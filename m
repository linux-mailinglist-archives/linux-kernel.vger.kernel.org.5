Return-Path: <linux-kernel+bounces-46195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F9843C08
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC1F1F2DB72
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327569D07;
	Wed, 31 Jan 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBAhDdj4"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1526775E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696169; cv=none; b=D2vMOv19N2VwSh+Cf/9q/UzTFDZlTwRw/9DuhWJN7t0RBykG9kHjzKpsJjhIA86TXL4XlqSvLsJll3e2YBEvWkD+BJBwqOGbUzWiAoYx/3VhDrRCkhAfLUuCPE/amnvVnG3zBH9+HVPChKv5pITt5Ps9mXBU5ta3OH6PxYsVKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696169; c=relaxed/simple;
	bh=k5yjOXfE45Fq1dYHfeKw7CS8ob/2spnqmq/42WE3TFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoUn4X3bZjUNjHFaaL9Ty+UZhKyej/UJe7F32o6hph4DcuwQ+fZrlFXjU7gmTEEYzHmG6iS+sEYVgWlxU/557Lsp5GSkGg5E6eqCuyvw0GveUG8Ylc/l6Ck9kBFWulAzaLKNnyX4jFw0NSgrNyy7KD60PGHNAyG4R/lBzRfH6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YBAhDdj4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55ef0465507so4255618a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706696166; x=1707300966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0S/vewGpjwHH5F87kZM31jgzYWI7BwBNBZ7vu7tKQM=;
        b=YBAhDdj4vW6amzYKezwyhMqSZSWoBzQCeM+D7uavNyYNUYTE5TMZEw925qHoedPHAX
         IBNCdeFacnCetQObcbHbsDWwi4vkA25OvPpSxRAS7i6djPDi4la+3RaF3NTfgbn4OykQ
         y0WXIv9MqPVwek/2YQKxUEXJ4Q9bc+q6Om/ddpMDSOGE7e1sTbd7UhMk+jCdIxbvkvNe
         RkA9UWIK6NNjvFsIXY4o9nwsOQhyF1I+FCuFlY208OCvGO6xFyl7rFfXpXVCFM3xQzvZ
         WHj7+cdMFAnSNEPq80YMqw1E3EzhTxV8PbN5qOqueL6vJMSPfbgYgs4Tz6TLk95MBGge
         GCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696166; x=1707300966;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0S/vewGpjwHH5F87kZM31jgzYWI7BwBNBZ7vu7tKQM=;
        b=kkYFwfGH7O/Mi4gadHLk298r3GsRzgjoFs1Geu7DwXfTSS5FICPsqgV589aPAPd5h1
         rHnvjfWL58vKVTV+goqzvW0wAsAlWBwPqUXBLzZmo6VahoM2DMYfQLUZmVv59ybFHDi/
         6Bs/iBstDDfDBWuUlUJXOeXhQW0Yu5HHBiQGjJ1RstoPD1O8LVo8xYDuQQf2TKXwTMcc
         yy6zJ2MCryjuab0QqEpGIA74QVSf6hM+LHtYU0LSpeYpUASXjLDN5PXsvL3Zo0dqQdvA
         XPW5+ZYWl2dCI9tQ7VjJOvGTQhql94zwRD54H4Mtle0ZcFw1Oke2hTKif0Ukjw/AdXGG
         ULFw==
X-Gm-Message-State: AOJu0YyDNRHCcAqdLmnY+V/Gp3mYW85oRWN1Rx4X2nW8MAQ9qdhjZnSU
	i0Y0zRpaf/jsJ1zbrBJgcs7gdZNxnm386dTKRddIpmvAqdYSVOF8ViLciYZNfVQ=
