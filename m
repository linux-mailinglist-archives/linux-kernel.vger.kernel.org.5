Return-Path: <linux-kernel+bounces-123336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A68906C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65492B23F47
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE30130A51;
	Thu, 28 Mar 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtXEBXl/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30A13A86B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645278; cv=none; b=ghPc45ll/7Gz0MjMBHGGUvrQSi0oLp8b81B5ZR1cSfCvZ9IVH3770rgoYOPTo14yEuiAgfYBPoS7nmD9cyyRNsC5qK0zYPNy+wubFKfyysXibia69YMxwVPqR53dLi8Fl02WHuUkrCcVLHqo9LAdJ3nj5svvt4Z06dFqsxhcdWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645278; c=relaxed/simple;
	bh=Fh/fvvGRV0ipLGBScyPvhaczpeww/KTs/gfhtV+DHN0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T3MivC1Iuc58Jm6Ftdv6VAx9uUb4ohWut+CM6O3AD+1ZcslKzFCqYv6LnaQfaw9zJhXttaGN7LTVN9SXeHLQ6wC19heUn8wru3qrRlWBx6TOpQ6KoXHTkWB4sb1qzWwEc5TW3jynW14i/hMzi1MNX2vUKTZ4Q2MOiw4r/cSIm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WtXEBXl/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41543b772e6so9335245e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711645275; x=1712250075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JvbGlCWeEtR2d0HYfJpjix5RjBTOtqrn3Jd60OZZIu0=;
        b=WtXEBXl/oH6yh/h6j3NH93kUw3nshTECO/Q81N2QaMmymkGTkKzHix5icUgpfDqJbj
         pXyyf2bcetSn3sfawAnXb+2IBOjJOXHTKvJqIVt00KbczaufoQiGxLUY+BRgYdeXWO2T
         CrD00hSnQrToJSF/BzkB1Unghg0fG4+5SOSMO0hGmvw3kxJLFfE0Pmst3t3z1PO4AhzL
         doyBpnxEY17n4j/YUzXiwwV92+8WpsJIIZGjti9aCaxqj6kM2yCpbWqekYzJDlpDeQsa
         1hWSDwlvb3Rq24lhxvlmh+Y+59MdpJrB+h+qYw/w3sHdYsswkIPpjCXDVLKnzWr8eBKF
         at+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645275; x=1712250075;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvbGlCWeEtR2d0HYfJpjix5RjBTOtqrn3Jd60OZZIu0=;
        b=KJ3Rh6R+dt2G/eRCDlk1ars4vUZ+OQZIDSsZVP6v/vIjUmdz/EA8qKy0GAqk2tYGJX
         A8zS9454+PG8G4vWP/bagnvkcQI6Hi5RY/C66zXmQX7B1bxZy0xXa6UVSvBospgdNJHm
         SBtIiX6OzveaMubuuD7F+gjw+N5hAxK9I6XgfOyJf2vxH6X52Vaz+yTwNoE6NORreP3b
         4vMVY6XGK0hapuxuMmUcvv+pA82hC7J2jucX2tUT4UBpZSBYPsL6yNtazQdTMIUFyTa7
         hVn9NbZpo3RelF9Y3eRPqV3IcGOdfjUF4+rc4IhVjiqZypOekVPC1HRYMp3wR5NxoGV/
         gj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw4/DinGD9z5eIUCRiMjZoZnwsUNRV0x3DwhARRv6RFSHBZKkUD/oLy5lVvLcw4Ei5VLajuPusy92EPnGIdFJdh2sjt7vUVvyO1Jeq
X-Gm-Message-State: AOJu0YyxXZz1vCoMOv0ruhruKxamoJ8tFG0jrq8o8lPyzBPuHuOpk9G1
	PXUEkWGCnMBu20dq8E8dyBnFntEgKRpW8aKh2ima8hsbGzcOxFZDNQPdnu/FgwQ=
X-Google-Smtp-Source: AGHT+IHl1XVC/4kgvD79NRisLWRE2gI3TkFtYQsLM4Dews8SLNO5juXXxy8LEkOQtwW4O/6aP3wovg==
X-Received: by 2002:a05:600c:4f13:b0:413:ee55:8bba with SMTP id l19-20020a05600c4f1300b00413ee558bbamr3347745wmq.4.1711645274517;
        Thu, 28 Mar 2024 10:01:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id gw5-20020a05600c850500b004148e3f4cafsm6030284wmb.14.2024.03.28.10.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:01:14 -0700 (PDT)
Message-ID: <83607b46-56e4-45eb-ac69-9bc5be5bdee4@linaro.org>
Date: Thu, 28 Mar 2024 18:01:11 +0100
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
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6b691a48-ca97-4f23-a09f-69b9254f0c11@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 14:36, Krzysztof Kozlowski wrote:
>> +
>> +static UNIVERSAL_DEV_PM_OPS(exyswd_rng_pm_ops, exyswd_rng_suspend,
>> +			    exyswd_rng_resume, NULL);
>> +
>> +static struct platform_driver exyswd_rng_driver = {
>> +	.probe		= exyswd_rng_probe,
>> +	.remove		= exyswd_rng_remove,
>> +	.driver		= {
>> +		.name	= DRVNAME,
>> +		.owner	= THIS_MODULE,
> 
> So this was fixed ~8-10 years ago. Yet it re-appears. Please do not use
> downstream code as template.
> 
> Take upstream driver and either change it or customize it.

Alex Elder pointed out that some of my comments might not be precise or
not helping enough. Let me clarify then:

Please run all standard, open-source tools when submitting new driver,
which is:
1. Coccinelle, which points to this specific line since 2014,
2. smatch,
3. sparse,
4. checkpatch,
5. If changing bindings: dt_binding_check,
6. If changing DTS or bindings: dtbs_check.

I still did not point to specific error I see, because I would like you
to setup the tools and find it. This way you will have toolset ready for
any other submissions. I hope this will be helpful.

Thank you for your contribution.


Best regards,
Krzysztof


