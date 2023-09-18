Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5457A4A09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbjIRMrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242002AbjIRMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:47:09 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB25A19A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:45:10 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1d661636928so4900881fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041110; x=1695645910;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hyzj3FkxBbOiRHmAOVfINvVoKVwl9VBEYfs9pGw5B/Q=;
        b=qjtc0QuhTL4z9U+0PolwvAm1qLMR0NT5ru8M5Vf5IU4jDzqpNZnE8qhoHAhuPZVCH+
         yTmqzO5OdM5Wr4WfxotT2MzjnBo02VSJTRYs2+8pQGOaaKueSfONsSHS7hlDb65v2XV7
         CZ4WnfMPVSufHo3EqJf4KeXad0GFTuinp1lMgQLgOHRAasQnPpJ1g2FhmmKfnM2siy/k
         DXeCyuQMqxx/hNdwJUW1DaIXqAJVOs0ZL3wDfQmi4xQuN+r5a+ZQZuanJR3KM4TteGJ+
         gk4iI9I3cNYIt9DxV8X1uJhSIyDFrL3CGyvag33E1OaF7E1hBi/QapIXBqsm4YI39geu
         WEmw==
X-Gm-Message-State: AOJu0YwwQSg5QrmgMqaLaXOnm09l7porDDLNIlM2vxypSYFz3h10OVPr
        aDM5hlkgEw5hOEkNrZOAG9S4CvORl8JHuEN/LLou9ZFoUDyx
X-Google-Smtp-Source: AGHT+IGYjjxJh9ClSXuBeLaKnpHYN/mxQQHtqswV/ryuqOMN33TRH8+qOLUlo64/Wi0t0LlMCpCKZOM3Fi/azghJ02trgQE6+VCS
MIME-Version: 1.0
X-Received: by 2002:a05:6870:98ac:b0:1d6:cf21:44c1 with SMTP id
 eg44-20020a05687098ac00b001d6cf2144c1mr1896501oab.9.1695041109974; Mon, 18
 Sep 2023 05:45:09 -0700 (PDT)
Date:   Mon, 18 Sep 2023 05:45:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d63410605a18363@google.com>
Subject: [syzbot] [input?] INFO: task hung in __input_unregister_device (5)
From:   syzbot <syzbot+78e2288f58b881ed3c45@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    0bb80ecc33a8 Linux 6.6-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=146fd272680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13b8d0222a8e5a19
dashboard link: https://syzkaller.appspot.com/bug?extid=78e2288f58b881ed3c45
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151e9d62680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17971b44680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a5fdb25d37ac/disk-0bb80ecc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc964206a779/vmlinux-0bb80ecc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/541dfc8b614c/bzImage-0bb80ecc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78e2288f58b881ed3c45@syzkaller.appspotmail.com

INFO: task kworker/1:0:22 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D
 stack:22752 pid:22    ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x967/0x1340 kernel/locking/mutex.c:747
 __input_unregister_device+0x136/0x450 drivers/input/input.c:2219
 input_unregister_device+0xb9/0x100 drivers/input/input.c:2440
 hidinput_disconnect+0x160/0x3e0 drivers/hid/hid-input.c:2386
 hid_disconnect+0x143/0x1b0 drivers/hid/hid-core.c:2273
 hid_hw_stop drivers/hid/hid-core.c:2322 [inline]
 hid_device_remove+0x1a5/0x250 drivers/hid/hid-core.c:2684
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3811
 hid_remove_device drivers/hid/hid-core.c:2859 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2879
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1456
 usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3811
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x890 drivers/usb/core/hub.c:2252
 hub_port_connect drivers/usb/core/hub.c:5280 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x1be0/0x4f30 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: task jbd2/sda1-8:2348 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda1-8     state:D stack:26656 pid:2348  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 io_schedule+0xbe/0x130 kernel/sched/core.c:9026
 bit_wait_io+0x16/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x62/0x170 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xdb/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 __wait_on_buffer+0x64/0x70 fs/buffer.c:123
 wait_on_buffer include/linux/buffer_head.h:370 [inline]
 journal_wait_on_commit_record fs/jbd2/commit.c:171 [inline]
 jbd2_journal_commit_transaction+0x4885/0x63d0 fs/jbd2/commit.c:890
 kjournald2+0x1fb/0x900 fs/jbd2/journal.c:201
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: task udevd:2385 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:26672 pid:2385  ppid:1      flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x625/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1522
 kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
 d_revalidate fs/namei.c:861 [inline]
 d_revalidate fs/namei.c:858 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1654
 walk_component+0x5b/0x5a0 fs/namei.c:1997
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2328
 link_path_walk fs/namei.c:2253 [inline]
 path_openat+0x231/0x29c0 fs/namei.c:3792
 do_filp_open+0x1de/0x430 fs/namei.c:3823
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff1d282a9a4
RSP: 002b:00007ffc58f5b980 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007ff1d282a9a4
RDX: 0000000000080000 RSI: 00007ffc58f5bab8 RDI: 00000000ffffff9c
RBP: 00007ffc58f5bab8 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055dec8f90b42 R14: 0000000000000001 R15: 0000000000000000
 </TASK>
