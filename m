Return-Path: <linux-kernel+bounces-149180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFFE8A8CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64CD1F22390
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C786C39AF2;
	Wed, 17 Apr 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB+L2ySp"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C263383AC;
	Wed, 17 Apr 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385783; cv=none; b=uf8Lg7ZIvlI+Jc9oIUsVRc+VKlyAsf9rInhaX/vaexNSubxsw95nSq91DTY3clEDaXgnV5YcaCBNN1pM3RvtpXBvgQ5eSGVL1jBtnixJLHZeaU6as8fLXqfGNz3aV6trEigGNYA1qDy37azhpQ83SeRReWrbw3b/Dr+MmTf0+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385783; c=relaxed/simple;
	bh=zp+2lX/d6oVVhftQC2UTZQ3BHON2MZJoJRY+xRflaV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3csEly8wgoSxZ3ZMe2n0QykDgEWdBudcq1UtF2DFJuIcj3jSKuXyDZ3ap6+DcFJfc2a4eoRkvOAnwLrIJmUoK8iMwA+aeZVbY6LRV7GdQxlIewRrfoGTkT4pXy2vwNfHMzj6hvRScyOlHteHOZJTl04L805fRV+mJfntS2Dczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB+L2ySp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-415515178ceso1444305e9.0;
        Wed, 17 Apr 2024 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713385780; x=1713990580; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xLbl6gmY0vXVsSj+r8Cg2zhwxGnV7jPWT6o5rHerPX4=;
        b=SB+L2ySpCkwL/vMwaIZBJcyHnc0u04wwrZk4vQiUa8oAESnZDxbmdqeSNorp28CIf+
         F+HkxCQj4nWw8YBI1cGDDbsQkqjmVqMgjMAclqkf0v+oxQwuXITWWHnC7Gd48XdvKhnK
         w9LxvoRksd+4HbfjrfsCdF5b/QS9X/23+0SNygowHPFTXed2NZq27gKtcKsl5c0OKix6
         MLIzagm+6gnOfMxO7YYtL5kx/paAyPDFwvB1uPvpfrt0MwGKuxuteKk2uXPD+fpLb0Tn
         lyYgSH+qwFi+naPbBUP/5G35QTX2SienjnLlyMKfrNiy0OCCYd83VbYJMddcUfURGAtg
         mTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713385780; x=1713990580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLbl6gmY0vXVsSj+r8Cg2zhwxGnV7jPWT6o5rHerPX4=;
        b=LF71glLC2vbISs57zKHMjU06ZmC2aZzv54LMV+nQltCaoNj5OmsFPiv5KVNaE5S1y6
         zoJGeFnB2A+MVB/OT74AUmI+eYd3xfttCye88exSl83pJ0eNAVtA/Hc4SyTVkJcR3/2X
         d70c1PhO2jAJy5CteQFRDhFOPA5v99VffkXPyzosa1DHtM5iNhWNFtPZ8p1KTxzc7eJH
         qwJIHnY1vaKux3naCDBk5TonLpgolmVPCIiwVBV6biSw3SyV8KROX69lootcU3YpH8JL
         1uWpDEeolTc4AM3DYhsiMc3O0+W3ZPbKrTHCEc22vAs+hHGhxWYSyxFkZf7mX+TFSW21
         FsKA==
X-Forwarded-Encrypted: i=1; AJvYcCVJnW6nHKbnVNzhmbUfClvqtRiEg7+XkUrHwPOWLCENv1r+ahGMrZoIJPs26EF5X/03/+MT7dOMNWsA/0QWJppUUixsutlKKX0ov9nJH/SFFpHqPU5m3ceRDlWOFuEihIGzJtVrwga6nrW6UxLsASSCHyAV4MwjfIXkFt73AlIBWIvIlg==
X-Gm-Message-State: AOJu0Ywgqd+Y+g/vAlIXSXxtIjMFVWswzhHpAP85uiSa69JDJa0NHi2V
	EDdf+KNxp1A1cEXx8TtaUTOnGnSnFVBfoK+t1hUnT96DarY+Pt4B
