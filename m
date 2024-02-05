Return-Path: <linux-kernel+bounces-52446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4EE849852
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E232B26F67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914C71803E;
	Mon,  5 Feb 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjA/q2rV"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD018633
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131015; cv=none; b=cQCXsgU3+T2T63XCDOob8XpI500zvwKxSajkHs1kNQH6C1LZhKrAezkW+YPHqZrZUCmi2Q8rXhORoUMBdT2UsnaJ4tN7/h99gSiNpytKwfgK5KSvwHPKjhsp+hbA5pZZdXMEJD62aetBx+zwz5YbEJxkaqEuXavk3HBHIQo7dAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131015; c=relaxed/simple;
	bh=5kotpH8j5ON/guqrQOvATBVvWiTW22RAQau8MMp5//w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPDCQW8heBJOs2b91V7xHgl2DQjWQpQgYP6U73hXEfGcBcYt2QMGQKvKpIopRl25SpVVvMvqKSGTbPGAttgN5zVkPGkZw+FCf9KIoKDLC/CNG2jks3RTQthQCtt1DQsARoMnGJogP7w9bE7HiOiUFkRXtcL/YI0Ahi6gbsn2pV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gjA/q2rV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fc654a718so24904125e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707131011; x=1707735811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWMeMy+p6YFvdOxdhP5YCV4stnrx5Fo0X2SQcn/J4xc=;
        b=gjA/q2rVJUbU/kKsTXsIvM411yVLducyanntPVaqxy4aWLE2iA4r/ykyWoGRcgE96Y
         veUS8rNj9Ib0ZWOVF4t497YxDCMsGpsC72rwc+23uu1bswNa/OH10RE0btyLoWfyWlq7
         CmxQJya4Wxk2oDOdMrhZw5Hfo3WlaWxg9U2ROPseHNSBIujOl8TfANTKkoRnUrd7zcan
         5pqBUXyh7At0BGtmVv7N1J5YjeG/4FpPMXCnVMZB5LThItWxSJcYcKwIXXXwzdWzHZZb
         FRpa5K+EHF4a3ZMYx5+/KAvOT0gZ/o7xGXR1GzL8vliGMe+VEdbQGiKPR3CikzQcJIhI
         W+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131011; x=1707735811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWMeMy+p6YFvdOxdhP5YCV4stnrx5Fo0X2SQcn/J4xc=;
        b=Eu22GN0mQZeTs/CvJRC7egGT0yeTaVGarYL/geiApmGYxO8Yyp4oyLdjzugMeyRfbh
         WLBzXA4IvX328jmDj1em5NqWcR0uX+nWIS1wA2q5pQenO0ZSIFpgSgM0M4gQDebaAdCe
         FI4LVy3y9FZMLBVyk8XMSxo1FtMmOD1RhgXPRAIA376YR2KdnY/6zHEBpUbxsULQUjET
         IC6vwKEEVJP+5RL2tv5hK/X9LnhN2sSAj8Gw3/7CVqRBfwUVg0pVAym5gtIYYMsrrK/f
         fy7b0LezxBPgE05EYCzqoEcW58xw2mdzkFU20AQQpcTzl1NxtGGpazFntqjq6lb3eOXU
         aBhg==
X-Gm-Message-State: AOJu0YzLU+uxKwpeVFb2NCGBr+xkAUQu7kDbNfk/steMnlf1KDMNFa6y
	hnc5NkhL8EeRdOCZ0YDtYlPUJmeKOz7ReCUUL3k2BCDB+oPiwnwNU82sRiJRE9U=
