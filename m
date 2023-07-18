Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB7758367
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjGRRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGRRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:25:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8491BE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:25:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so59679085e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689701132; x=1692293132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a7bdwP0hz+smn1w/RM7zDCqdYvPs1/udj7N2FtfNo4c=;
        b=jwC51CSQV0Xo/wjuVlJhSjW6mqm5XRKlXCLptju+qCYWba/3p+GXsJjdR2/2T6LZdg
         0GdkKr5yw+o0vxd/Taiz/Xp/geanzNikdepB6iAQF/QRiTqfk3pY98tVGV2j639uvv7V
         wiK4FLoehy8iUpWPoavaUOv/e0rlIumFdpbx8mIsw1uxqG/vmCmh2v/hKGK/tmC8zdwD
         DIOKBH3IYUo4v/A9KTLfpVtRvh36X5UsWoWQo232lYQg4r7+JJ6x37GNnnqyHGq9Ar2m
         54eDuZw5Fsa+d4jnKn1aQM3+s6/FL75uv6qA9qgyjo8LRthjujysCKeOnOSeTq2/TC/r
         8M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689701132; x=1692293132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7bdwP0hz+smn1w/RM7zDCqdYvPs1/udj7N2FtfNo4c=;
        b=An483a1PKUrJU3UGcvI+h7DhYZDVQga+EWruq69Du0yUDVkzHNKuaSvpVohA8aF+8m
         GOIjglSz3IDsAjRjlHXmIVz5JArp2ZgKk4t03dyrQH3pO7LDYW1Xdf2fZRjAAGareRN9
         rbAWzEeCLQGXvRtHzFNqr2VUYM6HmP8KTWpLjeR2s/O+QMvbGVGwRkWzOwANSO7wst/y
         IFVDvWLhZuGRY+mdbcxRAIdRRKRat6YDPp9LbnFM2LoHiGOWdzv18KRoCe6yw8m8qJpS
         hErHPXPi/UuBGMEVoeLSMf9UQ8JsX/x+jgwMT7g20j6dPAIxfpRskheppCjpp7igASVp
         UUdA==
X-Gm-Message-State: ABy/qLajSNu+MBLWqzgGjvV0Ifgg1CCL/pvIl04cDjI8b8pKfjmmbRaQ
        VK3mHe0yRhSSn3P8hcbtlnkCNaB2XFJwcahrEe8=
X-Google-Smtp-Source: APBJJlEWa7t73SLRBrNuRVUDQYLy6BM1T94haYSswf0x5LDx14Bs6XEuMPzq3IuaxJa9Jg9ndVGcOQ==
X-Received: by 2002:adf:ec51:0:b0:314:1ce8:a0a1 with SMTP id w17-20020adfec51000000b003141ce8a0a1mr259748wrn.17.1689701131757;
        Tue, 18 Jul 2023 10:25:31 -0700 (PDT)
Received: from airbuntu ([104.132.45.110])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b00313e4d02be8sm2916762wrs.55.2023.07.18.10.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:25:31 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:25:22 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Message-ID: <20230718172522.s4gcfx3ppljwbks7@airbuntu>
References: <20230716014125.139577-1-qyousef@layalina.io>
 <ZLaKFFjY6NWaJdOq@vingu-book>
 <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
 <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_PH_BODY_ACCOUNTS_PRE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/23 18:31, Vincent Guittot wrote:
