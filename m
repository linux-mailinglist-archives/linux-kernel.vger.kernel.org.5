Return-Path: <linux-kernel+bounces-2167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811D68158E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3294AB2307F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120E117982;
	Sat, 16 Dec 2023 12:01:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CEE14F9A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b42af63967so181989539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702728065; x=1703332865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsk3jtiwnWrh6c1VCNWda2BjSH4tmaBAonEH/uq+1p4=;
        b=o+4UuH9n6ThoOcHIkN/HA6E19h9IeV7IMKCDCEExYKFCNkqH8aPP+/PS8NbBeJiPaZ
         RrH7fNzedS0WxdStkiCxiAlIgylOCErsi5dWjlsppwZgXQHWXqErvgJMtb6SEoCUt9wX
         wbfBv3YbD9tqGsKvueFD7Ji8tj6H4exIL8rsC3gMzIOeLv8n0VtYMPxq9MbAhoqkZh+b
         AYdapZGdnPGmxY1cmTUOqvLT5cdPms+ahqLpluClXL5wMMQqod8x8voQGCMKdIuI1RzG
         2IrvtTiGrr6OQ0MVyQu5THTB+MFxVBU4qDue/3dsQnzfBQ+8WEzGhRveWbaLrS/ILmkj
         9j8A==
X-Gm-Message-State: AOJu0YxC8Jqn3q2M4acgvTtOEtNlcqQcIE+CQFz2CCLM3kAJFgAXXV7V
	QYshAEVbzZbSCTRRXfyac6JGKxBcE5D3kfpI1uMz1PlFoRl0
X-Google-Smtp-Source: AGHT+IFmEomdkDujKSP/XMfPIDNivZ7PRSTJJUiyCAPHWhP3Bw2fDFGF1Cgon6foR+oQzE2P12492PdPkp+sIJBgVSkfqFND6Rka
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:33a9:b0:469:35fa:9244 with SMTP id
 h41-20020a05663833a900b0046935fa9244mr434594jav.2.1702728065378; Sat, 16 Dec
 2023 04:01:05 -0800 (PST)
Date: Sat, 16 Dec 2023 04:01:05 -0800
In-Reply-To: <tencent_B69624EA1EECC2CD2C79FE6F942DA16D980A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c6eb2060c9f4539@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bdev_release

INFO: task syz-executor.0:5590 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27232 pid:5590  tgid:5590  ppid:5422   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 bdev_release+0xe6/0xac0 block/bdev.c:975
 blkdev_release+0x37/0x50 block/fops.c:616
 __fput+0x270/0xbb0 fs/file_table.c:394
 __fput_sync+0x47/0x50 fs/file_table.c:475
 __do_sys_close fs/open.c:1591 [inline]
 __se_sys_close fs/open.c:1576 [inline]
 __x64_sys_close+0x86/0xf0 fs/open.c:1576
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f59a8c7b9da
RSP: 002b:00007ffc5134e390 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f59a8c7b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f59a8d9d980 R08: 0000001b2e960000 R09: 0000000000000001
R10: 00007ffc513ba080 R11: 0000000000000293 R12: 000000000001db88
R13: ffffffffffffffff R14: 00007f59a8800000 R15: 000000000001d847
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/1:1/27:
 #0: ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
 #1: ffff8880b9928888 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
 #2: ffff8880b992a898 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5d/0x200 kernel/time/timer.c:999
 #3: ffffffff929aeca0 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x195/0x540 lib/debugobjects.c:708
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by getty/4819:
 #0: ffff8880285880a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015b72f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
1 lock held by udevd/5416:
 #0: ffff888141f694c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x278/0xfa0 block/bdev.c:860
1 lock held by syz-executor.0/5590:
 #0: ffff888141f694c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0xe6/0xac0 block/bdev.c:975
1 lock held by syz-executor.0/5824:
 #0: ffff888141f694c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x278/0xfa0 block/bdev.c:860
1 lock held by syz-executor.0/5841:
 #0: ffff888141f694c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x278/0xfa0 block/bdev.c:860

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 11 Comm: kworker/u4:0 Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: bat_events batadv_nc_worker
RIP: 0010:separate_irq_context kernel/locking/lockdep.c:4627 [inline]
RIP: 0010:__lock_acquire+0xa6e/0x3b10 kernel/locking/lockdep.c:5120
Code: 04 02 84 c0 74 08 3c 03 0f 8e 71 2e 00 00 48 8b 04 24 8b 80 b8 0a 00 00 85 c0 74 75 48 8b 74 24 28 48 8d 04 80 48 8d 6c c6 d8 <48> b8 00 00 00 00 00 fc ff df 48 8d 7d 21 48 89 fa 48 c1 ea 03 0f
RSP: 0018:ffffc90000107968 EFLAGS: 00000002
RAX: 000000000000000a RBX: 19143be48a2d0d7b RCX: ffffffff81683d4c
RDX: 1ffff110029588c7 RSI: ffff888014ac4640 RDI: ffffffff91f24f40
RBP: ffff888014ac4668 R08: 0000000000000000 R09: fffffbfff23e49e8
R10: ffffffff91f24f47 R11: 0000000000000002 R12: ffffed10029588c7
R13: ffff888014ac4640 R14: ffff888014ac4690 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564996f05680 CR3: 00000000263fa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 rcu_read_lock include/linux/rcupdate.h:747 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0x16e/0x10e0 net/batman-adv/network-coding.c:719
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
console output: https://syzkaller.appspot.com/x/log.txt?x=14446c06e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1245bcd1e80000


