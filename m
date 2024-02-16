Return-Path: <linux-kernel+bounces-68439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BA9857A38
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40853282461
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C8F24B50;
	Fri, 16 Feb 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+qGU7Re"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4CF12E78
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079080; cv=none; b=lPBzy8FAzJ3SH9NJgdIabSKp8HtJWp9aOHznCo5CN1ccgFjdvg92pHzAkuFVhrU2Sa8Lqbybj4YoLg+u4bURASwksfeRN4XSFtDio7ytzqLQwYFNzyUmjJgExd49ellekxqzXY5YdEWO2DwnDF3zn0HLJYj03+tBrQ2lR3ln3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079080; c=relaxed/simple;
	bh=x51vz9O6mot/XGE6MkaXf9a34isHwjwlCzvxKlHoyas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8uw7hAPPPztD/v7V/v78Ubt+8ij/0rz0X1+foF02V1UxymPWygeRgLzqT2SdfD+tZtK7/m96VBNJQlIFcGchpaKkuM/V2GWkQvogWfSMCxTvfiyc+igu4nvgKxcCmFyWmj8LX02hlAlSLu48oTtPmht8ole/FzjmYVpYA1WVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+qGU7Re; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbc649c275so1011671b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708079078; x=1708683878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SYGaelmQ1tr94QZOI15K5NazGRFH4ITRHWrwcFii0/8=;
        b=W+qGU7Re+vz7clHRGbFQl4JXPUogeykZEDa5yfQGwX4nQAPBLlp3+UGFvMWFWE9ISd
         cQTD27X9XMzD+HEmf6aL1jZksO4hVTyJMUSlUcu1S7+41Xk+Hw4VXwlJBgH+QlIqENEh
         6b2amSINQx+SjTwINRq5wTWHhyiZFZ4iwEk9oOvIotOuw274O6C+aM1J87HF6ue6iEN+
         NbS4aWfNBaeAE0JVqH+W/2cisIPkND2NkX0FzVyfTkP/Q3nyROqVBYtFIUmgmCc+qs82
         s4OggTD82iT3uXGScf4/hBdHYwgJN4efwpc0pSzDVJ3JvFWRruUqZ+eCgCWI0vyMCThb
         79IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708079078; x=1708683878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYGaelmQ1tr94QZOI15K5NazGRFH4ITRHWrwcFii0/8=;
        b=Riqx6gdzu0UIjYvTess83JldVPEG5dvehlLbTjZ+4nVsYEt6PGwkCY7Qn5pR7wQYKr
         vGjWX0aXNSQi9gOs1zy3t2LxBoIhGZnkHTNpcPtmoOIZ4zeVnRQgPIl13oLgySSRn4Tn
         nRjR0lPWoAxijT+mmu98Lq0KKn0hz5f/TqJg2rqvig3Z1MfljGbwPJGjaTTEDGUQV+wt
         o7LCe5UnlbHNzeBJPQ/voCWuss9fXbXOpTxtPKdpCrZ71fibV3y4pg6FNvVx+K+8zCAc
         P3CJBqboh4qVIkR7PSFxSsMrgg0ikx2b5CS7w4HfWjbWpl7esO4byHLrDZVHHjH0DoFj
         YP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmMsEl2YZfzK3fGw/Ob8WVMLY49zno11Rh7lfIwEF6NvSC0w3+/eon+rLC0K6LaXIyrRwNSuUpAbM8jIauc5j8/uYkAL7uDLMGpGqU
X-Gm-Message-State: AOJu0YykoECtjbv/d0KTvnjSQgxWKCSbK7jmjDI0BkneskOp+AWiUqkr
	efqYUctn0CUXuiOfJ611U3QI1ALbdoKO+IgC7sKE954dv3tc1RBaAmu4LVZZ5Gj1K3M58d6G0XL
	Fj8Nc2e/hUGDhPAu4V/Fc6DBpDu2tttHtLslMcw==
X-Google-Smtp-Source: AGHT+IHDRC/racALxd1eXwE3xn3c9jK9YanWbZMb8jyDxb2Obe1WmlnHvsRWoHqAE0jaTolXTNPkOZdEbGKuTi43e2Y=
X-Received: by 2002:a05:6808:34c:b0:3bf:fcae:17c6 with SMTP id
 j12-20020a056808034c00b003bffcae17c6mr4202570oie.30.1708079077965; Fri, 16
 Feb 2024 02:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zc0IzeM6tAvm1NTl@mtj.duckdns.org> <Zc65DUZKIx5IIgrX@slm.duckdns.org>
 <Zc7uKXZwHdATHyMY@slm.duckdns.org>
