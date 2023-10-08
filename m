Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09B7BCF47
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344944AbjJHQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344924AbjJHQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:46:12 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4456B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:46:09 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-351232a46b3so14860995ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696783569; x=1697388369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnVFZJC7sQv/uUQwxwCLKccSDfGZB0dl57RLHiWuzW8=;
        b=esFG7niQh8qYcE1f9MdgmDHD+yyY92SyXXOvu5+Som+GpodgXGL/AvoysW5NXWZIxR
         XxlCP0cDbLOyCc2FFjtwy9FvovxbVnAdNahT47hmBO73fJaS2YIp9F3D1RtFkOfIcQH+
         +t44/spSF0EuLlKwQxt2PFtNX4YPFmXRyQKZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696783569; x=1697388369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnVFZJC7sQv/uUQwxwCLKccSDfGZB0dl57RLHiWuzW8=;
        b=IvhNGSKcZZXRnIqF5Eeb2HW1AGJVE4l6Pe1zuF+IJ15bfGUdpJ6ZZfbISuKAAMNvYh
         nthnp8MTSIyBYJYXgc1pgKbNQHdcp0LDfhqhGRjm0h3TZnh/tor80aY6p0zHE9BObKlC
         QHoitSmzz3XXMXcFRageFQU5yLypg72Ysrar+fPWKAo8LpZkR/hfBVg2GNAphs7GKgbd
         jWKy59LNZoSSO1KtEjCB8WXVkPDqDkRg4OCf36NqNgNXaZ5idYg5IsUyERYMXa4xACJQ
         Q5w71VqELh8X4tR7mZ5l7IdewJdDCIuW/MTjAaNwq5+3zC1PaE2y9r4snf2Ihmk+RUzv
         HV6Q==
X-Gm-Message-State: AOJu0YzBA6UzOQS7yRrYc323X/rN5A1GLAxebYNNLa7WLFE2q37Kuv0C
        A52DvVlbxVvxv9Y3oFHYIzPnMQ==
X-Google-Smtp-Source: AGHT+IGXEcwoKYpM6C2uAQD5A4sGPWPRZ8l0B+QWJj0eO2MlZO81LuQW3BwsKpmY6OJUuVH9z0MNEw==
X-Received: by 2002:a05:6e02:1a4f:b0:352:a19c:a581 with SMTP id u15-20020a056e021a4f00b00352a19ca581mr17230008ilv.13.1696783568905;
        Sun, 08 Oct 2023 09:46:08 -0700 (PDT)
