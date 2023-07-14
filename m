Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A6754508
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGNWkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGNWkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:40:06 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B530DB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:40:04 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3a1e58db5caso4268028b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689374404; x=1691966404;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llNDf15h0Ng/lAbxlfYqhFIc9QU2naRT7j7be5rEF/4=;
        b=QApivxJ2e3CMDZx2TnECURmCa1cMD0DnnQ965SsiDnwhTdfkjGs6C9W5xf7FBFMD3G
         DoJykOSUkgnJjssKzQxWO3ZMcdvd7e1r+r8/NbrNHafL+tRou/jo+x8/yNHYMxkWgUDg
         hdqB+vohlXq3Dkj+6BD+siSeIWt3CWqiQBbMW/NQDD2jnqWoNx5V5XHQGlhQhn6QSqdn
         oTFYBYEnJ3O/U/5Gcw88VX5NZKd1U5ZjZ5pqJUAHq4aPPLcywY4QjKL6jeAbe2IfYQRR
         oxOJlpMldm7iXaBEr9xy6jZovcK3W2tXaBGFCVGYCla/SW0XWuMY/xrgIPKtbxODuW3N
         V7dg==
X-Gm-Message-State: ABy/qLZmlrB0n893qc6D/kxB1F2ssYyhD1AaXnDHzMFXB2E9EpGlZNfA
        +3Dr+JDFxhoOVOiXpJ/oMt26UFMyHPCEXR4x92h2bQ5mptTs
X-Google-Smtp-Source: APBJJlFQ3P0JAhTaITjvkcNUEPadRNV7A2PcsUDTELFmB8eD6J0bNviY9pHIzqugKPl0xKcuwixpSGxXHUZAjhorsU/I8DkoCtUD
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2190:b0:3a4:1082:9e5 with SMTP id
 be16-20020a056808219000b003a4108209e5mr7585902oib.2.1689374404196; Fri, 14
 Jul 2023 15:40:04 -0700 (PDT)
Date:   Fri, 14 Jul 2023 15:40:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000413f1506007a2183@google.com>
Subject: [syzbot] [block?] WARNING in invalidate_drive
From:   syzbot <syzbot+3254e329ee1f252d4915@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13914acca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=3254e329ee1f252d4915
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed16bd50e54f/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2bda39f6b871/bzImage-3f01e9fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3254e329ee1f252d4915@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 7350 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 0 PID: 7350 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 0 PID: 7350 at drivers/block/floppy.c:999 invalidate_drive+0xf5/0x110 drivers/block/floppy.c:3217
Modules linked in:
CPU: 0 PID: 7350 Comm: syz-executor.0 Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:invalidate_drive+0xf5/0x110 drivers/block/floppy.c:3217
Code: 84 db 75 0a e8 0c 84 57 fc 31 c0 5b 5d c3 e8 02 84 57 fc 48 89 ef e8 ca e4 ff ff e8 f5 83 57 fc 31 c0 5b 5d c3 e8 eb 83 57 fc <0f> 0b eb 97 e8 92 b9 aa fc e9 29 ff ff ff 66 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc900289efa20 EFLAGS: 00010216
RAX: 000000000000073b RBX: 0000000000000001 RCX: ffffc9000d0d4000
RDX: 0000000000040000 RSI: ffffffff852d5dd5 RDI: 0000000000000001
RBP: ffff88801dd7e000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000249
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff88802c600000(0063) knlGS:00000000f7f4fb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7f46db0 CR3: 000000001c15c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fd_locked_ioctl+0xbaf/0x19f0 drivers/block/floppy.c:3508
 fd_ioctl drivers/block/floppy.c:3576 [inline]
 fd_compat_ioctl+0x8a8/0x1bd0 drivers/block/floppy.c:3890
 compat_blkdev_ioctl+0x329/0x7d0 block/ioctl.c:677
 __do_compat_sys_ioctl+0x25b/0x2b0 fs/ioctl.c:968
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f75579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f4f5cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000249
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
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
  2b:	c3                   	retq
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

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
