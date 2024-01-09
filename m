Return-Path: <linux-kernel+bounces-20406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E139C827E59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3FF28595E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1246D6EA;
	Tue,  9 Jan 2024 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvovzs7n"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD5A5C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 05:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78315243c11so195193785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 21:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704778548; x=1705383348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SIl79HDk54ZYmitK/DrqoBI4jJQ+S6e1dOWl834lXwQ=;
        b=Vvovzs7nEYzEskSUjnL6QDXptsQgJGBUxDblEotraDfQ+kXcTqucHEz5ssvsbHGw8I
         XjEVLM6hKqGVhOySBefxe0GnNYoSAgIR3ARxu2sr5S9vUbj9FobD8heG4ecCUt4oMEbw
         LjinMfNteZ41zmo4AtOJynHDbsMiiLzAi65SOCg06Oxws6nji8CPAP9TGbaP9GF0qESK
         FxrH1R+y47OTAHziVXrJDDHGTI+88RpP4d/bST0yG2hGPEpMyEyQDbWDBDNdDH9xfHyU
         Y7FWqk12DggPYWRFpJ/kzNeTPE5Av6bO3zY5i7Uq1SBFnh0NP4blHQRUIm2yi73TZcQ6
         ItkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704778548; x=1705383348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIl79HDk54ZYmitK/DrqoBI4jJQ+S6e1dOWl834lXwQ=;
        b=AYFEL9utnIoRj0PUot0ktCx54NHLetVkMqprCSaIcii+U42tt6sk5fvxiz6wuMydn0
         5u9wd/Aya3Oe2yKum/n71NI7xMXIoAOjDlwKO3ac4k4UBnspraCH0/ZRDlTDOvxe1Wco
         bzywygrahCywepkzZxbfbgdV9t+eIX/MMkXW8eTjBrH7FbmbzUx5C+nmrEC7V2N0/ssF
         iYz7QL59yYlMXK8viMz9mseXu76HW3zo1jdn44+ujjOpyyrLM8OXOQb/g4zxFof11Img
         p+Jqg/VODi1B5l9SxzYPEykkNTqOFd4H5W9GdzyQAPSXbfJ1NhJyQeXBiRQP0lD5vWuq
         P+Wg==
X-Gm-Message-State: AOJu0Yynk8ZWaf0Q9BPNzJrgobcqHkCN+weRxKampAN3x71fa22TcUze
	oIc99dK0hDiv17e9zEF3b9k=
X-Google-Smtp-Source: AGHT+IGbpAnz6BygmXnwSfeWVK1x4I0AT8gJ4U+Z3s0IErcl7Xnw5ICV36XdHqZFPhcYe3+J4vV4vQ==
X-Received: by 2002:a05:620a:1a9c:b0:783:19ed:bb09 with SMTP id bl28-20020a05620a1a9c00b0078319edbb09mr3557371qkb.153.1704778548310;
        Mon, 08 Jan 2024 21:35:48 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id qp28-20020a05620a389c00b0077d66e5b2e6sm523459qkn.3.2024.01.08.21.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 21:35:47 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 5641827C005A;
	Tue,  9 Jan 2024 00:35:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 09 Jan 2024 00:35:47 -0500
X-ME-Sender: <xms:MtucZSFkvBfE561ZiQlPq5xn3G1BsjPTj-BXestvaLZ_js6axRYqKg>
    <xme:MtucZTVkjpFb5ez7c2g82SbnOvhMEOLbML4FUJgk0H0CN_tOA_yX4lKoMG7kf74RR
    bifLHZ_XmxjuYjUmw>
X-ME-Received: <xmr:MtucZcKg5DWBnxdoCOnKKkl7PwT2dUN3ZT7gOZ01jH1N6IdvtB52X6z8Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepffelkeefudethfekhfehkefhledvjefggedvjeejffduleektdffieev
    jeettedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:MtucZcEqgg7bWKoXqLqlNH1p70dVz4z11_0lK7SpO7sKNP2CRhtvAA>
    <xmx:MtucZYVeBSRCVDXgTY47m2RBmsKNrp88s-SVmrS1KBh9fkI0nZSlYQ>
    <xmx:MtucZfNYtyKTcjDjkFl9KyzUfgFYD2PIVJsNiYAU4hHT93o8Asi9qA>
    <xmx:M9ucZco95UeTiTiw30guQqryck46nFwKKRReCcSMSVkiUFqEaUvBGw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jan 2024 00:35:46 -0500 (EST)
