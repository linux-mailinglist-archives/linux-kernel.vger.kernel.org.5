Return-Path: <linux-kernel+bounces-7340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A677181A60E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DC5B21147
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92C47791;
	Wed, 20 Dec 2023 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDKOgLpN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2A4777A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28ad7a26f4aso4804837a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703092312; x=1703697112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok01C2qs8tNSlNQvOio7e2Z0/qXWsUL/pboDbcDn6K8=;
        b=zDKOgLpNoldITy38p8+68/yKoOqS7eFCrakbfV4pHG8k5ZqqUzn9zFyqoSWJYSi76I
         pFSyzaV1D/9dZhMETpSiRciaWXdz7S25xx5fkt6duN+JU7Ar7XI2MBemor/QoWxVUdW9
         s0STEt9pAoNbkzZ0UdOKB4nvtu+tTkKEZaMjNkkM9Utg/a3S7hz2fHqUdto42WG6pKh/
         6NIFIOKAtclu8VYK2A3ByLScf9vpkcNmnaIJfyEvBwH2Gp/YpPY48z+nS54vN60S6Ktq
         HgOezoNXv1r2vCvxrxn7N3SZRmqamm0w4E4UHTlljEUEqGdy1BS4s5zPJ7PA5jWvk80P
         2RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092312; x=1703697112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ok01C2qs8tNSlNQvOio7e2Z0/qXWsUL/pboDbcDn6K8=;
        b=GkOyj7W+j7RWZa8A7K/nxCDqGGC0XBTTojrUFZIB4fkUV22TRD5y68b6FHLcczRIvD
         gz90b8fKdvD3qwAHCGQdfDZG4Se3QjQoqNcM/aHIdm+Yx19aUkZucy1BEKurzTozDcA9
         XNrqMszGq3rQrO5+F+zm9Q7JevZv3owm3+Djwor5gAgRKZ2TuNk5CuezAhKEFbXIf+JM
         wxvDfW7eC/GVKiiPH2M6x7uS3qA12IBJxLYrc7ATOW+ipMGPOkjq9T3gKy6wR9rJe43U
         FExquDjuxnkUVm6DwR+Lb3LSp6ci5FYdQhCLdhHACOwbuwJi6Rj2PhEx6Yd8qG1CohKf
         f3SA==
X-Gm-Message-State: AOJu0YwfHNJ7UAnuRflqA7XVhRLQ6OqgMqpMDM7nDQF3+3jnS3Bz1pmu
	7VGZFsjAk/nF7hp8tEIlmahYfPpVaL1XbTO8WDYjBQ==
X-Google-Smtp-Source: AGHT+IELY4JpMjaKC50b89VIj7WAxcTDm3VX4zboU4+v2CKt9UcTWA1tTrK4pE7M8L7iUVY6BeqdnSElU0pdNrpgo8o=
X-Received: by 2002:a17:90b:4a0b:b0:28b:6b90:3d69 with SMTP id
 kk11-20020a17090b4a0b00b0028b6b903d69mr3969221pjb.76.1703092312039; Wed, 20
 Dec 2023 09:11:52 -0800 (PST)
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
 <44df7caf-dbb0-70c3-fbad-7242c0f87b5f@inria.fr>
