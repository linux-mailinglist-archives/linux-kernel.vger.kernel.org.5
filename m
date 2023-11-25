Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D01C7F8F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 22:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjKYVHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 16:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKYVHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 16:07:16 -0500
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910F811D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:07:22 -0800 (PST)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1cf9dded6fbso30143545ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700946442; x=1701551242;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2LFA89UojZHEhT5q7B3h6PoCR4H+/4dUmUOoeBt/qs=;
        b=u87VpzDFm5uRR8LHe43nFLalwoqhSgu1f44GKmv0T4i1QGvlRUcZenaN02FapAbcA/
         8Z19dK66gzcm8KsVAfoFX8rQMEfzK1ZFiW4Mt9InEUhDVKvHYSp3+JRzXBqtSOnLlIKk
         lRMyUGYN9n7v/ME0yI900ArKrM1ZkFW4co2y0tEx90V1RC6LvQnirNRmp2ULUL2Yq4Yw
         8GtE7L0oPahckgJYt3m16BalkWzWd48HbkXSfvPi1wuEC1MkTekTJ5GPEd0InLtIHhY3
         Et49cNZJn85Lj2iNA4L6Fxb2ufZdvB7cU2/heo9czKbT0W9OevZcMjviCBlqqlawH8xg
         WZ2Q==
X-Gm-Message-State: AOJu0YzGoRX/0RuxLZZ/srmDKc1nzZCHtJ7h/EQjff4oHFKaGPRPjs3e
        SBuR6vs6wZgRBhRq/+9wzqY3V6+CRHoOrvRBmHwxFMHu5YSt
X-Google-Smtp-Source: AGHT+IGE7PXV+0m6AILPJ2Ry/eIfIFbn+NiNM3xf4/qr75X+EYKE909ypxJUX5X4pgvi1tQvJoKmEMXn1ThSe/vMCmqxLa4HOuGW
MIME-Version: 1.0
X-Received: by 2002:a17:903:11c4:b0:1cf:669f:3a86 with SMTP id
 q4-20020a17090311c400b001cf669f3a86mr1716031plh.13.1700946442208; Sat, 25 Nov
 2023 13:07:22 -0800 (PST)
Date:   Sat, 25 Nov 2023 13:07:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000784b1c060b0074a2@google.com>
Subject: [syzbot] [kernel?] possible deadlock in stack_depot_put
From:   syzbot <syzbot+186b55175d8360728234@syzkaller.appspotmail.com>
To:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

syzbot found the following issue on:

HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c1a4d8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=186b55175d8360728234
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+186b55175d8360728234@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc2-next-20231124-syzkaller #0 Not tainted
------------------------------------------------------
jbd2/sda1-8/4474 is trying to acquire lock:
ffffffff8cf9a9b8 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x12/0x70 kernel/locking/semaphore.c:139

