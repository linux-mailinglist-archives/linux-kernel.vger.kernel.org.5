Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422247BB5AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjJFKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjJFKvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:51:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5399CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:51:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdcade7fbso346502166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696589505; x=1697194305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0k3d+Gwe+XklHyjb/cwFEc9lITqagIDR5jFODhEnVk=;
        b=gmYzL+u4MelA/4cQHXHJbwERG/PkVOPKeq2m8vtbcNPrIpwGbzrS3AcAvKfAUZIw8Y
         T/UhvWCwAl43F5LVngOcijFMecJywDCG40EpZNCryonKZa5XC7YYmxlYLn2CJmnYlgRP
         xs2d1hNEKLI/5oSYpfkNX1AupbhfFdHr+UQOdC893912huATaHLNAWuyf4kRWaHhV0Ur
         XH1yhU/aBUX+qDEqiFja8Fh7taXN37H0eAWOpSRM+oVeSvhwzurehQpDMYQomH4ntXJz
         3Qa3tS6t3MdhSe7TsmSupW2vxm9UyQDZiWC3y+JykNPzNdsSL9Q5sYNSwi0axELhoq2X
         A3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696589505; x=1697194305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0k3d+Gwe+XklHyjb/cwFEc9lITqagIDR5jFODhEnVk=;
        b=G35Tx1ifnnxNs0Q8H4UIAy/ChQKEQFQF35LjbWrk2yROO4MuYIKO+7YUyqV/OCMqSf
         8nV/1y2VMC4zL23SnmfeyyPrf0q6PHxUKKDKeAbEY9Eaq1pSKQwXLk8JdK2nq6ikKit3
         8wZRV1f2LmPB3yYtIKNx2aUtCzO3p/fA2d7e45OL+yRA3b8/SMypicARmtHH4cEK5q6D
         ShRjk6gE7XD0uu54hnKaohi+9M/FUXSNN2dAWQLx9210pFcnAXCBSh5gPp3u0lVnk3Id
         WWnct902hPX0nptWooqjpncRvq3FQBoOolWCwGPWaczu/5ye5d5KQkwo6OkO0T2k8iFU
         K10g==
X-Gm-Message-State: AOJu0Yxlj9/XMF1FUcs1nDsPLubu+ZxHKssZm1nw/1Cl2DdCVBqSs8VV
        9GEfkO0oCvL4q37wuBSLC0o=
X-Google-Smtp-Source: AGHT+IF7pfltS+LG83Y/IhhjrQK0yWIrIVB6b0RUZb5J7cJCycSlZId8aRcNri7QmjNVJYue16X0xg==
X-Received: by 2002:a17:906:156:b0:9a6:4f54:1da6 with SMTP id 22-20020a170906015600b009a64f541da6mr7277256ejh.57.1696589504725;
        Fri, 06 Oct 2023 03:51:44 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id cf7-20020a170906b2c700b009b296ce13a3sm2772822ejb.18.2023.10.06.03.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:51:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Oct 2023 12:51:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Message-ID: <ZR/mvd8Uw8PG+jx0@gmail.com>
References: <20231005161727.1855004-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005161727.1855004-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joel Fernandes (Google) <joel@joelfernandes.org> wrote:

