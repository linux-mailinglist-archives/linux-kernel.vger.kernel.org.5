Return-Path: <linux-kernel+bounces-89848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ABB86F67E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646031C20881
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB19F76418;
	Sun,  3 Mar 2024 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="DztJ/s26"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627D1EF12
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709487864; cv=none; b=njDmXrhJMdoi/piVtGIDWg1KIIz9QBRaO57XEFUoOaIy36nfum+G4g2IeXJqLyNVfi3g5aJQz2oU1KbI7FrjQEU1/jmTNhTZ4i0RVvfSO4iRVKUQK66IrNVmYGOnTouYOSfziYmUkL/iz+28ECExMhv2c3KS5ic3S9AgaAP8DtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709487864; c=relaxed/simple;
	bh=rT+iiep2fYMD43AzQaEzY+9SAledfPiCXPw8ymsohm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLJTRR/qR9s/g1AZSayHVwQQ9HqMa8HQSgnkgIhBduktO0MwIeKHut3V8apI7XOPDFtE39t3l9yMySEF1Vm8PH4YuW1ATNYDlm3NujcAsxioS5OOATQ4tS0hEQgfLJzgGskynvW7L//+uN73SZhdxyc3+bvJsNdZGif1VL5RADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=DztJ/s26; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c19b7d9de7so2505794b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 09:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709487861; x=1710092661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxXc88lXS2TTkCAEAGfmLOWn5W+HcMoNJd/RUqUodc0=;
        b=DztJ/s26/5pv2YIfmADVmSY+aM3ksWnkDMHp8y+ERZI2cbpVd4T6SzksrFhJc/Npzl
         s0hMgvlbpBmKp1Qi7D9jnDOvPD468gZLaxEjeyEPrU50hPfsVrDqVHzFvZB8PUkGuw5X
         tBeBfnXCMRkdrYYHL6WB1jvgicylqjziGG53kfUfIjOtcnAlKWYI4cSXmwWCEQ1qYsHH
         HQexZUW7UQfCaxXGTGhTE+nKgzolhlGyKF7aCHhb6He1z+pYrVdH88AVe+80TylSSI/d
         FWHxQejusp7FfEjYEdGBOU89F55jJd+mYNc7zGZodbZB5fk8X4RXCVsTtVVjK83ZuxXm
         P6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709487861; x=1710092661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxXc88lXS2TTkCAEAGfmLOWn5W+HcMoNJd/RUqUodc0=;
        b=ZYmuyaucmRHWsXlIMLbL58vvQ4oYsmjibrUO6iZYetVwHvGOYpnTEC9dL8bPmsqRik
         rmCCoCfBYISgHTvsdsritQR5f+RRjvibpbUbekEDZ5azE+CTCZ+aQBB/7wqYdkulIQPB
         7yNX0BMG/anUR2LsdwgKS2tPyJm1VsMr2qHdqQPRbkxLJqA4NL3WDejKyapn0JrRrNMv
         o4ogPOKid+FzoXIDnMkc3REJcAFx0HzY1x0yUaLQModx7Dpif3h5dnxM5Erzpo8RFO/a
         Pea+wYBxm9qOPilnmh3tACDyjgDp1RyELeOZEOtefdbG7cIF4WVq4pXBYa792OEsWcKA
         yqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0IhfNFGxKhyaC+dyNpWKpyKLKGNpdLWEogmHW4FuQxMAIxoQDMGpkF05X4UTXlA7XciD7iqsCSfU6zRM2eQMfPSieAU3JCekhhIQQ
X-Gm-Message-State: AOJu0YwvClsSY65T3ueDWZEUTciwvZReujxZ7PD2QqOLAGUSkCFZYHVD
	aYNKxXEsSTUIeqcCuPMd1MWSZ+DYnzefHIdVWHrPu/yILwb0/UkHVrXU0J2QmfE=
X-Google-Smtp-Source: AGHT+IEnb+HPcxyRpDUIIoj+gIynLCwzn0hqbdCz7ezvnD7rCfRMVGVx8BTIgfbWibszFIkHWQffyg==
X-Received: by 2002:a05:6808:13c4:b0:3c1:8412:eac6 with SMTP id d4-20020a05680813c400b003c18412eac6mr9146236oiw.18.1709487861372;
        Sun, 03 Mar 2024 09:44:21 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a00008b00b006e5ce366f0csm3596605pfj.89.2024.03.03.09.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 09:44:20 -0800 (PST)
