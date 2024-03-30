Return-Path: <linux-kernel+bounces-125799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76B892C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D787D28291B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAE03D0C6;
	Sat, 30 Mar 2024 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcebhrcX"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757433CC2;
	Sat, 30 Mar 2024 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711821349; cv=none; b=fLUNNundkpJE5oTTuXDI90xbJqjijxfnKi+kSbKH7bk9lUtjbOSTBMDACRynl+ldYEIbF6BLZW3+vWU7c/wUK6yhyrPQ/tXVYphDhxcr/MCWUkUNZ53AbCC/chuUOBCt4/qKfbmemOPRhsjg1nsE7Q0bfvmMSxlvTYXV3G8VZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711821349; c=relaxed/simple;
	bh=ik2g1P7TG9Yx3+8PvYC/s/qfvAwLBzhIfnSIc26TTu0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTJesFFGH0fINWBBXff2OOV4ACTJl/aoYGqVZ/YYdEoxfk8Ayrvungm5bG/sJpsQAAdmAamgCuFFNSWsZUiugF0MAt/rtlOTBTTwHoOQ9ZrYyoFEPBbordK4CPX5wxXLe6sW5/KmmuD0ISVjN6o/7VE++eZ4GgoMXOjp/YUAKoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcebhrcX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-515d515e28dso721476e87.0;
        Sat, 30 Mar 2024 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711821344; x=1712426144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOQZIoFKTO2QCJ6CBMFzuCwe8UnbxiUOeRsA3gTbsy8=;
        b=UcebhrcXGxEbJs3lRPNPzG+Kax5RVJn3f4sPPQeKAEnvmQL1EmFp68o8oPjYxu0dTp
         PRRKXOfmg6AipIT3G/VwLBzA6CZOYxnui3gCRo4Zy5eL+xrzQo9yOyijQNTCVGbIdFO1
         TMpp8mIdX1hP1A/iZrEXzJGokL24GAkMysbWuztIUYbxVqfqhZfBUdZ06FVuEHfR4d1A
         hLNVrGKIr4mKq3zJadnMF2OJjfI8GzRfyjcxnXBbduCNnDhujdRNlhiE6dMbsg/rGgCo
         yDmutKDe4syZ7nGlbWmLmAT6GjBvuU6MmfNVV9YT/5QuGCy4hMactosJkxIpIlojxjG1
         pwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711821344; x=1712426144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOQZIoFKTO2QCJ6CBMFzuCwe8UnbxiUOeRsA3gTbsy8=;
        b=hahqbGR1I32wg1t6Um3d7AoIwGd2MZPywiD0Tb0liq16eNiltIiS72TCCLs1EwiI8Y
         luH/JGJYcT3ODE/5yH4lqy1JReAymhByAwXgsDgSS2ud5ZVStKNB7zwFaWUDz+1Rfu96
         BHtAWsUXDG1Qe435jUaNh8FsxtNT3LOE0F7xYi3WtAxssQw47mCr2Y9wkYYdw0JlPTyT
         OCPEoO9n0A8SrkGHsUzNpwU4+1NniYfRzyZjOmozoextqHseorUgynbxXuEmXX89J1IG
         uHxiQ0Vou9pSDzUD7Ju/LkdhorHesAGgFTTqgxHgUa0ElYZynZQSx80CcCTTAdGPRkes
         dTbA==
X-Forwarded-Encrypted: i=1; AJvYcCWT3MQbzMiQDZdZSbhcX8N9swRBcVntfWeUfksmmqvf8ScggFUvdVuXx7WLr557YhnoXi6vnXCCwX3sZpaAmYsoBa2I/sBHhqWApN+xB7A/fvXM1QqOxssAfc9mdBOjupUY
X-Gm-Message-State: AOJu0Ywsp0V8Z0CIu+umTidbhMZl25AsDs7We+PluLwnqErla64v3JNv
	+BoN+tHpGYnGSla6O9dVvRE3AeNVh0cwYMk8RZKPIBT5TKo9T5vno6r2GyvODTc=
X-Google-Smtp-Source: AGHT+IF6D8Ekke30B7iVuV32WJCIFLuZcBxQU9nz4GpyFbXHxsFWJfLYoo07v2SofGa8h+KYxnlXBg==
X-Received: by 2002:a05:6512:3f0b:b0:513:2c86:3498 with SMTP id y11-20020a0565123f0b00b005132c863498mr4450561lfa.48.1711821343788;
        Sat, 30 Mar 2024 10:55:43 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id d5-20020ac24c85000000b00513c9ad26e8sm961169lfl.34.2024.03.30.10.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 10:55:43 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Sat, 30 Mar 2024 18:55:41 +0100
To: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
Message-ID: <ZghSHWexmBHXpyA-@pc638.lan>
References: <000000000000f2f0c0061494e610@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f2f0c0061494e610@google.com>

