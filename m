Return-Path: <linux-kernel+bounces-101260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0151087A4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF3A283847
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B271B97C;
	Wed, 13 Mar 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUDwBOuH"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F91B965
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321084; cv=none; b=EiySyYeLut6sbV9IDq8kEe2gRPR51vpOy7mLwUeVnSSSRweYNsyvuyDrYmd49BE1kuRjmEvFLDfAeTSoRW8t3x+B0alkjNVocwZWTAOR6Mmbg0+xxtMCsGmU87jCeCJc1fPo6/LdjkLRgaNgU5vPbQnkpAB4vK7W9ruQUth55AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321084; c=relaxed/simple;
	bh=Nog9/N+tAoaZ/MSBuyxW5ZeNiDO+1sNCdlgEZW9LEvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGaXSaKDRiOnelHtJZQ+nqcFALpKtkYpyTa3YmLyiS4uDHaTA3RWsLoofkUfRYPpvq4k+cXhoX8oHxwPqNE5Ye0wP7+5+/T/ltiU547ahjoZ6P045NxXv3GTfIz5AGJDfQIbtAT7JUUtPbot27YspC8Tb1duZRndxG7x6leegiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUDwBOuH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-413e642806fso5460245e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710321081; x=1710925881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1xxNpv8nSMeQDbbmL4FBnSN4DODov6zXmAugtpqIgo=;
        b=cUDwBOuHRQ3hHhbZReAKGCH14J9TKFwlPgTU8uy8Dzl0+pzqqoRs2TWQt4EFOP83eN
         gV/FfS0nR5SNBv+G2ZbZRVZVmBPlmNZq5AuROIAMpu5IuAe5fvyKHpMLv+jmoRY7B6vM
         /uB4NFFhA1HaDFy9c9LNTOWjpOzgqzg7TH//okBT3bW2BF3H4jVv1d8hrF9WGrOt6cG2
         U2r8/M1UsbMDPIE76w4cghyv15QOLCslXwk15jrMW/zUfUjtQweKCXzgSx+6qQmXqzwe
         QUleO6QXg64MJy+mzr9/e7YQAsoiMSTud6lNg+GGKTNXeEQaKMhJ7RPySXONh0IpDExF
         ajIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710321081; x=1710925881;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1xxNpv8nSMeQDbbmL4FBnSN4DODov6zXmAugtpqIgo=;
        b=JZMPW+vI+e4mU153VzVKJi+fnz8smrELBYiRkIYmBstZkYvLBq0QRFGs5DAvkiDa+A
         xU4zpVnus8jQsbcsDt8NwvnAjBN2us4oejXWVkVZN+alpC2tw6tuYs4sac0DYlowlNbK
         lCjujk2vSG8aoCYnTLkraAyl50CSVhZeOIXa4oP8SrddROvAkgcYW7DZUF+xQKn4erhX
         ZtSuh10YBWc9Mu7dFAQZFwlY2peXkaD+KWcxeXSWG98DB4aVXAtO7xzmrkeNzW/vqjQ2
         gTRHY3WvnEwkdyhFKVNB94jXP9BWao2hkJ4P2BsayKv2DPumchvac//2UXFLNtyz6QFS
         qSWA==
X-Forwarded-Encrypted: i=1; AJvYcCU0nxB3L3UbdY8Ta1TzG12bbZfwVhHEuxbqvTzgY/ZarC4oZES9sZN2h0DkUQAWknusO0F+Ky9J0QiS9wLdxBJW/L0us6z0nfg2lS57
X-Gm-Message-State: AOJu0YwbQsHSlelU97LUdp1V+hTwNCZIlJ7fadh7J1vMqWXYh8fynmrl
	0Q3ppRxe2pXw0lc5Z0W+G8ZzGoo6M/LKCcfSJWukZO42HSMissE+qdkELqFBUP0=
X-Google-Smtp-Source: AGHT+IFcIqvxWLpB8JHMlbhQKytC3+T7HJ36QXDJC4qPN5ur6HK+IC13Up1+viwWIC5QehnNlCMqQQ==
X-Received: by 2002:a05:600c:4f52:b0:413:1d9b:4d2 with SMTP id m18-20020a05600c4f5200b004131d9b04d2mr3560513wmq.15.1710321080720;
        Wed, 13 Mar 2024 02:11:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b00412f016a151sm1709363wmn.9.2024.03.13.02.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 02:11:20 -0700 (PDT)
