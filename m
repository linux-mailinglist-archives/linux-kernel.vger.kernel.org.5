Return-Path: <linux-kernel+bounces-149250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 877628A8DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449BD281B71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA54EB4A;
	Wed, 17 Apr 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kQbXVRXr"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309A262A3;
	Wed, 17 Apr 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389002; cv=none; b=i0s+odMnVhx0Odc8ZM6RxGueKSbJnIHxnJJrcnU9L4dOVvzif6+e5gqoc84kx5FAEiZJqLeVLpgwASBJpzZGSyHBOkN8o10OO6gWzPkorMTqW72yg3EAbkgOUP3Jf60PUgpT/0WG4/gE+7uwz8nHJ6kzBTx9zLs276LssaLPvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389002; c=relaxed/simple;
	bh=QwsdULUOFpSfkWJwfLlDh/Uo9khog5g5YIijWzBDQXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0/IRZ8V+CeSnzpbTty7zbvOkiKJ+i1qT3HqGx/6tlG4XvZouDZYLF0JWF2W8IZr+GI0Mj4vP+dHeY/vC8Q/8g8I8EoaKB4RmSTGGpIyKFW6I32Um9zA3RSdii/Bam1cNgSrr4ZWrrGZ6Ohh1+0XjsUa4udNKNHy2cw2mWZAgQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kQbXVRXr; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C72C4C4CDE;
	Wed, 17 Apr 2024 21:23:11 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E55AFF805;
	Wed, 17 Apr 2024 21:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713388989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4bcE3MlKnmkh1Cz6xEGvKJorSTkrDbZdvsUWJ7Scijw=;
	b=kQbXVRXrMuE+5icdV3JltyyDK1g4pc41WURe7uRuhsHLQnFbzap2Y/IHiYEvnNCSiIEGIL
	kUUiBAvqmBhaIbknD2OdKyDyDoZQ8SQERJQ1ZDg/dlDEMDcroUKveBCVBXtg3XrJ3/AxIg
	wXcYF+n7O4d4GOLG0pdeeDAa5Dxze6GX75LsT9zKYNFOa+7pKRtMRKEWirP8nEoO5H7Dxr
	Zmk4P7OfHhF04Zc7+anCfuiXMNejVbg9LX1DZPxNqv7qXcBX5iji4qQH8GPauO/jpoAt1D
	I9ME4HhsxAOvUztQCwidHasagWcJThXHo1QnMs6Gzaf7/49NsoTlGzFdh4wO+Q==
Date: Wed, 17 Apr 2024 23:23:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlan@gentoo.org, inochiama@outlook.com
Subject: Re: [PATCH v8 2/2] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Message-ID: <202404172121325952016a@mail.local>
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
 <20240204044143.415915-3-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204044143.415915-3-qiujingbao.dlmu@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 04/02/2024 12:41:43+0800, Jingbao Qiu wrote:
> +#define REG_ENABLE_FUN         BIT(0)
> +#define REG_DISABLE_FUN        0x00UL

I don't feel like these two macros make your code clearer, you should
probably simply use 0 and 1 in the proper locations.

> +static irqreturn_t cv1800_rtc_irq_handler(int irq, void *dev_id)
> +{
> +	struct rtc_device *rtc = dev_id;
> +
> +	rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);

I'm pretty sure this would result in a crash...

> +
> +	return IRQ_HANDLED;
> +}
> +
> +	ret = devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_handler,
> +			       IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);

.. you probably want to use rtc->rtc_dev here to fix this.

This also means that you have to request the irq late, else you are open
t a race condition anyway.

> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot register interrupt handler\n");
> +

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

