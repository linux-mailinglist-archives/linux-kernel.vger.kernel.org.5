Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E023C7FBA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbjK1Mxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbjK1Mxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:53:41 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1518F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:53:47 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B1C853200C1C;
        Tue, 28 Nov 2023 07:53:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 28 Nov 2023 07:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1701176026; x=
        1701262426; bh=Vf7sqG7zSpFhtlDZ9epobQhhREhcl6KFlJdEMxbPQDY=; b=o
        poiZpnUqBexmw9vuM1eajksYqR8dO/T6xmsGqZg47dNZnjOzdT8J9wAlOurY7LY0
        sNw19vRBt5KUid3bX4xPHc+n1GPah1iggCPmXj6a73QNzsGo0LFAHPI9x5zPBiAY
        Vs29+nEQ9FT1bSQ58iX5d6NPE9NMAFutjYH2anQc66460CJ3iVh1VhEnOqZaGFiQ
        n2rciDKRGqMP6BtrIGGWLQtTZVG42rctErzgS3dj/4EjMn3+PexkfPljV39scLz1
        qdM5TznommptWJCNf7aOTae2eORgJkfWBEQ3GfdvxN8DzF1cTQqf0Lws7HmH8w2z
        ALe4D3xCMDjaPa6Tx0GWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1701176026; x=1701262426; bh=V
        f7sqG7zSpFhtlDZ9epobQhhREhcl6KFlJdEMxbPQDY=; b=gWNbFp3dTIPXo/IXG
        FHg4VPWJLqEQNDebnQ6MzgNkvObEl8ZQIrC8jpvcEseIBDW54E3m6aHMmLShtTPf
        wQ8/iMxOuBKlm8HdVRmRq6uKhdRuL1iOU+LOxipKEEhTZoI03uj6bn1pz6OODcIL
        AA0LMQnP/MONz2z6BSMK3lsMySLEf9VSv9Qt0467qQHfxAKFItW/NmY6Ye5az4r+
        V+aUlaqik/7r5yXV60eVzmggA+j3yKDA/DZi66HUmzihX6+CraIFlCEMCAPscPLB
        7OX3JWCnhW4J4WfJVoenJTpYgB+SHSS7J2To7qBq+iPqPvjZ7MU0qv+HgkMxersu
        u5jkw==
X-ME-Sender: <xms:2eJlZbyEYA1LLSBDWF0WJRAG9LInckMyCmixvFb6kY6d6y7VZIwYRQ>
    <xme:2eJlZTSInxbp1qb22nYoquvcKm4bt-lxQWX1uR4vF4efKc92XqBo68HzBk2cudBGz
    4mjDrhnCUdY6Me99vY>
X-ME-Received: <xmr:2eJlZVUOnJXz7o9J9J_7mePOb8qB5_epMw3uYkI9QXc06sjfL4vknNNDJfWb-5ndcBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfvvefhufgtgfesthejre
    dttddvjeenucfhrhhomhepofgrnhhjuhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghkrgdr
    mhgvqeenucggtffrrghtthgvrhhnpeeugefggfevgeejvedtffdvteelkefgieetieefge
    ejffdtvedtgeeufffgteeiheenucffohhmrghinhepthhruhgvrdhophgvnhdpghhithhh
    uhgsrdgtohhmpdhruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehmrghnjhhushgrkhgrrdhmvg
X-ME-Proxy: <xmx:2uJlZVjkkRnbEzDURgm_MtWj63RYV6LZ9LFX1AXcHkvbhiOaD6HolA>
    <xmx:2uJlZdANqQPsopJnbN96hPyxG1-_JBNDsrVeymWhGA07F-ElXwOH3w>
    <xmx:2uJlZeJdCg4l7WziZHpybkrg2aULICz2CeGv9nW6Qi9dlbOF1WVOnw>
    <xmx:2uJlZQrBmjtYgQIiYwnr7RoNHh4eS1ztB8B4JZHHe2RAYtmYw4dcng>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 07:53:44 -0500 (EST)
