Return-Path: <linux-kernel+bounces-155390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE528AE9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A6B1F26066
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B213B795;
	Tue, 23 Apr 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkmcHzag"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2513B5B0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883301; cv=none; b=Ynoi9DAADO8pZjtaq9gla7ZwAAQ3NwbfZtRRkLX47I+H8f9dU/qb36bWnm85pNmvNTCDi6WOeZsUYXTrgsbQvUBzzLZWDaSjdISCOYRAwZf0037dowOvQ+O4kSrQGCsP8EuMF4+G9aa4q3V6X/y163pHfX7QUkMwfBogfPJ2+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883301; c=relaxed/simple;
	bh=SHePMIvAkVkmYBg3zgejga8b2mMgSpoachJmVkYbCaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/4NwZh7oxRRoZ6CsKoy8wB5A5o3Jk6M7ZqkL4ePcVrIBfVTayffxHuSvLkdwZLRQAlLHcJBGlTtiwhINW3gEP7oY5vcu05ZabgiP7CVUHowEFcUv5q4JbqSFeSD+smsmla8/dPtMJcW/2FVQwZ7sdA29Ku3tQ5fHNLlYiceN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LkmcHzag; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3465921600dso5129141f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713883298; x=1714488098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QOiCU6JZaKjFE/L7EpX6jtWXoZ8wrLTdlB0QsdreRf4=;
        b=LkmcHzagykgSvo/N5a4rzN55/InP6KW+uZOW0EAxJIRWIL/WWoZtSXqtlUqwXKuntR
         W4wi8hnqi5/RxZNdW3cnQY9bsTF6XQkeFoKemdFUNZTWpKoEgjzEURDVMBH2I9UWBK5K
         ZY6/g0pM0B2Fin89waQE1hRnMrCGwE8YqpGbH1gweUtc7AsUODEShq+LAMUbuLvSyvUs
         rEEridBRCr7e55gs68/em6q78dk2Ws/MT2a4KeBaeTGZTv+9mr8lovjlwKP2W9CCNikw
         udcW8jUu/m+eWizbk7a+EvYQXGX6kuYfXgXYkCjr0j9JKNOD5dW781j9fbjgf0JxnKR2
         8+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713883298; x=1714488098;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOiCU6JZaKjFE/L7EpX6jtWXoZ8wrLTdlB0QsdreRf4=;
        b=B/u3QfqFoc2hoN3P43GIHAUtde607eToJZNRqBS5s8jX7CXX+OPWUf3UXOFN2c6akB
         4RAHZL2u8PHZsKJK0FN9+U4PkZpZ+teSxFb4e+b96RaU+2QX+kFhyB9oHnpCfhzmJd85
         cPuGuwLqoTDpWuiA2IJMH2iabZXU1aacznFQkoLQt5Z7qqq0e8Lwa8IEXeVPJuXc9kTC
         NiUtgM8BM/bAmLW7NQhPP9Yswu7UaDqQ4ujnuStUAv/krF0LAhR4vBdGS1lE7TALSZnp
         SbUv7GbLjRKMPAIrzUJfvUvD38p8ECxNta6Ep6QmhCkq3CLFBl6DkxnEtNqKuegx2xt0
         n4rA==
X-Forwarded-Encrypted: i=1; AJvYcCUKkIyLwvd4AS2WCn/+EBJPdnt3IAD4MORfPihOF1+FAHGXXdHU840m3t9X2Hqr5AMhKW+iWnFeqyIxrWtFOtSQJnrR2XHubiIkIUdB
X-Gm-Message-State: AOJu0Yw2D1xhYagOVLUk4Tb099+YCdCLfFhZ6U1fiFrpWxq51BM8vsCV
	2Unn5SV5vTQTlf3Qhm25pcNquucco0juIN/TTYaJTSxMKToF/qHZsNjduQuY/iY=
X-Google-Smtp-Source: AGHT+IFyyJasS6WyWjsQRVZ9N7NPygkxprHq+fsDdTbs029FiT1JZu+BZQizTPwetmcei2Ds1GWMtA==
X-Received: by 2002:a5d:5265:0:b0:345:66a1:d949 with SMTP id l5-20020a5d5265000000b0034566a1d949mr8369747wrc.0.1713883298232;
        Tue, 23 Apr 2024 07:41:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00346ceb9e060sm14681502wri.103.2024.04.23.07.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 07:41:37 -0700 (PDT)
Message-ID: <6506b2e8-c7f2-460d-b17d-55b731fac1ac@linaro.org>
Date: Tue, 23 Apr 2024 16:41:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 2/2] memory: tegra: make sid and broadcast regions
 optional
To: Sumit Gupta <sumitg@nvidia.com>, robh@kernel.org, conor+dt@kernel.org,
 maz@kernel.org, mark.rutland@arm.com, treding@nvidia.com,
 jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, amhetre@nvidia.com, bbasu@nvidia.com
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-3-sumitg@nvidia.com>
 <06849796-f896-4cff-842c-118d86e94a6b@linaro.org>
 <1aab0272-85ea-e3a1-7d68-27ab4f1e1993@nvidia.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1aab0272-85ea-e3a1-7d68-27ab4f1e1993@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 16:36, Sumit Gupta wrote:
> 
>> On 12/04/2024 15:05, Sumit Gupta wrote:
>>> MC SID and Broadbast channel register access is restricted for Guest VM.
>>
>> Same typo
>>
> Thank you for catching. Will correct in v4.
> 
>>> In Tegra MC driver, consider both the regions as optional and skip
>>> access to restricted registers from Guest if a region is not present
>>> in Guest DT.
>>>
>>
>> ...
>>
>>>
>>>   static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
>>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>>> index 1b3183951bfe..716582255eeb 100644
>>> --- a/drivers/memory/tegra/tegra186.c
>>> +++ b/drivers/memory/tegra/tegra186.c
>>> @@ -26,20 +26,16 @@
>>>   static int tegra186_mc_probe(struct tegra_mc *mc)
>>>   {
>>>        struct platform_device *pdev = to_platform_device(mc->dev);
>>> +     struct resource *res;
>>>        unsigned int i;
>>> -     char name[8];
>>> +     char name[14];
>>
>> How is it relevant? I don't see this being used in your diff.
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Did this change for below warning coming with 'W=1'.
> 
> ../drivers/memory/tegra/tegra186.c: In function tegra186_mc_probe:
> ../drivers/memory/tegra/tegra186.c:51:49: warning: %u directive output 
> may be truncated writing between 1 and 10 bytes into a region of size 6 
> [8;;https://gc
> c.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wformat-truncation=-Wformat-truncation=8;;]
>     51 |                 snprintf(name, sizeof(name), "ch%u", i);
>        |                                                 ^~
> ../drivers/memory/tegra/tegra186.c:51:46: note: directive argument in 
> the range [0, 4294967294]
>     51 |                 snprintf(name, sizeof(name), "ch%u", i);
>        |                                              ^~~~~~
> ../drivers/memory/tegra/tegra186.c:51:17: note: snprintf output between 
> 4 and 13 bytes into a destination of size 8
>     51 |                 snprintf(name, sizeof(name), "ch%u", i);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I asked how this is relevant to this change and you answer there is a
warning. If the warning was there, your answer is really just deflecting
the topic, so obviously this is new warning. Which part of code uses
longer name?

BTW, really, such answers do not make review of your code smoother.

Best regards,
Krzysztof


