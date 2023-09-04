Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE979122E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352450AbjIDHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352444AbjIDHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:30:13 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E5FCE3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:29:53 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-68bee35afe0so1156348b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812593; x=1694417393;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnTFgKlrZ/bw5fT+AFNAKL5xSFn0oeyvdCefjBq5gos=;
        b=Nr5+y+/ilawdk/xm1LuIqDzMXderfvajjNQeEaKmX84QSiyN2eOI4aE9UVBeXbguCQ
         664eQvIz75/N88y7iYMhg3VKzlzWqr9IcGzjQ4xZBmEc9s2LOjNzlirWznp2XtTJ7cWb
         6OsT/02jseTsf3N2pjtQb8UcSCTEsAC12u1iaVcoPULAMEVyxvkPJwXSQ4iVsosX4djI
         kYYAsh+AdCnd52Wr1Gvu6XMMuKQAUOlHQOVu0Iwj9riIlzAuMSzHtwU0Yy6NT4TUJX5T
         i449C7E1xbkrrCkZP7WFIWf52xUMQz3Bi7A7U4qUYWQQ1F5YB3xPFTqIGNZEet1LJ9v6
         vEPg==
X-Gm-Message-State: AOJu0YyQ8nMtGvWpIkg2OZb7KQlHYvbWMZYD46b/956VRfu/aabpAbiB
        9+tGaK7iD+o490EO5QKRSxd3I4t7MQv+yjodNAfpJ5yUh+wS
X-Google-Smtp-Source: AGHT+IGNdfERNjAijg9uzJibkGPzm6BMXnzxL8+4OzDJGtA7bFMxAz9oDtSRODbO3X9RsOSDWcREmJOPGsAM493uL+5C1E2Vg1+q
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:22c9:b0:68b:ee34:972f with SMTP id
 f9-20020a056a0022c900b0068bee34972fmr3885347pfj.5.1693812593120; Mon, 04 Sep
 2023 00:29:53 -0700 (PDT)
Date:   Mon, 04 Sep 2023 00:29:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eddce70604837929@google.com>
Subject: [syzbot] [kernel?] general protection fault in loop_add
From:   syzbot <syzbot+24adf36b9fdc6531990f@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126f7104680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
dashboard link: https://syzkaller.appspot.com/bug?extid=24adf36b9fdc6531990f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162c4cd0680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1271eb2fa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04bb6c9609f2/disk-92901222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99fe68c63200/vmlinux-92901222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/819e0d3f2de3/bzImage-92901222.xz

The issue was bisected to:

commit d21fdd07cea418c0d98c8a15fc95b8b8970801e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Aug 17 09:12:21 2023 +0000

    driver core: Return proper error code when dev_set_name() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173bdf7ba80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14bbdf7ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10bbdf7ba80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24adf36b9fdc6531990f@syzkaller.appspotmail.com
Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")

Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe7399c EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000004c80
RDX: 0000000099999999 RSI: 0000000000000006 RDI: 0000000000000000
RBP: 00000000000110e3 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5039 Comm: syz-executor104 Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 01 ae f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003c77b40 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90003c77bd0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003c77bd0
R13: 0000000000000cc0 R14: ffff888014b88200 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0063) knlGS:0000000057b48380
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007ffd37f99fd8 CR3: 0000000074d36000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x290/0x1ac0 drivers/base/core.c:3560
 device_add_disk+0x42a/0x11f0 block/genhd.c:456
 add_disk include/linux/blkdev.h:735 [inline]
 loop_add+0x87f/0xaf0 drivers/block/loop.c:2087
 loop_control_ioctl+0x13a/0x630 drivers/block/loop.c:2210
 __do_compat_sys_ioctl+0x2bf/0x330 fs/ioctl.c:972
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7e62579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe7399c EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000004c80
RDX: 0000000099999999 RSI: 0000000000000006 RDI: 0000000000000000
RBP: 00000000000110e3 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 01 ae f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003c77b40 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90003c77bd0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003c77bd0
R13: 0000000000000cc0 R14: ffff888014b88200 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9900000(0063) knlGS:0000000057b48380
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000055676ffba0b8 CR3: 0000000074d36000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
