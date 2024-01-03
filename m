Return-Path: <linux-kernel+bounces-15838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C025E823421
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92821C23BFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B81C691;
	Wed,  3 Jan 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNkiOG7Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2131C2BE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d5b7be937so2065e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704305434; x=1704910234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nylZ1SH7bULn4GXSP8vPmEaGDmDPmakB1zWF4sPJh10=;
        b=BNkiOG7Q3wwqlDGYY/IKJSI8mYpr1E95ke96OE6X97qy6E/jzW0l1oNy2D+UGOZNxE
         x80J/SnkZGB0ubq04ULhYtWmfUpJYUJ1m/F/nLmV9OF0Uh9TKWzLhnou4ILBuq3Yals9
         uM0WsPXm+Sdbb8OKxcR+427AQwWGkbc7KYWitcZ+mZt+WapPM4on0g9bX4/zAzsSg3s/
         tMh8DiUt+/XJeCZT+AeGBtyehhdrPCdkJ0En32E7Jkr2Dr//wT33pVFGKgpUfHvVq4Iz
         Fe3Ij7tRj83hdzVZNETsd4x2vjmAn2nEqIVHNxP+2+bQVtcFxLDJBKekcjxQSNDW0lQS
         iiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704305434; x=1704910234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nylZ1SH7bULn4GXSP8vPmEaGDmDPmakB1zWF4sPJh10=;
        b=lPXOw8+gHlQBxBVsQ0gx8SRCIz6+3TL/OhKezc6NbqJbqMgEPzTPZRXnqNwIoP6KtH
         dGbp7k/KQXo0s35nIm6Gc2fuEQpbjPnzrjh54b46iISdR4DzoDEn7LNP0t7elbTDfnI1
         AHVBRaKiGs1U6MO/Xb5H2CSJ3SymawdxbbApJ39YqiGw6vN5trRoQrrjFQGpVmh+l4XJ
         /xUZfIFR3GwzmGnxjaUkV8BXZltlEjbJayJ9+ZAKkIHhcOIGCRWtp9T8vAgXn4KKqoQ1
         3lEPMz5CRoB5ejq7QntO0GQNtQ89Yu6YSe7pyAakic9mm+OYJbv25IXKhPv8uRSe7P5+
         +pXQ==
X-Gm-Message-State: AOJu0YwPr8d7OrCx3idUJmjMfDtKDZwYpVPc9S6VhINh7rAwp6qpz4Wv
	FF9t85pHSlVZoVcBNz2onaSCsS/KSSwyfRT7SiN5twKWKeZnFmWB9LLPGZbcLfw22V4=
X-Google-Smtp-Source: AGHT+IGFsz7pCoOjFb8bRZ2Y//CvFtR4+i5QT7//yriwaruJ332MAVvOJE13Q4oWWDXbs3li22LfssbQg2Ce7+2ym4I=
X-Received: by 2002:a05:600c:1d1e:b0:40c:256f:756b with SMTP id
 l30-20020a05600c1d1e00b0040c256f756bmr178379wms.2.1704305434458; Wed, 03 Jan
 2024 10:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <30bcec9b-30ef-ad13-ec0b-59c6b94b05d1@maine.edu> <CAP-5=fUiRLh0e+V8j7P79pXTVkE1D=WL6t3Vwj29ypxZGaJ+gw@mail.gmail.com>
