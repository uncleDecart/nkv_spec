# SPDX-License-Identifier: Apache-2.0

# This file contains common messages which are
# used between NkvClient and Server in Cap'n Proto format.
# for more info checkout github.com/uncleDecart/nkv

using Go = import "/go.capnp";
@0xad055e760f5b08be;
$Go.package("nkv_spec");
$Go.import("uncleDecart/nkv_spec");

struct BaseMessage {
    id @0 :Text;
    key @1 :Text;
    clientUuid @2 :Text;
}

struct PutMessage {
    base @0 :BaseMessage;
    value @1 :Data;
}

struct ServerRequest {
    union {
        put @0 :PutMessage;
        get @1 :BaseMessage;
        delete @2 :BaseMessage;
        subscribe @3 :BaseMessage;
        unsubscribe @4 :BaseMessage;
    }
}

struct BaseResp {
    id @0 :Text;
    status @1 :UInt16;  # StatusCode as an integer representation (HTTP Status codes are numeric)
    message @2 :Text;
}

struct DataResp {
    base @0 :BaseResp;
    data @1 :List(Data);
}

struct ServerResponse {
    union {
        base @0 :BaseResp;
        get @1 :DataResp;
        put @2 :DataResp;
        sub @3 :DataResp;
    }
}

