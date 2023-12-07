Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80BD808FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443673AbjLGSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjLGSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:17:20 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355AB1709
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:17:26 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b83ce0d549so2037747b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973045; x=1702577845;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhnv9lBHKEXOXqfNZWSlL9PiEGeoqa474iI9yfu4Gxo=;
        b=eHkA66hY+amnkWednK2KN/8nqAvz7AWRBoMFfUIKT7FEK4IFMWd1sEEbtLAwCYzD5G
         6Tyv53zTX+L1heWc9qgED/QPdloMV9lDigTze4UbpPUytT8x/wdKqlZrHipRvCI+w6WV
         gj0XmtjVNTejJ6mlF/yD4b1fz1lACqkY3T61O8vKlRjV1xXqVhTQgoVjrJibDf4Jmc50
         B4HuwpAFcyQLbpkLKMsNrKpGUKIx+Wkkbe2FqYX7qmmdGgdKptPLBoUZTKBvLuTtMHnl
         DKtUYRBYuVUkyRWE/8aQAfCz+SGd8jgDJJC3V9jbEU8Ovs76HHY3rK515MbffORfoTpA
         iSAA==
X-Gm-Message-State: AOJu0YyHvnQebcLn4hQIILGKWV5yUcBqrbounEUNcoYvdGkmmcSvQPsG
        fR4e22my5H99rwwxUohkvmP/A/UuZLXXFtDywhA4CWN0oJTB
X-Google-Smtp-Source: AGHT+IFvA1IozkeVb87UcIiqOXemDjGIaAAgjK3RmtRQPsUEXQHeYAY+sEIECKIKz5f+OyTLkRA7sfv+lWzgHJwRkrqOiLlGwjbI
MIME-Version: 1.0
X-Received: by 2002:a05:6808:158e:b0:3b5:6a59:abb7 with SMTP id
 t14-20020a056808158e00b003b56a59abb7mr2958776oiw.6.1701973045498; Thu, 07 Dec
 2023 10:17:25 -0800 (PST)
Date:   Thu, 07 Dec 2023 10:17:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb5b07060bef7ac0@google.com>
Subject: [syzbot] [net?] WARNING in ip6_route_info_create
From:   syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5a08d0065a91 ipv6: add debug checks in fib6_info_release()
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=175698dae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16070374e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145e1574e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12a59d7df47f/disk-5a08d006.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14f0ca0a861e/vmlinux-5a08d006.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae9306decbe5/bzImage-5a08d006.xz

The issue was bisected to:

commit 5a08d0065a915ccf325563d7ca57fa8b4897881c
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Dec 5 17:32:50 2023 +0000

    ipv6: add debug checks in fib6_info_release()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1137437ae80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1337437ae80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1537437ae80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5062 at include/net/ip6_fib.h:332 fib6_info_release include/net/ip6_fib.h:332 [inline]
WARNING: CPU: 0 PID: 5062 at include/net/ip6_fib.h:332 ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
Modules linked in:
CPU: 0 PID: 5062 Comm: syz-executor399 Not tainted 6.7.0-rc3-syzkaller-00805-g5a08d0065a91 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:fib6_info_release include/net/ip6_fib.h:332 [inline]
RIP: 0010:ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
Code: 49 83 7f 40 00 75 28 e8 04 ae 50 f8 49 8d bf a0 00 00 00 48 c7 c6 c0 ae 37 89 e8 41 2c 3a f8 e9 65 f4 ff ff e8 e7 ad 50 f8 90 <0f> 0b 90 eb ad e8 dc ad 50 f8 90 0f 0b 90 eb cd e8 d1 ad 50 f8 e8
RSP: 0018:ffffc900039cf8e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000400000 RCX: ffffffff8936e418
RDX: ffff888014695940 RSI: ffffffff8936e469 RDI: 0000000000000005
RBP: ffffc900039cf9d0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000400000 R11: ffffffff8aa0008b R12: ffffffffffffffed
R13: ffff88802560682c R14: ffffc900039cfac4 R15: ffff888025606800
FS:  00005555567bb380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c2 CR3: 00000000793d5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
 ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
 inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
 sock_do_ioctl+0x113/0x270 net/socket.c:1220
 sock_ioctl+0x22e/0x6b0 net/socket.c:1339
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f73fa33f369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce78f30b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffce78f3288 RCX: 00007f73fa33f369
RDX: 00000000200001c0 RSI: 000000000000890b RDI: 0000000000000003
RBP: 00007f73fa3b2610 R08: 0000000000000000 R09: 00007ffce78f3288
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffce78f3278 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
