Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110AA7AC5CE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjIWXCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 19:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjIWXCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 19:02:43 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF64127
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 16:02:36 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6c46baafe2dso8042680a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 16:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695510156; x=1696114956;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtZE/pXNiesxk6F1Xj3U/SZyn05+QOteBIIWrsU6Aig=;
        b=HLz1DyXGc1nBQfc7Cfa6n5A6dBH+c301fv1xrXiB1KZoNLEcQmnaQgqA/PC9psK7nE
         IKGltu6fWmZm3tVXVORCXxnssnwirp9Dmz3UxRZOxXzcFbFGSnXHb2WxWGGwb62Z3Ras
         C8bKWdJDYwlI75NV9S8aqwBxh4iuXjuLes1DMlVjvqQ9++3E3iK+4TeYSxQ1o+WI9I/1
         4qd5Cz34CectUnWhynsYN0N4Psj+MHj17Jf7abXnT5ppFvgPU5VDxOygmqV+tVfahMie
         ooi534+4ACrum40zpuD+J5ZTo5RULtB6lD73gmMhIUBiqQ7IvtxwNA6RLosjn6LQNXey
         wkIw==
X-Gm-Message-State: AOJu0YwtROQljvz99dxaKiI+mKagIQ2szZua1PWk9f7dg+RVn9ZKSXME
        HKavwJTjOKFCyTOZ72wPMIMH3CTmbQosUdi+TSkNc6BdZLsE
X-Google-Smtp-Source: AGHT+IET4Tu6XbuFtzJke/FPwhybfzOWbIkftdWhECreusTvkGKw3mS7VvluRdFANhScJa6DWRT7BMbfZp7BjR+ZL+n//j3fuBs6
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1e69:b0:6ba:8e4a:8e62 with SMTP id
 m9-20020a0568301e6900b006ba8e4a8e62mr1250236otr.7.1695510155876; Sat, 23 Sep
 2023 16:02:35 -0700 (PDT)
Date:   Sat, 23 Sep 2023 16:02:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dded106060eb81a@google.com>
Subject: [syzbot] [serial?] INFO: task hung in console_callback (4)
From:   syzbot <syzbot+fe9e847f8a1d979468f2@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
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

HEAD commit:    ce9ecca0238b Linux 6.6-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15c0df5a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59eae8406319284a
dashboard link: https://syzkaller.appspot.com/bug?extid=fe9e847f8a1d979468f2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a503493dab8/disk-ce9ecca0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0265acc85204/vmlinux-ce9ecca0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4861e26a08d/bzImage-ce9ecca0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe9e847f8a1d979468f2@syzkaller.appspotmail.com

INFO: task kworker/0:2:28429 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:22784 pid:28429 ppid:2      flags:0x00004000
Workqueue: events console_callback

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_timeout+0x278/0x2c0 kernel/time/timer.c:2143
 ___down_common kernel/locking/semaphore.c:225 [inline]
 __down_common+0x327/0x6c0 kernel/locking/semaphore.c:246
 down+0x74/0xa0 kernel/locking/semaphore.c:63
 console_lock+0x96/0x150 kernel/printk/printk.c:2652
 console_callback+0x63/0x4c0 drivers/tty/vt/vt.c:2933
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u4:0/11:
1 lock held by khungtaskd/29:
 #0: ffffffff87eac820 (rcu_read_lock
){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:749 [inline]
){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by getty/2443:
 #0: ffff88810c3020a0 (
&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc5/0x1480 drivers/tty/n_tty.c:2206
3 locks held by kworker/1:0/12460:
 #0: ffff88810aa6d138 ((wq_completion)usb_hub_wq
){+.+.}-{0:0}, at: process_one_work+0x787/0x15c0 kernel/workqueue.c:2605
 #1: ffffc90002e6fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7e9/0x15c0 kernel/workqueue.c:2606
 #2: ffff88810634e190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
 #2: ffff88810634e190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f30 drivers/usb/core/hub.c:5768
3 locks held by kworker/0:1/14506:
2 locks held by kworker/0:2/28429:
 #0: ffff888100070d38 ((wq_completion)events){+.+.}-{0:0}