Message-ID: <30d0e4e5-d4f1-4fb5-8359-8752a77fce42@manjusaka.me>
Date:   Tue, 28 Nov 2023 20:53:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     ryncsn@gmail.com
From:   Manjusaka <me@manjusaka.me>
Subject: [BUG Report] The read syscall extremely slow on some type of the AMD
 CPU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone

We have some of the code(Python vs Rust) below 

```python
import pathlib
import timeit

root = pathlib.Path(__file__).parent
filename = "file"

def read_file_with_normal() -> bytes:
    with open("/tmp/demofile2", "rb") as fp:
        result = fp.read()
    return result

if __name__ == "__main__":
    read_file_with_normal()
```

```rust
use std::io::Read;
use std::fs::OpenOptions;

fn main() {
    // let bs = op.read("file").unwrap();
    let mut bs = vec![0; 1024 * 1024 * 64];
    let mut f = OpenOptions::new().read(true).open("/tmp/demofile2").unwrap();
    f.read_exact(&mut bs).unwrap();
    // let bs = std::fs::read("/tmp/test/file").unwrap();
    //assert_eq!(bs.len(), 64 * 1024 * 1024);
}
```

We find out the Rust Code on `read` syscall is slower than Python syscall. we use the eBPF to measure the read operation time on "/tmp/demofile2"

```python
from bcc import BPF
import time
import argparse

bpf_text = """
#include <uapi/linux/ptrace.h>
#include <linux/fs.h>
#include <linux/sched.h>

BPF_HASH(fd_info, pid_t, int);
BPF_HASH(action_info, pid_t, u64);

struct event_data_t {
    u32 pid;
    u64 delta_ts;
};


BPF_RINGBUF_OUTPUT(events, 65536);

static __always_inline int matchPrefix(const char *cs, const char *ct, int size) {
    int len = 0;
    unsigned char c1, c2;
    for (len=0;len<(size & 0xff);len++) {
        c1 = *cs++;
        c2 = *ct++;
        if (c1 != c2) return c1 < c2 ? -1 : 1;
        if (!c1) break;
     }
     return 0;
}

TRACEPOINT_PROBE(syscalls, sys_enter_openat) {
    u32 pid = bpf_get_current_pid_tgid() >> 32;
    u32 tid = bpf_get_current_pid_tgid();
    char *filename = args->filename;
    if (matchPrefix(filename, "/tmp/demofile2", sizeof(filename)) != 0) {
        return 0;
    }
    int fd=0;
    fd_info.update(&tid, &fd);

    return 0;
}

TRACEPOINT_PROBE(syscalls, sys_exit_openat) {
    u32 pid = bpf_get_current_pid_tgid() >> 32;
    u32 tid = bpf_get_current_pid_tgid();
    int *dfd = fd_info.lookup(&tid);
    if (dfd == NULL) {
        return 0;
    }
    int fd = args->ret;
    fd_info.update(&tid, &fd);
    return 0;
}


TRACEPOINT_PROBE(syscalls, sys_enter_open) {
    u32 pid = bpf_get_current_pid_tgid() >> 32;
    u32 tid = bpf_get_current_pid_tgid();
    char *filename = args->filename;
    if (matchPrefix(filename, "/tmp/demofile2", sizeof(filename)) != 0) {
        return 0;
    }
    int fd=0;
    fd_info.update(&tid, &fd);

    return 0;
}

TRACEPOINT_PROBE(syscalls, sys_exit_open) {
    u32 pid = bpf_get_current_pid_tgid() >> 32;
    u32 tid = bpf_get_current_pid_tgid();
    int *dfd = fd_info.lookup(&tid);
    if (dfd == NULL) {
        return 0;
    }
    int fd = args->ret;
    fd_info.update(&tid, &fd);
    return 0;
}

TRACEPOINT_PROBE(syscalls, sys_enter_read) {
    u32 pid = bpf_get_current_pid_tgid() >> 32;
    u32 tid = bpf_get_current_pid_tgid();
    int *dfd = fd_info.lookup(&tid);
    if (dfd == NULL) {
        return 0;
    }

    if (*dfd != args->fd) {
        return 0;
    }
    u64 ts = bpf_ktime_get_ns();
    action_info.update(&tid, &ts);

    return 0;
}

TRACEPOINT_PROBE(syscalls, sys_exit_read) {
    u32 pid = bpf_get_current_pid_tgid() >> 32;
    u32 tid = bpf_get_current_pid_tgid();
    u64 *ts = action_info.lookup(&tid);
    if (ts == NULL) {
        return 0;
    }
    action_info.delete(&tid);
    struct event_data_t *event_data = events.ringbuf_reserve(sizeof(struct event_data_t));
    if (!event_data) {
        return 0;
    }
    event_data->pid = pid;
    event_data->delta_ts = bpf_ktime_get_ns() - *ts;
    events.ringbuf_submit(event_data, sizeof(event_data));
    return 0;
}
"""

bpf = BPF(text=bpf_text)


def process_event_data(cpu, data, size):
    event = bpf["events"].event(data)
    print(f"Process {event.pid} read file {event.delta_ts} ns")


bpf["events"].open_ring_buffer(process_event_data)

while True:
    try:
        bpf.ring_buffer_consume()
    except KeyboardInterrupt:
        exit()
```