but task is already holding lock:
ffffffff8da73f98 (pool_rwlock){----}-{2:2}, at: stack_depot_put lib/stackdepot.c:621 [inline]
ffffffff8da73f98 (pool_rwlock){----}-{2:2}, at: stack_depot_put+0x24/0x110 lib/stackdepot.c:613

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (pool_rwlock){----}-{2:2}:
       __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
       _raw_read_lock_irqsave+0x46/0x90 kernel/locking/spinlock.c:236
       stack_depot_save_flags+0x169/0x740 lib/stackdepot.c:508
       kasan_save_stack+0x42/0x50 mm/kasan/common.c:47
       __kasan_record_aux_stack+0xc2/0xd0 mm/kasan/generic.c:508
       task_work_add+0x88/0x2a0 kernel/task_work.c:48
       task_tick_numa kernel/sched/fair.c:3512 [inline]
       task_tick_fair+0x5a5/0xc30 kernel/sched/fair.c:12599
       scheduler_tick+0x210/0x650 kernel/sched/core.c:5674
       update_process_times+0x19e/0x220 kernel/time/timer.c:2076
       tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:255
       tick_nohz_highres_handler+0xe9/0x110 kernel/time/tick-sched.c:1516
       __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
       __hrtimer_run_queues+0x654/0xc20 kernel/time/hrtimer.c:1752
       hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
       local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
       __sysvec_apic_timer_interrupt+0x10c/0x410 arch/x86/kernel/apic/apic.c:1082
       sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
       sha256_transform_rorx+0xffc/0x1120 arch/x86/crypto/sha256-avx2-asm.S:655
       lib_sha256_base_do_update.isra.0+0x12d/0x150 include/crypto/sha256_base.h:63
       sha256_base_do_update include/crypto/sha256_base.h:81 [inline]
       _sha256_update arch/x86/crypto/sha256_ssse3_glue.c:74 [inline]
       _sha256_update+0xb6/0xe0 arch/x86/crypto/sha256_ssse3_glue.c:58
       ima_calc_file_hash_tfm+0x2fe/0x3d0 security/integrity/ima/ima_crypto.c:496
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
       ima_calc_file_hash+0x1c6/0x4a0 security/integrity/ima/ima_crypto.c:573
       ima_collect_measurement+0x85e/0xa20 security/integrity/ima/ima_api.c:290
       process_measurement+0xe92/0x2260 security/integrity/ima/ima_main.c:359
       ima_file_mmap+0x1ad/0x1d0 security/integrity/ima/ima_main.c:449
       security_mmap_file+0x186/0x1d0 security/security.c:2788
       vm_mmap_pgoff+0xdb/0x3c0 mm/util.c:552
       vm_mmap+0x8e/0xc0 mm/util.c:575
       elf_map fs/binfmt_elf.c:385 [inline]
       elf_load+0x196/0x870 fs/binfmt_elf.c:408
       load_elf_interp fs/binfmt_elf.c:675 [inline]
       load_elf_binary+0x3436/0x4e10 fs/binfmt_elf.c:1200
       search_binary_handler fs/exec.c:1736 [inline]
       exec_binprm fs/exec.c:1778 [inline]
       bprm_execve fs/exec.c:1853 [inline]
       bprm_execve+0x7ef/0x1a80 fs/exec.c:1809
       kernel_execve+0x3d7/0x4e0 fs/exec.c:2021
       try_to_run_init_process init/main.c:1364 [inline]
       kernel_init+0x137/0x2a0 init/main.c:1497
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1374 [inline]
       rq_lock kernel/sched/sched.h:1688 [inline]
       task_fork_fair+0x70/0x240 kernel/sched/fair.c:12619
       sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4835
       copy_process+0x6a38/0x9770 kernel/fork.c:2601
       kernel_clone+0xfd/0x940 kernel/fork.c:2899
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2977
       rest_init+0x27/0x2b0 init/main.c:695
       arch_call_rest_init+0x13/0x30 init/main.c:827
       start_kernel+0x39e/0x480 init/main.c:1072
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
       secondary_startup_64_no_verify+0x166/0x16b

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:522 [inline]
       try_to_wake_up+0x9a/0x13d0 kernel/sched/core.c:4252
       up+0x79/0xb0 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:340 [inline]
       __console_unlock kernel/printk/printk.c:2706 [inline]
       console_unlock+0x1cf/0x260 kernel/printk/printk.c:3038
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
       dev_vprintk_emit drivers/base/core.c:4850 [inline]
       dev_printk_emit+0xfb/0x140 drivers/base/core.c:4861
       __dev_printk+0xf5/0x270 drivers/base/core.c:4873
       _dev_printk+0xde/0x120 drivers/base/core.c:4890
       sdev_prefix_printk+0x1a2/0x230 drivers/scsi/scsi_logging.c:78
       ioctl_internal_command.constprop.0+0x57e/0x5f0 drivers/scsi/scsi_ioctl.c:93
       scsi_send_start_stop drivers/scsi/scsi_ioctl.c:241 [inline]
       scsi_ioctl+0x46b/0x1840 drivers/scsi/scsi_ioctl.c:907
       sg_ioctl+0xb7b/0x2760 drivers/scsi/sg.c:1163
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl fs/ioctl.c:857 [inline]
       __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x62/0x6a

