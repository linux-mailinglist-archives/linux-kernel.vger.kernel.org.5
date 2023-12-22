Return-Path: <linux-kernel+bounces-9797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31DF81CB90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38355B21530
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD22374C;
	Fri, 22 Dec 2023 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwKeaph9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C523745
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d775f9af42so1745125b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703256952; x=1703861752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zmy0sMSzcEjtEYNoHQc/fDtbTqenJq7yZuTeDwM0hno=;
        b=KwKeaph96+2WL02zmx9oieYUgTI8pAjkcTgj6JW2MpIVzz42R7Ce//liINk9mCDmi3
         9UJsrbZxh15lAlQucSAt/ECWrqzpj/eKR1dqXhCIHmu/8LEPGi3DQiuvPZkfZ1D8OhTH
         S5KxAhmHhrbZYNlAQDV46+80dmSLT1c6O6mr7vj8SkZYm2WzQ7FrOOM7Ur1INv1YI2TS
         bBxfDB/mzyPqsGgIbI4Bqvp1UOHI8JKwX8zq6sQDl2TPkjST8d7T3mYkwz7xhH0wrwPl
         neOM6e2wByZwmCGIoUUfVq5CkbuskyD5N/j2sm0hlGH1M2jkTo5DFWoLoyzJGn8vOjsF
         UNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703256952; x=1703861752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmy0sMSzcEjtEYNoHQc/fDtbTqenJq7yZuTeDwM0hno=;
        b=Moj0LQLnj3sKeBgZZabzOn8y3hQzrQtt2N0n18jdGoPSRWWDEy9k1q4pww5CwORC2q
         FBRc27n+upGoADL/Rz3DVludbJEW2n6+PV7b3/m2M6zjz0gwzebBgIZ+8h2W77kNGqWW
         ePmQ0RxZ0uIy0RHcH2gfEEIQG7SMXLYOaNH0enTh1/y8AtOgMra35DSsmwFdulSvZqxK
         HIYaJkmtYin0v1AoB/NgjlbYArQyEBSerleaYS6+xueJuGTEPGZqh7rl1SFJnqUT3UwA
         TX2VgQhs7NDqCWa/dYdmvkbgaWs5TfZRn5NPystRtmcV6hcQbSQmyIMkJUpRKEuY4ENr
         uq/g==
X-Gm-Message-State: AOJu0Ywcebrierl62vZYrXkbr/urnzUFLtXk72bSjaxXzGsh98br7P0Z
	maAI2OdHFdBf49EX7sPFGSNYErRxcYeyI6jzK/NHixJF8NsJcA==
X-Google-Smtp-Source: AGHT+IGg2OTZhpNO4nB5iTLY92GaSwGHDpdcYUexBc4b/8NUxKTSXXt/5VbU2jX/kvjNqTN1OBJYnE4z1hc+Y3yQ+2E=
X-Received: by 2002:a05:6a20:96d7:b0:195:c5c:d836 with SMTP id
 hq23-20020a056a2096d700b001950c5cd836mr1278557pzc.119.1703256952086; Fri, 22
 Dec 2023 06:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <20231003215159.GJ1539@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041358420.3108@hadrien>
 <20231004120544.GA6307@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
 <20231004174801.GE19999@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041958380.3108@hadrien>
 <20231009102949.GC14330@noisy.programming.kicks-ass.net> <b8ab29de-1775-46e-dd75-cdf98be8b0@inria.fr>
 <CAKfTPtBhWwk9sf9F1=KwubiAWFDC2A9ZT-SSJ+tgFxme1cFmYA@mail.gmail.com>
 <alpine.DEB.2.22.394.2312182302310.3361@hadrien> <CAKfTPtALEFtrapi3Kk97KLGQN4259eEQEwwftVUK4RG42Vgoyw@mail.gmail.com>
 <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr> <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com>
 <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr>
In-Reply-To: <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 22 Dec 2023 15:55:40 +0100
Message-ID: <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com>
Subject: Re: EEVDF and NUMA balancing
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 19:20, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Wed, 20 Dec 2023, Vincent Guittot wrote:
>
> > On Tue, 19 Dec 2023 at 18:51, Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > > > > One CPU has 2 threads, and the others have one.  The one with two threads
> > > > > is returned as the busiest one.  But nothing happens, because both of them
> > > > > prefer the socket that they are on.
> > > >
> > > > This explains way load_balance uses migrate_util and not migrate_task.
> > > > One CPU with 2 threads can be overloaded
> > > >
> > > > ok, so it seems that your 1st problem is that you have 2 threads on
> > > > the same CPU whereas you should have an idle core in this numa node.
> > > > All cores are sharing the same LLC, aren't they ?
> > >
> > > Sorry, not following this.
> > >
> > > Socket 1 has N-1 threads, and thus an idle CPU.
> > > Socket 2 has N+1 threads, and thus one CPU with two threads.
> > >
> > > Socket 1 tries to steal from that one CPU with two threads, but that
> > > fails, because both threads prefer being on Socket 2.
> > >
> > > Since most (or all?) of the threads on Socket 2 perfer being on Socket 2.
> > > the only hope for Socket 1 to fill in its idle core is active balancing.
> > > But active balancing is not triggered because of migrate_util and because
> > > CPU_NEWLY_IDLE prevents the failure counter from ebing increased.
> >
> >  CPU_NEWLY_IDLE load_balance doesn't aims to do active load balance so
> > you should focus on the CPU_NEWLY_IDLE load_balance
>
> I'm still perplexed why a core that has been idle for 1 second or more is
> considered to be newly idle.

