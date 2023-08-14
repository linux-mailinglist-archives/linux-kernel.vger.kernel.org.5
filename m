Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6564F77B6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjHNK2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjHNK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:27:55 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70BB94
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:27:54 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-267f1559391so4601369a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008874; x=1692613674;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNa7ul5soS5E5SSXHyHYrSwZyKw8X9nA5eDMBKiCbHc=;
        b=YUlpYrosbiW+imGd5zEiK1ocBwCpfDZydCRM5nDHRrlpxrrx3U2Bb6csBNtgBfL8PT
         TGbCQ73VDlug7u328HwihusEDs6XgFC4MN/lUlBVs38w2KyIIeIpw8E2euJ+ekW/lqZ1
         bzvTHG24CdY+3S/GvJOPTU4XQo/LbN2lRQqPzYqNOUtjZMD8tYJaxhWFKtmoybmnqdPh
         LDQ+yTgOnmmq655YHunZHF4TV9yPCUJt+SqAgbAOfN6ym88OAbN5Yu9a8/1+I5vfqnJ4
         nPXoethXpXzGPlxRcLHk+NsGGNlyaNjP7LTh398DmWIBkeHteQC/O1V+nivf7j6SsAPI
         FFvg==
X-Gm-Message-State: AOJu0YwtivQ31lnnGjNYkb1R5v4VwJ0wcvNQaRQsCAIMDIIBFcfkHR7g
        XptNNRXozEoAwjROakmUBRII3KsDXT+fGrI2Tf6k93XCAc7C
X-Google-Smtp-Source: AGHT+IEDZrGV6OhGw6QnvghjwV21o3rOyHL3X2mw1zGWTHLitjJ+g2DN/kRoBEgs6GT450Fb1q5/+z1gkcXUro6voy6ZbNq+sL0R
MIME-Version: 1.0
X-Received: by 2002:a17:90a:e691:b0:26b:5c14:cedc with SMTP id
 s17-20020a17090ae69100b0026b5c14cedcmr462753pjy.1.1692008874384; Mon, 14 Aug
 2023 03:27:54 -0700 (PDT)
Date:   Mon, 14 Aug 2023 03:27:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea227d0602df83eb@google.com>
Subject: [syzbot] [block?] general protection fault in start_motor (3)
From:   syzbot <syzbot+1fad709a9a55674f0e0b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    2ccdd1b13c59 Linux 6.5-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138ad837a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fc59e2140295873
dashboard link: https://syzkaller.appspot.com/bug?extid=1fad709a9a55674f0e0b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c2b69a80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccdd1b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/421f85ee78b3/vmlinux-2ccdd1b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a52df43998f1/bzImage-2ccdd1b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fad709a9a55674f0e0b@syzkaller.appspotmail.com

floppy1: FDC access conflict!
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 12 Comm: kworker/u16:1 Not tainted 6.5.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:start_motor+0x3a/0x3e0 drivers/block/floppy.c:1905
Code: 08 e8 da 6d 50 fc 48 8b 1d 73 8c 0d 0d 48 b8 00 00 00 00 00 fc ff df 0f b6 2d c2 76 0d 0d 48 89 da 48 c1 ea 03 89 e9 41 89 ed <0f> b6 04 02 83 e1 03 41 83 e5 03 84 c0 74 08 3c 03 0f 8e a8 02 00
RSP: 0018:ffffc90000317c70 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8534b2e6 RDI: ffffffff8534e840
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8534e840
R13: 0000000000000001 R14: ffff88801cfc5000 R15: ffffffff8d6dffe0
FS:  0000000000000000(0000) GS:ffff88806b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f4f471c98 CR3: 00000000222a8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_ready+0x87/0x1b40 drivers/block/floppy.c:1932
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:start_motor+0x3a/0x3e0 drivers/block/floppy.c:1905
Code: 08 e8 da 6d 50 fc 48 8b 1d 73 8c 0d 0d 48 b8 00 00 00 00 00 fc ff df 0f b6 2d c2 76 0d 0d 48 89 da 48 c1 ea 03 89 e9 41 89 ed <0f> b6 04 02 83 e1 03 41 83 e5 03 84 c0 74 08 3c 03 0f 8e a8 02 00
RSP: 0018:ffffc90000317c70 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8534b2e6 RDI: ffffffff8534e840
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8534e840
R13: 0000000000000001 R14: ffff88801cfc5000 R15: ffffffff8d6dffe0
FS:  0000000000000000(0000) GS:ffff88806b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f4f471c98 CR3: 00000000222a8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 e8                	or     %ch,%al
   2:	da 6d 50             	fisubrl 0x50(%rbp)
   5:	fc                   	cld
   6:	48 8b 1d 73 8c 0d 0d 	mov    0xd0d8c73(%rip),%rbx        # 0xd0d8c80
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	0f b6 2d c2 76 0d 0d 	movzbl 0xd0d76c2(%rip),%ebp        # 0xd0d76e0
  1e:	48 89 da             	mov    %rbx,%rdx
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	89 e9                	mov    %ebp,%ecx
  27:	41 89 ed             	mov    %ebp,%r13d
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	83 e1 03             	and    $0x3,%ecx
  31:	41 83 e5 03          	and    $0x3,%r13d
  35:	84 c0                	test   %al,%al
  37:	74 08                	je     0x41
  39:	3c 03                	cmp    $0x3,%al
  3b:	0f                   	.byte 0xf
  3c:	8e                   	.byte 0x8e
  3d:	a8 02                	test   $0x2,%al


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