Date: Mon, 8 Jan 2024 21:35:44 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	ke.wang@unisoc.com, zhiguo.niu@unisoc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock/lockdep: Add missing graph_unlock in validate_chain
Message-ID: <ZZzbMFwTepKaVDHc@Boquns-Mac-mini.home>
References: <20240104054030.14733-1-xuewen.yan@unisoc.com>
 <ZZcJ-3MXF4BPqPtL@boqun-archlinux>
 <CAB8ipk9+BAFOa_4Dm2hs-bpfmMC_LHkaAb=JUVBq1CChX11wzA@mail.gmail.com>
 <ZZwivt2C7-oxuMJS@boqun-archlinux>
 <CAB8ipk-E63myUvW7X=kX7t0_zW9wyBOcseyyh_tjOJNpzz=fZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk-E63myUvW7X=kX7t0_zW9wyBOcseyyh_tjOJNpzz=fZQ@mail.gmail.com>

On Tue, Jan 09, 2024 at 10:55:11AM +0800, Xuewen Yan wrote:
> Hi boqun
> 
> On Tue, Jan 9, 2024 at 12:30 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Fri, Jan 05, 2024 at 12:46:36PM +0800, Xuewen Yan wrote:
> > [...]
> > > >
> > > > Are you hitting a real issue or this is found by code reading?
> > >
> > > Indeed, we hit a real issue:
> > > One cpu did not call graph_unlock, as a result, caused a deadlock with
> > > other cpus,
> > > because any cpu calling raw_spin_lock would get the graph_lock first.
> > >
> >
> > Could you share more details about the real issue you hit? For example,
> > serial log? I asked because although the graph_unlock() makes logical
> > sense, but that path should really not hit if lockdep works correctly.
> 
> The following is our stack:
> 
> first, there is a  scenario in our kernel tree:
> get mutexA lock-->get rcu lock-->get mutexB lock
> As a result, there is a warning about the chain:
> 
> [    7.344848][ T1@C0] reboot: Restarting system with command
> 'userrequested,recovery'
> [    7.354028][ T1@C0]
> [    7.354358][ T1@C0] =============================
> [    7.354967][ T1@C0] [ BUG: Invalid wait context ]
> [    7.355580][ T1@C0] 6.6.5-0-g53d4f6ea5e56-dirty-ab000013 #1
> Tainted: G        W
> [    7.356720][ T1@C0] -----------------------------
> [    7.357326][ T1@C0] init/1 is trying to lock:
> [    7.357894][ T1@C0] ffffffc07b0b5310 (kmsg_buf_lock){+.+.}-{3:3},
> at: last_kmsg_handler+0x60/0xb8
> [    7.359244][ T1@C0] other info that might help us debug this:
> [    7.359982][ T1@C0] context-{4:4}
> [    7.360420][ T1@C0] 2 locks held by init/1:
> [    7.360967][ T1@C0]  #0: ffffffc08234d0b8
> (system_transition_mutex){+.+.}-{3:3}, at:
> __arm64_sys_reboot+0x130/0x27c
> [    7.362353][ T1@C0]  #1: ffffffc0823c9a18
> (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x38
> [    7.363568][ T1@C0] stack backtrace:
> [    7.364038][ T1@C0] CPU: 0 PID: 1 Comm: init Tainted: G        W
>       6.6.5-android14-0-g53d4f6ea5e56-dirty-ab000013 #1
> [    7.365453][ T1@C0] Hardware name: Unisoc ***-base Board (DT)
> [    7.366238][ T1@C0] Call trace:
> [    7.366652][ T1@C0]  dump_backtrace+0xf8/0x148
> [    7.367244][ T1@C0]  show_stack+0x20/0x30
> [    7.367779][ T1@C0]  dump_stack_lvl+0x60/0x84
> [    7.368372][ T1@C0]  __lock_acquire+0xc2c/0x3288
> [    7.368982][ T1@C0]  lock_acquire+0x124/0x2b0
> [    7.369556][ T1@C0]  __mutex_lock+0xa0/0xbfc
> [    7.370122][ T1@C0]  mutex_lock_nested+0x2c/0x38
> [    7.370730][ T1@C0]  last_kmsg_handler+0x60/0xb8 <<<<get mutex B
> [    7.371494][ T1@C0]  kmsg_dump+0xf0/0x16c   <<<<rcu lock
> [    7.372028][ T1@C0]  kernel_restart+0x100/0x11c
> [    7.372626][ T1@C0]  __arm64_sys_reboot+0x1a8/0x27c
> [    7.373270][ T1@C0]  invoke_syscall+0x60/0x11c
> [    7.373857][ T1@C0]  el0_svc_common+0xb4/0xf0
> [    7.374434][ T1@C0]  do_el0_svc+0x24/0x30
> [    7.374967][ T1@C0]  el0_svc+0x50/0xe4
> [    7.375467][ T1@C0]  el0t_64_sync_handler+0x68/0xbc
> [    7.376109][ T1@C0]  el0t_64_sync+0x1a8/0x1ac
> 
> This warning should be caused by the order of taking the lock.
> But when CONFIG_PREEMPT_RCU is turned on, I think it is reasonable to
> take the mutex after taking the rcu-lock.

Thanks for the information, but...

No, the rule of CONFIG_PREEMPT_RCU is allowing only implicit preemption
in RCU read-side critical sections. So calling mutex after taking RCU
read_lock() is illegal.

See the comments before rcu_read_lock():

 * In preemptible RCU implementations (PREEMPT_RCU) in CONFIG_PREEMPTION
 * kernel builds, RCU read-side critical sections may be preempted,
 * but explicit blocking is illegal.

> Maybe the logic of check_wait_context needs to be modified？
> 
> And then it occurs the following stack:
> 
> core0 get rdp_gp->nocb_gp_lock and then try to get graph_lock:
> 
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> -001|queued_spin_lock()
> -001|lockdep_lock()
> -001|graph_lock()
> -002|lookup_chain_cache_add()
> -002|validate_chain()
> -003|lock_acquire(lock = 0xFFFFFF817F211D98, subclass = 0, trylock =
> 0, read = 0, check = 1, nest_lock = 0x0, ip = 18446743800981533176)
> -004|__raw_spin_lock_irqsave()
>     |  lock = 0xFFFFFF817F211D80 -> (
>     |    raw_lock = (
>     |      val = (counter = 0),
>     |      locked = 0,
>     |      pending = 0,
>     |      locked_pending = 0,
>     |      tail = 0),
>     |    magic = 3735899821,
>     |    owner_cpu = 4294967295,
>     |    owner = 0xFFFFFFFFFFFFFFFF,
>     |    dep_map = (key = 0xFFFFFFC082F12C88, class_cache =
> (0xFFFFFFC0825378E0, 0x0), name = 0xFFFFFFC081541039, wait_type_outer
> = 0, wait_type_inner = 2, lock_type = 0))
>     |  flags = 0
>     |
>  110|
> -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> -005|lock_timer_base(inline)
> -005|__mod_timer.llvm.7968396489078322347(timer = 0xFFFFFF817F2A88D0,
> expires = 4294893461, options = 0)
> -006|mod_timer(inline)
> -006|wake_nocb_gp_defer(inline)
> -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680, was_alldone = ?, flags = ?)
> -007|__call_rcu_common(inline)
> -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> -008|call_rcu_hurry(inline)
> -008|rcu_sync_call(inline)
> -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> -010|nocb_cb_wait(inline)
> -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> -011|kthread(_create = 0xFFFFFF8080363740)
> -012|ret_from_fork(asm)
> 
> However, the grapg_lock is owned by core1, and it try to get
> rdp_gp->nocb_gp_lock, and it caused the deadlock.
> But we do not see where the core do not unlock the graph_lock:
> 

