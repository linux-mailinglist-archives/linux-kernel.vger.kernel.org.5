Return-Path: <linux-kernel+bounces-37097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A903083AB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BC1B278AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900427A718;
	Wed, 24 Jan 2024 14:16:02 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840E77F09
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105761; cv=none; b=P91Qoi+VsNhId49aEgWokc6p2M29q0plErChmSKeuDC4qqn9sPnPJ6fWvufhgB8mt21hZthj1MobB/T9oRAjNPpWAX7ra5AUnUoeXuomzydH7nqzV+nAXJmSRc5LbFPALevGHbjdbrXGZDqDZF2cgTLlVtRy25bLQoS0CTTQ/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105761; c=relaxed/simple;
	bh=e/F+yV0Bn/8Aphhe5wnzrUWa2cznLfciMioBIkSaJD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzD9JbvUSChsdoOlmS9Rxvzp503pbb6A7xajfRvjWj67aHrYgfJg0qsiaKUHhMv+pWbJ0JHMsBs1KRRAleRZ7urwpJHbdsAIqYeiXqwPm12q9yWo+M+HPh1CLpyyJsRwwYcT/KTHAvHx7qQNYRMigGoUzHPKMYydSXty20hMCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a277339dcf4so606274666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105758; x=1706710558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI+CDmFVYUPtWyzmf03Qrs01XjTZsbVB4L2PntlcuDo=;
        b=EowNsmjtFKwSqu/RXqF9px7QXLe6iQK22KdXSCzm1yDNWZYTPFa66TP/6LLBJJ68pV
         deyXlYYOb5cvVKqXR5otsGxsK7gLBrengSdDRgr6fyu1YA+G1ifYvXiebf3VU+nVn+8w
         aACvFalD99Aflr3IfpyMICHF/DCgg562Es0r7d4zsMxppZ1JjurxC5e6qbYz1XlhBInm
         3HSJEpXtEzqhbj0uUNLwTyzk2bsXPmzEc4BcalhrNfnVp1rRd/gKs+C2mp4ZXjatd8H0
         DZ8zUjw+zFVk8pPye42+scKO4NB5j+MxSuKjzI5uMe0w7EWXP4vDv/wpY508c+kLHSZf
         FZxQ==
X-Gm-Message-State: AOJu0YzSkN6Lb1YVm418m/98/TDivI4E8HQZB4KvVlhyTrj7UCX7MGJ8
	K4s7kDxsz0ktw2BoZiMX9HKauGvdf8XKHYtbTFZfCh2fjepr/5cc
X-Google-Smtp-Source: AGHT+IEKEUNeTvBN7jCai1VG/OUNHzNc4MTlQv0xNEFcwtF2SN/60GvP9xg3NO4760aBhepzMg69NQ==
X-Received: by 2002:a17:906:35d3:b0:a2e:99c4:c61d with SMTP id p19-20020a17090635d300b00a2e99c4c61dmr743739ejb.106.1706105757488;
        Wed, 24 Jan 2024 06:15:57 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id ps11-20020a170906bf4b00b00a2f1888ddecsm7307512ejb.166.2024.01.24.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:15:57 -0800 (PST)
Date: Wed, 24 Jan 2024 06:15:55 -0800
From: Breno Leitao <leitao@debian.org>
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
Message-ID: <ZbEbmyszaK9tYobe@gmail.com>
References: <cover.1700502145.git.andreyknvl@google.com>
 <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>

Hello Andrey,

On Mon, Nov 20, 2023 at 06:47:10PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Currently, stack depot uses the following locking scheme:
> 
> 1. Lock-free accesses when looking up a stack record, which allows to
>    have multiple users to look up records in parallel;
> 2. Spinlock for protecting the stack depot pools and the hash table
>    when adding a new record.
> 
> For implementing the eviction of stack traces from stack depot, the
> lock-free approach is not going to work anymore, as we will need to be
> able to also remove records from the hash table.
> 
> Convert the spinlock into a read/write lock, and drop the atomic accesses,
> as they are no longer required.
> 
> Looking up stack traces is now protected by the read lock and adding new
> records - by the write lock. One of the following patches will add a new
> function for evicting stack records, which will be protected by the write
> lock as well.
> 
> With this change, multiple users can still look up records in parallel.
> 
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.

