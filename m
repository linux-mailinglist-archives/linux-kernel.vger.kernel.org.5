Return-Path: <linux-kernel+bounces-73175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2890A85BEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BBEB22E93
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7CE6BB2B;
	Tue, 20 Feb 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hppiNdG/"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F26A8C0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438935; cv=none; b=EdrmRd4D/UYwbWPQWbGbsZFgklxdof+7b8s0Y3LwGgQWWId1QYMSHeQT+VpoV6bU9MULOzi6P/DMsg1Dm3CGhNWmTz6R7A4ZcO2Vxbpxd16tPY88XfaHhoXdXmzCGbqzzHfmstWXnaz/RmKs/Ifcz66UTw7y0X6POzkzQ27f0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438935; c=relaxed/simple;
	bh=jAw2zftbgBAJKSrekDaII6VYyxCwwnVK69YNBjgCFjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiP/zAZaorJP0xQL+NctlV4HhwQMszsBtehMKVoqPc2TgyXEUbrAxYlf27grHmEIvPJIy2yr0peG11IWWTelTxUeQ4qtlqT782Z+IGM1n6vGvuB9yprBGckUrf/zAkDvnjCMYcyDlryFoWexAQhG7ohSe4axkitEIRlNBrk9mTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hppiNdG/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so4083897a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438934; x=1709043734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KBoCun9C06tVXA8wZQBtoO6pNvn7N0rtBPsUqAq+yXE=;
        b=hppiNdG/2PZVg4ZIIrL8BrJr9fE5V4CPQm4nFkptDD6Fmw5sWN8/sabT37ghC4AZJT
         8lEe2bd+Pf4Q0cqhkMjPRH940ppBZdP/YdRTx3MXvq5p7iGQuB8M4ivMXAtrKADyY/ME
         lAl5jJ083XbeFWSiLquBmu1j9EHZiMjZ3D49f64qd2xL/oGQkbKP7ugKpgfKCT0mbqMl
         U/xlwXA9oSXsUbyPXK+ur4EqWG4z6aN0qP+RpMS8LAPWwomCnC3n6b70l4McTEhkM6Du
         5f3/L+AMfNfQ/oFQrwbOhoDUri9+NHvlWlFdqidlpxS1Jee9WLejFYKJUrR6BVOSG9JH
         knYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438934; x=1709043734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBoCun9C06tVXA8wZQBtoO6pNvn7N0rtBPsUqAq+yXE=;
        b=Gtdi68kSZUz1Qzl1U+r3TCMbHg5kWv/QDYAA7t80396IuAHKuHr3hFauc7ObnZ3/Ab
         DZEoInyIgabCRxz7LF31Xzx17zRuOc9s+eSUNKWVvCHcFLoQHfw3cwX7uBg0Fb9pwEbM
         h+mCyl+CrDVchlgHjy/92uWV8pD0TmNUcxl+nDtL+kVpsRzP73LSsfR3sZ0pYkzuf/M8
         A2YgA5Bty/I7qYEYu69MJdtT56mbPl936viKGgrFdg5CDVA1woiwVSHfWdN1O4czkevE
         /FMH4xgCNWAsQJ/D1vH8rp9cBqchBi2FwZCP//LjXcKAML+c5W+Y2gXxDclC66FC6fBG
         TTXA==
X-Forwarded-Encrypted: i=1; AJvYcCXWQDYgcSIE6vcfdTlM0X0JjbBky2KxePiV/rWyenjuFNM82M2X8nMcgk7Gg7bTct8J9EGrofQJlj8RRJ4tBpEtPiqBrpdsJtHQAAC8
X-Gm-Message-State: AOJu0YyO+07r8TlAhzu7G6HItLCj3W8d2Q1kS2dqfsov88dNuxPzy+of
	cS61IZ7gXJU0DHRo+u1lf3hmYZok/kqPfADKrT5L3dTAUdKpnQSxTzDBRYlNa+QTec5sByZHgQE
	BoUDlCPmrldRbsHzzsS7bxuZt+3nyjzTMFXRoJ2rvVblhqXWE7rs=