X-Google-Smtp-Source: AGHT+IFf+dsKbgDvXKZGpdiPaPGzkvTx0wWWOhyaNQkX9/WGaK0wTpqUxq+6fQE4y02wS2ma7DUVsw==
X-Received: by 2002:a05:6402:3d1:b0:55f:8021:3570 with SMTP id t17-20020a05640203d100b0055f80213570mr697319edw.33.1706696165792;
        Wed, 31 Jan 2024 02:16:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU2ZUSqngD7xTZu588qskRd6Vv38U1PfT9beW2sdy638tGqcZmoJSrMXOMD8kMwc7Ji7EvgQR4wrhQp8RWEmv44chPCrFgzR7LIifOYP/vk7Di3tPN78SdGw6SDvV2dqYBkgVweXuSiBLM/2VIKtBFBHUF9puGNgInFJskPYIlJE2YQhKfdIqfZxDhmzBHVr51tERFF6JSwzJk5KuLFUd8Vj3rGprkommEazM5h2KrBBpRd1Lrxr2WFGzkLpgdU9csp744w2LO6OQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id n3-20020a5099c3000000b0055971af7a23sm5916192edb.95.2024.01.31.02.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 02:16:04 -0800 (PST)
Message-ID: <b99efbd4-7c12-485d-8688-a4ec606f0cf5@linaro.org>
Date: Wed, 31 Jan 2024 11:16:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bingdings: perf: Support uncore ARM NI-700 PMU
Content-Language: en-US
To: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>,
 will <will@kernel.org>, "mark.rutland" <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, =?UTF-8?B?6LW15Y+v?= <ke.zhao@shingroup.cn>,
 zhijie.ren@shingroup.cn, linux-kernel@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20240131065953.9634-1-jialong.yang@shingroup.cn>
 <e7bf16fc-b12d-47eb-9197-0694e6829ac8@linaro.org>
 <02B995F774AB7A9D+adfd0934-00cb-4dc3-8bf8-058b83dc2fbb@shingroup.cn>
 <ebbc9d73-9be2-49ae-98f3-0d71ce624ee4@linaro.org>
 <873A6CC450C1D0E6+75a39d6c-4fbf-4e30-8630-3226bd725901@shingroup.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <873A6CC450C1D0E6+75a39d6c-4fbf-4e30-8630-3226bd725901@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 11:13, Yang Jialong 杨佳龙 wrote:
> 
> 
> 在 2024/1/31 17:30, Krzysztof Kozlowski 写道:
>> On 31/01/2024 10:26, Yang Jialong 杨佳龙 wrote:
>>>
>>>
>>> 在 2024/1/31 15:49, Krzysztof Kozlowski 写道:
>>>> On 31/01/2024 07:59, JiaLong.Yang wrote:
>>>>> Add file corresponding to hx_arm_ni.c introducing ARM NI-700 PMU driver
>>>>> for HX.
>>>>>
>>>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>>>> ---
>>>>> v1 --> v2:
>>>>> 1. Submit dt-bindings file Seperately.
>>>>
>>>> Where is the driver?
>>>>
>>>> Please read:
>>>> https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/process/submitting-patches.rst
>>>> before posting.
>>>>
>>
>> Keep all discussions public.
> 
> Get.
> 
>>
>>
>>>>> +  pccs-id:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description: Used to identify NIs in system which has more than
>>>>> +      one NI.
>>>>
>>>> No, reg does it. Drop the property. Anyway you miss here vendor prefix
>>>> and proper explanation.
>>>>
>>>
>>> reg will tell phy address. Phy address is too long. I just want a id.
>>> example: perf stat -a -e ni_pmu_${pccs-id}/cycles/
>>> I will use it in user space. Not only in driver.
>>
>> Custom vendor property is not for that purpose. Use for example IDR, DT
>> aliases or something else.
>>
>>
> 
> I have considered TD aliases. It's not very easy. Two places...
> IDR.. I have tested. But it chouldn't correspond to the HWs.
> I need it to identify NIs.
> DT aliases is reachable. But no very easy.

Except that "you want" I did not see any rationale, any argument
explaining why this is needed and why this has to be present.

Best regards,
Krzysztof