In-Reply-To: <Zc7uKXZwHdATHyMY@slm.duckdns.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 16 Feb 2024 11:24:26 +0100
Message-ID: <CADYN=9+-er+j_7MQDrVbs8Kt5zAz5EdEjszeJWuHjP1K1GjWFg@mail.gmail.com>
Subject: Re: [PATCH v2 wq/for-6.9] workqueue, irq_work: Build fix for !CONFIG_IRQ_WORK
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Feb 2024 at 06:10, Tejun Heo <tj@kernel.org> wrote:
>
> 2f34d7337d98 ("workqueue: Fix queue_work_on() with BH workqueues") added
> irq_work usage to workqueue; however, it turns out irq_work is actually
> optional and the change breaks build on configuration which doesn't have
> CONFIG_IRQ_WORK enabled.
>
> Fix build by making workqueue use irq_work only when CONFIG_SMP and enabling
> CONFIG_IRQ_WORK when CONFIG_SMP is set. It's reasonable to argue that it may
> be better to just always enable it. However, this still saves a small bit of
> memory for tiny UP configs and also the least amount of change, so, for now,
> let's keep it conditional.
>
> Verified to do the right thing for x86_64 allnoconfig and defconfig, and
> aarch64 allnoconfig, allnoconfig + prink disable (SMP but nothing selects
> IRQ_WORK) and a modified aarch64 Kconfig where !SMP and nothing selects
> IRQ_WORK.
>
> v2: `depends on SMP` leads to Kconfig warnings when CONFIG_IRQ_WORK is
>     selected by something else when !CONFIG_SMP. Use `def_bool y if SMP`
>     instead.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 2f34d7337d98 ("workqueue: Fix queue_work_on() with BH workqueues")
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> Hello,
>
> Unfortunately, the previous patch triggers Kconfig warnings when IRQ_WORK is
> selected by something else but !CONFIG_SMP. This one seems to do the right
> thing in all cases.
>
> Naresh, Anders, can you please test it again?

I applied this patch on yesterdays next tag next-20240215 and I was able to
build the arm64 tinyconfig.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

>
> Thanks.
>
>  init/Kconfig       |  2 +-
>  kernel/workqueue.c | 24 +++++++++++++++---------
>  2 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 8df18f3a9748..0d21c9e0398f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -106,7 +106,7 @@ config CONSTRUCTORS
>         bool
>
>  config IRQ_WORK
> -       bool
> +       def_bool y if SMP
>
>  config BUILDTIME_TABLE_SORT
>         bool
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 04e35dbe6799..6ae441e13804 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1209,6 +1209,20 @@ static struct irq_work *bh_pool_irq_work(struct worker_pool *pool)
>         return &per_cpu(bh_pool_irq_works, pool->cpu)[high];
>  }
>
> +static void kick_bh_pool(struct worker_pool *pool)
> +{
> +#ifdef CONFIG_SMP
> +       if (unlikely(pool->cpu != smp_processor_id())) {
> +               irq_work_queue_on(bh_pool_irq_work(pool), pool->cpu);
> +               return;
> +       }
> +#endif
> +       if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
> +               raise_softirq_irqoff(HI_SOFTIRQ);
> +       else
> +               raise_softirq_irqoff(TASKLET_SOFTIRQ);
> +}
> +
>  /**
>   * kick_pool - wake up an idle worker if necessary
>   * @pool: pool to kick
> @@ -1227,15 +1241,7 @@ static bool kick_pool(struct worker_pool *pool)
>                 return false;
>
>         if (pool->flags & POOL_BH) {
> -               if (likely(pool->cpu == smp_processor_id())) {
> -                       if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
> -                               raise_softirq_irqoff(HI_SOFTIRQ);
> -                       else
> -                               raise_softirq_irqoff(TASKLET_SOFTIRQ);
> -               } else {
> -                       irq_work_queue_on(bh_pool_irq_work(pool), pool->cpu);
> -               }
> -
> +               kick_bh_pool(pool);
>                 return true;
>         }
>
> --
> 2.43.2
>

