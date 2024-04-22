Return-Path: <linux-kernel+bounces-153848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6878AD423
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EBB1F21E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B86154C00;
	Mon, 22 Apr 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giBiEiVT"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE31474D3;
	Mon, 22 Apr 2024 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811483; cv=none; b=pfWhsr76HEUHdSZJwCGM74MPYKja8O9dZMyn80JFP40mfpIbB4wu2SmsDdax7jdrGjrCXm6VKxoRw6jiMJ922vg8L6D483deDg33nkP+7ncIUTDgv8zj6oxHkkEGpP763mO0TcXXWANmP7mcebDvjq3YHTSgiRXg2H23A4lMj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811483; c=relaxed/simple;
	bh=m9hdpmWgAwwXLyTdINbjBbsv/0OUJZ3zGrO25w57cp0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=m41k1kSwCAxzzD7Uh3z9pUEfpuhzKMPvmxpBCIy09ve4SykNgGnKzMrenhLxv1wa7n71Ndh5auCPMIBhuQdMDZejQf4cNJqgR7Ped5Foy8PEXapwwp3Aod4YKB5/b1EOTOtKJrbZRn8Wdb5/1LS1+PcZGY+/JRYpl4gUMkfk4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giBiEiVT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2dd615b6c44so19765561fa.0;
        Mon, 22 Apr 2024 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713811479; x=1714416279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yIbA28a+VBS8R9f8t8mPsb+qJBgfHQN6diSlvHLDKOE=;
        b=giBiEiVTVVzi34OXMVjFnUBqGT08ItRJOPFUSiuvODeWLproH9A1Xl7dgtSRoAszjT
         cHvP3FvaKsZ1JhxubIfWWwg35eVnd73YShSrrmPOM0QgETmkeWDdjRt+U/pOj02+HoEU
         UmTrlRjEL7EjFmP4K7ZU+qAVFcold6qjMG+QliOoUNIit1EZd5/TEEHSyG5G+EoBIU6+
         HfDNM4iS2tD9jhvr8iYiG2Q+gN4rYiJ0JxNv4UPVn/7O/eVtS2SS+W+/0i8m5OUnmDcc
         EEeyL3MmQQ59YIqgnbgg7X9qUS/0XZEbitDWtHe5MaNa/fGMZnIrMlcK+j+BCUPqs5Tt
         krhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713811479; x=1714416279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIbA28a+VBS8R9f8t8mPsb+qJBgfHQN6diSlvHLDKOE=;
        b=YlDScmN8HC1IyIEju1u37igyFdJa/Moemkjt+7rUcJi/AHvN46u5b4/yvEG6a9Ai37
         QtPOVln3KNCFviuEXuoJvYc+n4YVqOqhEESNPk2cqyKoNTPMn5BUb+PDWHYrPxa5BPQ6
         e8qsfvGoKiHCnjE4hdbyhR2Hvqb8ZLHD6kvHmiZmYQeky/S+8h2uDFycgOe63R7VUz5B
         OnPTbW2r7EMVGmc9nMhSnEaM68RF9jHIn6yybuYmIzFwjs+a+vT38n6LMJ4xobjmZZSb
         3CWPXZ54JS7kunyODkqe3KRcqCqvgHXIwLAGjqUsoAMRVGVHinvqf3b2QjSOZtmCZrKY
         591Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfLWvFgEEkNRvLWch3JeaGIziFn52TWHRTUA0iO1RFpcXt+9zLHf+FHofKmPN+uRbGTGVLVz5CmZJC0+Xn19AUvKd5/WHH6MfCWwAOtLVIXUYHtbFtoerTbMzi/I0fcy5hCGKPGvOoYtjY8PBLRg==
X-Gm-Message-State: AOJu0YyMzOgFPdPbktN6p8QC+L2Sp7Q31ZovAAfdk/rgdMpYDeqj4sLD
	WlM6vnE40p5R4k72bgfTfQBOCKIfyZvz+utMy7e60/lqcFu4iO2gf1soLuzU7JObg4jdXjXp5tA
	Yr4fe9m5fhFaVsggksHn97KE44n4=
