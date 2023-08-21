Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FF8782EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjHUQsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbjHUQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:48:05 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C4FB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:48:02 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68a3b41fa66so1850002b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636482; x=1693241282;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6avjvyZDjVCRKOfj/6cbcAUyMuDBKp30LSpGvu//wg=;
        b=K2zG95SdKnhyGRvAwe+PvSjV5T0HznJHgMFuB3gpYgQC9EDNwZIhvrq+76pFYDNEU1
         TxQ0zGKqt7F773PrEFeLLnUQF3nr/e4hvLlQYYVA9oTGgaXUJQfYw5CKS9UpXHFW7/Da
         Nm6NBGMQnIvMx/RDW+n6LPmLyIlQGDyVtOctX+p6r7Ge3scsbE5sgwPW5N4P+wwi70AQ
         ApK5jvH/vmpJXsWOcYmqBegYqSsezbE2KJIqrvK2BbUlxW3xJcO6MkeuKKBz7dMSnBES
         BkkzLGioVBQM6khj95U6Ux9Ku8h3josgaEfQ762+EeRGOu5pe/+KUvYUWAC6qWIqTfq4
         8p2Q==
X-Gm-Message-State: AOJu0YyXPhEno3OtnkrYmGFFB8iBfFueR5pgW/jVpRgUznmXUyuI2K7v
        9oy3P2nEh5midVabjKIs2Jc2g4JEFetgH+NJtFd2i1WH891m
X-Google-Smtp-Source: AGHT+IFhdmLZUVD+sMYSI3r6eU8dkdJUCwEZy/nD7+1BD1iKPKv2/irBsYknATITdC5fldU/xWpASGqWJKE0xDG7A+2y6vjpwzLv
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1348:b0:687:da95:a15c with SMTP id
 k8-20020a056a00134800b00687da95a15cmr4501711pfu.5.1692636481939; Mon, 21 Aug
 2023 09:48:01 -0700 (PDT)
Date:   Mon, 21 Aug 2023 09:48:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d73d3060371a47e@google.com>
Subject: [syzbot] [usb?] INFO: task hung in get_bMaxPacketSize0
From:   syzbot <syzbot+f7ac46d91cf13b4591a4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    7271b2a53042 Add linux-next specific files for 20230818
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10e05763a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=f7ac46d91cf13b4591a4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1085e265a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14290117a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81109bc02c1/disk-7271b2a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b3bf8e2a4f7/vmlinux-7271b2a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6404cd473c1e/bzImage-7271b2a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7ac46d91cf13b4591a4@syzkaller.appspotmail.com

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-next-20230818-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:26768 pid:9     ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 usb_kill_urb.part.0+0x1c6/0x250 drivers/usb/core/urb.c:713
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:702
 usb_start_wait_urb+0x251/0x4c0 drivers/usb/core/message.c:65
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x327/0x4a0 drivers/usb/core/message.c:154
 get_bMaxPacketSize0.constprop.0+0xa5/0x1c0 drivers/usb/core/hub.c:4725
 hub_port_init+0x680/0x3850 drivers/usb/core/hub.c:4921
 hub_port_connect drivers/usb/core/hub.c:5369 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2b64/0x4e00 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.5.0-rc6-next-20230818-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfac/0x1230 kernel/hung_task.c:379
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5041 Comm: strace-static-x Not tainted 6.5.0-rc6-next-20230818-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:wait_consider_task+0x94/0x4030 kernel/exit.c:1391
Code: c7 40 08 00 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 f0 00 00 00 31 c0 e8 67 da 38 00 4c 89 f8 48 c1 e8 03 0f b6 14 28 <4c> 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 d8 18 00 00 45
RSP: 0018:ffffc90003cdfb30 EFLAGS: 00000a06
RAX: 1ffff1100ddcfbcf RBX: ffffc90003cdfcf8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff814ef909 RDI: ffffc90003cdfcf8
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88806ee7d940 R14: 0000000000000000 R15: ffff88806ee7de78
FS:  0000000000ad73c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbbc40e6c00 CR3: 0000000027552000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 ptrace_do_wait kernel/exit.c:1514 [inline]
 do_wait+0x88c/0xc70 kernel/exit.c:1621
 kernel_wait4+0x16d/0x280 kernel/exit.c:1780
 __do_sys_wait4+0x15b/0x170 kernel/exit.c:1808
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4d6ad6
Code: 00 00 00 90 31 c9 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 14 48 89 74 24
RSP: 002b:00007fff4d5e5ec8 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004d6ad6
RDX: 0000000040000000 RSI: 00007fff4d5e5eec RDI: 00000000ffffffff
RBP: 0000000000000000 R08: 0000000000000017 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000add3f0
R13: 00007fff4d5e5eec R14: 0000000000ad8b90 R15: 000000000063f160
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.221 msecs


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
