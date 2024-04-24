Return-Path: <linux-kernel+bounces-156864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F58B096B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB8D1F254DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84C15B56E;
	Wed, 24 Apr 2024 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VHdqBnNF"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5E15ADBD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961545; cv=none; b=QNoM7Xqb/me5EdRPN05S99x6pen13C++EH6IsCwTntVvSiLYPM33nyPRpHuGDip+c9nmmcUdkqYEmSQ1W0Sr3p12Q3GN3u16SbrqgnRvYlP2PPuZs4+Rsp/okpNdS56cpd8kbpxupVCJ2OmJl1HZcvCbVCqxKYXS/IVdzvoXljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961545; c=relaxed/simple;
	bh=OUnlVrtOA8bfYKyxgEQlwedfzZMyoS8iLwh26XS6VIc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pG+djGW3IzEWfFNkmNB5dDJPwF6VtKgjRU5TQ6jSDJ1JTJrlkpDPKyiFgJ7BlFEx4E4Ep4AYI2IRdCcUM/P2fs3BiauowdRV12YoG91Vfu+l99qHT8fsXxMPiHnKnDzkJhnU43Jl0QuBNCatSkcNmLdB4MB8xXBJQG9dkHgQ1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VHdqBnNF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so62302861fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713961541; x=1714566341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kxsp6XgbCGqnM98GPeUTVgQx/m9yaIy5tDfehUmygVg=;
        b=VHdqBnNF3CHmbEZ3dqufwUn56+xJSPmxFLsLH3L+ymETyTFz/JXZRss+ZQnrdEMF3D
         Vh/pFxb3g25qvJoxvdl3NfbZrd1aOz/pbKgK04bbN0qaRAbG/4fOT23G/Eya56S/1HCX
         WvrPjINHaFkYqWr4mnUDUNM3lj1NHnwVkLnsQQCT3ZN8Nxf/7FXWRfaoVTqmPL6wwRdq
         NE1GZMEbcUV+YydNbu9aEZYHj/scj7mq0TEZd9fVfozEeTbu+qDr0vD3i1LeBoE8zqHN
         VgPwkF4/AIExdocUaO6WlcLxdv86h4+Pa31HsPhgG192vyNiS3AHFOlv7i0hzD9Tgouh
         MRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961541; x=1714566341;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kxsp6XgbCGqnM98GPeUTVgQx/m9yaIy5tDfehUmygVg=;
        b=GhtwZd9iIswnlj9jkJlS1zqJ3mp1VgmtzhxX9Si0La3OCapKVEzLK2zg5wpvfum540
         RKOgFkOoMvMjaiHioNaLpGwAHCURqnvpK//le7GszGncgjWwECjXqtSLC5z0lBIRdN4P
         E0T+kWJep+rUjshJTSi5eMqH3VOYfrh8bTsYWoTQDOqojfUMpMvBolJWFZ+/gp4Y9GfG
         BhJEWk51BXqjDICvAaaydvxe2GvnRXobNlYIYW9I8Cqp8gIxqbCdUdjJWsNci/p9LAS7
         rJZ/79r7WfNP+RnVce5fM5qtOtvJlm0VMNlF3t3emEFmgNC5MbBbqekC2xZwPK9C3vsU
         hwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOcX5VtDj++RwnE9OPbGyN8jDDQD9k/igs0HV5xhgoeo94UwbWIgVh9xUHqSiF2jjPD9KaqSB1pDX1/KMFjqBML+T7zfHGx3R2HV5p
X-Gm-Message-State: AOJu0Ywjw5jvvR9EavF67er242EWYlOtCRqJTrW83FJ+8x+UoVrvu6hD
	zXKvVXEOzm/1pCb31uRl76ZmCpYp7hI7qOJfLYvSDaUtOuEGv5eRDmXZYNQshXw=
X-Google-Smtp-Source: AGHT+IGisWWM3dOSMD/2TLTmlTpO/DkDiI5dyGZfRTU/1KaVCsR4C5njQohN6cTWFWdeG9//MP/iDg==
X-Received: by 2002:a05:6512:2383:b0:519:2a14:8511 with SMTP id c3-20020a056512238300b005192a148511mr1977508lfv.69.1713961541257;
        Wed, 24 Apr 2024 05:25:41 -0700 (PDT)
