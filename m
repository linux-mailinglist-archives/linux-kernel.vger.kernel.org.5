Return-Path: <linux-kernel+bounces-74205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71085D121
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5E01F276CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591753AC14;
	Wed, 21 Feb 2024 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvWkElj5"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018B3A8CD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499961; cv=none; b=fR2H15luht1INdxSZxPLfAvKLjXQ/Q+ZE374pQSc+aIslgjHGbpfI7wac4gDU0jT0l1jgtWdMFd61w6jFar+AvS+AhIAS9DwsDkAs3TqnasfIZVpDhTAvPFbFc5vSQh0O0NZEJwFXU1GZsIqrrw12KHSPBy8MnISoK3lmTOFHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499961; c=relaxed/simple;
	bh=FpSzc/ULvmybbFen93pqpymAOq0L/uqCZruUCXdcO9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxiFi6giu7gnCM/1n72jOu9l5nsTBPfJ12akFH9shsfhLn8sZf9usj8pHh3vnIWtbLLgnJHX/DW8rNsN3Qh09ZUoLoBEk5EcL9Zo3PCWCEwmexnXsumKWtGoGTCfL3pSGnbULILvWiD4gePTRRKnrxx+qSr54dM3ovf46OTT80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvWkElj5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3566c0309fso741211966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708499958; x=1709104758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DsXkNm/a06dOSvB/DAXcgIlUfR6UQeZosO9CYoPE5s=;
        b=PvWkElj5v64WZ5qZiBV1dcZbtEOq+LUw1R6HbucxcwqcrKYpM5iS0+PWBiqoLpJAOy
         f0MOMa3hLUgXF2sSM5lyRpBHYdf++HFGo1psn1kiLoNB5zXeynglf6gHZGLvA+UetivO
         IceHWvAVr55UfrauBtfx3bCECTH/emwWWBkND4GxuucGlmWCn2n4SzbN+4P7p03qfSWB
         PT+pNfhTl3gddm979g8/ZwRGuZH4n83/QsFBEReHoKdBUlNS4/9CS3zy1SxGK2ODA/MD
         yeF8Ikxj1QPoTLK/563+zq6U88zrQTVeJG2YZ+NYM+lITeCS86GscgssSA+yqaqgXqAM
         jHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499958; x=1709104758;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DsXkNm/a06dOSvB/DAXcgIlUfR6UQeZosO9CYoPE5s=;
        b=fzQ2qzVA4ABxAPfpMOquMcmfy+DnVetSCOL7wAEAIlcaL5z7KNY2GaDI1CQKphwbNF
         nOmExsOHxAE79AVsdG3npgv+EzvB48x1niIsmMf4Ih3lfzDfOH2bOXBgXhXdP2n8E+aE
         YdG1OugspN/KFg1Lrj+oMtK2tMEqzhq1s81uFgaJX5aO/js4iwQLDeIOx83+AP9gR5FF
         c4Axay7PSVz2t3/R459Hr66twAV0NjSAWLbMXCyIM3Ya+U43stkWJHHQSvOp+73xn1wU
         0xjY+tknYH2dDpjhaYCFsHpmoJMJWg/UfWhEdCZicnJDkR5LkKnX1Kxy7fGAOnYvTP96
         EsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvaLmcZvU+QDbv+/0jrgIn+vOQRlF/rXX7vrucqd2OmqyDcHncfc/pLNoA3v/4tGAk5Gty9I47w6hsLsQl941OKV8j6ZM8vnn3HY+g
X-Gm-Message-State: AOJu0Yz8rwpOODOOK25v+q+mC4EKKASrzi8WoipUI6AEel/vZnnYEb3t
	MNQqZxtNjCFokXV4a+2c7Ik6bfN15EOe40d2MeiIYiBZg5/0kxOEwiPMEo+gpLk=
X-Google-Smtp-Source: AGHT+IEZORZ8nfJo15O+GNR1nZluGd+MjprHCLUWhw0uH1DXD508rb4uNBFikxFtGZLNsWs1xXLUTg==
X-Received: by 2002:a17:906:26ca:b0:a3e:ed41:1403 with SMTP id u10-20020a17090626ca00b00a3eed411403mr3527569ejc.27.1708499957738;
        Tue, 20 Feb 2024 23:19:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906168800b00a3e7a2d9ac4sm3172817ejd.6.2024.02.20.23.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:19:17 -0800 (PST)
Message-ID: <d3dc9a41-4738-4634-9a98-fefcf418f552@linaro.org>
Date: Wed, 21 Feb 2024 08:19:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Content-Language: en-US
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
 andriy.shevchenko@linux.intel.com, daniel.lezcano@linaro.org,
 dmitry.baryshkov@linaro.org
