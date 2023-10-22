Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF447D208A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 02:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjJVA2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 20:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJVA2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 20:28:12 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73237E8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 17:28:07 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3574f99d236so8006925ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 17:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697934487; x=1698539287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIkKNYnE4pG9i7ZaI/S+MbnvsoBKqeoQfqmpY9/coNA=;
        b=QFctFHN09QihYfXH4+rPp3O6AymTdxNx8pdr8MCc7/soKYS9YlV18v3QLjF03gOL54
         ySurWfJ+t1kOsWKemEP5nDPz3mgMSX3EHksAVPNr9hN+KbomnDDF9J/4R78TT0Lcadc9
         RrZDeoF9uNJ8QQHKFkL0rXGWX7XZChquYWjMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697934487; x=1698539287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIkKNYnE4pG9i7ZaI/S+MbnvsoBKqeoQfqmpY9/coNA=;
        b=AMZ4eyej1ItLejiv/1Hga0c2OBlUmUhkmI1N5MGXVSkeEfMHBybX4zMuiPRswNcwUq
         QzItJt3jb9eUWhpB+4q2e763iXgIp0pRUKTRFZuHYGpv9ctN+6v+ghGHPdaZWbNR9m8R
         hX1q+aVFMnk5PryM01jF4fr2Zij0/oJH9DIoXWSoQ47oyLIprBlqvi6PQvS0xaoqGyt5
         hXM2MHUd6deXB/VL2HqGqnV6iF2lFmYyjnx1w5VV5ZZc2twShRULqFBx7jSk9SFQkn3R
         Gn1qcxVkpWGR7l8nAWp9nkgVj5EfS0nLHufAweTG31+fF0aqfqxXLULbaUSVBZ4sLqCp
         HIlA==
X-Gm-Message-State: AOJu0YxzPzQdSLAP+rmPJzlhb3fFgnsoiZDoFJ5tKzr3lT+Fg0Z5N36/
        b7YVorcjO7Vts4/SK71kXZJixQ==
X-Google-Smtp-Source: AGHT+IFiH27szdDLri3n69KGuzBDjlQ2JFC0qHUAZYF7F+MmKrIGLQGZafdaYJ+sfNtKtHGqmgd3yA==
X-Received: by 2002:a05:6e02:b22:b0:34f:68fe:630 with SMTP id e2-20020a056e020b2200b0034f68fe0630mr7424575ilu.25.1697934486704;
        Sat, 21 Oct 2023 17:28:06 -0700 (PDT)
