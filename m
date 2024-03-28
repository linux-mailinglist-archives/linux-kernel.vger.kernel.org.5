Return-Path: <linux-kernel+bounces-122961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1032A89005F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C531F25D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C737EF04;
	Thu, 28 Mar 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ls7eTJPH"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5A7F7CE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633006; cv=none; b=t4SvjsEFgl3PkfCPG1wxcfx/HpThifC5E4UIPaDhzojibVjRuxn8r+4xfMNgoFqxYasKP0O3Oe/rnD29e5+57GEzAPLuk6K5tpwUpS6vUXnkcrygyMUQa5iNQTqSRNsLg41qbYl1gLL2w+gUmQYfGnBhrpojk3g3MV5zoYCo2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633006; c=relaxed/simple;
	bh=ImeiQvEeK4vVx6wgVtnrIyHLe/KlQ6pY3d5ytHEwbuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzLue6LRJ+AaTo7qAI6wE5gcLxIKszEegCzuS/ViRKHsxNUtYx6W+TcCMJk8me0We9/3TG2iDx0U1XVv9GtBJjnr2CbK+FhVY+U8enO1XdarXxOf7WFDAUGz+uAgwA70KFrPqKSjt5cMktQLgLd2A5J71PH9FZscRU/aG+nt25c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ls7eTJPH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-415446af364so3729575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711633003; x=1712237803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1IePTNqHmG2u8C44qjEuGkD7ttbOGPgyCjA8yYZ50bc=;
        b=ls7eTJPHiC5L1ZjnEH3HxkoCDdjo5ndDi1hffwr+ln8UC6/VVTXLl5uBXEmaTVLzgc
         Qr8DFzXBRBWD3p7ft7QK7UG04VmXtnrxglgvoPjaYnjxyTcSdNNJ/95EN1g1LJlUbowV
         D8wxtc8u01Qc/x8b+WBRvIY7yHEVRSn1pTK0CoTJxnyXuE8BB2auCZOtVkryoAlk+Zsp
         McMfvBtcnQSqXNrCY0heLEWB+B2fOAWt3SlXamPM4SB0COYbsO2bWXKJdNiIZMwo+xFb
         FUQSGqPve5UK2g+YiCMoTm3/shvejOQYmJQlEgHOODwm2TdDdcjcceGpGHQU4KTs+YgB
         Rizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633003; x=1712237803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IePTNqHmG2u8C44qjEuGkD7ttbOGPgyCjA8yYZ50bc=;
        b=MNovGTE6oEamjO387MyfGQve1lrUaOVH4122dm42XmksCqnfXumQ4CDpyZm9EXUg9x
         /yO82Okw3C5cT5G9kwua3Jv9BmEZ2eKtCAjluGdZajkubuxGMPJo+UgKacNWVms+dPzB
         qz7YvfTc7PFWvG+8Xclm11Qg1A3x+fjVzIC55vFtq1huTC5Tgw7bLisSUoCLupvt1BfK
         T6Cj2OEd7UxIf/akx2JdKYkzVWzMrOI1ZMqsKskTVBhTKLKYjmqRRfqGzfxRDLcUzryZ
         dW0CrMQpuD2FVz6+6K/1+f26EcXkrp0CtKRdpPoOP9VQfoh70fMplQhc9UZAmLTD7LN+
         5acA==
X-Forwarded-Encrypted: i=1; AJvYcCWhYkWB/qs6+kknZoCoMXZ+j6nFDpTuVmFlBoFtsMCgAPP0N1aElQqqcEBef1CVLQh+UD6V5A7z5cMFWRUHQ/cFu8pyrRwxCXa0j4tN
X-Gm-Message-State: AOJu0YzkL1nWeQx74GhOirPkf6404MLBp1Sj5wo8kjCupYKF7SWSxTaJ
	E0MrljHHx7NgD+Jukx/rAf8Gu2ogtZDFZFi/171wKceDXfZ9VSCmEm3Nvn8IGYA=
X-Google-Smtp-Source: AGHT+IEqy69lfejNCICnEF+Lz3j5+RW5/EqlqxH994OBXzrzmpwHtFr1ILfHmp+nOsj3wq2bEQxAVA==
X-Received: by 2002:adf:e6cb:0:b0:343:343f:85da with SMTP id y11-20020adfe6cb000000b00343343f85damr886818wrm.33.1711633002735;
        Thu, 28 Mar 2024 06:36:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05600c0c8300b00414896b61e4sm5493647wmb.16.2024.03.28.06.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 06:36:42 -0700 (PDT)
