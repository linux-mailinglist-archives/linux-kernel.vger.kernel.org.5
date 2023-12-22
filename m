Return-Path: <linux-kernel+bounces-9917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C3881CD39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8B2B21646
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675528DAE;
	Fri, 22 Dec 2023 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMc9EB4Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4228DA5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ca5b61f101so957734a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703263337; x=1703868137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lFO53RPbjcKJBETc7ymiWXYbqQu4dNFjS0HcEyhGgXQ=;
        b=UMc9EB4ZhBjAqhZhwxMQj8fbEJlk1ieuiG+la6CEG5QFhlZGr7LYyB9kRfRgBbMfGh
         CaxhVPfDXBnAX3z4gtF2VCd5eyX6ZOa/WC0G3YXzY6kbBZrVot+UAhb7QS0o/+KsN2wL
         IZbSeJOG8F64TLsCjBFy7u9N3LHhsG+4bXg1818x1ct0mS3jPrS0mia17JZPbrtDdzLB
         A0XlTioUpsYkL7zjO1caqmDMywyf8NvE8HdLKvbWF3SdeKmmuE3rzgqqpC1E8xY9cV4n
         nqv8EzcZ6CX0ZvcX6xTZ2xYOgk8kvWTfUMAhcxYjUdeJ/GvAROXW/l5weLMkWJLV1glZ
         zTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703263337; x=1703868137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFO53RPbjcKJBETc7ymiWXYbqQu4dNFjS0HcEyhGgXQ=;
        b=kELKSrOPvw2E3CGKmKtgrfBljYGUraSpEremPIMWX2qzgwn0vZrRUiI8KFB9xjRS6L
         V7mLoExoVgleLjrx60xb2wiFthflAi3GUzpRIB5MqICMOoPPLLxTcU24cRfXlsZ0ktal
         Mmdh59Ik3r2lvb3RdRMyYEjOyBcK+8jeLU7HLcbYRbm57eVXyXwTFZ/islYheTULRToD
         Aab5DxQABXc2D6iI7CTENEGk5teFqK6uAQA/ujGgCNewmgD4j2FS3+LUojUZsb+VPFob
         zhzU3fLHX4F9EIf86WBmi1+k2M35kR06x6lVny4mf5944032+BzFbjLpLCTtQ5CBuaLh
         Cfxg==
X-Gm-Message-State: AOJu0YwItd+R31nt00WS3H/I3VqXERS2kbSVrmDomF29FrAt60PIs6b8
	Erwo2rDzEQsAPzTwXmudTlf1NRPAD5Hz0Now9wGFPq/NY/an+A==
X-Google-Smtp-Source: AGHT+IGhazhADiVk+HWz7NSwts6AmJEn78QzU7OA/a64PWEifL4AUQ6m5nGjlL6i28PZCUfaRw9qIuzI3GymOD5K0kw=
X-Received: by 2002:a17:90a:fe90:b0:286:997b:d6b5 with SMTP id
 co16-20020a17090afe9000b00286997bd6b5mr995967pjb.74.1703263337515; Fri, 22
 Dec 2023 08:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <20231004120544.GA6307@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
 <20231004174801.GE19999@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041958380.3108@hadrien>
 <20231009102949.GC14330@noisy.programming.kicks-ass.net> <b8ab29de-1775-46e-dd75-cdf98be8b0@inria.fr>
 <CAKfTPtBhWwk9sf9F1=KwubiAWFDC2A9ZT-SSJ+tgFxme1cFmYA@mail.gmail.com>
 <alpine.DEB.2.22.394.2312182302310.3361@hadrien> <CAKfTPtALEFtrapi3Kk97KLGQN4259eEQEwwftVUK4RG42Vgoyw@mail.gmail.com>
 <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr> <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com>
 <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr> <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com>
 <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr> <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com>
 <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr>
