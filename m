Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E808F7904D1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 05:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjIBDGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 23:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIBDGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 23:06:03 -0400
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B610FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 20:05:59 -0700 (PDT)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-68bf123aca4so2982403b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 20:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693623959; x=1694228759;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRC5dO40H8Q1IEC2YsFhwWz15pm80YaBkFyCAfb3XT0=;
        b=UlVrS0T+GClWG9eXucRNyNrH07Kn0fjQQBnEWHH6Mk1Psgp2VRLSbVfRFpt+to+qKk
         Ai8/5eSXZZwFkLc2tPeORAodOZByYEVn2lAJNdOn2AWt290P6Ja/wIbeduN/TAJ+AR+t
         eqUntOIULGMNjEFoCS7uFwSr6Ip1Ctenia4KeYqNrVBwT3ovd2jIg4xKq4Yni5fHMJ+w
         2OQO4IaJ4B3p6GT01AM38CG7Z7QqZIwKy5YX1mo0rd2nIr0OruPHS/gFV7KzoqqGJKme
         x5KaFIXcEXuv9fq6120do5/PSgs+I6vMbfzixxgwIylaTXwk18AbIvVzdQXZT9vGotjw
         6YCw==
X-Gm-Message-State: AOJu0YzWrOa5PxGGoyhgMW7mSjGygSymWc5iNrA1KNiJ4oBIsNwkAeAt
        XV5KDiAaE+7gTJQWBRslUkrJm5vCUh7KSjWvG/WwX4/2DsLq
X-Google-Smtp-Source: AGHT+IEhcp5l2i8WgUpJ1EHup0vaggz04PpWnB2EqaDM7IawnhiuQQFer76lyPAtzsEFBYKLKQ3qW9ekdDC5s7sVaTC8Ff2+7FWp
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1818:b0:68a:6c69:2a8d with SMTP id
 y24-20020a056a00181800b0068a6c692a8dmr1707912pfa.3.1693623959375; Fri, 01 Sep
 2023 20:05:59 -0700 (PDT)
Date:   Fri, 01 Sep 2023 20:05:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b589e0604578e70@google.com>
Subject: [syzbot] [kernel?] general protection fault in tty_register_device_attr
From:   syzbot <syzbot+85792f3143e6271d2c97@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2ee82481c392 Add linux-next specific files for 20230828
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13da2cc0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=85792f3143e6271d2c97
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10124470680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a38ecba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30801702ce78/disk-2ee82481.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d9b67709145/vmlinux-2ee82481.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47f8ef9bffd0/bzImage-2ee82481.xz

The issue was bisected to:

commit d21fdd07cea418c0d98c8a15fc95b8b8970801e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Aug 17 09:12:21 2023 +0000

    driver core: Return proper error code when dev_set_name() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f0e057a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1008e057a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f0e057a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85792f3143e6271d2c97@syzkaller.appspotmail.com
Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")

Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff38fc4838 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fac9a3aed89
RDX: 0000000020000040 RSI: 00000000404c4701 RDI: 0000000000000004
RBP: 0000000000000001 R08: 00007fff38fc45d7 R09: 0000000000000003
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fff38fc4928
R13: 00007fac9a3f5032 R14: 00007fff38fc4980 R15: 0000000000000003
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5046 Comm: syz-executor362 Not tainted 6.5.0-next-20230828-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: a3 ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003a1f800 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90003a1f890 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003a1f890
R13: 0000000000000cc0 R14: ffff888014a96000 R15: 0000000000000001
FS:  0000555556b43480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005584fe812978 CR3: 00000000729c5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x290/0x1ac0 drivers/base/core.c:3560
 tty_register_device_attr+0x38f/0x7b0 drivers/tty/tty_io.c:3248
 gsm_register_devices drivers/tty/n_gsm.c:654 [inline]
 gsm_activate_mux+0x157/0x2d0 drivers/tty/n_gsm.c:3138
 gsm_config drivers/tty/n_gsm.c:3383 [inline]
 gsmld_ioctl+0x8cc/0x1550 drivers/tty/n_gsm.c:3786
 tty_ioctl+0x706/0x1580 drivers/tty/tty_io.c:2785
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fac9a3aed89
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff38fc4838 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fac9a3aed89
RDX: 0000000020000040 RSI: 00000000404c4701 RDI: 0000000000000004
RBP: 0000000000000001 R08: 00007fff38fc45d7 R09: 0000000000000003
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fff38fc4928
R13: 00007fac9a3f5032 R14: 00007fff38fc4980 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: a3 ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003a1f800 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90003a1f890 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003a1f890
R13: 0000000000000cc0 R14: ffff888014a96000 R15: 0000000000000001
FS:  0000555556b43480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005584fe812978 CR3: 00000000729c5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
* 2a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 c7 c1 b8 ff ff ff 	mov    $0xffffffffffffffb8,%rcx
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