CPU_NEWLY_IDLE load balance is called when the scheduler was
scheduling something that just migrated or went back to sleep and
doesn't have anything to schedule so it tries to  pull a task from
somewhere else.

But you should still have some CPU_IDLE load balance according to your
description where one CPU of the socket remains idle and those will
increase the nr_balance_failed

I'm surprised that you have mainly CPU_NEWLY_IDLE. Do you know the reason ?

>
> >
> > >
> > > The part that I am currently missing to understand is that when I convert
> > > CPU_NEWLY_IDLE to CPU_IDLE, it typically picks a CPU with only one thread
> > > as busiest.  I have the impression that the fbq_type intervenes to cause
> >
> > find_busiest_queue skips rqs which only have threads preferring being
> > in there. So it selects another rq with a thread that doesn't prefer
> > its current node.
> >
> > do you know what is the value of env->fbq_type ?
>
> I have seen one trace in which it is all.  There are 33 tasks on one
> socket, and they are all considered to have a preference for that socket.

With env->fbq_type == all, load_balance and find_busiest_queue should
be able to select the actual busiest queue with 2 threads.

But then I imagine that can_migrate/ migrate_degrades_locality
prevents to detach the task

>
> But I have another trace in which it is regular.  There are 33 tasks on
> the socket, but only 32 have a preference.
>
> >
> > need_active_balance() probably needs a new condition for the numa case
> > where the busiest queue can't be selected and we have to trigger an
> > active load_balance on a rq with only 1 thread but that is not running
> > on its preferred node. Something like the untested below :
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e5da5eaab6ce..de1474191488 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11150,6 +11150,24 @@ imbalanced_active_balance(struct lb_env *env)
> >         return 0;
> >  }
> >
> > +static inline bool
> > +numa_active_balance(struct lb_env *env)
> > +{
> > +       struct sched_domain *sd = env->sd;
> > +
> > +       /*
> > +        * We tried to migrate only a !numa task or a task on wrong node but
> > +        * the busiest queue with such task has only 1 running task. Previous
> > +        * attempt has failed so force the migration of such task.
> > +        */
> > +       if ((env->fbq_type < all) &&
> > +           (env->src_rq->cfs.h_nr_running == 1) &&
> > +           (sd->nr_balance_failed > 0))
>
> The last condition will still be a problem because of CPU_NEWLY_IDLE.  The
> nr_balance_failed counter doesn't get incremented very often.

It waits for at least 1 failed CPU_IDLE load_balance

>
> julia
>
> > +               return 1;
> > +
> > +       return 0;
> > +}
> > +
> >  static int need_active_balance(struct lb_env *env)
> >  {
> >         struct sched_domain *sd = env->sd;
> > @@ -11176,6 +11194,9 @@ static int need_active_balance(struct lb_env *env)
> >         if (env->migration_type == migrate_misfit)
> >                 return 1;
> >
> > +       if (numa_active_balance(env))
> > +               return 1;
> > +
> >         return 0;
> >  }
> >
> >
> > > it to avoid the CPU with two threads that already prefer Socket 2.  But I
> > > don't know at the moment why that is the case.  In any case, it's fine to
> > > active balance from a CPU with only one thread, because Socket 2 will
> > > even itself out afterwards.
> > >
> > > >
> > > > You should not have more than 1 thread per CPU when there are N+1
> > > > threads on a node with N cores / 2N CPUs.
> > >
> > > Hmm, I think there is a miscommunication about cores and CPUs.  The
> > > machine has two sockets with 16 physical cores each, and thus 32
> > > hyperthreads.  There are 64 threads running.
> >
> > Ok, I have been confused by what you wrote previously:
> > " The context is that there are 2N threads running on 2N cores, one thread
> > gets NUMA balanced to the other socket, leaving N+1 threads on one socket
> > and N-1 threads on the other socket."
> >
> > I have assumed that there were N cores and 2N CPUs per socket as you
> > mentioned Intel Xeon 6130 in the commit message . My previous emails
> > don't apply at all with N CPUs per socket and the group_overloaded is
> > correct.
> >
> >
> >
> > >
> > > julia
> > >
> > > > This will enable the
> > > > load_balance to try to migrate a task instead of some util(ization)
> > > > and you should reach the active load balance.
> > > >
> > > > >
> > > > > > In theory you should have the
> > > > > > local "group_has_spare" and the busiest "group_fully_busy" (at most).
> > > > > > This means that no group should be overloaded and load_balance should
> > > > > > not try to migrate utli but only task
> > > > >
> > > > > I didn't collect information about the groups.  I will look into that.
> > > > >
> > > > > julia
> > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > and changing the above test to:
> > > > > > >
> > > > > > >         if ((env->migration_type == migrate_task || env->migration_type == migrate_util) &&
> > > > > > >             (sd->nr_balance_failed > sd->cache_nice_tries+2))
> > > > > > >
> > > > > > > seems to solve the problem.
> > > > > > >
> > > > > > > I will test this on more applications.  But let me know if the above
> > > > > > > solution seems completely inappropriate.  Maybe it violates some other
> > > > > > > constraints.
> > > > > > >
> > > > > > > I have no idea why this problem became more visible with EEVDF.  It seems
> > > > > > > to have to do with the time slices all turning out to be the same.  I got
> > > > > > > the same behavior in 6.5 by overwriting the timeslice calculation to
> > > > > > > always return 1.  But I don't see the connection between the timeslice and
> > > > > > > the behavior of the idle task.
> > > > > > >
> > > > > > > thanks,
> > > > > > > julia
> > > > > >
> > > >
> >

