Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E597BF3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442423AbjJJHPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379439AbjJJHPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:15:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944DDCF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:15:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso4782478b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696922132; x=1697526932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1bv9a5kg6ueVzpxutD0hg3nIXvYEYVLM37qCCKpPdaU=;
        b=c6k8CK7y4DTQWdqI3x7gtdZxgKkHmspEdmJ3uNjVaGJKpeEup169eJygPvKFSMMdl6
         nBvHHv64Ctl+ckZ7tBP3ccxpx1tn0QhMaGHi6sHMStQyT7VKtGNPrd/cKu4IPseDUFIY
         ko74jcPMyjRzwQdk/Dc2nL6RMxZGzPXvz2ZEuT5sz2PIVlxNAU+lg4YQIwRzSznHBNN5
         MvayeCPe63a4hmCxowRN5nSyDm1SF5Ag+gOj/IeK4WM6AV+pORKLZHaQQWKzdjYrykaG
         Pyp7D5MBaiqelx9Gx5MabC3T21hs7G9YUU4BDTmzWV7ynpJmFvY3xKvlQrl75Uh6rQQ6
         puVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696922132; x=1697526932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bv9a5kg6ueVzpxutD0hg3nIXvYEYVLM37qCCKpPdaU=;
        b=WfmnFBmmpEb/+MWB+XIeqxKj1GSJAdv/41SvhZpk1D0KROGaO2i8Xb+sBjyy7gwjss
         M7paBbtXUkEHSmMb5FVY8tnRZNDWZ7t8ChFi+RsPgj/OXkp6N80aCiwfjUf7JinDgHSW
         sLhqKXTzOsu64q2dP0ycFaaXSWjGUbyLxl5YZ1bhyRNuJc82yRZtRWFPOvAx/JjEFmbG
         pprn6KOIcDbP6KsPfZWyb1dwrASM+ES9oHixJcrSy+nhjfFWBf+PQ3KF7nQMLhns3ZpS
         upT705K/vjMe1tqxZHkAgHnSx2sOelyUpGBkeqtZFeDM20dqTuVsXu+OyzoDmvJKZmwZ
         roOA==
X-Gm-Message-State: AOJu0YzksBorWXX6aUQWhom2UegYCUHGKa9FsKjNJsNAoS+K39mF0aCH
        +CKuMclxA3NKojOaWOS0yYPoeIYzgBaDevjgG0Ojyg==
X-Google-Smtp-Source: AGHT+IFOhNl6S3IKmrs5347NExT+5SE9A6jdTzQSqjCXDpvP/8cijbA0DPfqxR4MxGgPppXNK2a9lHHzKNQ1tpj4T3I=
X-Received: by 2002:a05:6a00:2d23:b0:690:c5cf:91f4 with SMTP id
 fa35-20020a056a002d2300b00690c5cf91f4mr19813686pfb.12.1696922132443; Tue, 10
 Oct 2023 00:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <ZR/mvd8Uw8PG+jx0@gmail.com> <20231008173535.GD2338308@google.com>
