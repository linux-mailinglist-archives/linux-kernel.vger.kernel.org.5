Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0220A7D848F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbjJZOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjJZOXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:23:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76F1B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:23:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5a9d8f4388bso706601a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698330227; x=1698935027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=73jtFgDVROsytnjcWc12Mdu1oBsXpBBdzgXeJGwYuzE=;
        b=XyT4g4lbT9vKj1KQend6Q4rwXDR60uQYjq5mROqPy/8VmabzcCmBK4M4cxTKkEL4hP
         VUKneDOATLeFbDBCaIlg+2UXyoZI9GOu5O0habz3EnuF8apzquZe4euPXoAvOh/1XM2L
         yD+HtxI0dqBOyfaH2MvypK6F1Ip+aevK3zZhMNKGe+HEk0KumaXuohKvYJlzAh9RjNIt
         eDfmjQKYx8muz8ZSUgZCh4C7Re/b6Rur3lo0wgDZ4YC45yZIc+11MlyDnK8Mv7CnYfdn
         ETTlsX3hI6yosqDiTWxrJff64eRsNv6DBk1M73D7wjoi+4qGkdoDUhEnBvSFrEgbVQoR
         DQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330227; x=1698935027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73jtFgDVROsytnjcWc12Mdu1oBsXpBBdzgXeJGwYuzE=;
        b=xSedOiHJ7HEC4RkvzgiVbGO42G1LIP9evFX8uKskbvn88YKNLeDrKIPV9Mbr/Qksso
         Mfw8B6wmGtxrIAG/BgL8YIov8JStm7+czX13c4bdUYTATu9BiN4qYDnfdnQuKHcMSuLE
         dllbTgppXFyqWVLD2yBcnizsVem1ofKuwgnUeN/WOMQz/1w7E/Q4mik/V7SSSeO3Ct7c
         k5UQiEeytOmTcvckgOl33sZ06Mu4W/0dW/LGPjvXcU56mhpvlswBcN9tmZ8lISN025h/
         9JlRpQoN0IvAapGnAMrSScikYIump1dYVT6ksLFSlyQkxvfX2K5R46L+deSDax3fN5nM
         zEKA==
X-Gm-Message-State: AOJu0YwjmB2sZ2GuNSHQp6GDPY6FH8UHAFC+Rrlgo+GecN2AdeF0te93
        NL60eT5qAOkJbo3WQeqiUAASFcbzliPbFLDz5VpKCg==
X-Google-Smtp-Source: AGHT+IH1gpga4R0PGAgt4dWcs1eWXO2MXzZPshrXO5n1GJE5hJgW9/49QHfQbWNvXmIpFkDjJZkBVD7KUbcIJEGLorE=
X-Received: by 2002:a17:90a:6096:b0:27d:46e5:2d7c with SMTP id
 z22-20020a17090a609600b0027d46e52d7cmr15584149pji.26.1698330227350; Thu, 26
 Oct 2023 07:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org> <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
 <20231022002805.GA3219395@google.com>
In-Reply-To: <20231022002805.GA3219395@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Oct 2023 16:23:35 +0200
Message-ID: <CAKfTPtCAbMERMkD9h1QRLUti0nPVW_u9N1Vr7W4ONbu_rEjTtw@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during newidle balance
To:     Joel Fernandes <joel@joelfernandes.org>
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

On Sun, 22 Oct 2023 at 02:28, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Oct 20, 2023 at 03:40:14PM +0200, Vincent Guittot wrote:
> > On Fri, 20 Oct 2023 at 03:40, Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
> > >
> > > When newidle balancing triggers, we see that it constantly clobbers
> > > rq->next_balance even when there is no newidle balance happening due to
> > > the cost estimates.  Due to this, we see that periodic load balance
> > > (rebalance_domains) may trigger way more often when the CPU is going in
> > > and out of idle at a high rate but is no really idle. Repeatedly
> > > triggering load balance there is a bad idea as it is a heavy operation.
> > > It also causes increases in softirq.
> >
> > we have 2 balance intervals:
> > - one when idle based on the sd->balance_interval = sd_weight
> > - one when busy which increases the period by multiplying it with
> > busy_factor = 16
>
> On my production system I see load balance triggering every 4 jiffies! In a

Which kind of system do you have? sd->balance_interval is in ms

> Qemu system (which I use for traces below), I see every 8 jiffies. I'll go
> look into that more as well, it could be something going on in
> get_sd_balance_interval().
>
> > When becoming idle, the rq->next_balance can have been set using the
> > 16*sd_weight period so load_balance can wait for a long time before
> > running idle load balance for this cpu.
>
> Got it.
>
> > As a typical example, instead of waiting at most 8ms, we will wait
> > 128ms before we try to pull a task on the idle CPU.
> >
> > That's the reason for updating rq->next_balance in newidle_balance()
>
> Got it, makes sense. But I still feel the mechanism is too aggressive, see
> below.
>
> > > Another issue is ->last_balance is not updated after newidle balance
> > > causing mistakes in the ->next_balance calculations.
> >
> > newly idle load balance is not equal to idle load balance. It's a
> > light load balance trying to pull one  task and you can't really
> > consider it to the normal load balance
>
> True. However the point is that it is coupled with the other load balance
> mechanism and the two are not independent. As you can see below, modifying
> rq->next_balance in newidle also causes the periodic balance to happen more
> aggressively as well if there is a high transition from busy to idle and
> viceversa.