The data shows that the Rust code for the read operation time on "/tmp/demofile2" time is almost double times for the Python version.

```text
Process 88010 read file 11094021 ns
Process 92652 read file 29149375 ns
```

We change the Rust code to `C` code 

```c
#include <stdio.h>
#include <stdlib.h>

#define FILE_SIZE 64 * 1024 * 1024  // 64 MiB

int main() {
    FILE *file;
    char *buffer;
    size_t result;

    file = fopen("/tmp/file", "rb");
    if (file == NULL) {
        fputs("Error opening file", stderr);
        return 1;
    }

    buffer = (char *)malloc(sizeof(char) * FILE_SIZE);
    if (buffer == NULL) {
        fputs("Memory error", stderr);
        fclose(file);
        return 2;
    }

    result = fread(buffer, 1, FILE_SIZE, file);
    if (result != FILE_SIZE) {
        fputs("Reading error", stderr);
        fclose(file);
        free(buffer);
        return 3;
    }

    fclose(file);
    free(buffer);

    return 0;
}
```

The results is the same.

And we find a interested issue. We change buffer variable's offset in C

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#define FILE_SIZE 64 * 1024 * 1024  // 64 MiB

int main() {
    int file;
    char *buffer;
    size_t result;

    file = open("/tmp/file", O_RDONLY);
    if (file == NULL) {
        fputs("Error opening file", stderr);
        return 1;
    }

    buffer = (char *)malloc(sizeof(char) * FILE_SIZE);
    if (buffer == NULL) {
        fputs("Memory error", stderr);
        close(file);
        return 2;
    }

    result = read(file, buffer + 0x20, FILE_SIZE);
    if (result != FILE_SIZE) {
        fputs("Reading error", stderr);
        close(file);
        free(buffer);
        return 3;
    }

    close(file);
    free(buffer);

    return 0;
}
```

The result becomes normal. The behavior is same with we change malloc to aligned_alloc.

And we found that the result is normal when the offset is in range [page*4k-0x10,page*4k+0x10], otherwise the result is slow.

This issue can be produced on AMD Ryzen 9 5950X, AMD R7 5700X, AMD Ryzen 9 5900X

Here's some reference for this issue which is reported in the community

1. https://github.com/apache/incubator-opendal/issues/3665
2. https://users.rust-lang.org/t/std-read-slow/85424/13
