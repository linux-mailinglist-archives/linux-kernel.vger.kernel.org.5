Return-Path: <linux-kernel+bounces-123338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603558906D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1621E1F28106
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8358004F;
	Thu, 28 Mar 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzTVIOOh"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151D3BBEB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645558; cv=none; b=WFatciqZ6pu47l6CPaya/lO2NIlsOWSrX75hV5ZknxfxXyfqE62Dl/jOc70M+LancxtJhgfhy5IMITtnWq4JdX6/dRW0LHon/SAXNA2LFC78Y1JhdcEyp3VJJ2Gewms7EzJKS6VKocYwltWZrvYrVVmSsDfg10ctSyv/P4suwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645558; c=relaxed/simple;
	bh=wSsry2PMXLPRJT5NhTiuPA1FZxtDvgfhBGHxg4riOr4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DcMFSl89sefNbC5bAL0uhkkFv45Jc/wCEB+vZrjjLOhzLWqiqwCSW4XSh5qmotnvv1mHEWJToLflQW5i09TCHiUPXwzYP2JPiDrNAc4cv9+GlOuJWMXO/LJTrxHtNnAeyyw5v2yId+/m5lKHzVbBDkGcjDd0w3dLWkT+YjSa3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VzTVIOOh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so17956251fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711645555; x=1712250355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8UV269C+zXw1qTig2GGB1q1grJrIL/P42czrgTeCgxA=;
        b=VzTVIOOhSUQTcx1vlA6ObXvp6qGaHNcxqRblLYzeUefZZWXD6LEvFA3QC5ode6oUyd
         TsZQnmm/gKQaAKC2AeMWMOuMlndV7iY/gmSQN466WEE/vQLZP1zKoaJVUo8zJQazo/aR
         KZHCjlo0U1/934njzM2FldbSWa6TGuknKwj7maa7YO9swLJyVgihujEUofIhvIegxa9f
         FvShosevcp13L9Zh0GLNJrm80dfhqUGTe9N8W7li0w8iodWsWR4CppqRTaneHLKuGpBq
         9NBxazIkdG3D6QJTkd58KibPMnONOE/WOmMGlinZz0aWNFtmx2bYbLdg9sJ1dKC1mAqE
         zeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645555; x=1712250355;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UV269C+zXw1qTig2GGB1q1grJrIL/P42czrgTeCgxA=;
        b=UAT5xPJG30mL37bykIrGPVprZgWTgQWdWQmalSLzryT/4pUA8TMtKL1bhVQMYg0h04
         6r/f5K/gevbcr/PRbEHnf2LVpQt1nB13frINe1hxF1YjkgE6zomsj8mCDcwL9vVDXNtz
         TbByaituc5n4TVzJeIt6YP6sIJ7AIYpEwdnsX+/vjkLnh+qJTKFu4nnYV2BgBGKVGNIN
         zIM53BvUH2PtbmmsLWVCO/o3lsDE7RGBWbMZhHLyuRNfHwJlqODznlr3ibDqzc6yHJxm
         AqFJa6tBqOlmZQ0IqiZyUs46hrHC+73Z+1jdVZbd51FfWVqCsw+bVzjcfVgTjjtEXxsG
         UNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMwNTeDU4+bPy1kcgaijhSKEWjhGv6swW3aGrllYK0skUy8+W4WHuYuJHbL0gRMoJlxbIfBF9W0UopSFCZYfInbxyPaOM7+WlxJ4ag
X-Gm-Message-State: AOJu0Yw7v/oElVs3fYzTXLg56cGASJ8NWjJM6KrDoFuXOFG4E1VZLf4F
	GKoa8KNDw4LX/idGzrQ/8mkD5y2VqlRvTaNNrhzOroKrAxEP8nuekElmio8uqSE=
X-Google-Smtp-Source: AGHT+IFZbbgEPpP8HiHWB0MFkZHwyrileLkAqzyfyUOIrjDjVaxKv38u5/6CSekNPHOY1gdBGyKJ9A==
X-Received: by 2002:a2e:8606:0:b0:2d6:f62b:6e08 with SMTP id a6-20020a2e8606000000b002d6f62b6e08mr2511766lji.27.1711645554835;
        Thu, 28 Mar 2024 10:05:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c00cf00b00414041032casm4810878wmm.1.2024.03.28.10.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:05:54 -0700 (PDT)
Message-ID: <38d2156e-fdc5-4196-b598-644a00a0c35f@linaro.org>
Date: Thu, 28 Mar 2024 18:05:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH REVIEW] hwrng: add exynos Secure World RNG device driver
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <6b691a48-ca97-4f23-a09f-69b9254f0c11@linaro.org>
 <83607b46-56e4-45eb-ac69-9bc5be5bdee4@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <83607b46-56e4-45eb-ac69-9bc5be5bdee4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 18:01, Krzysztof Kozlowski wrote:
> On 28/03/2024 14:36, Krzysztof Kozlowski wrote:
>>> +
>>> +static UNIVERSAL_DEV_PM_OPS(exyswd_rng_pm_ops, exyswd_rng_suspend,
>>> +			    exyswd_rng_resume, NULL);
>>> +
>>> +static struct platform_driver exyswd_rng_driver = {
>>> +	.probe		= exyswd_rng_probe,
>>> +	.remove		= exyswd_rng_remove,
>>> +	.driver		= {
>>> +		.name	= DRVNAME,
>>> +		.owner	= THIS_MODULE,
>>
>> So this was fixed ~8-10 years ago. Yet it re-appears. Please do not use
>> downstream code as template.
>>
>> Take upstream driver and either change it or customize it.
> 
> Alex Elder pointed out that some of my comments might not be precise or
> not helping enough. Let me clarify then:
> 
> Please run all standard, open-source tools when submitting new driver,
> which is:
> 1. Coccinelle, which points to this specific line since 2014,
> 2. smatch,
> 3. sparse,
> 4. checkpatch,
> 5. If changing bindings: dt_binding_check,
> 6. If changing DTS or bindings: dtbs_check.

And I forgot:
7. make W=1

Many of these, including W=1 above, can be with target, e.g.
	`make W=1 drivers/char/hw_random/`
to reduce the scope of tests/warnings etc.

Best regards,
Krzysztof


