Return-Path: <linux-kernel+bounces-17283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D84824AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67BC1F215E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24962C86A;
	Thu,  4 Jan 2024 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Gx2vXP+5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7882CCAD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-db3a09e96daso931428276.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 14:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1704406882; x=1705011682; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eQQhJlyIm/LvTTrNL4u+7zhgTsxbDAWkmLHsnUJN4k=;
        b=Gx2vXP+5PmRS6qeI+fg1mKWlsM0qLISj3Sm2fajwUzdarSCWrWgwTDqshMRS+dUE6R
         Fz7APkHY9KJuabHGEkDQTEU+ShCcLKGiC/+4AsCHIaSSPux3f+zC4vulvxG8SeCax8wz
         yQTLdYiL9BkKxLZxao19tBDz4rpt0VyXDgxU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704406882; x=1705011682;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eQQhJlyIm/LvTTrNL4u+7zhgTsxbDAWkmLHsnUJN4k=;
        b=DFzPi6N6ee1SfdpElEr7NgulzB2xvz/gJI2vzIYx5NBwtQLOzOTlkUcqpgh9o+iVZh
         OD8Fk2XgzPm/pMPEXcBayF3PL20muIyqD4Fco/l096+FDd5gaYhVdZ9dGWMIkJj2oBMK
         RkqF+mo9inGmA1M8432ejHrQphDJk2UwIA32PMm3VqxO6LNFUKcyLWVuw5zXMGGggJ69
         BrHQ+yQRkz9Uj3jo61IWjjPQkW/TU7dPA6mKhPoNdrkW0sR1CAWKlJCUCkySyYN5ZqYg
         jdzk/nFtezIDrRKIgLhPpNu5Np9cWry9+nSOeIXVt1p1sVPXFOIy8CVP0HnfR9Rv8d2W
         +Suw==
X-Gm-Message-State: AOJu0YxzDKwP3I7F1+rHnmnm1OHUq0TgOvpx9leRIy1RrCEe0oYwTsun
	aiWFVw8lJMHBFRCZ0wy+fsOCiMoJMp96
X-Google-Smtp-Source: AGHT+IFA6aqNqK2qIMtFhjbMNT+mqkKsi3UWkTVZ7X7SGB15Hivj2FL9VUuxkm2mfDvhA3TINfAfOQ==
X-Received: by 2002:a05:6902:dca:b0:dbd:afa2:e9c8 with SMTP id de10-20020a0569020dca00b00dbdafa2e9c8mr1319107ybb.48.1704406882006;
        Thu, 04 Jan 2024 14:21:22 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id c1-20020ac80541000000b00427f8c50f31sm175340qth.46.2024.01.04.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:21:21 -0800 (PST)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 4 Jan 2024 17:21:20 -0500 (EST)
To: Ian Rogers <irogers@google.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, peterz@infradead.org, 
    mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, jolsa@kernel.org, 
    namhyung@kernel.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, 
    linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [perf] vsyscall, possible circular locking dependency detected
In-Reply-To: <CAP-5=fXe2vx+cyQCLLPL4VJyOKDfrqBAp0dm3R1U5Ca9bxU6tw@mail.gmail.com>
Message-ID: <3f2ec370-2590-a70a-204a-0d9d5b713f4e@maine.edu>
References: <30bcec9b-30ef-ad13-ec0b-59c6b94b05d1@maine.edu> <CAP-5=fUiRLh0e+V8j7P79pXTVkE1D=WL6t3Vwj29ypxZGaJ+gw@mail.gmail.com> <CAP-5=fXe2vx+cyQCLLPL4VJyOKDfrqBAp0dm3R1U5Ca9bxU6tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463802360-2033901734-1704406881=:214922"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463802360-2033901734-1704406881=:214922
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Wed, Jan 3, 2024 at 10:08 AM Ian Rogers <irogers@google.com> wrote:

> > is there a simple reproduction for this failure? Has there been any
> > other progress on this issue?

I tried reproducing the issue, but unfortunately restarting the fuzzer 
with the same input doesn't reliably trigger it.

I let the perf_fuzzer run a while on the haswell machine and it was able 
to eventually trigger it again after a few hours (see below).

Vince

