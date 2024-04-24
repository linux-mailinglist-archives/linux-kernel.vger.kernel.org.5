Return-Path: <linux-kernel+bounces-156327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540078B013F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80191B226E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB7156877;
	Wed, 24 Apr 2024 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LedwhX4f"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355C156675
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937462; cv=none; b=PMmQ1vgi+uW+KzMtt+3JV+4c6pt+cR3dAOGoFPTXhKfjAHLBfeWFY5xZdb4ADx+e+i1tXd73e8hLrTV8hMuwmc6MSpclAK4KSuEEm3i24KEtxJpI6m262ZNwTodJwiORP/wV/s24wCNLTNIGL5juXoTDzq/m5Gv20XNo7KDvMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937462; c=relaxed/simple;
	bh=Tsukt/u+x+bfuUgjj0ucX/lXEUi04xh/6bzDgekdZdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMZLrVKDHyWg3Gz05UMq5/n4Tsk16stdumj3urTpSUM+QlLjL1126Ph90IWkGvyZjg120wPvq/ikLopEBC/jbQKemufzoy9p28IjbWIQtXdxAPlaicuMlKFEqOIRD7Jq9sIjEQMbDgVcEN3dmb4d6ekiYx1d+3mZBjDAn+pnK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LedwhX4f; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55b10bfd30so205249566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713937459; x=1714542259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jlneV0689N8HaAgnKrA8+c/XGpL5OqjXfyjAo9Y+EUk=;
        b=LedwhX4fnBBGFUSibiLwDXq69JAHO9/f7vimfuppckluu9lcTOAaaKO+BvGDHt6S4P
         5bEYhOxyDCfjDKLpxDdN+APn8q4EVX/rm1eNtrqS6xchBsEfRl+Tt/q/rtUIGSQeCqpQ
         ApjJTNtuPlGBHz6FnWQz04yEq97uRl/oSRXh1doWpAnjBhx6cp1x8fcXOAI6+H3hOcmF
         ErFWYQzuOdRVA7zPpmbfTurPFirfxgmnjL197wO1zItsmUAAE0rCHHr4KNhicY3EK7RV
         Gjr4bFm7jktzZMq9LZmIbLE3UNqOyVbuMiiBEXyT8WnvB92K+KAV1GsbFDSUsrmfqK/D
         OPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713937459; x=1714542259;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlneV0689N8HaAgnKrA8+c/XGpL5OqjXfyjAo9Y+EUk=;
        b=WU70tCS8xoMmEABFrUqmrSVoY3kSn0IY47Q9AKXM8bwZNav12I0EHN/0zM/M4lcdLi
         BwQGHwC/BtI6kz9Hz6+D5BejOdx3wndqCnvDQQHiRQ/0pwA5Qkc23OMqhRp5sShXn3G1
         VSxsWp/uiQesAUCXKJ8zhgTgJvMJTdJHUHwwb9MYinSc08IL+WAvY5mQpsk/vZ66LYZ5
         l9WKtUnaQfDvfvneG4PSPAj/qKfobMsBfG4XQFZUUHFik0+iD+KugWpZmRQ4mNib41LP
         BlYp0bcFt2DAXFCugTGSHYUIX2WW8vhVBbWJoYvV/t2KURZklj3M+21URkpjubZcba86
         mP0A==
X-Forwarded-Encrypted: i=1; AJvYcCWdKVmLfT5ztvcaZRV13TVxxB4SrhUoNRjBeJ9yCE8R47lKOqcX95lv3NnKWH9ozs9IIGMm4jkJXdMChRwxIoleurqXZ5eXwzRSpgOF
X-Gm-Message-State: AOJu0YzRdrdiXtkDXDHErnRbqE6ZJk0eZaqB3DEogYI7uv4O/Kw++GyX
	EXsQ6oO591s4f0ulRvvFfVn+H/2/wcul3o0GMen7frD/1U+8EPbvUYI0zTua9T8=
