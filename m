Return-Path: <linux-kernel+bounces-132202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DA189913D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A569F1F248CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D213C661;
	Thu,  4 Apr 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5lLinSO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3C13BC38;
	Thu,  4 Apr 2024 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269352; cv=none; b=aL4bLENDkxPO1eC8sVxNtjyhENhOxVezPUQq2b15M1n4dbClmAYA9PT1vzYSV6iPoOTvcl1r2iaHwudvmXULN8fTuriifvAZaPDpzNV6sU0a8/Y2FcQ8UL09lXvagYmKCbfRljMFUNIVh1tJxJKT3jvJn3q7+4qrmfyX7psrNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269352; c=relaxed/simple;
	bh=PAUB31Lbk7A5qSD46mLGpRw8cb8xNEjWeXK81ujDxhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmPTpCCwhDMTynDMzBSV4YcaRcN39iLPVOt4jGMuMoZZ6couNkVYq1bMxCwFX9WQvu7gjanzRvsT6MZtHdvDAG8lWOex94O1uXlRx1x7QFGSik29/CpTdCF+fEmTL0mxG5H3wRgK4WssGDew5sZGyi7F83bbWCgb7wrGiFbqZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5lLinSO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso616117f8f.2;
        Thu, 04 Apr 2024 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712269349; x=1712874149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYdP/XdMj9iS2AUFBFqglfEVdB66Vng54xvkJjnVjFI=;
        b=b5lLinSOfhLholpSxwWu9qg5tHWAleYUQi7KShl7N5ahQyAmqHInpRo9FXL8fdWbUW
         KRHBNJY3f7wlzvgtAyN6eZKcPuJ+LOpCyN2pcyUubpJVYckgz6TY2zmwKexVnm2szy18
         zhiB3kIV8xALi1SSGb76KY+QIegs41i22e647bTY7szN+CgoBPyYboSWKpvM4XUewWTN
         yU6KsYA6k+P9OytFPWtgjLsllj0jOcVQvHEAvyF1/2VxL0B9rTiEceCegrRvwLAni6L8
         ee7kxBF+muo05jl58ECmBY512W7NpXlCkflgj4jz3GQV8DZY5ohJjlRZvjW+h0tj7af4
         H41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269349; x=1712874149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYdP/XdMj9iS2AUFBFqglfEVdB66Vng54xvkJjnVjFI=;
        b=PsJV26LCf1qNCN0/k1/LWBOPauwBGpeAJRQxotmxjFhiZP1913nG6jxw+b/AdkTsU7
         zzBMi+erNfR2GApf6CDUOinrsMhTFYuajfChv43xglTvfNfyYI3JESrjaGm1SLldRkoS
         1pA/ugqvmZmTU3ev+sfQW7t0UjrxQVEek4b5+3XY3KVQd6aDp70lX+pKZ6aPXt8L8neM
         8/8wD+FOxdTleKj+xL9B2g76rF2hOYVvrQ6NG2CjiFUOgfGq50e2Zq21VqG4GbYvivPK
         POFd80lbY8O2lE1AHAqQSUK5K5EpfSypVY7X6qQV2zx5ODyyVc/XLZkbtq81qFPOLP3f
         fj+A==
X-Forwarded-Encrypted: i=1; AJvYcCXqFTAmOBsG9pt0DEI94tha/brsmeF2w1hEpokA08H8iTYQ1mYs5q3qU1vzPdkvVSa29S80PJqQjImia5cJNhtcuL8bs5XlNmsVYGEaTpisNOJBme72sPa8J0hCRqrZmCek
X-Gm-Message-State: AOJu0YzujRtpSFQaoMnMrs19Y7Oy6R31ipBnTSSxoIQBkAOrJowntKgK
	9bLhBGrijbTY+bugeqNO3Wra0IGn8XC0b9CVsKQhGwXETEkj2tbM9wfb9QerqowGqj06MxacwLi
	/a5TDmzB2/sdQxXCsIKoruQOl/aI=