In-Reply-To: <20231008173535.GD2338308@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 10 Oct 2023 09:15:21 +0200
Message-ID: <CAKfTPtAmoG-QRs0uJJoe1Y0+MFOzH-yrqTFb6Jdrnjyo-N98BQ@mail.gmail.com>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Oct 2023 at 19:35, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Oct 06, 2023 at 12:51:41PM +0200, Ingo Molnar wrote:
> >
> > * Joel Fernandes (Google) <joel@joelfernandes.org> wrote:
> >
> > > From: Vineeth Pillai <vineethrp@google.com>
> > >
> > > Whenever a CPU stops its tick, it now requires another idle CPU to handle the
> > > balancing for it because it can't perform its own periodic load balancing.
> > > This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
> > > the upcoming nohz-idle load balancing is too distant in the future. This update
> > > process is done by triggering an ILB, as the general ILB handler
> > > (_nohz_idle_balance) that manages regular nohz balancing also refreshes
> > > 'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
> > > and selecting the smallest value.
> > >
> > > Triggering this ILB can be achieved by setting the NOHZ_NEXT_KICK flag. This
> > > primarily results in the ILB handler updating 'nohz.next_balance' while
> > > possibly not doing any load balancing at all. However, sending an IPI merely to
> > > refresh 'nohz.next_balance' seems excessive, and there ought to be a more
> > > efficient method to update 'nohz.next_balance' from the local CPU.
> > >
> > > Fortunately, there already exists a mechanism to directly invoke the ILB
> > > handler (_nohz_idle_balance) without initiating an IPI. It's accomplished by
> > > setting the NOHZ_NEWILB_KICK flag. This flag is set during regular "newly idle"
> > > balancing and solely exists to update a CPU's blocked load if it couldn't pull
> > > more tasks during regular "newly idle balancing" - and it does so without
> > > having to send any IPIs. Once the flag is set, the ILB handler is called
> > > directly from do_idle()-> nohz_run_idle_balance(). While its goal is to update
> > > the blocked load without an IPI, in our situation, we aim to refresh
> > > 'nohz.next_balance' without an IPI but we can piggy back on this.
> > >
> > > So in this patch, we reuse this mechanism by also setting the NOHZ_NEXT_KICK to
> > > indicate nohz.next_balance needs an update via this direct call shortcut. Note
> > > that we set this flag without knowledge that the tick is about to be stopped,
> > > because at the point we do it, we have no way of knowing that. However we do
> > > know that the CPU is about to enter idle. In our testing, the reduction in IPIs
> > > is well worth updating nohz.next_balance a few more times.
> > >
> > > Also just to note, without this patch we observe the following pattern:
> > >
> > > 1. A CPU is about to stop its tick.
> > > 2. It sets nohz.needs_update to 1.
> > > 3. It then stops its tick and goes idle.
> > > 4. The scheduler tick on another CPU checks this flag and decides an ILB kick is needed.
> > > 5. The ILB CPU ends up being the one that just stopped its tick!
> > > 6. This results in an IPI to the tick-stopped CPU which ends up waking it up
> > >    and disturbing it!
> > >
> > > Testing shows a considerable reduction in IPIs when doing this:
> > >
> > > Running "cyclictest -i 100 -d 100 --latency=1000 -t -m" on a 4vcpu VM
> > > the IPI call count profiled over 10s period is as follows:
> > > without fix: ~10500
> > > with fix: ~1000
> > >
> > > Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
> > >
> > > [ Joel: wrote commit messages, collaborated on fix, helped reproduce issue etc. ]
> > >
> > > Cc: Suleiman Souhlal <suleiman@google.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Hsin Yi <hsinyi@google.com>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Vineeth Pillai <vineethrp@google.com>
> > > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/sched/fair.c | 21 ++++++++++++++-------
> > >  1 file changed, 14 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index cb225921bbca..2ece55f32782 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -11786,13 +11786,12 @@ void nohz_balance_enter_idle(int cpu)
> > >     /*
> > >      * Ensures that if nohz_idle_balance() fails to observe our
> > >      * @idle_cpus_mask store, it must observe the @has_blocked
> > > -    * and @needs_update stores.
> > > +    * stores.
> > >      */
> > >     smp_mb__after_atomic();
> > >
> > >     set_cpu_sd_state_idle(cpu);
> > >
> > > -   WRITE_ONCE(nohz.needs_update, 1);
> > >  out:
> > >     /*
> > >      * Each time a cpu enter idle, we assume that it has blocked load and
> > > @@ -11945,21 +11944,25 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
> > >  }
> > >
> > >  /*
> > > - * Check if we need to run the ILB for updating blocked load before entering
> > > - * idle state.
> > > + * Check if we need to run the ILB for updating blocked load and/or updating
> > > + * nohz.next_balance before entering idle state.
> > >   */
> > >  void nohz_run_idle_balance(int cpu)
> > >  {
> > >     unsigned int flags;
> > >
> > > -   flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
> > > +   flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK | NOHZ_NEXT_KICK, nohz_flags(cpu));
> > > +
> > > +   if (!flags)
> > > +           return;
> > >
> > >     /*
> > >      * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
> > >      * (ie NOHZ_STATS_KICK set) and will do the same.
> > >      */
> > > -   if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
> > > -           _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
> > > +   if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
> > > +       !need_resched())
> > > +           _nohz_idle_balance(cpu_rq(cpu), flags);
> > >  }
> > >
> > >  static void nohz_newidle_balance(struct rq *this_rq)
> > > @@ -11977,6 +11980,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
> > >     if (this_rq->avg_idle < sysctl_sched_migration_cost)
> > >             return;
> > >
> > > +   /* If rq->next_balance before nohz.next_balance, trigger ILB */
> > > +   if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance)))
> > > +           atomic_or(NOHZ_NEXT_KICK, nohz_flags(this_cpu));
> > > +
> > >     /* Don't need to update blocked load of idle CPUs*/
> > >     if (!READ_ONCE(nohz.has_blocked) ||
> > >         time_before(jiffies, READ_ONCE(nohz.next_blocked)))
> >
> > Ok, judging by your IPI reduction numbers this is definitely an
> > optimization we want to do.
> >
> > The patch does make _nohz_idle_balance() run more parallel, as previously
> > it would be generally run by the first-idle CPU in nohz.idle_cpus_mask (at
> > least for next_balance updates), but I think it's still SMP-safe, as all
> > key data structure updates are already rq-locked AFAICS.
>
> One thing I am confused about in the original code is:
>
> tick_nohz_idle_stop_tick() is what sets the nohz.idle_cpus_mask.
> However, nohz_run_idle_balance() is called before that can happen, in
> do_idle(). So it is possible that NOHZ_NEWILB_KICK is set for a CPU but it is
> not yet in the mask.

2 things:
- update of nohz.idle_cpus_mask is not strictly aligned with cpu
entering/exiting idle state. It is set when entering but only cleared
during the next tick on the cpu because nohz.idle_cpus_mask is a
bottleneck when all CPUs enter/exit idle at high rate (usec). This
implies that a cpu entering idle can already be set in
nohz.idle_cpus_mask
- NOHZ_NEWILB_KICK is more about updating blocked load of others
already idle CPUs than the one entering idle which has already updated
its blocked load in newidle_balance()

The goal of nohz_run_idle_balance() is to run ILB only for updating
the blocked load of already idle CPUs without waking up one of those
idle CPUs and outside the preempt disable / irq off phase of the local
cpu about to enter idle because it can take a long time.

>
> So will this code in _nohz_idle_balance() really run in such a scenario?
>
>                 if (flags & NOHZ_STATS_KICK)
>                         has_blocked_load |= update_nohz_stats(rq);
>
> AFAICS, this loop may not select the CPU due to its absence from the mask:
>         for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1)
>
> I must be missing something. I'll go trace this path later as well.
>
> thanks,
>
>  - Joel
>