In-Reply-To: <44df7caf-dbb0-70c3-fbad-7242c0f87b5f@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 20 Dec 2023 18:11:40 +0100
Message-ID: <CAKfTPtDWtmaLjWt6h58qmCBSkAF9JJKxQL=vUff=9pq0pUawrw@mail.gmail.com>
Subject: Re: EEVDF and NUMA balancing
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 17:39, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 19 Dec 2023, Vincent Guittot wrote:
>
> > On Mon, 18 Dec 2023 at 23:31, Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > >
> > >
> > > On Mon, 18 Dec 2023, Vincent Guittot wrote:
> > >
> > > > On Mon, 18 Dec 2023 at 14:58, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > I have looked further into the NUMA balancing issue.
> > > > >
> > > > > The context is that there are 2N threads running on 2N cores, one thread
> > > > > gets NUMA balanced to the other socket, leaving N+1 threads on one socket
> > > > > and N-1 threads on the other socket.  This condition typically persists
> > > > > for one or more seconds.
> > > > >
> > > > > Previously, I reported this on a 4-socket machine, but it can also occur
> > > > > on a 2-socket machine, with other tests from the NAS benchmark suite
> > > > > (sp.B, bt.B, etc).
> > > > >
> > > > > Since there are N+1 threads on one of the sockets, it would seem that load
> > > > > balancing would quickly kick in to bring some thread back to socket with
> > > > > only N-1 threads.  This doesn't happen, though, because actually most of
> > > > > the threads have some NUMA effects such that they have a preferred node.
> > > > > So there is a high chance that an attempt to steal will fail, because both
> > > > > threads have a preference for the socket.
> > > > >
> > > > > At this point, the only hope is active balancing.  However, triggering
> > > > > active balancing requires the success of the following condition in
> > > > > imbalanced_active_balance:
> > > > >
> > > > >         if ((env->migration_type == migrate_task) &&
> > > > >             (sd->nr_balance_failed > sd->cache_nice_tries+2))
> > > > >
> > > > > sd->nr_balance_failed does not increase because the core is idle.  When a
> > > > > core is idle, it comes to the load_balance function from schedule() though
> > > > > newidle_balance.  newidle_balance always sends in the flag CPU_NEWLY_IDLE,
> > > > > even if the core has been idle for a long time.
> > > >
> > > > Do you mean that you never kick a normal idle load balance ?
> > >
> > > OK, it seems that both happen, at different times.  But the calls to
> > > trigger_load_balance seem to rarely do more than the SMT level.
> >
> > yes, the min period is equal to "cpumask_weight of sched_domain" ms, 2
> > ms at SMT level and 2N ms at numa level.
> >
> > >
> > > I have attached part of a trace in which I print various things that
> > > happen during the idle period.
> > >
> > > >
> > > > >
> > > > > Changing newidle_balance to use CPU_IDLE rather than CPU_NEWLY_IDLE when
> > > > > the core was already idle before the call to schedule() is not enough
> > > > > though, because there is also the constraint on the migration type.  That
> > > > > turns out to be (mostly?) migrate_util.  Removing the following
> > > > > code from find_busiest_queue:
> > > > >
> > > > >                         /*
> > > > >                          * Don't try to pull utilization from a CPU with one
> > > > >                          * running task. Whatever its utilization, we will fail
> > > > >                          * detach the task.
> > > > >                          */
> > > > >                         if (nr_running <= 1)
> > > > >                                 continue;
> > > >
> > > > I'm surprised that load_balance wants to "migrate_util"  instead of
> > > > "migrate_task"
> > >
> > > In the attached trace, there are 147 occurrences of migrate_util, and 3
> > > occurrences of migrate_task.  But even when migrate_task appears, the
> > > counter has gotten knocked back down, due to the calls to newidle_balance.
> > >
> > > > You have N+1 threads on a group of 2N CPUs so you should have at most
> > > > 1 thread per CPUs in your busiest group.
> > >
> > > One CPU has 2 threads, and the others have one.  The one with two threads
> > > is returned as the busiest one.  But nothing happens, because both of them
> > > prefer the socket that they are on.
> >
> > This explains way load_balance uses migrate_util and not migrate_task.
> > One CPU with 2 threads can be overloaded
>
> The node with N-1 tasks (and thus an empty core) is categorized as
> group_has_spare and the one with N+1 tasks (and thus one core with 2
> tasks and N-1 cores with 1 task) is categorized as group_overloaded.  This
> seems reasonable, and based on these values the conditions hold for
> migrate_util to be chosen.
>
> I tried just extending the test in imbalanced_active_balance to also
> accept migrate_util, but the sd->nr_balance_failed still goes up too
> slowly due to the many calls from newidle_balance.

As mentioned in my other reply, your problem comes from fbq_type which
prevents you to get the the rq which triggered the group_overloaded
state and the use of migrate_util

>
> julia
>
> >
> > ok, so it seems that your 1st problem is that you have 2 threads on
> > the same CPU whereas you should have an idle core in this numa node.
> > All cores are sharing the same LLC, aren't they ?
> >
> > You should not have more than 1 thread per CPU when there are N+1
> > threads on a node with N cores / 2N CPUs. This will enable the
> > load_balance to try to migrate a task instead of some util(ization)
> > and you should reach the active load balance.
> >
> > >
> > > > In theory you should have the
> > > > local "group_has_spare" and the busiest "group_fully_busy" (at most).
> > > > This means that no group should be overloaded and load_balance should
> > > > not try to migrate utli but only task
> > >
> > > I didn't collect information about the groups.  I will look into that.
> > >
> > > julia
> > >
> > > >
> > > >
> > > > >
> > > > > and changing the above test to:
> > > > >
> > > > >         if ((env->migration_type == migrate_task || env->migration_type == migrate_util) &&
> > > > >             (sd->nr_balance_failed > sd->cache_nice_tries+2))
> > > > >
> > > > > seems to solve the problem.
> > > > >
> > > > > I will test this on more applications.  But let me know if the above
> > > > > solution seems completely inappropriate.  Maybe it violates some other
> > > > > constraints.
> > > > >
> > > > > I have no idea why this problem became more visible with EEVDF.  It seems
> > > > > to have to do with the time slices all turning out to be the same.  I got
> > > > > the same behavior in 6.5 by overwriting the timeslice calculation to
> > > > > always return 1.  But I don't see the connection between the timeslice and
> > > > > the behavior of the idle task.
> > > > >
> > > > > thanks,
> > > > > julia
> > > >
> >