X-Google-Smtp-Source: AGHT+IHNE4gaCBTlJ6Sf/cqNINe8TvWqiG0aBUbIQKuaZ6WnvS0rVqHd6cxqfvofKLdBvRbPhira79fIXUFcm9BIfQc=
X-Received: by 2002:a5d:4e8f:0:b0:343:8176:9861 with SMTP id
 e15-20020a5d4e8f000000b0034381769861mr492880wru.33.1712269348396; Thu, 04 Apr
 2024 15:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c98e7d06153a5177@google.com> <20240404143142.9e99f7127703892cb3166d64@linux-foundation.org>
In-Reply-To: <20240404143142.9e99f7127703892cb3166d64@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 15:22:17 -0700
Message-ID: <CAADnVQJ_x7LYuNMbbnb5=H3eEWqL8FYrk2GqdxU3ppMp8JZynQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] inconsistent lock state in __mmap_lock_do_trace_acquire_returned
To: Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>
Cc: syzbot <syzbot+76f802bc1dee8ba28a6e@syzkaller.appspotmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:31=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Wed, 03 Apr 2024 17:21:24 -0700 syzbot <syzbot+76f802bc1dee8ba28a6e@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
>
> Thanks.  I think this is due to BPF playing with mmap_lock from timer
> context.  Cc added.

Looks like lockdep false positive.
bpf side is doing mmap_read_trylock for that very reason.

Adding Song, in case he sees something I don't.