X-Google-Smtp-Source: AGHT+IEjAEBDHtn0xnmdyswaIyJaWejZ3w9BRDdqRqJOXBK95QmKvna74oahKQCvTJrzjxZM33Xekg==
X-Received: by 2002:a05:600c:35c3:b0:418:d220:dfbd with SMTP id r3-20020a05600c35c300b00418d220dfbdmr528567wmq.23.1713385779332;
        Wed, 17 Apr 2024 13:29:39 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm31986wrs.53.2024.04.17.13.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:29:38 -0700 (PDT)
Date: Wed, 17 Apr 2024 22:29:36 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20240417202936.GA148552@debian>
References: <20240301111124.29283-1-dima.fedrau@gmail.com>
 <20240301111124.29283-3-dima.fedrau@gmail.com>
 <s256onwsfw2mfdlkeb42j5jucejogxinioumpkklrtd57icwrx@5uaqlj6z2i5h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s256onwsfw2mfdlkeb42j5jucejogxinioumpkklrtd57icwrx@5uaqlj6z2i5h>

Am Tue, Mar 19, 2024 at 05:35:41PM +0100 schrieb Uwe Kleine-König:
> Hello Dimitri,
>
Hi Uwe,

thanks for reviewing and sorry for the late reply.

> On Fri, Mar 01, 2024 at 12:11:23PM +0100, Dimitri Fedrau wrote:
> > diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> > new file mode 100644
> > index 000000000000..35753039da6b
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-mc33xs2410.c
> > @@ -0,0 +1,324 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> > + */
> 
> Please document the general behaviour of the device here. For that
> please stick to the format used in other drivers such that
> 
> 	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c
> 
> does the right thing for your driver.
>
Will add the description and limitations in the next version of the
driver.

> > +
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/pwm.h>
> > +
> > +#include <asm/unaligned.h>
> > +
> > +#include <linux/spi/spi.h>
> > +
> > +#define MC33XS2410_GLB_CTRL		0x00
> > +#define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
> > +#define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)
> > +#define MC33XS2410_GLB_CTRL_SAFE_MODE	BIT(7)
> > +#define MC33XS2410_OUT1_4_CTRL		0x02
> > +#define MC33XS2410_PWM_CTRL1		0x05
> > +#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
> > +#define MC33XS2410_PWM_CTRL3		0x07
> > +#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x))
> 
> Maybe add the valid range for x here. Something like:
> 
> #define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x)) /* x in {0 ... 3} */
>
Ok.

> > +#define MC33XS2410_PWM_CTRL3_EN_MASK	GENMASK(7, 4)
> 
> MC33XS2410_PWM_CTRL3_EN_MASK is unused.
> 
Will remove it.

> > +#define MC33XS2410_PWM_FREQ1		0x08
> > +#define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x))
> 
> Huh, is it expected that MC33XS2410_PWM_FREQ(1) != MC33XS2410_PWM_FREQ1?
> I guess the hardware manual numbers these registers from 1 .. max but
> you're passing hwpwm which starts at 0? Hmm.
> 
> I think I'd use:
> 
> #define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x) - 1)
> 
> and pass hwpwm + 1.
> 
Ok.

> > +#define MC33XS2410_PWM_FREQ_STEP_MASK	GENMASK(7, 6)
> > +#define MC33XS2410_PWM_FREQ_MASK	GENMASK(5, 0)
> > +#define MC33XS2410_PWM_DC1		0x0c
> > +#define MC33XS2410_PWM_DC(x)		(MC33XS2410_PWM_DC1 + (x))
> > +#define MC33XS2410_WDT			0x14
> > +
> > +#define MC33XS2410_IN_OUT_STA		0x01
> > +#define MC33XS2410_IN_OUT_STA_OUT_EN(x)	BIT(4 + (x))
> > +
> > +#define MC33XS2410_WR_FLAG		BIT(7)
> > +#define MC33XS2410_RD_CTRL_FLAG		BIT(7)
> > +#define MC33XS2410_RD_DATA_MASK		GENMASK(13, 0)
> > +
> > +#define MC33XS2410_PERIOD_MAX	0
> > +#define MC33XS2410_PERIOD_MIN	1
> 
> This deserves a comment. (Or drop it after following my suggestion to
> drop mc33xs2410_period[][].)
> 
>
I will drop it.