Message-ID: <6b691a48-ca97-4f23-a09f-69b9254f0c11@linaro.org>
Date: Thu, 28 Mar 2024 14:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH REVIEW] hwrng: add exynos Secure World RNG device driver
To: Alexey Klimov <alexey.klimov@linaro.org>, olivia@selenic.com,
 herbert@gondor.apana.org.au, sehi.kim@samsung.com,
 linux-samsung-soc@vger.kernel.org, peter.griffin@linaro.org,
 =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc: alim.akhtar@samsung.com, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com, andre.draszik@linaro.org, willmcvicker@google.com,
 saravanak@google.com, elder@linaro.org, tudor.ambarus@linaro.org,
 klimov.linux@gmail.com
References: <20240328125056.1054878-1-alexey.klimov@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240328125056.1054878-1-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 13:50, Alexey Klimov wrote:
> The Exynos TRNG device is controlled by firmware and shared between

No, it is not. I have TRNG perfectly usable on my board. Maybe you are
refer to some specific SoC...

Please always Cc existing TRNG driver maintainer.

> non-secure world and secure world. Access to it is exposed via SMC
> interface which is implemented here. The firmware code does
> additional security checks, start-up test and some checks on resume.
> 
> This device is found, for instance, in Google Tensor GS101-family
> of devices.

Nothing here explains why this cannot be integrated into existing
driver. Maybe it, maybe it cannot...

You try to upstream again vendor driver ignoring that community already
did it and instead it might be enough to customize it.

Guys, the same as all the MCT, PHYs and PCI in previous works of various
people: stop duplicating drivers by upstreaming new vendor stuff with
all the issues we already fixed and please work on re-using existing
drivers.

Sometimes work cannot be combined, so come with arguments. Otherwise we
keep repeating and repeating the same feedback.

> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  drivers/char/hw_random/Kconfig           |  12 +
>  drivers/char/hw_random/Makefile          |   1 +
>  drivers/char/hw_random/exynos-swd-trng.c | 423 +++++++++++++++++++++++
>  3 files changed, 436 insertions(+)
>  create mode 100644 drivers/char/hw_random/exynos-swd-trng.c
> 
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 442c40efb200..bff7c3ec129a 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -479,6 +479,18 @@ config HW_RANDOM_EXYNOS
>  
>  	  If unsure, say Y.
>  
> +config HW_RANDOM_EXYNOS_SWD
> +	tristate "Exynos SWD HW random number generator support"

What is SWD?

> +	default n
> +	help
> +	  This driver provides kernel-side support for accessing Samsung
> +	  TRNG hardware located in secure world using smc calls.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called exynos-swd-trng.
> +
> +	  If unsure, say N.
> +


..

> +
> +static UNIVERSAL_DEV_PM_OPS(exyswd_rng_pm_ops, exyswd_rng_suspend,
> +			    exyswd_rng_resume, NULL);
> +
> +static struct platform_driver exyswd_rng_driver = {
> +	.probe		= exyswd_rng_probe,
> +	.remove		= exyswd_rng_remove,
> +	.driver		= {
> +		.name	= DRVNAME,
> +		.owner	= THIS_MODULE,

So this was fixed ~8-10 years ago. Yet it re-appears. Please do not use
downstream code as template.

Take upstream driver and either change it or customize it.


> +		.pm     = &exyswd_rng_pm_ops,
> +	},
> +};
> +
> +static struct platform_device *exyswd_rng_pdev;

And if I have multiple devices?

> +
> +static int __init exyswd_rng_init(void)
> +{
> +	int ret;
> +
> +	exyswd_rng_pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
> +	if (IS_ERR(exyswd_rng_pdev))
> +		pr_err(DRVNAME ": could not register device: %ld\n",
> +		       PTR_ERR(exyswd_rng_pdev));

This is some oddity... Why do you create devices based on module load?
So I load this on Qualcomm anbd you create exynos device? This does not
make sense.


> +
> +	ret = platform_driver_register(&exyswd_rng_driver);
> +	if (ret) {
> +		platform_device_unregister(exyswd_rng_pdev);
> +		return ret;
> +	}
> +
> +	pr_info("ExyRNG driver, (c) 2014 Samsung Electronics\n");

Drop, dirvers should not print code just because I load a driver. Again:
imagine I load it on Qualcomm.


Best regards,
Krzysztof