Received: from localhost (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id a9-20020a92ce49000000b0035142caa6edsm2398364ilr.6.2023.10.08.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 09:46:08 -0700 (PDT)
Date:   Sun, 8 Oct 2023 16:46:07 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Message-ID: <20231008164607.GB2338308@google.com>
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <98d06022-accd-a1df-7608-dcd6689b44ec@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d06022-accd-a1df-7608-dcd6689b44ec@linux.vnet.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 12:48:57AM +0530, Shrikanth Hegde wrote:
> 
> 
> On 10/5/23 9:47 PM, Joel Fernandes (Google) wrote:
> > From: Vineeth Pillai <vineethrp@google.com>
> > 
> > Whenever a CPU stops its tick, it now requires another idle CPU to handle the
> > balancing for it because it can't perform its own periodic load balancing.
> > This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
> > the upcoming nohz-idle load balancing is too distant in the future. This update
> > process is done by triggering an ILB, as the general ILB handler
> > (_nohz_idle_balance) that manages regular nohz balancing also refreshes
> > 'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
> > and selecting the smallest value.
> > 
> > Triggering this ILB can be achieved by setting the NOHZ_NEXT_KICK flag. This
> > primarily results in the ILB handler updating 'nohz.next_balance' while
> > possibly not doing any load balancing at all. However, sending an IPI merely to
> > refresh 'nohz.next_balance' seems excessive, and there ought to be a more
> > efficient method to update 'nohz.next_balance' from the local CPU.
> > 
> > Fortunately, there already exists a mechanism to directly invoke the ILB
> > handler (_nohz_idle_balance) without initiating an IPI. It's accomplished by
> > setting the NOHZ_NEWILB_KICK flag. This flag is set during regular "newly idle"
> > balancing and solely exists to update a CPU's blocked load if it couldn't pull
> > more tasks during regular "newly idle balancing" - and it does so without
> > having to send any IPIs. Once the flag is set, the ILB handler is called
> > directly from do_idle()-> nohz_run_idle_balance(). While its goal is to update
> > the blocked load without an IPI, in our situation, we aim to refresh
> > 'nohz.next_balance' without an IPI but we can piggy back on this.
> > 
> > So in this patch, we reuse this mechanism by also setting the NOHZ_NEXT_KICK to
> > indicate nohz.next_balance needs an update via this direct call shortcut. Note
> > that we set this flag without knowledge that the tick is about to be stopped,
> > because at the point we do it, we have no way of knowing that. However we do
> > know that the CPU is about to enter idle. In our testing, the reduction in IPIs
> > is well worth updating nohz.next_balance a few more times.
> > 
> > Also just to note, without this patch we observe the following pattern:
> > 
> > 1. A CPU is about to stop its tick.
> > 2. It sets nohz.needs_update to 1.
> > 3. It then stops its tick and goes idle.
> > 4. The scheduler tick on another CPU checks this flag and decides an ILB kick is needed.
> > 5. The ILB CPU ends up being the one that just stopped its tick!
> > 6. This results in an IPI to the tick-stopped CPU which ends up waking it up
> >    and disturbing it!
> > 
> > Testing shows a considerable reduction in IPIs when doing this:
> > 
> > Running "cyclictest -i 100 -d 100 --latency=1000 -t -m" on a 4vcpu VM
> > the IPI call count profiled over 10s period is as follows:
> > without fix: ~10500
> > with fix: ~1000
> > 
> > Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
> > 
> > [ Joel: wrote commit messages, collaborated on fix, helped reproduce issue etc. ]
> 
> Hi Joel/Vineeth. 
> 
> Its an interesting patch. 
> 
> Gave this patch a try on powerpc system with 96 CPU. (12 cores SMT8)
> Was debugging an issue where ILB count goes up significantly at a specific 
> busy CPU count. Haven't yet found out why. Its WIP. Was curious if this patch 
> would address that issue. 

Do you see that only from a specific kernel version onward? Have you tried
pre-6.1 kernels?

> cloned rt-test repo and ran same cyclictest command and collected 
> softirq's count using bcc tool. That count remains same more or less with patch. 
> Is what I am checking incorrect? Any other way to check IPI count?
> 
>         base 6.6_rc4    +patch
> 
> block       31.00        48.86
> net_rx     475.90       348.90
> timer     2213.20      2405.00
> rcu      33057.30     34738.10
> sched   175904.70    169695.60

So, we ran "perf stat -e irq:softirq_*" and counted those. For the sched
softirq, a majority of them were raised from the ILB path. This gave a clue
that it must be a flood of ILB.

For IPI counts, we run "perf record -a -g" and then "perf script" and look
for call stacks involving an smp_call. There's also /proc/interrupts that can
read out IPI counts.

We also used trace_printk in the ILB path, collected a trace, and count how
many times the ILB happens.

Vineeth collected the final data in this patch so I'll let him add any
details if he used some other method.

thanks,

 - Joel

> 
> 
> > 
> > Cc: Suleiman Souhlal <suleiman@google.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Hsin Yi <hsinyi@google.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Vineeth Pillai <vineethrp@google.com>
> > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/sched/fair.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cb225921bbca..2ece55f32782 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11786,13 +11786,12 @@ void nohz_balance_enter_idle(int cpu)
> >  	/*
> >  	 * Ensures that if nohz_idle_balance() fails to observe our
> >  	 * @idle_cpus_mask store, it must observe the @has_blocked
> > -	 * and @needs_update stores.
> > +	 * stores.
> >  	 */
> >  	smp_mb__after_atomic();
> >  
> >  	set_cpu_sd_state_idle(cpu);
> >  
> > -	WRITE_ONCE(nohz.needs_update, 1);
> >  out:
> >  	/*
> >  	 * Each time a cpu enter idle, we assume that it has blocked load and
> > @@ -11945,21 +11944,25 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
> >  }
> >  
> >  /*
> > - * Check if we need to run the ILB for updating blocked load before entering
> > - * idle state.
> > + * Check if we need to run the ILB for updating blocked load and/or updating
> > + * nohz.next_balance before entering idle state.
> >   */
> >  void nohz_run_idle_balance(int cpu)
> >  {
> >  	unsigned int flags;
> >  
> > -	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
> > +	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK | NOHZ_NEXT_KICK, nohz_flags(cpu));
> > +
> > +	if (!flags)
> > +		return;
> >  
> >  	/*
> >  	 * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
> >  	 * (ie NOHZ_STATS_KICK set) and will do the same.
> >  	 */
> > -	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
> > -		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
> > +	if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
> > +	    !need_resched())
> > +		_nohz_idle_balance(cpu_rq(cpu), flags);
> >  }
> >  
> >  static void nohz_newidle_balance(struct rq *this_rq)
> > @@ -11977,6 +11980,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
> >  	if (this_rq->avg_idle < sysctl_sched_migration_cost)
> >  		return;
> >  
> > +	/* If rq->next_balance before nohz.next_balance, trigger ILB */
> > +	if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance)))
> > +		atomic_or(NOHZ_NEXT_KICK, nohz_flags(this_cpu));
> > +
> >  	/* Don't need to update blocked load of idle CPUs*/
> >  	if (!READ_ONCE(nohz.has_blocked) ||
> >  	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