In-Reply-To: <CAP-5=fUiRLh0e+V8j7P79pXTVkE1D=WL6t3Vwj29ypxZGaJ+gw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jan 2024 10:10:23 -0800
Message-ID: <CAP-5=fXe2vx+cyQCLLPL4VJyOKDfrqBAp0dm3R1U5Ca9bxU6tw@mail.gmail.com>
Subject: Re: [perf] vsyscall, possible circular locking dependency detected
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, Alexander Shishkin <alexander.shishkin@linux.intel.com>, jolsa@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 10:08=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Dec 13, 2023 at 7:08=E2=80=AFAM Vince Weaver <vincent.weaver@main=
e.edu> wrote:
> >
> > Hello
> >
> > I recently added vsyscall fuzzing support to the perf_fuzzer and it gav=
e
> > me this dump when fuzzing on a haswell machine running current git
> > (6.7.0-rc5+)
> >
> > [12559.226693] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [12559.232906] WARNING: possible circular locking dependency detected
> > [12559.239116] 6.7.0-rc5+ #1 Tainted: G        W
> > [12559.244286] ------------------------------------------------------
> > [12559.250493] perf_fuzzer/284551 is trying to acquire lock:
> > [12559.255923] ffff88800aff65d8 (&sighand->siglock){-.-.}-{2:2}, at: fo=
rce_sig_info_to_task+0x41/0x260
> > [12559.265034]
> >                but task is already holding lock:
> > [12559.270891] ffff8880d08bd4d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin=
_rq_lock_nested+0x26/0xb0
> > [12559.279463]
> >                which lock already depends on the new lock.
> >
> > [12559.287670]
> >                the existing dependency chain (in reverse order) is:
> > [12559.295182]
> >                -> #1 (&rq->__lock){-.-.}-{2:2}:
> > [12559.300966]        _raw_spin_lock_nested+0x32/0x40
> > [12559.305789]        raw_spin_rq_lock_nested+0x26/0xb0
> > [12559.310783]        _raw_spin_rq_lock_irqsave+0x23/0x60
> > [12559.315959]        sched_mm_cid_before_execve+0xcd/0x3d0
> > [12559.321306]        exit_signals+0x1a3/0x450
> > [12559.325521]        do_exit+0x24b/0x1100
> > [12559.329389]        __x64_sys_exit+0x2c/0x30
> > [12559.333600]        do_syscall_64+0x41/0x120
> > [12559.337814]        entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [12559.343423]
> >                -> #0 (&sighand->siglock){-.-.}-{2:2}:
> > [12559.349732]        __lock_acquire+0x1d8d/0x31f0
> > [12559.354296]        lock_acquire+0x16c/0x3e0
> > [12559.358506]        _raw_spin_lock_irqsave+0x47/0x70
> > [12559.363416]        force_sig_info_to_task+0x41/0x260
> > [12559.368418]        force_sig_fault+0xaa/0xf0
> > [12559.372722]        exc_page_fault+0x61/0xf0
> > [12559.376932]        asm_exc_page_fault+0x22/0x30
> > [12559.381494]        __get_user_handle_exception+0x0/0x20
> > [12559.386755]        perf_callchain_user+0x2d3/0x390
> > [12559.391581]        get_perf_callchain+0x21a/0x2d0
> > [12559.396312]        perf_callchain+0xc3/0xe0
> > [12559.400526]        perf_prepare_sample+0x4f1/0xc70
> > [12559.405346]        perf_event_output_forward+0xbf/0x270
> > [12559.410599]        __perf_event_overflow+0x1ad/0x3c0
> > [12559.415597]        ___perf_sw_event+0x1f7/0x390
> > [12559.420154]        __schedule+0x12d3/0x2560
> > [12559.424367]        preempt_schedule_irq+0x47/0x90
> > [12559.429098]        irqentry_exit+0x31/0x80
> > [12559.433223]        asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [12559.438912]        seqcount_lockdep_reader_access.constprop.0+0x88/0=
x90
> > [12559.445562]        ktime_get_real_ts64+0x28/0x120
> > [12559.450297]        __x64_sys_gettimeofday+0x86/0x150
> > [12559.455292]        emulate_vsyscall+0x258/0x590
> > [12559.459858]        do_user_addr_fault+0x346/0x8c0
> > [12559.464588]        exc_page_fault+0x61/0xf0
> > [12559.468798]        asm_exc_page_fault+0x22/0x30
> > [12559.473360]        _end+0x7a5da000/0x0
> > [12559.477135]
> >                other info that might help us debug this:
> >
> > [12559.485163]  Possible unsafe locking scenario:
> >
> > [12559.491115]        CPU0                    CPU1
> > [12559.495670]        ----                    ----
> > [12559.500228]   lock(&rq->__lock);
> > [12559.503492]                                lock(&sighand->siglock);
> > [12559.509791]                                lock(&rq->__lock);
> > [12559.515569]   lock(&sighand->siglock);
> > [12559.519352]
> >                 *** DEADLOCK ***
> >
> > [12559.525303] 3 locks held by perf_fuzzer/284551:
> > [12559.529867]  #0: ffff8880d08bd4d8 (&rq->__lock){-.-.}-{2:2}, at: raw=
_spin_rq_lock_nested+0x26/0xb0
> > [12559.538873]  #1: ffffffff831a3ec0 (rcu_read_lock){....}-{1:2}, at: _=
__perf_sw_event+0x10f/0x390
> > [12559.547618]  #2: ffffffff831a3ec0 (rcu_read_lock){....}-{1:2}, at: p=
erf_event_output_forward+0x8f/0x270
> > [12559.557058]
> >                stack backtrace:
> > [12559.561439] CPU: 5 PID: 284551 Comm: perf_fuzzer Tainted: G        W=
          6.7.0-rc5+ #1