Date: Sun, 3 Mar 2024 17:44:16 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240303174416.7m3gv5wywcmedov4@airbuntu>
References: <20240220225622.2626569-1-qyousef@layalina.io>
 <20240220225622.2626569-3-qyousef@layalina.io>
 <d6699c3a-3df6-46a3-98db-e07c8722f106@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6699c3a-3df6-46a3-98db-e07c8722f106@arm.com>

On 02/27/24 10:42, Dietmar Eggemann wrote:
> On 20/02/2024 23:56, Qais Yousef wrote:
> > If a misfit task is affined to a subset of the possible cpus, we need to
> > verify that one of these cpus can fit it. Otherwise the load balancer
> > code will continuously trigger needlessly leading the balance_interval
> > to increase in return and eventually end up with a situation where real
> > imbalances take a long time to address because of this impossible
> > imbalance situation.
> > 
> > This can happen in Android world where it's common for background tasks
> > to be restricted to little cores.
> > 
> > Similarly if we can't fit the biggest core, triggering misfit is
> > pointless as it is the best we can ever get on this system.
> > 
> > To be able to detect that; we use asym_cap_list to iterate through
> > capacities in the system to see if the task is able to run at a higher
> > capacity level based on its p->cpus_ptr. We do that when the affinity
> > change, a fair task is forked, or when a task switched to fair policy.
> > We store the max_allowed_capacity in task_struct to allow for cheap
> > comparison in the fast path.
> > 
> > Improve check_misfit_status() function by removing redundant checks.
> > misfit_task_load will be 0 if the task can't move to a bigger CPU. And
> > nohz_load_balance() already checks for cpu_check_capacity() before
> 
> s/nohz_load_balance()/nohz_balancer_kick() ?

Yes.

> 
> > calling check_misfit_status().
> 
> Isn't there an issue with CPU hotplug.

Sigh, yes. Thanks for catching it.

This should fix it, if you're willing to give a try it before I post v8, that'd
be appreciated. Otherwise I'll send v8 later in the week.

	diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
	index 174687252e1a..b0e60a565945 100644
	--- a/kernel/sched/fair.c
	+++ b/kernel/sched/fair.c
	@@ -8260,6 +8260,8 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
			cpumask_t *cpumask;
	 
			cpumask = cpu_capacity_span(entry);
	+		if (!cpumask_intersects(cpu_active_mask, cpumask))
	+			continue;
			if (!cpumask_intersects(p->cpus_ptr, cpumask))
				continue;
	 
	@@ -8269,6 +8271,53 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
		rcu_read_unlock();
	 }
	 
	+static void __update_tasks_max_allowed_capacity(unsigned long capacity)
	+{
	+	struct task_struct *g, *p;
	+
	+	for_each_process_thread(g, p) {
	+		if (fair_policy(p->policy) && p->max_allowed_capacity == capacity)
	+			set_task_max_allowed_capacity(p);
	+	}
	+}
	+
	+/*
	+ * Handle a cpu going online/offline changing the available capacity levels.
	+ */
	+static void update_tasks_max_allowed_capacity(int cpu, bool online)
	+{
	+	struct asym_cap_data *entry;
	+	bool do_update = false;
	+
	+	if (!sched_asym_cpucap_active())
	+		return;
	+
	+	if (cpuhp_tasks_frozen)
	+		return;
	+
	+	rcu_read_lock();
	+	/* Did a capacity level appear/disappear? */
	+	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
	+		unsigned int nr_active;
	+		cpumask_t *cpumask;
	+
	+		cpumask = cpu_capacity_span(entry);
	+
	+		if (!cpumask_test_cpu(cpu, cpumask))
	+			continue;
	+
	+		nr_active = cpumask_weight_and(cpu_active_mask, cpumask);
	+		if (online)
	+			do_update = nr_active == 1;
	+		else
	+			do_update = !nr_active;
	+		break;
	+	}
	+	if (do_update)
	+		__update_tasks_max_allowed_capacity(entry->capacity);
	+	rcu_read_unlock();
	+}
	+
	 static void set_cpus_allowed_fair(struct task_struct *p, struct affinity_context *ctx)
	 {
		set_cpus_allowed_common(p, ctx);
	@@ -12500,6 +12549,8 @@ static void rq_online_fair(struct rq *rq)
		update_sysctl();
	 
		update_runtime_enabled(rq);
	+
	+	update_tasks_max_allowed_capacity(cpu_of(rq), true);
	 }
	 
	 static void rq_offline_fair(struct rq *rq)
	@@ -12511,6 +12562,8 @@ static void rq_offline_fair(struct rq *rq)
	 
		/* Ensure that we remove rq contribution to group share: */
		clear_tg_offline_cfs_rqs(rq);
	+
	+	update_tasks_max_allowed_capacity(cpu_of(rq), false);
	 }
	 
	 #endif /* CONFIG_SMP */