Received: from localhost (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id p3-20020a92d683000000b0034e2572bb50sm1592092iln.13.2023.10.21.17.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 17:28:06 -0700 (PDT)
Date:   Sun, 22 Oct 2023 00:28:05 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during
 newidle balance
Message-ID: <20231022002805.GA3219395@google.com>
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org>
 <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:40:14PM +0200, Vincent Guittot wrote:
> On Fri, 20 Oct 2023 at 03:40, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
> >
> > When newidle balancing triggers, we see that it constantly clobbers
> > rq->next_balance even when there is no newidle balance happening due to
> > the cost estimates.  Due to this, we see that periodic load balance
> > (rebalance_domains) may trigger way more often when the CPU is going in
> > and out of idle at a high rate but is no really idle. Repeatedly
> > triggering load balance there is a bad idea as it is a heavy operation.
> > It also causes increases in softirq.
> 
> we have 2 balance intervals:
> - one when idle based on the sd->balance_interval = sd_weight
> - one when busy which increases the period by multiplying it with
> busy_factor = 16

On my production system I see load balance triggering every 4 jiffies! In a
Qemu system (which I use for traces below), I see every 8 jiffies. I'll go
look into that more as well, it could be something going on in
get_sd_balance_interval().

> When becoming idle, the rq->next_balance can have been set using the
> 16*sd_weight period so load_balance can wait for a long time before
> running idle load balance for this cpu.

Got it.

> As a typical example, instead of waiting at most 8ms, we will wait
> 128ms before we try to pull a task on the idle CPU.
> 
> That's the reason for updating rq->next_balance in newidle_balance()

Got it, makes sense. But I still feel the mechanism is too aggressive, see
below.

> > Another issue is ->last_balance is not updated after newidle balance
> > causing mistakes in the ->next_balance calculations.
> 
> newly idle load balance is not equal to idle load balance. It's a
> light load balance trying to pull one  task and you can't really
> consider it to the normal load balance

True. However the point is that it is coupled with the other load balance
mechanism and the two are not independent. As you can see below, modifying
rq->next_balance in newidle also causes the periodic balance to happen more
aggressively as well if there is a high transition from busy to idle and
viceversa.

> > Fix by updating last_balance when a newidle load balance actually
> > happens and then updating next_balance. This is also how it is done in
> > other load balance paths.
> >
> > Testing shows a significant drop in softirqs when running:
> > cyclictest -i 100 -d 100 --latency=1000 -D 5 -t -m  -q
> >
> > Goes from ~6k to ~800.
> 
> Even if your figures look interesting, your patch adds regression in
> the load balance and the fairness.

Yes I see that now. However it does illustrate the problem IMO.

> We can probably do improve the current behavior for decreasing number
> of ILB but your proposal is not the right solution IMO

One of the problems is if you have task goes idle a lot, then the
newidle_balance mechanism triggers the periodic balance every jiffie (once
per millisecond on HZ=1000).

Following are some traces I collected.

cyclictest-123   [003]   522.650574  newidle_balance: this_rq[cpu=3]->next_balance: 221,264 -> 221,145 (jiffies=221,157)
   <idle>-0      [003]   522.651443  trigger_load_balance: time_after_eq(jiffies=221,158, rq->next_balance=221,145) = 1
   <idle>-0      [003]   522.651461  rebalance_domains: rq[cpu=3]->next_balance: 221,145 -> 221,264 (jiffies=221,158)
cyclictest-123   [003]   522.651494  newidle_balance: this_rq[cpu=3]->next_balance: 221,264 -> 221,145 (jiffies=221,158)
   <idle>-0      [003]   522.652522  trigger_load_balance: time_after_eq(jiffies=221,159, rq->next_balance=221,145) = 1
   <idle>-0      [003]   522.652560  rebalance_domains: rq[cpu=3]->next_balance: 221,145 -> 221,264 (jiffies=221,159)
cyclictest-124   [003]   522.652586  newidle_balance: this_rq[cpu=3]->next_balance: 221,264 -> 221,145 (jiffies=221,159)
   <idle>-0      [003]   522.654492  trigger_load_balance: time_after_eq(jiffies=221,161, rq->next_balance=221,145) = 1
   <idle>-0      [003]   522.654534  rebalance_domains: rq[cpu=3]->next_balance: 221,145 -> 221,264 (jiffies=221,161)

Triggering it so aggressively likely that is useless, it increases softirq
count and hurts power when no real work is done IMHO. And it probably makes
things worse for power on ARM where you have uclamp stuff happening in the
load balance paths which is quite heavy when I last traced that..

Further, we have observed in our tracing on real device that the update of
rq->next_balance from the newidle path is itself buggy... we observed that
because newidle balance may not update rq->last_balance, it is possible that
rq->next_balance when updated by update_next_balance() will be updated to a
value that is in the past and it will be stuck there for a long time! Perhaps
we should investigate more and fix that bug separately. Vineeth could provide
more details on the "getting stuck in the past" behavior as well.

I hope these patches highlight some of the issues we find and can trigger any
improvements by us or others. From our side we'll continue to work on it and
thank you for explaining some of the load balance code!

thanks,

 - Joel & Vineeth


> 
> >
> > Cc: Suleiman Souhlal <suleiman@google.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/sched/fair.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8e276d12c3cb..b147ad09126a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -12076,11 +12076,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >
> >         if (!READ_ONCE(this_rq->rd->overload) ||
> >             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> > -
> > -               if (sd)
> > -                       update_next_balance(sd, &next_balance);
> >                 rcu_read_unlock();
> > -
> >                 goto out;
> >         }
> >         rcu_read_unlock();
> > @@ -12095,8 +12091,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >                 int continue_balancing = 1;
> >                 u64 domain_cost;
> >
> > -               update_next_balance(sd, &next_balance);
> > -
> >                 if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
> >                         break;
> >
> > @@ -12109,6 +12103,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >                         t1 = sched_clock_cpu(this_cpu);
> >                         domain_cost = t1 - t0;
> >                         update_newidle_cost(sd, domain_cost);
> > +                       sd->last_balance = jiffies;
> > +                       update_next_balance(sd, &next_balance);
> >
> >                         curr_cost += domain_cost;
> >                         t0 = t1;
> > --
> > 2.42.0.655.g421f12c284-goog
> >