Cc: lars@metafoo.de, luca@z3ntu.xyz, marijn.suijten@somainline.org,
 agross@kernel.org, sboyd@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linus.walleij@linaro.org, quic_subbaram@quicinc.com,
 quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
 quic_kamalw@quicinc.com, kernel@quicinc.com, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-3-quic_jprakash@quicinc.com>
 <3f812ffa-ec33-448e-b72a-ce698618a8c1@linaro.org>
 <13f2b558-a50d-44d3-85de-38e230212732@quicinc.com>
 <f52b2d5e-b2b4-48ae-a6a6-fc00c89662d2@linaro.org>
 <0b9e807d-e0ca-411c-9a2b-3d804bdf168c@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0b9e807d-e0ca-411c-9a2b-3d804bdf168c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 06:36, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 2/17/2024 7:43 PM, Krzysztof Kozlowski wrote:
>> On 16/02/2024 11:39, Jishnu Prakash wrote:
>>> Hi Krzysztof,
>>>
>>> On 1/4/2024 1:48 PM, Krzysztof Kozlowski wrote:
>>>> On 31/12/2023 18:12, Jishnu Prakash wrote:
>>>>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>>>>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>>>>
>>>>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>>>>> going through PBS(Programmable Boot Sequence) firmware through a single
>>>>> register interface. This interface is implemented on an SDAM (Shared
>>>>> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
>>>>> than a dedicated ADC peripheral.
>>>>>
>>>>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>>>>> channels and virtual channels (combination of ADC channel number and
>>>>> PMIC SID number) per PMIC, to be used by clients of this device.
>>>>>
>>>>> Changes since v2:
>>>>> - Moved ADC5 Gen3 documentation into a separate new file.
>>>> Changelog goes under ---.
>>>>
>>>> Why did you do this? What is the rationale? Sorry, this patchset goes
>>>> nowhere.
>>>
>>>
>>> I'll elaborate this more in the next patchset. There are two main
>>> reasons for adding this documentation in a new file:
>>
>> This was more than a month ago? You reply to my comment with 1.5 months
>> delay?
>>
>> Sorry, I am not in the context and I am not going back to it. I have
>> many other emails where my questions are addressed faster than 1.5 months.
>>
>> The patch is not even in my mailbox, long gone.
>> Why you are making it so difficult for reviewers?
>>
>> You will get answers like I am not in context, sorry. Next time don't
>> respond after 1.5 months.
>>
> 
> You're right - I'll do my best to get back to review comments in a 
> reasonable time frame.
> 
>>
>>>
>>> 1.This device is not exactly like the existing QCOM VADC drivers as it
>>> now combines VADC functionality (reading ADC channel on client request)
>>> with ADC_TM functionality (thermal threshold monitoring).
>>
>> Does no explain touching bindings. Your drivers don't matter for bindings.
>>
>>>
>>> 2.Adding this device's bindings in the existing qcom,spmi-vadc.yaml file
>>
>> No rationale was provided in commit msg.
>>
>>> is not possible as it would require updating some of the existing
>>> top-level constraints. (for the older devices in that file, "reg" and
>>> "interrupts" can have at most one item, while this device can have more
>>> than one item under these properties.)
>>
> 
>> How is this a problem?
> 
> In qcom,spmi-vadc.yaml, we have the following top-level constraints for 
> the "reg" and "interrupts" properties:
> 
>    reg:
>      maxItems: 1
> 
>    interrupts:
>      maxItems: 1
> 
> For the ADC5 Gen3 device being added now, these constraints cannot be 
> followed always, as there may be more than one peripheral under one 
> device instance, each with a corresponding interrupt. For example, the 
> above properties could be like this for a ADC5 Gen3 device:
> 
>      reg = <0x9000>, <0x9100>;
>      interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
>                   <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;
> 
> 
> I could not overwrite the top-level constraints for the new device 
> "qcom,spmi-adc5-gen3" alone in qcom,spmi-vadc.yaml, so I tried to remove 
> the constraints from the top level and add them back conditionally for 
> all the device types separately, but you told me not to remove them 
> (full message: 
> https://lore.kernel.org/linux-iio/832053f4-bd5d-4e58-81bb-1a8188e7f364@linaro.org/)

Because top-level widest constraints must stay, but it is not a problem.
Most of the multi-device bindings work like this. Dozen of Qualcomm. Why
you cannot do this the same way we do for all Qualcomm devices?

> 
> Since these constraints cannot be modified for a specific new device or 

???

> removed, I think the only way to accommodate this new device is to add 
> it in its own new file.
> 
> Is this a sufficient justification for adding this documentation in a 
> new file or do you have any other suggestions?

I already gave you the suggestions and you ignored them. Do like we are
doing for all other drivers. Don't re-invent stuff. Either this fits to
existing schema or come with common schema (and then provide rationale
why it does not fit to existing one).

Best regards,
Krzysztof