INFO: task udevd:2500 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:27568 pid:2500  ppid:2385   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x625/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1522
 kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
 d_revalidate fs/namei.c:861 [inline]
 d_revalidate fs/namei.c:858 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1654
 walk_component+0x5b/0x5a0 fs/namei.c:1997
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2328
 link_path_walk fs/namei.c:2252 [inline]
 path_lookupat+0x93/0x770 fs/namei.c:2481
 filename_lookup+0x1e7/0x5b0 fs/namei.c:2511
 vfs_statx+0x160/0x430 fs/stat.c:277
 vfs_fstatat+0xb3/0x140 fs/stat.c:332
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:502
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff1d282a5f4
RSP: 002b:00007ffc58f59b38 EFLAGS: 00000206
 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 000055decac27a40 RCX: 00007ff1d282a5f4
RDX: 00007ffc58f59b48 RSI: 00007ffc58f59bd8 RDI: 00000000ffffff9c
RBP: 000055decac3d3df R08: 000055decac3d3df R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 0000000000000000
R13: 000055decac27b30 R14: 00007ffc58f59bd8 R15: 000055dec8f91a04
 </TASK>
INFO: task kworker/1:3:2503 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:22416 pid:2503  ppid:2      flags:0x00004000
Workqueue: events console_callback

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_timeout+0x27a/0x2c0 kernel/time/timer.c:2143
 ___down_common kernel/locking/semaphore.c:225 [inline]
 __down_common+0x328/0x6c0 kernel/locking/semaphore.c:246
 down+0x74/0xa0 kernel/locking/semaphore.c:63
 console_lock+0x96/0x150 kernel/printk/printk.c:2652
 console_callback+0x63/0x4c0 drivers/tty/vt/vt.c:2933
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: task udevd:2507 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:27712 pid:2507  ppid:2385   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x625/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1522
 kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
 d_revalidate fs/namei.c:861 [inline]
 d_revalidate fs/namei.c:858 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1654
 walk_component+0x5b/0x5a0 fs/namei.c:1997
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2328
 link_path_walk fs/namei.c:2252 [inline]
 path_lookupat+0x93/0x770 fs/namei.c:2481
 filename_lookup+0x1e7/0x5b0 fs/namei.c:2511
 vfs_statx+0x160/0x430 fs/stat.c:277
 vfs_fstatat+0xb3/0x140 fs/stat.c:332
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:502
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff1d282a5f4
RSP: 002b:00007ffc58f58e98 EFLAGS: 00000206
 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 000055decac14d40 RCX: 00007ff1d282a5f4
RDX: 00007ffc58f58ea8 RSI: 00007ffc58f58f38 RDI: 00000000ffffff9c
RBP: 00007ffc58f5a390 R08: 00007ffc58f5a390 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 0000000000000000
R13: 000055decac14e30 R14: 00007ffc58f58f38 R15: 0000000000000001
 </TASK>
INFO: task udevd:2508 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:26768 pid:2508  ppid:2385   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x625/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1522
 kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
 d_revalidate fs/namei.c:861 [inline]
 d_revalidate fs/namei.c:858 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1654
 walk_component+0x5b/0x5a0 fs/namei.c:1997
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2328
 link_path_walk fs/namei.c:2252 [inline]
 path_lookupat+0x93/0x770 fs/namei.c:2481
 filename_lookup+0x1e7/0x5b0 fs/namei.c:2511
 vfs_statx+0x160/0x430 fs/stat.c:277
 vfs_fstatat+0xb3/0x140 fs/stat.c:332
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:502
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff1d282a5f4
RSP: 002b:00007ffc58f59b38 EFLAGS: 00000206
 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 000055decac33730 RCX: 00007ff1d282a5f4
