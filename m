Return-Path: <linux-kernel+bounces-92623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E92872301
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD351C23096
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8388128362;
	Tue,  5 Mar 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jc2ivg69"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59C127B71
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653194; cv=none; b=dg+MCxGDXnXdXfczdpckGYnflMcojKyHbECAb6vd/qmJJSX4fPYeuxZ6hK2r9MXIjgRTEvwIXgI3ev11USHiLanEBcWPn9gpSEdEDAvg6EqRGt2Iho3AY+ytsqhV6lOOEBn43YP+YIyHvVN1wOpTndIPzdbinakeAtiTkxkHv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653194; c=relaxed/simple;
	bh=sptLKP1qj/IdRZ23mzS3Bpz78MwzyEFf336ZqQ2JjEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCC/YrFn/4nmP3FYJIRyghX6txSXROjMGqp8UAg/Pu6XvYDJcBEiJZtf6LJwI1o5J+FLIrp0XBrHdAzXFECdWTyRQrqXQvG2L7DvIZmgSqYF5vyYdSwahDLC56OTlCny62FkcgjCCoxr83jc5yiiJn9WtQRfHCX2vLb2XVklfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jc2ivg69; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a11dea5bbaso2110352eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709653192; x=1710257992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N07enT1aAcuouhS79EMXmnQ3oHVX7oa3bHXCLqkh0bk=;
        b=Jc2ivg69wpIDGxyvIDeu+zXzdG+azdAchpZhnBkOOQLR39v8URgJfLU1vYMN/VyDBG
         87JwwkuHQTHex48wRfYs0cV1OuLmsklRWwov3aOOPxEMMDOicQmeG7Gv+NCr5+JAqKx0
         pa/vBCSoa6tP9s1VbeT6+G43+Vx6vhc+7bCbNeUirOk+dEc3ObwhqnRSAGDI8to5zWNb
         pfvBGNV4+7MpeWwq+cYl8Qb9Aa6N23JCT7ozqUm1SVciGi2TEUCuXthKllZz7010IUoV
         Dhs1AJKbjJM7wznfZh1CcTMU+0TAtKFKGU1hmYcxcwDa3o4Ji3y5m0RBQVUy3V9TbAel
         13uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653192; x=1710257992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N07enT1aAcuouhS79EMXmnQ3oHVX7oa3bHXCLqkh0bk=;
        b=R6+THuV+/BXalM2fHB9vn93aGdobhf8eXG+xq6EZ0NrPlPUjHUyUmTBOuEySM6TLfc
         QA8O8Jqqgtf73clKraM5AscEFLaHqr9WdiqVIb4qhzNsR8MuJiEQFH/qjOn7ZHcpcUK3
         nAYt9NSOsswLhtm5mfOVrXeiLrFwFA7+YNUThoBRXrm//QDMfJ0XbcjZSXJ5O4OTcetP
         MRyNJh8meu7F1/Ha2XF2v+H7/fHPjCuxPkf+Clsr3D7J/KgGd0Sd1s40LKIfyw4nc0P4
         IrPh6Ds3z8/KSXtPl9x9x7swnMMm/9FhR5JOftVFAcrm3sWq5CL1xpDsGLnvyHT89MuK
         U4Ag==
X-Gm-Message-State: AOJu0YxHoIU0rRE5O8+2eXeMSpu4RElGDwdRdPEw6XCNkrL9PebXqRNh
	xI+naarqOldWQkxMOMO2P4RZB2SUFPQ11iUPxno1/yUosDJnUy67k8AonRFQhkZrh92xekyMBfu
	vCRKgcs4qL0k2rg89WWRlPeGwhjNpBVwOweVq1FaJjYUMDefkoQY=
X-Google-Smtp-Source: AGHT+IFCXrNh+2CwBiuApe2KiFN6j7Yb61poInVx93GmXO6ac6FS9+kaeZxhzevpTPBdsDhBkJpPida1FeAQSb06zVM=
X-Received: by 2002:a05:6358:a09b:b0:17c:9a3:7813 with SMTP id
 u27-20020a056358a09b00b0017c09a37813mr2436196rwn.27.1709653192238; Tue, 05
 Mar 2024 07:39:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305095111.777525-1-christian.loehle@arm.com>
 <CAKfTPtC6D4RTP3T8tqEJKA1drGbAANOaGPKqmELd1G8TLocizg@mail.gmail.com> <0e2833ee-0939-44e0-82a2-520a585a0153@arm.com>
In-Reply-To: <0e2833ee-0939-44e0-82a2-520a585a0153@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 5 Mar 2024 16:39:39 +0100
Message-ID: <CAKfTPtDtu1-9noPuV0bK=nbkX0XzF8raojb1je=RUPpzKRC85w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Remove stale FREQUENCY_UTIL comment
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 16:18, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 05/03/2024 15:05, Vincent Guittot wrote:
> > On Tue, 5 Mar 2024 at 10:51, Christian Loehle <christian.loehle@arm.com> wrote:
> >>
> >> effective_cpu_util() flags were removed, so remove the comment part
> >> mentioning it.
> >>
> >> commit 9c0b4bb7f6303 ("sched/cpufreq: Rework schedutil governor performance estimation")
> >> reworked effective_cpu_util() removing enum cpu_util_type.
> >>
> >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >> ---
> >>  kernel/sched/fair.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 533547e3c90a..6b0c47d00fd3 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7849,8 +7849,6 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
> >>                  * Performance domain frequency: utilization clamping
> >>                  * must be considered since it affects the selection
> >>                  * of the performance domain frequency.
> >> -                * NOTE: in case RT tasks are running, by default the
> >> -                * FREQUENCY_UTIL's utilization can be max OPP.
> >
> > Yes, it's no more accurate.
> > Should we update the comment instead of deleting it as the effect is
> > still there ?
> >  "NOTE: in case RT tasks are running, by default the min utilization
> > can be max OPP."
>
> I'm fine with either and that was my first thought here, too, but it did seem like
> the comment was mostly placed there to justify the 'unexpected' high utilization
> when explicitly passing FREQUENCY_UTIL and the need to clamp it then.

The behavior is still there but it has moved in the min parameter .
The problem remains the same when it come to select a compute capacity
with sugov_effective_cpu_perf

> So removing did feel slightly more natural to me anyway.
>
> So alternatively:
>
> From: Christian Loehle <christian.loehle@arm.com>
> Date: Tue, 5 Mar 2024 09:34:41 +0000
> Subject: [PATCH] sched/fair: Remove stale FREQUENCY_UTIL mention
>
> effective_cpu_util() flags were removed, so remove mentioning of the
> flag.
>
> commit 9c0b4bb7f6303 ("sched/cpufreq: Rework schedutil governor performance estimation")
> reworked effective_cpu_util() removing enum cpu_util_type. Modify the
> comment accordingly.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..f5151cbcd94e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7849,8 +7849,8 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>                  * Performance domain frequency: utilization clamping
>                  * must be considered since it affects the selection
>                  * of the performance domain frequency.
> -                * NOTE: in case RT tasks are running, by default the
> -                * FREQUENCY_UTIL's utilization can be max OPP.
> +                * NOTE: in case RT tasks are running, by default the min
> +                * utilization can be max OPP.
>                  */
>                 eff_util = effective_cpu_util(cpu, util, &min, &max);
>
> --
> 2.34.1
>