In-Reply-To: <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 22 Dec 2023 17:42:05 +0100
Message-ID: <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com>
Subject: Re: EEVDF and NUMA balancing
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Dec 2023 at 17:29, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Fri, 22 Dec 2023, Julia Lawall wrote:
>
> >
> >
> > On Fri, 22 Dec 2023, Vincent Guittot wrote:
> >
> > > On Fri, 22 Dec 2023 at 16:00, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > >
> > > >
> > > > On Fri, 22 Dec 2023, Vincent Guittot wrote:
> > > >
> > > > > On Thu, 21 Dec 2023 at 19:20, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On Wed, 20 Dec 2023, Vincent Guittot wrote:
> > > > > >
> > > > > > > On Tue, 19 Dec 2023 at 18:51, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > > > > >
> > > > > > > > > > One CPU has 2 threads, and the others have one.  The one with two threads
> > > > > > > > > > is returned as the busiest one.  But nothing happens, because both of them
> > > > > > > > > > prefer the socket that they are on.
> > > > > > > > >
> > > > > > > > > This explains way load_balance uses migrate_util and not migrate_task.
> > > > > > > > > One CPU with 2 threads can be overloaded
> > > > > > > > >
> > > > > > > > > ok, so it seems that your 1st problem is that you have 2 threads on
> > > > > > > > > the same CPU whereas you should have an idle core in this numa node.
> > > > > > > > > All cores are sharing the same LLC, aren't they ?
> > > > > > > >
> > > > > > > > Sorry, not following this.
> > > > > > > >
> > > > > > > > Socket 1 has N-1 threads, and thus an idle CPU.
> > > > > > > > Socket 2 has N+1 threads, and thus one CPU with two threads.
> > > > > > > >
> > > > > > > > Socket 1 tries to steal from that one CPU with two threads, but that
> > > > > > > > fails, because both threads prefer being on Socket 2.
> > > > > > > >
> > > > > > > > Since most (or all?) of the threads on Socket 2 perfer being on Socket 2.
> > > > > > > > the only hope for Socket 1 to fill in its idle core is active balancing.
> > > > > > > > But active balancing is not triggered because of migrate_util and because
> > > > > > > > CPU_NEWLY_IDLE prevents the failure counter from ebing increased.
> > > > > > >
> > > > > > >  CPU_NEWLY_IDLE load_balance doesn't aims to do active load balance so
> > > > > > > you should focus on the CPU_NEWLY_IDLE load_balance
> > > > > >
> > > > > > I'm still perplexed why a core that has been idle for 1 second or more is
> > > > > > considered to be newly idle.
> > > > >
> > > > > CPU_NEWLY_IDLE load balance is called when the scheduler was
> > > > > scheduling something that just migrated or went back to sleep and
> > > > > doesn't have anything to schedule so it tries to  pull a task from
> > > > > somewhere else.
> > > > >
> > > > > But you should still have some CPU_IDLE load balance according to your
> > > > > description where one CPU of the socket remains idle and those will
> > > > > increase the nr_balance_failed
> > > >
> > > > This happens.  But not often.
> > > >
> > > > > I'm surprised that you have mainly CPU_NEWLY_IDLE. Do you know the reason ?
> > > >
> > > > No.  They come from do_idle calling the scheduler.  I will look into why
> > > > this happens so often.
> > >
> > > Hmm, the CPU was idle and received a need resched which triggered the
> > > scheduler but there was nothing to schedule so it goes back to idle
> > > after running a newly_idle _load_balance.
> >
> > I spent quite some time thinking the same until I saw the following code
> > in do_idle:
> >
> > preempt_set_need_resched();
> >
> > So I have the impression that do_idle sets need resched itself.
>
> But of course that code is only executed if need_resched is true.  But I

Yes, that is your root cause. something, most probably in interrupt
context, wakes up your CPU and expect to wake up a thread

> don't know who would be setting need resched on each clock tick.

that can be a timer, interrupt, ipi, rcu ...
a trace should give you some hints