> > syzbot found the following issue on:
> >
> > HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.ker=
nel..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D132e732d180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daef2a55903e=
5791c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D76f802bc1dee8=
ba28a6e
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16d61b761=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D166ee109180=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/d=
isk-fe46a7dd.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmli=
nux-fe46a7dd.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d=
/bzImage-fe46a7dd.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+76f802bc1dee8ba28a6e@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: inconsistent lock state
> > 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> > --------------------------------
> > inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > syz-executor244/5087 [HC0[0]:SC1[1]:HE0:SE0] takes:
> > ffff8880b9538780 (lock#9){+.?.}-{2:2}, at: local_lock_acquire include/l=
inux/local_lock_internal.h:29 [inline]
> > ffff8880b9538780 (lock#9){+.?.}-{2:2}, at: __mmap_lock_do_trace_acquire=
_returned+0x7f/0x760 mm/mmap_lock.c:237
> > {SOFTIRQ-ON-W} state was registered at:
> >   lock_acquire kernel/locking/lockdep.c:5754 [inline]
> >   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
> >   local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
> >   __mmap_lock_do_trace_acquire_returned+0x97/0x760 mm/mmap_lock.c:237
> >   __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inli=
ne]
> >   mmap_read_lock include/linux/mmap_lock.h:147 [inline]
> >   process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
> >   process_vm_rw_core.constprop.0+0x7d7/0xa10 mm/process_vm_access.c:216
> >   process_vm_rw+0x301/0x360 mm/process_vm_access.c:284
> >   __do_sys_process_vm_readv mm/process_vm_access.c:296 [inline]
> >   __se_sys_process_vm_readv mm/process_vm_access.c:292 [inline]
> >   __x64_sys_process_vm_readv+0xe2/0x1c0 mm/process_vm_access.c:292
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > irq event stamp: 997
> > hardirqs last  enabled at (996): [<ffffffff8ad62d96>] __do_softirq+0x1d=
6/0x8de kernel/softirq.c:538
> > hardirqs last disabled at (997): [<ffffffff8ad5ff95>] __raw_spin_lock_i=
rq include/linux/spinlock_api_smp.h:117 [inline]
> > hardirqs last disabled at (997): [<ffffffff8ad5ff95>] _raw_spin_lock_ir=
q+0x45/0x50 kernel/locking/spinlock.c:170
> > softirqs last  enabled at (896): [<ffffffff819e467f>] spin_unlock_bh in=
clude/linux/spinlock.h:396 [inline]
> > softirqs last  enabled at (896): [<ffffffff819e467f>] bpf_link_settle k=
ernel/bpf/syscall.c:3181 [inline]
> > softirqs last  enabled at (896): [<ffffffff819e467f>] bpf_raw_tp_link_a=
ttach+0x35f/0x610 kernel/bpf/syscall.c:3842
> > softirqs last disabled at (995): [<ffffffff8151a149>] invoke_softirq ke=
rnel/softirq.c:428 [inline]
> > softirqs last disabled at (995): [<ffffffff8151a149>] __irq_exit_rcu ke=
rnel/softirq.c:633 [inline]
> > softirqs last disabled at (995): [<ffffffff8151a149>] irq_exit_rcu+0xb9=
/0x120 kernel/softirq.c:645
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(lock#9);
> >   <Interrupt>
> >     lock(lock#9);
> >
> >  *** DEADLOCK ***
> >
> > 6 locks held by syz-executor244/5087:
> >  #0: ffff88802247b1e8 (&tsk->futex_exit_mutex){+.+.}-{3:3}, at: futex_c=
leanup_begin kernel/futex/core.c:1091 [inline]
> >  #0: ffff88802247b1e8 (&tsk->futex_exit_mutex){+.+.}-{3:3}, at: futex_e=
xit_release+0x2a/0x220 kernel/futex/core.c:1143
> >  #1: ffffc90000a08cb0 (&(&ipvs->defense_work)->timer){..-.}-{0:0}, at: =
call_timer_fn+0x11a/0x5b0 kernel/time/timer.c:1789
> >  #2: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire=
 include/linux/rcupdate.h:298 [inline]
> >  #2: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock in=
clude/linux/rcupdate.h:750 [inline]
> >  #2: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xf=
2/0x1170 kernel/workqueue.c:2324
> >  #3: ffff8880b953d5d8 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x39e=
/0x1170 kernel/workqueue.c:2360
> >  #4: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire=
 include/linux/rcupdate.h:298 [inline]
> >  #4: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock in=
clude/linux/rcupdate.h:750 [inline]
> >  #4: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run =
kernel/trace/bpf_trace.c:2380 [inline]
> >  #4: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run3+0=
xf8/0x440 kernel/trace/bpf_trace.c:2421
> >  #5: ffff88807965b120 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylo=
ck include/linux/mmap_lock.h:165 [inline]
> >  #5: ffff88807965b120 (&mm->mmap_lock){++++}-{3:3}, at: stack_map_get_b=
uild_id_offset+0x1e8/0x7d0 kernel/bpf/stackmap.c:141
> >
> > stack backtrace:
> > CPU: 1 PID: 5087 Comm: syz-executor244 Not tainted 6.8.0-syzkaller-0895=
1-gfe46a7dd189e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 03/27/2024
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
> >  print_usage_bug kernel/locking/lockdep.c:3971 [inline]
> >  valid_state kernel/locking/lockdep.c:4013 [inline]
> >  mark_lock_irq kernel/locking/lockdep.c:4216 [inline]
> >  mark_lock+0x923/0xc60 kernel/locking/lockdep.c:4678
> >  mark_usage kernel/locking/lockdep.c:4567 [inline]
> >  __lock_acquire+0x13d4/0x3b30 kernel/locking/lockdep.c:5091
> >  lock_acquire kernel/locking/lockdep.c:5754 [inline]
> >  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
> >  local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
> >  __mmap_lock_do_trace_acquire_returned+0x97/0x760 mm/mmap_lock.c:237
> >  __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inlin=
e]
> >  mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
> >  stack_map_get_build_id_offset+0x5df/0x7d0 kernel/bpf/stackmap.c:141
> >  __bpf_get_stack+0x6bf/0x700 kernel/bpf/stackmap.c:449
> >  ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
> >  bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1975
> >  ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
> >  __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> >  __bpf_prog_run include/linux/filter.h:657 [inline]
> >  bpf_prog_run include/linux/filter.h:664 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> >  bpf_trace_run3+0x167/0x440 kernel/trace/bpf_trace.c:2421
> >  __bpf_trace_workqueue_queue_work+0x101/0x140 include/trace/events/work=
queue.h:23
> >  __traceiter_workqueue_queue_work+0x6c/0xc0 include/trace/events/workqu=
eue.h:23
> >  trace_workqueue_queue_work include/trace/events/workqueue.h:23 [inline=
]
> >  __queue_work+0x627/0x1170 kernel/workqueue.c:2382
> >  call_timer_fn+0x1a0/0x5b0 kernel/time/timer.c:1792
> >  expire_timers kernel/time/timer.c:1838 [inline]
> >  __run_timers+0x567/0xab0 kernel/time/timer.c:2408
> >  __run_timer_base kernel/time/timer.c:2419 [inline]
> >  __run_timer_base kernel/time/timer.c:2412 [inline]
> >  run_timer_base+0x111/0x190 kernel/time/timer.c:2428
> >  run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2438
> >  __do_softirq+0x218/0x8de kernel/softirq.c:554
> >  invoke_softirq kernel/softirq.c:428 [inline]
> >  __irq_exit_rcu kernel/softirq.c:633 [inline]
> >  irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [in=
line]
> >  sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
> >  </IRQ>
> >  <TASK>
> >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentr=
y.h:702
> > RIP: 0010:lock_acquire+0x1f2/0x540 kernel/locking/lockdep.c:5722
> > Code: c1 05 ea 37 97 7e 83 f8 01 0f 85 c8 02 00 00 9c 58 f6 c4 02 0f 85=
 b3 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 =
c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
> > RSP: 0018:ffffc90003457ba0 EFLAGS: 00000206
> > RAX: dffffc0000000000 RBX: 1ffff9200068af76 RCX: ffffffff816a5d5e
> > RDX: 0000000000000001 RSI: ffffffff8b0cba40 RDI: ffffffff8b6e88a0
> > RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff27b4e38
> > R10: ffffffff93da71c7 R11: 0000000000000000 R12: 0000000000000001
> > R13: 0000000000000000 R14: ffff88802247b1e8 R15: 0000000000000000
> >  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> >  __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
> >  futex_cleanup_begin kernel/futex/core.c:1091 [inline]
> >  futex_exit_release+0x2a/0x220 kernel/futex/core.c:1143
> >  exit_mm_release+0x19/0x30 kernel/fork.c:1652
> >  exit_mm kernel/exit.c:542 [inline]
> >  do_exit+0x865/0x2be0 kernel/exit.c:865
> >  do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
> >  __do_sys_exit_group kernel/exit.c:1038 [inline]
> >  __se_sys_exit_group kernel/exit.c:1036 [inline]
> >  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > RIP: 0033:0x7f44f7223a79
> > Code: 90 49 c7 c0 b8 ff ff ff be e7 00 00 00 ba 3c 00 00 00 eb 12 0f 1f=
 44 00 00 89 d0 0f 05 48 3d 00 f0 ff ff 77 1c f4 89 f0 0f 05 <48> 3d 00 f0 =
ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00
> > RSP: 002b:00007ffd5c6574d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f44f7223a79
> > RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> > RBP: 00007f44f729e2b0 R08: ffffffffffffffb8 R09: 00000000000f4240
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f44f729e2b0
> > R13: 0000000000000000 R14: 00007f44f729ed20 R15: 00007f44f71f4700
> >  </TASK>
> > ----------------
> > Code disassembly (best guess):
> >    0: c1 05 ea 37 97 7e 83    roll   $0x83,0x7e9737ea(%rip)        # 0x=
7e9737f1
> >    7: f8                      clc
> >    8: 01 0f                   add    %ecx,(%rdi)
> >    a: 85 c8                   test   %ecx,%eax
> >    c: 02 00                   add    (%rax),%al
> >    e: 00 9c 58 f6 c4 02 0f    add    %bl,0xf02c4f6(%rax,%rbx,2)
> >   15: 85 b3 02 00 00 48       test   %esi,0x48000002(%rbx)
> >   1b: 85 ed                   test   %ebp,%ebp
> >   1d: 74 01                   je     0x20
> >   1f: fb                      sti
> >   20: 48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> >   27: fc ff df
> > * 2a: 48 01 c3                add    %rax,%rbx <-- trapping instruction
> >   2d: 48 c7 03 00 00 00 00    movq   $0x0,(%rbx)
> >   34: 48 c7 43 08 00 00 00    movq   $0x0,0x8(%rbx)
> >   3b: 00
> >   3c: 48                      rex.W
> >   3d: 8b                      .byte 0x8b
> >   3e: 84                      .byte 0x84
> >   3f: 24                      .byte 0x24
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>

