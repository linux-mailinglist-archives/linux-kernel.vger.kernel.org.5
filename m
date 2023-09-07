Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59CD7975D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjIGP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbjIGP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:57:41 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FC6A5E5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:45:07 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1b88decb2a9so25941935ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694101433; x=1694706233;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fYI7PmTnEgN9yCnUp3BmYG5tudnSAWaoxtwrXZCFZM=;
        b=muae+KQr5cZ2KRVvtXU+oRYuSjAdKIHq2MIevqI4WMwCM4HEFCuCLfA9nX03FJCCmw
         MvfmksLFbpnSr8Da7g7rksjtEQMUT4ezvXdyRAQ4KeGldE2iLECon6csp585Jy/gTXn8
         BHdB05TkywugQW9tViwxPG2a4JawhA/K16Oask4giSM3r7GyzSEdcgahy3GIiiZdmcBQ
         Pa9uR75mT/c6NHBg1vr8YoCNLIS7UitwWUsRbLaek3h40az4STMEghElWZDuk5rsmkbr
         kr1ARjyvQVw0TmsnPfOLgUWZjmunveOA63R226hZdvXv9LmtHN+bBZ4pzkXmaTiCEsTL
         rp1w==
X-Gm-Message-State: AOJu0YzYQcfDIecH9xPYwi5Uifg3K3NBBoGKi1epe9I88YD3/SWPfkUi
        dxzxqgk5dirq7vwYMJUTvOPE5gCEflfZvn7cTsuTE0TOFKnw
X-Google-Smtp-Source: AGHT+IF7HFHTbVqi6Y7r1IGtZ2WiLiOnKY2f+pcruWampvw5hD+t3nubHvoy7kV2vecL9oVMaYPd+kBrSkToZYt748ARecSKUhwm
MIME-Version: 1.0
X-Received: by 2002:a17:902:e549:b0:1c1:df80:67ef with SMTP id
 n9-20020a170902e54900b001c1df8067efmr1021365plf.1.1694101433384; Thu, 07 Sep
 2023 08:43:53 -0700 (PDT)
Date:   Thu, 07 Sep 2023 08:43:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002683d00604c6bafe@google.com>
Subject: [syzbot] [kernel?] general protection fault in hci_register_dev
From:   syzbot <syzbot+410a8e33c6a740b40d51@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13585198680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
dashboard link: https://syzkaller.appspot.com/bug?extid=410a8e33c6a740b40d51
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14df7104680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125a5357a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee486d884228/disk-92901222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5187db0b1d1/vmlinux-92901222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/82c4e42d693e/bzImage-92901222.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+410a8e33c6a740b40d51@syzkaller.appspotmail.com

RBP: 0000000000000002 R08: 00007ffcb6e971b6 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffcb6e9742c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5034 Comm: syz-executor191 Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 01 ae f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc9000440fa90 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc9000440fb20 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc9000440fb20
R13: 0000000000000cc0 R14: ffff888020187f80 R15: 0000000000000001
FS:  00005555569f8380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13479ea6a4 CR3: 0000000020b59000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x290/0x1ac0 drivers/base/core.c:3560
 hci_register_dev+0x2f2/0xbc0 net/bluetooth/hci_core.c:2644
 hci_uart_register_dev drivers/bluetooth/hci_ldisc.c:688 [inline]
 hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:712 [inline]
 hci_uart_tty_ioctl+0x83e/0xc70 drivers/bluetooth/hci_ldisc.c:765
 tty_ioctl+0x6fd/0x1580 drivers/tty/tty_io.c:2785
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f134798cd39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcb6e97418 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffcb6e97430 RCX: 00007f134798cd39
RDX: 0000000000000000 RSI: 00000000400455c8 RDI: 0000000000000003
RBP: 0000000000000002 R08: 00007ffcb6e971b6 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffcb6e9742c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 01 ae f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc9000440fa90 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc9000440fb20 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc9000440fb20
R13: 0000000000000cc0 R14: ffff888020187f80 R15: 0000000000000001
FS:  00005555569f8380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13479ea6a4 CR3: 0000000020b59000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	01 ae f7 48 8b 74    	add    %ebp,0x748b48f7(%rsi)
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