Message-ID: <15e344a8-8ad2-41f2-a8ac-6e5d1627c19a@linaro.org>
Date: Wed, 13 Mar 2024 10:11:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, linus.walleij@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240312025807.26075-1-quic_tengfan@quicinc.com>
 <20240312025807.26075-2-quic_tengfan@quicinc.com>
 <0d768f17-22d9-448e-9253-8498b61bf71e@linaro.org>
 <31b02b76-88ff-42d7-a665-18d2661e028c@quicinc.com>
 <6a3b5c9d-6375-457f-83c9-269746c1612a@linaro.org>
 <ef237b3c-8613-4cd8-9391-e4a08d50cc6c@quicinc.com>
 <60a0e51f-dc0e-4bbf-8127-f987ac2aae71@linaro.org>
 <f515f9f4-b87c-465b-83c0-f4b7b5c47840@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f515f9f4-b87c-465b-83c0-f4b7b5c47840@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 08:55, Tengfei Fan wrote:
>>>>>> Wasn't this applied?
>>>>>
>>>>> My test code base on tag: next-20240308, this patch is still not applied.
>>>>>
>>>>> In fact, the following dt binding check warning only can be got before
>>>>> this patch is applied.
>>>>>
>>>>
>>>> Please read all emails in the previous thread. You ignored two emails in
>>>> the past and apparently one more recent.
>>>
>>> I don't know if you mean I ignored the email which related with "Patch
>>> applied" tag from Linus Walleij. If so, the following is the reasion why
>>> I still include this patch:
>>
>> Yep, that's the one. Please do not send patches which were already
>> applied. It causes unnecessary effort on reviewer and maintainer side.
>>
>>>
>>> I synced the latest upstream code on 03/12/2024, the latest tag is
>>> next-20240308, this tag still doesn't include this patch[PATCH v3 1/2].
>>
>> Happens, considering Linus applied it after 8th of March, I think.
>>
>>>
>>> Dt binding check still get warning if I only send [PATCH v3 2/2] patch
>>> to upstream base on next-20240308. so I include this patch[PATCH v3 1/2]
>>
>> If you send patch 1+2, dt_binding_check will have exactly the same
>> result. I don't know about what sort of dt binding check you talk, but
>> for all cases: you changed nothing by sending these two patches in that
>> regard. Only noise on the lists.
> 
> The dt binding check failed which Rob Herring remind me in previous 
> patch series as the following:

This does not make any sense. Whether Rob runs his test on previous or
future next, changes nothing in regard of this patchset being sent with
duplicated patch or not. The result will be exactly the same for Rob.

> 
> Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
> /example-0/pinctrl@f100000: failed to match any schema with
> compatible: ['qcom,sm4450-tlmm']
> 
> This failed is introduced by 
> https://lore.kernel.org/linux-arm-msm/20231206020840.33228-2-quic_tengfan@quicinc.com/. 
> Something got broken aroud -m flags for dtschema, so indeed no reports 
> this unmatched compatibles warning when this patch was revriwed. We also 
> have some discusstion in patch email.

Again, not related at all whether you send patch *which was applied* or not.

> 
> The patch[PATCH v3 1/2] is made for fix this previous patch dt binding 
> check failed. So dt binding check failed will disappear after this 
> patch[PATCH v3 1/2] is applied.

And who is supposed to run that dt binding check and on what base? Your
patch changes absolutely nothing in that regard, just creates confusion.

And the fact that you keep arguing over this simple case, reminds me
other clueless discussions I had with some Qualcomm folks. None of the
arguments you brought here justify sending patch which was applied.

> 
>>
>>> in patch series even if this patch have "Patch applied" tag.
>>>
>>> Looking forward to getting your advice if submitting patch series this
>>> way is problematic.
>>
>> Do not send patches which are known to be applied.
> 
> Yes, I will be careful not to resend the patch which have already been 
> applied in the future work.

Then why do you keep arguing that sending this duplicated patch was
correct approach?

> 
> Do you think it is necessary to send another version patch series for 
> remove this applied patch[PATCH v3 1/2] from patch series?

No. It is merge window, please read process documents in Documentation
directory. Then please read Qualcomm upstreaming guide.

Best regards,
Krzysztof


