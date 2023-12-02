Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061DC801A0E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjLBCdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:33:00 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104321B3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:33:06 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so1171818a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 18:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701484385; x=1702089185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lXGWrWfm5JIwqXotFadGFrCerxkophD6SnQjYZPBP4=;
        b=q7uieqmICDo57/2p9Tr5DB7PpNt/wbHOs8KexEo1gaaiAb/whVYEblixfCXe679Zvt
         fv5e0OQFa5qFaCtHAHz93TBhhFpfAXQXDMgoitg1u+hYWYXcwkMFGGiMF4j1JlZeYFcN
         LrWbO0dsdGXMrBKxEQLeuaA5Y3q6R+x1JjVtO+k8UficOgb67BciiSiO4+LcSTWFXZwt
         0rs5yhJc5T2fKRg+otXh3TFgo6XTL8QyhUu4HbRz1N4tBUU+bZZSNOSnHaTJ+uW3unvA
         cbdsvXSAciHAP154rQFUr+KiQrRuuDfgWQ8Fww1Nm8QgUYE8fx2x4mNLa8DcraSxfLK/
         gBNw==
X-Gm-Message-State: AOJu0Yw0ei7W29/O0jPwz6wEL7sinfyxrSuvdMFT+MFM8l32nijPCTMa
        XApY/wkq0DC+kdpB5bdzAtpT+1LKXbcG1pN8JmVAvxKNAXmi
X-Google-Smtp-Source: AGHT+IF11S4niwdOQrHIUCHFZQynjjuqGAfbLcWKpOA5FpKNna+mevT5eN4iByeK7E/RrJjJzTHpmgWMdGfbZOTgOBASAH0HdxEv
MIME-Version: 1.0
X-Received: by 2002:a63:5945:0:b0:5be:3925:b5b4 with SMTP id
 j5-20020a635945000000b005be3925b5b4mr3989051pgm.9.1701484385564; Fri, 01 Dec
 2023 18:33:05 -0800 (PST)
Date:   Fri, 01 Dec 2023 18:33:05 -0800
In-Reply-To: <tencent_E68094D8E9BAEFDACCF878BA6C342CE16E0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064827b060b7db4ab@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
From:   syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blk_trace_ioctl

INFO: task syz-executor.5:5691 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:29344 pid:5691  tgid:5688  ppid:5438   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
 blkdev_common_ioctl+0x1575/0x1ce0 block/ioctl.c:562
 blkdev_ioctl+0x249/0x770 block/ioctl.c:627
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f0bacc7cae9
RSP: 002b:00007f0bada690c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0bacd9c050 RCX: 00007f0bacc7cae9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007f0baccc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f0bacd9c050 R15: 00007ffdfd91ff58
 </TASK>
INFO: task syz-executor.4:5694 blocked for more than 144 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:28464 pid:5694  tgid:5692  ppid:5446   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
 blkdev_ioctl+0x111/0x770 block/ioctl.c:622
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fd308c7cae9
RSP: 002b:00007fd3099650c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd308d9bf80 RCX: 00007fd308c7cae9
RDX: 0000000020000380 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 00007fd308cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd308d9bf80 R15: 00007ffdef910b18
 </TASK>
INFO: task syz-executor.4:5695 blocked for more than 145 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:29536 pid:5695  tgid:5692  ppid:5446   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
 blkdev_common_ioctl+0x1575/0x1ce0 block/ioctl.c:562
 blkdev_ioctl+0x249/0x770 block/ioctl.c:627
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fd308c7cae9
RSP: 002b:00007fd3099440c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd308d9c050 RCX: 00007fd308c7cae9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007fd308cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fd308d9c050 R15: 00007ffdef910b18
 </TASK>
INFO: task syz-executor.2:5699 blocked for more than 145 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:28464 pid:5699  tgid:5698  ppid:5433   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
 blkdev_ioctl+0x111/0x770 block/ioctl.c:622
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f06c0a7cae9
RSP: 002b:00007f06c17260c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f06c0b9bf80 RCX: 00007f06c0a7cae9
RDX: 0000000020000380 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 00007f06c0ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f06c0b9bf80 R15: 00007ffd778555b8
 </TASK>