> > [12559.569823] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AU=
S 01/26/2014
> > [12559.577248] Call Trace:
> > [12559.579720]  <TASK>
> > [12559.581846]  dump_stack_lvl+0x57/0x90
> > [12559.585539]  check_noncircular+0x24f/0x290
> > [12559.589668]  ? __pfx_check_noncircular+0x10/0x10
> > [12559.594327]  ? lockdep_lock+0xb3/0x170
> > [12559.598106]  ? __pfx_lockdep_lock+0x10/0x10
> > [12559.602323]  ? add_chain_block+0x2dc/0x300
> > [12559.606456]  __lock_acquire+0x1d8d/0x31f0
> > [12559.610508]  ? __pfx___lock_acquire+0x10/0x10
> > [12559.614896]  ? __pfx_mark_lock+0x10/0x10
> > [12559.618849]  lock_acquire+0x16c/0x3e0
> > [12559.622548]  ? force_sig_info_to_task+0x41/0x260
> > [12559.627197]  ? __pfx_lock_acquire+0x10/0x10
> > [12559.631414]  ? __pfx_mark_lock+0x10/0x10
> > [12559.635370]  ? mark_lock+0x10b/0xd40
> > [12559.638981]  ? mark_lock+0x10b/0xd40
> > [12559.642586]  _raw_spin_lock_irqsave+0x47/0x70
> > [12559.646971]  ? force_sig_info_to_task+0x41/0x260
> > [12559.651618]  force_sig_info_to_task+0x41/0x260
> > [12559.656101]  force_sig_fault+0xaa/0xf0
> > [12559.659882]  ? __pfx_force_sig_fault+0x10/0x10
> > [12559.664360]  ? kernelmode_fixup_or_oops+0x10a/0x150
> > [12559.669272]  exc_page_fault+0x61/0xf0
> > [12559.672964]  asm_exc_page_fault+0x22/0x30
> > [12559.677007] RIP: 0010:__get_user_handle_exception+0x0/0x20
> > [12559.682524] Code: 90 90 90 90 90 90 90 90 90 90 0f 1f 00 0f ae e8 48=
 8b 10 31 c0 0f 1f 00 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90=
 <0f> 1f 00 31 d2 48 c7 c0 f2 ff ff ff c3 cc cc cc cc cc cc cc cc cc
> > [12559.701336] RSP: 0000:ffffc90021bef5d0 EFLAGS: 00010006
> > [12559.706592] RAX: 0000000000000005 RBX: ffffc90021bef680 RCX: fffffff=
f8100a5a3
> > [12559.713764] RDX: 0000000000000011 RSI: ffffffff8100a55d RDI: ffff888=
0138d8090
> > [12559.720931] RBP: 0000000000000005 R08: 0000000000000000 R09: fffffbf=
ff0799b5c
> > [12559.728098] R10: ffffffff83ccdae1 R11: 0000000000000000 R12: ffffc90=
021bef68c
> > [12559.735266] R13: ffffc90021bef688 R14: 0000000000000005 R15: ffff888=
0138d8000
> > [12559.742436]  ? perf_callchain_user+0x353/0x390
> > [12559.746914]  ? perf_callchain_user+0x30d/0x390
> > [12559.751391]  perf_callchain_user+0x2d3/0x390
> > [12559.755699]  get_perf_callchain+0x21a/0x2d0
> > [12559.759917]  ? __pfx_get_perf_callchain+0x10/0x10
> > [12559.764662]  ? lock_is_held_type+0xe3/0x140
> > [12559.768882]  ? preempt_schedule_irq+0x47/0x90
> > [12559.773269]  perf_callchain+0xc3/0xe0
> > [12559.776961]  perf_prepare_sample+0x4f1/0xc70
> > [12559.781263]  ? __pfx_perf_prepare_sample+0x10/0x10
> > [12559.786084]  ? __pfx___lock_acquire+0x10/0x10
> > [12559.790478]  perf_event_output_forward+0xbf/0x270
> > [12559.795214]  ? __pfx_perf_event_output_forward+0x10/0x10
> > [12559.800554]  ? lock_acquire+0x16c/0x3e0
> > [12559.804420]  ? lock_acquire+0x17c/0x3e0
> > [12559.808295]  ? __pfx_lock_acquire+0x10/0x10
> > [12559.812511]  ? ___perf_sw_event+0x22f/0x390
> > [12559.816727]  ? __pfx_lock_release+0x10/0x10
> > [12559.820951]  __perf_event_overflow+0x1ad/0x3c0
> > [12559.825428]  ___perf_sw_event+0x1f7/0x390
> > [12559.829467]  ? __pfx____perf_sw_event+0x10/0x10
> > [12559.834037]  ? preempt_schedule_irq+0x47/0x90
> > [12559.838426]  ? __update_load_avg_se+0x86/0x5c0
> > [12559.842900]  ? __update_load_avg_cfs_rq+0x70/0x570
> > [12559.847726]  ? lock_acquire+0x16c/0x3e0
> > [12559.851590]  ? __update_load_avg_se+0x15f/0x5c0
> > [12559.856154]  ? lock_is_held_type+0xe3/0x140
> > [12559.860372]  ? update_load_avg+0x154/0xdc0
> > [12559.864499]  ? lock_is_held_type+0xe3/0x140
> > [12559.868721]  ? set_next_entity+0xec/0x1e0
> > [12559.872764]  ? preempt_schedule_irq+0x47/0x90
> > [12559.877149]  ? __schedule+0x12d3/0x2560
> > [12559.881012]  __schedule+0x12d3/0x2560
> > [12559.884717]  ? __pfx___schedule+0x10/0x10
> > [12559.888754]  ? __pfx___lock_acquire+0x10/0x10
> > [12559.893139]  ? lock_is_held_type+0xe3/0x140
> > [12559.897353]  ? mark_held_locks+0x24/0x90
> > [12559.901316]  preempt_schedule_irq+0x47/0x90
> > [12559.905531]  irqentry_exit+0x31/0x80
> > [12559.909136]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [12559.914305] RIP: 0010:seqcount_lockdep_reader_access.constprop.0+0x8=
8/0x90
> > [12559.921217] Code: 31 f6 48 c7 c7 48 7c 1c 83 e8 84 25 f8 ff 48 8b 74=
 24 08 48 c7 c7 48 7c 1c 83 e8 93 1c f8 ff e8 6e d2 0c 00 fb 0f 1f 44 00 00=
 <5a> c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> > [12559.940025] RSP: 0000:ffffc90021befdb8 EFLAGS: 00000202
