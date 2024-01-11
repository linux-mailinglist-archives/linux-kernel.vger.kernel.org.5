Return-Path: <linux-kernel+bounces-23247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 002F682A9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964E1B24839
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610641172D;
	Thu, 11 Jan 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlWN2TBl"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400ED11704
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso2146147a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704963189; x=1705567989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4e6Zeh9ktpPN489K8Bx9njOW7cObEYYxVQYUCbqBhE=;
        b=UlWN2TBlYF4d6zyMvO4hTEyteoNG2wPzPwxe4FU62cbJrfEVkq8WRdlDcwg87kFlVw
         CTvV16FqRED2J0k2QcZCz3WuIDaWDMlqY+w+ayStHrsuyNi84WxkMiAulRFAqM6yASL/
         HZD6W01UfllulFBu93a2clwf32OMzKosvZaaI5L8XU8dx1wwS/6ZNugSvOp7wWDWfVF4
         L2fd1LgFQBBBkXlhxu9rfPa4l01oNfg+TKfJ9pKKcun3LHapKPZkL1DtybC1UfYwm2NW
         eHQXecYinzMtoMGn8DljGP+d62BisAIsOBfOxjZV3tA8Nb4kB8S11MZXgKOBFc296gUz
         J0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963189; x=1705567989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4e6Zeh9ktpPN489K8Bx9njOW7cObEYYxVQYUCbqBhE=;
        b=Pb6RovUGiBL/1MG1qlpxy2FDjDGjwE4YmD8fLqZkUM/H7HLHh9HOxepy7c65vhz4Fb
         TmY+oXb0tFXtDRPYBP0WvM5Dryq+Ptiw5/VfRRibh1KB7MBtHR11EwIoQwz0xyQIr0zZ
         8q3RXg7BHGpoJI2sI9ND6bTirC6e2NP4OzsDv+5jwLWeH9SIqgk2fRGflnibgIw1bRDk
         eP73NJBTvBaOuxNzeUxV0S0P6Qh+gowCPUg5272qlYlTRfprkkkL3ApyBv5A2knKjIwg
         UAZFUgAD1QwYcjEWDnK3IwuO53bQRiF0wbBzZZRpmt5XjO8u2eBaxM6nHD3hw/ipWGDf
         y5Uw==
X-Gm-Message-State: AOJu0YwP+P2XR3rW632gdDb19tKqLYRktYJ9otexRzc1X+P5qGn9qUON
	GDQO5ukNYZsCS1p5AzP7nVB3gdOtCZoDiLU7Ou1gVLThjunj1Q==
X-Google-Smtp-Source: AGHT+IHNGEbseD/uH+2yRVuHw+PgTFJ0jqvNru785773g0GXRqbrbkyA3N425zF/5c6ajSU1Yj+Xurk7y2Jlx9/qwME=
X-Received: by 2002:a17:90a:cb90:b0:28b:c953:77b0 with SMTP id
 a16-20020a17090acb9000b0028bc95377b0mr505334pju.97.1704963189425; Thu, 11 Jan
 2024 00:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110131707.437301-1-keisuke.nishimura@inria.fr>
 <CAKfTPtCgqkUUtWMknyHrNeb994V_L4T9bxV9A=bUXCQu-+S1SQ@mail.gmail.com> <8d9e076c-8505-4538-83f5-506ccf62f7a9@inria.fr>
In-Reply-To: <8d9e076c-8505-4538-83f5-506ccf62f7a9@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 11 Jan 2024 09:52:53 +0100
Message-ID: <CAKfTPtDN0X3eern3DDj9JVh10YJ=YX9OHW0HYJscoi+P-4_v4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2 RESEND] sched/fair: take into account scheduling
 domain in select_idle_smt()
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Julia Lawall <julia.lawall@inria.fr>, 
	Xunlei Pang <xlpang@linux.alibaba.com>, Abel Wu <wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 18:57, Keisuke Nishimura
<keisuke.nishimura@inria.fr> wrote:
>
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 533547e3c90a..66457d4b8965 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7311,13 +7311,19 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
> >>   /*
> >>    * Scan the local SMT mask for idle CPUs.
> >>    */
> >> -static int select_idle_smt(struct task_struct *p, int target)
> >> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> >>   {
> >>          int cpu;
> >>
> >>          for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
> >>                  if (cpu == target)
> >>                          continue;
> >> +               /*
> >> +                * Check if the CPU is in the LLC scheduling domain of @target.
> >> +                * Due to isolcpus, there is no guarantee that all the siblings are in the domain.
> >> +                */
> >> +               if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
> >
> > commit df3cb4ea1fb6 ("sched/fair: Fix wrong cpu selecting from isolated domain")
> > also checked if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> >
> > Why didn't you also re-add this test ?
> >
> >
>
> Thank you for your comment. This is because the iterator "for_each_cpu_and(cpu,
> cpu_smt_mask(target), p->cpus_ptr)" ensures that cpu is included in p->cpus_ptr.

Ah yes indeed. I didn't notice that it was now included in the for_each_cpu_and

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


>
> The iterator has changed. FYI, here is the change made in commit df3cb4ea1fb6:
>
>          for_each_cpu(cpu, cpu_smt_mask(target)) {
> -               if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> +               if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> +                   !cpumask_test_cpu(cpu, sched_domain_span(sd)))
>                          continue;
>                  if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>
> best,
> Keisuke
>

