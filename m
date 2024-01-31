Return-Path: <linux-kernel+bounces-46338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D579843E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C61F1F245AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939C73168;
	Wed, 31 Jan 2024 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOgTEynS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qyQZgPsB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34E22619
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700010; cv=none; b=gnoIELECFHaUuDBReVS/1lB7boN9s9ov4xu8mosIkEiPPHBNinWmRKzmzZM1Qv9em/3VrIr/bDTOuVVgr7OVOX0XMGW3kTrOQODBhCOtY/YPs3qp2odnRDVK+CYWGYSzgtS6iROSAg7ruiirnlbytFrFaquWFseV3FqW59/ocIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700010; c=relaxed/simple;
	bh=ioCqrCUfMsxYPFaY+75fTEdC4w/2y5OEqCj2wF6cQ/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2PLqMWavL1bJ3xV9vsWUkpeWJS6Y4HhzixGa7nj6G6FSmi88YbQlkczRDEZPlOT9lsMxfg9AXgKW0Dfynj/pQNCCuy1yv3gC3EH3efINDce4EDLgihV+P4xJHLltoucklIjbp86XM3WA6kKAcBpA4Rduv8Pz9MbUEqQbHQ8kiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SOgTEynS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qyQZgPsB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706700001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9xaG8XueDfj75NVpSyHdbdda0x15af3Vr65vEcef6qc=;
	b=SOgTEynSh4igUqyCpOPmXPWBlgmaxNZu6rAzUA3emwXT6s68Zc7RQe/XDd9gPWJ73kJtTf
	LzQJS55efWqIDyYY/YCyMBt707EikSkyNZmXwxqPsQnpmPJndcLaAZcOlb8izv83m8vP4o
	pGkSEa5CVJelyFMSsdfOiUI7WefGYOYhmCgAihNxvdkzHN5YlsPyApmThlYbglIU29UA+k
	BHw7S5C6KbrNqPQQrtN25xwnKV+7V1lO4yMlxiE8ZFcBB4i//GrUZJIvekhIbmM12l9vmA
	hFHirBJP9JJc+L71YZ5hRkebyAw4HksTisV2gXw3u4jH9didpTSw5B3kMsxXxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706700001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9xaG8XueDfj75NVpSyHdbdda0x15af3Vr65vEcef6qc=;
	b=qyQZgPsBVNbGBDiIkH97LPltfiX2MynFoWNkBFCZe/i2C91/KxIyj7CK0ryTPYsDeNtN5H
	p1BdJwa97A6jrcDQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@infradead.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior
 <bigeasy@linutronix.de>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lukasz
 Luba <lukasz.luba@arm.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@intel.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
In-Reply-To: <Zblma8NNZOftJ5fb@pavilion.home>
References: <Zbb5m0hRHgk59-8z@pavilion.home> <87v87a9033.fsf@somnus>
 <Zblma8NNZOftJ5fb@pavilion.home>
Date: Wed, 31 Jan 2024 12:19:59 +0100
Message-ID: <87r0hxbvhc.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Frederic Weisbecker <frederic@kernel.org> writes:

[...]

>
> But you know what, let's make it more simple. CPU down hotplug is not a
> fast path and it doesn't deserve so many optimizations. Just remove ->wakeup_recalc
> entirely and if the offlining CPU detects it's the last active CPU in the
> hierarchy, just queue an empty work to the first online CPU. It will briefly
> force that CPU out of idle and trigger an activate. Then either the CPU
> periodically checks remote timers or it will go back idle and notice.
>

I'll have a look at it and give it a try! Thanks!

