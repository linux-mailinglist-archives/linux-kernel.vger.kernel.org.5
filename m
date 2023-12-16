Return-Path: <linux-kernel+bounces-2094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D378157CC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EBD2870CA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E340125A4;
	Sat, 16 Dec 2023 05:35:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB65C9C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7a772c238so130334339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702704908; x=1703309708;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/ASiTzDPnfgRI87aonIzOdpt1S57X2/8GKvkZ4qxyg=;
        b=OwsSA9+r6EeIlvbybzsBfuljh3lMrUGxO1KP6xGhGKYpPGgQSs7GCXKaO2pTLzCj9W
         Sna2JGWEBNUSJVTMB2VCkOtccB0hXBy5cIn6V5oFSO7yO/1xxdEw5rtbo/L0+hdqoSbZ
         0LUifVWOT85/ahorwXxUVjlzytTEm1WKCYmy8HPladXLuH6jhve5mAfsD3lWzbajPlnI
         F6gl1FMCGMMl4VbEoWD0HQiVhkDxlsTbdOrLrbqf7BA4LUELSrEsmtJ3BzgECQEryqES
         VomG1mLrhwWu9ejFNo+2qVRosuJX5Slt64gLOETZnZ5qny1prXAY0jMM65w7GXbKfpCP
         ME/w==
X-Gm-Message-State: AOJu0Yz+e2/Nqiu9qcDmKPiJgCeTaUnkZ/cFAv2zECeVz6VeA1BLiUc3
	9A7UNvvq97mVN4mJ9rFQL2c8THfCRgXlWK7HmEi8EAeoA5tj
X-Google-Smtp-Source: AGHT+IEfbJBET8G/B9YG3AB06Ui/emrjJ4VDCtQdNGFCDjCtEqRk0llp74GqNd70WXI/CQSa9L+dPqt3E7FI+n4wL6FJ4/sd1N/n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1927:b0:468:d16d:71a5 with SMTP id
 p39-20020a056638192700b00468d16d71a5mr484420jal.4.1702704908166; Fri, 15 Dec
 2023 21:35:08 -0800 (PST)
Date: Fri, 15 Dec 2023 21:35:08 -0800
In-Reply-To: <tencent_E74A0E747D762B66DA3C9D36FE9698367C09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000356b35060c99e19f@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bdev_release

INFO: task syz-executor.0:5479 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27744 pid:5479  tgid:5478  ppid:5422   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 bdev_release+0xe6/0xac0 block/bdev.c:971
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
RIP: 0033:0x7f32c047cae9
RSP: 002b:00007f32c11ec0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f32c059bf80 RCX: 00007f32c047cae9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000005
RBP: 00007f32c04c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f32c059bf80 R15: 00007fff376969d8
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u4:0/11:
 #0: ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
 #1: ffff8880b9928888 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by getty/4814:
 #0: ffff88802b1f20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
1 lock held by udevd/5436:
 #0: ffff888143f344c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x2ae/0xf50 block/bdev.c:858
1 lock held by syz-executor.0/5479:
 #0: ffff888143f344c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0xe6/0xac0 block/bdev.c:971
1 lock held by syz-executor.0/5796:
 #0: ffff888143f344c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x2ae/0xf50 block/bdev.c:858
1 lock held by syz-executor.0/5812:
 #0: ffff888143f344c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x2ae/0xf50 block/bdev.c:858

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
CPU: 1 PID: 48 Comm: kworker/u4:3 Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:smp_call_function_many_cond+0x1213/0x1570 kernel/smp.c:845
Code: e8 b2 b5 0b 00 84 db 0f 84 cc fa ff ff e8 75 ba 0b 00 e8 50 29 84 ff e9 c9 fa ff ff e8 66 ba 0b 00 90 0f 0b 90 e9 85 fc ff ff <e8> 58 ba 0b 00 e8 03 73 12 00 4c 8b 74 24 30 31 f6 4c 89 f7 e8 b4
RSP: 0018:ffffc90000b8f920 EFLAGS: 00000006
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff817c4cc2
RDX: ffff88801a6c3b80 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 0000000000000200 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000200 R11: 0000000000000006 R12: 0000000000000001
R13: 000000000003bccc R14: 0000000000000000 R15: ffff8880b993d8c0
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dc28b15680 CR3: 000000000cd78000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2008 [inline]
 text_poke_bp_batch+0x561/0x750 arch/x86/kernel/alternative.c:2301
 text_poke_flush arch/x86/kernel/alternative.c:2409 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2406 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2416
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate mm/kfence/core.c:830 [inline]
 toggle_allocation_gate+0xf4/0x250 mm/kfence/core.c:822
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
console output: https://syzkaller.appspot.com/x/log.txt?x=14080556e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=176a65e6e80000


