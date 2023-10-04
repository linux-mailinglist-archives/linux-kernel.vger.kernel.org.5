Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4226E7B86FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbjJDRuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjJDRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:50:50 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B23A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:50:46 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1c8f14ed485so16878fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 10:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696441845; x=1697046645;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ka8p3X0Wztopy2Fn+X/UCRo0PVol+m1mMSaMbHpPhM=;
        b=uGQDOSKHaIOdnwMLV5YEEQTiLJhJquaOZHLab4bBhSoMNkL3LhbQ5WT6lDhE5jFe5X
         SVMtFsYqoZ2ykWSJXx1xwOz8EbpssRJ25Ol68/lgR+RqMe14JXizjWbBZ4Nlt3lVM806
         fbpIykhzUPrXvaOcs3de0qgT/mmX+6YivcZ/6KfKLZj5b11kMXq4NyAk85krx3FIFYaO
         IDRXzqkpH5Rviuu3eWCHVymPBKiai9jCyPi1xLHt49G6ixcugtsGrZd0Ay6lg3Hv8Mp3
         0Uh1V3I/1c4v2DCH02fk+tEeMTufF0JXlKjMbu0U75VOBHl3RkcOf+yd89Mg2FnNs5Q3
         Tqvw==
X-Gm-Message-State: AOJu0Yy98eEoiaoXbOH3pQsn/VlJdIvpXxsJIubKPg5+XIcoZytpy2cp
        z3D2WBQSaqxde1tyuzUSKuyngDEcSfeSvU8ugj5hu+QTk8vd
X-Google-Smtp-Source: AGHT+IGBa1l49kHokuJFnakeBlyaq7XvzwtTlTl5DgYgQ1El5ux2F6L7lr2c98HdNCxz9Ra58QJXjJIcjH1v97/9FV3UgxIZ9uFd
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3a10:b0:1d5:95fc:2a65 with SMTP id
 du16-20020a0568703a1000b001d595fc2a65mr1334792oab.0.1696441845773; Wed, 04
 Oct 2023 10:50:45 -0700 (PDT)
Date:   Wed, 04 Oct 2023 10:50:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000997dac0606e7a57c@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel NULL pointer dereference
 in __kmap_local_page_prot
From:   syzbot <syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ce36c8b14987 Merge tag 'ubifs-for-linus-6.6-rc5' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151d1e92680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b4e3baedc34d5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-ce36c8b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8347e21e2813/vmlinux-ce36c8b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65c05c43e3fe/zImage-ce36c8b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[00000000] *pgd=85891003, *pmd=e44a7003
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 22169 Comm: syz-executor.1 Not tainted 6.6.0-rc4-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at page_zonenum include/linux/mmzone.h:1086 [inline]
PC is at __kmap_local_page_prot+0xc/0x74 mm/highmem.c:573
LR is at kmap_local_page include/linux/highmem-internal.h:73 [inline]
LR is at copy_page_to_iter+0xf8/0x184 lib/iov_iter.c:479
pc : [<804640a4>]    lr : [<807da754>]    psr: 60000013
sp : eb215bf8  ip : eb215c08  fp : eb215c04
r10: 00000018  r9 : 828544e8  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 85a67c00
r3 : 00c00000  r2 : 0000071f  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 8a553240  DAC: 00000000
Register r0 information: NULL pointer
Register r1 information: NULL pointer
Register r2 information: non-paged memory
Register r3 information: non-paged memory
Register r4 information: slab kmalloc-1k start 85a67c00 pointer offset 0 size 1024
Register r5 information: NULL pointer
Register r6 information: NULL pointer
Register r7 information: NULL pointer
Register r8 information: NULL pointer
Register r9 information: non-slab/vmalloc memory
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xeb214000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Register r12 information: 2-page vmalloc region starting at 0xeb214000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Process syz-executor.1 (pid: 22169, stack limit = 0xeb214000)
Stack: (0xeb215bf8 to 0xeb216000)
5be0:                                                       eb215c3c eb215c08
5c00: 807da754 804640a4 eb215c2c eb215ee8 8024bc7c 85a67c00 85a67c00 00000000
5c20: 00000001 00000000 00000038 00000018 eb215c8c eb215c40 813c94e0 807da668
5c40: 81345950 802dcce4 85896a00 85896ad0 89e8b600 85896ad8 eb215ee8 00000000
5c60: 00000000 89e8b600 00000038 85896a00 82e6d240 00000000 00000000 00000000
5c80: eb215cfc eb215c90 815e3418 813c93fc 00000000 00000002 eb215ca4 00000000
5ca0: 00000000 00000000 89e8b6a8 85896aec 89e8b83c eb215ed8 00000000 00000000
5cc0: 00000000 00000000 00000000 7b6cdf11 00000000 815e32c8 eb215ed8 848e3680
5ce0: 00000000 00000000 00000000 eb215d4c eb215d1c eb215d00 815e2758 815e32d4
5d00: 00000000 00000000 00000000 815e2720 eb215d3c eb215d20 81340208 815e272c
5d20: eb215ed8 848e3680 20000500 00000000 eb215dfc eb215d40 8134040c 813401c4
5d40: 00000000 00000000 00000001 00000000 00000000 00000000 00000000 00000000
5d60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5dc0: 00000000 00000000 00000000 7b6cdf11 00000000 00000000 eb215ed8 20000500
5de0: 00000000 848e3680 82e6d240 00000001 eb215e7c eb215e00 81342f58 81340388
5e00: 00000000 00000000 00000009 00000000 00000000 20000580 00000038 00000000
5e20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5e40: 00000000 00000000 00000000 00000000 00000000 7b6cdf11 eb215e7c eb215eb8
5e60: 20000500 00000000 00000000 00000000 eb215f5c eb215e80 81343080 81342edc
5e80: 00000000 eb215e90 80889cc0 848e3680 00000001 00000000 00000000 00000000
5ea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000001 ffffffff
5ec0: 000f4240 eb215ed8 eb215f24 000509e0 00000000 00000000 eb215d4c 00000000
5ee0: 00000000 00000000 00000005 00000001 00000001 20000580 00000037 00000000
5f00: 00000001 00000000 00000000 00000001 00000000 00000000 00000000 00000000
5f20: 00000000 00000000 eb215f44 7b6cdf11 8183c20c 00000003 20000500 00000000
5f40: 00000000 00000001 82e6d240 0000016d eb215fa4 eb215f60 81343a50 81342f98
5f60: 00000000 eb215fb0 00000000 00000000 00000000 00000000 eb215fac 7b6cdf11
5f80: 8020c8d0 00000000 00000000 0014c2c8 0000016d 80200288 00000000 eb215fa8
5fa0: 80200060 81343998 00000000 00000000 00000003 20000500 00000001 00000000
5fc0: 00000000 00000000 0014c2c8 0000016d 7ead532e 7ead532f 003d0f00 76bf20fc
5fe0: 76bf1f08 76bf1ef8 00016688 000509e0 60000010 00000003 00000000 00000000
Backtrace: 
[<80464098>] (__kmap_local_page_prot) from [<807da754>] (kmap_local_page include/linux/highmem-internal.h:73 [inline])
[<80464098>] (__kmap_local_page_prot) from [<807da754>] (copy_page_to_iter+0xf8/0x184 lib/iov_iter.c:479)
[<807da65c>] (copy_page_to_iter) from [<813c94e0>] (sk_msg_recvmsg+0xf0/0x3cc net/core/skmsg.c:437)
 r10:00000018 r9:00000038 r8:00000000 r7:00000001 r6:00000000 r5:85a67c00
 r4:85a67c00