> Something like this (untested):
>
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index de1905b0bae7..0f15215ef257 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -548,7 +548,6 @@ static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
>  
>  	tmc->cpuevt.ignore = true;
>  	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
> -	tmc->wakeup_recalc = false;
>  
>  	walk_groups(&tmigr_active_up, &data, tmc);
>  }
> @@ -1041,41 +1040,11 @@ int tmigr_requires_handle_remote(void)
>  	}
>  
>  	/*
> -	 * If the CPU is idle, check whether the recalculation of @tmc->wakeup
> -	 * is required. @tmc->wakeup_recalc is set, when the last active CPU
> -	 * went offline. The last active CPU delegated the handling of the timer
> -	 * migration hierarchy to another (this) CPU by updating this flag and
> -	 * sending a reschedule.
> -	 *
> -	 * Racy lockless check is valid:
> -	 * - @tmc->wakeup_recalc is set by the remote CPU before it issues
> -	 *   reschedule IPI.
> -	 * - As interrupts are disabled here this CPU will either observe
> -	 *   @tmc->wakeup_recalc set before the reschedule IPI can be handled or
> -	 *   it will observe it when this function is called again on return
> -	 *   from handling the reschedule IPI.
> -	 */
> -	if (tmc->wakeup_recalc) {
> -		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
> -
> -		if (data.firstexp != KTIME_MAX)
> -			ret = 1;
> -
> -		raw_spin_lock(&tmc->lock);
> -		WRITE_ONCE(tmc->wakeup, data.firstexp);
> -		tmc->wakeup_recalc = false;
> -		raw_spin_unlock(&tmc->lock);
> -
> -		return ret;
> -	}
> -
> -	/*
> -	 * When the CPU is idle and @tmc->wakeup is reliable as
> -	 * @tmc->wakeup_recalc is not set, compare it with @data.now. The lock
> -	 * is required on 32bit architectures to read the variable consistently
> -	 * with a concurrent writer. On 64bit the lock is not required because
> -	 * the read operation is not split and so it is always consistent.
> -
> +	 * When the CPU is idle and @tmc->wakeup is reliable, compare it with
> +	 * @data.now. The lock is required on 32bit architectures to read the
> +	 * variable consistently with a concurrent writer. On 64bit the lock
> +	 * is not required because the read operation is not split and so it is
> +	 * always consistent.
>  	 */
>  	if (IS_ENABLED(CONFIG_64BIT)) {
>  		if (data.now >= READ_ONCE(tmc->wakeup))
> @@ -1119,21 +1088,7 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
>  		    tmc->cpuevt.ignore) {
>  			ret = tmigr_new_timer(tmc, nextexp);
>  		}
> -	} else if (tmc->wakeup_recalc) {
> -		struct tmigr_remote_data data;
> -
> -		data.now = KTIME_MAX;
> -		data.childmask = tmc->childmask;
> -		data.firstexp = KTIME_MAX;
> -		data.tmc_active = false;
> -		data.check = false;
> -
> -		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
> -
> -		ret = data.firstexp;
>  	}
> -	tmc->wakeup_recalc = false;
> -
>  	/*
>  	 * Make sure the reevaluation of timers in idle path will not miss an
>  	 * event.
> @@ -1212,36 +1167,7 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
>  	 *   hierarchy) and
>  	 * - there is a pending event in the hierarchy
>  	 */
> -	if (data->firstexp != KTIME_MAX) {
> -		WARN_ON_ONCE(group->parent);
> -		/*
> -		 * Top level path: If this CPU is about going offline and was
> -		 * the last active CPU, wake up some random other CPU so it will
> -		 * take over the migrator duty and program its timer
> -		 * properly. Ideally wake the CPU with the closest expiry time,
> -		 * but that's overkill to figure out.
> -		 *
> -		 * Set wakeup_recalc of remote CPU, to make sure the complete
> -		 * idle hierarchy with enqueued timers is reevaluated.
> -		 */
> -		if (!(this_cpu_ptr(&tmigr_cpu)->online)) {
> -			struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> -			unsigned int cpu = smp_processor_id();
> -			struct tmigr_cpu *tmc_resched;
> -
> -			cpu = cpumask_any_but(cpu_online_mask, cpu);
> -			tmc_resched = per_cpu_ptr(&tmigr_cpu, cpu);
> -
> -			raw_spin_unlock(&tmc->lock);
> -
> -			raw_spin_lock(&tmc_resched->lock);
> -			tmc_resched->wakeup_recalc = true;
> -			raw_spin_unlock(&tmc_resched->lock);
> -
> -			raw_spin_lock(&tmc->lock);
> -			smp_send_reschedule(cpu);
> -		}
> -	}
> +	WARN_ON_ONCE(data->firstexp != KTIME_MAX && group->parent);
>  
>  	return walk_done;
>  }
> @@ -1579,9 +1505,20 @@ static int tmigr_cpu_online(unsigned int cpu)
>  	return 0;
>  }
>  
> +long tmigr_trigger_active(void *unused)
> +{
> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +
> +	WARN_ON_ONCE(!tmc->online || tmc->idle);
> +
> +	return 0;
> +}
> +
>  static int tmigr_cpu_offline(unsigned int cpu)
>  {
>  	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +	int migrator;
> +	u64 firstexp;
>  
>  	raw_spin_lock_irq(&tmc->lock);
>  	tmc->online = false;
> @@ -1591,9 +1528,14 @@ static int tmigr_cpu_offline(unsigned int cpu)
>  	 * CPU has to handle the local events on his own, when on the way to
>  	 * offline; Therefore nextevt value is set to KTIME_MAX
>  	 */
> -	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
> +	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
>  	raw_spin_unlock_irq(&tmc->lock);
>  
> +	if (firstexp != KTIME_MAX) {
> +		migrator = cpumask_any_but(cpu_online_mask, cpu);
> +		work_on_cpu(migrator, tmigr_trigger_active, NULL);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
> index c32947cf429b..c556d5824792 100644
> --- a/kernel/time/timer_migration.h
> +++ b/kernel/time/timer_migration.h
> @@ -78,18 +78,12 @@ struct tmigr_group {
>   * @idle:		Indicates whether the CPU is idle in the timer migration
>   *			hierarchy
>   * @remote:		Is set when timers of the CPU are expired remotely
> - * @wakeup_recalc:	Indicates, whether a recalculation of the @wakeup value
> - *			is required. @wakeup_recalc is only used by this CPU
> - *			when it is marked idle in the timer migration
> - *			hierarchy. It is set by a remote CPU which was the last
> - *			active CPU and is on the way to idle.
>   * @tmgroup:		Pointer to the parent group
>   * @childmask:		childmask of tmigr_cpu in the parent group
>   * @wakeup:		Stores the first timer when the timer migration
>   *			hierarchy is completely idle and remote expiry was done;
>   *			is returned to timer code in the idle path and is only
> - *			used in idle path; it is only valid, when @wakeup_recalc
> - *			is not set.
> + *			used in idle path.
>   * @cpuevt:		CPU event which could be enqueued into the parent group
>   */
>  struct tmigr_cpu {
> @@ -97,7 +91,6 @@ struct tmigr_cpu {
>  	bool			online;
>  	bool			idle;
>  	bool			remote;
> -	bool			wakeup_recalc;
>  	struct tmigr_group	*tmgroup;
>  	u8			childmask;
>  	u64			wakeup;