> > [12559.945281] RAX: 000000000182a8d9 RBX: ffffc90021befe18 RCX: dffffc0=
000000000
> > [12559.952453] RDX: 0000000000000000 RSI: ffffffff826804e0 RDI: fffffff=
f828c8620
> > [12559.959619] RBP: 00007ffcf0f36fd0 R08: 0000000000000001 R09: 0000000=
000000001
> > [12559.966786] R10: ffffffff8371fd27 R11: 0000000000000000 R12: 0000000=
000000000
> > [12559.973953] R13: 0000000000000000 R14: ffff88800aa55340 R15: ffffc90=
021befff0
> > [12559.981129]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
> > [12559.987426]  ? ktime_get_real_ts64+0x28/0x120
> > [12559.991820]  ktime_get_real_ts64+0x28/0x120
> > [12559.996032]  __x64_sys_gettimeofday+0x86/0x150
> > [12560.000512]  ? __pfx___x64_sys_gettimeofday+0x10/0x10
> > [12560.005602]  ? do_user_addr_fault+0x3c5/0x8c0
> > [12560.009994]  emulate_vsyscall+0x258/0x590
> > [12560.014034]  ? 0xffffffffff600000
> > [12560.017376]  do_user_addr_fault+0x346/0x8c0
> > [12560.021587]  ? rcu_is_watching+0x34/0x60
> > [12560.025541]  ? 0xffffffffff600000
> > [12560.028882]  exc_page_fault+0x61/0xf0
> > [12560.032578]  asm_exc_page_fault+0x22/0x30
> > [12560.036616] RIP: 0033:_end+0x7a5da000/0x0
> > [12560.040653] Code: Unable to access opcode bytes at 0xffffffffff5fffd=
6.
> > [12560.047210] RSP: 002b:00007ffcf0f36fb8 EFLAGS: 00010246
> > [12560.052470] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 0000000=
00000000a
> > [12560.059632] RDX: 0000000000000010 RSI: 0000000000000000 RDI: 00007ff=
cf0f36fd0
> > [12560.066799] RBP: 00007ffcf0f36fc0 R08: 00007f482684b274 R09: 00007f4=
82684b280
> > [12560.073966] R10: 00007f4826675a10 R11: 0000000000000246 R12: 0000000=
000000000
> > [12560.081132] R13: 00007ffcf0f39448 R14: 000055f2641d2dd8 R15: 00007f4=
8268a3000
> > [12560.088304]  </TASK>
>
> Thanks Vince, the potential deadlock is bad. I notice you updated your te=
sts at:
> https://github.com/deater/perf_event_tests
> is there a simple reproduction for this failure? Has there been any
> other progress on this issue?

Apologies, I just saw the syzkaller reproduction and your comments:
https://lore.kernel.org/lkml/CABOYnLxoG=3DYsE1XyOjfF0O+2UrdTyK1JMir3xPapGsR=
zh-XFAA@mail.gmail.com/

Thanks,
Ian