> On Tue, 18 Jul 2023 at 18:18, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 07/18/23 14:48, Vincent Guittot wrote:
> > > Le dimanche 16 juil. 2023 à 02:41:25 (+0100), Qais Yousef a écrit :
> > > > We've seen cases while running geekbench that an idle little core never
> > > > pulls a task from a bigger overloaded cluster for 100s of ms and
> > > > sometimes over a second.
> > > >
> > > > It turned out that the load balance identifies this as a migrate_util
> > > > type since the local group (little cluster) has a spare capacity and
> > > > will try to pull a task. But the little cluster capacity is very small
> > > > nowadays (around 200 or less) and if two busy tasks are stuck on a mid
> > > > core which has a capacity of over 700, this means the util of each tasks
> > > > will be around 350+ range. Which is always bigger than the spare
> > > > capacity of the little group with a single idle core.
> > > >
> > > > When trying to detach_tasks() we bail out then because of the comparison
> > > > of:
> > > >
> > > >     if (util > env->imbalance)
> > > >             goto next;
> > > >
> > > > In calculate_imbalance() we convert a migrate_util into migrate_task
> > > > type if the CPU trying to do the pull is idle. But we only do this if
> > > > env->imbalance is 0; which I can't understand. AFAICT env->imbalance
> > > > contains the local group's spare capacity. If it is 0, this means it's
> > > > fully busy.
> > > >
> > > > Removing this condition fixes the problem, but since I can't fully
> > > > understand why it checks for 0, sending this as RFC. It could be a typo
> > > > and meant to check for
> > > >
> > > >     env->imbalance != 0
> > > >
> > > > instead?
> > > >
> > > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > > ---
> > > >  kernel/sched/fair.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index a80a73909dc2..682d9d6a8691 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -10288,7 +10288,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> > > >                      * waiting task in this overloaded busiest group. Let's
> > > >                      * try to pull it.
> > > >                      */
> > > > -                   if (env->idle != CPU_NOT_IDLE && env->imbalance == 0) {
> > > > +                   if (env->idle != CPU_NOT_IDLE) {
> > >
> > > With this change you completely skip migrate_util for idle and newly idle case
> > > and this would be too aggressive.
> >
> > Yeah I didn't have great confidence in it to be honest.
> >
> > Could you help me understand the meaning of env->imbalance == 0 though? At this
> > stage its value is
> >
> >         env->imbalance = max(local->group_capacity, local->group_util) - local->group_util;
> >
> > which AFAICT is calculating the _spare_ capacity, right? So when we check
> > env->imbalance == 0 we say if this_cpu is (idle OR newly idle) AND the local
> > group is fully utilized? Why it must be fully utilized to do the pull? It's
> > counter intuitive to me. I'm probably misinterpreting something but can't see
> 
> This is a special case. We have some situations where group_util is
> higher than capacity because of tasks newly migrated to this group for
> example so the spare capacity is null but one cpu is idle or newly
> idle. In this case we try to pull a task with the risk that this group
> becomes overloaded. That's why we do not try to pull a task every
> time.
> But that might be good choice all the time

So on misfit, I do see that a bigger cpu will pull the task quickly as soon as
a bigger cpu gets idle.

This scenario is the opposite. Maybe the exception in my case is that the
little cpu has spare capacity as it's mostly idle all the time. It's just
unlucky circumstances at wake up ended up putting two tasks on bigger core.

Specifically, at the start of some of the sub-tests, there's a good chance that
we have simultaneous wake ups and there's a limitation/race in EAS because of
the gap between select_task_rq_fair() and enqueue_task_fair(). If two task wake
up simultaneously, select_task_rq_fair() could be called twice before the
enqueue_task_fair() and end up selecting the same CPU for both tasks not
realizing one of them is just waiting to be enqueued. IOW, EAS will not take
into account the updated util of one of the CPUs because of the (short) delay
to enqueue it.

This should be fixed (the wake up race), but this is a different story and
a bit trickier.

The risk of pulling always is:

	1. Risk force migrating prev task if it woke up shortly after the pull.
	   Which is no worse IMHO than misfit going almost immediately to
	   bigger core.

	2. Not sure of not being too smart about which task to pull. I can
	   envisage other scenarios where one of the two tasks is better to
	   pull. In geekbench both tasks are equal. But maybe in other use
	   cases one of them less impactful. For example if one of them has
	   a low uclamp_max but the other doesn't. But this case is unsupported
	   feature at the moment. My plan (hope) to treat these uclamp_max as
	   misfit migration. Which I think is the better path in general to
	   treat special cases. So for migration_util this behavior might be
	   sensible all the time. We are working too hard, let's use all of our
	   resources and make use all of idle cpus. If prev_task wakes up,
	   there's no harm; I doubt the cache hotness is a problem even given
	   two tasks are busy all the time trashing L1 anyway.

	3. Not sure what will happen in cases we have nu_running > nr_cpus and
	   some tasks happen to sleep for brief period of times. Two tasks
	   stuck on little core is worse than two tasks stuck on mid or big
	   core. But maybe migrate_util will pull it back again given how
	   little capacity they have?

Cheers

--
Qais Yousef

> 
> > it.
> >
> > >
> > > We can do something similar to migrate_load in detach_tasks():
> > >
> > > ---
> > >  kernel/sched/fair.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d3df5b1642a6..64111ac7e137 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8834,7 +8834,13 @@ static int detach_tasks(struct lb_env *env)
> > >               case migrate_util:
> > >                       util = task_util_est(p);
> > >
> > > -                     if (util > env->imbalance)
> > > +                     /*
> > > +                      * Make sure that we don't migrate too much utilization.
> > > +                      * Nevertheless, let relax the constraint if
> > > +                      * scheduler fails to find a good waiting task to
> > > +                      * migrate.
> > > +                      */
> > > +                     if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
> > >                               goto next;
> >
> > Thanks! This looks better but I still see a 100 or 200 ms delay sometimes.
> > Still debugging it but I _think_ it's a combination of two things:
> >
> >         1. nr_balance_failed doesn't increment as fast - I see a lot of 0s with
> >            occasional 1s and less frequent 2s
> >         2. something might wake up briefly on that cpu in between load balance,
> >            and given how small the littles are they make the required
> >            nr_balance_failed to tip the scale even higher
> >
> >
> > Thanks
> >
> > --
> > Qais Yousef
> >
> > >
> > >                       env->imbalance -= util;
> > > --
> > >
> > >
> > >
> > > >                             env->migration_type = migrate_task;
> > > >                             env->imbalance = 1;
> > > >                     }
> > > > --
> > > > 2.25.1
> > > >
