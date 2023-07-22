Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69175DC6A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGVMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGVMQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:16:23 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C071E47
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:16:22 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3a3a8ceb0e3so6428104b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690028181; x=1690632981;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e71TWKKKeEQL3eVs2hsHyD+BVvXX/WdE+2bGmEBTckI=;
        b=aoOp4A/8rLXBxSHuhsR/0dZz3MKhALaPRwpHOJBtTU2Domb0GtsP7SNBetE9g2+5CV
         2vQPtsbU3MozXf5d8WSU2Cbr0ZLBqTCOv7GbbppNAF90kTfSjDxdJo2va94m94z+Imkq
         SJ68M/YdTrr6Vha0xzb79z+T7RdB9H3FEErTkZfVmSfiPb65xHG94srvrwNrgsC7GSzO
         K3RLyOmLufOYVhoDP/dXhPvD0fB+BmCa+bOj2qaHD56ecvIaxToj5gWmFypGv101tMKS
         TGhW3VFG8x9dHEN97wLP55Q57v/aHV3dIr8fcMRfdasfWAxFkzV/OxrovjHsEy1QihK1
         yb1Q==
X-Gm-Message-State: ABy/qLaMFttA9d7yIH0YF2Fgsbcl4Ov7wU+N2ilGkK5nOHhddqSY4CFE
        hTvHUzHWlb4fN4XOVX0hm9b4yFhHXVWY8HhkAcCsp9CHomq5
X-Google-Smtp-Source: APBJJlG1R3hDExLlzsxptSTu+v0O7K35Oa77mibaOC+L/oYvDjuMFamgrzVTa1l8uATnrGSCOefFNQ3ufbupdZT9diyCfRHEFfbw
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1817:b0:3a4:18d1:1638 with SMTP id
 bh23-20020a056808181700b003a418d11638mr9751640oib.5.1690028181841; Sat, 22
 Jul 2023 05:16:21 -0700 (PDT)
Date:   Sat, 22 Jul 2023 05:16:21 -0700
In-Reply-To: <0000000000009e2dd805ffc595a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000706b5c0601125945@google.com>
Subject: Re: [syzbot] [serial?] general protection fault in serial8250_tx_chars
From:   syzbot <syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    d192f5382581 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d03ff4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e4fe52a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/517e5a5be15c/disk-d192f538.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/59d41b43c30c/vmlinux-d192f538.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99ed26179ccf/bzImage-d192f538.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5137 Comm: kworker/0:4 Not tainted 6.5.0-rc2-syzkaller-00307-gd192f5382581 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Workqueue: pm pm_runtime_work
RIP: 0010:serial8250_tx_chars+0x299/0x8b0 drivers/tty/serial/8250/8250_port.c:1813
Code: 8d cc 25 fd 48 8b 2b 48 8b 44 24 20 42 0f b6 04 38 84 c0 0f 85 8f 02 00 00 48 8b 04 24 48 63 00 48 01 c5 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 91 02 00 00 0f b6 6d 00 48 8b 44 24 60
RSP: 0018:ffffc9000432f8b0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88801f490fd0 RCX: 1ffffffff246641b
RDX: 1ffffffff2466465 RSI: 0000000000000000 RDI: ffffffff92332330
RBP: 0000000000000000 R08: ffffffff84bef450 R09: fffff52000865f10
R10: dffffc0000000000 R11: fffff52000865f10 R12: 0000000000000010
R13: ffffffff92332180 R14: ffffffff92332080 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555c2f938 CR3: 000000002b259000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __start_tx+0x312/0x450 drivers/tty/serial/8250/8250_port.c:1547
 serial_port_runtime_resume+0x1ec/0x2a0 drivers/tty/serial/serial_port.c:40
 __rpm_callback+0x2b9/0x7a0 drivers/base/power/runtime.c:392
 rpm_callback drivers/base/power/runtime.c:446 [inline]
 rpm_resume+0x10b1/0x1af0 drivers/base/power/runtime.c:912
 pm_runtime_work+0x147/0x210 drivers/base/power/runtime.c:977
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:serial8250_tx_chars+0x299/0x8b0 drivers/tty/serial/8250/8250_port.c:1813
Code: 8d cc 25 fd 48 8b 2b 48 8b 44 24 20 42 0f b6 04 38 84 c0 0f 85 8f 02 00 00 48 8b 04 24 48 63 00 48 01 c5 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 91 02 00 00 0f b6 6d 00 48 8b 44 24 60
RSP: 0018:ffffc9000432f8b0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88801f490fd0 RCX: 1ffffffff246641b
RDX: 1ffffffff2466465 RSI: 0000000000000000 RDI: ffffffff92332330
RBP: 0000000000000000 R08: ffffffff84bef450 R09: fffff52000865f10
R10: dffffc0000000000 R11: fffff52000865f10 R12: 0000000000000010
R13: ffffffff92332180 R14: ffffffff92332080 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000002b259000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	cc                   	int3
   1:	25 fd 48 8b 2b       	and    $0x2b8b48fd,%eax
   6:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   b:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax
  10:	84 c0                	test   %al,%al
  12:	0f 85 8f 02 00 00    	jne    0x2a7
  18:	48 8b 04 24          	mov    (%rsp),%rax
  1c:	48 63 00             	movslq (%rax),%rax
  1f:	48 01 c5             	add    %rax,%rbp
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 91 02 00 00    	jne    0x2c7
  36:	0f b6 6d 00          	movzbl 0x0(%rbp),%ebp
  3a:	48 8b 44 24 60       	mov    0x60(%rsp),%rax


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