INFO: task syz-executor.2:5702 blocked for more than 146 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:28880 pid:5702  tgid:5698  ppid:5433   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
 blkdev_common_ioctl+0x1575/0x1ce0 block/ioctl.c:562
 blkdev_ioctl+0x249/0x770 block/ioctl.c:627
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f06c0a7cae9
RSP: 002b:00007f06c17050c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f06c0b9c050 RCX: 00007f06c0a7cae9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007f06c0ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f06c0b9c050 R15: 00007ffd778555b8
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:1/9:
 #0: ffff888013074d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffff8880b9828888 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
 #2: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #2: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #2: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: led_trigger_event drivers/leds/led-triggers.c:389 [inline]
 #2: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: led_trigger_event+0x44/0x240 drivers/leds/led-triggers.c:381
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by kworker/u4:11/4345:
2 locks held by getty/4820:
 #0: ffff8880270240a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
3 locks held by kworker/1:4/5079:
 #0: ffff888013074d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc900040afd80 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
 #2: ffff8881670a0240 (&data->fib_lock){+.+.}-{3:3}, at: nsim_fib_event_work+0x1bb/0x26e0 drivers/net/netdevsim/fib.c:1489
3 locks held by kworker/0:6/5550:
 #0: ffff88802668fd38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc90005657d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
 #2: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4137
2 locks held by syz-executor.5/5689:
1 lock held by syz-executor.5/5691:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.4/5694:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.4/5695:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.2/5699:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.2/5702:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.3/5896:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.3/5897:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.1/5951:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.1/5952:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.0/5983:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.0/5984:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.5/5986:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.5/5987:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.4/5989:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.4/5991:
 #0: ffff88814435bbe8
 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.2/5993:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.2/5994:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.3/6013:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.3/6014:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.1/6041:
 #0: 
ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.1/6042:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
2 locks held by syz-executor.2/6063:
 #0: ffffffff8eb482b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1075
 #1: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: nl80211_pre_doit+0xb4/0xb10 net/wireless/nl80211.c:16329
3 locks held by syz-executor.4/6064:
1 lock held by syz-executor.0/6100:
 #0: 
ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.0/6102:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.3/6113:
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6555
1 lock held by syz-executor.5/6116:
 #0: ffff88814435bbe8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.5/6117:
 #0: ffff88814435bbe8 (&q->debugfs_mutex/1){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf86/0x1210 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 1252 Comm: kworker/u4:7 Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:printk_get_next_message+0x2bc/0x7c0 kernel/printk/printk.c:2828
Code: 24 84 c0 74 3a e8 54 e7 1c 00 0f b6 74 24 1f 31 ff e8 78 e2 1c 00 45 84 e4 0f 85 c1 00 00 00 e8 3a e7 1c 00 8b 35 64 09 16 11 <4c> 89 ff 0f b6 15 7a 76 80 0b 83 e6 01 e8 32 9d ff ff 41 89 c6 e8
RSP: 0018:ffffc900055575c8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff92000aaaebd RCX: ffffffff816b2ac8
RDX: ffff888020b98000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc900055577d0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000005010 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000006 R15: ffffc90005557608
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555db3938 CR3: 000000000cd78000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 console_emit_next_record kernel/printk/printk.c:2868 [inline]
 console_flush_all+0x3af/0xd60 kernel/printk/printk.c:2967
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3036
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 ieee80211_sta_find_ibss net/mac80211/ibss.c:1447 [inline]
 ieee80211_ibss_work+0xbb0/0x14c0 net/mac80211/ibss.c:1666
 ieee80211_iface_work+0xbeb/0xda0 net/mac80211/iface.c:1665
 cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:435
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         8c9660f6 Add linux-next specific files for 20231124
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=104c7d64e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6eff11e3e3c25a4f
dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f7e752e80000