X-Google-Smtp-Source: AGHT+IEk1XTgtoIQ2MS41hy3SMrupyasfBYe9OpfN9uyWGTfq1hYSolqElIpWbXLbKClxt9S4tM+XQ==
X-Received: by 2002:a05:6402:2033:b0:572:325a:8515 with SMTP id ay19-20020a056402203300b00572325a8515mr241936edb.36.1713937458625;
        Tue, 23 Apr 2024 22:44:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402164300b00562d908daf4sm7429161edx.84.2024.04.23.22.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 22:44:18 -0700 (PDT)
Message-ID: <4824ad5c-0250-43cb-8f92-ec5e6c9c49af@linaro.org>
Date: Wed, 24 Apr 2024 07:44:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 2/2] memory: tegra: make sid and broadcast regions
 optional
To: Sumit Gupta <sumitg@nvidia.com>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "maz@kernel.org"
 <maz@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Thierry Reding <treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Ashish Mhetre <amhetre@nvidia.com>, Bibek Basu <bbasu@nvidia.com>
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-3-sumitg@nvidia.com>
 <06849796-f896-4cff-842c-118d86e94a6b@linaro.org>
 <1aab0272-85ea-e3a1-7d68-27ab4f1e1993@nvidia.com>
 <6506b2e8-c7f2-460d-b17d-55b731fac1ac@linaro.org>
 <e1d4e915-08c9-c2e0-f882-6d7cd9500c96@nvidia.com>
 <d27d0784-7f88-4351-943e-5c464a7d95df@linaro.org>
 <95f8e4b5-23af-90cb-4dae-2922e8e71920@nvidia.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <95f8e4b5-23af-90cb-4dae-2922e8e71920@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 07:27, Sumit Gupta wrote:
> 
> 
>>>
>>>>>>>
>>>>>>>     static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
>>>>>>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>>>>>>> index 1b3183951bfe..716582255eeb 100644
>>>>>>> --- a/drivers/memory/tegra/tegra186.c
>>>>>>> +++ b/drivers/memory/tegra/tegra186.c
>>>>>>> @@ -26,20 +26,16 @@
>>>>>>>     static int tegra186_mc_probe(struct tegra_mc *mc)
>>>>>>>     {
>>>>>>>          struct platform_device *pdev = to_platform_device(mc->dev);
>>>>>>> +     struct resource *res;
>>>>>>>          unsigned int i;
>>>>>>> -     char name[8];
>>>>>>> +     char name[14];
>>>>>>
>>>>>> How is it relevant? I don't see this being used in your diff.
>>>>>>
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>>
>>>>> Did this change for below warning coming with 'W=1'.
>>>>>
>>>>> ../drivers/memory/tegra/tegra186.c: In function tegra186_mc_probe:
>>>>> ../drivers/memory/tegra/tegra186.c:51:49: warning: %u directive output
>>>>> may be truncated writing between 1 and 10 bytes into a region of size 6
>>>>> [8;;https://gc
>>>>> c.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wformat-truncation=-Wformat-truncation=8;;]
>>>>>       51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>>>>          |                                                 ^~
>>>>> ../drivers/memory/tegra/tegra186.c:51:46: note: directive argument in
>>>>> the range [0, 4294967294]
>>>>>       51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>>>>          |                                              ^~~~~~
>>>>> ../drivers/memory/tegra/tegra186.c:51:17: note: snprintf output between
>>>>> 4 and 13 bytes into a destination of size 8
>>>>>       51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>>>>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> I asked how this is relevant to this change and you answer there is a
>>>> warning. If the warning was there, your answer is really just deflecting
>>>> the topic, so obviously this is new warning. Which part of code uses
>>>> longer name?
>>>>
>>>> BTW, really, such answers do not make review of your code smoother.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Apologies for not explaining it earlier.
>>>
>>> I increased the buffer size to suppress a static check warning in the
>>> existing code due to big range of 'unsigned int i', if copied to small
>>> name buffer.
>>>
>>> Seems like the warning is harmless as the maximum value of num_channels
>>> is 16. I will remove it and keep the buffer size as 8 in the next
>>> version.
>>>
>>
>> That's not the point. For the third time: how is it relevant to this
>> change here? Was or was not the warning before?
>>
> 
> This is not relevant to the change here. The warning was before as well.

OK, fixing the warning is always a good idea, but this *must* be always
separate patch, with its own explanation and rationale, and warning message.

Best regards,
Krzysztof