> From: Vineeth Pillai <vineethrp@google.com>
> 
> Whenever a CPU stops its tick, it now requires another idle CPU to handle the
> balancing for it because it can't perform its own periodic load balancing.
> This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
> the upcoming nohz-idle load balancing is too distant in the future. This update
> process is done by triggering an ILB, as the general ILB handler
> (_nohz_idle_balance) that manages regular nohz balancing also refreshes
> 'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
> and selecting the smallest value.
> 
> Triggering this ILB can be achieved by setting the NOHZ_NEXT_KICK flag. This
> primarily results in the ILB handler updating 'nohz.next_balance' while
> possibly not doing any load balancing at all. However, sending an IPI merely to
> refresh 'nohz.next_balance' seems excessive, and there ought to be a more
> efficient method to update 'nohz.next_balance' from the local CPU.
> 
> Fortunately, there already exists a mechanism to directly invoke the ILB
> handler (_nohz_idle_balance) without initiating an IPI. It's accomplished by
> setting the NOHZ_NEWILB_KICK flag. This flag is set during regular "newly idle"
> balancing and solely exists to update a CPU's blocked load if it couldn't pull
> more tasks during regular "newly idle balancing" - and it does so without
> having to send any IPIs. Once the flag is set, the ILB handler is called
> directly from do_idle()-> nohz_run_idle_balance(). While its goal is to update
> the blocked load without an IPI, in our situation, we aim to refresh
> 'nohz.next_balance' without an IPI but we can piggy back on this.
> 
> So in this patch, we reuse this mechanism by also setting the NOHZ_NEXT_KICK to
> indicate nohz.next_balance needs an update via this direct call shortcut. Note
> that we set this flag without knowledge that the tick is about to be stopped,
> because at the point we do it, we have no way of knowing that. However we do
> know that the CPU is about to enter idle. In our testing, the reduction in IPIs
> is well worth updating nohz.next_balance a few more times.
> 
> Also just to note, without this patch we observe the following pattern:
> 
> 1. A CPU is about to stop its tick.
> 2. It sets nohz.needs_update to 1.
> 3. It then stops its tick and goes idle.
> 4. The scheduler tick on another CPU checks this flag and decides an ILB kick is needed.
> 5. The ILB CPU ends up being the one that just stopped its tick!
> 6. This results in an IPI to the tick-stopped CPU which ends up waking it up
>    and disturbing it!
> 
> Testing shows a considerable reduction in IPIs when doing this:
> 
> Running "cyclictest -i 100 -d 100 --latency=1000 -t -m" on a 4vcpu VM
> the IPI call count profiled over 10s period is as follows:
> without fix: ~10500
> with fix: ~1000
> 
> Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
> 
> [ Joel: wrote commit messages, collaborated on fix, helped reproduce issue etc. ]
> 
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Hsin Yi <hsinyi@google.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Vineeth Pillai <vineethrp@google.com>
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/fair.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cb225921bbca..2ece55f32782 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11786,13 +11786,12 @@ void nohz_balance_enter_idle(int cpu)
>  	/*
>  	 * Ensures that if nohz_idle_balance() fails to observe our
>  	 * @idle_cpus_mask store, it must observe the @has_blocked
> -	 * and @needs_update stores.
> +	 * stores.
>  	 */
>  	smp_mb__after_atomic();
>  
>  	set_cpu_sd_state_idle(cpu);
>  
> -	WRITE_ONCE(nohz.needs_update, 1);
>  out:
>  	/*
>  	 * Each time a cpu enter idle, we assume that it has blocked load and
> @@ -11945,21 +11944,25 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  }
>  
>  /*
> - * Check if we need to run the ILB for updating blocked load before entering
> - * idle state.
> + * Check if we need to run the ILB for updating blocked load and/or updating
> + * nohz.next_balance before entering idle state.
>   */
>  void nohz_run_idle_balance(int cpu)
>  {
>  	unsigned int flags;
>  
> -	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
> +	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK | NOHZ_NEXT_KICK, nohz_flags(cpu));
> +
> +	if (!flags)
> +		return;
>  
>  	/*
>  	 * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
>  	 * (ie NOHZ_STATS_KICK set) and will do the same.
>  	 */
> -	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
> -		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
> +	if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
> +	    !need_resched())
> +		_nohz_idle_balance(cpu_rq(cpu), flags);
>  }
>  
>  static void nohz_newidle_balance(struct rq *this_rq)
> @@ -11977,6 +11980,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
>  	if (this_rq->avg_idle < sysctl_sched_migration_cost)
>  		return;
>  
> +	/* If rq->next_balance before nohz.next_balance, trigger ILB */
> +	if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance)))
> +		atomic_or(NOHZ_NEXT_KICK, nohz_flags(this_cpu));
> +
>  	/* Don't need to update blocked load of idle CPUs*/
>  	if (!READ_ONCE(nohz.has_blocked) ||
>  	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))

Ok, judging by your IPI reduction numbers this is definitely an 
optimization we want to do.

The patch does make _nohz_idle_balance() run more parallel, as previously 
it would be generally run by the first-idle CPU in nohz.idle_cpus_mask (at 
least for next_balance updates), but I think it's still SMP-safe, as all 
key data structure updates are already rq-locked AFAICS.

One thing I noticed is that we now use nohz.needs_update only in a single 
remaining case, when _nohz_idle_balance() "self-defers":

                /*
                 * If this CPU gets work to do, stop the load balancing
                 * work being done for other CPUs. Next load
                 * balancing owner will pick it up.
                 */
                if (need_resched()) {
                        if (flags & NOHZ_STATS_KICK)
                                has_blocked_load = true;
                        if (flags & NOHZ_NEXT_KICK)
                                WRITE_ONCE(nohz.needs_update, 1);
                        goto abort;
                }

Getting a need-resched flag set on this CPU is a pretty dubious reason to 
skip an ILB run IMO, and we could do entirely without that complication, 
allowing us to remove the nohz.needs_update flag handling logic altogether?

If we do that then the !need_resched() flag needs to go from 
nohz_run_idle_balance() too:

        /*
         * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
         * (ie NOHZ_STATS_KICK set) and will do the same.
         */
        if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
            !need_resched())
                _nohz_idle_balance(cpu_rq(cpu), flags);

... if I'm reading the code right that is.

Thanks,

	Ingo