As mentioned, rq->next_balance is updated whenever cpu enters idle
(i.e. in newidle_balance() but it's not related with doing a newly
idle load balance. But your problem is more related with the fact that
nohz.needs_update is set when stopping cpu timer in order to update
nohz.next_balance which is then used to kick a "real" idle load
balance

>
> > > Fix by updating last_balance when a newidle load balance actually
> > > happens and then updating next_balance. This is also how it is done in
> > > other load balance paths.
> > >
> > > Testing shows a significant drop in softirqs when running:
> > > cyclictest -i 100 -d 100 --latency=1000 -D 5 -t -m  -q
> > >
> > > Goes from ~6k to ~800.
> >
> > Even if your figures look interesting, your patch adds regression in
> > the load balance and the fairness.
>
> Yes I see that now. However it does illustrate the problem IMO.
>
> > We can probably do improve the current behavior for decreasing number
> > of ILB but your proposal is not the right solution IMO
>
> One of the problems is if you have task goes idle a lot, then the
> newidle_balance mechanism triggers the periodic balance every jiffie (once
> per millisecond on HZ=1000).

every msec seems quite a lot.

>
> Following are some traces I collected.
>
> cyclictest-123   [003]   522.650574  newidle_balance: this_rq[cpu=3]->next_balance: 221,264 -> 221,145 (jiffies=221,157)
>    <idle>-0      [003]   522.651443  trigger_load_balance: time_after_eq(jiffies=221,158, rq->next_balance=221,145) = 1
>    <idle>-0      [003]   522.651461  rebalance_domains: rq[cpu=3]->next_balance: 221,145 -> 221,264 (jiffies=221,158)
> cyclictest-123   [003]   522.651494  newidle_balance: this_rq[cpu=3]->next_balance: 221,264 -> 221,145 (jiffies=221,158)
>    <idle>-0      [003]   522.652522  trigger_load_balance: time_after_eq(jiffies=221,159, rq->next_balance=221,145) = 1
>    <idle>-0      [003]   522.652560  rebalance_domains: rq[cpu=3]->next_balance: 221,145 -> 221,264 (jiffies=221,159)
> cyclictest-124   [003]   522.652586  newidle_balance: this_rq[cpu=3]->next_balance: 221,264 -> 221,145 (jiffies=221,159)
>    <idle>-0      [003]   522.654492  trigger_load_balance: time_after_eq(jiffies=221,161, rq->next_balance=221,145) = 1
>    <idle>-0      [003]   522.654534  rebalance_domains: rq[cpu=3]->next_balance: 221,145 -> 221,264 (jiffies=221,161)

Ok, so IIUC your trace above, this happens because the tick is not
stop after entering idle so it continues to fire and triggers a load
balance without checking if there is a need like what is done for nohz
mode

>
> Triggering it so aggressively likely that is useless, it increases softirq
> count and hurts power when no real work is done IMHO. And it probably makes

In the case above, the tick has already fired because it was not
stopped. I mean that it's not the ilb which triggers this and woke up
the cpu but it takes advantage of the tick so most of the pain has
already happened (wakeup the cpu which was probably in a shallow
c-state to let its tick firing)

> things worse for power on ARM where you have uclamp stuff happening in the
> load balance paths which is quite heavy when I last traced that..
>
> Further, we have observed in our tracing on real device that the update of
> rq->next_balance from the newidle path is itself buggy... we observed that
> because newidle balance may not update rq->last_balance, it is possible that
> rq->next_balance when updated by update_next_balance() will be updated to a
> value that is in the past and it will be stuck there for a long time! Perhaps
> we should investigate more and fix that bug separately. Vineeth could provide
> more details on the "getting stuck in the past" behavior as well.

sd->last_balance reflects last time an idle/busy load_balance happened
(newly idle is out of the scope for the points that I mentioned
previously).  So if no load balance happens for a while, the
rq->next_balance can be in the past but I don't see a problem here. It
just means that a load balance hasn't happened for a while. It can
even move backward if it has been set when busy but the cpu is now
idle

>
> I hope these patches highlight some of the issues we find and can trigger any
> improvements by us or others. From our side we'll continue to work on it and
> thank you for explaining some of the load balance code!
>
> thanks,
>
>  - Joel & Vineeth
>
>
> >
> > >
> > > Cc: Suleiman Souhlal <suleiman@google.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/sched/fair.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 8e276d12c3cb..b147ad09126a 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -12076,11 +12076,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > >
> > >         if (!READ_ONCE(this_rq->rd->overload) ||
> > >             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> > > -
> > > -               if (sd)
> > > -                       update_next_balance(sd, &next_balance);
> > >                 rcu_read_unlock();
> > > -
> > >                 goto out;
> > >         }
> > >         rcu_read_unlock();
> > > @@ -12095,8 +12091,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > >                 int continue_balancing = 1;
> > >                 u64 domain_cost;
> > >
> > > -               update_next_balance(sd, &next_balance);
> > > -
> > >                 if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
> > >                         break;
> > >
> > > @@ -12109,6 +12103,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > >                         t1 = sched_clock_cpu(this_cpu);
> > >                         domain_cost = t1 - t0;
> > >                         update_newidle_cost(sd, domain_cost);
> > > +                       sd->last_balance = jiffies;
> > > +                       update_next_balance(sd, &next_balance);
> > >
> > >                         curr_cost += domain_cost;
> > >                         t0 = t1;
> > > --
> > > 2.42.0.655.g421f12c284-goog
> > >
