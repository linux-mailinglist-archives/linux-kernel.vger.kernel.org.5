Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87666776456
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHIPry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjHIPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:47:51 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751FF2111
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:47:50 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1bbf8cb6250so163875ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596070; x=1692200870;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTM/e7iCoxhRAcH3a8TX3wLUBL5+j62XjQUJA7cnbV4=;
        b=NN/b1yRTZBZ5sYmEC1ZDWiSsJZuDUMHvw2CmQHVREzwllNzdmW+xDt/l3zMB68ImvT
         lHDYb55ga0yegszIMyJNqurj7kFpUzOV+lbN/gymCnzc5YBC0wXxSTvVGEgQ3pZED74h
         4wPwD7OYWxD/0kLZ8UkhRu7oy0P3aT6DAy5np6kCwFMVvQ9T/7CfX+w1BsOxSVCBznNO
         J3NevWIdj+rBai9lLqVvUaBu37KMWsdVSEcD3cqUSWxRhd96QZOSQFekREugIrV2+Lhe
         cqpULwGhoAhcez0ajP/+FUAH1kMRvVKEHGIvEa+Da+5qTeD446lPF9EivtcWRhULHazy
         Gl4A==
X-Gm-Message-State: AOJu0YzguOhHQsaTMwN9WsYhF6YTW32YmAKDPDhIHHjx2xLY16QdQsAi
        47x9l56y4Sl7m6akueKNSBWyF4Adf2g9VDXxQT+UXGnJxZz2
X-Google-Smtp-Source: AGHT+IGEHGBBQOb6zEWgq5DeMw2XWkJ+8oDphJUhpUa+qAk+T7cAfyspjNVkc2ugllUIeVU7yP9cqYb6VoH94d7iRFggD0su1YDH
MIME-Version: 1.0
X-Received: by 2002:a17:902:fb03:b0:1b8:8c7:31e6 with SMTP id
 le3-20020a170902fb0300b001b808c731e6mr288723plb.1.1691596069965; Wed, 09 Aug
 2023 08:47:49 -0700 (PDT)
Date:   Wed, 09 Aug 2023 08:47:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da953306027f66bf@google.com>
Subject: [syzbot] [usb?] INFO: task hung in usbdev_release (2)
From:   syzbot <syzbot+bfa320b67fcbe2583c6f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    024ff300db33 Merge tag 'hyperv-fixes-signed-20230804' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a38679a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=bfa320b67fcbe2583c6f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16546d0da80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15eb1933a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b3c1c33ea305/disk-024ff300.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/558adc8f23ab/vmlinux-024ff300.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c2661f242bc/bzImage-024ff300.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfa320b67fcbe2583c6f@syzkaller.appspotmail.com

INFO: task syz-executor223:5058 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc4-syzkaller-00227-g024ff300db33 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor223 state:D stack:26464 pid:5058  ppid:5055   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6710
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x967/0x1340 kernel/locking/mutex.c:747
 device_lock include/linux/device.h:958 [inline]
 usbdev_release+0x87/0x4b0 drivers/usb/core/devio.c:1096
 __fput+0x3fd/0xac0 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3b1b87e0e0
RSP: 002b:00007fffd979ace8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f3b1b87e0e0
RDX: 0000000000000007 RSI: 00007fffd979a820 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000f4240
R13: 00007fffd979af98 R14: 0000000000000001 R15: 00007fffd979ad30
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c9a5970 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2c/0xe20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c9a5670 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2c/0xe20 kernel/rcu/tasks.h:522
5 locks held by kworker/1:1/26:
 #0: ffff888146644538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:20 [inline]
 #0: ffff888146644538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: raw_atomic64_set include/linux/atomic/atomic-arch-fallback.h:2608 [inline]
 #0: ffff888146644538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: raw_atomic_long_set include/linux/atomic/atomic-long.h:79 [inline]
 #0: ffff888146644538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:3196 [inline]
 #0: ffff888146644538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:675 [inline]
 #0: ffff888146644538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:702 [inline]
 #0: ffff888146644538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x96a/0x16f0 kernel/workqueue.c:2567
 #1: ffffc90000a1fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x99e/0x16f0 kernel/workqueue.c:2571
 #2: ffff888022b9c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:958 [inline]
 #2: ffff888022b9c190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c8/0x5230 drivers/usb/core/hub.c:5754
 #3: ffff888022bb0508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3162 [inline]
 #3: ffff888022bb0508 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5318 [inline]
 #3: ffff888022bb0508 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5566 [inline]
 #3: ffff888022bb0508 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5726 [inline]
 #3: ffff888022bb0508 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x2a54/0x5230 drivers/usb/core/hub.c:5808
 #4: ffff888022b5c168 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5319 [inline]
 #4: ffff888022b5c168 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5566 [inline]
 #4: ffff888022b5c168 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5726 [inline]
 #4: ffff888022b5c168 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x2a7d/0x5230 drivers/usb/core/hub.c:5808
1 lock held by khungtaskd/28:
 #0: ffffffff8c9a6580 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6615
1 lock held by klogd/4471:
 #0: ffff8880b993c3d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
2 locks held by getty/4782:
 #0: ffff88802cc8a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfcb/0x1480 drivers/tty/n_tty.c:2187
1 lock held by syz-executor223/5058:
 #0: ffff888022b9c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:958 [inline]
 #0: ffff888022b9c190 (&dev->mutex){....}-{3:3}, at: usbdev_release+0x87/0x4b0 drivers/usb/core/devio.c:1096

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc4-syzkaller-00227-g024ff300db33 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2ac/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf29/0x11b0 kernel/hung_task.c:379
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 76 Comm: kworker/u4:4 Not tainted 6.5.0-rc4-syzkaller-00227-g024ff300db33 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:26 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:67 [inline]
RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:103 [inline]
RIP: 0010:lock_is_held_type+0x55/0x140 kernel/locking/lockdep.c:5828
Code: d0 75 85 c0 0f 85 cb 00 00 00 65 4c 8b 24 25 80 b9 03 00 41 8b 94 24 c4 0a 00 00 85 d2 0f 85 b2 00 00 00 48 89 fd 41 89 f6 9c <8f> 04 24 fa 48 c7 c7 40 77 6c 8a 45 31 ff e8 18 10 00 00 41 8b 84
RSP: 0018:ffffc900015d7920 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 1ffff920002baf2f RCX: 0000000000000001
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffff8c9a64c0
RBP: ffffffff8c9a64c0 R08: ffffffff812ea95b R09: 0000000000000000
R10: ffffc900015d7b58 R11: 0000000000000000 R12: ffff888013758000
R13: 00000000ffffffff R14: 00000000ffffffff R15: ffffffff8c4149d0
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cc53cf2680 CR3: 000000000c776000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_is_held include/linux/lockdep.h:288 [inline]
 __might_resched+0x4cf/0x5e0 kernel/sched/core.c:10151
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0xee/0x1340 kernel/locking/mutex.c:747
 arch_jump_label_transform_queue+0x5b/0x100 arch/x86/kernel/jump_label.c:136
 __jump_label_update+0x125/0x420 kernel/jump_label.c:475
 jump_label_update+0x32e/0x410 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x154/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:836 [inline]
 toggle_allocation_gate+0x13f/0x250 mm/kfence/core.c:823
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x687/0x1110 kernel/workqueue.c:2748
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.912 msecs


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