-> #0 ((console_sem).lock){-...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2466/0x3b10 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x40/0x140 kernel/printk/printk.c:323
       console_trylock+0x73/0x130 kernel/printk/printk.c:2659
       console_trylock_spinning kernel/printk/printk.c:1923 [inline]
       vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2302
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2328
       __warn_printk+0x158/0x350 kernel/panic.c:721
       refcount_warn_saturate+0x149/0x210 lib/refcount.c:28
       __refcount_sub_and_test include/linux/refcount.h:283 [inline]
       __refcount_dec_and_test include/linux/refcount.h:315 [inline]
       refcount_dec_and_test include/linux/refcount.h:333 [inline]
       stack_depot_put lib/stackdepot.c:627 [inline]
       stack_depot_put+0xe4/0x110 lib/stackdepot.c:613
       __kasan_record_aux_stack+0xb3/0xd0 mm/kasan/generic.c:506
       insert_work+0x38/0x230 kernel/workqueue.c:1653
       __queue_work+0x633/0x11d0 kernel/workqueue.c:1802
       __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
       mod_delayed_work_on+0xcc/0x1a0 kernel/workqueue.c:2027
       kblockd_mod_delayed_work_on+0x29/0x40 block/blk-core.c:1038
       blk_kick_flush block/blk-flush.c:348 [inline]
       blk_flush_complete_seq+0xa66/0x10c0 block/blk-flush.c:213
       blk_insert_flush+0x349/0x6d0 block/blk-flush.c:456
       blk_mq_submit_bio+0x16cd/0x2150 block/blk-mq.c:2992
       __submit_bio+0xfd/0x310 block/blk-core.c:599
       __submit_bio_noacct_mq block/blk-core.c:678 [inline]
       submit_bio_noacct_nocheck+0x852/0xbb0 block/blk-core.c:707
       submit_bio_noacct+0x87b/0x1b90 block/blk-core.c:801
       journal_submit_commit_record+0x73b/0xab0 fs/jbd2/commit.c:156
       jbd2_journal_commit_transaction+0x39fd/0x63c0 fs/jbd2/commit.c:880
       kjournald2+0x1f8/0x8f0 fs/jbd2/journal.c:201
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &rq->__lock --> pool_rwlock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(pool_rwlock);
                               lock(&rq->__lock);
                               lock(pool_rwlock);
  lock((console_sem).lock);

 *** DEADLOCK ***

4 locks held by jbd2/sda1-8/4474:
 #0: ffff88801e366218 (&fq->mq_flush_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #0: ffff88801e366218 (&fq->mq_flush_lock){..-.}-{2:2}, at: blk_insert_flush+0x337/0x6d0 block/blk-flush.c:455
 #1: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #1: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #1: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xf2/0x11d0 kernel/workqueue.c:1730
 #2: ffff8880b993c2f8 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x39e/0x11d0 kernel/workqueue.c:1766
 #3: ffffffff8da73f98 (pool_rwlock){----}-{2:2}, at: stack_depot_put lib/stackdepot.c:621 [inline]
 #3: ffffffff8da73f98 (pool_rwlock){----}-{2:2}, at: stack_depot_put+0x24/0x110 lib/stackdepot.c:613