RDX: 00007ffc58f59b48 RSI: 00007ffc58f59bd8 RDI: 00000000ffffff9c
RBP: 000055decac3dcbb R08: 000055decac3dcbb R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 0000000000000000
R13: 000055decac33820 R14: 00007ffc58f59bd8 R15: 000055dec8f91a04
 </TASK>
INFO: task kworker/0:6:2525 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:6     state:D
 stack:22912 pid:2525  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x625/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1522
 kernfs_find_and_get_ns+0x71/0xc0 fs/kernfs/dir.c:897
 kernfs_find_and_get include/linux/kernfs.h:601 [inline]
 sysfs_unmerge_group+0x61/0x170 fs/sysfs/group.c:369
 dpm_sysfs_remove+0x68/0xb0 drivers/base/power/sysfs.c:833
 device_del+0x1a8/0xa50 drivers/base/core.c:3786
 device_unregister+0x1d/0xc0 drivers/base/core.c:3852
 usb_remove_ep_devs+0x42/0x80 drivers/usb/core/endpoint.c:188
 remove_intf_ep_devs drivers/usb/core/message.c:1264 [inline]
 usb_disable_device+0x322/0x7f0 drivers/usb/core/message.c:1415
 usb_disconnect+0x2e1/0x890 drivers/usb/core/hub.c:2252
 hub_port_connect drivers/usb/core/hub.c:5280 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x1be0/0x4f30 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: task udevd:2537 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:27712 pid:2537  ppid:2385   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x625/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1522
 kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
 d_revalidate fs/namei.c:861 [inline]
 d_revalidate fs/namei.c:858 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1654
 walk_component+0x5b/0x5a0 fs/namei.c:1997
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2328
 link_path_walk fs/namei.c:2252 [inline]
 path_lookupat+0x93/0x770 fs/namei.c:2481
 filename_lookup+0x1e7/0x5b0 fs/namei.c:2511
 user_path_at_empty+0x42/0x60 fs/namei.c:2910
 do_readlinkat+0xdd/0x2f0 fs/stat.c:533
 __do_sys_readlink fs/stat.c:566 [inline]
 __se_sys_readlink fs/stat.c:563 [inline]
 __x64_sys_readlink+0x78/0xb0 fs/stat.c:563
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff1d282bd47
RSP: 002b:00007ffc58f59a48 EFLAGS: 00000246
 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 00007ffc58f59a58 RCX: 00007ff1d282bd47
RDX: 0000000000000400 RSI: 00007ffc58f59a58 RDI: 00007ffc58f59f38
RBP: 0000000000000400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000246 R12: 00007ffc58f59f38
R13: 00007ffc58f59ea8 R14: 000055decac14910 R15: 00007ffc58f5b049
 </TASK>
INFO: task syz-executor212:2596 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor212 state:D stack:28864 pid:2596  ppid:2487   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_write_slowpath+0x53e/0x1290 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d3/0x200 kernel/locking/rwsem.c:1574
 kernfs_add_one+0xb1/0x510 fs/kernfs/dir.c:757
 kernfs_create_dir_ns+0x181/0x210 fs/kernfs/dir.c:1050
 sysfs_create_dir_ns+0x13b/0x2a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x2c8/0x960 lib/kobject.c:238
 kobject_add_varg lib/kobject.c:372 [inline]
 kobject_init_and_add+0x11c/0x190 lib/kobject.c:455
 bus_add_driver+0x186/0x630 drivers/base/bus.c:666
 driver_register+0x15c/0x4a0 drivers/base/driver.c:246
 usb_gadget_register_driver_owner+0xfd/0x2d0 drivers/usb/gadget/udc/core.c:1674
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:548 [inline]
 raw_ioctl+0x172f/0x2b80 drivers/usb/gadget/legacy/raw_gadget.c:1255
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff0f81f082b
RSP: 002b:00007ffdd1f948b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff0f81f082b
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
RBP: 00007ffdd1f95970 R08: 0000000000000010 R09: 00312e6364755f79
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdd1f94940 R14: 00007ffdd1f969e0 R15: 00007ff0f82693c0
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
7 locks held by kworker/0:0/8:
 #0: ffff88810aa6dd38 ((wq_completion)usb_hub_wq
){+.+.}-{0:0}, at: process_one_work+0x774/0x15d0 kernel/workqueue.c:2602
 #1: ffffc9000008fd88 ((work_completion)(&hub->events)){+.+.}-{0:0}