[77210.091776] ======================================================
[77210.097974] WARNING: possible circular locking dependency detected
[77210.104181] 6.7.0-rc5+ #1 Tainted: G        W         
[77210.109344] ------------------------------------------------------
[77210.115541] perf_fuzzer/2004640 is trying to acquire lock:
[77210.121046] ffff8880180e5358 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x41/0x260
[77210.130133] 
               but task is already holding lock:
[77210.135988] ffff8880d063d4d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x26/0xb0
[77210.144546] 
               which lock already depends on the new lock.

[77210.152744] 
               the existing dependency chain (in reverse order) is:
[77210.160262] 
               -> #1 (&rq->__lock){-.-.}-{2:2}:
[77210.166062]        _raw_spin_lock_nested+0x32/0x40
[77210.170894]        raw_spin_rq_lock_nested+0x26/0xb0
[77210.175898]        _raw_spin_rq_lock_irqsave+0x23/0x60
[77210.181082]        sched_mm_cid_before_execve+0xcd/0x3d0
[77210.186435]        exit_signals+0x1a3/0x450
[77210.190654]        do_exit+0x24b/0x1100
[77210.194526]        __x64_sys_exit+0x2c/0x30
[77210.198746]        do_syscall_64+0x41/0x120
[77210.202969]        entry_SYSCALL_64_after_hwframe+0x6e/0x76
[77210.208579] 
               -> #0 (&sighand->siglock){-.-.}-{2:2}:
[77210.214891]        __lock_acquire+0x1d8d/0x31f0
[77210.219462]        lock_acquire+0x16c/0x3e0
[77210.223682]        _raw_spin_lock_irqsave+0x47/0x70
[77210.228596]        force_sig_info_to_task+0x41/0x260
[77210.233600]        force_sig_fault+0xaa/0xf0
[77210.237903]        exc_page_fault+0x61/0xf0
[77210.242126]        asm_exc_page_fault+0x22/0x30
[77210.246695]        __get_user_handle_exception+0x0/0x20
[77210.251963]        perf_callchain_user+0x2d3/0x390
[77210.256792]        get_perf_callchain+0x21a/0x2d0
[77210.261541]        perf_callchain+0xc3/0xe0
[77210.265760]        perf_prepare_sample+0x4f1/0xc70
[77210.270588]        perf_event_output_forward+0xbf/0x270
[77210.275851]        __perf_event_overflow+0x1ad/0x3c0
[77210.280848]        ___perf_sw_event+0x1f7/0x390
[77210.285414]        __schedule+0x1370/0x2560
[77210.289638]        preempt_schedule_irq+0x47/0x90
[77210.294380]        irqentry_exit+0x31/0x80
[77210.298509]        asm_sysvec_apic_timer_interrupt+0x16/0x20
[77210.304209]        seqcount_lockdep_reader_access.constprop.0+0x88/0x90
[77210.310866]        ktime_get_real_ts64+0x28/0x120
[77210.315610]        __x64_sys_gettimeofday+0x86/0x150
[77210.320614]        emulate_vsyscall+0x258/0x590
[77210.325177]        do_user_addr_fault+0x346/0x8c0
[77210.329918]        exc_page_fault+0x61/0xf0
[77210.334137]        asm_exc_page_fault+0x22/0x30
[77210.338707]        _end+0x7a5da000/0x0
[77210.342491] 
               other info that might help us debug this:

[77210.350530]  Possible unsafe locking scenario:

[77210.356488]        CPU0                    CPU1
[77210.361051]        ----                    ----
[77210.365616]   lock(&rq->__lock);
[77210.368883]                                lock(&sighand->siglock);
[77210.375190]                                lock(&rq->__lock);
[77210.380979]   lock(&sighand->siglock);
[77210.384771] 
                *** DEADLOCK ***

[77210.390730] 3 locks held by perf_fuzzer/2004640:
[77210.395378]  #0: ffff8880d063d4d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x26/0xb0
[77210.404408]  #1: ffffffff831a3ec0 (rcu_read_lock){....}-{1:2}, at: ___perf_sw_event+0x10f/0x390
[77210.413168]  #2: ffffffff831a3ec0 (rcu_read_lock){....}-{1:2}, at: perf_event_output_forward+0x8f/0x270
[77210.422625] 
               stack backtrace:
[77210.427012] CPU: 0 PID: 2004640 Comm: perf_fuzzer Tainted: G        W          6.7.0-rc5+ #1
[77210.435490] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
[77210.442926] Call Trace:
[77210.445409]  <TASK>
[77210.447535]  dump_stack_lvl+0x57/0x90
[77210.451234]  check_noncircular+0x24f/0x290
[77210.455371]  ? __pfx_check_noncircular+0x10/0x10
[77210.460042]  ? lockdep_lock+0xb3/0x170
[77210.463829]  ? __pfx_lockdep_lock+0x10/0x10
[77210.468048]  ? add_chain_block+0x2dc/0x300
[77210.472186]  __lock_acquire+0x1d8d/0x31f0
[77210.476251]  ? __pfx___lock_acquire+0x10/0x10
[77210.480661]  lock_acquire+0x16c/0x3e0
[77210.484366]  ? force_sig_info_to_task+0x41/0x260
[77210.489027]  ? __pfx_lock_acquire+0x10/0x10
[77210.493256]  ? mark_lock+0x10b/0xd40
[77210.496877]  _raw_spin_lock_irqsave+0x47/0x70
[77210.501275]  ? force_sig_info_to_task+0x41/0x260
[77210.505933]  force_sig_info_to_task+0x41/0x260
[77210.510421]  force_sig_fault+0xaa/0xf0
[77210.514209]  ? __pfx_force_sig_fault+0x10/0x10
[77210.518687]  ? lock_release+0x22a/0x3e0
[77210.522567]  ? kernelmode_fixup_or_oops+0x10a/0x150
[77210.527489]  exc_page_fault+0x61/0xf0
[77210.531195]  asm_exc_page_fault+0x22/0x30
[77210.535239] RIP: 0010:__get_user_handle_exception+0x0/0x20
[77210.540764] Code: 90 90 90 90 90 90 90 90 90 90 0f 1f 00 0f ae e8 48 8b 10 31 c0 0f 1f 00 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <0f> 1f 00 31 d2 48 c7 c0 f2 ff ff ff c3 cc cc cc cc cc cc cc cc cc
[77210.559590] RSP: 0000:ffffc9000fd8f5d0 EFLAGS: 00010006
[77210.564857] RAX: 0000000000000005 RBX: ffffc9000fd8f680 RCX: ffffffff8100a5a3
[77210.572030] RDX: 0000000000000004 RSI: ffffffff8100a55d RDI: ffff88802f014028
[77210.579209] RBP: 0000000000000005 R08: 000000000000007f R09: 0000000000000000
[77210.586381] R10: ffffffff8371fd27 R11: 0000000000000000 R12: ffffc9000fd8f68c
[77210.593558] R13: ffffc9000fd8f688 R14: 0000000000000005 R15: ffff88802f014000
[77210.600742]  ? perf_callchain_user+0x353/0x390
[77210.605225]  ? perf_callchain_user+0x30d/0x390
[77210.609709]  perf_callchain_user+0x2d3/0x390
[77210.614027]  get_perf_callchain+0x21a/0x2d0
[77210.618253]  ? __pfx_get_perf_callchain+0x10/0x10
[77210.623007]  ? lock_is_held_type+0xe3/0x140
[77210.627237]  ? preempt_schedule_irq+0x47/0x90
[77210.631630]  perf_callchain+0xc3/0xe0
[77210.635336]  perf_prepare_sample+0x4f1/0xc70
[77210.639645]  ? __pfx_perf_prepare_sample+0x10/0x10
[77210.644477]  ? lock_release+0x22a/0x3e0
[77210.648351]  ? __pfx___lock_acquire+0x10/0x10
[77210.652750]  perf_event_output_forward+0xbf/0x270
[77210.657498]  ? __pfx_perf_event_output_forward+0x10/0x10
[77210.662852]  ? lock_acquire+0x16c/0x3e0
[77210.666723]  ? lock_acquire+0x17c/0x3e0
[77210.670597]  ? __pfx_lock_acquire+0x10/0x10
[77210.674817]  ? __kernel_text_address+0xe/0x40
[77210.679213]  ? unwind_get_return_address+0x33/0x50
[77210.684048]  __perf_event_overflow+0x1ad/0x3c0
[77210.688533]  ___perf_sw_event+0x1f7/0x390
[77210.692587]  ? stack_trace_save+0x91/0xd0
[77210.696632]  ? __pfx____perf_sw_event+0x10/0x10
[77210.701205]  ? preempt_schedule_irq+0x47/0x90
[77210.705602]  ? __update_load_avg_se+0x2dc/0x5c0
[77210.710172]  ? __update_load_avg_cfs_rq+0x70/0x570
[77210.715009]  ? lock_acquire+0x16c/0x3e0
[77210.718887]  ? __update_load_avg_se+0x86/0x5c0
[77210.723377]  ? update_load_avg+0x154/0xdc0
[77210.727514]  ? lock_is_held_type+0xe3/0x140
[77210.731738]  ? set_next_entity+0xec/0x1e0
[77210.735790]  ? preempt_schedule_irq+0x47/0x90
[77210.740185]  ? __schedule+0x1370/0x2560
[77210.744054]  __schedule+0x1370/0x2560
[77210.747771]  ? __pfx___schedule+0x10/0x10
[77210.751822]  ? __pfx___lock_acquire+0x10/0x10
[77210.756216]  ? lock_is_held_type+0xe3/0x140
[77210.760441]  ? mark_held_locks+0x24/0x90
[77210.764410]  preempt_schedule_irq+0x47/0x90
[77210.768634]  irqentry_exit+0x31/0x80
[77210.772244]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[77210.777426] RIP: 0010:seqcount_lockdep_reader_access.constprop.0+0x88/0x90
[77210.784346] Code: 31 f6 48 c7 c7 48 7c 1c 83 e8 84 25 f8 ff 48 8b 74 24 08 48 c7 c7 48 7c 1c 83 e8 93 1c f8 ff e8 6e d2 0c 00 fb 0f 1f 44 00 00 <5a> c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[77210.803173] RSP: 0000:ffffc9000fd8fdb8 EFLAGS: 00000206
[77210.808436] RAX: 0000000000e1f517 RBX: ffffc9000fd8fe18 RCX: dffffc0000000000
[77210.815609] RDX: 0000000000000000 RSI: ffffffff826804e0 RDI: ffffffff828c8620
[77210.822784] RBP: 00007ffc3a66d400 R08: 0000000000000001 R09: 0000000000000001
[77210.829958] R10: ffffffff8371fd27 R11: 0000000000000000 R12: 0000000000000000
[77210.837128] R13: 0000000000000000 R14: ffff888016c69bc0 R15: ffffc9000fd8fff0
[77210.844314]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
[77210.850619]  ? ktime_get_real_ts64+0x28/0x120
[77210.855017]  ktime_get_real_ts64+0x28/0x120
[77210.859240]  __x64_sys_gettimeofday+0x86/0x150
[77210.863727]  ? __pfx___x64_sys_gettimeofday+0x10/0x10
[77210.868822]  emulate_vsyscall+0x258/0x590
[77210.872872]  ? 0xffffffffff600000
[77210.876222]  do_user_addr_fault+0x346/0x8c0
[77210.880444]  ? rcu_is_watching+0x34/0x60
[77210.884407]  ? 0xffffffffff600000
[77210.887758]  exc_page_fault+0x61/0xf0
[77210.891460]  asm_exc_page_fault+0x22/0x30
[77210.895505] RIP: 0033:_end+0x7a5da000/0x0
[77210.899551] Code: Unable to access opcode bytes at 0xffffffffff5fffd6.
[77210.906114] RSP: 002b:00007ffc3a66d3e8 EFLAGS: 00010246
[77210.911378] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 000000000000000a
[77210.918549] RDX: 0000000000000010 RSI: 0000000000000000 RDI: 00007ffc3a66d400
[77210.925726] RBP: 00007ffc3a66d3f0 R08: 00007f2b06c55230 R09: 00007f2b06c55280
[77210.932905] R10: 00007f2b06c55264 R11: 0000000000000206 R12: 0000000000000000
[77210.940077] R13: 00007ffc3a66f878 R14: 000056508bcc7dd8 R15: 00007f2b06cad000
[77210.947269]  </TASK>


---1463802360-2033901734-1704406881=:214922--