> > +struct mc33xs2410_pwm {
> > +	struct pwm_chip chip;
> > +	struct spi_device *spi;
> > +	struct mutex lock;
> > +};
> > +
> > +enum mc33xs2410_freq_steps {
> > +	STEP_05HZ,
> > +	STEP_2HZ,
> > +	STEP_8HZ,
> > +	STEP_32HZ,
> > +};
> > +
> > +/*
> > + * When outputs are controlled by SPI, the device supports four frequency ranges
> > + * with following steps:
> > + * - 0.5 Hz steps from 0.5 Hz to 32 Hz
> > + * - 2 Hz steps from 2 Hz to 128 Hz
> > + * - 8 Hz steps from 8 Hz to 512 Hz
> > + * - 32 Hz steps from 32 Hz to 2048 Hz
> > + * Below are the minimum and maximum frequencies converted to periods in ns for
> > + * each of the four frequency ranges.
> > + */
> > +static const u32 mc33xs2410_period[4][2] = {
> > +	[STEP_05HZ] = { 2000000000, 31250000 },
> > +	[STEP_2HZ] = { 500000000, 7812500 },
> > +	[STEP_8HZ] = { 125000000, 1953125 },
> > +	[STEP_32HZ] = { 31250000, 488281 },
> > +};
> > +
> > +static struct mc33xs2410_pwm *mc33xs2410_pwm_from_chip(struct pwm_chip *chip)
> > +{
> > +	return container_of(chip, struct mc33xs2410_pwm, chip);
> > +}
> > +
> > +static int mc33xs2410_write_reg(struct spi_device *spi, u8 reg, u8 val)
> > +{
> > +	u8 tx[2];
> > +
> > +	tx[0] = reg | MC33XS2410_WR_FLAG;
> > +	tx[1] = val;
> > +
> > +	return spi_write(spi, tx, 2);
> > +}
> > +
> > +static int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, bool ctrl)
> > +{
> > +	u8 tx[2], rx[2];
> > +	int ret;
> > +
> > +	tx[0] = reg;
> > +	tx[1] = ctrl ? MC33XS2410_RD_CTRL_FLAG : 0;
> > +
> > +	ret = spi_write(spi, tx, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = spi_read(spi, rx, 2);
> > +	if (ret < 0)
> > +		return ret;
> 
> This could benefit from using spi_write_then_read().
> 
The device needs the chip select to go inactive after two bytes are
transmitted. I could go for spi_sync_transfer and set cs_change in the
first spi_transfer to 1 to get this done.

> > +
> > +	return FIELD_GET(MC33XS2410_RD_DATA_MASK, get_unaligned_be16(rx));
> > +}
> > +
> > +static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg)
> > +{
> > +	return mc33xs2410_read_reg(spi, reg, true);
> > +}
> > +
> > +static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
> > +{
> > +	int ret;
> > +
> > +	ret = mc33xs2410_read_reg_ctrl(spi, reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret &= ~mask;
> > +	ret |= val & mask;
> > +
> > +	return mc33xs2410_write_reg(spi, reg, ret);
> > +}
> > +
> > +static int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg)
> > +{
> > +	return mc33xs2410_read_reg(spi, reg, false);
> > +}
> > +
> > +static u8 mc33xs2410_pwm_get_freq(const struct pwm_state *state)
> > +{
> > +	u32 period, freq, max, min;
> > +	int step;
> > +	u8 ret;
> 
> When reading "ret" I'd expect this to be an integer representing an
> error code. Maybe call it "freq" instead?
> 
Ok.

> > +	period = state->period;
> > +	/*
> > +	 * Check if period is within the limits of each of the four frequency
> > +	 * ranges, starting with the highest frequency(lowest period). Higher
> > +	 * frequencies are represented with better resolution by the device.
> > +	 */
> > +	for (step = STEP_32HZ; step >= STEP_05HZ; step--) {
> > +		min = mc33xs2410_period[step][MC33XS2410_PERIOD_MIN];
> > +		max = mc33xs2410_period[step][MC33XS2410_PERIOD_MAX];
> > +		if ((period <= max) && (period >= min))
> > +			break;
> > +	}
> 
> Given that mc33xs2410_period[step][0] is 2000000000 >> (2 * step) and
> mc33xs2410_period[step][1] = 31250000 >> (2 * step), this can be
> calculated without a loop.
> 
> Something like:
> 
> 	step = (fls((31250000 - 1) / period) + 1) / 2
> 
> or given there are only four options this can also be done as follows:
> 
> 	switch (period) {
> 		case 488281 .. 31250000:
> 			step = 3;
> 			break;
> 		case 31250001 .. 125000000:
> 			...
> 	}
>
> which gives the compiler a real chance to implement it efficiently. Also
> then you could drop mc33xs2410_period[][].
>
I would stick to the switch and drop mc33xs2410_period[][].

> > +	freq = DIV_ROUND_CLOSEST(max, period) - 1;
> > +	ret = FIELD_PREP(MC33XS2410_PWM_FREQ_MASK, freq);
> > +	return (ret | FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step));
> 
> Also using DIV_ROUND_CLOSEST smells wrong. Did you test with PWM_DEBUG
> enabled?
> 
At least I enabled it and tested some cases. But I think
DIV_ROUND_CLOSEST is what I want. The device is able to generate
frequencies in four frequency ranges with different steps of resolution.
I want to minimize the error introduced by this approach. When a user
wants to set 1041 Hz, the device is not able to generate this frequency.
It is able to generate 1024 Hz or 1056Hz and 1024 Hz is more accurate,
which hopefully can be accomplished with DIV_ROUND_CLOSEST.

