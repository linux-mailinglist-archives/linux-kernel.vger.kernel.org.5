Return-Path: <linux-kernel+bounces-164956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F7B8B8569
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C31D2813AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB5848CF2;
	Wed,  1 May 2024 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="Y424BfbC"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505704A99C
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714542195; cv=none; b=Ks+YQqr5SGXQLI8UD5t2Vffl7ay8Zy5NnN3UrmbXV9XSYQeVsLsqsB50wpy09S2l17C4NvK3swKhQR/resTjlUA5/6VeD5w9dlzOZlnn3bJXVfccyXQ/MtwmUwp3bAK244f34whnCR1Z2s6OZqleOWocRLydpyOyNeJ5epVBDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714542195; c=relaxed/simple;
	bh=26r+LT/6atmj9opecbx4FJ7PWFVD5JLfAoCCwRN2W1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMp3Tv+RSU9ihtffMrNL1Mts2+z8KXrMWl8+lLNCKxFN7ZXcOIU+aFgeOEcV9hQOjEXQ7xb8G1zbLhyOwmQu6idh91J6DV3Qzl/myIhIOxzaudOGwgnF+JTyCi+fDZvj9sAIKO+xOuKDFhv503kc/vEuxItH6gy3/hszPkO3scM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=Y424BfbC; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Wed, 1 May 2024 15:42:44 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1714542190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0JjuJfRwN3PxzuU5OJDvRQPhrTURiBh6iup5xIVpTE=;
	b=Y424BfbCPAvaTiEHva+EjwrF+C76RSvznwiqdRgCuCqTxRnj4CPCMnZcgRxIj6IJHGoWfH
	QDA+QESm21J7Owl6Nwa43JtUtBul3458OjK+OWjihWPXsis2nkQ35huVIS2GaA+EYM92bo
	pSi6wkVCU6jXLeu40QYL6P5vfcGM/B1CzZr6tFHol2LsuCNthYca4DosTY7W8q/uO1Y0oB
	dsdOKMr7KJobIGPIBnci+tvmJ2r7NGGYg0swk/u4gxbde7uajDO3S8ZtWd1PLIOYmAUHX5
	AVpikoE3IjpRbzcw/aqXp5G6Ink/LHb/tylAKunqkzV7dKkd1tifPeDv+/rSGQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <ZjHWVEbzQ1udTcmQ@titan>
References: <20240131125920.2879433-1-privatesub2@gmail.com>
 <20240131125920.2879433-3-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131125920.2879433-3-privatesub2@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi,

On Wed, Jan 31, 2024 at 03:59:15PM +0300, Aleksandr Shubin wrote:
> +	if (state->polarity != pwm->state.polarity ||
> +	    state->duty_cycle != pwm->state.duty_cycle ||
> +	    state->period != pwm->state.period) {
> +		ctl = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> +		clk_cfg = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm));
> +		hosc_rate = clk_get_rate(sun20i_chip->clk_hosc);
> +		bus_rate = clk_get_rate(sun20i_chip->clk_apb0);
> +		if (pwm_en & SUN20I_PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
> +			/* if the neighbor channel is enable, check period only */
> +			use_bus_clk = FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, clk_cfg) != 0;
> +			val = mul_u64_u64_div_u64(state->period,
> +						  (use_bus_clk ? bus_rate : hosc_rate),
> +						  NSEC_PER_SEC);
> +
> +			div_m = FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, clk_cfg);
> +		} else {
> +			/* check period and select clock source */
> +			use_bus_clk = false;
> +			val = mul_u64_u64_div_u64(state->period, hosc_rate, NSEC_PER_SEC);
> +			if (val <= 1) {
> +				use_bus_clk = true;
> +				val = mul_u64_u64_div_u64(state->period, bus_rate, NSEC_PER_SEC);
> +				if (val <= 1) {
> +					ret = -EINVAL;
> +					goto unlock_mutex;
> +				}
> +			}
> +			div_m = fls(DIV_ROUND_DOWN_ULL(val, SUN20I_PWM_MAGIC));
> +			if (div_m > SUN20I_PWM_CLK_DIV_M_MAX) {
> +				ret = -EINVAL;
> +				goto unlock_mutex;
> +			}
> +
> +			/* set up the CLK_DIV_M and clock CLK_SRC */
> +			clk_cfg = FIELD_PREP(SUN20I_PWM_CLK_CFG_DIV_M, div_m);
> +			clk_cfg |= FIELD_PREP(SUN20I_PWM_CLK_CFG_SRC, use_bus_clk);
> +
> +			sun20i_pwm_writel(sun20i_chip, clk_cfg, SUN20I_PWM_CLK_CFG(pwm->hwpwm));
> +		}

If I'm reading this correctly, for each PWM pair you set the clock once.
Wouldn't this mean that the order of setting PWMs would affect the accuracy?
It would be good to note this down perhaps?

John.

> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

