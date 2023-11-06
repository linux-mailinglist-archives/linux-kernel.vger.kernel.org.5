Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977D07E25FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjKFNrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFNrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:47:11 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD3D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:47:09 -0800 (PST)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d32c33f7b7so3994052a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699278428; x=1699883228;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeQ3aR/T9HPkZMfYXqJxip8nwWmO+ZUtSFKfqqoyofo=;
        b=rXblBuajaVbMD/RwbK8x0FZDSomW4bEftsQofwGQE3dc9QL6CZJev5ni3jkHOfMWxL
         h6iY/EnmT3JNXDtw1EqO+5FLh+2PSrQKZIYYIbapRumxEAl2KIP3zVeiubH3yu6FdVCK
         bCc5bcclvnKZlruu3gohOZf7LBtqEYyqRPZyt+z5tktnaW2kzUPGljw5MsrzhgWQ16wN
         3AaQDZqoQwd9xA0Y7sXFdXRmJSrYU18mfYv0Q2765sA527mv4/f1TJ1Qa3X54dAptM6P
         NSQKrmSRzq4gGhY5q4m1gGY0mqZojS2f4+lLI4uW/vd7ElPZpJ8c5JDpD5OuC/dEy3q/
         XvNw==
X-Gm-Message-State: AOJu0YyzKVSrnAlPrDoJ1XB02ojHYDjmeN+0eEJchbwuWnphoKKk8IJQ
        V5JUBP8+biB/w7RozoL+8bnMLmpVxvUELbE4BCISYCFcak6H9tU=
X-Google-Smtp-Source: AGHT+IHLnxUC2Ii1/oCAPrvCiSSa/eByletCOjydjIIYiMXmWjEw9gnBdpPP2eO9YA7KaJV5HpZpwjRDi6KswlGtf9Dq76jTUKkG
MIME-Version: 1.0
X-Received: by 2002:a9d:6e14:0:b0:6c4:e41c:6e6a with SMTP id
 e20-20020a9d6e14000000b006c4e41c6e6amr8278445otr.4.1699278428577; Mon, 06 Nov
 2023 05:47:08 -0800 (PST)
Date:   Mon, 06 Nov 2023 05:47:08 -0800
In-Reply-To: <DB3PR10MB6835A6C1F8E2DD5D5CE8DE90E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c270106097c1763@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in sk_msg_recvmsg
From:   syzbot <syzbot+84f695756ed0c4bb3aba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000097c38006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  Access size = 8 byte(s)
  SSE = 0, SRT = 3
  SF = 1, AR = 0
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000045ff3000
[0000000000000000] pgd=080000004d468003, p4d=080000004d468003, pud=0800000045fd2003, pmd=0000000000000000
Internal error: Oops: 0000000097c38006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3469 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-gd2f51b3516da #0
Hardware name: linux,dummy-virt (DT)
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : page_kasan_tag include/linux/mm.h:1810 [inline]
pc : lowmem_page_address include/linux/mm.h:2181 [inline]
pc : kmap_local_page include/linux/highmem-internal.h:185 [inline]
pc : copy_page_to_iter+0xb0/0x150 lib/iov_iter.c:379
lr : sk_msg_recvmsg+0xf8/0x37c net/core/skmsg.c:437
sp : ffff800082c1b940
x29: ffff800082c1b940 x28: 0000000000000000 x27: f9ff000006afdc00
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000000 x22: 0000040000000000 x21: ffff000000000000
x20: 0000000000001000 x19: ffff800082c1bd50 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000fffffdc6d2a8
x14: 0000000000000194 x13: 0000000000000000 x12: ffff80008244fe70
x11: 0000000000000001 x10: 7210c3fc147100c6 x9 : d0bd2b0aa9cf051c
x8 : faff00000b25de48 x7 : 0000000000000000 x6 : fdff000006afd540
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff800082c1bd50
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 arch_static_branch_jump arch/arm64/include/asm/jump_label.h:38 [inline]
 kasan_enabled include/linux/kasan-enabled.h:13 [inline]
 page_kasan_tag include/linux/mm.h:1809 [inline]
 lowmem_page_address include/linux/mm.h:2181 [inline]
 kmap_local_page include/linux/highmem-internal.h:185 [inline]
 copy_page_to_iter+0xb0/0x150 lib/iov_iter.c:379
 sk_msg_recvmsg+0xf8/0x37c net/core/skmsg.c:437
 unix_bpf_recvmsg net/unix/unix_bpf.c:73 [inline]
 unix_bpf_recvmsg+0x13c/0x4f0 net/unix/unix_bpf.c:50
 unix_dgram_recvmsg+0x30/0x4c net/unix/af_unix.c:2485
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg net/socket.c:1066 [inline]
 sock_recvmsg net/socket.c:1062 [inline]
 ____sys_recvmsg+0x1d0/0x268 net/socket.c:2807
 ___sys_recvmsg+0x90/0xe8 net/socket.c:2849
 do_recvmmsg+0xc8/0x2f8 net/socket.c:2943
 __sys_recvmmsg net/socket.c:3022 [inline]
 __do_sys_recvmmsg net/socket.c:3045 [inline]
 __se_sys_recvmmsg net/socket.c:3038 [inline]
 __arm64_sys_recvmmsg+0xd0/0xec net/socket.c:3038
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
 el0_svc+0x34/0xd8 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
Code: 8b160320 d346fc00 8b0032a0 d503201f (f9400323) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b160320 	add	x0, x25, x22
   4:	d346fc00 	lsr	x0, x0, #6
   8:	8b0032a0 	add	x0, x21, x0, lsl #12
   c:	d503201f 	nop
* 10:	f9400323 	ldr	x3, [x25] <-- trapping instruction


Tested on:

commit:         d2f51b35 Merge tag 'rtc-6.7' of git://git.kernel.org/p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10d706eb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe6eaf758d1d4518
dashboard link: https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
