Return-Path: <linux-kernel+bounces-20308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE3827D15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF11D281914
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941286124;
	Tue,  9 Jan 2024 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4nVBn/k"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F8610A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-203ae9903a6so1400103fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 18:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704768923; x=1705373723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKEEmXYU71cWRkWtuKZB9X6OaL4DNs/xYzTT01aO6C8=;
        b=D4nVBn/kdK2EoUNp9GYc8GzPs/qT9u97tYrjb0pQMLLPZZmwJaYt65R6iYvlQFLzzd
         h9JYObHy+aIvvqxl5VMUWRALNe7bzTB2rw7RZR3JC9HvwAkLjfD9TooqQzuDdgXerYQ3
         cefUD/iY/4X6SyN/s5yQ9QY8vT+Ryiz32z2yB51XZRVrCP/cnsqQmNxwHAR3waHJOzK4
         mqN/L1vaV30TsVhFvvfKpfpEzDOeAi3fDzyYPQT+V7liDFMtbU5MJqKe+ojLCwAc0yvS
         shTmq7wvfeNs0EdLW+yZLtKKu4TcYKtO2LoILLHE+XFazDCgEASCTFZhmNhyqOzot7Vv
         YquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704768923; x=1705373723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKEEmXYU71cWRkWtuKZB9X6OaL4DNs/xYzTT01aO6C8=;
        b=rz2ofZO7QIKTIXyNupHowF4MmtFQZ8UkAyPlL8qCRn1qagZxS4uWXPRVJa7cW8ruAq
         KkNOGQqN9ZVshUWYaihxLuGFjftfqhD695kQWae1IYIsCuEPjq/uktwjJGHvmAcamX67
         e1Vy7hmu6s0b83xS81Ikx+A0newVHPP7OOWx+PGUdTHxSTSKWA5BkPb8MDZjj2oDHxhT
         KxKsRcYyE6ZIo6v+M8eQHtLQBn+WfMuRCp7lkNY7UqF/w4OxY0I24DfBI7zpYAOkVyCS
         AEF4fhup252B+26BvOioVBIm28EAV8hZ6fDOAXEOq1Wiw1W4l/vjrMIZJ+rwXxxDNFUR
         yy/Q==
X-Gm-Message-State: AOJu0YxCYsT50j1U0EtZeQqErC3hPe9UJQhOVDvAIk5jvzH0EdZSJjeK
	PWLm0Y6PZbag3e1dcLViPjcvULLbw4pRHCGZMLw=
X-Google-Smtp-Source: AGHT+IHklgcQRP6NF3K22JPsqJWm7thJXCObEEb+5APNUBPhcWtT/bCtDVU1MAqihJMJFv0VmPFX5RJumt76pxedQ4E=
X-Received: by 2002:a05:6871:8285:b0:204:75bc:1e68 with SMTP id
 sq5-20020a056871828500b0020475bc1e68mr4726618oab.30.1704768922953; Mon, 08
 Jan 2024 18:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104054030.14733-1-xuewen.yan@unisoc.com> <ZZcJ-3MXF4BPqPtL@boqun-archlinux>
 <CAB8ipk9+BAFOa_4Dm2hs-bpfmMC_LHkaAb=JUVBq1CChX11wzA@mail.gmail.com> <ZZwivt2C7-oxuMJS@boqun-archlinux>
In-Reply-To: <ZZwivt2C7-oxuMJS@boqun-archlinux>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 9 Jan 2024 10:55:11 +0800
Message-ID: <CAB8ipk-E63myUvW7X=kX7t0_zW9wyBOcseyyh_tjOJNpzz=fZQ@mail.gmail.com>
Subject: Re: [PATCH] lock/lockdep: Add missing graph_unlock in validate_chain
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, ke.wang@unisoc.com, 
	zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi boqun

