Return-Path: <linux-kernel+bounces-4145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145D81786A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BA81F233F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B0F5A858;
	Mon, 18 Dec 2023 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhHlVnVu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75D4237E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b012f93eeso1323994a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702919929; x=1703524729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S1D4GI6oAvY4mJ1MSnP0envpbKSQ3PQDlsLAaDvR2hg=;
        b=FhHlVnVupZMUvUpuet2mIb+B8Re0YhVTtgaaMthjLTnsNg8gx3VNGg2i3ndifCGY61
         6vD8AAf0RdEm6Y/xttNQKTGJwSzaWVl/PW57DwAPi86Cu9AEkX9PxlOrjDmN22BMMpwl
         2TxQhQeSXhfofxoLs6NybLA6Sc7uAryDFGiraBM8FNihbo6MkjOx/4JIrAJIPwhZppKl
         8BFIu+9yU7Q+hgCmFa0Rxllup8iU4KJq/T14ujue81CWwKGqpyylN3wzeJSYXVwmoJuD
         YEq4IOaDay02daozym2lIVhszh5r1ezDFrcr89RdZl4Ts6SLrgQLshE3rav2v/bZs8Ky
         lDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919929; x=1703524729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1D4GI6oAvY4mJ1MSnP0envpbKSQ3PQDlsLAaDvR2hg=;
        b=O/ffCKehnhMIAp5St2K/3VYFSziu03DJic02/91vV/ZfO+zQPqArLY7F9bq/bc/vNV
         HhJolgz5umN0UJjIvYJKT8OZak4tRhWF6VTbTAZQ4Y1Ztwufw0gS0MVY7kzaB3MPdIOM
         Y2+xRpMAl2IknrWnilHObTzA2REPvRRGhF5MB/sHv7JOMQqXUu+ONuJ3MSZl3VfEdjX3
         R5mHuwbFwOvpWszA+Rowqw21HCgJilZnwLIA4o3umE/bTXVbNDhOD7xMLoED9PWIGMJG
         s4XF3aFfSEGywmh+ZAFmSJNSapee93k56/83bi3WQg4JlCNFm7+KmF4WZGpRDb8eFZWQ
         NuOg==
X-Gm-Message-State: AOJu0Yy8BaSQtd2G9tHYLW2mvH7v+/9HUTOLiV9pYYYyKsXS/ZrHqx2d
	L4FrJCeMGky9tFv8Z2f8KzsPiQjOqg9YnPW2knwFCg==
X-Google-Smtp-Source: AGHT+IGMz1rWRwJf0pDzi2dA+goGdN8F5/rCZKkKTXhMWpGAXljHpZaZoSKKBU2Acba2h7ikm9LeiF8+0AVF1Y0HsOA=
X-Received: by 2002:a17:90a:5285:b0:28a:b5ac:514f with SMTP id
 w5-20020a17090a528500b0028ab5ac514fmr5048759pjh.95.1702919929648; Mon, 18 Dec
 2023 09:18:49 -0800 (PST)
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
In-Reply-To: <b8ab29de-1775-46e-dd75-cdf98be8b0@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 18 Dec 2023 18:18:38 +0100
Message-ID: <CAKfTPtBhWwk9sf9F1=KwubiAWFDC2A9ZT-SSJ+tgFxme1cFmYA@mail.gmail.com>
Subject: Re: EEVDF and NUMA balancing
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 14:58, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> Hello,
>
> I have looked further into the NUMA balancing issue.
>
> The context is that there are 2N threads running on 2N cores, one thread
> gets NUMA balanced to the other socket, leaving N+1 threads on one socket
> and N-1 threads on the other socket.  This condition typically persists
> for one or more seconds.
>
> Previously, I reported this on a 4-socket machine, but it can also occur
> on a 2-socket machine, with other tests from the NAS benchmark suite
> (sp.B, bt.B, etc).
>
> Since there are N+1 threads on one of the sockets, it would seem that load
> balancing would quickly kick in to bring some thread back to socket with
> only N-1 threads.  This doesn't happen, though, because actually most of
> the threads have some NUMA effects such that they have a preferred node.
> So there is a high chance that an attempt to steal will fail, because both
> threads have a preference for the socket.
>
> At this point, the only hope is active balancing.  However, triggering
> active balancing requires the success of the following condition in
> imbalanced_active_balance:
>
>         if ((env->migration_type == migrate_task) &&
>             (sd->nr_balance_failed > sd->cache_nice_tries+2))
>
> sd->nr_balance_failed does not increase because the core is idle.  When a
> core is idle, it comes to the load_balance function from schedule() though
> newidle_balance.  newidle_balance always sends in the flag CPU_NEWLY_IDLE,
> even if the core has been idle for a long time.

Do you mean that you never kick a normal idle load balance ?

>
> Changing newidle_balance to use CPU_IDLE rather than CPU_NEWLY_IDLE when
> the core was already idle before the call to schedule() is not enough
> though, because there is also the constraint on the migration type.  That
> turns out to be (mostly?) migrate_util.  Removing the following
> code from find_busiest_queue:
>
>                         /*
>                          * Don't try to pull utilization from a CPU with one
>                          * running task. Whatever its utilization, we will fail
>                          * detach the task.
>                          */
>                         if (nr_running <= 1)
>                                 continue;

I'm surprised that load_balance wants to "migrate_util"  instead of
"migrate_task"

You have N+1 threads on a group of 2N CPUs so you should have at most
1 thread per CPUs in your busiest group. In theory you should have the
local "group_has_spare" and the busiest "group_fully_busy" (at most).
This means that no group should be overloaded and load_balance should
not try to migrate utli but only task


>
> and changing the above test to:
>
>         if ((env->migration_type == migrate_task || env->migration_type == migrate_util) &&
>             (sd->nr_balance_failed > sd->cache_nice_tries+2))
>
> seems to solve the problem.
>
> I will test this on more applications.  But let me know if the above
> solution seems completely inappropriate.  Maybe it violates some other
> constraints.
>
> I have no idea why this problem became more visible with EEVDF.  It seems
> to have to do with the time slices all turning out to be the same.  I got
> the same behavior in 6.5 by overwriting the timeslice calculation to
> always return 1.  But I don't see the connection between the timeslice and
> the behavior of the idle task.
>
> thanks,
> julia

