Return-Path: <linux-kernel+bounces-136284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB8B89D23A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F191F2299C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7206FE06;
	Tue,  9 Apr 2024 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="C4urIcu2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F52524AF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643554; cv=none; b=JDfvxTtnu6ah/jLsQBCAZ30Hp9EKsCGWi4DOT/jdN7zXoi6bSS7CemY8wpZgFNxXspt4UiScbLaypIhwQjOEuAo3JxJFyXGfzkCUb6b+Ytw05W20C95J+JHOI5RDl2nSiXFJGfzLoli1TuH/gp6E11klvxy+NmeMDQhsBbENZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643554; c=relaxed/simple;
	bh=zFhwm1ItKILaHreSDT7Vvr+9GifZdA1mRiCL8eGn7E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcwFYYvE9WK2tyUIZg1Myf1dJdLtOO3bmoeUuh21XlZrwBW6917oQ7DXyF1xtFNdwzxN99jUxNqjZfiks3wLpuWi5RbbGuZogVBKKDgp2VJFidUoRz6R3KKd8E4tRvTIfHiK74wwPqgj/Eaw8zNiL79eZnZtwAPVL5pdoXVvEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=C4urIcu2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso3683821b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1712643552; x=1713248352; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QdzZ0R+UmqwjTSQK9W90Q8xqm2fMZ1gt15Od4SXKF+M=;
        b=C4urIcu20YCHVNpf7wLjZdZSBuMm+3i1TkYdjzzMoB0f/uGQeQrFUAdERBbVRaNhNM
         lbRAohmzdX3wvWF1e6rVjo9UaD++CFlSwvvLHzsGJqhwt5YebTz2kYIVGU6fzR7apW7c
         T2muz/LPbbW7YHE3A4vndik810o1DGV5Ym1uvOG+FAdnzKcJD77dktuamLD0h+JiRchx
         vU03yu2m8nuE5fTudhN4xsxKvSWLLleODM6oiVcB0K2HKaHCGR8FYpZm0FLgIxPgS5Z6
         /KeIT0DjUiHnMrbSqOPg2WpTRTP7+uw8bkukpkHu9YWg6o6euIp8aV8/rcCSDvWpsc5W
         Apqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643552; x=1713248352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdzZ0R+UmqwjTSQK9W90Q8xqm2fMZ1gt15Od4SXKF+M=;
        b=uJyGHKGUceVUZpn21mhuaQ4tMq5iru+fz0Tb8YLhJG4PeC7SWuXVOOaAS+TZgyQhbV
         TstsYB79mOvc3Yc1ehbm8SBhRZ3h+NeoFUDFcXQRLjKazDkVaF2q1xrv+7289ySMUGfU
         qqsZvNvnYJkJQzVt+M6SVFiFS2sq/QuK6jm1QvxKi1QZwi4TBsWrfK5hd/chwF5HYggc
         Vy7FQz5G4NbCXDrzrEdREATef3jNuMydFU3BklAlkX6SBdrJ1iY8bR7zCd7q3LySGCXm
         xackOMSrPuHd4ijr59C/t1DipKqHRoVFMCiTdJc49uwwayAY5CHX5s5vHEhQCjyJFuf8
         v0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1/wjzzxCcrUa0uN4Sp5oqqwd/I/bZijGZTbtc5f/g96kPgb1apltUk6r/fSsZbIZDUCoxEQCD4yGK4u4SyuHctPwGIlZBqM+dSAU
X-Gm-Message-State: AOJu0YzAVs03HIHj6TYZIKfG6FRuof+3NQBE21tcka7NqUrIxyiR2cQY
	Pm1W1zLzIP9zvj4RSeFpsjeficXvHTGzG84gg5OeGOShPec0b/HqriWUC5sYeMQ=
X-Google-Smtp-Source: AGHT+IEzMCjBmsGS4sJHCrdffXtdbWnV4LV6gdj017ZQLmtxA1JEvtOWV+XAhymj3BTYwXE2f+J8EA==
X-Received: by 2002:a05:6a00:3927:b0:6ed:21cb:13f3 with SMTP id fh39-20020a056a00392700b006ed21cb13f3mr6860643pfb.17.1712643552035;
        Mon, 08 Apr 2024 23:19:12 -0700 (PDT)
