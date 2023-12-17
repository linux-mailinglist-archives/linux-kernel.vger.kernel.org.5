Return-Path: <linux-kernel+bounces-2455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C90D815D5C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE511F2213A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A995B136F;
	Sun, 17 Dec 2023 04:06:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374010E7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 04:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b71da9f8b9so363219339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 20:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702785967; x=1703390767;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbqvTrp2y8FQAsdPUW4HbXOpt0E5LZxjHxvLk6mHzCE=;
        b=i7pSwkGYCZq8pI5cIttRyh+NL9Hl5uegtqf3W8l/4WhYSiKNVrb0SwaHkuMFFs0TmK
         ze7RpAEkUG/GS7q4Qf4PE0uyCipTyh0xvUaN6VTMtdLVbPTOUU5MYM2ZIfelJ/btVD16
         2nrtfrBhLzrdQDLDG58c7b0e8uUnTpZAzt4Bu/9hegfbtc/k8tRLAkgoLbcgKV85cEAk
         KBfoi7VKZ2Kb5Amt9F5DwOIDBND46LP4xMrUH9U32q/GeEQ/EFwxMLTtOchc2DnoYnSs
         wJ1c1IcRmCLcA7ZJ2vMYBXIy31SQmDXYqyIPGy7rLdYgPvi7CnrJ1OfJlXlagnv2GMtc
         IMDg==
X-Gm-Message-State: AOJu0YxzjNKyu4lAVmtn+zGW8ADhA3MAdI0SOx5VfyWUV2ox2ueWhA3N
	OcNppNqji24Awhn8doKTY5j4fVMBJOffdAD5qTFpRwENeJS2
X-Google-Smtp-Source: AGHT+IGuKQ/bweunc5WCVbFCpB/wT5DZxkb2cyUzEaQgwmkQNFf+6etqmzWmfEix0Hy6v5yPC9RLFArOI88k+YNNFTeCDPqp2cjG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d09:b0:35f:a338:44ae with SMTP id
 i9-20020a056e021d0900b0035fa33844aemr166707ila.3.1702785967102; Sat, 16 Dec
 2023 20:06:07 -0800 (PST)
Date: Sat, 16 Dec 2023 20:06:07 -0800
In-Reply-To: <tencent_FC33DA9E731BEF4B621B55255CBA2CBB7808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2a318060cacc025@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bdev_release

INFO: task syz-executor.0:5520 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28464 pid:5520  tgid:5519  ppid:5421   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 bdev_release+0xe6/0xac0 block/bdev.c:969
 blkdev_release+0x37/0x50 block/fops.c:616
 __fput+0x270/0xbb0 fs/file_table.c:394
 task_work_run+0x14c/0x240 kernel/task_work.c:180
 get_signal+0x105a/0x2770 kernel/signal.c:2669
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11e/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f13f867cae9
RSP: 002b:00007f13f79fe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f13f879bf80 RCX: 00007f13f867cae9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000005
RBP: 00007f13f86c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f13f879bf80 R15: 00007fffee00fa68
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by getty/4815:
 #0: ffff88802b51a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015c72f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
1 lock held by udevd/5416:
 #0: ffff888143f0e4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xed0 block/bdev.c:857
1 lock held by syz-executor.0/5520:
 #0: ffff888143f0e4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0xe6/0xac0 block/bdev.c:969
1 lock held by syz-executor.0/5795:
 #0: ffff888143f0e4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xed0 block/bdev.c:857
1 lock held by syz-executor.0/5813:
 #0: ffff888143f0e4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xed0 block/bdev.c:857

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
CPU: 1 PID: 76 Comm: kworker/u4:5 Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: bat_events batadv_nc_worker
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:116 [inline]
RIP: 0010:lock_release+0xb7/0x6a0 kernel/locking/lockdep.c:5766
Code: 00 89 db be 08 00 00 00 48 89 d8 48 c1 e8 06 48 8d 3c c5 90 36 19 8f e8 77 bb 76 00 48 0f a3 1d 6f c7 b0 0d 0f 82 0c 04 00 00 <48> c7 c3 58 6a 19 8f 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1
RSP: 0018:ffffc90001597ae0 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81686f19
RDX: 0000000000000000 RSI: ffffffff8b2f2100 RDI: ffffffff8ca75a68
RBP: 1ffff920002b2f5e R08: 0000000000000000 R09: fffffbfff1e326d2
R10: ffffffff8f193697 R11: 0000000000000002 R12: ffffffff8cfacf60
R13: 0000000000000000 R14: 000000000003bccc R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005622f5959680 CR3: 000000000cd78000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 rcu_lock_release include/linux/rcupdate.h:306 [inline]
 rcu_read_unlock include/linux/rcupdate.h:780 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
 batadv_nc_worker+0x8f3/0x10e0 net/batman-adv/network-coding.c:719
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
console output: https://syzkaller.appspot.com/x/log.txt?x=119557c1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10731cd1e80000