On Tue, Jan 9, 2024 at 12:30=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Fri, Jan 05, 2024 at 12:46:36PM +0800, Xuewen Yan wrote:
> [...]
> > >
> > > Are you hitting a real issue or this is found by code reading?
> >
> > Indeed, we hit a real issue:
> > One cpu did not call graph_unlock, as a result, caused a deadlock with
> > other cpus,
> > because any cpu calling raw_spin_lock would get the graph_lock first.
> >
>
> Could you share more details about the real issue you hit? For example,
> serial log? I asked because although the graph_unlock() makes logical
> sense, but that path should really not hit if lockdep works correctly.

The following is our stack:

first, there is a  scenario in our kernel tree:
get mutexA lock-->get rcu lock-->get mutexB lock
As a result, there is a warning about the chain:

[    7.344848][ T1@C0] reboot: Restarting system with command
'userrequested,recovery'
[    7.354028][ T1@C0]
[    7.354358][ T1@C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    7.354967][ T1@C0] [ BUG: Invalid wait context ]
[    7.355580][ T1@C0] 6.6.5-0-g53d4f6ea5e56-dirty-ab000013 #1
Tainted: G        W
[    7.356720][ T1@C0] -----------------------------
[    7.357326][ T1@C0] init/1 is trying to lock:
[    7.357894][ T1@C0] ffffffc07b0b5310 (kmsg_buf_lock){+.+.}-{3:3},
at: last_kmsg_handler+0x60/0xb8
[    7.359244][ T1@C0] other info that might help us debug this:
[    7.359982][ T1@C0] context-{4:4}
[    7.360420][ T1@C0] 2 locks held by init/1:
[    7.360967][ T1@C0]  #0: ffffffc08234d0b8
(system_transition_mutex){+.+.}-{3:3}, at:
__arm64_sys_reboot+0x130/0x27c
[    7.362353][ T1@C0]  #1: ffffffc0823c9a18
(rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x38
[    7.363568][ T1@C0] stack backtrace:
[    7.364038][ T1@C0] CPU: 0 PID: 1 Comm: init Tainted: G        W
      6.6.5-android14-0-g53d4f6ea5e56-dirty-ab000013 #1
[    7.365453][ T1@C0] Hardware name: Unisoc ***-base Board (DT)
[    7.366238][ T1@C0] Call trace:
[    7.366652][ T1@C0]  dump_backtrace+0xf8/0x148
[    7.367244][ T1@C0]  show_stack+0x20/0x30
[    7.367779][ T1@C0]  dump_stack_lvl+0x60/0x84
[    7.368372][ T1@C0]  __lock_acquire+0xc2c/0x3288
[    7.368982][ T1@C0]  lock_acquire+0x124/0x2b0
[    7.369556][ T1@C0]  __mutex_lock+0xa0/0xbfc
[    7.370122][ T1@C0]  mutex_lock_nested+0x2c/0x38
[    7.370730][ T1@C0]  last_kmsg_handler+0x60/0xb8 <<<<get mutex B
[    7.371494][ T1@C0]  kmsg_dump+0xf0/0x16c   <<<<rcu lock
[    7.372028][ T1@C0]  kernel_restart+0x100/0x11c
[    7.372626][ T1@C0]  __arm64_sys_reboot+0x1a8/0x27c
[    7.373270][ T1@C0]  invoke_syscall+0x60/0x11c
[    7.373857][ T1@C0]  el0_svc_common+0xb4/0xf0
[    7.374434][ T1@C0]  do_el0_svc+0x24/0x30
[    7.374967][ T1@C0]  el0_svc+0x50/0xe4
[    7.375467][ T1@C0]  el0t_64_sync_handler+0x68/0xbc
[    7.376109][ T1@C0]  el0t_64_sync+0x1a8/0x1ac

This warning should be caused by the order of taking the lock.
But when CONFIG_PREEMPT_RCU is turned on, I think it is reasonable to
take the mutex after taking the rcu-lock.
Maybe the logic of check_wait_context needs to be modified=EF=BC=9F

And then it occurs the following stack:

core0 get rdp_gp->nocb_gp_lock and then try to get graph_lock:

-000|queued_spin_lock_slowpath(lock =3D 0xFFFFFFC08291BBC8, val =3D 0)
-001|queued_spin_lock()
-001|lockdep_lock()
-001|graph_lock()
-002|lookup_chain_cache_add()
-002|validate_chain()
-003|lock_acquire(lock =3D 0xFFFFFF817F211D98, subclass =3D 0, trylock =3D
0, read =3D 0, check =3D 1, nest_lock =3D 0x0, ip =3D 18446743800981533176)
-004|__raw_spin_lock_irqsave()
    |  lock =3D 0xFFFFFF817F211D80 -> (
    |    raw_lock =3D (
    |      val =3D (counter =3D 0),
    |      locked =3D 0,
    |      pending =3D 0,
    |      locked_pending =3D 0,
    |      tail =3D 0),
    |    magic =3D 3735899821,
    |    owner_cpu =3D 4294967295,
    |    owner =3D 0xFFFFFFFFFFFFFFFF,
    |    dep_map =3D (key =3D 0xFFFFFFC082F12C88, class_cache =3D
(0xFFFFFFC0825378E0, 0x0), name =3D 0xFFFFFFC081541039, wait_type_outer
=3D 0, wait_type_inner =3D 2, lock_type =3D 0))
    |  flags =3D 0
    |
 110|
-004|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F211D80)
-005|lock_timer_base(inline)
-005|__mod_timer.llvm.7968396489078322347(timer =3D 0xFFFFFF817F2A88D0,
expires =3D 4294893461, options =3D 0)
-006|mod_timer(inline)
-006|wake_nocb_gp_defer(inline)
-006|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F2A8680, was_alldone =3D ?, fl=
ags =3D ?)
-007|__call_rcu_common(inline)
-007|call_rcu(head =3D 0xFFFFFFC0822E0B58, func =3D ?)
-008|call_rcu_hurry(inline)
-008|rcu_sync_call(inline)
-008|rcu_sync_func(rhp =3D 0xFFFFFFC0822E0B58)
-009|rcu_do_batch(rdp =3D 0xFFFFFF817F266680)
-010|nocb_cb_wait(inline)
-010|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F266680)
-011|kthread(_create =3D 0xFFFFFF8080363740)
-012|ret_from_fork(asm)