X-Google-Smtp-Source: AGHT+IFvO5zHZP2am1JSDTjIy5GjXf4oDweY/JpnM+jBH/YIWxTOWYQqtadZC/X+MVB9tx0aiSAWQYW5bjgZOemKtn4=
X-Received: by 2002:a17:90b:3555:b0:299:b570:bbd6 with SMTP id
 lt21-20020a17090b355500b00299b570bbd6mr3792421pjb.28.1708438933728; Tue, 20
 Feb 2024 06:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205022006.2229877-1-qyousef@layalina.io> <CAKfTPtBoapJtwD3DByd06CE07MD3eGhfJVyZ01cRLyKLO8fJ7w@mail.gmail.com>
 <20240220135745.h5mlvutle6wn6eim@airbuntu>
In-Reply-To: <20240220135745.h5mlvutle6wn6eim@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 20 Feb 2024 15:22:01 +0100
Message-ID: <CAKfTPtDC0w-gdb15pmCDr7tS9gmTeT4qAugTSviO+g9KebNvzA@mail.gmail.com>
Subject: Re: [PATCH] sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 14:57, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 02/14/24 08:32, Vincent Guittot wrote:
> > On Mon, 5 Feb 2024 at 03:20, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > We are providing headroom for the utilization to grow until the next
> > > decision point to pick the next frequency. Give the function a better
> > > name and give it some documentation. It is not really mapping anything.
> >
> > The renaming makes sense.
> >
> > >
> > > Also move it to sched.h. This function relies on updating util signal
> >
> > I don't see the benefit of moving it the sched.h as it is only used by
> > cpufreq_schedutil()
>
> Hehe what's for me the reason to move it for you it's the reason not to :-)
>
> (I believe you meant cpufreq_schedutil.c)
>
> It doesn't make sense outside of schedutil, does it? I can't see it being
> suitable for consumption by other governors for example as it is not generic
> enough.
>
> And the headroom definition needs to evolve. And the tight coupling to util
> which is a scheduler internal metric will make it hard once it's part of
> cpufreq. The headroom IMO is a property of the governor.

In this case make it part of cpufreq_schedutil.c if this is the
governor that can use it. I don't like sched.h because It gives the
impression that scheduler can play with it whereas it's a property of
the cpufreq governor

>
> We can defer the moving for now if you insist. But I think it's inevitable?
>
> >
> >
> > > appropriately to give a headroom to grow. This is more of a scheduler
> > > functionality than cpufreq. Move it to sched.h where all the other util
> > > handling code belongs.
> > >
> > > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > > ---
> > >  include/linux/sched/cpufreq.h    |  5 -----
> > >  kernel/sched/cpufreq_schedutil.c |  2 +-
> > >  kernel/sched/sched.h             | 17 +++++++++++++++++
> > >  3 files changed, 18 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > > index bdd31ab93bc5..d01755d3142f 100644
> > > --- a/include/linux/sched/cpufreq.h
> > > +++ b/include/linux/sched/cpufreq.h
> > > @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
> > >  {
> > >         return freq * util / cap;
> > >  }
> > > -
> > > -static inline unsigned long map_util_perf(unsigned long util)
> > > -{
> > > -       return util + (util >> 2);
> > > -}
> > >  #endif /* CONFIG_CPU_FREQ */
> > >
> > >  #endif /* _LINUX_SCHED_CPUFREQ_H */
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 95c3c097083e..abbd1ddb0359 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -179,7 +179,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > >                                  unsigned long max)
> > >  {
> > >         /* Add dvfs headroom to actual utilization */
> > > -       actual = map_util_perf(actual);
> > > +       actual = apply_dvfs_headroom(actual);
> > >         /* Actually we don't need to target the max performance */
> > >         if (actual < max)
> > >                 max = actual;
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index e58a54bda77d..0da3425200b1 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > >                                  unsigned long min,
> > >                                  unsigned long max);
> > >
> > > +/*
> > > + * DVFS decision are made at discrete points. If CPU stays busy, the util will
> > > + * continue to grow, which means it could need to run at a higher frequency
> > > + * before the next decision point was reached. IOW, we can't follow the util as
> > > + * it grows immediately, but there's a delay before we issue a request to go to
> > > + * higher frequency. The headroom caters for this delay so the system continues
> > > + * to run at adequate performance point.
> > > + *
> > > + * This function provides enough headroom to provide adequate performance
> > > + * assuming the CPU continues to be busy.
> > > + *
> > > + * At the moment it is a constant multiplication with 1.25.
> > > + */
> > > +static inline unsigned long apply_dvfs_headroom(unsigned long util)
> > > +{
> > > +       return util + (util >> 2);
> > > +}
> > >
> > >  /*
> > >   * Verify the fitness of task @p to run on @cpu taking into account the
> > > --
> > > 2.34.1
> > >

