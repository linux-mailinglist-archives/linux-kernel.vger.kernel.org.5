Return-Path: <linux-kernel+bounces-121694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B6188EC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95772B22D52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB38C137929;
	Wed, 27 Mar 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNIDloCM"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D5149DF5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560239; cv=none; b=fTA/GcgDAAKogEsLjqXWcEvQgv50mJVTDxGQs0XohPUFfL4zSZWsM41+Qp4eZL8GjVT10Vv3Tu0gx3LNJVu9V6ST2DeM7KREasUJkhxaTG96NsdidtgozmXkcMBivd7KLK/EQoJim5tyD5nBzcsQhPlkHCitI0JkNkmwkXZI9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560239; c=relaxed/simple;
	bh=gU8hpSisSp+6BtuvXahGOiszAjF5oU9mclXS6lx1AdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWMzSlunBIvXKINfY4sbYl7GVmPJDgFBcCiEArmyr3ypYiCF+V6GxL529gSXYrt8Ly34biTOWpCl+3C0QnjDMisAhqbcaKaOH7IEAcPnjfM8tj+ryk2nWWVluL9pFgXGoMvfNLEiZT9cgI0LbabnoEyFKrmGVakN0qVXfUmfCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sNIDloCM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso75319a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711560235; x=1712165035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xl0fD+b7ivyyV0fNt3GA+UpFmy9R06Vg+zROf9ZHvoA=;
        b=sNIDloCMFJjqu9QYGz+fcYzLrwblJ6WnlXcfYvpReT6sGciRciHKqGjA7d6sFWTOYP
         wb/eDze/zs7d6/QAyxik/ZOmPpWTqsIFCdLc8T67xQs1U2BLrWYVaaCq5O52FG03mS5b
         rUcp2v/Tif4SZC2BCurhklGeH/+gIP9jOCQWjLipLTq2mhQ4k1wHvVVLZkB9bciY6NQG
         +fVVy7Rx8iQj+DNE8Z3EthCJnKt7f/oecOqmNA3ltWuZ/cBHqJw56Y6GAo6mh8VtE14+
         YKe3/QPISRoNMSQrew4FiJrplO54exMDT7Bj7mi6fGZztoPiYE7GEpSeykY1Xsh3Fw4z
         bRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711560235; x=1712165035;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl0fD+b7ivyyV0fNt3GA+UpFmy9R06Vg+zROf9ZHvoA=;
        b=cYP88/fd5Kvev4aatYcHj50+5h3zrknlvGFnx683CoA5KKzIEYKyz3cdCpQmDvQMtR
         LBiGWhjON+aPq9cRYisfEPXacASmr7p8e6XRBs0BpRhAyqJQjZZAbUmOTbj5mbQy8P+Z
         Rmy3qtxVZSa4RVtwhcvMVn5Wzvs+xsr+7UKflA79op4Ku03IwcUwUVJ9+cuxrj6jFtkD
         8ovmwUCrQIZFOhirw74EVA1tx4VGYwSOfbelHvfZuqmcO+E5LDiLsy5re0FxhnXH3PcK
         C9lO7EiZY+YDgmaU3MKb1ikbgD3brKD3u96AHCeOrxUXMa2B4iYuhYnAzCWtoYIJQJXP
         yDdA==
X-Forwarded-Encrypted: i=1; AJvYcCXesSC8FO6Sf+0pe55+ys8+1zPeJraR3Tk3x8hpwBs+Kl2V3rfyZwV10R4rkqaB/th2dBCCWNYudId87ay6rTY39pg//aNi3o1wdfez
X-Gm-Message-State: AOJu0YxJ24QbaFN1/X9Y59I6sXGFtaRi1JAIjahCTb1PdcFAWHIZQitd
	YOMSw+wWHqeiGSxVl/naN+hdy6kHQfXH7cHDXMFqNxEvmx0CNIC3RNEfGmMqWvA=
X-Google-Smtp-Source: AGHT+IEluCUtWzQOjSzFx0UVf3642SUO5zAamjkbF8COFcQKtz+ZNExwbdYYcnuiqXsnawLe5A2SLQ==
X-Received: by 2002:a50:8a9c:0:b0:56b:d158:c5de with SMTP id j28-20020a508a9c000000b0056bd158c5demr306607edj.16.1711560235543;
        Wed, 27 Mar 2024 10:23:55 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id cs12-20020a0564020c4c00b0056bf96985adsm5299194edb.32.2024.03.27.10.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 10:23:53 -0700 (PDT)
Message-ID: <98a00291-8a8c-43c4-936a-cc337f5e1d7c@linaro.org>
Date: Wed, 27 Mar 2024 18:23:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/20] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-3-3dac84b88c4b@linaro.org>
 <b6d6beab-39f5-4f00-8427-52b662181864@linaro.org>
 <30945f7a-b18b-483a-bc43-99f913fb98c3@linaro.org>
 <072aacd2-fedf-485a-970e-a705748cc92e@nexus-software.ie>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <072aacd2-fedf-485a-970e-a705748cc92e@nexus-software.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.03.2024 10:55 AM, Bryan O'Donoghue wrote:
> On 26/03/2024 21:23, Konrad Dybcio wrote:
>> On 6.03.2024 1:20 PM, Bryan O'Donoghue wrote:
>>> On 09/02/2024 21:09, Konrad Dybcio wrote:
>>>> To make it easier to understand the various clock requirements within
>>>> this driver, add kerneldoc to venus_clk_get() explaining the fluff.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    drivers/media/platform/qcom/venus/pm_helpers.c | 28 ++++++++++++++++++++++++++
>>>>    1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>>>> index ac7c83404c6e..ea0a7d4601e2 100644
>>>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>>>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>>>> @@ -23,6 +23,34 @@
>>>>      static bool legacy_binding;
>>>>    +/**
>>>> + * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
>>>
>>> Get non-codec Venus clocks.
>>
>> No, this is not necessarily the case.. these may still include
>> vcodec clocks, that are specified under the root venus node (which
>> is the only way we'd like to keep)
>>
>> I applied the rest of your suggestions, do I keep your rb?
>>
>> Konrad
>>
> 
> Sure
> 
> BTW, I plan to test this series when I can - do you have a working tree ?

next + the patchset in question is a working tree..

Konrad