[<813c93f0>] (sk_msg_recvmsg) from [<815e3418>] (unix_bpf_recvmsg net/unix/unix_bpf.c:73 [inline])
[<813c93f0>] (sk_msg_recvmsg) from [<815e3418>] (unix_bpf_recvmsg+0x150/0x444 net/unix/unix_bpf.c:50)
 r10:00000000 r9:00000000 r8:00000000 r7:82e6d240 r6:85896a00 r5:00000038
 r4:89e8b600
[<815e32c8>] (unix_bpf_recvmsg) from [<815e2758>] (unix_dgram_recvmsg+0x38/0x4c net/unix/af_unix.c:2457)
 r10:eb215d4c r9:00000000 r8:00000000 r7:00000000 r6:848e3680 r5:eb215ed8
 r4:815e32c8
[<815e2720>] (unix_dgram_recvmsg) from [<81340208>] (sock_recvmsg_nosec net/socket.c:1027 [inline])
[<815e2720>] (unix_dgram_recvmsg) from [<81340208>] (sock_recvmsg+0x50/0x78 net/socket.c:1049)
 r4:815e2720
[<813401b8>] (sock_recvmsg) from [<8134040c>] (____sys_recvmsg+0x90/0x158 net/socket.c:2760)
 r7:00000000 r6:20000500 r5:848e3680 r4:eb215ed8
[<8134037c>] (____sys_recvmsg) from [<81342f58>] (___sys_recvmsg+0x88/0xbc net/socket.c:2802)
 r10:00000001 r9:82e6d240 r8:848e3680 r7:00000000 r6:20000500 r5:eb215ed8
 r4:00000000
[<81342ed0>] (___sys_recvmsg) from [<81343080>] (do_recvmmsg+0xf4/0x298 net/socket.c:2896)
 r8:00000000 r7:00000000 r6:00000000 r5:20000500 r4:eb215eb8
[<81342f8c>] (do_recvmmsg) from [<81343a50>] (__sys_recvmmsg net/socket.c:2975 [inline])
[<81342f8c>] (do_recvmmsg) from [<81343a50>] (__do_sys_recvmmsg_time32 net/socket.c:3009 [inline])
[<81342f8c>] (do_recvmmsg) from [<81343a50>] (sys_recvmmsg_time32+0xc4/0xd8 net/socket.c:3002)
 r10:0000016d r9:82e6d240 r8:00000001 r7:00000000 r6:00000000 r5:20000500
 r4:00000003
[<8134398c>] (sys_recvmmsg_time32) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xeb215fa8 to 0xeb215ff0)
5fa0:                   00000000 00000000 00000003 20000500 00000001 00000000
5fc0: 00000000 00000000 0014c2c8 0000016d 7ead532e 7ead532f 003d0f00 76bf20fc
5fe0: 76bf1f08 76bf1ef8 00016688 000509e0
 r8:80200288 r7:0000016d r6:0014c2c8 r5:00000000 r4:00000000
Code: eaffffe8 e1a0c00d e92dd800 e24cb004 (e5901000) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	eaffffe8 	b	0xffffffa8
   4:	e1a0c00d 	mov	ip, sp
   8:	e92dd800 	push	{fp, ip, lr, pc}
   c:	e24cb004 	sub	fp, ip, #4
* 10:	e5901000 	ldr	r1, [r0] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