Received: from airbuntu ([64.125.41.58])
        by smtp.gmail.com with ESMTPSA id g14-20020aa7874e000000b006e69a142458sm7557082pfo.213.2024.04.08.23.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:19:11 -0700 (PDT)
Date: Tue, 9 Apr 2024 07:19:09 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting
 prio
Message-ID: <20240409061909.tb3vxc27h2eawiwg@airbuntu>
References: <20240403005930.1587032-1-qyousef@layalina.io>
 <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240404220500.dmfl2krll37znbi5@airbuntu>
 <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
 <20240405171653.boxbylrdak5fopjv@airbuntu>
 <20240407122700.ns7gknqwqkpjjyd4@airbuntu>
 <CAKfTPtBZao-Ry=sdAV=rtTwbxbEJmwb-_gNceSjV6u-6EXTY-w@mail.gmail.com>
 <CANDhNCq5HZvecSe9_9f7j5koY2VNdyjM_b3csL6=U1A_8J2ksw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCq5HZvecSe9_9f7j5koY2VNdyjM_b3csL6=U1A_8J2ksw@mail.gmail.com>

On 04/08/24 12:51, John Stultz wrote:
> On Mon, Apr 8, 2024 at 12:17 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Sun, 7 Apr 2024 at 14:27, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 04/05/24 18:16, Qais Yousef wrote:
> > >
> > > > >
> > > > > All that to say that I think the weight is not applied on purpose.
> > > > > This might work for your particular case but there are more changes to
> > > > > be done if you want to apply prio inheritance between cfs tasks.
> > > > >
> > > > > As an example, what about the impact of cgroup on the actual weight
> > > > > and the inherited priority of a task ? If the owner and the waiter
> > > > > don't belong to the same cgroup their own prio is meaningless... task
> > > > > nice -20 in a group with a weight equal to nice 19 vs a task nice 19
> > > > > in a group with a weight equals to nice -20
> > > >
> > > > That is on my mind actually. But I thought it's a separate problem. That has to
> > > > do with how we calculate the effective priority of the pi_task. And probably
> > > > the sorting order to if we agree we need to revert the above. If that is done
> > >
> > > Thinking more about it the revert is not the right thing to do. We want fair
> > > tasks to stay ordered in FIFO for better fairness and avoid potential
> > > starvation issues. It's just the logic for searching the top_waiter need to be
> > > different. If the top_waiter is fair, then we need to traverse the tree to find
> > > the highest nice value. We probably can keep track of this while adding items
> > > to the tree to avoid the search.
> > >
> > > For cgroup; is it reasonable (loosely speaking) to keep track of pi_cfs_rq and
> > > detach_attach_task_cfs_rq() before the reweight? This seems the most
> > > straightforward solution and will contain the complexity to keeping track of
> > > cfs_rq. But it'll have similar issue to proxy execution where a task that
> > > doesn't belong to the cgroup will consume its share..
> >
> > That's a good point, Would proxy execution be the simplest way to fix all this ?

Is it? Over 4.5 years ago Unity reported to me about performance inversion
problem and that's when proxy execution work was revived as simplest way to fix
all of this. But still no end in sight from what I see. I was and still think
an interim solution in rt_mutex could help a lot of use cases already without
being too complex. Not as elegant and comprehensive like proxy execution, but
given the impact on both userspace and out of tree kernel hacks are growing
waiting for this to be ready, the cost of waiting is high IMHO.

FWIW, I already heard several feedbacks that PTHREAD_PRIO_INHERIT does nothing.
I think this reweight issue is more serious problem and likely why I heard this
feedback. I could be underestimating the complexity of the fix though. So I'll
trust your judgement and ditch further effort if you think it's more effort
than helping proxy execution patchset - for the list at least. I'm likely still
to pursue something out of tree to get into as many android LTS kernels. And
will be happy to share this work if there's desire to try to pick something up
for mainline to make the problem less severe at least.

Note that binder has already performance, latency (out of tree) and priority
inheritance and without those performance is impacted in many corner cases and
considered indispensable part.

> 
> So, at the moment, in part. It ought to resolve the issue for
> in-kernel mutexes (blocked tasks stay on rq, if blocked tasks are
> selected to run we will instead run the runnable lock owner - thus it
> works across scheduling classes), but it isn't tied into userland
> futexes the way rt_mutexes are at this point.
> 
> Review and feedback on the series would be greatly appreciated!
> (Nudge! Nudge! :)

I am guilty of this, sorry.