Received: from [172.30.204.128] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id cf18-20020a056512281200b0051bb99b8946sm175720lfb.146.2024.04.24.05.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:25:40 -0700 (PDT)
Message-ID: <48326406-98c1-43c5-8c96-7e861b07efab@linaro.org>
Date: Wed, 24 Apr 2024 14:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 3/5] clk: qcom: gdsc: Add set and get hwmode
 callbacks to switch GDSC mode
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Gross <agross@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-4-quic_jkona@quicinc.com>
 <e70e0379-cab0-4586-825e-ade6775ca67c@linaro.org>
 <e419c6aa-6bb2-48ff-bacb-17a2e85856ea@quicinc.com>
 <0ed739d8-7ef6-4b0d-bd61-62966c9a9362@linaro.org>
 <2e8f5e93-1f24-4451-ab9f-ad1e7d98bc65@quicinc.com>
 <603aef24-a8ad-4c39-8c5a-846139f77a77@linaro.org>
Content-Language: en-US
In-Reply-To: <603aef24-a8ad-4c39-8c5a-846139f77a77@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/24/24 14:22, Konrad Dybcio wrote:
> 
> 
> On 4/24/24 12:27, Jagadeesh Kona wrote:
>>
>>
>> On 4/24/2024 3:25 PM, Bryan O'Donoghue wrote:
>>> On 24/04/2024 10:47, Jagadeesh Kona wrote:
>>>>
>>>>
>>>> On 4/24/2024 5:18 AM, Bryan O'Donoghue wrote:
>>>>> On 13/04/2024 16:20, Jagadeesh Kona wrote:
>>>>>> Some GDSC client drivers require the GDSC mode to be switched dynamically
>>>>>> to HW mode at runtime to gain the power benefits. Typically such client
>>>>>> drivers require the GDSC to be brought up in SW mode initially to enable
>>>>>> the required dependent clocks and configure the hardware to proper state.
>>>>>> Once initial hardware set up is done, they switch the GDSC to HW mode to
>>>>>> save power. At the end of usecase, they switch the GDSC back to SW mode
>>>>>> and disable the GDSC.
>>>>>>
>>>>>> Introduce HW_CTRL_TRIGGER flag to register the set_hwmode_dev and
>>>>>> get_hwmode_dev callbacks for GDSC's whose respective client drivers
>>>>>> require the GDSC mode to be switched dynamically at runtime using
>>>>>> dev_pm_genpd_set_hwmode() API.
>>>>>>
>>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>> ---
>>>>>>   drivers/clk/qcom/gdsc.c | 37 +++++++++++++++++++++++++++++++++++++
>>>>>>   drivers/clk/qcom/gdsc.h |  1 +
>>>>>>   2 files changed, 38 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>>>>>> index df9618ab7eea..c5f6be8181d8 100644
>>>>>> --- a/drivers/clk/qcom/gdsc.c
>>>>>> +++ b/drivers/clk/qcom/gdsc.c
>>>>>> @@ -363,6 +363,39 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>>>>>>       return 0;
>>>>>>   }
>>>>>> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
>>>>>> +{
>>>>>> +    struct gdsc *sc = domain_to_gdsc(domain);
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = gdsc_hwctrl(sc, mode);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    /* Wait for 1usec for mode transition to properly complete */
>>>>>> +    udelay(1);
>>>>>
>>>>> A delay I suspect you don't need - if the HW spec says "takes 1 usec for this to take effect" that's 1 usec from io write completion from APSS to another system agent.
>>>>>
>>>>> You poll for the state transition down below anyway.
>>>>>
>>>>> I'd be pretty certain that's a redundant delay.
>>>>>
>>>>
>>>> Thanks Bryan for your review!
>>>>
>>>> This 1usec delay is needed every time GDSC is moved in and out of HW control mode and the reason for same is explained in one of the older gdsc driver change at below link
>>>>
>>>> https://lore.kernel.org/all/1484027679-18397-1-git-send-email-rnayak@codeaurora.org/
>>>>
>>>
>>> Right.
>>>
>>> If that is your precedent then you seem to be missing the mb(); between
>>>
>>> gdsc_hwctrl();
>>>
>>> /* mb(); here */
>>>
>>> and this
>>>
>>> udelay(1);
>>>
>>
>> Sorry, earlier I shared the link to base patch series which has mb() used, but in the mainlined series of the same patch mb() is removed as per the review comments.
>>
>> Please find the mainlined series link:-
>> https://lore.kernel.org/all/1485145581-517-1-git-send-email-rnayak@codeaurora.org/
> 
> Mostly because mb is a solution to a different problem. See this talk
> for more details:
> 
> https://youtu.be/i6DayghhA8Q

(long story short: you want to read back the register right after
writing to make sure things arrive at the hardware when you
expect it to)

Konrad

