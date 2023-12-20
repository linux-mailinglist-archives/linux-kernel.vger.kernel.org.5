Return-Path: <linux-kernel+bounces-7337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E564981A5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FC02852DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF3C4778F;
	Wed, 20 Dec 2023 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8ZXi7eI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D947771
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28be15fca9fso287683a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703092172; x=1703696972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HZ7jTw+AAxm5MCrLUPCxZhuBjfnYxDCeJf4ldH7CNa8=;
        b=b8ZXi7eIaARsywlQd2KoTnSkgGgxmrmc8PPcL3pO7cZ4iRKhGaHdngx8LamMkjKcsS
         +8QIuHvO142EYYd6ypnoSMXnZtaSThCgy9uldHPMXUFneaD5w0/zEmMAcub8Et3MjpXa
         vQQLqdUuUCqSUseui2WN7nqfFO1FAz6P40quCBXIO9O4vh3HXZ/94WorWIm0+xPbOPPS
         1/lLuthEC/F/UBkamZiUSntXuPWCv9Z1YVcIRAlgNFTfZBEKGtLubCCcfCnhvCkfmloR
         FfYfy2/AX8W05/8lNJeQt+15EajBCn8r/4/5sBuxtGd1fTQIUgA+BfPE9l9jCGJKPPZi
         cVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092172; x=1703696972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZ7jTw+AAxm5MCrLUPCxZhuBjfnYxDCeJf4ldH7CNa8=;
        b=JH4qvuRqqkSXyqI1R90uwBQ+aHj0V+TjkYYgiJILCqWWXXbdLyZ3+VXaM28UxBBIf4
         GsijZqosKBIb1NyCOySQhzi3tOtyaXECNazLMiadS8NX2k4dgvUGpQDdPYHt6h+miIho
         E/5eHezdXqDR9fSFRry5SRH27aZoUKXXN0NVutj7LsGPhSai6xodag7ITEUVfykOnkVI
         VGdGz9CJzpYazLz0Lb+GIroJzsi93w5P+SjqsAtAMuhcukwqyoEDkblDOb9lTJgw9NXN
         m96zVpIqDFNndRE6w2tevy6leJDw7wICExvvGw3w5MSsYqHHZhR2N+qux8ZBDIDfNirX
         29HQ==
X-Gm-Message-State: AOJu0Yxg+yqG01MwSjH2NMb68WerD4smRYKoWQaEZvzEvkHmI9f4xUW2
	5plGVe3lz/Av8HeU9osx5En3v4ZNDGtDfCjoM5rcGQ==
X-Google-Smtp-Source: AGHT+IFD3kcJbZ1RGpZ/JJ30Y4IhtQNSZ+k3F934RSL0Aai/kJpFvT3eTnKb8f7gDI3uM52Bu+yIjiUH6vUD1VGYHwg=
X-Received: by 2002:a17:90a:e149:b0:286:6cc0:b926 with SMTP id
 ez9-20020a17090ae14900b002866cc0b926mr7825575pjb.93.1703092172021; Wed, 20
 Dec 2023 09:09:32 -0800 (PST)
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
 <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr>
In-Reply-To: <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 20 Dec 2023 18:09:20 +0100
Message-ID: <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com>
Subject: Re: EEVDF and NUMA balancing
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 18:51, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > > One CPU has 2 threads, and the others have one.  The one with two threads
> > > is returned as the busiest one.  But nothing happens, because both of them
> > > prefer the socket that they are on.
> >
> > This explains way load_balance uses migrate_util and not migrate_task.
> > One CPU with 2 threads can be overloaded
> >
> > ok, so it seems that your 1st problem is that you have 2 threads on
> > the same CPU whereas you should have an idle core in this numa node.
> > All cores are sharing the same LLC, aren't they ?
>
> Sorry, not following this.
>
> Socket 1 has N-1 threads, and thus an idle CPU.
> Socket 2 has N+1 threads, and thus one CPU with two threads.
>
> Socket 1 tries to steal from that one CPU with two threads, but that
> fails, because both threads prefer being on Socket 2.
>
> Since most (or all?) of the threads on Socket 2 perfer being on Socket 2.
> the only hope for Socket 1 to fill in its idle core is active balancing.
> But active balancing is not triggered because of migrate_util and because
> CPU_NEWLY_IDLE prevents the failure counter from ebing increased.

 CPU_NEWLY_IDLE load_balance doesn't aims to do active load balance so
you should focus on the CPU_NEWLY_IDLE load_balance

>
> The part that I am currently missing to understand is that when I convert
> CPU_NEWLY_IDLE to CPU_IDLE, it typically picks a CPU with only one thread
> as busiest.  I have the impression that the fbq_type intervenes to cause

find_busiest_queue skips rqs which only have threads preferring being
in there. So it selects another rq with a thread that doesn't prefer
its current node.

do you know what is the value of env->fbq_type ?

need_active_balance() probably needs a new condition for the numa case
where the busiest queue can't be selected and we have to trigger an
active load_balance on a rq with only 1 thread but that is not running
on its preferred node. Something like the untested below :

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5da5eaab6ce..de1474191488 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11150,6 +11150,24 @@ imbalanced_active_balance(struct lb_env *env)
        return 0;
 }

+static inline bool
+numa_active_balance(struct lb_env *env)
+{
+       struct sched_domain *sd = env->sd;
+
+       /*
+        * We tried to migrate only a !numa task or a task on wrong node but
+        * the busiest queue with such task has only 1 running task. Previous
+        * attempt has failed so force the migration of such task.
+        */
+       if ((env->fbq_type < all) &&
+           (env->src_rq->cfs.h_nr_running == 1) &&
+           (sd->nr_balance_failed > 0))
+               return 1;
+
+       return 0;
+}
+
 static int need_active_balance(struct lb_env *env)
 {
        struct sched_domain *sd = env->sd;
@@ -11176,6 +11194,9 @@ static int need_active_balance(struct lb_env *env)
        if (env->migration_type == migrate_misfit)
                return 1;

+       if (numa_active_balance(env))
+               return 1;
+
        return 0;
 }


> it to avoid the CPU with two threads that already prefer Socket 2.  But I
> don't know at the moment why that is the case.  In any case, it's fine to
> active balance from a CPU with only one thread, because Socket 2 will
> even itself out afterwards.
>
> >
> > You should not have more than 1 thread per CPU when there are N+1
> > threads on a node with N cores / 2N CPUs.
>
> Hmm, I think there is a miscommunication about cores and CPUs.  The
> machine has two sockets with 16 physical cores each, and thus 32
> hyperthreads.  There are 64 threads running.

Ok, I have been confused by what you wrote previously:
" The context is that there are 2N threads running on 2N cores, one thread
gets NUMA balanced to the other socket, leaving N+1 threads on one socket
and N-1 threads on the other socket."

I have assumed that there were N cores and 2N CPUs per socket as you
mentioned Intel Xeon 6130 in the commit message . My previous emails
don't apply at all with N CPUs per socket and the group_overloaded is
correct.



>
> julia
>
> > This will enable the
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

