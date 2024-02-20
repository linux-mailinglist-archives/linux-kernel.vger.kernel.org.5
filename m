Return-Path: <linux-kernel+bounces-72533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277B85B4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468461C20884
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDF5D725;
	Tue, 20 Feb 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mD7ct/s5"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962F5D48C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417249; cv=none; b=nG+SOdpDQ4yWx7VC8IcTcBpi5qeBvP2PowhqU1dOyYLu4TLuulN+WNxi55cXSYJD0UE+93VQ16ghY2BRhMg3CJxrfQ+gHjlv4RLNLyhG2Bh0I0gzxH52jkBe00OmuQ6eVBZHcDLQGKxyfDQi6bjnuQJC6h1V8TUS2twhscZ3Q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417249; c=relaxed/simple;
	bh=esQQTCwFnaz2VFx2osLghu+CKaVhUzw6mxOgxpZuC7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpaoq1kJsqLormnW6eYENr1dP15NuHM+In2nogVV9lFWvDXaX/T5eOlIFacsyEVXOIJMv8I0jIQep+vtsWMB69xc7zFuKXRfMgftCao23ffgH+DLIFiKIQSPQoLMslUHWApfJwWjjkyjn/a7t5by/r1wcG8qV4d4ThaWqZSQsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mD7ct/s5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so2894460f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708417245; x=1709022045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uP8r2h7BuNacWT3gapar2KulUotL4aqqTjjB0S3tcsc=;
        b=mD7ct/s5ywId56xBdxwxBgwnqonEvYoTdQMnKE9sfgqnhNmCLXFdAXpg+RSX1Z/xDr
         HIlWtmSK+IiPMZ1tvC3Rf3eYIm/CrZ8BwKk8N7ztYFWSc38DdGG8nYe6ZaHRW+RkrMcg
         xRUs0UWS7NBBKCVbKmoWIqdC7lwJxBfNa3OUZCkbxyXJ1qd8tLsa31Dz/QUNWYYayYtT
         oaTj4Kk65MiXViN9Z1EGgDNDo4HcfqDS0QRht1MENKXU8O4BrcK39IlpyEna2Lqhl63X
         wl8RnsDqMBgN/Vb5ZlcFEul9/TNZjCy6abVQHC9d6o0FbCf61xCICt6mfqs44tcvozxp
         jeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417245; x=1709022045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP8r2h7BuNacWT3gapar2KulUotL4aqqTjjB0S3tcsc=;
        b=p6vjOGumioHHt0xaRtkd91v3DHYmYILcGz7xLsbt7fCia6/lXjgW8o5IABAMWntL4r
         wMVrz5uxTuALT78N51hj36X0Tt+dPQ4gNFkUbkTJzXJQaSP+Atpq7DF09Q5fNnSYK2a5
         VkmXjauDsPP1qYnrH2s7VUODTe4tyqMIrHX/kGaFRfB17gN4za9dWheYEaSQ++prwbFC
         sa9yUcVCLbuGfyCfiiWkESmivX9ZPTicb1kSCBKGIt88rI5LtKs2ClwRV1OlYpmjfGvb
         /7/srN7lym95iirV/3M0MZspiIkFWbxB6GQFDTVWB9uEfD8jK4SXmB2nnKF7GeQ9dill
         3bBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA0SRNwRjZMI9zXXvZMvD4GYrpRMHeExNu3YB8l4UEmtcqgtXMyIp+13KzKm8ESSr7QVsYAeM7rRjiP6JQNAG6Lzeji0VblsVkK3SX
X-Gm-Message-State: AOJu0YwOKArnCNGEtUQn4czVo0gwShSjNL6ghWhtMApM8W5uydCm6nqL
	i6YwTzTRlM9rww+8KycIeztHOCHaQav+N0O0evFnMzPSXPbdps5G198XRJDvz9C7l96Xqk9owYT
	9
X-Google-Smtp-Source: AGHT+IEeGrdRgoUqwO+avqHllSzaJUzrnaeeb6gPAxfRsfBsQdvR2ZPNu2mngCGBPmTWum8vAx2hWA==
X-Received: by 2002:a5d:504b:0:b0:33d:282c:af49 with SMTP id h11-20020a5d504b000000b0033d282caf49mr6036147wrt.58.1708417244799;
        Tue, 20 Feb 2024 00:20:44 -0800 (PST)
