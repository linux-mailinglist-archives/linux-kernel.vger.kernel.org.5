Return-Path: <linux-kernel+bounces-73127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D0C85BDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DB21C217A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899A36A8C1;
	Tue, 20 Feb 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Z4PjYgrT"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AA6A325
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437470; cv=none; b=Czmwe4YUQon0pBUhHPm62cWyXFZsEEv0qxrvDW2DJJdXGhvPvrPdkztBnujRPj5EexM9cCScyddGYRyJNsY+ClXXIpmKYKzXbbTeLBpYpz1UGlkWSddIEDXJRpm9+GBfrJcrXEpo0YiT8L6Nog+fZjvJnqzJl/TDNHlvFE/W0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437470; c=relaxed/simple;
	bh=eKFE7ixr+z9DCFBk5T0AINAAtRILUz3VbnLZA8f10bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtabWAHZiII/FnaKpq5NUJ/7u/SCSB/jtNuxZUc6e82QPQE2XO3L2pz+HrxufeQNYADjQgntVtGmHsfNgzZt5GZm394ywgyXW3nFM05naCdCCNTzvR0SzfgfdZAgq0mfMj6r3KWnHQEqkA0WKljilETVhIsadgddvwosShwwTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Z4PjYgrT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d70df523dso239787f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708437467; x=1709042267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AI5Avz0WDOYWyiRhPfNRydtZ2zETZ/BjR+NeiTklUgk=;
        b=Z4PjYgrTObZKGaP/9+0LPZhBwYkewccMEtkcjkSfHOGvVq9KimuM9T7orMvixulWXi
         NDnVZeootN34yOGCgnGVKTmo1S7uvLMTSvvrTj/VEHbNjtrjrL//smoRyjP2VEw6989L
         NhdmAhYJiN0e4ZpsvVGXCn08MDHFVyVPNo6F9w8urb+ctNtoyu6fPQlCEuCVfSmAP1RI
         zwNxe9jWbvUQ8wODItDy2bGwYkOWai3b2i2r8/03XlLyN6JpFBlnQlMKk1nZA9EutHPM
         1IFUuE1zbq36PJvRzXY+RrIuF3NxPJWY/KtMsL/oVuCqDa0EETIkS4qV18ifpbPoMngh
         N7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708437467; x=1709042267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AI5Avz0WDOYWyiRhPfNRydtZ2zETZ/BjR+NeiTklUgk=;
        b=RnUY5kFE8a/aWjZJYcV1FpvzRmx9WZFDVJ/yLZpy6a7WcD1s3sQjcbqFGckJUtMZJV
         9rlFPKJuHmAMCaz0v0/tzC2Mn4qQr4diAFupV1yFXbPbDxlL/yzF1lpB7OuZ/QHrFm2x
         b2vnuB/HDbMGNq2823oTlTeGYnRLz+UHDcYl0+DjyqWX9ERbiC151M3UImJ1w0e6L7Ae
         ExRu4DmYCq5LKeOReshgVOvwsXzkXpUrsCrDrmlSlLWihbY752os4FaEeniY1R3gnaw0
         6NKtssZfZH2KdY2JKTCNV3oLd1O0z8SKnaERZbBbPPtj9FB8Bvf3EUf/EmcRXxfNqw8b
         bFsA==
X-Forwarded-Encrypted: i=1; AJvYcCXpB+Yxcs2nox7PgW1oqR3fj3uAo4k7IV0T3ZjRAqRXMNDdiPqMSb8arUKLDrYGZhzstRRDJu20Xbr5O+61vD7etEISJyQwe7EYnx1R
X-Gm-Message-State: AOJu0Yz8fjQaZbprxa/niBCVmkOb4OlSCqp9UIOiS4/y9LhRHh49NsQc
	pgCsdLhSIlRAyj27MkQvMYY8swZguu0pQNiruTYR2/S6/WAw9vl1jgWIz+c77Zg=
