Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2BD7F6381
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjKWQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjKWQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:03:20 -0500
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAECBA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:03:23 -0800 (PST)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-6c415e09b1bso1357579b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755403; x=1701360203;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2a8tFJiYj/47Zq0ZKTfsTZKESgVvhjegY91OHA3Qhxk=;
        b=ouaEr292aM5E/BUOSnRLdezBl1jEYMzMpT6TMzR8QMyOIxLceTFW7FKg2Nfe1qYEO5
         /Rbga7KQXk7AIc0kIOTKfbJlgHtnmL2c/WYMoe3UcKyPK75SQ/Y9nMmyRLPPiyc48oWs
         5DQvJcNDgwyYSxKbHabJr1DlvhOL8VPS5vn50+QcGrHzjxntMgMXCeoXJI1oCbJ12JKh
         BRlIkvtqo46LXbEtaxKu3d5QgDN/qdwaAv8Vvljgyn5keSu96+zxLKD6T7qLgvWfimJd
         dW/eUComAxn9IC4vRMCd2G4IHYK8WPX6JHDTiWI8lXtNu3vVmsqa1MB3p0KWhpNmSuFH
         vm+g==
X-Gm-Message-State: AOJu0Yy6PzO9xg2EnCc1IDw1WgjAVdoOcLoQTTtJi58bP+//jP9iWg+F
        g4cog7X/qnYF8ejit+VGCppW1dmAJR3q1ePfWf6GVVmnPZPt9OEZyg==
X-Google-Smtp-Source: AGHT+IEVNiAWro6wAQYBfMb9aS54ARzyUSbCrbKCwN3aXzydPJU/x19NLRAvN+EzPdPhM2Fg3gYmlgOClg5IUUv2ZUpIGIppRByj
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:80e8:b0:6cb:7fb1:84d with SMTP id
 ei40-20020a056a0080e800b006cb7fb1084dmr1188522pfb.6.1700755403405; Thu, 23
 Nov 2023 08:03:23 -0800 (PST)
Date:   Thu, 23 Nov 2023 08:03:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab8015060ad3f9bc@google.com>
Subject: [syzbot] go runtime error
From:   syzbot <syzbot+b8bbc03ee7bf80fc9f78@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9b6de136b5f0 Merge tag 'loongarch-fixes-6.7-1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123e51cce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd
dashboard link: https://syzkaller.appspot.com/bug?extid=b8bbc03ee7bf80fc9f78
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0b18037dc96/disk-9b6de136.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0700a526b76e/vmlinux-9b6de136.xz
kernel image: https://storage.googleapis.com/syzbot-assets/395f90da0cd9/bzImage-9b6de136.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8bbc03ee7bf80fc9f78@syzkaller.appspotmail.com

runtime: bad span s.state=0 s.sweepgen=32678 sweepgen=242
fatal error: non in-use span in unswept list

goroutine 3 [running]:
runtime.throw({0xafea36?, 0x7fa6ac2a6b00?})
	/usr/local/go/src/runtime/panic.go:1047 +0x5d fp=0xc000055730 sp=0xc000055700 pc=0x4363dd
runtime.sweepone()
	/usr/local/go/src/runtime/mgcsweep.go:384 +0x256 fp=0xc000055780 sp=0xc000055730 pc=0x4245d6
runtime.bgsweep(0x0?)
	/usr/local/go/src/runtime/mgcsweep.go:299 +0xff fp=0xc0000557c8 sp=0xc000055780 pc=0x42425f
runtime.gcenable.func1()
	/usr/local/go/src/runtime/mgc.go:178 +0x26 fp=0xc0000557e0 sp=0xc0000557c8 pc=0x419406
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc0000557e8 sp=0xc0000557e0 pc=0x469781
created by runtime.gcenable
	/usr/local/go/src/runtime/mgc.go:178 +0x6b