> > +}
> > +
> > +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				const struct pwm_state *state)
> > +{
> > +	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
> > +	struct spi_device *spi = mc33xs2410->spi;
> > +	u8 mask, val;
> > +	int ret;
> > +
> > +	if (state->period > mc33xs2410_period[STEP_05HZ][MC33XS2410_PERIOD_MAX])
> > +		return -EINVAL;
> 
> Please make this:
> 
> 	u64 period = min(state->period, mc33xs2410_period[STEP_05HZ][MC33XS2410_PERIOD_MAX]);
>
Ok.
> > +
> > +	if (state->period < mc33xs2410_period[STEP_32HZ][MC33XS2410_PERIOD_MIN])
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&mc33xs2410->lock);
> 
> Huh, didn't know this syntax for locking. Interesting. However with the
> pending changes for the next merge window, calls to .apply() are
> serialized per chip already by the core, so you don't need locking.
> 
Ok.

> > +	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
> > +	val = (state->polarity == PWM_POLARITY_INVERSED) ? mask : 0;
> > +	ret = mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL1, mask, val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = mc33xs2410_write_reg(spi, MC33XS2410_PWM_FREQ(pwm->hwpwm),
> > +				   mc33xs2410_pwm_get_freq(state));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = mc33xs2410_write_reg(spi, MC33XS2410_PWM_DC(pwm->hwpwm),
> > +				   pwm_get_relative_duty_cycle(state, 255));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
> > +	val = (state->enabled) ? mask : 0;
> > +	return mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL3, mask, val);
> 
> Is this procedure atomic? Or can it happen that the output pin does
> something that is neither the old nor the new state in between?
> 
It is not atomic and I didn't find any information in the datasheet how
to achieve this. Data is taken and valid only after the chip select is
going inactive after each write transaction. Write transactions can't be
bundled to make it atomic, not documented, but I still tried it without
success. It is possible that the output pin does something that is
neither the old nor the new state. At least this is what I see on my
scope. Tested it with the lowest frequency 0.5Hz.

> Maybe it's worth the effort doing that in a single spi transfer, both to
> make the procedure quicker and (maybe?) atomic.
> 
I could go for spi_sync_transfer with multiple transfers which change
chip select. This could maybe improve the procedure a little bit.

> > +}
> > +
> > +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> > +				    struct pwm_device *pwm,
> > +				    struct pwm_state *state)
> > +{
> > +	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
> > +	struct spi_device *spi = mc33xs2410->spi;
> > +	u32 freq, code, steps;
> > +	int ret;
> > +
> > +	guard(mutex)(&mc33xs2410->lock);
> > +	ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_CTRL1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	state->polarity = (ret & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
> > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +
> > +	ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_FREQ(pwm->hwpwm));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Lowest frequency steps are starting with 0.5Hz, scale them by two. */
> > +	steps = (FIELD_GET(MC33XS2410_PWM_FREQ_STEP_MASK, ret) * 2) << 1;
> 
> You're multiplying by 2 twice here. I fail to follow.
> 
steps:
  - 0 = 0.5Hz
  - 1 = 2Hz
  - 2 = 8Hz
  - 3 = 32Hz
frequency = (code + 1) x steps

To avoid division in case steps is zero, I scale steps value by two
keeping in mind that I doubled the frequency. This is important when
calculating the period. I will document this properly in next version of
the driver.

> > +	code = FIELD_GET(MC33XS2410_PWM_FREQ_MASK, ret);
> > +	/* Frequency = (code + 1) x steps */
> > +	freq = (code + 1) * steps;
> > +	/* Convert frequency to period in ns, considering scaled steps value. */
> > +	state->period = 2000000000ULL / (freq);
> 
> Please make 2000000000ULL a define. This can then be used also in the
> calculations that currently involve mc33xs2410_period[][].
> 
Ok.
> Also you need to round up here.
> 
Ok.
> > +	ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_DC(pwm->hwpwm));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = pwm_set_relative_duty_cycle(state, ret, 255);
> > +	if (ret)
> > +		return ret;
> 
> Pretty sure this is also wrong and fails if you enable PWM_DEBUG.
> 
Yes, you are right. Would go for:
pwm_set_relative_duty_cycle(state, ret + 1, 256);