X-Google-Smtp-Source: AGHT+IHvRSABhd84+/WNH4uDtuD5xYag2bdZ9/oYZin1ISl19dZqPFPnNCu2eM4fBFlEd1YmMyX+CRbkUUN6aX0uPAg=
X-Received: by 2002:a2e:87cc:0:b0:2d4:3e82:117e with SMTP id
 v12-20020a2e87cc000000b002d43e82117emr8783426ljj.32.1713811479353; Mon, 22
 Apr 2024 11:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Mon, 22 Apr 2024 11:44:27 -0700
Message-ID: <CAJg=8jw=5vKSE8ibuim0uFKQq=sA3sWULqM5auqKNJCq0=kqGg@mail.gmail.com>
Subject: possible deadlock in __perf_event_task_sched_in
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We would like to report the following bug which has been found by our
modified version of syzkaller.

We found this report (https://lkml.org/lkml/2021/9/12/333) that seems
to have a similar but different stack trace. We are unable to tell,
though, whether it is the same cause. We=E2=80=99d be grateful for your
advice.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
description: possible deadlock in __perf_event_task_sched_in
affected file: kernel/events/core.c
kernel version: v5.15.156
kernel commit: c52b9710c83d3b8ab63bb217cc7c8b61e13f12cd
git tree: upstream
kernel config: attached
crash reproducer: attached
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Crash log:
WARNING: possible circular locking dependency detected
5.15.156 #1 Not tainted
------------------------------------------------------
syz-executor.2/150802 is trying to acquire lock:
ffffffff8b976cd8 ((console_sem).lock){-.-.}-{2:2}, at:
down_trylock+0xe/0x60 kernel/locking/semaphore.c:138

but task is already holding lock:
ffff88809b9f8c20 (&ctx->lock){....}-{2:2}, at: perf_ctx_lock
kernel/events/core.c:169 [inline]
ffff88809b9f8c20 (&ctx->lock){....}-{2:2}, at:
perf_event_context_sched_in kernel/events/core.c:4009 [inline]
ffff88809b9f8c20 (&ctx->lock){....}-{2:2}, at:
__perf_event_task_sched_in+0x4bc/0xb90 kernel/events/core.c:4071

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (&ctx->lock){....}-{2:2}:
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
    perf_event_context_sched_out kernel/events/core.c:3623 [inline]
    __perf_event_task_sched_out+0x6e0/0x2110 kernel/events/core.c:3732
    perf_event_task_sched_out include/linux/perf_event.h:1252 [inline]
    prepare_task_switch kernel/sched/core.c:4834 [inline]
    context_switch kernel/sched/core.c:4982 [inline]
    __schedule+0x16d1/0x5560 kernel/sched/core.c:6376
    preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6552
    preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:34
    try_to_wake_up+0xa11/0x1580 kernel/sched/core.c:4152
    wake_up_process kernel/sched/core.c:4215 [inline]
    wake_up_q+0x7e/0xf0 kernel/sched/core.c:950
    futex_wake+0x3e9/0x490 kernel/futex/core.c:1702
    do_futex+0x2cc/0x1960 kernel/futex/core.c:3987
    __do_sys_futex+0xe7/0x3d0 kernel/futex/core.c:4059
    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    entry_SYSCALL_64_after_hwframe+0x66/0xd0

-> #2 (&rq->__lock){-.-.}-{2:2}:
    _raw_spin_lock_nested+0x30/0x40 kernel/locking/spinlock.c:368
    raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:475
    raw_spin_rq_lock kernel/sched/sched.h:1326 [inline]
    rq_lock kernel/sched/sched.h:1621 [inline]
    task_fork_fair+0x70/0x500 kernel/sched/fair.c:11480
    sched_cgroup_fork+0x343/0x480 kernel/sched/core.c:4466
    copy_process+0x39c8/0x8730 kernel/fork.c:2320
    kernel_clone+0xe7/0x9f0 kernel/fork.c:2604
    kernel_thread+0xb8/0xf0 kernel/fork.c:2656
    rest_init+0x23/0x460 init/main.c:704
    start_kernel+0x465/0x486 init/main.c:1138
    secondary_startup_64_no_verify+0xb0/0xbb

-> #1 (&p->pi_lock){-.-.}-{2:2}:
    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
    _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
    try_to_wake_up+0xac/0x1580 kernel/sched/core.c:4030
    up+0x75/0xb0 kernel/locking/semaphore.c:190
    __up_console_sem+0xa4/0xc0 kernel/printk/printk.c:256
    console_unlock+0x564/0xb70 kernel/printk/printk.c:2760
    vga_remove_vgacon drivers/gpu/vga/vgaarb.c:211 [inline]
    vga_remove_vgacon.cold+0x99/0x9e drivers/gpu/vga/vgaarb.c:192
    drm_aperture_remove_conflicting_pci_framebuffers+0x7f/0x230
drivers/gpu/drm/drm_aperture.c:343
    bochs_pci_probe+0x101/0x870 drivers/gpu/drm/tiny/bochs.c:645
    local_pci_probe+0xe1/0x1a0 drivers/pci/pci-driver.c:323
    pci_call_probe drivers/pci/pci-driver.c:380 [inline]
    __pci_device_probe drivers/pci/pci-driver.c:405 [inline]
    pci_device_probe+0x3dd/0x6f0 drivers/pci/pci-driver.c:448
    call_driver_probe drivers/base/dd.c:516 [inline]
    really_probe+0x245/0xcd0 drivers/base/dd.c:595
    __driver_probe_device+0x2f0/0x460 drivers/base/dd.c:755
    driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:785
    __driver_attach+0x29a/0x500 drivers/base/dd.c:1164
    bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
    bus_add_driver+0x3ae/0x640 drivers/base/bus.c:618
    driver_register+0x23c/0x3d0 drivers/base/driver.c:240
    bochs_init+0x78/0x86 drivers/gpu/drm/tiny/bochs.c:722
    do_one_initcall+0x103/0x540 init/main.c:1300
    do_initcall_level init/main.c:1373 [inline]
    do_initcalls init/main.c:1389 [inline]
    do_basic_setup init/main.c:1408 [inline]
    kernel_init_freeable+0x6b4/0x73d init/main.c:1613
    kernel_init+0x1a/0x1d0 init/main.c:1504
    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:300

-> #0 ((console_sem).lock){-.-.}-{2:2}:
    check_prev_add kernel/locking/lockdep.c:3053 [inline]
    check_prevs_add kernel/locking/lockdep.c:3172 [inline]
    validate_chain kernel/locking/lockdep.c:3788 [inline]
    __lock_acquire+0x2a41/0x5340 kernel/locking/lockdep.c:5012
    lock_acquire kernel/locking/lockdep.c:5623 [inline]
    lock_acquire+0x1ab/0x4e0 kernel/locking/lockdep.c:5588
    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
    _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
    down_trylock+0xe/0x60 kernel/locking/semaphore.c:138
    __down_trylock_console_sem+0x40/0x120 kernel/printk/printk.c:239
    console_trylock kernel/printk/printk.c:2575 [inline]
    console_trylock_spinning kernel/printk/printk.c:1867 [inline]
    vprintk_emit+0x14b/0x520 kernel/printk/printk.c:2273
    vprintk+0x72/0x90 kernel/printk/printk_safe.c:45
    _printk+0xba/0xed kernel/printk/printk.c:2299
    ex_handler_msr.cold+0xb7/0x147 arch/x86/mm/extable.c:90
    fixup_exception+0x973/0xbb0 arch/x86/mm/extable.c:187
    __exc_general_protection arch/x86/kernel/traps.c:601 [inline]
    exc_general_protection+0xed/0x2f0 arch/x86/kernel/traps.c:562
    asm_exc_general_protection+0x22/0x30 arch/x86/include/asm/idtentry.h:56=
2
    __wrmsr arch/x86/include/asm/msr.h:103 [inline]
    native_write_msr arch/x86/include/asm/msr.h:154 [inline]
    wrmsrl arch/x86/include/asm/msr.h:271 [inline]
    __x86_pmu_enable_event arch/x86/events/intel/../perf_event.h:1120 [inli=
ne]
    intel_pmu_enable_event+0x2d9/0xff0 arch/x86/events/intel/core.c:2694
    x86_pmu_start+0x1cc/0x270 arch/x86/events/core.c:1520
    x86_pmu_enable+0x481/0xdf0 arch/x86/events/core.c:1337
    perf_pmu_enable kernel/events/core.c:1243 [inline]
    perf_pmu_enable kernel/events/core.c:1239 [inline]
    perf_event_context_sched_in kernel/events/core.c:4033 [inline]
    __perf_event_task_sched_in+0x79c/0xb90 kernel/events/core.c:4071
    perf_event_task_sched_in include/linux/perf_event.h:1229 [inline]
    finish_task_switch.isra.0+0x554/0xc80 kernel/sched/core.c:4899
    context_switch kernel/sched/core.c:5033 [inline]
    __schedule+0xb5c/0x5560 kernel/sched/core.c:6376
    preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6552
    preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:34
    __raw_spin_unlock include/linux/spinlock_api_smp.h:152 [inline]
    _raw_spin_unlock+0x36/0x40 kernel/locking/spinlock.c:186
    spin_unlock include/linux/spinlock.h:403 [inline]
    zap_pte_range mm/memory.c:1435 [inline]
    zap_pmd_range mm/memory.c:1494 [inline]
    zap_pud_range mm/memory.c:1523 [inline]
    zap_p4d_range mm/memory.c:1544 [inline]
    unmap_page_range+0x1090/0x2a40 mm/memory.c:1565
    unmap_single_vma+0x198/0x310 mm/memory.c:1610
    unmap_vmas+0x16d/0x2f0 mm/memory.c:1642
    exit_mmap+0x1d0/0x620 mm/mmap.c:3186
    __mmput+0x122/0x4b0 kernel/fork.c:1126
    mmput+0x58/0x60 kernel/fork.c:1147
    exit_mm kernel/exit.c:548 [inline]
    do_exit+0xa8f/0x2930 kernel/exit.c:859
    do_group_exit+0x125/0x310 kernel/exit.c:994
    get_signal+0x337/0x26b0 kernel/signal.c:2889
    arch_do_signal_or_restart+0x2a6/0x1c10 arch/x86/kernel/signal.c:867
    handle_signal_work kernel/entry/common.c:154 [inline]
    exit_to_user_mode_loop kernel/entry/common.c:178 [inline]
    exit_to_user_mode_prepare+0x13d/0x280 kernel/entry/common.c:214
    irqentry_exit_to_user_mode+0x5/0x40 kernel/entry/common.c:320
    exc_page_fault+0xc6/0x170 arch/x86/mm/fault.c:1535
    asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:568

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &rq->__lock --> &ctx->lock

 Possible unsafe locking scenario:

    CPU0                CPU1
    ----                ----
  lock(&ctx->lock);
                            lock(&rq->__lock);
                            lock(&ctx->lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

2 locks held by syz-executor.2/150802:
 #0: ffff888063e42e20 (&cpuctx_lock){-...}-{2:2}, at: perf_ctx_lock
kernel/events/core.c:167 [inline]
 #0: ffff888063e42e20 (&cpuctx_lock){-...}-{2:2}, at:
perf_event_context_sched_in kernel/events/core.c:4009 [inline]
 #0: ffff888063e42e20 (&cpuctx_lock){-...}-{2:2}, at:
__perf_event_task_sched_in+0x4ab/0xb90 kernel/events/core.c:4071
 #1: ffff88809b9f8c20 (&ctx->lock){....}-{2:2}, at: perf_ctx_lock
kernel/events/core.c:169 [inline]
 #1: ffff88809b9f8c20 (&ctx->lock){....}-{2:2}, at:
perf_event_context_sched_in kernel/events/core.c:4009 [inline]
 #1: ffff88809b9f8c20 (&ctx->lock){....}-{2:2}, at:
__perf_event_task_sched_in+0x4bc/0xb90 kernel/events/core.c:4071

stack backtrace:
CPU: 0 PID: 150802 Comm: syz-executor.2 Not tainted 5.15.156 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x268/0x310 kernel/locking/lockdep.c:2133
 check_prev_add kernel/locking/lockdep.c:3053 [inline]
 check_prevs_add kernel/locking/lockdep.c:3172 [inline]
 validate_chain kernel/locking/lockdep.c:3788 [inline]
 __lock_acquire+0x2a41/0x5340 kernel/locking/lockdep.c:5012
 lock_acquire kernel/locking/lockdep.c:5623 [inline]
 lock_acquire+0x1ab/0x4e0 kernel/locking/lockdep.c:5588
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 down_trylock+0xe/0x60 kernel/locking/semaphore.c:138
 __down_trylock_console_sem+0x40/0x120 kernel/printk/printk.c:239
 console_trylock kernel/printk/printk.c:2575 [inline]
 console_trylock_spinning kernel/printk/printk.c:1867 [inline]
 vprintk_emit+0x14b/0x520 kernel/printk/printk.c:2273
 vprintk+0x72/0x90 kernel/printk/printk_safe.c:45
 _printk+0xba/0xed kernel/printk/printk.c:2299
 ex_handler_msr.cold+0xb7/0x147 arch/x86/mm/extable.c:90
 fixup_exception+0x973/0xbb0 arch/x86/mm/extable.c:187
 __exc_general_protection arch/x86/kernel/traps.c:601 [inline]
 exc_general_protection+0xed/0x2f0 arch/x86/kernel/traps.c:562
 asm_exc_general_protection+0x22/0x30 arch/x86/include/asm/idtentry.h:562
RIP: 0010:__wrmsr arch/x86/include/asm/msr.h:103 [inline]
RIP: 0010:native_write_msr arch/x86/include/asm/msr.h:154 [inline]
RIP: 0010:wrmsrl arch/x86/include/asm/msr.h:271 [inline]
RIP: 0010:__x86_pmu_enable_event
arch/x86/events/intel/../perf_event.h:1120 [inline]
RIP: 0010:intel_pmu_enable_event+0x2d9/0xff0 arch/x86/events/intel/core.c:2=
694
Code: ea 03 49 81 cc 00 00 40 00 4d 21 f4 80 3c 02 00 0f 85 5b 0c 00
00 44 8b ab 70 01 00 00 4c 89 e2 44 89 e0 48 c1 ea 20 44 89 e9 <0f> 30
0f 1f 44 00 00 e8 1b 32 75 00 48 83 c4 20 5b 5d 41 5c 41 5d
RSP: 0018:ffffc900115af348 EFLAGS: 00010002
RAX: 0000000000530000 RBX: ffff888019dd6a50 RCX: 0000000000000188
RDX: 0000000000000002 RSI: ffffffff81029464 RDI: ffff888019dd6bc0
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff888063e22ab7
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000200530000
R13: 0000000000000188 R14: ffffffffffffffff R15: ffff888019dd6bb0
 x86_pmu_start+0x1cc/0x270 arch/x86/events/core.c:1520
 x86_pmu_enable+0x481/0xdf0 arch/x86/events/core.c:1337
 perf_pmu_enable kernel/events/core.c:1243 [inline]
 perf_pmu_enable kernel/events/core.c:1239 [inline]
 perf_event_context_sched_in kernel/events/core.c:4033 [inline]
 __perf_event_task_sched_in+0x79c/0xb90 kernel/events/core.c:4071
 perf_event_task_sched_in include/linux/perf_event.h:1229 [inline]
 finish_task_switch.isra.0+0x554/0xc80 kernel/sched/core.c:4899
 context_switch kernel/sched/core.c:5033 [inline]
 __schedule+0xb5c/0x5560 kernel/sched/core.c:6376
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6552
 preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:34
 __raw_spin_unlock include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock+0x36/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:403 [inline]
 zap_pte_range mm/memory.c:1435 [inline]
 zap_pmd_range mm/memory.c:1494 [inline]
 zap_pud_range mm/memory.c:1523 [inline]
 zap_p4d_range mm/memory.c:1544 [inline]
 unmap_page_range+0x1090/0x2a40 mm/memory.c:1565
 unmap_single_vma+0x198/0x310 mm/memory.c:1610
 unmap_vmas+0x16d/0x2f0 mm/memory.c:1642
 exit_mmap+0x1d0/0x620 mm/mmap.c:3186
 __mmput+0x122/0x4b0 kernel/fork.c:1126
 mmput+0x58/0x60 kernel/fork.c:1147
 exit_mm kernel/exit.c:548 [inline]
 do_exit+0xa8f/0x2930 kernel/exit.c:859
 do_group_exit+0x125/0x310 kernel/exit.c:994
 get_signal+0x337/0x26b0 kernel/signal.c:2889
 arch_do_signal_or_restart+0x2a6/0x1c10 arch/x86/kernel/signal.c:867
 handle_signal_work kernel/entry/common.c:154 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:178 [inline]
 exit_to_user_mode_prepare+0x13d/0x280 kernel/entry/common.c:214
 irqentry_exit_to_user_mode+0x5/0x40 kernel/entry/common.c:320
 exc_page_fault+0xc6/0x170 arch/x86/mm/fault.c:1535
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0033:0x7f7cb7755e07
Code: Unable to access opcode bytes at RIP 0x7f7cb7755ddd.
RSP: 002b:00007f7cb5d14df0 EFLAGS: 00010246
RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00007f7cb7831920 RSI: 0000000000000000 RDI: 00007f7cb840e000
RBP: 00007f7cb5d14ef0 R08: 00007f7cb840e000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7cb783ffdc R14: 00007f7cb7840512 R15: 00007f7cb5cf6000
 </TASK>
Call Trace:
 <TASK>
 x86_pmu_start+0x1cc/0x270 arch/x86/events/core.c:1520
 x86_pmu_enable+0x481/0xdf0 arch/x86/events/core.c:1337
 perf_pmu_enable kernel/events/core.c:1243 [inline]
 perf_pmu_enable kernel/events/core.c:1239 [inline]
 perf_event_context_sched_in kernel/events/core.c:4033 [inline]
 __perf_event_task_sched_in+0x79c/0xb90 kernel/events/core.c:4071
 perf_event_task_sched_in include/linux/perf_event.h:1229 [inline]
 finish_task_switch.isra.0+0x554/0xc80 kernel/sched/core.c:4899
 context_switch kernel/sched/core.c:5033 [inline]
 __schedule+0xb5c/0x5560 kernel/sched/core.c:6376
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6552
 preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:34
 __raw_spin_unlock include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock+0x36/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:403 [inline]
 zap_pte_range mm/memory.c:1435 [inline]
 zap_pmd_range mm/memory.c:1494 [inline]
 zap_pud_range mm/memory.c:1523 [inline]
 zap_p4d_range mm/memory.c:1544 [inline]
 unmap_page_range+0x1090/0x2a40 mm/memory.c:1565
 unmap_single_vma+0x198/0x310 mm/memory.c:1610
 unmap_vmas+0x16d/0x2f0 mm/memory.c:1642
 exit_mmap+0x1d0/0x620 mm/mmap.c:3186
 __mmput+0x122/0x4b0 kernel/fork.c:1126
 mmput+0x58/0x60 kernel/fork.c:1147
 exit_mm kernel/exit.c:548 [inline]
 do_exit+0xa8f/0x2930 kernel/exit.c:859
 do_group_exit+0x125/0x310 kernel/exit.c:994
 get_signal+0x337/0x26b0 kernel/signal.c:2889
 arch_do_signal_or_restart+0x2a6/0x1c10 arch/x86/kernel/signal.c:867
 handle_signal_work kernel/entry/common.c:154 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:178 [inline]
 exit_to_user_mode_prepare+0x13d/0x280 kernel/entry/common.c:214
 irqentry_exit_to_user_mode+0x5/0x40 kernel/entry/common.c:320
 exc_page_fault+0xc6/0x170 arch/x86/mm/fault.c:1535
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0033:0x7f7cb7755e07
Code: Unable to access opcode bytes at RIP 0x7f7cb7755ddd.
RSP: 002b:00007f7cb5d14df0 EFLAGS: 00010246
RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00007f7cb7831920 RSI: 0000000000000000 RDI: 00007f7cb840e000
RBP: 00007f7cb5d14ef0 R08: 00007f7cb840e000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7cb783ffdc R14: 00007f7cb7840512 R15: 00007f7cb5cf6000
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:    03 49 81        add -0x7f(%rcx),%ecx
   3:    cc              int3
   4:    00 00           add %al,(%rax)
   6:    40 00 4d 21     rex add %cl,0x21(%rbp)
   a:    f4              hlt
   b:    80 3c 02 00     cmpb   $0x0,(%rdx,%rax,1)
   f:    0f 85 5b 0c 00 00   jne 0xc70
  15:    44 8b ab 70 01 00 00     mov 0x170(%rbx),%r13d
  1c:    4c 89 e2        mov %r12,%rdx
  1f:    44 89 e0        mov %r12d,%eax
  22:    48 c1 ea 20     shr $0x20,%rdx
  26:    44 89 e9        mov %r13d,%ecx
* 29:    0f 30           wrmsr <-- trapping instruction
  2b:    0f 1f 44 00 00  nopl   0x0(%rax,%rax,1)
  30:    e8 1b 32 75 00  call   0x753250
  35:    48 83 c4 20     add $0x20,%rsp
  39:    5b              pop %rbx
  3a:    5d              pop %rbp
  3b:    41 5c           pop %r12
  3d:    41 5d           pop %r13
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Wishing you a nice day!

Best,
Marius