X-Google-Smtp-Source: AGHT+IGu4MHtjPKYxRddQnBmeScsZCXVcJ+5xOoO0OEEfqtZRzKqYaxENLsFi0GhZwHaQmb0CApxug==
X-Received: by 2002:adf:f50a:0:b0:33d:14be:a6eb with SMTP id q10-20020adff50a000000b0033d14bea6ebmr8567955wro.45.1708437467042;
        Tue, 20 Feb 2024 05:57:47 -0800 (PST)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b0033b198efbedsm13474007wrw.15.2024.02.20.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:57:46 -0800 (PST)
Date: Tue, 20 Feb 2024 13:57:45 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched: cpufreq: Rename map_util_perf to
 apply_dvfs_headroom
Message-ID: <20240220135745.h5mlvutle6wn6eim@airbuntu>
References: <20240205022006.2229877-1-qyousef@layalina.io>
 <CAKfTPtBoapJtwD3DByd06CE07MD3eGhfJVyZ01cRLyKLO8fJ7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBoapJtwD3DByd06CE07MD3eGhfJVyZ01cRLyKLO8fJ7w@mail.gmail.com>

On 02/14/24 08:32, Vincent Guittot wrote:
> On Mon, 5 Feb 2024 at 03:20, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > We are providing headroom for the utilization to grow until the next
> > decision point to pick the next frequency. Give the function a better
> > name and give it some documentation. It is not really mapping anything.
> 
> The renaming makes sense.
> 
> >
> > Also move it to sched.h. This function relies on updating util signal
> 
> I don't see the benefit of moving it the sched.h as it is only used by
> cpufreq_schedutil()

Hehe what's for me the reason to move it for you it's the reason not to :-)

(I believe you meant cpufreq_schedutil.c)

It doesn't make sense outside of schedutil, does it? I can't see it being
suitable for consumption by other governors for example as it is not generic
enough.

And the headroom definition needs to evolve. And the tight coupling to util
which is a scheduler internal metric will make it hard once it's part of
cpufreq. The headroom IMO is a property of the governor.

We can defer the moving for now if you insist. But I think it's inevitable?

> 
> 
> > appropriately to give a headroom to grow. This is more of a scheduler
> > functionality than cpufreq. Move it to sched.h where all the other util
> > handling code belongs.
> >
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >  include/linux/sched/cpufreq.h    |  5 -----
> >  kernel/sched/cpufreq_schedutil.c |  2 +-
> >  kernel/sched/sched.h             | 17 +++++++++++++++++
> >  3 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > index bdd31ab93bc5..d01755d3142f 100644
> > --- a/include/linux/sched/cpufreq.h
> > +++ b/include/linux/sched/cpufreq.h
> > @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
> >  {
> >         return freq * util / cap;
> >  }
> > -
> > -static inline unsigned long map_util_perf(unsigned long util)
> > -{
> > -       return util + (util >> 2);
> > -}
> >  #endif /* CONFIG_CPU_FREQ */
> >
> >  #endif /* _LINUX_SCHED_CPUFREQ_H */
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 95c3c097083e..abbd1ddb0359 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -179,7 +179,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> >                                  unsigned long max)
> >  {
> >         /* Add dvfs headroom to actual utilization */
> > -       actual = map_util_perf(actual);
> > +       actual = apply_dvfs_headroom(actual);
> >         /* Actually we don't need to target the max performance */
> >         if (actual < max)
> >                 max = actual;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index e58a54bda77d..0da3425200b1 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> >                                  unsigned long min,
> >                                  unsigned long max);
> >
> > +/*
> > + * DVFS decision are made at discrete points. If CPU stays busy, the util will
> > + * continue to grow, which means it could need to run at a higher frequency
> > + * before the next decision point was reached. IOW, we can't follow the util as
> > + * it grows immediately, but there's a delay before we issue a request to go to
> > + * higher frequency. The headroom caters for this delay so the system continues
> > + * to run at adequate performance point.
> > + *
> > + * This function provides enough headroom to provide adequate performance
> > + * assuming the CPU continues to be busy.
> > + *
> > + * At the moment it is a constant multiplication with 1.25.
> > + */
> > +static inline unsigned long apply_dvfs_headroom(unsigned long util)
> > +{
> > +       return util + (util >> 2);
> > +}
> >
> >  /*
> >   * Verify the fitness of task @p to run on @cpu taking into account the
> > --
> > 2.34.1
> >