Right, this is the key point. There is a static variable tracking the
owner task of graph-lock:

static struct task_struct *__owner;

are you able to find some information from the coredump?

> -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
> -001|queued_spin_lock(inline)
> -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
> -002|__raw_spin_lock_irqsave(inline)
> -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
> -003|wake_nocb_gp_defer(inline)
> -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680, was_alldone = ?, flags = ?)
> -004|__call_rcu_common(inline)
> -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
> -005|call_rcu_zapped(inline)
> -005|free_zapped_rcu(ch = ?)
> -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
> -007|nocb_cb_wait(inline)
> -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
> -008|kthread(_create = 0xFFFFFF80803122C0)
> -009|ret_from_fork(asm)
> 
> Based on this, we read the lockdep code, and found the check_prev_add's logic.
> 
> But now we reproduce the scenario although we add the graph_unlock in
> check_prev_add().

If you have a reliable reproduce then could you try the following debug
code?

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..a313fcc78e8e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -466,6 +466,8 @@ static __always_inline void lockdep_recursion_finish(void)
 {
        if (WARN_ON_ONCE(__this_cpu_dec_return(lockdep_recursion)))
                __this_cpu_write(lockdep_recursion, 0);
+
+       BUG_ON(__owner == current);
 }

 void lockdep_set_selftest_task(struct task_struct *task)

This may tell you which code path in lockdep forgot to unlock the graph
lock.

> So this is not the root-cause of our problem. And we are also still debugging.

That matches my expectation: that "return 0" should never hit. So the
problem may be somewhere any else.

Regards,
BOqun

> We would be very grateful if you could give us some suggestions.
> 
> Thanks!
> 
> ---
> BRs
> xuewen
> 
> 
> > Thanks!
> >
> > Regards,
> > Boqun
> >
> > > Thanks!

