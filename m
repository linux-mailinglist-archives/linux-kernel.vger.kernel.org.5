Return-Path: <linux-kernel+bounces-145004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC488A4E04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEECF1C20E67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C06064CEF;
	Mon, 15 Apr 2024 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hTWESPEz"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A74E1C9;
	Mon, 15 Apr 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181734; cv=none; b=QcmI59SP4+UCfhQ6htnEjGXx5dCCSJb1uRw4Y3AT77VsjEODQlFNmt9VXQHmhv/szqnXdSkTlTKhcmvts5NmdKtS6PSImohLknYtl36mDrJpUsa+bIlLu44RFNnRrZMg7uplu6oM4Ox13wNC4U6dz2O0vySz8qvtaJVolPOsdIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181734; c=relaxed/simple;
	bh=eET1pX9I1cdrhU3c46Ss84IQIxFOX+xYeTVK4Qtj68o=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MWRR3YQUsMuXEPPZPR1J7/Ia8Zv+8M0TYFT7pDiMHIEcjyzsgam7az4EleWV9TvfIkfmjJqxiOeLiBVM3gsWDaY8y/1b8ydtR9Zrxr2bLxOM/P4Z1Utn7RN2MnFW/FIpcvuo6M9YTyffm4WZVw0L0tG3anJ8d+je8Hlv+8rfoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hTWESPEz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E09C8C0005;
	Mon, 15 Apr 2024 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713181729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHFzrlLFn4E1ExYOjEZ9nCG7yBy5rx/gtcDIhxkwf64=;
	b=hTWESPEzV9xVD9Q+wMDkau2rPvUPdmuiyZ6O3MBPlHaTgXpNpDJ4OA1hrr1XvjZ+ub5NkR
	49r8eQUbSd2w9nB4Xzlfe5kwmrWB6Jr6LVsuRel7mO3jJWreOBg7qh1PPMh0OgYgiCWVYE
	1ZgjoAGwgkM88blAik+YLtkNfZa92iaZnlIYlcMMlrbe1U0rMruQBAr636aj1wZTDbHZJB
	dITN890v6oSkUGEd5rkLayad6YXeX0SRS3xo6wHC3avpvA4+qbnqZQqRjkO9oucAANQsQH
	lvlumYo8Rlgeb6y/q7JnpBJGoqdVfsi8yoFKtjh2vEEfoIm4P6i80EjDDwiUWA==
Message-ID: <9f8a584c-03a7-437e-96a7-56484523b2e4@bootlin.com>
Date: Mon, 15 Apr 2024 13:48:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jszhang@kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
 robh+dt@kernel.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, wefu@redhat.com,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231005130519.3864-3-jszhang@kernel.org>
Subject: Re: [PATCH v3 2/2] pwm: add T-HEAD PWM driver
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <20231005130519.3864-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com

 > T-HEAD SoCs such as the TH1520 contain a PWM controller used
 > to control the LCD backlight, fan and so on. Add driver for it.
 >
 > Signed-off-by: Jisheng Zhang <jszhang@kernel.org > ---

Hello,
I've just tested your driver and it works flawlessly on the 
BeagleV-Ahead with the last mainline kernel. However, I had to modify 
some portion of the code to comply with the last kernel needs.

 > +static const struct pwm_ops thead_pwm_ops = {
 > +    .apply = thead_pwm_apply,
 > +    .get_state = thead_pwm_get_state,
 > +    .owner = THIS_MODULE,

Since commit 384461abcab6, the owner of a pwm_ops structure is implicit 
and so, you can (must) remove this last line now.

 > +};
 > ...
 > +static int thead_pwm_probe(struct platform_device *pdev)
 > +{
 > +    struct thead_pwm_chip *priv;
 > +    int ret, i;
 > +    u32 val;
 > +
 > +    priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 > +    if (!priv)
 > +        return -ENOMEM;
 > +
 > +    platform_set_drvdata(pdev, priv);
 > +
 > +    priv->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 > +    if (IS_ERR(priv->mmio_base))
 > +        return PTR_ERR(priv->mmio_base);
 > +
 > +    priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 > +    if (IS_ERR(priv->clk))
 > +        return PTR_ERR(priv->clk);
 > +
 > +    priv->chip.ops = &thead_pwm_ops;
 > +    priv->chip.dev = &pdev->dev;
 > +    priv->chip.npwm = THEAD_PWM_MAX_NUM;
 > +
 > +    /* check whether PWM is ever started or not */
 > +    for (i = 0; i < priv->chip.npwm; i++) {
 > +        val = readl(priv->mmio_base + THEAD_PWM_FP(i));
 > +        if (val)
 > +            priv->channel_ever_started |= 1 << i;

					     BIT(i) ?
If the bootloader starts a PWM channel for some reason, it will not be 
referenced by the PM usage counter, I added this line in the if 
statement to counter this problem :
		pm_runtime_get(&pdev->dev);

 > +    }
 > +
 > +    ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
 > +    if (ret)
 > +        return ret;
 > +
 > +    devm_pm_runtime_enable(&pdev->dev);
 > +
 > +    return 0;
 > +}


Thank you for your work. With the above comments addressed:

Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Do you plan to send out a new iteration of this patch soon ?

Best regards,
Thomas Bonnefille