-- 
2.34.1


> 
> On a tri-geared Juno:
> 
> root@juno:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 513
> 1024
> 1024
> 513
> 256
> 256
> 
> root@juno:~# taskset -pc 0,3-5 $$
> 
> [  108.248425] set_task_max_allowed_capacity() [bash 1636]
> max_allowed_capacity=513 nr_cpus_allowed=4 cpus_mask=0,3-5
> 
> echo 0 > /sys//devices/system/cpu/cpu0/online
> echo 0 > /sys//devices/system/cpu/cpu3/online
> 
> [  134.136887] set_task_max_allowed_capacity() [bash 1639]
> max_allowed_capacity=513 nr_cpus_allowed=4 cpus_mask=0,3-5
> 
> 
> Cpuset seems to be fine since it set task's cpumask.
> 
> [...]
> 
> > +/*
> > + * Check the max capacity the task is allowed to run at for misfit detection.
> 
> Nitpick: It's rather a setter function so s/check/set here ?
> 
> > + */
> > +static void set_task_max_allowed_capacity(struct task_struct *p)
> > +{
> > +	struct asym_cap_data *entry;
> > +
> > +	if (!sched_asym_cpucap_active())
> > +		return;
> > +
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> > +		cpumask_t *cpumask;
> > +
> > +		cpumask = cpu_capacity_span(entry);
> > +		if (!cpumask_intersects(p->cpus_ptr, cpumask))
> > +			continue;
> > +
> > +		p->max_allowed_capacity = entry->capacity;
> > +		break;
> > +	}
> > +	rcu_read_unlock();
> > +}
> 
> [...]
> 
> > @@ -9601,16 +9644,10 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
> >  				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
> >  }
> >  
> > -/*
> > - * Check whether a rq has a misfit task and if it looks like we can actually
> > - * help that task: we can migrate the task to a CPU of higher capacity, or
> > - * the task's current CPU is heavily pressured.
> > - */
> > -static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> > +/* Check if the rq has a misfit task */
> > +static inline bool check_misfit_status(struct rq *rq, struct sched_domain *sd)
> 
> `struct sched_domain *sd` is not needed anymore.
> 
> Since there is only 1 user of check_misfit_status() you might remove it
> entirely and use `rq->rq->misfit_task_load` directly in
> nohz_balancer_kick() ?

I think it's better to keep the access encapsulated.

I have this fixup diff

	diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
	index 593e85f90a36..1ac7dc8784b5 100644
	--- a/kernel/sched/fair.c
	+++ b/kernel/sched/fair.c
	@@ -8246,7 +8246,7 @@ static void task_dead_fair(struct task_struct *p)
	 }

	 /*
	- * Check the max capacity the task is allowed to run at for misfit detection.
	+ * Set the max capacity the task is allowed to run at for misfit detection.
	  */
	 static void set_task_max_allowed_capacity(struct task_struct *p)
	 {
	@@ -9638,7 +9638,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
	 }

	 /* Check if the rq has a misfit task */
	-static inline bool check_misfit_status(struct rq *rq, struct sched_domain *sd)
	+static inline bool check_misfit_status(struct rq *rq)
	 {
		return rq->misfit_task_load;
	 }
	@@ -11952,7 +11952,7 @@ static void nohz_balancer_kick(struct rq *rq)
			 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
			 * to run the misfit task on.
			 */
	-               if (check_misfit_status(rq, sd)) {
	+               if (check_misfit_status(rq)) {
				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
				goto unlock;
			}


Thanks!

--
Qais Yousef