goroutine 1 [select]:
runtime.gopark(0xc01e9afa00?, 0x2?, 0x20?, 0xf9?, 0xc01e9af9bc?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc01e9af7f0 sp=0xc01e9af7d0 pc=0x4390f6
runtime.selectgo(0xc01e9afa00, 0xc01e9af9b8, 0xc025372570?, 0x0, 0x0?, 0x1)
	/usr/local/go/src/runtime/select.go:327 +0x7be fp=0xc01e9af930 sp=0xc01e9af7f0 pc=0x4491fe
main.(*Fuzzer).pollLoop(0xc000222600)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:385 +0x105 fp=0xc01e9afa30 sp=0xc01e9af930 pc=0x90d4c5
main.main()
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:313 +0x176c fp=0xc01e9aff80 sp=0xc01e9afa30 pc=0x90cb4c
runtime.main()
	/usr/local/go/src/runtime/proc.go:250 +0x207 fp=0xc01e9affe0 sp=0xc01e9aff80 pc=0x438cc7
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc01e9affe8 sp=0xc01e9affe0 pc=0x469781

goroutine 2 [force gc (idle), 3 minutes]:
runtime.gopark(0x0?, 0x0?, 0x0?, 0x0?, 0x0?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000054fb0 sp=0xc000054f90 pc=0x4390f6
runtime.goparkunlock(...)
	/usr/local/go/src/runtime/proc.go:387
runtime.forcegchelper()
	/usr/local/go/src/runtime/proc.go:305 +0xb0 fp=0xc000054fe0 sp=0xc000054fb0 pc=0x438f30
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000054fe8 sp=0xc000054fe0 pc=0x469781
created by runtime.init.6
	/usr/local/go/src/runtime/proc.go:293 +0x25

goroutine 4 [GC scavenge wait]:
runtime.gopark(0x35e32c62a8?, 0x5b459955a?, 0x0?, 0x0?, 0x0?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000055f70 sp=0xc000055f50 pc=0x4390f6
runtime.goparkunlock(...)
	/usr/local/go/src/runtime/proc.go:387
runtime.(*scavengerState).park(0x1f3afe0)
	/usr/local/go/src/runtime/mgcscavenge.go:400 +0x53 fp=0xc000055fa0 sp=0xc000055f70 pc=0x422133
runtime.bgscavenge(0x0?)
	/usr/local/go/src/runtime/mgcscavenge.go:633 +0x65 fp=0xc000055fc8 sp=0xc000055fa0 pc=0x422725
runtime.gcenable.func2()
	/usr/local/go/src/runtime/mgc.go:179 +0x26 fp=0xc000055fe0 sp=0xc000055fc8 pc=0x4193a6
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000055fe8 sp=0xc000055fe0 pc=0x469781
created by runtime.gcenable
	/usr/local/go/src/runtime/mgc.go:179 +0xaa

goroutine 17 [finalizer wait]:
runtime.gopark(0x0?, 0xc1dfd0?, 0x40?, 0xc6?, 0x2000000020?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000054628 sp=0xc000054608 pc=0x4390f6
runtime.runfinq()
	/usr/local/go/src/runtime/mfinal.go:193 +0x107 fp=0xc0000547e0 sp=0xc000054628 pc=0x418447
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc0000547e8 sp=0xc0000547e0 pc=0x469781
created by runtime.createfing
	/usr/local/go/src/runtime/mfinal.go:163 +0x45

goroutine 18 [select]:
runtime.gopark(0xc000050788?, 0x3?, 0x90?, 0x0?, 0xc000050772?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc0000505f8 sp=0xc0000505d8 pc=0x4390f6
runtime.selectgo(0xc000050788, 0xc00005076c, 0xc0000edc00?, 0x0, 0x0?, 0x1)
	/usr/local/go/src/runtime/select.go:327 +0x7be fp=0xc000050738 sp=0xc0000505f8 pc=0x4491fe
go.opencensus.io/stats/view.(*worker).start(0xc0000edc00)
	/syzkaller/gopath/src/github.com/google/syzkaller/vendor/go.opencensus.io/stats/view/worker.go:292 +0xad fp=0xc0000507c8 sp=0xc000050738 pc=0x8ceaad
go.opencensus.io/stats/view.init.0.func1()
	/syzkaller/gopath/src/github.com/google/syzkaller/vendor/go.opencensus.io/stats/view/worker.go:34 +0x26 fp=0xc0000507e0 sp=0xc0000507c8 pc=0x8cdce6
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc0000507e8 sp=0xc0000507e0 pc=0x469781
created by go.opencensus.io/stats/view.init.0
	/syzkaller/gopath/src/github.com/google/syzkaller/vendor/go.opencensus.io/stats/view/worker.go:34 +0x96

goroutine 19 [GC worker (idle)]:
runtime.gopark(0x3c2f3aed6b?, 0x2?, 0xa6?, 0xd0?, 0x0?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000050f50 sp=0xc000050f30 pc=0x4390f6
runtime.gcBgMarkWorker()
	/usr/local/go/src/runtime/mgc.go:1275 +0xf1 fp=0xc000050fe0 sp=0xc000050f50 pc=0x41b171
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000050fe8 sp=0xc000050fe0 pc=0x469781
created by runtime.gcBgMarkStartWorkers
	/usr/local/go/src/runtime/mgc.go:1199 +0x25

goroutine 5 [GC worker (idle)]:
runtime.gopark(0xc1e1c8?, 0xc00003c040?, 0x1a?, 0x14?, 0x0?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000056750 sp=0xc000056730 pc=0x4390f6
runtime.gcBgMarkWorker()
	/usr/local/go/src/runtime/mgc.go:1275 +0xf1 fp=0xc0000567e0 sp=0xc000056750 pc=0x41b171
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc0000567e8 sp=0xc0000567e0 pc=0x469781
created by runtime.gcBgMarkStartWorkers
	/usr/local/go/src/runtime/mgc.go:1199 +0x25

goroutine 20 [chan receive, 3 minutes]:
runtime.gopark(0xc000057688?, 0xc0000576e0?, 0xb3?, 0xc4?, 0xc0000576e0?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc0000576b0 sp=0xc000057690 pc=0x4390f6
runtime.chanrecv(0xc00009e1e0, 0x0, 0x1)
	/usr/local/go/src/runtime/chan.go:583 +0x49d fp=0xc000057740 sp=0xc0000576b0 pc=0x406f5d
runtime.chanrecv1(0xc00009e1e0?, 0xc0000577b0?)
	/usr/local/go/src/runtime/chan.go:442 +0x18 fp=0xc000057768 sp=0xc000057740 pc=0x406a98
github.com/google/syzkaller/pkg/osutil.HandleInterrupts.func1()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/osutil/osutil_unix.go:78 +0x8a fp=0xc0000577e0 sp=0xc000057768 pc=0x52ddaa
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc0000577e8 sp=0xc0000577e0 pc=0x469781
created by github.com/google/syzkaller/pkg/osutil.HandleInterrupts
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/osutil/osutil_unix.go:75 +0x56

goroutine 21 [chan receive, 3 minutes]:
runtime.gopark(0x0?, 0x0?, 0x0?, 0x0?, 0x0?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000057ee8 sp=0xc000057ec8 pc=0x4390f6
runtime.chanrecv(0xc0000820c0, 0x0, 0x1)
	/usr/local/go/src/runtime/chan.go:583 +0x49d fp=0xc000057f78 sp=0xc000057ee8 pc=0x406f5d
runtime.chanrecv1(0x0?, 0x0?)
	/usr/local/go/src/runtime/chan.go:442 +0x18 fp=0xc000057fa0 sp=0xc000057f78 pc=0x406a98
main.main.func1()
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:182 +0x1f fp=0xc000057fe0 sp=0xc000057fa0 pc=0x90cc1f
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000057fe8 sp=0xc000057fe0 pc=0x469781
created by main.main
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:180 +0x48f

goroutine 6 [select, 3 minutes, locked to thread]:
runtime.gopark(0xc000b4cfa8?, 0x2?, 0x72?, 0x94?, 0xc000b4cfa4?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000b4ce18 sp=0xc000b4cdf8 pc=0x4390f6
runtime.selectgo(0xc000b4cfa8, 0xc000b4cfa0, 0x0?, 0x0, 0x0?, 0x1)
	/usr/local/go/src/runtime/select.go:327 +0x7be fp=0xc000b4cf58 sp=0xc000b4ce18 pc=0x4491fe
runtime.ensureSigM.func1()
	/usr/local/go/src/runtime/signal_unix.go:1000 +0x1af fp=0xc000b4cfe0 sp=0xc000b4cf58 pc=0x46138f
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4cfe8 sp=0xc000b4cfe0 pc=0x469781
created by runtime.ensureSigM
	/usr/local/go/src/runtime/signal_unix.go:983 +0xbd

goroutine 7 [syscall, 3 minutes]:
runtime.notetsleepg(0x0?, 0x0?)
	/usr/local/go/src/runtime/lock_futex.go:236 +0x34 fp=0xc000b4d7a0 sp=0xc000b4d768 pc=0x40c554
os/signal.signal_recv()
	/usr/local/go/src/runtime/sigqueue.go:152 +0x2f fp=0xc000b4d7c0 sp=0xc000b4d7a0 pc=0x465d4f
os/signal.loop()
	/usr/local/go/src/os/signal/signal_unix.go:23 +0x19 fp=0xc000b4d7e0 sp=0xc000b4d7c0 pc=0x52c8b9
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4d7e8 sp=0xc000b4d7e0 pc=0x469781
created by os/signal.Notify.func1.1
	/usr/local/go/src/os/signal/signal.go:151 +0x2a

goroutine 23 [IO wait]:
runtime.gopark(0x1?, 0xb?, 0x0?, 0x0?, 0x3?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc01e9b1958 sp=0xc01e9b1938 pc=0x4390f6
runtime.netpollblock(0x4bc5a5?, 0x40482f?, 0x0?)
	/usr/local/go/src/runtime/netpoll.go:527 +0xf7 fp=0xc01e9b1990 sp=0xc01e9b1958 pc=0x431a57
internal/poll.runtime_pollWait(0x7fa6ad0efc28, 0x72)
	/usr/local/go/src/runtime/netpoll.go:306 +0x89 fp=0xc01e9b19b0 sp=0xc01e9b1990 pc=0x463b49
internal/poll.(*pollDesc).wait(0xc00078f880?, 0xc0007e3000?, 0x0)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:84 +0x32 fp=0xc01e9b19d8 sp=0xc01e9b19b0 pc=0x4d7a72
internal/poll.(*pollDesc).waitRead(...)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:89
internal/poll.(*FD).Read(0xc00078f880, {0xc0007e3000, 0x1000, 0x1000})
	/usr/local/go/src/internal/poll/fd_unix.go:167 +0x299 fp=0xc01e9b1a70 sp=0xc01e9b19d8 pc=0x4d8e59
net.(*netFD).Read(0xc00078f880, {0xc0007e3000?, 0x95ebe0?, 0xc0250e9848?})
	/usr/local/go/src/net/fd_posix.go:55 +0x29 fp=0xc01e9b1ab8 sp=0xc01e9b1a70 pc=0x65d9e9
net.(*conn).Read(0xc000c5b7c0, {0xc0007e3000?, 0x198?, 0x4b25fa?})
	/usr/local/go/src/net/net.go:183 +0x45 fp=0xc01e9b1b00 sp=0xc01e9b1ab8 pc=0x66f525
net.(*TCPConn).Read(0xc000b68120?, {0xc0007e3000?, 0x9e2660?, 0xc0250e9830?})
	<autogenerated>:1 +0x29 fp=0xc01e9b1b30 sp=0xc01e9b1b00 pc=0x67f789
bufio.(*Reader).fill(0xc000077da0)
	/usr/local/go/src/bufio/bufio.go:106 +0xff fp=0xc01e9b1b68 sp=0xc01e9b1b30 pc=0x50c7ff
bufio.(*Reader).ReadByte(0xc000077da0)
	/usr/local/go/src/bufio/bufio.go:265 +0x2c fp=0xc01e9b1b88 sp=0xc01e9b1b68 pc=0x50cfcc
compress/flate.(*decompressor).moreBits(0xc0008a8000)
	/usr/local/go/src/compress/flate/inflate.go:696 +0x2d fp=0xc01e9b1bc0 sp=0xc01e9b1b88 pc=0x51888d
compress/flate.(*decompressor).nextBlock(0xc0008a8000)
	/usr/local/go/src/compress/flate/inflate.go:303 +0x2e fp=0xc01e9b1bd8 sp=0xc01e9b1bc0 pc=0x516c4e
compress/flate.(*decompressor).Read(0xc0008a8000, {0xc0007fb000, 0x1000, 0xc01e9b1c80?})
	/usr/local/go/src/compress/flate/inflate.go:347 +0x7e fp=0xc01e9b1c10 sp=0xc01e9b1bd8 pc=0x516ebe
github.com/google/syzkaller/pkg/rpctype.(*flateConn).Read(0xc000b68100?, {0xc0007fb000?, 0x9eda40?, 0xc0250e9800?})
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/rpctype/rpc.go:136 +0x26 fp=0xc01e9b1c40 sp=0xc01e9b1c10 pc=0x909126
bufio.(*Reader).Read(0xc000077e00, {0xc0007b10d0, 0x1, 0xc01e9b1d70?})
	/usr/local/go/src/bufio/bufio.go:237 +0x1bb fp=0xc01e9b1c78 sp=0xc01e9b1c40 pc=0x50cddb
io.ReadAtLeast({0xcd8a20, 0xc000077e00}, {0xc0007b10d0, 0x1, 0x9}, 0x1)
	/usr/local/go/src/io/io.go:332 +0x9a fp=0xc01e9b1cc0 sp=0xc01e9b1c78 pc=0x4b25fa
io.ReadFull(...)
	/usr/local/go/src/io/io.go:351
encoding/gob.decodeUintReader({0xcd8a20?, 0xc000077e00?}, {0xc0007b10d0?, 0x9?, 0x9?})
	/usr/local/go/src/encoding/gob/decode.go:116 +0x57 fp=0xc01e9b1d18 sp=0xc01e9b1cc0 pc=0x89bfd7
encoding/gob.(*Decoder).recvMessage(0xc00078f900)
	/usr/local/go/src/encoding/gob/decoder.go:82 +0x39 fp=0xc01e9b1d50 sp=0xc01e9b1d18 pc=0x8a5b99
encoding/gob.(*Decoder).decodeTypeSequence(0xc00078f900, 0x0)
	/usr/local/go/src/encoding/gob/decoder.go:148 +0x4f fp=0xc01e9b1d80 sp=0xc01e9b1d50 pc=0x8a5f2f
encoding/gob.(*Decoder).DecodeValue(0xc00078f900, {0x957940?, 0xc000480990?, 0x7fa6d44a2a48?})
	/usr/local/go/src/encoding/gob/decoder.go:227 +0x18f fp=0xc01e9b1e00 sp=0xc01e9b1d80 pc=0x8a63cf
encoding/gob.(*Decoder).Decode(0xc00078f900, {0x957940?, 0xc000480990?})
	/usr/local/go/src/encoding/gob/decoder.go:204 +0x165 fp=0xc01e9b1e58 sp=0xc01e9b1e00 pc=0x8a61e5
net/rpc.(*gobClientCodec).ReadResponseHeader(0xa13280?, 0xc000480990?)
	/usr/local/go/src/net/rpc/client.go:228 +0x27 fp=0xc01e9b1e80 sp=0xc01e9b1e58 pc=0x8bbce7
net/rpc.(*Client).input(0xc000077ec0)
	/usr/local/go/src/net/rpc/client.go:109 +0xb4 fp=0xc01e9b1fc8 sp=0xc01e9b1e80 pc=0x8baf74
net/rpc.NewClientWithCodec.func1()
	/usr/local/go/src/net/rpc/client.go:206 +0x26 fp=0xc01e9b1fe0 sp=0xc01e9b1fc8 pc=0x8bbba6
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc01e9b1fe8 sp=0xc01e9b1fe0 pc=0x469781
created by net/rpc.NewClientWithCodec
	/usr/local/go/src/net/rpc/client.go:206 +0xc5

goroutine 10 [IO wait, 1 minutes]:
runtime.gopark(0x0?, 0xb?, 0x0?, 0x0?, 0xf?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000b4fde8 sp=0xc000b4fdc8 pc=0x4390f6
runtime.netpollblock(0x4bc5a5?, 0x40482f?, 0x0?)
	/usr/local/go/src/runtime/netpoll.go:527 +0xf7 fp=0xc000b4fe20 sp=0xc000b4fde8 pc=0x431a57
internal/poll.runtime_pollWait(0x7fa6ad0efb38, 0x72)
	/usr/local/go/src/runtime/netpoll.go:306 +0x89 fp=0xc000b4fe40 sp=0xc000b4fe20 pc=0x463b49
internal/poll.(*pollDesc).wait(0xc000650060?, 0xc027394000?, 0x1)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:84 +0x32 fp=0xc000b4fe68 sp=0xc000b4fe40 pc=0x4d7a72
internal/poll.(*pollDesc).waitRead(...)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:89
internal/poll.(*FD).Read(0xc000650060, {0xc027394000, 0x20000, 0x20000})
	/usr/local/go/src/internal/poll/fd_unix.go:167 +0x299 fp=0xc000b4ff00 sp=0xc000b4fe68 pc=0x4d8e59
os.(*File).read(...)
	/usr/local/go/src/os/file_posix.go:31
os.(*File).Read(0xc01c258480, {0xc027394000?, 0xc000804180?, 0xc000804120?})
	/usr/local/go/src/os/file.go:118 +0x5e fp=0xc000b4ff58 sp=0xc000b4ff00 pc=0x4e42be
github.com/google/syzkaller/pkg/ipc.makeCommand.func2(0xc0002bf030)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:629 +0x8a fp=0xc000b4ffc8 sp=0xc000b4ff58 pc=0x906e0a
github.com/google/syzkaller/pkg/ipc.makeCommand.func7()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:644 +0x2a fp=0xc000b4ffe0 sp=0xc000b4ffc8 pc=0x906d4a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4ffe8 sp=0xc000b4ffe0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:623 +0xa7b

goroutine 24 [sync.Cond.Wait]:
runtime.gopark(0xc024644600?, 0x4ec65e?, 0x0?, 0x0?, 0xc00055417b?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc001f83b50 sp=0xc001f83b30 pc=0x4390f6
runtime.goparkunlock(...)
	/usr/local/go/src/runtime/proc.go:387
sync.runtime_notifyListWait(0xc000b66a10, 0x5f)
	/usr/local/go/src/runtime/sema.go:527 +0x14c fp=0xc001f83b98 sp=0xc001f83b50 pc=0x4658ec
sync.(*Cond).Wait(0xaa36db?)
	/usr/local/go/src/sync/cond.go:70 +0x8c fp=0xc001f83bd0 sp=0xc001f83b98 pc=0x4824cc
github.com/google/syzkaller/pkg/ipc.(*Gate).Enter(0xc000b66a40)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/gate.go:34 +0x3f fp=0xc001f83bf8 sp=0xc001f83bd0 pc=0x902c3f
main.(*Proc).executeRaw(0xc01ca70080, 0x0?, 0x1e8?, 0x1)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:322 +0x88 fp=0xc001f83d10 sp=0xc001f83bf8 pc=0x912e08
main.(*Proc).execute(0xc01ca70080, 0xb?, 0xc?, 0xc001f83f38?, 0x1?)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:255 +0x49 fp=0xc001f83e50 sp=0xc001f83d10 pc=0x9126a9
main.(*Proc).executeAndCollide(0xc01ca70080, 0xa849df?, 0xc01e554b70?, 0xc001f83f38?, 0xc01ca70000?)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:284 +0x27 fp=0xc001f83e98 sp=0xc001f83e50 pc=0x912ba7
main.(*Proc).loop(0xc01ca70080)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:97 +0x3d7 fp=0xc001f83fc8 sp=0xc001f83e98 pc=0x910bb7
main.main.func2()
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x26 fp=0xc001f83fe0 sp=0xc001f83fc8 pc=0x90cbc6
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc001f83fe8 sp=0xc001f83fe0 pc=0x469781
created by main.main
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x15e5

goroutine 25 [sync.Cond.Wait]:
runtime.gopark(0xc0250c9a90?, 0x4ec65e?, 0x78?, 0xfb?, 0xc00055417b?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc001f7fb50 sp=0xc001f7fb30 pc=0x4390f6
runtime.goparkunlock(...)
	/usr/local/go/src/runtime/proc.go:387
sync.runtime_notifyListWait(0xc000b66a10, 0x5d)
	/usr/local/go/src/runtime/sema.go:527 +0x14c fp=0xc001f7fb98 sp=0xc001f7fb50 pc=0x4658ec
sync.(*Cond).Wait(0xaa36db?)
	/usr/local/go/src/sync/cond.go:70 +0x8c fp=0xc001f7fbd0 sp=0xc001f7fb98 pc=0x4824cc
github.com/google/syzkaller/pkg/ipc.(*Gate).Enter(0xc000b66a40)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/gate.go:34 +0x3f fp=0xc001f7fbf8 sp=0xc001f7fbd0 pc=0x902c3f
main.(*Proc).executeRaw(0xc01ca70100, 0x0?, 0x174?, 0x1)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:322 +0x88 fp=0xc001f7fd10 sp=0xc001f7fbf8 pc=0x912e08
main.(*Proc).execute(0xc01ca70100, 0xb?, 0xc?, 0xc001f7ff38?, 0x1?)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:255 +0x49 fp=0xc001f7fe50 sp=0xc001f7fd10 pc=0x9126a9
main.(*Proc).executeAndCollide(0xc01ca70100, 0xa849df?, 0xc01e554ba0?, 0xc001f7ff38?, 0xc01ca70000?)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:284 +0x27 fp=0xc001f7fe98 sp=0xc001f7fe50 pc=0x912ba7
main.(*Proc).loop(0xc01ca70100)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:97 +0x3d7 fp=0xc001f7ffc8 sp=0xc001f7fe98 pc=0x910bb7
main.main.func2()
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x26 fp=0xc001f7ffe0 sp=0xc001f7ffc8 pc=0x90cbc6
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc001f7ffe8 sp=0xc001f7ffe0 pc=0x469781
created by main.main
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x15e5

goroutine 26 [IO wait]:
runtime.gopark(0x540ee0?, 0xb?, 0x0?, 0x0?, 0x25?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc001f817a8 sp=0xc001f81788 pc=0x4390f6
runtime.netpollblock(0x4bc5a5?, 0x40482f?, 0x0?)
	/usr/local/go/src/runtime/netpoll.go:527 +0xf7 fp=0xc001f817e0 sp=0xc001f817a8 pc=0x431a57
internal/poll.runtime_pollWait(0x7fa6ac154570, 0x72)
	/usr/local/go/src/runtime/netpoll.go:306 +0x89 fp=0xc001f81800 sp=0xc001f817e0 pc=0x463b49
internal/poll.(*pollDesc).wait(0xc0006507e0?, 0xc01ed369f0?, 0x1)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:84 +0x32 fp=0xc001f81828 sp=0xc001f81800 pc=0x4d7a72
internal/poll.(*pollDesc).waitRead(...)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:89
internal/poll.(*FD).Read(0xc0006507e0, {0xc01ed369f0, 0xc, 0xc})
	/usr/local/go/src/internal/poll/fd_unix.go:167 +0x299 fp=0xc001f818c0 sp=0xc001f81828 pc=0x4d8e59
os.(*File).read(...)
	/usr/local/go/src/os/file_posix.go:31
os.(*File).Read(0xc01c2584f0, {0xc01ed369f0?, 0xc001f81950?, 0x40de47?})
	/usr/local/go/src/os/file.go:118 +0x5e fp=0xc001f81918 sp=0xc001f818c0 pc=0x4e42be
io.ReadAtLeast({0xcdbc00, 0xc01c2584f0}, {0xc01ed369f0, 0xc, 0xc}, 0xc)
	/usr/local/go/src/io/io.go:332 +0x9a fp=0xc001f81960 sp=0xc001f81918 pc=0x4b25fa
io.ReadFull(...)
	/usr/local/go/src/io/io.go:351
github.com/google/syzkaller/pkg/ipc.(*command).exec(0xc0002bf0a0, 0x7fa6a924c000?, {0x0, 0x0, 0x0})
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:786 +0x559 fp=0xc001f81b18 sp=0xc001f81960 pc=0x907d19
github.com/google/syzkaller/pkg/ipc.(*Env).Exec(0xc000218750, 0xc01ecc2801?, 0xc01ecc6140)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:286 +0x24e fp=0xc001f81bf8 sp=0xc001f81b18 pc=0x903d4e
main.(*Proc).executeRaw(0xc01ca701c0, 0x484b7e?, 0xc01ed366a0?, 0x1)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:328 +0x1bc fp=0xc001f81d10 sp=0xc001f81bf8 pc=0x912f3c
main.(*Proc).execute(0xc01ca701c0, 0xb?, 0xc?, 0xc001f81f38?, 0x1?)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:255 +0x49 fp=0xc001f81e50 sp=0xc001f81d10 pc=0x9126a9
main.(*Proc).executeAndCollide(0xc01ca701c0, 0xa849df?, 0xc01e554bd0?, 0xc001f81f38?, 0xc01ca70000?)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:284 +0x27 fp=0xc001f81e98 sp=0xc001f81e50 pc=0x912ba7
main.(*Proc).loop(0xc01ca701c0)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:97 +0x3d7 fp=0xc001f81fc8 sp=0xc001f81e98 pc=0x910bb7
main.main.func2()
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x26 fp=0xc001f81fe0 sp=0xc001f81fc8 pc=0x90cbc6
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc001f81fe8 sp=0xc001f81fe0 pc=0x469781
created by main.main
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x15e5

goroutine 27 [runnable]:
runtime.mapaccess1_fast64(0x999340, 0xc001b1d120, 0xc002f5ff80)
	/usr/local/go/src/runtime/map_fast64.go:13 +0x17f fp=0xc001b1cf98 sp=0xc001b1cf90 pc=0x411e1f
github.com/google/syzkaller/prog.clone({0xcdf5c0?, 0xc0030ee0c0?}, 0xc001b1d120)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/clone.go:81 +0x49b fp=0xc001b1d050 sp=0xc001b1cf98 pc=0x5474bb
github.com/google/syzkaller/prog.cloneCall(0xc0023bf7c0, 0xa1fd60?)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/clone.go:36 +0x15a fp=0xc001b1d0a0 sp=0xc001b1d050 pc=0x546f7a
github.com/google/syzkaller/prog.cloneCalls({0xc00305cb00, 0x8, 0x0?}, 0x0?)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/clone.go:23 +0x67 fp=0xc001b1d0e0 sp=0xc001b1d0a0 pc=0x546da7
github.com/google/syzkaller/prog.(*Prog).Clone(0xc00305c940)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/clone.go:14 +0x96 fp=0xc001b1d1f0 sp=0xc001b1d0e0 pc=0x546c76
github.com/google/syzkaller/prog.(*randGen).resourceCentric(0xc02772afe0, 0xc011eec7d0, 0x11ca8e0, 0x0?)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:917 +0xb0 fp=0xc001b1d340 sp=0xc001b1d1f0 pc=0x56a990
github.com/google/syzkaller/prog.(*ResourceType).generate(0x11ca8e0, 0xc02772afe0, 0x94f640?, 0xc0?)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:732 +0xd4 fp=0xc001b1d3d8 sp=0xc001b1d340 pc=0x568674
github.com/google/syzkaller/prog.(*randGen).generateArgImpl(0xc02772afe0, 0xc011eec7d0, {0xce5670?, 0x11ca8e0?}, 0x2, 0x0)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:720 +0x606 fp=0xc001b1d498 sp=0xc001b1d3d8 pc=0x5683e6
github.com/google/syzkaller/prog.(*randGen).generateArg(...)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:670
github.com/google/syzkaller/prog.(*randGen).generateArgs(0x25e51c98?, 0x412f22?, {0x12fa500, 0x2, 0x2}, 0x2)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:658 +0x17b fp=0xc001b1d568 sp=0xc001b1d498 pc=0x567c1b
github.com/google/syzkaller/prog.(*StructType).generate(0x12fa4a0, 0xc0004800c0?, 0xb182a7?, 0x2)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:856 +0x45 fp=0xc001b1d5e0 sp=0xc001b1d568 pc=0x569b45
github.com/google/syzkaller/prog.(*randGen).generateArgImpl(0xc02772afe0, 0xc011eec7d0, {0xce5738?, 0x12fa4a0?}, 0x2, 0x0)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:720 +0x606 fp=0xc001b1d6a0 sp=0xc001b1d5e0 pc=0x5683e6
github.com/google/syzkaller/prog.(*randGen).generateArg(...)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:670
github.com/google/syzkaller/prog.(*ArrayType).generate(0x12e52c0, 0xc02772afe0, 0x0?, 0x2)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:848 +0x22c fp=0xc001b1d770 sp=0xc001b1d6a0 pc=0x56990c
github.com/google/syzkaller/prog.(*randGen).generateArgImpl(0xc02772afe0, 0xc011eec7d0, {0xce4f68?, 0x12e52c0?}, 0x2, 0x0)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:720 +0x606 fp=0xc001b1d830 sp=0xc001b1d770 pc=0x5683e6
github.com/google/syzkaller/prog.(*randGen).generateArg(...)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:670
github.com/google/syzkaller/prog.(*randGen).generateArgs(0xcdf500?, 0x412f22?, {0x186a0a0, 0x4, 0x4}, 0x2)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:658 +0x17b fp=0xc001b1d900 sp=0xc001b1d830 pc=0x567c1b
github.com/google/syzkaller/prog.(*StructType).generate(0x12fa440, 0xc0004800c0?, 0xb0e197?, 0x2)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:856 +0x45 fp=0xc001b1d978 sp=0xc001b1d900 pc=0x569b45
github.com/google/syzkaller/prog.(*randGen).generateArgImpl(0xc02772afe0, 0xc011eec7d0, {0xce5738?, 0x12fa440?}, 0x2, 0x0)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:720 +0x606 fp=0xc001b1da38 sp=0xc001b1d978 pc=0x5683e6
github.com/google/syzkaller/prog.(*randGen).generateArg(...)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:670
github.com/google/syzkaller/prog.(*PtrType).generate(0x1214620, 0xc02772afe0, 0x415c70?, 0x0?)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:875 +0x85 fp=0xc001b1dac0 sp=0xc001b1da38 pc=0x569e45
github.com/google/syzkaller/prog.(*randGen).generateArgImpl(0xc02772afe0, 0xc011eec7d0, {0xce55a8?, 0x1214620?}, 0x0, 0x0)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:720 +0x606 fp=0xc001b1db80 sp=0xc001b1dac0 pc=0x5683e6
github.com/google/syzkaller/prog.(*randGen).generateArg(...)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:670
github.com/google/syzkaller/prog.(*randGen).generateArgs(0x19334a0?, 0x0?, {0x166cc60, 0x3, 0x3}, 0x0)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:658 +0x17b fp=0xc001b1dc50 sp=0xc001b1db80 pc=0x567c1b
github.com/google/syzkaller/prog.(*randGen).generateParticularCall(0xc02772afe0, 0xc011eec7d0?, 0x19334a0)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:584 +0x85 fp=0xc001b1dcd8 sp=0xc001b1dc50 pc=0x566ce5
github.com/google/syzkaller/prog.(*randGen).generateCall(0xc02772afe0, 0xc011eec7d0, 0xc0075436c0?, 0xc007543600?)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/rand.go:573 +0xb6 fp=0xc001b1dd00 sp=0xc001b1dcd8 pc=0x566bf6
github.com/google/syzkaller/prog.(*mutator).insertCall(0xc001b1de48)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/mutation.go:152 +0xc5 fp=0xc001b1ddc0 sp=0xc001b1dd00 pc=0x55a405
github.com/google/syzkaller/prog.(*Prog).Mutate(0xc0075436c0, {0xcdd528?, 0xc01e554c00}, 0x1e, 0xc01ca70000, 0xc000480390, {0xc01f420000, 0x480a, 0x5400})
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/mutation.go:49 +0x2ac fp=0xc001b1de98 sp=0xc001b1ddc0 pc=0x5596ec
main.(*Proc).loop(0xc01ca70300)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:95 +0x365 fp=0xc001b1dfc8 sp=0xc001b1de98 pc=0x910b45
main.main.func2()
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x26 fp=0xc001b1dfe0 sp=0xc001b1dfc8 pc=0x90cbc6
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc001b1dfe8 sp=0xc001b1dfe0 pc=0x469781
created by main.main
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x15e5

goroutine 28 [IO wait]:
runtime.gopark(0x540ee0?, 0xb?, 0x0?, 0x0?, 0x21?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc01e9ab7a8 sp=0xc01e9ab788 pc=0x4390f6
runtime.netpollblock(0x4bc5a5?, 0x40482f?, 0x0?)
	/usr/local/go/src/runtime/netpoll.go:527 +0xf7 fp=0xc01e9ab7e0 sp=0xc01e9ab7a8 pc=0x431a57
internal/poll.runtime_pollWait(0x7fa6ac153c10, 0x72)
	/usr/local/go/src/runtime/netpoll.go:306 +0x89 fp=0xc01e9ab800 sp=0xc01e9ab7e0 pc=0x463b49
internal/poll.(*pollDesc).wait(0xc000650fc0?, 0xc020db47f0?, 0x1)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:84 +0x32 fp=0xc01e9ab828 sp=0xc01e9ab800 pc=0x4d7a72
internal/poll.(*pollDesc).waitRead(...)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:89
internal/poll.(*FD).Read(0xc000650fc0, {0xc020db47f0, 0xc, 0xc})
	/usr/local/go/src/internal/poll/fd_unix.go:167 +0x299 fp=0xc01e9ab8c0 sp=0xc01e9ab828 pc=0x4d8e59
os.(*File).read(...)
	/usr/local/go/src/os/file_posix.go:31
os.(*File).Read(0xc01c258590, {0xc020db47f0?, 0xc01e9ab950?, 0x40de47?})
	/usr/local/go/src/os/file.go:118 +0x5e fp=0xc01e9ab918 sp=0xc01e9ab8c0 pc=0x4e42be
io.ReadAtLeast({0xcdbc00, 0xc01c258590}, {0xc020db47f0, 0xc, 0xc}, 0xc)
	/usr/local/go/src/io/io.go:332 +0x9a fp=0xc01e9ab960 sp=0xc01e9ab918 pc=0x4b25fa
io.ReadFull(...)
	/usr/local/go/src/io/io.go:351
github.com/google/syzkaller/pkg/ipc.(*command).exec(0xc0002bf1f0, 0x7fa6a6a4c000?, {0x0, 0x0, 0x0})
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:786 +0x559 fp=0xc01e9abb18 sp=0xc01e9ab960 pc=0x907d19
github.com/google/syzkaller/pkg/ipc.(*Env).Exec(0xc000218870, 0x1?, 0xc020dc6040)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:286 +0x24e fp=0xc01e9abbf8 sp=0xc01e9abb18 pc=0x903d4e
main.(*Proc).executeRaw(0xc01ca70380, 0x484b7e?, 0xc020db4490?, 0x1)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:328 +0x1bc fp=0xc01e9abd10 sp=0xc01e9abbf8 pc=0x912f3c
main.(*Proc).execute(0xc01ca70380, 0xb?, 0xc?, 0xc01e9abf38?, 0x1?)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:255 +0x49 fp=0xc01e9abe50 sp=0xc01e9abd10 pc=0x9126a9
main.(*Proc).executeAndCollide(0xc01ca70380, 0xa849df?, 0xc01e554c30?, 0xc01e9abf38?, 0xc01ca70000?)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:284 +0x27 fp=0xc01e9abe98 sp=0xc01e9abe50 pc=0x912ba7
main.(*Proc).loop(0xc01ca70380)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:97 +0x3d7 fp=0xc01e9abfc8 sp=0xc01e9abe98 pc=0x910bb7
main.main.func2()
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x26 fp=0xc01e9abfe0 sp=0xc01e9abfc8 pc=0x90cbc6
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc01e9abfe8 sp=0xc01e9abfe0 pc=0x469781
created by main.main
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x15e5

goroutine 29 [sync.Cond.Wait]:
runtime.gopark(0xc0250cb660?, 0xc0250cb640?, 0x20?, 0x0?, 0x20?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc002607c90 sp=0xc002607c70 pc=0x4390f6
runtime.goparkunlock(...)
	/usr/local/go/src/runtime/proc.go:387
sync.runtime_notifyListWait(0xc000b66a10, 0x5e)
	/usr/local/go/src/runtime/sema.go:527 +0x14c fp=0xc002607cd8 sp=0xc002607c90 pc=0x4658ec
sync.(*Cond).Wait(0xc002607d68?)
	/usr/local/go/src/sync/cond.go:70 +0x8c fp=0xc002607d10 sp=0xc002607cd8 pc=0x4824cc
github.com/google/syzkaller/pkg/ipc.(*Gate).Enter(0xc000b66a40)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/gate.go:34 +0x3f fp=0xc002607d38 sp=0xc002607d10 pc=0x902c3f
main.(*Proc).executeRaw(0xc01ca70480, 0xb?, 0xc?, 0x8)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:322 +0x88 fp=0xc002607e50 sp=0xc002607d38 pc=0x912e08
main.(*Proc).executeAndCollide(0xc01ca70480, 0xa849df?, 0xc01e554c60?, 0xc002607f38?, 0xc01ca70000?)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:292 +0x72 fp=0xc002607e98 sp=0xc002607e50 pc=0x912bf2
main.(*Proc).loop(0xc01ca70480)
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/proc.go:97 +0x3d7 fp=0xc002607fc8 sp=0xc002607e98 pc=0x910bb7
main.main.func2()
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x26 fp=0xc002607fe0 sp=0xc002607fc8 pc=0x90cbc6
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc002607fe8 sp=0xc002607fe0 pc=0x469781
created by main.main
	/syzkaller/gopath/src/github.com/google/syzkaller/syz-fuzzer/fuzzer.go:310 +0x15e5

goroutine 11 [syscall, 1 minutes]:
syscall.Syscall6(0xc01ca6e050?, 0x0?, 0x0?, 0x0?, 0x1?, 0xc000056e88?, 0x90f41f?)
	/usr/local/go/src/syscall/syscall_linux.go:91 +0x36 fp=0xc000056de0 sp=0xc000056d58 pc=0x4be516
os.(*Process).blockUntilWaitable(0xc01e5384e0)
	/usr/local/go/src/os/wait_waitid.go:32 +0x87 fp=0xc000056eb8 sp=0xc000056de0 pc=0x4ea887
os.(*Process).wait(0xc01e5384e0)
	/usr/local/go/src/os/exec_unix.go:22 +0x28 fp=0xc000056f18 sp=0xc000056eb8 pc=0x4e3b08
os.(*Process).Wait(...)
	/usr/local/go/src/os/exec.go:132
os/exec.(*Cmd).Wait(0xc019bea840)
	/usr/local/go/src/os/exec/exec.go:890 +0x45 fp=0xc000056f80 sp=0xc000056f18 pc=0x5283a5
github.com/google/syzkaller/pkg/ipc.makeCommand.func3(0xc0002bf030)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:652 +0x32 fp=0xc000056fc8 sp=0xc000056f80 pc=0x906c92
github.com/google/syzkaller/pkg/ipc.makeCommand.func8()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:657 +0x2a fp=0xc000056fe0 sp=0xc000056fc8 pc=0x906c2a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000056fe8 sp=0xc000056fe0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:651 +0xc7c

goroutine 367 [select]:
runtime.gopark(0xc000b4a7b0?, 0x2?, 0x90?, 0xa0?, 0xc000b4a78c?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000b4a618 sp=0xc000b4a5f8 pc=0x4390f6
runtime.selectgo(0xc000b4a7b0, 0xc000b4a788, 0x4c9ff7?, 0x0, 0x906ce7?, 0x1)
	/usr/local/go/src/runtime/select.go:327 +0x7be fp=0xc000b4a758 sp=0xc000b4a618 pc=0x4491fe
github.com/google/syzkaller/pkg/ipc.(*command).exec.func1()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:771 +0x7d fp=0xc000b4a7e0 sp=0xc000b4a758 pc=0x90841d
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4a7e8 sp=0xc000b4a7e0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.(*command).exec
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:769 +0x25b

goroutine 31 [IO wait, 1 minutes]:
runtime.gopark(0x0?, 0xb?, 0x0?, 0x0?, 0x10?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000051de8 sp=0xc000051dc8 pc=0x4390f6
runtime.netpollblock(0x4bc5a5?, 0x40482f?, 0x0?)
	/usr/local/go/src/runtime/netpoll.go:527 +0xf7 fp=0xc000051e20 sp=0xc000051de8 pc=0x431a57
internal/poll.runtime_pollWait(0x7fa6ad0ef2c8, 0x72)
	/usr/local/go/src/runtime/netpoll.go:306 +0x89 fp=0xc000051e40 sp=0xc000051e20 pc=0x463b49
internal/poll.(*pollDesc).wait(0xc0016ad2c0?, 0xc027434000?, 0x1)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:84 +0x32 fp=0xc000051e68 sp=0xc000051e40 pc=0x4d7a72
internal/poll.(*pollDesc).waitRead(...)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:89
internal/poll.(*FD).Read(0xc0016ad2c0, {0xc027434000, 0x20000, 0x20000})
	/usr/local/go/src/internal/poll/fd_unix.go:167 +0x299 fp=0xc000051f00 sp=0xc000051e68 pc=0x4d8e59
os.(*File).read(...)
	/usr/local/go/src/os/file_posix.go:31
os.(*File).Read(0xc0155f39a0, {0xc027434000?, 0x4807?, 0x5400?})
	/usr/local/go/src/os/file.go:118 +0x5e fp=0xc000051f58 sp=0xc000051f00 pc=0x4e42be
github.com/google/syzkaller/pkg/ipc.makeCommand.func2(0xc0003975e0)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:629 +0x8a fp=0xc000051fc8 sp=0xc000051f58 pc=0x906e0a
github.com/google/syzkaller/pkg/ipc.makeCommand.func7()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:644 +0x2a fp=0xc000051fe0 sp=0xc000051fc8 pc=0x906d4a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000051fe8 sp=0xc000051fe0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:623 +0xa7b

goroutine 15 [IO wait, 1 minutes]:
runtime.gopark(0x0?, 0xb?, 0x0?, 0x0?, 0x23?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000b4b5e8 sp=0xc000b4b5c8 pc=0x4390f6
runtime.netpollblock(0x4bc5a5?, 0x40482f?, 0x0?)
	/usr/local/go/src/runtime/netpoll.go:527 +0xf7 fp=0xc000b4b620 sp=0xc000b4b5e8 pc=0x431a57
internal/poll.runtime_pollWait(0x7fa6ad0eee18, 0x72)
	/usr/local/go/src/runtime/netpoll.go:306 +0x89 fp=0xc000b4b640 sp=0xc000b4b620 pc=0x463b49
internal/poll.(*pollDesc).wait(0xc000650720?, 0xc0273d4000?, 0x1)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:84 +0x32 fp=0xc000b4b668 sp=0xc000b4b640 pc=0x4d7a72
internal/poll.(*pollDesc).waitRead(...)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:89
internal/poll.(*FD).Read(0xc000650720, {0xc0273d4000, 0x20000, 0x20000})
	/usr/local/go/src/internal/poll/fd_unix.go:167 +0x299 fp=0xc000b4b700 sp=0xc000b4b668 pc=0x4d8e59
os.(*File).read(...)
	/usr/local/go/src/os/file_posix.go:31
os.(*File).Read(0xc01c2584d0, {0xc0273d4000?, 0x0?, 0x1d0cb50?})
	/usr/local/go/src/os/file.go:118 +0x5e fp=0xc000b4b758 sp=0xc000b4b700 pc=0x4e42be
github.com/google/syzkaller/pkg/ipc.makeCommand.func2(0xc0002bf0a0)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:629 +0x8a fp=0xc000b4b7c8 sp=0xc000b4b758 pc=0x906e0a
github.com/google/syzkaller/pkg/ipc.makeCommand.func7()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:644 +0x2a fp=0xc000b4b7e0 sp=0xc000b4b7c8 pc=0x906d4a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4b7e8 sp=0xc000b4b7e0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:623 +0xa7b

goroutine 16 [IO wait, 1 minutes]:
runtime.gopark(0x0?, 0xb?, 0x0?, 0x0?, 0x2a?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000b4bde8 sp=0xc000b4bdc8 pc=0x4390f6
runtime.netpollblock(0x4bc5a5?, 0x40482f?, 0x0?)
	/usr/local/go/src/runtime/netpoll.go:527 +0xf7 fp=0xc000b4be20 sp=0xc000b4bde8 pc=0x431a57
internal/poll.runtime_pollWait(0x7fa6ac1541b0, 0x72)
	/usr/local/go/src/runtime/netpoll.go:306 +0x89 fp=0xc000b4be40 sp=0xc000b4be20 pc=0x463b49
internal/poll.(*pollDesc).wait(0xc000650a80?, 0xc0273f4000?, 0x1)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:84 +0x32 fp=0xc000b4be68 sp=0xc000b4be40 pc=0x4d7a72
internal/poll.(*pollDesc).waitRead(...)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:89
internal/poll.(*FD).Read(0xc000650a80, {0xc0273f4000, 0x20000, 0x20000})
	/usr/local/go/src/internal/poll/fd_unix.go:167 +0x299 fp=0xc000b4bf00 sp=0xc000b4be68 pc=0x4d8e59
os.(*File).read(...)
	/usr/local/go/src/os/file_posix.go:31
os.(*File).Read(0xc01c258530, {0xc0273f4000?, 0x0?, 0x1c197e0?})
	/usr/local/go/src/os/file.go:118 +0x5e fp=0xc000b4bf58 sp=0xc000b4bf00 pc=0x4e42be
github.com/google/syzkaller/pkg/ipc.makeCommand.func2(0xc0002bf180)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:629 +0x8a fp=0xc000b4bfc8 sp=0xc000b4bf58 pc=0x906e0a
github.com/google/syzkaller/pkg/ipc.makeCommand.func7()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:644 +0x2a fp=0xc000b4bfe0 sp=0xc000b4bfc8 pc=0x906d4a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4bfe8 sp=0xc000b4bfe0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:623 +0xa7b

goroutine 33 [syscall, 1 minutes]:
syscall.Syscall6(0x0?, 0x0?, 0x0?, 0x0?, 0x0?, 0x402020302020302?, 0x0?)
	/usr/local/go/src/syscall/syscall_linux.go:91 +0x36 fp=0xc000b4c5e0 sp=0xc000b4c558 pc=0x4be516
os.(*Process).blockUntilWaitable(0xc01e5387e0)
	/usr/local/go/src/os/wait_waitid.go:32 +0x87 fp=0xc000b4c6b8 sp=0xc000b4c5e0 pc=0x4ea887
os.(*Process).wait(0xc01e5387e0)
	/usr/local/go/src/os/exec_unix.go:22 +0x28 fp=0xc000b4c718 sp=0xc000b4c6b8 pc=0x4e3b08
os.(*Process).Wait(...)
	/usr/local/go/src/os/exec.go:132
os/exec.(*Cmd).Wait(0xc001c6a160)
	/usr/local/go/src/os/exec/exec.go:890 +0x45 fp=0xc000b4c780 sp=0xc000b4c718 pc=0x5283a5
github.com/google/syzkaller/pkg/ipc.makeCommand.func3(0xc0003975e0)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:652 +0x32 fp=0xc000b4c7c8 sp=0xc000b4c780 pc=0x906c92
github.com/google/syzkaller/pkg/ipc.makeCommand.func8()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:657 +0x2a fp=0xc000b4c7e0 sp=0xc000b4c7c8 pc=0x906c2a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4c7e8 sp=0xc000b4c7e0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:651 +0xc7c

goroutine 302 [IO wait]:
runtime.gopark(0x0?, 0xb?, 0x0?, 0x0?, 0x15?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000b4dde8 sp=0xc000b4ddc8 pc=0x4390f6
runtime.netpollblock(0x4bc5a5?, 0x40482f?, 0x0?)
	/usr/local/go/src/runtime/netpoll.go:527 +0xf7 fp=0xc000b4de20 sp=0xc000b4dde8 pc=0x431a57
internal/poll.runtime_pollWait(0x7fa6ad0ef0e8, 0x72)
	/usr/local/go/src/runtime/netpoll.go:306 +0x89 fp=0xc000b4de40 sp=0xc000b4de20 pc=0x463b49
internal/poll.(*pollDesc).wait(0xc01765ef60?, 0xc0120fc000?, 0x1)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:84 +0x32 fp=0xc000b4de68 sp=0xc000b4de40 pc=0x4d7a72
internal/poll.(*pollDesc).waitRead(...)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:89
internal/poll.(*FD).Read(0xc01765ef60, {0xc0120fc000, 0x20000, 0x20000})
	/usr/local/go/src/internal/poll/fd_unix.go:167 +0x299 fp=0xc000b4df00 sp=0xc000b4de68 pc=0x4d8e59
os.(*File).read(...)
	/usr/local/go/src/os/file_posix.go:31
os.(*File).Read(0xc01c2585d8, {0xc0120fc000?, 0xc01911a1c8?, 0x0?})
	/usr/local/go/src/os/file.go:118 +0x5e fp=0xc000b4df58 sp=0xc000b4df00 pc=0x4e42be
github.com/google/syzkaller/pkg/ipc.makeCommand.func2(0xc00041d180)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:629 +0x8a fp=0xc000b4dfc8 sp=0xc000b4df58 pc=0x906e0a
github.com/google/syzkaller/pkg/ipc.makeCommand.func7()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:644 +0x2a fp=0xc000b4dfe0 sp=0xc000b4dfc8 pc=0x906d4a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4dfe8 sp=0xc000b4dfe0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:623 +0xa7b

goroutine 35 [IO wait, 1 minutes]:
runtime.gopark(0x0?, 0xb?, 0x0?, 0x0?, 0x13?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000b4e5e8 sp=0xc000b4e5c8 pc=0x4390f6
runtime.netpollblock(0x4bc5a5?, 0x40482f?, 0x0?)
	/usr/local/go/src/runtime/netpoll.go:527 +0xf7 fp=0xc000b4e620 sp=0xc000b4e5e8 pc=0x431a57
internal/poll.runtime_pollWait(0x7fa6ad0efa48, 0x72)
	/usr/local/go/src/runtime/netpoll.go:306 +0x89 fp=0xc000b4e640 sp=0xc000b4e620 pc=0x463b49
internal/poll.(*pollDesc).wait(0xc000650f00?, 0xc027414000?, 0x1)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:84 +0x32 fp=0xc000b4e668 sp=0xc000b4e640 pc=0x4d7a72
internal/poll.(*pollDesc).waitRead(...)
	/usr/local/go/src/internal/poll/fd_poll_runtime.go:89
internal/poll.(*FD).Read(0xc000650f00, {0xc027414000, 0x20000, 0x20000})
	/usr/local/go/src/internal/poll/fd_unix.go:167 +0x299 fp=0xc000b4e700 sp=0xc000b4e668 pc=0x4d8e59
os.(*File).read(...)
	/usr/local/go/src/os/file_posix.go:31
os.(*File).Read(0xc01c258578, {0xc027414000?, 0x0?, 0x12cecb0?})
	/usr/local/go/src/os/file.go:118 +0x5e fp=0xc000b4e758 sp=0xc000b4e700 pc=0x4e42be
github.com/google/syzkaller/pkg/ipc.makeCommand.func2(0xc0002bf1f0)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:629 +0x8a fp=0xc000b4e7c8 sp=0xc000b4e758 pc=0x906e0a
github.com/google/syzkaller/pkg/ipc.makeCommand.func7()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:644 +0x2a fp=0xc000b4e7e0 sp=0xc000b4e7c8 pc=0x906d4a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4e7e8 sp=0xc000b4e7e0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:623 +0xa7b

goroutine 32 [syscall, 1 minutes]:
syscall.Syscall6(0xc01ca70000?, 0x0?, 0x0?, 0x0?, 0xc00078f900?, 0xc000051688?, 0x90f41f?)
	/usr/local/go/src/syscall/syscall_linux.go:91 +0x36 fp=0xc0000515e0 sp=0xc000051558 pc=0x4be516
os.(*Process).blockUntilWaitable(0xc00bc1f7a0)
	/usr/local/go/src/os/wait_waitid.go:32 +0x87 fp=0xc0000516b8 sp=0xc0000515e0 pc=0x4ea887
os.(*Process).wait(0xc00bc1f7a0)
	/usr/local/go/src/os/exec_unix.go:22 +0x28 fp=0xc000051718 sp=0xc0000516b8 pc=0x4e3b08
os.(*Process).Wait(...)
	/usr/local/go/src/os/exec.go:132
os/exec.(*Cmd).Wait(0xc019bea9a0)
	/usr/local/go/src/os/exec/exec.go:890 +0x45 fp=0xc000051780 sp=0xc000051718 pc=0x5283a5
github.com/google/syzkaller/pkg/ipc.makeCommand.func3(0xc0002bf0a0)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:652 +0x32 fp=0xc0000517c8 sp=0xc000051780 pc=0x906c92
github.com/google/syzkaller/pkg/ipc.makeCommand.func8()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:657 +0x2a fp=0xc0000517e0 sp=0xc0000517c8 pc=0x906c2a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc0000517e8 sp=0xc0000517e0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:651 +0xc7c

goroutine 36 [syscall, 1 minutes]:
syscall.Syscall6(0x0?, 0x0?, 0x0?, 0x0?, 0x0?, 0x0?, 0x0?)
	/usr/local/go/src/syscall/syscall_linux.go:91 +0x36 fp=0xc002a31de0 sp=0xc002a31d58 pc=0x4be516
os.(*Process).blockUntilWaitable(0xc01e538960)
	/usr/local/go/src/os/wait_waitid.go:32 +0x87 fp=0xc002a31eb8 sp=0xc002a31de0 pc=0x4ea887
os.(*Process).wait(0xc01e538960)
	/usr/local/go/src/os/exec_unix.go:22 +0x28 fp=0xc002a31f18 sp=0xc002a31eb8 pc=0x4e3b08
os.(*Process).Wait(...)
	/usr/local/go/src/os/exec.go:132
os/exec.(*Cmd).Wait(0xc019beab00)
	/usr/local/go/src/os/exec/exec.go:890 +0x45 fp=0xc002a31f80 sp=0xc002a31f18 pc=0x5283a5
github.com/google/syzkaller/pkg/ipc.makeCommand.func3(0xc0002bf180)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:652 +0x32 fp=0xc002a31fc8 sp=0xc002a31f80 pc=0x906c92
github.com/google/syzkaller/pkg/ipc.makeCommand.func8()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:657 +0x2a fp=0xc002a31fe0 sp=0xc002a31fc8 pc=0x906c2a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc002a31fe8 sp=0xc002a31fe0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:651 +0xc7c

goroutine 50 [syscall, 1 minutes]:
syscall.Syscall6(0xc01ca70000?, 0x0?, 0x0?, 0x0?, 0x19e4260?, 0xc000b4ee88?, 0x90f41f?)
	/usr/local/go/src/syscall/syscall_linux.go:91 +0x36 fp=0xc000b4ede0 sp=0xc000b4ed58 pc=0x4be516
os.(*Process).blockUntilWaitable(0xc00bc1f8c0)
	/usr/local/go/src/os/wait_waitid.go:32 +0x87 fp=0xc000b4eeb8 sp=0xc000b4ede0 pc=0x4ea887
os.(*Process).wait(0xc00bc1f8c0)
	/usr/local/go/src/os/exec_unix.go:22 +0x28 fp=0xc000b4ef18 sp=0xc000b4eeb8 pc=0x4e3b08
os.(*Process).Wait(...)
	/usr/local/go/src/os/exec.go:132
os/exec.(*Cmd).Wait(0xc019beac60)
	/usr/local/go/src/os/exec/exec.go:890 +0x45 fp=0xc000b4ef80 sp=0xc000b4ef18 pc=0x5283a5
github.com/google/syzkaller/pkg/ipc.makeCommand.func3(0xc0002bf1f0)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:652 +0x32 fp=0xc000b4efc8 sp=0xc000b4ef80 pc=0x906c92
github.com/google/syzkaller/pkg/ipc.makeCommand.func8()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:657 +0x2a fp=0xc000b4efe0 sp=0xc000b4efc8 pc=0x906c2a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000b4efe8 sp=0xc000b4efe0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:651 +0xc7c

goroutine 360 [select]:
runtime.gopark(0xc000053fb0?, 0x2?, 0xc0?, 0x26?, 0xc000053f8c?)
	/usr/local/go/src/runtime/proc.go:381 +0xd6 fp=0xc000053e18 sp=0xc000053df8 pc=0x4390f6
runtime.selectgo(0xc000053fb0, 0xc000053f88, 0x0?, 0x0, 0x0?, 0x1)
	/usr/local/go/src/runtime/select.go:327 +0x7be fp=0xc000053f58 sp=0xc000053e18 pc=0x4491fe
github.com/google/syzkaller/pkg/ipc.(*command).exec.func1()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:771 +0x7d fp=0xc000053fe0 sp=0xc000053f58 pc=0x90841d
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc000053fe8 sp=0xc000053fe0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.(*command).exec
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:769 +0x25b

goroutine 303 [syscall]:
syscall.Syscall6(0xc002a30608?, 0x4488f3?, 0x4390f6?, 0x1?, 0x0?, 0xc002a30748?, 0x4497b4?)
	/usr/local/go/src/syscall/syscall_linux.go:91 +0x36 fp=0xc002a305e0 sp=0xc002a30558 pc=0x4be516
os.(*Process).blockUntilWaitable(0xc00477b980)
	/usr/local/go/src/os/wait_waitid.go:32 +0x87 fp=0xc002a306b8 sp=0xc002a305e0 pc=0x4ea887
os.(*Process).wait(0xc00477b980)
	/usr/local/go/src/os/exec_unix.go:22 +0x28 fp=0xc002a30718 sp=0xc002a306b8 pc=0x4e3b08
os.(*Process).Wait(...)
	/usr/local/go/src/os/exec.go:132
os/exec.(*Cmd).Wait(0xc001c6b760)
	/usr/local/go/src/os/exec/exec.go:890 +0x45 fp=0xc002a30780 sp=0xc002a30718 pc=0x5283a5
github.com/google/syzkaller/pkg/ipc.makeCommand.func3(0xc00041d180)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:652 +0x32 fp=0xc002a307c8 sp=0xc002a30780 pc=0x906c92
github.com/google/syzkaller/pkg/ipc.makeCommand.func8()
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:657 +0x2a fp=0xc002a307e0 sp=0xc002a307c8 pc=0x906c2a
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1598 +0x1 fp=0xc002a307e8 sp=0xc002a307e0 pc=0x469781
created by github.com/google/syzkaller/pkg/ipc.makeCommand
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:651 +0xc7c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