, at: process_one_work+0x787/0x15c0 kernel/workqueue.c:2605
 #1: ffffc9000ee27d80 (console_work){+.+.}-{0:0}, at: process_one_work+0x7e9/0x15c0 kernel/workqueue.c:2606
6 locks held by kworker/1:10/31385:
 #0: 
ffff88810aa6d138
 (
(wq_completion)usb_hub_wq){+.+.}-{0:0}
, at: process_one_work+0x787/0x15c0 kernel/workqueue.c:2605
 #1: ffffc90010b4fd80
 (
(work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7e9/0x15c0 kernel/workqueue.c:2606
 #2: ffff88810676e190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
 #2: ffff88810676e190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f30 drivers/usb/core/hub.c:5768
 #3: ffff888106779500 (&port_dev->status_lock){+.+.}-{3:3}
, at: usb_lock_port drivers/usb/core/hub.c:3138 [inline]
, at: hub_port_connect drivers/usb/core/hub.c:5337 [inline]
, at: hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
, at: port_event drivers/usb/core/hub.c:5740 [inline]
, at: hub_event+0x28b4/0x4f30 drivers/usb/core/hub.c:5822
 #4: ffff888103fa3d68
 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5338 [inline]
 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5740 [inline]
 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x28da/0x4f30 drivers/usb/core/hub.c:5822
 #5: ffff8881f673b558 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:558 [inline]
 #5: ffff8881f673b558 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1372 [inline]
 #5: ffff8881f673b558 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1681 [inline]
 #5: ffff8881f673b558 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x290/0x30a0 kernel/sched/core.c:6612
5 locks held by kworker/0:12/963:
3 locks held by kworker/0:13/972:
4 locks held by kworker/0:10/3172:
 #0: ffff88810aa6d138
 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x787/0x15c0 kernel/workqueue.c:2605
 #1: ffffc9000f70fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7e9/0x15c0 kernel/workqueue.c:2606
 #2: ffff888106366190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
 #2: ffff888106366190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f30 drivers/usb/core/hub.c:5768
 #3: 
ffff88811b843190 (&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: usb_remote_wakeup+0x21/0xe0 drivers/usb/core/hub.c:3772
5 locks held by syz-executor.5/4757:
1 lock held by syz-executor.4/4778:
1 lock held by syz-executor.0/4781:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x26c/0x2d0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6142 Comm: kworker/1:8 Not tainted 6.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Workqueue: events legacy_dvb_usb_read_remote_control
RIP: 0010:check_region_inline mm/kasan/generic.c:167 [inline]
RIP: 0010:kasan_check_range+0x14c/0x190 mm/kasan/generic.c:187
Code: c0 01 49 89 d3 48 39 d0 74 11 80 38 00 74 ef 4d 8d 1c 2c 48 85 c0 48 89 c2 75 97 48 89 da 4c 89 d8 4c 29 da e9 30 ff ff ff 5b <b8> 01 00 00 00 5d 41 5c c3 b8 01 00 00 00 c3 48 29 c3 48 89 da 49
RSP: 0018:ffffc9000d7df670 EFLAGS: 00000046
RAX: fffffbfff16de139 RBX: 000000000000000e RCX: ffffffff812e172f
RDX: fffffbfff16de139 RSI: 0000000000000008 RDI: ffffffff8b6f09c0
RBP: fffffbfff16de138 R08: 0000000000000000 R09: fffffbfff16de138
R10: ffffffff8b6f09c7 R11: 205d323431365420 R12: ffff888115b68b42
R13: ffff888115b68b20 R14: 00000000373b5825 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f72ede41070 CR3: 000000013ea4b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class kernel/locking/lockdep.c:228 [inline]
 __lock_acquire+0xc8f/0x5de0 kernel/locking/lockdep.c:5133
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 console_lock_spinning_enable kernel/printk/printk.c:1858 [inline]
 console_emit_next_record kernel/printk/printk.c:2904 [inline]
 console_flush_all+0x4c1/0xfb0 kernel/printk/printk.c:2966
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 m920x_read drivers/media/usb/dvb-usb/m920x.c:40 [inline]
 m920x_rc_query+0x496/0x760 drivers/media/usb/dvb-usb/m920x.c:193
 legacy_dvb_usb_read_remote_control+0x107/0x4f0 drivers/media/usb/dvb-usb/dvb-usb-remote.c:123
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