I am testing quite recent "debug" kernel (with KASAN, Lockdep, etc
enabled). This kernel is based on
9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e, and I found the following
lockdep DEADLOCK splat recently. Before investigating further, I would
like to share here to check if this is a known problem:

	 ======================================================
	 WARNING: possible circular locking dependency detected
	 6.7.0-0_fbk700_debug_kbuilder_0_g9f8413c4a66f #1 Tainted: G S          EL   N
	 ------------------------------------------------------
	 btrfs-transacti/566 is trying to acquire lock:
	 ffffffff84563058 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock (kernel/locking/semaphore.c:135) 
 
	 but task is already holding lock:
	 ffffffff850a2a70 (pool_lock#2){-.-.}-{2:2}, at: __stack_depot_save (lib/stackdepot.c:415) 
	 which lock already depends on the new lock.

	 the existing dependency chain (in reverse order) is:

	 -> #3 (pool_lock#2){-.-.}-{2:2}:
	 lock_acquire (kernel/locking/lockdep.c:462 kernel/locking/lockdep.c:5753) 
	 _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
	 __stack_depot_save (lib/stackdepot.c:415) 
	 kasan_save_stack (mm/kasan/common.c:46) 
	 __kasan_record_aux_stack (mm/kasan/generic.c:492) 
	 task_work_add (kernel/task_work.c:44) 
	 scheduler_tick (kernel/sched/core.c:5677) 
	 update_process_times (kernel/time/timer.c:2070 kernel/time/timer.c:2086) 
	 tick_nohz_highres_handler (kernel/time/tick-sched.c:? kernel/time/tick-sched.c:1512) 
	 __hrtimer_run_queues (kernel/time/hrtimer.c:484 kernel/time/hrtimer.c:1656 kernel/time/hrtimer.c:1752) 
	 hrtimer_interrupt (kernel/time/hrtimer.c:? kernel/time/hrtimer.c:1796) 
	 __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052 arch/x86/kernel/apic/apic.c:1082) 
	 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076) 
	 asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:649) 
	 _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
	 debug_object_activate (lib/debugobjects.c:? lib/debugobjects.c:732) 
	 call_rcu (kernel/rcu/rcu.h:227 kernel/rcu/tree.c:2666 kernel/rcu/tree.c:2795) 
	 mas_wr_modify (lib/maple_tree.c:3375 lib/maple_tree.c:3482 lib/maple_tree.c:4198 lib/maple_tree.c:4236) 
	 mas_wr_store_entry (lib/maple_tree.c:1389 lib/maple_tree.c:4250) 
	 mas_store_prealloc (lib/maple_tree.c:5364 lib/maple_tree.c:5458) 
	 vma_complete (mm/mmap.c:523) 
	 __split_vma (include/linux/mmap_lock.h:71 include/linux/mm.h:694 include/linux/mm.h:713 mm/mmap.c:2399) 
	 do_vmi_align_munmap (include/linux/maple_tree.h:621 mm/mmap.c:2547) 
	 do_vmi_munmap (mm/mmap.c:2729) 
	 __vm_munmap (mm/mmap.c:3010) 
	 elf_load (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:382 fs/binfmt_elf.c:408) 
	 load_elf_binary (fs/binfmt_elf.c:?) 
	 bprm_execve (fs/exec.c:? fs/exec.c:1854) 
	 kernel_execve (fs/exec.c:2009) 
	 kernel_init (init/main.c:1468) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 

	-> #2 (&rq->__lock){-.-.}-{2:2}:
	 lock_acquire (kernel/locking/lockdep.c:462 kernel/locking/lockdep.c:5753) 
	 _raw_spin_lock_nested (kernel/locking/spinlock.c:378) 
	 raw_spin_rq_lock_nested (kernel/sched/core.c:560) 
	 task_fork_fair (kernel/sched/fair.c:12644) 
	 sched_cgroup_fork (kernel/sched/sched.h:2024 kernel/sched/sched.h:2047 kernel/sched/core.c:4833) 
	 copy_process (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:67 include/linux/refcount.h:136 kernel/fork.c:1868 kernel/fork.c:2499) 
	 kernel_clone (kernel/fork.c:2898) 
	 user_mode_thread (kernel/fork.c:2977) 
	 rest_init (init/main.c:695) 
	 arch_call_rest_init+0xf/0x10 
	 start_kernel (init/main.c:1011) 
	 x86_64_start_reservations (??:?) 
	 x86_64_start_kernel (??:?) 
	 secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:461) 

	-> #1 (&p->pi_lock){-.-.}-{2:2}:
	 lock_acquire (kernel/locking/lockdep.c:462 kernel/locking/lockdep.c:5753) 
	 _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
	 try_to_wake_up (include/linux/spinlock.h:? kernel/sched/core.c:4252) 
	 up (kernel/locking/semaphore.c:189) 
	 console_unlock+0xcb/0x1e0a <- releases console semaphore 
	 vprintk_emit (arch/x86/include/asm/irqflags.h:? arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:1968 kernel/printk/printk.c:2302) 
	 _printk (kernel/printk/printk.c:?) 
	 _fat_msg (fs/fat/misc.c:?) 
	 fat_fill_super (fs/fat/inode.c:? fs/fat/inode.c:1646) 
	 mount_bdev (fs/super.c:?) 
	 legacy_get_tree (fs/fs_context.c:662) 
	 vfs_get_tree (fs/super.c:1784) 
	 path_mount (fs/namespace.c:? fs/namespace.c:3662) 
	 __se_sys_mount (fs/namespace.c:? fs/namespace.c:3882 fs/namespace.c:3864) 
	 do_syscall_64 (arch/x86/entry/common.c:?) 
	 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 

	-> #0 ((console_sem).lock){-.-.}-{2:2}:
	 check_prevs_add (kernel/locking/lockdep.c:223 kernel/locking/lockdep.c:3098 kernel/locking/lockdep.c:3253) 
	 __lock_acquire+0x2399/0x24f0 * Trying to get the sem_console 
	 lock_acquire (kernel/locking/lockdep.c:462 kernel/locking/lockdep.c:5753) 
	 _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
	 down_trylock (kernel/locking/semaphore.c:135) 
	 __down_trylock_console_sem (kernel/printk/printk.c:322) 
	 vprintk_emit (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 kernel/printk/printk.c:2621 kernel/printk/printk.c:2657 kernel/printk/printk.c:1923 kernel/printk/printk.c:2302) 
	 _printk (kernel/printk/printk.c:?) 
	 __warn_printk (include/linux/context_tracking.h:131 include/linux/context_tracking.h:145 kernel/panic.c:718) 
	 __stack_depot_save+0x685/0x690 * <- Got the *pool* lock 
	 kasan_set_track (mm/kasan/common.c:52) 
	 __kasan_slab_alloc (mm/kasan/common.c:331) 
	 kmem_cache_alloc (include/linux/kasan.h:188 mm/slab.h:763 mm/slub.c:3478 mm/slub.c:3486 mm/slub.c:3493 mm/slub.c:3502) 
	 btrfs_add_delayed_tree_ref (fs/btrfs/delayed-ref.c:1027) 
	 btrfs_free_tree_block (fs/btrfs/delayed-ref.h:316 fs/btrfs/extent-tree.c:3452) 
	 btrfs_force_cow_block (include/asm-generic/unaligned.h:52 fs/btrfs/accessors.h:681 fs/btrfs/accessors.h:721 fs/btrfs/ctree.c:574) 
	 btrfs_cow_block (include/asm-generic/unaligned.h:37 fs/btrfs/accessors.h:678 fs/btrfs/ctree.c:678 fs/btrfs/ctree.c:727) 
	 balance_level (fs/btrfs/ctree.c:960) 
	 btrfs_search_slot (fs/btrfs/ctree.c:2097) 
	 lookup_inline_extent_backref (fs/btrfs/accessors.h:371 fs/btrfs/extent-tree.c:814) 
	 __btrfs_free_extent (fs/btrfs/extent-tree.c:3113) 
	 __btrfs_run_delayed_refs (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:592 fs/btrfs/extent-tree.c:2045 fs/btrfs/extent-tree.c:2134) 
	 btrfs_run_delayed_refs (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 fs/btrfs/extent-tree.c:2238) 
	 btrfs_commit_transaction (fs/btrfs/transaction.c:2217) 
	 transaction_kthread (fs/btrfs/disk-io.c:1558) 
	 kthread (kernel/kthread.c:373) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 

	other info that might help us debug this:

	 Chain exists of:
	(console_sem).lock --> &rq->__lock --> pool_lock#2

	  Possible unsafe locking scenario:

		CPU0                    CPU1
		----                    ----
	   lock(pool_lock#2);
					lock(&rq->__lock);
					lock(pool_lock#2);
	   lock((console_sem).lock);

	*** DEADLOCK ***

	 11 locks held by btrfs-transacti/566:
	 #0: ffff8883221147d8 (&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at: transaction_kthread (fs/btrfs/disk-io.c:?) 
	 #1: ffff888322116390 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction (include/linux/spinlock.h:? fs/btrfs/transaction.c:285) 
	 #2: ffff8883221163b8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction (include/linux/spinlock.h:? fs/btrfs/transaction.c:285) 
	 #3: ffff8883221163e0 (btrfs_trans_commit_prep){.+.+}-{0:0}, at: btrfs_commit_transaction (fs/btrfs/transaction.c:2205) 
	 #4: ffff8889220f2240 (&head_ref->mutex){+.+.}-{3:3}, at: btrfs_delayed_ref_lock (include/linux/lockdep.h:288 fs/btrfs/delayed-ref.c:503) 
	 #5: ffff8885b372a980 (btrfs-extent-02){++++}-{3:3}, at: btrfs_lock_root_node (arch/x86/include/asm/current.h:41 fs/btrfs/locking.c:211 fs/btrfs/locking.c:217 fs/btrfs/locking.c:270) 
	 #6: ffff8888635b5538 (btrfs-extent-01){++++}-{3:3}, at: btrfs_tree_lock (arch/x86/include/asm/current.h:41 fs/btrfs/locking.c:211 fs/btrfs/locking.c:217) 
	 #7: ffff8885df3e2d30 (btrfs-extent-01/2){+.+.}-{3:3}, at: __btrfs_tree_lock (arch/x86/include/asm/current.h:41 fs/btrfs/locking.c:211) 
	 #8: ffff88832bb33490 (btrfs-extent-01/3){+.+.}-{3:3}, at: __btrfs_tree_lock (arch/x86/include/asm/current.h:41 fs/btrfs/locking.c:211) 
	 #9: ffff888708195c98 (btrfs-extent-01/5){+.+.}-{3:3}, at: __btrfs_tree_lock (arch/x86/include/asm/current.h:41 fs/btrfs/locking.c:211) 
	 #10: ffffffff850a2a70 (pool_lock#2){-.-.}-{2:2}, at: __stack_depot_save (lib/stackdepot.c:415) 