X-Google-Smtp-Source: AGHT+IFGiuvK4vBQMICw+TVMp0pUrD0KDwiEZRj5NvEvt7aSliN3fIPIWklaQtb8N8qXhqyHYTg/nQ==
X-Received: by 2002:a05:600c:4713:b0:40e:b93e:4a0f with SMTP id v19-20020a05600c471300b0040eb93e4a0fmr4425437wmo.19.1707131010965;
        Mon, 05 Feb 2024 03:03:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWyLJ7RWu9Z9Dm5bvEfJxFwW19wrUX2+4LTjK/HErNAX41VONCYodUCERFWvnIw9nscSexRsYW778sSbMgpwx8D5M/tjSENKb4MR6vuyJvnGbTEASr6OHWewWQAlxA8svsyRvluG+RTx07QqRMwKPBnE7vC73auQGJBAIhfgjZNZdn9tECX4XSYzQk1JsUO87YYl++RzGH4jv1iBGFcJz1zqTScLYFg928uCZEuwcwO3QpoPDjfZXnIwCWDF62iNH9Ae4U1eEV0BTSqo2RYcDArKzSwBIXfHY0KhbSL/VERnVwKugh3PyqyDoNqbXkgd3C/bjmT+0+m/+Jbct9fWToY80dePBd6Cf1jBmFnq+OhrxXhNNIniLlvSJV3osxu+6vnRSjwzIQZqbs+2W4XwN3ZV1hr3jLVsoxvP0xNYKk97UPteW1p98ciucpghiAK+87y167tG6V1atwLju8P6hVMUGC46nJ9uJ0bEZAeJF2JXoy7JAjZDegZV42BK4GACbOmhKLZHkbuDbKit1pg3IxsXCB5mEuiNdG+u9MtM7TwDIT48YofnPwsqpBxdxbHLdGNLM8YIDNWw8ZaWOLXbJrBHX9Nwedl7DUXuThqomwdh6F7RfIe0DdLsQ/v+Rw=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id w12-20020adfec4c000000b0033b17e18df8sm7837150wrn.12.2024.02.05.03.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 03:03:30 -0800 (PST)
Message-ID: <8124a8f7-23c0-4773-aec2-0a3f70ee7e11@linaro.org>
Date: Mon, 5 Feb 2024 12:03:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>
Cc: arnd@arndb.de, linux@roeck-us.net, wim@linux-watchdog.org,
 alim.akhtar@samsung.com, jaewon02.kim@samsung.com,
 semen.protsenko@linaro.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com,
 willmcvicker@google.com, linux-fsd@tesla.com,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20240129211912.3068411-1-peter.griffin@linaro.org>
 <20240129211912.3068411-2-peter.griffin@linaro.org>
 <fb530eb8-e32b-4faf-81f3-efc334ebf241@linaro.org>
 <CADrjBPrNryfccFkrZWY9_4EfDF1h3VyqKcxh8vim9Hp8D_AhkQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADrjBPrNryfccFkrZWY9_4EfDF1h3VyqKcxh8vim9Hp8D_AhkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 12:29, Peter Griffin wrote:
>>>       int ret;
>>>
>>>       pmu_base_addr = devm_platform_ioremap_resource(pdev, 0);
>>> @@ -137,6 +333,35 @@ static int exynos_pmu_probe(struct platform_device *pdev)
>>>                       GFP_KERNEL);
>>>       if (!pmu_context)
>>>               return -ENOMEM;
>>> +
>>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +     if (!res)
>>> +             return -ENODEV;
>>> +
>>> +     pmuregmap_config.max_register = resource_size(res) -
>>> +                                  pmuregmap_config.reg_stride;
>>> +
>>> +     if (of_device_is_compatible(np, "google,gs101-pmu")) {
>>
>> No compatibles inside the probe. Use driver match data. This applies to
>> all drivers in all subsystems.
> 
> Noted, will fix in v3.
> 
>>
>>> +             pmuregmap_config.reg_read = tensor_sec_reg_read;
>>> +             pmuregmap_config.reg_write = tensor_sec_reg_write;
>>> +             pmuregmap_config.reg_update_bits = tensor_sec_update_bits;
>>
>> No, regmap_config should be const and please use match data.
> 
> Are you sure you want the regmap_config struct const?
> 
> In my draft v3 I have implemented it so far having a regmap_smccfg
> struct which sets all the configuration apart from max_register field
> (used by gs101) and a regmap_mmiocfg struct (used by all other
> exynos-pmu SoCs). The choice over which regmap_config to register is
> made via match data exynos_pmu_data flag 'pmu_secure' which is set
> only for gs101. That avoids having to define exynos_pmu_data structs
> for the other exynos SoCs that currently don't really need them
> (exynos7, exynos850, exynos5443, exyno5410 etc).
> 
> But I still wish to set at runtime the regmap_config.max_register
> field based on the resource size coming from DT. Having the structs
> const would prohibit that and mean we need to specify many more
> regmap_config structs where the only difference is the max_register
> field.
> 
> Is the above approach acceptable for you?

Having it non-const is one more step of supporting only one instance of
PMU device, but we already rely on such design choice, so I guess it is
fine. If ever needed, this can be easily converted to devm_kmemdup...


Best regards,
Krzysztof


