Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D56791220
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352401AbjIDH3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352387AbjIDH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:28:55 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6577D126
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:28:49 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68bec515fa9so1842093b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812529; x=1694417329;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvWUzXAfG4nFm7V4p+xZqGCZnwuAw9GxKxPXA4WyBaU=;
        b=ih5W2FRrXZYiU3Qbq0a8vu78tGeuwKtFHDPLQIAfW72XRED0ImgJOVQAACtkmwH8Od
         6Z3WwEteTtIIdnhxI63kfKM6fnOv1IXXJSUQizQsXSBPeLv+joUJ42XoQpFfAWnGhD9a
         DHqw8UQDKSAuwABn5kWcfx3V++y6GHwejxAlW29qGyBjtL9LcyhFCFDWQ7Q24huFeRMz
         aQN/St0NvuG/3nSOVuEn2O03QaVftlc3MnfZ/ccarPWRPheZOLeAdqEXnEjDxd2AnTgO
         6m1HokQ2Z2aamUOCSPtr5Ei8vtLgKkWbjlz4HkESZELtjvICJVE4S/gMSPp9mO4It8kR
         U/Eg==
X-Gm-Message-State: AOJu0Yz7lwpHmW3hefSRgyJJCGP+2cMXelpbn8qR3Iij+Urvrhr6yegb
        JeYNpnFV1b4GPy71HJEh2vL+jA4rkQqSRvek9rPBfhnmZfY9
X-Google-Smtp-Source: AGHT+IHot2R1AMyCwQBY0RXjlvJFtrSmUZUNSw7mF0cc/Wzx9Ofk1R2hvIG3fHoefXmKYpTXwlmieWtZYTHDC9FSXkhztTuHA/yb
MIME-Version: 1.0
X-Received: by 2002:aa7:8881:0:b0:68a:2c24:57d7 with SMTP id
 z1-20020aa78881000000b0068a2c2457d7mr4238320pfe.0.1693812528866; Mon, 04 Sep
 2023 00:28:48 -0700 (PDT)
Date:   Mon, 04 Sep 2023 00:28:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000196cf906048376d5@google.com>
Subject: [syzbot] [kernel?] general protection fault in evdev_connect
From:   syzbot <syzbot+f31b0633f7ca73e2d726@syzkaller.appspotmail.com>
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

HEAD commit:    b84acc11b1c9 Merge tag 'fbdev-for-6.6-rc1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=161ae177a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbe3c86253fd240a
dashboard link: https://syzkaller.appspot.com/bug?extid=f31b0633f7ca73e2d726
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146f7e70680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149489c0680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e001ebb73e5d/disk-b84acc11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/579905a03237/vmlinux-b84acc11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc5b290a4017/bzImage-b84acc11.xz

The issue was bisected to:

commit d21fdd07cea418c0d98c8a15fc95b8b8970801e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Aug 17 09:12:21 2023 +0000

    driver core: Return proper error code when dev_set_name() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15100848680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17100848680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13100848680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f31b0633f7ca73e2d726@syzkaller.appspotmail.com
Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")

RAX: ffffffffffffffda RBX: 00007fffff7eb6b0 RCX: 00007f9419218db9
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
RBP: 0000000000000002 R08: 00007fffff7eb436 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 00007fffff7eb6ac
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5036 Comm: syz-executor288 Not tainted 6.5.0-syzkaller-10204-gb84acc11b1c9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:strchr+0x21/0x90 lib/string.c:329
Code: 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 55 41 57 41 56 53 41 89 f6 48 89 fb 49 bf 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 4f 0f b6 03 44 38 f0 74 3d 48 8d 6b 01 84
RSP: 0018:ffffc90003aafa30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880268c0000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8abb6929 R09: 0000000000000000
R10: ffffc90003aafb20 R11: fffff52000755f67 R12: dffffc0000000000
R13: 1ffff11005956c27 R14: 0000000000000025 R15: dffffc0000000000
FS:  0000555555f39380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94192304ec CR3: 0000000078dde000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvasprintf_const+0x29/0x170 lib/kasprintf.c:45
 kobject_set_name_vargs+0x61/0x120 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x113/0x210 lib/kobject.c:424
 device_add+0x449/0xc90 drivers/base/core.c:3560
 cdev_device_add+0x1ec/0x3a0 fs/char_dev.c:556
 evdev_connect+0x349/0x3f0 drivers/input/evdev.c:1386
 input_attach_handler drivers/input/input.c:1064 [inline]
 input_register_device+0xcf0/0x1090 drivers/input/input.c:2396
 uinput_create_device+0x40e/0x620 drivers/input/misc/uinput.c:365
 uinput_ioctl_handler+0x48b/0x1770 drivers/input/misc/uinput.c:904
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9419218db9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffff7eb698 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fffff7eb6b0 RCX: 00007f9419218db9
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
RBP: 0000000000000002 R08: 00007fffff7eb436 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 00007fffff7eb6ac
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x21/0x90 lib/string.c:329
Code: 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 55 41 57 41 56 53 41 89 f6 48 89 fb 49 bf 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 4f 0f b6 03 44 38 f0 74 3d 48 8d 6b 01 84
RSP: 0018:ffffc90003aafa30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880268c0000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8abb6929 R09: 0000000000000000
R10: ffffc90003aafb20 R11: fffff52000755f67 R12: dffffc0000000000
R13: 1ffff11005956c27 R14: 0000000000000025 R15: dffffc0000000000
FS:  0000555555f39380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94192304ec CR3: 0000000078dde000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	0f 1f 40 00          	nopl   0x0(%rax)
   8:	f3 0f 1e fa          	endbr64
   c:	55                   	push   %rbp
   d:	41 57                	push   %r15
   f:	41 56                	push   %r14
  11:	53                   	push   %rbx
  12:	41 89 f6             	mov    %esi,%r14d
  15:	48 89 fb             	mov    %rdi,%rbx
  18:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  1f:	fc ff df
  22:	48 89 f8             	mov    %rdi,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 4f                	jne    0x81
  32:	0f b6 03             	movzbl (%rbx),%eax
  35:	44 38 f0             	cmp    %r14b,%al
  38:	74 3d                	je     0x77
  3a:	48 8d 6b 01          	lea    0x1(%rbx),%rbp
  3e:	84                   	.byte 0x84


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