stack backtrace:
CPU: 1 PID: 4474 Comm: jbd2/sda1-8 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x316/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2466/0x3b10 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x40/0x140 kernel/printk/printk.c:323
 console_trylock+0x73/0x130 kernel/printk/printk.c:2659
 console_trylock_spinning kernel/printk/printk.c:1923 [inline]
 vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2302
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 __warn_printk+0x158/0x350 kernel/panic.c:721
 refcount_warn_saturate+0x149/0x210 lib/refcount.c:28
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 stack_depot_put lib/stackdepot.c:627 [inline]
 stack_depot_put+0xe4/0x110 lib/stackdepot.c:613
 __kasan_record_aux_stack+0xb3/0xd0 mm/kasan/generic.c:506
 insert_work+0x38/0x230 kernel/workqueue.c:1653
 __queue_work+0x633/0x11d0 kernel/workqueue.c:1802
 __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
 mod_delayed_work_on+0xcc/0x1a0 kernel/workqueue.c:2027
 kblockd_mod_delayed_work_on+0x29/0x40 block/blk-core.c:1038
 blk_kick_flush block/blk-flush.c:348 [inline]
 blk_flush_complete_seq+0xa66/0x10c0 block/blk-flush.c:213
 blk_insert_flush+0x349/0x6d0 block/blk-flush.c:456
 blk_mq_submit_bio+0x16cd/0x2150 block/blk-mq.c:2992
 __submit_bio+0xfd/0x310 block/blk-core.c:599
 __submit_bio_noacct_mq block/blk-core.c:678 [inline]
 submit_bio_noacct_nocheck+0x852/0xbb0 block/blk-core.c:707
 submit_bio_noacct+0x87b/0x1b90 block/blk-core.c:801
 journal_submit_commit_record+0x73b/0xab0 fs/jbd2/commit.c:156
 jbd2_journal_commit_transaction+0x39fd/0x63c0 fs/jbd2/commit.c:880
 kjournald2+0x1f8/0x8f0 fs/jbd2/journal.c:201
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 4474 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 1 PID: 4474 Comm: jbd2/sda1-8 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 78 4b 24 fd 84 db 0f 85 66 ff ff ff e8 3b 50 24 fd c6 05 7e 9b 9f 0a 01 90 48 c7 c7 e0 c1 2e 8b e8 57 42 ea fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 18 50 24 fd 0f b6 1d 59 9b 9f 0a 31
RSP: 0018:ffffc9000e3df300 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814e05d9
RDX: ffff88801bc89dc0 RSI: ffffffff814e05e6 RDI: 0000000000000001
RBP: ffff88806d1c243c R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888017e80780
R13: ffff888018a92400 R14: ffff888018a9245c R15: ffff8880b993c340
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020064000 CR3: 000000007cc12000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 stack_depot_put lib/stackdepot.c:627 [inline]
 stack_depot_put+0xe4/0x110 lib/stackdepot.c:613
 __kasan_record_aux_stack+0xb3/0xd0 mm/kasan/generic.c:506
 insert_work+0x38/0x230 kernel/workqueue.c:1653
 __queue_work+0x633/0x11d0 kernel/workqueue.c:1802
 __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
 mod_delayed_work_on+0xcc/0x1a0 kernel/workqueue.c:2027
 kblockd_mod_delayed_work_on+0x29/0x40 block/blk-core.c:1038
 blk_kick_flush block/blk-flush.c:348 [inline]
 blk_flush_complete_seq+0xa66/0x10c0 block/blk-flush.c:213
 blk_insert_flush+0x349/0x6d0 block/blk-flush.c:456
 blk_mq_submit_bio+0x16cd/0x2150 block/blk-mq.c:2992
 __submit_bio+0xfd/0x310 block/blk-core.c:599
 __submit_bio_noacct_mq block/blk-core.c:678 [inline]
 submit_bio_noacct_nocheck+0x852/0xbb0 block/blk-core.c:707
 submit_bio_noacct+0x87b/0x1b90 block/blk-core.c:801
 journal_submit_commit_record+0x73b/0xab0 fs/jbd2/commit.c:156
 jbd2_journal_commit_transaction+0x39fd/0x63c0 fs/jbd2/commit.c:880
 kjournald2+0x1f8/0x8f0 fs/jbd2/journal.c:201
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
