Return-Path: <linux-kernel+bounces-45052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D259842B18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232251F27CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3011D685;
	Tue, 30 Jan 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiTXz43a"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4D1272DA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636309; cv=none; b=uwqSPf4bXXnThKJLgFr1I/7FQWrB9CmQ2lhxME0z9uhV4PZgYxKgDdXMDbbuYM9jbYplNQ4I6B3nMic0NZI7OgNWJDqybGVINy0UQ2HdIx5gr2w6/77fvXv2rPV+uL2JMdakMHTcjmq1P2r/eDPniBDCKOHe800Au2yq8bTNnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636309; c=relaxed/simple;
	bh=2TbTvOJDPGl5d3FAMeuXChO1S+7u/Pw2Z2DravzPzBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERl/BadkA1q3bIwSbc0VNxX9FdppPLIPtHRDVzrVGW5zHpxLOcmuze2gUMqwsyClC8ONVJE64RekKaYd3AckVxgS6/mBsIQObFDwjrwsr87hSn2hJduIfRInFd6ry4aW3e7YTDT7o0K8ic5pGumlhHB73IkbQlh3TuQH37T0zfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EiTXz43a; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fafced20aso4531985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706636305; x=1707241105; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4pzbZS1rtphhJPpoCmxByVYIAa2guEhJDVA86rKB8OU=;
        b=EiTXz43aw+stFfu8UyFqurZk/sozBETkffT9QL0b2BOc8z/9CuPeQM2k0uji+jepc6
         Gplg6meU8XfcM1UTOBk5TJE9DO1b6BB5ZBLuv+Cudp9CaTav8QmQmziqw4zxaX5UUV/8
         Xs9/YiBQ+etubNQznBJ1DfpHkAZ6Y5mzNvyiPqhOoLbGPlHlmersFDtITpDlToptmKJS
         uKto5eZZXbyww35IsVwckVDjSunbNhGZA8Kyy9UJ0K4XbvNz1QphLIdOVIjmaZKHSCxr
         +0m1y/aKQ0AmiOueNqExPJem7C+OgzmkNUkP7e1r4XU4FdMKqNCl7ZYwFI2C6BcosVPX
         lgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706636305; x=1707241105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pzbZS1rtphhJPpoCmxByVYIAa2guEhJDVA86rKB8OU=;
        b=jDME7I2JGMWe9B/EOTpXnxJJHSpXDYOOeaeBi0RJZ7UHYeTTTtDg2mr3lUK93+LpWN
         lL7yLRoNy+TsjpehJMlfCoS+yOoHho2ok2XguXYRbVJUMzwzCAkmuLTSiOwT7VwrvtCO
         eWWuGWGdTjYXTJMu/7Io5DWH5PTm+xoY7xWcSL9LJy//ROsfr4nZMoqNfHzrQaEgjZNQ
         FyFulC9LyNK508gDFfHJ2/sjcJC7wLlhTI75eZwA+fB7N14HWe8ozqQqkXOpJ5P3Ke5S
         b4uDiVG942WNYUNQ+g4AixeTr2/TMiUYChsZPguoqfT1l5d+GGqFl9flXpT9zgkAWWyh
         LNeQ==
X-Gm-Message-State: AOJu0Yypy+BUFzBGaNiKoK0wlDKaoGNlvQmqXhlmo4W2t7UuBRFNpuzW
	7w8PfsGSbmrN9we8iKauJ3QHis2+Pf70VLybiSKkI3FOSbq40FHCby0lMSqvDi4=
X-Google-Smtp-Source: AGHT+IEaW4n1rmtcE9DmqPQvrMZTDGxN+PVahTKeK5HCkpW0Fmf6FowWbWl2bkSbDWbIWv4Wtg2EUg==
X-Received: by 2002:adf:ee48:0:b0:33a:fce6:4d9d with SMTP id w8-20020adfee48000000b0033afce64d9dmr1640095wro.60.1706636305299;
        Tue, 30 Jan 2024 09:38:25 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:513a:c1da:4bd6:228])
        by smtp.gmail.com with ESMTPSA id by5-20020a056000098500b0033afef9bdfbsm502634wrb.8.2024.01.30.09.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:38:24 -0800 (PST)
Date: Tue, 30 Jan 2024 18:38:22 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
Message-ID: <Zbk0DhibX0oDLk1s@vingu-book>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-9-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208002342.367117-9-qyousef@layalina.io>

