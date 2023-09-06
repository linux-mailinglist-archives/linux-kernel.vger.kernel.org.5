Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3600D793377
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjIFBsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjIFBsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:48:18 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAAC1BB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 18:48:15 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1bf703dd1c0so34447215ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 18:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693964894; x=1694569694;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAyPqUa5IKolOaOZR1BqOC8Rxom8X7Z09al7amuG2l0=;
        b=OUsFVfQ66rzmTzZQO4dkm3pETFWBYGO/eFyaXGEAuqF2Q8X+ZG7SFzO0Gr91MetM1M
         e6Pf8AeBYe6a5kCeEVjFxA3QUuMM+M1lp5YDVM4TkcOs+vDGyyZh41u1k84xmUugnYn8
         aaF1FW2zPZGp8FZBD1M3dOYV+6TtOj1Ql4YdHxUAuFo6yHy20YOf/BrnPzoBsckfvKiH
         2nbAcR216h/q+sYKjEgmpyS6mSY2p4nnXsjJtGmxQR8F4Zp9Cq5sUvHXXofgbEJKfzc2
         sMnM+tXZo+xi/yVjDB0SCoz//Zyy+GsHMATWxRxhDeqrSYj8dcD5BBXUXf8Mwp0Uldk/
         3XNA==
X-Gm-Message-State: AOJu0Ywk9ikYCdgq6oyoyPKzH6iPRT7NIJK5FxtKKnlQYRL0a6vEahDx
        nRdK9t0M+B3w0n2zMB5McNiWjkXbOPRGfGJrJBjYFoWl4CZJ
X-Google-Smtp-Source: AGHT+IEgta0iKJEK3KOWoySAx2oadmcFxT/NUhgBEyJZ+/GW8DF+aMtYb5lcDfk59Z8pjj1rtULJPk29fikevzRDq86f6YbGrUiX
MIME-Version: 1.0
X-Received: by 2002:a17:902:e88b:b0:1b8:8c7:31e6 with SMTP id
 w11-20020a170902e88b00b001b808c731e6mr4898108plg.1.1693964894750; Tue, 05 Sep
 2023 18:48:14 -0700 (PDT)
Date:   Tue, 05 Sep 2023 18:48:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d04ea90604a6efcc@google.com>
Subject: [syzbot] [kernel?] general protection fault in usb_hub_create_port_device
From:   syzbot <syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10e9af87a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3aba740d8a88ff1d
dashboard link: https://syzkaller.appspot.com/bug?extid=c063a4e176681d2e0380
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e4acdba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14eb56dba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b5634407855/disk-b84acc11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31f561af0e06/vmlinux-b84acc11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37275212826f/bzImage-b84acc11.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com

RSP: 002b:00007ffee900dd08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffee900dd20 RCX: 00007f3436e47b79
RDX: 0000000020000040 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 0000000000000002 R08: 00007ffee900daa6 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5032 Comm: syz-executor272 Not tainted 6.5.0-syzkaller-10204-gb84acc11b1c9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 31 af f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc9000431f5b8 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc9000431f648 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff8a60008b R12: ffffc9000431f648
R13: 0000000000000cc0 R14: ffff88802294d078 R15: 0000000000000001
FS:  00005555570f1380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cf9a73d2f8 CR3: 000000007c71a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x290/0x1ac0 drivers/base/core.c:3560
 usb_hub_create_port_device+0x3bb/0xe30 drivers/usb/core/port.c:713
 hub_configure drivers/usb/core/hub.c:1685 [inline]
 hub_probe+0x1e66/0x3070 drivers/usb/core/hub.c:1922
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 proc_ioctl+0x585/0x6a0 drivers/usb/core/devio.c:2365
 proc_ioctl_default drivers/usb/core/devio.c:2400 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2756 [inline]
 usbdev_ioctl+0x1650/0x3ca0 drivers/usb/core/devio.c:2816
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3436e47b79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee900dd08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffee900dd20 RCX: 00007f3436e47b79
RDX: 0000000020000040 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 0000000000000002 R08: 00007ffee900daa6 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 31 af f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc9000431f5b8 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc9000431f648 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff8a60008b R12: ffffc9000431f648
R13: 0000000000000cc0 R14: ffff88802294d078 R15: 0000000000000001
FS:  00005555570f1380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cf9a73d2f8 CR3: 000000007c71a000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	31 af f7 48 8b 74    	xor    %ebp,0x748b48f7(%rdi)
   6:	24 08                	and    $0x8,%al
   8:	48 8b 14 24          	mov    (%rsp),%rdx
   c:	eb 89                	jmp    0xffffff97
   e:	90                   	nop
   f:	f3 0f 1e fa          	endbr64
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	48 89 fa             	mov    %rdi,%rdx
  20:	55                   	push   %rbp
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	53                   	push   %rbx
  26:	48 83 ec 10          	sub    $0x10,%rsp
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 04                	jg     0x3c
  38:	84 c0                	test   %al,%al
  3a:	75 51                	jne    0x8d
  3c:	0f b6 07             	movzbl (%rdi),%eax
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