On Tue, Mar 26, 2024 at 12:00:22PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11547a65180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1fa663a2100308ab6eab
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> ------------------------------------------------------
> syz-executor.3/6590 is trying to acquire lock:
> ffff8880b9529470 (krc.lock){..-.}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
> ffff8880b9529470 (krc.lock){..-.}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3359 [inline]
> ffff8880b9529470 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3444
> 
> but task is already holding lock:
> ffff888021a271f8 (&trie->lock){..-.}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&trie->lock){..-.}-{2:2}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>        trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451
>        bpf_prog_510c7248c5f60c92+0x2e/0x46
>        bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>        __bpf_prog_run include/linux/filter.h:657 [inline]
>        bpf_prog_run include/linux/filter.h:664 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>        bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
>        trace_timer_start include/trace/events/timer.h:52 [inline]
>        enqueue_timer+0x396/0x550 kernel/time/timer.c:663
>        internal_add_timer kernel/time/timer.c:688 [inline]
>        __mod_timer+0xa0e/0xeb0 kernel/time/timer.c:1183
>        call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
>        expire_timers kernel/time/timer.c:1843 [inline]
>        __run_timers kernel/time/timer.c:2408 [inline]
>        __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2419
>        run_timer_base kernel/time/timer.c:2428 [inline]
>        run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
>        __do_softirq+0x2bc/0x943 kernel/softirq.c:554
>        invoke_softirq kernel/softirq.c:428 [inline]
>        __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
>        irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
>        instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>        sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
>        asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
>        memory_is_poisoned_n mm/kasan/generic.c:130 [inline]
>        memory_is_poisoned mm/kasan/generic.c:161 [inline]
>        check_region_inline mm/kasan/generic.c:180 [inline]
>        kasan_check_range+0x4f/0x290 mm/kasan/generic.c:189
>        instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>        atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
>        queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
>        do_raw_spin_lock+0x14f/0x370 kernel/locking/spinlock_debug.c:116
>        spin_lock include/linux/spinlock.h:351 [inline]
>        lockref_get+0x15/0x60 lib/lockref.c:50
>        dget include/linux/dcache.h:333 [inline]
>        __traverse_mounts+0x3b4/0x580 fs/namei.c:1401
>        traverse_mounts fs/namei.c:1442 [inline]
>        handle_mounts fs/namei.c:1545 [inline]
>        step_into+0x5e5/0x1080 fs/namei.c:1842
>        walk_component fs/namei.c:2010 [inline]
>        link_path_walk+0x748/0xea0 fs/namei.c:2331
>        path_lookupat+0xa9/0x450 fs/namei.c:2484
>        filename_lookup+0x256/0x610 fs/namei.c:2514
>        user_path_at_empty+0x42/0x60 fs/namei.c:2921
>        do_readlinkat+0x118/0x3b0 fs/stat.c:499
>        __do_sys_readlink fs/stat.c:532 [inline]
>        __se_sys_readlink fs/stat.c:529 [inline]
>        __x64_sys_readlink+0x7f/0x90 fs/stat.c:529
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> -> #1 (&base->lock){-.-.}-{2:2}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>        lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
>        __mod_timer+0x1ca/0xeb0 kernel/time/timer.c:1132
>        queue_delayed_work_on+0x15a/0x260 kernel/workqueue.c:2595
>        kvfree_call_rcu+0x47f/0x790 kernel/rcu/tree.c:3472
>        rtnl_register_internal+0x482/0x590 net/core/rtnetlink.c:265
>        rtnl_register+0x36/0x80 net/core/rtnetlink.c:315
>        ip_rt_init+0x2f5/0x3a0 net/ipv4/route.c:3719
>        ip_init+0xe/0x20 net/ipv4/ip_output.c:1664
>        inet_init+0x3d8/0x580 net/ipv4/af_inet.c:2022
>        do_one_initcall+0x238/0x830 init/main.c:1241
>        do_initcall_level+0x157/0x210 init/main.c:1303
>        do_initcalls+0x3f/0x80 init/main.c:1319
>        kernel_init_freeable+0x435/0x5d0 init/main.c:1550
>        kernel_init+0x1d/0x2a0 init/main.c:1439
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> 
> -> #0 (krc.lock){..-.}-{2:2}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>        krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
>        add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3359 [inline]
>        kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3444
>        trie_update_elem+0x819/0xc10 kernel/bpf/lpm_trie.c:385
>        bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
>        generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1876
>        bpf_map_do_batch+0x3e0/0x690 kernel/bpf/syscall.c:5145
>        __sys_bpf+0x377/0x810
>        __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>        __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>        __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   krc.lock --> &base->lock --> &trie->lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&trie->lock);
>                                lock(&base->lock);
>                                lock(&trie->lock);
>   lock(krc.lock);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz-executor.3/6590:
>  #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
>  #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
>  #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
>  #1: ffff888021a271f8 (&trie->lock){..-.}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324
> 
> stack backtrace:
> CPU: 1 PID: 6590 Comm: syz-executor.3 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
>  add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3359 [inline]
>  kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3444
>  trie_update_elem+0x819/0xc10 kernel/bpf/lpm_trie.c:385
>  bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
>  generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1876
>  bpf_map_do_batch+0x3e0/0x690 kernel/bpf/syscall.c:5145
>  __sys_bpf+0x377/0x810
>  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7fe5f987dda9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe5fa6000c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fe5f99abf80 RCX: 00007fe5f987dda9
> RDX: 0000000000000038 RSI: 0000000020000240 RDI: 000000000000001a
> RBP: 00007fe5f98ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fe5f99abf80 R15: 00007ffe908076c8
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
Could you please test below:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d9642dd06c25..8867aac3668c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3467,19 +3467,19 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	 */
 	kmemleak_ignore(ptr);
 
-	// Set timer to drain after KFREE_DRAIN_JIFFIES.
-	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
-		schedule_delayed_monitor_work(krcp);
-
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
 
-	/*
-	 * Inline kvfree() after synchronize_rcu(). We can do
-	 * it from might_sleep() context only, so the current
-	 * CPU can pass the QS state.
-	 */
-	if (!success) {
+	if (success) {
+		// Set timer to drain after KFREE_DRAIN_JIFFIES.
+		if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
+			schedule_delayed_monitor_work(krcp);
+	} else {
+		/*
+		 * Inline kvfree() after synchronize_rcu(). We can do
+		 * it from might_sleep() context only, so the current
+		 * CPU can pass the QS state.
+		 */
 		debug_rcu_head_unqueue((struct rcu_head *) ptr);
 		synchronize_rcu();
 		kvfree(ptr);


--
Uladzislau Rezki

