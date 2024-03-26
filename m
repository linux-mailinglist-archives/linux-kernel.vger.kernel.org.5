Return-Path: <linux-kernel+bounces-119878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F3288CE16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A308F1C66AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA36713D29B;
	Tue, 26 Mar 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdsl8YoM"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964813CFB6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484121; cv=none; b=WqMyj3LcHRNTlXoFabGBHywCglgH3EjV9vqte+oXapBablAXY0AVEb3RZc+AcBR3Rs/t/IktI/cDQS9qurTZA4TAXrOEp14GzR/go1F0NAIHiIpXD/z20S68ZST941EQaIGWUY/SfzcklAzJoQG/hhDo5AZ6kMcMHdwntemcLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484121; c=relaxed/simple;
	bh=4yBYbmDfgEXYEY4/WQHaGZoRI0U4OduvPl3k8j6yg9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfovJHvIUWTx925y3ahlMzYfbBlbGmQWJGPqNbMmfBKw+xavcJChVFLJ56H9k6T+X+57B7HAQFwg+8YJPLJ7rPML5HF0Q7+lyRM7M/dRdkYu1F3ER+O27Xbol5I4HdOBQCb4xBJIY7dEkoH8v3k4+FkS7eUXJCU1n/psiokMB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kdsl8YoM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e7425a6714so3902318b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484119; x=1712088919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KEIj6g5QJwKmZovExsPATLABNnOuOV8p3kw1ynEOBRo=;
        b=kdsl8YoM/w1i4SRf3SZ2klasmcXB+ySy+ylJyK2R0dPIEfVm1GBOoCk826x4mTmAEC
         OzEpVbWR6iS+77lduNmE2Gb/3Qgd2Kt2jfBExqs1aA+zYY/QaVpu4i75s0mh86mo1cUy
         2VXobruuSHqfLTKCydVE2f7+TxyEieaq4ie18uZdVa+mIK4RyuDANOrTgP34a8YDLeht
         c6hdUHWsLrApsplBhbRUAzzH18filQEVBxBGDcpokUDk4Omn+MVFu8FuW3/XAauSZ8om
         1D+p82v5m8viyybKdpqZIfiTarU9NANCVvURdfdaBpGTa3RdGt91UFeCyAP7Qy9yJGU4
         uJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484119; x=1712088919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEIj6g5QJwKmZovExsPATLABNnOuOV8p3kw1ynEOBRo=;
        b=ZU2Ea9kQHDIKEIne28LQN6e5zcwm90kI89u2/0hiC6WzoLap5TY7UtHiktjJlYAQlm
         Tk1WhvSJ0w0VV/p5mwxox0tV8NIxBF85f9zi8PPEtqsrHQwjUrwFCIbnlwVXmGe3mCWh
         6CsygK6BAKd0Mbs9Nhb2L+o/nW3AIOloAqL1anfWeD0tmdqggXpFryKQirPP3+Vn3fmi
         KJ9NBf1a7qe6S0/QzNZx/W/CksiZccM+0bOHfP1em/xVJbSiG34Gqf3WXmYquJALfNCe
         XL5YPL9xh1bAkJpNjfNvBMVfEsbJ7arl1R7sH029HK4t/yF4GEKxDq+lG8A1RtIWb1D+
         BfVg==
X-Forwarded-Encrypted: i=1; AJvYcCUn6SsEBvodJin7zsPCu5qbuRQfbDdUrWQnHzOK/eef8HqDbJon1OlCnWvY2n2xkeN8sPgLhM9gebKPUeMOknHju4MOxiJ2OtPI9pbG
X-Gm-Message-State: AOJu0YznGUzBRB5B53Q9s413luWpp54SUa3HLT8cOS5CuAEpA1/BG6jC
	CSFpT6ZTgiGUxOJP7pO3K7fTqs9T40wJuE3xDfl1LYbs8v1UDmOFhIZAEU5Cn9ejyuC/3vkhYSn
	3E1q1LwvGN6vj7gxE/kBZptGCSEGbeZkkKeu4YrfMwhijryVF+Xs=
X-Google-Smtp-Source: AGHT+IHPKYXRgrHAZz7qgpOQRs0ve3LD3Lxt6htHFab48RxUMDw+btmHKJM0H7u27tG+k/+bwrRkP9wyBgFR4gS84yE=
X-Received: by 2002:a05:6a00:3ccc:b0:6e9:74d7:7092 with SMTP id
 ln12-20020a056a003ccc00b006e974d77092mr12836329pfb.24.1711484118932; Tue, 26
 Mar 2024 13:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326152616.380999-1-sshegde@linux.ibm.com> <ZgMiwYxF5rnVTpLf@gmail.com>
In-Reply-To: <ZgMiwYxF5rnVTpLf@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 26 Mar 2024 21:15:07 +0100
Message-ID: <CAKfTPtCk_aD-g-uADdoiWrGVHBbbVMuBKzWjyrKuA609O8vJzA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Combine EAS check with overutilized access
To: Ingo Molnar <mingo@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, peterz@infradead.org, dietmar.eggemann@arm.com, 
	qyousef@layalina.io, linux-kernel@vger.kernel.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 20:32, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> > Access to overutilized is always used with sched_energy_enabled in
> > the pattern:
> >
> > if (sched_energy_enabled && !overutilized)
> >        do something
> >
> > So modify the helper function to return this pattern. This is more
> > readable code as it would say, do something when root domain is not
> > overutilized. This function always return true when EAS is disabled.
> >
> > No change in functionality intended.
> >
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > ---
> >  kernel/sched/fair.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 24a7530a7d3f..e222e3ad4cfe 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6686,12 +6686,11 @@ static inline bool cpu_overutilized(int cpu)
> >  }
> >
> >  /*
> > - * Ensure that caller can do EAS. overutilized value
> > - * make sense only if EAS is enabled
> > + * overutilized value make sense only if EAS is enabled
> >   */
> >  static inline int is_rd_overutilized(struct root_domain *rd)
> >  {
> > -     return READ_ONCE(rd->overutilized);
> > +     return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
> >  }
> >
> >  static inline void set_rd_overutilized_status(struct root_domain *rd,
> > @@ -6710,8 +6709,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
> >        * overutilized field is used for load balancing decisions only
> >        * if energy aware scheduler is being used
> >        */
> > -     if (!sched_energy_enabled())
> > -             return;
> >
> >       if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
> >               set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>
> On a second thought, I'm not sure removing the open-coded
> sched_energy_enabled() branches is a good idea: the current code makes it
> really, really clear when we are within EAS code paths.
>
> Hiding it within is_rd_overutilized() makes it a lot less obvious IMO.

That's probably a matter of pov. I prefer embedding everything to make
sure to have useless access to rd->overutilized

>
> And this one:
>
> > @@ -8202,7 +8199,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >                   cpumask_test_cpu(cpu, p->cpus_ptr))
> >                       return cpu;
> >
> > -             if (sched_energy_enabled()) {
> > +             if (!is_rd_overutilized(this_rq()->rd)) {
> >                       new_cpu = find_energy_efficient_cpu(p, prev_cpu);
> >                       if (new_cpu >= 0)
> >                               return new_cpu;
>
> Didn't have a root_domain::overutilized check before?

This is the one that was in find_energy_efficient_cpu() before.

>
> Thanks,
>
>         Ingo