>
> julia
>
> >
> > julia
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > The part that I am currently missing to understand is that when I convert
> > > > > > > > CPU_NEWLY_IDLE to CPU_IDLE, it typically picks a CPU with only one thread
> > > > > > > > as busiest.  I have the impression that the fbq_type intervenes to cause
> > > > > > >
> > > > > > > find_busiest_queue skips rqs which only have threads preferring being
> > > > > > > in there. So it selects another rq with a thread that doesn't prefer
> > > > > > > its current node.
> > > > > > >
> > > > > > > do you know what is the value of env->fbq_type ?
> > > > > >
> > > > > > I have seen one trace in which it is all.  There are 33 tasks on one
> > > > > > socket, and they are all considered to have a preference for that socket.
> > > > >
> > > > > With env->fbq_type == all, load_balance and find_busiest_queue should
> > > > > be able to select the actual busiest queue with 2 threads.
> > > >
> > > > That's what it does.  But nothing can be stolen because there is no active
> > > > balancing.
> > >
> > > My patch below should enable to pull a task from the 1st idle load
> > > balance that fails
> > >
> > > >
> > > > >
> > > > > But then I imagine that can_migrate/ migrate_degrades_locality
> > > > > prevents to detach the task
> > > >
> > > > Exactly.
> > > >
> > > > julia
> > > >
> > > > > >
> > > > > > But I have another trace in which it is regular.  There are 33 tasks on
> > > > > > the socket, but only 32 have a preference.
> > > > > >
> > > > > > >
> > > > > > > need_active_balance() probably needs a new condition for the numa case
> > > > > > > where the busiest queue can't be selected and we have to trigger an
> > > > > > > active load_balance on a rq with only 1 thread but that is not running
> > > > > > > on its preferred node. Something like the untested below :
> > > > > > >
> > > > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > > > index e5da5eaab6ce..de1474191488 100644
> > > > > > > --- a/kernel/sched/fair.c
> > > > > > > +++ b/kernel/sched/fair.c
> > > > > > > @@ -11150,6 +11150,24 @@ imbalanced_active_balance(struct lb_env *env)
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +static inline bool
> > > > > > > +numa_active_balance(struct lb_env *env)
> > > > > > > +{
> > > > > > > +       struct sched_domain *sd = env->sd;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * We tried to migrate only a !numa task or a task on wrong node but
> > > > > > > +        * the busiest queue with such task has only 1 running task. Previous
> > > > > > > +        * attempt has failed so force the migration of such task.
> > > > > > > +        */
> > > > > > > +       if ((env->fbq_type < all) &&
> > > > > > > +           (env->src_rq->cfs.h_nr_running == 1) &&
> > > > > > > +           (sd->nr_balance_failed > 0))
> > > > > >
> > > > > > The last condition will still be a problem because of CPU_NEWLY_IDLE.  The
> > > > > > nr_balance_failed counter doesn't get incremented very often.
> > > > >
> > > > > It waits for at least 1 failed CPU_IDLE load_balance
> > > > >
> > > > > >
> > > > > > julia
> > > > > >
> > > > > > > +               return 1;
> > > > > > > +
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int need_active_balance(struct lb_env *env)
> > > > > > >  {
> > > > > > >         struct sched_domain *sd = env->sd;
> > > > > > > @@ -11176,6 +11194,9 @@ static int need_active_balance(struct lb_env *env)
> > > > > > >         if (env->migration_type == migrate_misfit)
> > > > > > >                 return 1;
> > > > > > >
> > > > > > > +       if (numa_active_balance(env))
> > > > > > > +               return 1;
> > > > > > > +
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > >
> > > > > > > > it to avoid the CPU with two threads that already prefer Socket 2.  But I
> > > > > > > > don't know at the moment why that is the case.  In any case, it's fine to
> > > > > > > > active balance from a CPU with only one thread, because Socket 2 will
> > > > > > > > even itself out afterwards.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > You should not have more than 1 thread per CPU when there are N+1
> > > > > > > > > threads on a node with N cores / 2N CPUs.
> > > > > > > >
> > > > > > > > Hmm, I think there is a miscommunication about cores and CPUs.  The
> > > > > > > > machine has two sockets with 16 physical cores each, and thus 32
> > > > > > > > hyperthreads.  There are 64 threads running.
> > > > > > >
> > > > > > > Ok, I have been confused by what you wrote previously:
> > > > > > > " The context is that there are 2N threads running on 2N cores, one thread
> > > > > > > gets NUMA balanced to the other socket, leaving N+1 threads on one socket
> > > > > > > and N-1 threads on the other socket."
> > > > > > >
> > > > > > > I have assumed that there were N cores and 2N CPUs per socket as you
> > > > > > > mentioned Intel Xeon 6130 in the commit message . My previous emails
> > > > > > > don't apply at all with N CPUs per socket and the group_overloaded is
> > > > > > > correct.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > julia
> > > > > > > >
> > > > > > > > > This will enable the
> > > > > > > > > load_balance to try to migrate a task instead of some util(ization)
> > > > > > > > > and you should reach the active load balance.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > In theory you should have the
> > > > > > > > > > > local "group_has_spare" and the busiest "group_fully_busy" (at most).
> > > > > > > > > > > This means that no group should be overloaded and load_balance should
> > > > > > > > > > > not try to migrate utli but only task
> > > > > > > > > >
> > > > > > > > > > I didn't collect information about the groups.  I will look into that.
> > > > > > > > > >
> > > > > > > > > > julia
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > and changing the above test to:
> > > > > > > > > > > >
> > > > > > > > > > > >         if ((env->migration_type == migrate_task || env->migration_type == migrate_util) &&
> > > > > > > > > > > >             (sd->nr_balance_failed > sd->cache_nice_tries+2))
> > > > > > > > > > > >
> > > > > > > > > > > > seems to solve the problem.
> > > > > > > > > > > >
> > > > > > > > > > > > I will test this on more applications.  But let me know if the above
> > > > > > > > > > > > solution seems completely inappropriate.  Maybe it violates some other
> > > > > > > > > > > > constraints.
> > > > > > > > > > > >
> > > > > > > > > > > > I have no idea why this problem became more visible with EEVDF.  It seems
> > > > > > > > > > > > to have to do with the time slices all turning out to be the same.  I got
> > > > > > > > > > > > the same behavior in 6.5 by overwriting the timeslice calculation to
> > > > > > > > > > > > always return 1.  But I don't see the connection between the timeslice and
> > > > > > > > > > > > the behavior of the idle task.
> > > > > > > > > > > >
> > > > > > > > > > > > thanks,
> > > > > > > > > > > > julia
> > > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > >
> > >
> >