However, the grapg_lock is owned by core1, and it try to get
rdp_gp->nocb_gp_lock, and it caused the deadlock.
But we do not see where the core do not unlock the graph_lock:

-000|queued_spin_lock_slowpath(lock =3D 0xFFFFFF817F2A8A80, val =3D ?)
-001|queued_spin_lock(inline)
-001|do_raw_spin_lock(lock =3D 0xFFFFFF817F2A8A80)
-002|__raw_spin_lock_irqsave(inline)
-002|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F2A8A80)
-003|wake_nocb_gp_defer(inline)
-003|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F30B680, was_alldone =3D ?, fl=
ags =3D ?)
-004|__call_rcu_common(inline)
-004|call_rcu(head =3D 0xFFFFFFC082EECC28, func =3D ?)
-005|call_rcu_zapped(inline)
-005|free_zapped_rcu(ch =3D ?)
-006|rcu_do_batch(rdp =3D 0xFFFFFF817F245680)
-007|nocb_cb_wait(inline)
-007|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F245680)
-008|kthread(_create =3D 0xFFFFFF80803122C0)
-009|ret_from_fork(asm)

Based on this, we read the lockdep code, and found the check_prev_add's log=
ic.

But now we reproduce the scenario although we add the graph_unlock in
check_prev_add().
So this is not the root-cause of our problem. And we are also still debuggi=
ng.
We would be very grateful if you could give us some suggestions.

Thanks!

---
BRs
xuewen


> Thanks!
>
> Regards,
> Boqun
>
> > Thanks!

