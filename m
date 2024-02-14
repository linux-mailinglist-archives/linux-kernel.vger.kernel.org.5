Return-Path: <linux-kernel+bounces-65650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53765855000
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775AD1C29386
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB284FAE;
	Wed, 14 Feb 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bz2viO5C"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A258128368
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931189; cv=none; b=De3nasGWuAmkE7v8JIOsGAYbbIcpC77Bs22K8rq/YQu6dqfLzyZrgQ/I+L+0DkfeQKqfNmzXctTaEA6cz4zhRQvCkDSW3Pmr1tRwjJJhHobMiZeO6fWy6wbm/D/6izi8dwpty3QQOOas7TyVyxCH0/7qrA/LVKW1VsQXVJ92ffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931189; c=relaxed/simple;
	bh=Yku4QTzDRgKI/i8hKOFaa1PxharxpUPm5kuh1Z3KMas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPDFKrQS5ItEIuYOt9xCXtx/ZG49fNoQ0d+cz5giIZzMFnoBIj/rdkLXx5pmKEPuXc4eT753H0f2F7Ev6FxgX2ai3LQ76cPQbR8IwCh6BqX8daT1o3WC7EC+uvxnzRMb56NLUlS1yleNszbqKg6eTZlDZ3erFotGbgIBVgB+/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bz2viO5C; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7232dcb3eso42959435ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707931187; x=1708535987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQJxYiPtkKunXHr1tWOWmm3RzE0fHMgYFU5N+FoanzQ=;
        b=bz2viO5CXR43zHcNBPXSQpr8axEtMcy6ugW9CYGG1Dg3Ei1haWIZcwbHlbyoVQDMQ4
         0jObCmRQs5ZYIbbHCKY/pVWw3MAdFFG+bU6GBKz5T1CaqR1veJY2i6RMqyA+cmOvBObq
         UNfXg5sw3jDh1HpblzSn2ZKpUWwXmdbmWE4KtydlQylNrklVKXO2S0jq+0tn+rRZpxbn
         OlIbro1TGzQwJLqrDh4txKaz52dlkrhX+Oqb50tGky4eJ1EKzIopcBTMKtzsiVUsv+dv
         HKbLsM0cIzS+gIrtXfMjuhW7rppLJsCZ5fZ0TfTibyLLYvsmTcRNCgGn3eG7YTbUnvnB
         36+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931187; x=1708535987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQJxYiPtkKunXHr1tWOWmm3RzE0fHMgYFU5N+FoanzQ=;
        b=sOcEgs2CEbT2OLXmb9TwmlaN7DtDLDuMAatfffJo+G9feWVCJ5YZpth0NW8VQutqA3
         3fY0M10LWvTOEUfG2bokpHSsFyeV3B59zq4ZkDHdBscXa4ErxA8R6/Po3hOXKy5JKNIW
         +B4yAsXX1zHhHEcFpy2Fe2j/Wl0vxwgBCmrbOVqE4tGkWp0yL8bsTsYJOZTQ6+5z6nbD
         E4hRRDBeRHZzYSTmM6PbvyFER1nIea8XTBxXzAGYWk7czBphZLm/grGerAOYzcQFpODV
         qr+23jKAOheeEndBRmr4H58zYyNzaq/lxY7DTpxclJT3XmK8fL5XQ+PpSL9catqmZj5R
         xXGA==
X-Forwarded-Encrypted: i=1; AJvYcCUPmoxiLS9LJfD5DQqMkgPY76pACLhbMKFOTnGn6qZQ3w7I0NiJbdZrlhTDsdC0Qc5hKx+xXeVOx5s0m0rLxmiHnbBusuY3TgOAJqUH
X-Gm-Message-State: AOJu0YypquPlZjbZ79L+1O4dK4rF0IMvwr/41AUXDS/8LaU58EZeXW2J
	x8rVODh90qVT9ymEhj3oxFuN2bBnYP24mmMIESplrqSoTkriynyFaitMaKjolhHuH2TQ3GMKnuk
	1W+AfNHOXzMcxTH1CPPhkCcosEpoABUecU0jKXw==
X-Google-Smtp-Source: AGHT+IE/4Jb60J8umLNZe6538ribl0j0RPOFasDoPpDRIFX5AjneBXpKfyUvuFsnp7LDN4A0Ix05qgk5V9Wx9geOoCA=
X-Received: by 2002:a17:90b:351:b0:298:ba30:789b with SMTP id
 fh17-20020a17090b035100b00298ba30789bmr3088028pjb.32.1707931187327; Wed, 14
 Feb 2024 09:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240114183600.135316-1-vincent.guittot@linaro.org> <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