Received: from [192.168.232.100] (31-187-2-233.dynamic.upc.ie. [31.187.2.233])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b0033d07edbaa6sm12661878wrs.110.2024.02.20.00.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 00:20:44 -0800 (PST)
Message-ID: <bc05fe84-0700-4587-bb18-eb39d30f10a8@linaro.org>
Date: Tue, 20 Feb 2024 08:20:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
Content-Language: en-US
To: Fenglin Wu <quic_fenglinw@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com,
 quic_collinsd@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
 <13baed68-1014-4a48-874a-94027a6dd061@sirena.org.uk>
 <f38468b4-8b16-4180-9738-0a2b557651a1@linaro.org>
 <dcce3fa9-ecf3-42be-adf6-ca653a79ba2e@sirena.org.uk>
 <3851e21f-f8cb-487b-9ed4-9975949ff922@linaro.org>
 <a09d6450-95e7-4ed6-a0ad-5e7bb661533a@sirena.org.uk>
 <df6a49f3-88e9-46b4-b7c3-e5419fd01eca@linaro.org>
 <6f6dfaa2-f529-c9fe-7dde-402c92f0daf6@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <6f6dfaa2-f529-c9fe-7dde-402c92f0daf6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2024 3:06 a.m., Fenglin Wu wrote:
> 
> 
> On 2024/2/15 6:47, Bryan O'Donoghue wrote:
>> On 14/02/2024 14:52, Mark Brown wrote:
>>> On Wed, Feb 14, 2024 at 02:44:56PM +0000, Bryan O'Donoghue wrote:
>>>> On 14/02/2024 14:13, Mark Brown wrote:
>>>
>>>>> Not just that but also note that every voltage step in the range will
>>>>> have the 8mV offset added.
>>>
>>>> The documents I have just show sensors attached to ldo3, ldo4 and 
>>>> ldo6 fixed
>>>> at 1.808.
>>>
>>>> I don't think there's any better or different information than a 
>>>> +200000uV
>>>> increment TBH.
>>>
>>> This seems like a very surprising and unusual hardware design, the
>>> 1.808V voltage is already unusual.  Note that this may break systems
>>> that are trying to set a range of say 1.8-2.0V if they actually need to
>>> set 2V.
>>
>> Hmm. I'm sure the rail value should be 1.808 its all over the 
>> documentation for example when we get to index 3 we hit 2608000
>>
>> REGULATOR_LINEAR_RANGE(1808000, 0,  2,  200000),
>> 1808000 0
>> 2008000 1
>> 2208000 2
>> 2408000 x
>> REGULATOR_LINEAR_RANGE(2608000, 3,  28, 16000),
>>
>> And there are other rails @ 1v8 if 1v8
>>
>> The one thing I can't easily verify is index 0 = 1808000 and not say 
>> 1800000 or indeed that the increment is 200000 and not say 8000.
>>
>> I'll see if I can ask around with the hw people and get a more 
>> complete answer.
>>
>> Similarly now that you've gotten me digging into this problem, it's 
>> not clear to me why this regulator isn't just a linear regulator with 
>> an 8mv increment over a range of indexes.
>>
>> At least the documentation I'm looking at doesn't elucidate.
>>
>> I'll dig some more.
> Please see the voltage steps for LDO3/4/6 described in the PM8010 TDOS 
> document which is the most authoritative that we used internally for 
> PMIC driver development:

I will look - however

1. The powertree internal docs for xe801000 show 1.808 rails derived
    from 1.856 rails for camera sensors

2. Publicly available with registration : 80-185821-1
 
https://docs.qualcomm.com/bundle/80-18582-1/resource/80-18582-1_REV_AV_PM8010_Data_Sheet.pdf

    Table 3-7 Linear/low-voltage regulator summary

    Specified programmable range (V)
    ldo3, ldo4, ldo6 = 1.808 to 3.312

3. The pmic ranges I'm looking at on the internal
    show increases of 8000 mv linearly

> And I do see from the document change history that step 0 was changed 
> from 1808mV and step 2 was changed from 2512mV, I don't know the reason 
> of the change though.

Hrmm...

OK, that's enough to investigate further.

---
bod