> > +	ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_IN_OUT_STA);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	state->enabled = !!(ret & MC33XS2410_IN_OUT_STA_OUT_EN(pwm->hwpwm));
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops mc33xs2410_pwm_ops = {
> > +	.apply = mc33xs2410_pwm_apply,
> > +	.get_state = mc33xs2410_pwm_get_state,
> > +};
> > +
> > +static int mc33xs2410_reset(struct device *dev)
> > +{
> > +	struct gpio_desc *reset_gpio;
> > +
> > +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR_OR_NULL(reset_gpio))
> > +		return PTR_ERR_OR_ZERO(reset_gpio);
> > +
> > +	fsleep(1000);
> > +	gpiod_set_value_cansleep(reset_gpio, 0);
> > +	/* Wake-up time */
> > +	fsleep(10000);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mc33xs2410_probe(struct spi_device *spi)
> > +{
> > +	struct mc33xs2410_pwm *mc33xs2410;
> > +	struct device *dev = &spi->dev;
> > +	int ret;
> > +
> > +	mc33xs2410 = devm_kzalloc(&spi->dev, sizeof(*mc33xs2410), GFP_KERNEL);
> 
> After struct device *dev = &spi->dev you could better use dev here
> instead of &spi->dev.
>
Ok.

> > +	if (!mc33xs2410)
> > +		return -ENOMEM;
> 
> Please use devm_pwmchip_alloc(). See
> 11ee0a124cb48bb837a1d90c3504a9c3376e96d1 for a simple example to copy
> from.
>
Ok.

> > +	mc33xs2410->chip.dev = dev;
> > +	mc33xs2410->chip.ops = &mc33xs2410_pwm_ops;
> > +	mc33xs2410->chip.npwm = 4;
> > +	mc33xs2410->spi = spi;
> > +	mutex_init(&mc33xs2410->lock);
> > +
> > +	ret = mc33xs2410_reset(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Disable watchdog */
> > +	ret = mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");
> > +
> > +	/* Transitition to normal mode */
> 
> s/Transitition/Transition/
>
Ok.

> > +	ret = mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
> > +				    MC33XS2410_GLB_CTRL_MODE_MASK,
> > +				    MC33XS2410_GLB_CTRL_NORMAL_MODE);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to transition to normal mode\n");
> > +
> > +	ret = devm_pwmchip_add(dev, &mc33xs2410->chip);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct spi_device_id mc33xs2410_spi_id[] = {
> > +	{ "mc33xs2410", 0 },
> 
> driver_data is unused here, please drop it.
>
Ok.

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, mc33xs2410_spi_id);
> > +
> > +static const struct of_device_id mc33xs2410_of_match[] = {
> > +	{ .compatible = "nxp,mc33xs2410" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mc33xs2410_of_match);
> > +
> > +static struct spi_driver mc33xs2410_driver = {
> > +	.driver = {
> > +		.name = "mc33xs2410-pwm",
> > +		.of_match_table = mc33xs2410_of_match,
> > +	},
> > +	.probe = mc33xs2410_probe,
> > +	.id_table = mc33xs2410_spi_id,
> > +};
> > +module_spi_driver(mc33xs2410_driver);
> > +
> > +MODULE_DESCRIPTION("NXP MC33XS2410 high-side switch driver");
> > +MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
> > +MODULE_LICENSE("GPL");
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Best regards
Dimitri