, at: process_one_work+0x7a7/0x15d0 kernel/workqueue.c:2605
 #2: ffff888106335190 (
&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: hub_event+0x1be/0x4f30 drivers/usb/core/hub.c:5768
 #3: ffff88811bed8190 (&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88811bfbd160 (&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: 
ffff88811d4b1a20 (&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #6: ffffffff88aa3328
 (input_mutex
){+.+.}-{3:3}
, at: input_register_device+0xa27/0x1130 drivers/input/input.c:2389
7 locks held by kworker/1:0/22:
 #0: 
ffff88810aa6dd38 ((wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work+0x774/0x15d0 kernel/workqueue.c:2602
 #1: ffffc9000017fd88 ((work_completion)(&hub->events)
){+.+.}-{0:0}, at: process_one_work+0x7a7/0x15d0 kernel/workqueue.c:2605
 #2: ffff888105bf5190 (
&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: hub_event+0x1be/0x4f30 drivers/usb/core/hub.c:5768
 #3: ffff8881158c8190
 (&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: usb_disconnect+0x10a/0x890 drivers/usb/core/hub.c:2243
 #4: 
ffff88811beda160 (&dev->mutex
){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffff888109fc1a20 (
&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #6: ffffffff88aa3328 (input_mutex){+.+.}-{3:3}
, at: __input_unregister_device+0x136/0x450 drivers/input/input.c:2219
1 lock held by khungtaskd/29:
 #0: ffffffff87eac820 (rcu_read_lock
){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6607
7 locks held by kworker/1:2/1781:
 #0: 
ffff88810aa6dd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}
, at: process_one_work+0x774/0x15d0 kernel/workqueue.c:2602
 #1: ffffc900035bfd88
 ((work_completion)(&hub->events)){+.+.}-{0:0}
, at: process_one_work+0x7a7/0x15d0 kernel/workqueue.c:2605
 #2: 
ffff888105fe5190 (&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: hub_event+0x1be/0x4f30 drivers/usb/core/hub.c:5768
 #3: ffff88811b744190
 (&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: 
ffff88811b84e160 (&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: 
ffff8881123fda20 (&dev->mutex){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #6: 
ffffffff88aa3328 (
input_mutex
){+.+.}-{3:3}
, at: input_register_device+0xa27/0x1130 drivers/input/input.c:2389
1 lock held by udevd/2385:
 #0: 
ffff88810165f948 (&root->kernfs_rwsem
){++++}-{3:3}
, at: kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
2 locks held by getty/2443:
 #0: 
ffff88810bb160a0 (&tty->ldisc_sem
){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (
&ldata->atomic_read_lock){+.+.}-{3:3}
, at: n_tty_read+0xfc5/0x1480 drivers/tty/n_tty.c:2206
1 lock held by udevd/2500:
 #0: ffff88810165f948 (&root->kernfs_rwsem
){++++}-{3:3}, at: kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
2 locks held by kworker/1:3/2503:
 #0: ffff888100070d38 ((wq_completion)events
){+.+.}-{0:0}, at: process_one_work+0x774/0x15d0 kernel/workqueue.c:2602
 #1: ffffc9000156fd88
 (console_work){+.+.}-{0:0}
, at: process_one_work+0x7a7/0x15d0 kernel/workqueue.c:2605
1 lock held by udevd/2507:
 #0: ffff88810165f948 (&root->kernfs_rwsem
){++++}-{3:3}, at: kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
1 lock held by udevd/2508:
 #0: 
ffff88810165f948 (&root->kernfs_rwsem){++++}-{3:3}
, at: kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
9 locks held by kworker/1:4/2514:
10 locks held by kworker/1:6/2517:
5 locks held by kworker/0:6/2525:
 #0: 
ffff88810aa6dd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}
, at: process_one_work+0x774/0x15d0 kernel/workqueue.c:2602
 #1: ffffc9000148fd88 (
(work_completion)(&hub->events)){+.+.}-{0:0}
, at: process_one_work+0x7a7/0x15d0 kernel/workqueue.c:2605
 #2: ffff888105fbd190 (
&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f30 drivers/usb/core/hub.c:5768
 #3: ffff88811b743190 (
&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x890 drivers/usb/core/hub.c:2243
 #4: ffff88810165f948 (
&root->kernfs_rwsem){++++}-{3:3}, at: kernfs_find_and_get_ns+0x71/0xc0 fs/kernfs/dir.c:897
1 lock held by udevd/2537:
 #0: ffff88810165f948
 (&root->kernfs_rwsem){++++}-{3:3}
, at: kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
1 lock held by syz-executor212/2596:
 #0: ffff88810165f948 (
&root->kernfs_rwsem
){++++}-{3:3}
, at: kernfs_add_one+0xb1/0x510 fs/kernfs/dir.c:757

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x26c/0x2d0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfac/0x1230 kernel/hung_task.c:379
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2517 Comm: kworker/1:6 Not tainted 6.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:__sanitizer_cov_trace_const_cmp2+0x8/0x20 kernel/kcov.c:297
Code: 00 00 f3 0f 1e fa 48 8b 0c 24 40 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 e9 d6 fe ff ff 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b 0c 24 <0f> b7 d6 0f b7 f7 bf 03 00 00 00 e9 b8 fe ff ff 0f 1f 84 00 00 00
RSP: 0018:ffffc90000198510 EFLAGS: 00000046
RAX: 0000000000000002 RBX: 0000000000000002 RCX: ffffffff813144a0
RDX: ffff88810fff3a00 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffffff8bfc2610 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000020 R11: 000000000bf26868 R12: 0000000000000000
R13: 000000000000001a R14: ffffc900001985b0 R15: 000000000000000a
FS:  0000000000000000(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557349ca8 CR3: 000000010a34a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 printk_sprint+0x220/0x2f0 kernel/printk/printk.c:2141
 vprintk_store+0x4d8/0xb80 kernel/printk/printk.c:2242
 vprintk_emit+0x154/0x630 kernel/printk/printk.c:2288
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x2ac/0x4f0 arch/x86/kernel/dumpstack.c:285
 sched_show_task kernel/sched/core.c:9182 [inline]
 sched_show_task+0x3f4/0x600 kernel/sched/core.c:9156
 show_state_filter+0xeb/0x310 kernel/sched/core.c:9227
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xea/0x140 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
 kbd_event+0xcc8/0x17c0 drivers/tty/vt/keyboard.c:1543
 input_to_handler+0x382/0x4c0 drivers/input/input.c:132
 input_pass_values.part.0+0x536/0x7a0 drivers/input/input.c:161
 input_pass_values drivers/input/input.c:148 [inline]
 input_event_dispose+0x5ee/0x770 drivers/input/input.c:378
 input_handle_event+0x11c/0xd80 drivers/input/input.c:406
 input_repeat_key+0x251/0x340 drivers/input/input.c:2263
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x20b/0x94e kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x8e/0xb0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:console_flush_all+0x9d2/0xf70 kernel/printk/printk.c:2972
Code: b4 0f 23 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 42 64 1c 00 48 85 db 0f 85 95 03 00 00 e8 a4 68 1c 00 fb 48 8b 44 24 08 <48> 8b 14 24 0f b6 00 83 e2 07 38 d0 7f 08 84 c0 0f 85 9e 04 00 00
RSP: 0018:ffffc900016bf5a0 EFLAGS: 00000293
RAX: fffff520002d7edf RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88810fff3a00 RSI: ffffffff813107bc RDI: 0000000000000007
RBP: ffffffff88353b80 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 205d314320202020 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff88353bd8 R15: 0000000000000001
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x189/0x630 kernel/printk/printk.c:2307
 dev_vprintk_emit drivers/base/core.c:4847 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4858
 __dev_printk+0xf5/0x270 drivers/base/core.c:4870
 _dev_info+0xe5/0x120 drivers/base/core.c:4916
 usb_disconnect+0xec/0x890 drivers/usb/core/hub.c:2234
 hub_port_connect drivers/usb/core/hub.c:5280 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x1be0/0x4f30 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 3.678 msecs


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
