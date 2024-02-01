Return-Path: <linux-kernel+bounces-48106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3084574F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0132B24313
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FCE15F30B;
	Thu,  1 Feb 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0Czepnq"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076215F309
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790049; cv=none; b=UewZ6hTC7pCtcfH8w97fsNCFfU3l1sqqQ5bYmM2fN8Z9jehxI5QFZJB7McQbiEXjz1jKBSuOai4NgpfmkBr93Yniq2IJNhCPCan3WmTUoRHW3Naw1um916Akh6gNsirG37c263hKlCH9boTDLraUzy0Ua7/BzsPEcjqDoSuJsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790049; c=relaxed/simple;
	bh=QWvJ3SA3Xq+JvR6s0Zz/XENYak92/3NXJdy/zoFH4rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIkabuMe+5UByXwt6aJkAdsF1A5xbzrkQQUzQjrTKHU/v/kDeDYQgR0aobXj+e5xgVkfTKeYXfpFj58c05R+vxSdn4ZDz65uNqoSr+RTPN4Ber2DiC1e6IF2qNyRO/maPJPJ7OMXSEBEuuULKcHJbg/NzrQ5xBNW7ojOtiwO2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0Czepnq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26f73732c5so122160866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706790046; x=1707394846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leZ9SLmBHoZD2cMB+YqriNbTiJT/YPKPjDIiSxiUUJk=;
        b=i0Czepnq7+cQiD7cVJjtVmQpbTKkqrXDjDEgW9q+gNlb1d35AqZGxWg+cK9ffQmgzR
         0AOokqPy+b1ZXvJxTau6Nv2yGIp6sUaGhq15vMt5Mxc1HY4fD9a4FVairzDbOpf5eFHa
         obB1rt0E3V9uArkda2DFxygxL2izuM/EbNFFIwXVTQXYWrQckMaUP44zoPzaeZkmvINL
         fL3ohvO62aYN7yt0YQKiKxTb9QTdb6iY0ksdy/+u66xfz8mjJnXfLH5R/JV59ekzHmy3
         pmJyejMMkuaINnAdAzHYg39pd6JPW2O07PIuIxoJMv0mO6ABri9A/SpMt6FqFfth1lPV
         BCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706790046; x=1707394846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leZ9SLmBHoZD2cMB+YqriNbTiJT/YPKPjDIiSxiUUJk=;
        b=glYrdHZC5eUB+1Vlup3/29agi/es4r8PZd30rWsfyT0Bi80mJwtAJWg9F4RYhqB0xr
         wsqKNMjYU6xY46D1VqWwTk6hkeT65G2pjbF3cuCDONE3waEJ4alJ9U59n8nCFo45iL0u
         kwWEVvCg4KDWzCZUCh19gQPLkHikoV0GIVvkxakG/28UKoY9AmhiXFOTa55ChVQqEkfC
         M2HKJTolMxlafvvRuWl/mFBjVXOF2u5h8re/tH8cPQ2Y+dcJa+RSUibPAbm0UervS1gL
         /2ie7s8OXaSVv1vDZlNxSAdPUfvFtOVBxgzBSGY6SX9B41c5dGNg1wg0K1NsGTS9XC+C
         2vuw==
X-Gm-Message-State: AOJu0YxzFG7eh+VSj58buZLhj/NEYf/NJ8Y9ewuZLPcY5U5dskdLGegp
	gRvKDRWl005qujmda4NVtg4Tt4ulIY82VBaoigaD/nlIgy313jz/q3TDXAVLgxE=
X-Google-Smtp-Source: AGHT+IEVYeWyZ03x3ptIqUAlTY6fdXwg8sWM1H983Hi8+DNy1GWOVNHmfh7It3D2D3i2fDemLQYwYQ==
X-Received: by 2002:a17:906:fb84:b0:a34:d1a9:77ad with SMTP id lr4-20020a170906fb8400b00a34d1a977admr1638729ejb.22.1706790046038;
        Thu, 01 Feb 2024 04:20:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUh1qa1LY8FiGzn4Y+l7K+NBC31M8gfimlg7ort33zy/KcJ/OdeA7IsFnU7rW1+rg9iMxE+IhfadWRo0GEanOGmhwfxasTYtphk+N4Tp6bGQ4JETaOuiz0GuyHlnUUxuRC5nnjZIf+048Nu9DiN/UpPI+sIIUB3l0Hw037qb8tWr/ANUDMNxA+tx4uz9J0ZPb25Ofs9uX5orOkNe+0MLaFSELAiHU1ctCQewd2BDDKynkQiRhVKrK3ll8xYYnyK08cgXPGMJYtUnJfsaliRnW8JnDK9mEJ0R+7OIr6DLyd9diIWFFRa8oWbuRaT7iFbj9WlN0rbqLk1MyWkVr/AhE72tenzg+7L9zm4v+bYUX1oIiWP4wcwqXOt8t6lx6XHyMejQbEqKDEq/7bTmWW+dOiFtA1qGyPpCgqYM8vazA8OwvEOWUTtYj5qhQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id mm27-20020a170906cc5b00b00a35aeab95b5sm4501957ejb.185.2024.02.01.04.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:20:45 -0800 (PST)
Message-ID: <5c6fec5f-79ed-4c93-b337-68a2c25d8a44@linaro.org>
Date: Thu, 1 Feb 2024 13:20:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: aim300: add AIM300 AIoT
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Qiang Yu <quic_qianyu@quicinc.com>, Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-7-quic_tengfan@quicinc.com>
 <d3ef45cf-2de8-4f5b-8857-62d1996f3f58@linaro.org>
 <842bf6ad-46e1-43d8-86be-79ab0f49710b@quicinc.com>
 <c17dafd2-db89-4fe2-8e98-2a031f7237c2@quicinc.com>
 <b28904a6-c1ef-44b5-96ca-313a9a2a3f8b@quicinc.com>
 <3e3cbc36-2f3f-4295-9325-90757f0d77ce@linaro.org>
 <012bb387-2472-4bcb-ba87-3bf75dd88d64@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <012bb387-2472-4bcb-ba87-3bf75dd88d64@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 13:16, Tengfei Fan wrote:
> 
> 
> On 2/1/2024 8:03 PM, Krzysztof Kozlowski wrote:
>> On 01/02/2024 12:49, Tengfei Fan wrote:
>>>>>> This should be probably TX SWR_INPUT1.
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>>
>>>>> I will double check this with related team and I will update this.
>>>>>
>>>>
>>>> I will apply "TX SWR_INPUT1" on audio-routing node in the next patch
>>>> series.
>>>>
>>>
>>> This patch series has been sent for nearly two weeks. do you think it is
>>> better to modify the patch series acording to the current comments and
>>> submit a new patch series, or continue to wait for your review comments
>>> on the current path series?
>>
>> Hi,
>>
>> Whom do you ask?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Sorry Krzysztof, can you give sone guidance on whether I should update 
> patch and submit a new patch series, or do you need time to review 
> current patch series?

Up to you, I do not plan to provide more reviews on this. I just
commented about this thing here, because I was doing similar work for QRD.

Best regards,
Krzysztof