In-Reply-To: <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Feb 2024 18:19:35 +0100
Message-ID: <CAKfTPtAR-yWG8odEv-b8XoZQa05OiYd3PLn56MA+AqPb4h=NJA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant case
To: Jon Hunter <jonathanh@nvidia.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, wkarny@gmail.com, 
	torvalds@linux-foundation.org, qyousef@layalina.io, tglx@linutronix.de, 
	rafael@kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, 
	Sasha Levin <sashal@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Shardar Mohammed <smohammed@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Wed, 14 Feb 2024 at 18:12, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi Vincent,
>
> On 14/01/2024 18:36, Vincent Guittot wrote:
> > When frequency invariance is not enabled, get_capacity_ref_freq(policy)
> > returns the current frequency and the performance margin applied by
> > map_util_perf(), enabled the utilization to go above the maximum compute
> > capacity and to select a higher frequency than the current one.
> >
> > The performance margin is now applied earlier in the path to take into
> > account some utilization clampings and we can't get an utilization higher
> > than the maximum compute capacity.
> >
> > We must use a frequency above the current frequency to get a chance to
> > select a higher OPP when the current one becomes fully used. Apply
> > the same margin and returns a frequency 25% higher than the current one in
> > order to switch to the next OPP before we fully use the cpu at the current
> > one.
> >
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Closes: https://lore.kernel.org/lkml/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com/
> > Reported-by: Wyes Karny <wkarny@gmail.com>
> > Closes: https://lore.kernel.org/lkml/20240114091240.xzdvqk75ifgfj5yx@wyes-pc/
> > Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Tested-by: Wyes Karny <wkarny@gmail.com>
> > ---
> >   kernel/sched/cpufreq_schedutil.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 95c3c097083e..d12e95d30e2e 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> >       if (arch_scale_freq_invariant())
> >               return policy->cpuinfo.max_freq;
> >
> > -     return policy->cur;
> > +     /*
> > +      * Apply a 25% margin so that we select a higher frequency than
> > +      * the current one before the CPU is full busy
> > +      */
> > +     return policy->cur + (policy->cur >> 2);
> >   }
> >
> >   /**
>
>
> We have also observed a performance degradation on our Tegra platforms
> with v6.8-rc1. Unfortunately, the above change does not fix the problem
> for us and we are still seeing a performance issue with v6.8-rc4. For
> example, running Dhrystone on Tegra234 I am seeing the following ...
>
> Linux v6.7:
> [ 2216.301949] CPU0: Dhrystones per Second: 31976326 (18199 DMIPS)
> [ 2220.993877] CPU1: Dhrystones per Second: 49568123 (28211 DMIPS)
> [ 2225.685280] CPU2: Dhrystones per Second: 49568123 (28211 DMIPS)
> [ 2230.364423] CPU3: Dhrystones per Second: 49632220 (28248 DMIPS)
>
> Linux v6.8-rc4:
> [   44.661686] CPU0: Dhrystones per Second: 16068483 (9145 DMIPS)
> [   51.895107] CPU1: Dhrystones per Second: 16077457 (9150 DMIPS)
> [   59.105410] CPU2: Dhrystones per Second: 16095436 (9160 DMIPS)
> [   66.333297] CPU3: Dhrystones per Second: 16064000 (9142 DMIPS)
>
> If I revert this change and the following ...
>
>   b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
>   f12560779f9d ("sched/cpufreq: Rework iowait boost")
>   9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
>
> ... then the perf is similar to where it was ...
>
> Linux v6.8-rc4 plus reverts:
> [   31.768189] CPU0: Dhrystones per Second: 48421678 (27559 DMIPS)
> [   36.556838] CPU1: Dhrystones per Second: 48401324 (27547 DMIPS)
> [   41.343343] CPU2: Dhrystones per Second: 48421678 (27559 DMIPS)
> [   46.163347] CPU3: Dhrystones per Second: 47679814 (27137 DMIPS)
>
> All CPUs are running with the schedutil CPUFREQ governor. We have not
> looked any further but wanted to report this in case you have any more
> thoughts or suggestions for us to try.

Have you tried this :
https://lore.kernel.org/lkml/20240117190545.596057-1-vincent.guittot@linaro.org/

It's in driver-core-linus' branch and should be sent to Linus soon

Vincent

>
> Thanks
> Jon
>
> --
> nvpublic