Le vendredi 08 déc. 2023 à 00:23:42 (+0000), Qais Yousef a écrit :
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> The new sched_pelt_multiplier boot param allows a user to set a clock
> multiplier to x2 or x4 (x1 being the default). This clock multiplier
> artificially speeds up PELT ramp up/down similarly to use a faster
> half-life than the default 32ms.
> 
>   - x1: 32ms half-life
>   - x2: 16ms half-life
>   - x4: 8ms  half-life
> 
> Internally, a new clock is created: rq->clock_task_mult. It sits in the
> clock hierarchy between rq->clock_task and rq->clock_pelt.
> 
> The param is set as read only and can only be changed at boot time via
> 
> 	kernel.sched_pelt_multiplier=[1, 2, 4]
> 
> PELT has a big impact on the overall system response and reactiveness to
> change. Smaller PELT HF means it'll require less time to reach the
> maximum performance point of the system when the system become fully
> busy; and equally shorter time to go back to lowest performance point
> when the system goes back to idle.
> 
> This faster reaction impacts both dvfs response and migration time
> between clusters in HMP system.
> 
> Smaller PELT values are expected to give better performance at the cost
> of more power. Under powered systems can particularly benefit from
> smaller values. Powerful systems can still benefit from smaller values
> if they want to be tuned towards perf more and power is not the major
> concern for them.
> 
> This combined with respone_time_ms from schedutil should give the user
> and sysadmin a deterministic way to control the triangular power, perf
> and thermals for their system. The default response_time_ms will half
> as PELT HF halves.
> 
> Update approximate_{util_avg, runtime}() to take into account the PELT
> HALFLIFE multiplier.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> [Converted from sysctl to boot param and updated commit message]
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/core.c  |  2 +-
>  kernel/sched/pelt.c  | 52 ++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/pelt.h  | 42 +++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  1 +
>  4 files changed, 90 insertions(+), 7 deletions(-)
> 

..

> +__read_mostly unsigned int sched_pelt_lshift;
> +static unsigned int sched_pelt_multiplier = 1;
> +
> +static int set_sched_pelt_multiplier(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = param_set_int(val, kp);
> +	if (ret)
> +		goto error;
> +
> +	switch (sched_pelt_multiplier)  {
> +	case 1:
> +		fallthrough;
> +	case 2:
> +		fallthrough;
> +	case 4:
> +		WRITE_ONCE(sched_pelt_lshift,
> +			   sched_pelt_multiplier >> 1);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	sched_pelt_multiplier = 1;
> +	return ret;
> +}
> +
> +static const struct kernel_param_ops sched_pelt_multiplier_ops = {
> +	.set = set_sched_pelt_multiplier,
> +	.get = param_get_int,
> +};
> +
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +/* XXX: should we use sched as prefix? */
> +#define MODULE_PARAM_PREFIX "kernel."
> +module_param_cb(sched_pelt_multiplier, &sched_pelt_multiplier_ops, &sched_pelt_multiplier, 0444);
> +MODULE_PARM_DESC(sched_pelt_multiplier, "PELT HALFLIFE helps control the responsiveness of the system.");
> +MODULE_PARM_DESC(sched_pelt_multiplier, "Accepted value: 1 32ms PELT HALIFE - roughly 200ms to go from 0 to max performance point (default).");
> +MODULE_PARM_DESC(sched_pelt_multiplier, "                2 16ms PELT HALIFE - roughly 100ms to go from 0 to max performance point.");
> +MODULE_PARM_DESC(sched_pelt_multiplier, "                4  8ms PELT HALIFE - roughly  50ms to go from 0 to max performance point.");
> +
>  /*
>   * Approximate the new util_avg value assuming an entity has continued to run
>   * for @delta us.

..

> +
>  static inline void
> -update_rq_clock_pelt(struct rq *rq, s64 delta) { }
> +update_rq_clock_task_mult(struct rq *rq, s64 delta) { }
>  
>  static inline void
>  update_idle_rq_clock_pelt(struct rq *rq) { }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index bbece0eb053a..a7c89c623250 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1029,6 +1029,7 @@ struct rq {
>  	u64			clock;
>  	/* Ensure that all clocks are in the same cache line */
>  	u64			clock_task ____cacheline_aligned;
> +	u64			clock_task_mult;

I'm not sure that we want yet another clock and this doesn't apply for irq_avg.

What about the below is simpler and I think cover all cases ?

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index f951c44f1d52..5cdd147b7abe 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -180,6 +180,7 @@ static __always_inline int
 ___update_load_sum(u64 now, struct sched_avg *sa,
 		  unsigned long load, unsigned long runnable, int running)
 {
+	int time_shift;
 	u64 delta;

 	delta = now - sa->last_update_time;
@@ -195,12 +196,17 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	/*
 	 * Use 1024ns as the unit of measurement since it's a reasonable
 	 * approximation of 1us and fast to compute.
+	 * On top of this, we can change the half-time period from the default
+	 * 32ms to a shorter value. This is equivalent to left shifting the
+	 * time.
+	 * Merge both right and left shifts in one single right shift
 	 */
-	delta >>= 10;
+	time_shift = 10 - sched_pelt_lshift;
+	delta >>= time_shift;
 	if (!delta)
 		return 0;

-	sa->last_update_time += delta << 10;
+	sa->last_update_time += delta << time_shift;

 	/*
 	 * running is a subset of runnable (weight) so running can't be set if



>  	u64			clock_pelt;
>  	unsigned long		lost_idle_time;
>  	u64			clock_pelt_idle;
> -- 
> 2.34.1
> 

