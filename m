Return-Path: <linux-kernel+bounces-11444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0781E673
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF371C21DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D64D11A;
	Tue, 26 Dec 2023 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kq4VXrax"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A174D58B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-554de45baf3so1763040a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703583416; x=1704188216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq/IL+aI2wvzsv74vMm6XI/3SuDRb0LU/4Y+hul9Li4=;
        b=kq4VXraxutFoQwGUGX0k0dIc1r28SkaOsyyBDpS61Ds4OyzcXy6XtUB8rjUHXlNNRq
         5sMAvoEfOYlIEdshBjdLjL4dRJJEiQAd4OTt4zOPKw/k2ivkz5EAqj9WpJYMX+M/CX6S
         7Z3uuEfb1HH0+QJGQaPAABSxclZcBM9WlY36K9P53jeq2GMt+ac4OoULMwigQqNwtZsB
         LvCbM4M+eRQQsI76z6zD+1iA0q8mV33fWnCvTjCKZ1PeMmceS7IaYwzDB410HhqnOEFX
         54sOCm37nORawSecU/psmpCuVRmqRPi/FoXa0tArRLjCzEM9/YmSsKx54qqwTMo0Um5d
         aV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703583416; x=1704188216;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aq/IL+aI2wvzsv74vMm6XI/3SuDRb0LU/4Y+hul9Li4=;
        b=RLbx4H1ell9+jTN9/ubjy4iErHO8rEO7x1CJaJaEtoIAuq9YQiyOyqyvEkze92KcLA
         Tjiwo3EIeJCqOawEqP5X1vmXUoGW/oy4HNH1EnpSRomNGajIuv7PGuWU85qLBeFVR98v
         FidE1APrNBNjspUGsrjzjRYn6CvblhI7YJgx3M+pPlq7p5pxdRkLQpqNSAaGPz8K3JA3
         ifveCfPmYyA7284v1Nh0TmMyRyh4FcZAK1i9F24iGHbwKtS9HfvBETGncS8VPqTSspb6
         1EZj0NTE1MVDjnvdD0Sm9XaDA8Ni5pSsve3hs1HIUrDtgqlcbaEMo4BcPQHsqcNWXeT2
         bK6Q==
X-Gm-Message-State: AOJu0Yz/Rtr8r9Zx7/Xv8Nz2jk167RIoWBR8CZqqFsOw+fiDgy8I0RfU
	YkqrDmBDsNv06YwvTl2HgfFs3ztw8IWAfw==
X-Google-Smtp-Source: AGHT+IEm1vJdt9n9NRZSWj/SNczfh/2xCjOJy1cy7kFhPScEs4b0wVDQzpiJQU5OzyhUd+AdTWe50g==
X-Received: by 2002:a50:cd14:0:b0:554:3bdb:52c6 with SMTP id z20-20020a50cd14000000b005543bdb52c6mr6318482edi.6.1703583415889;
        Tue, 26 Dec 2023 01:36:55 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402044200b005553a8bb61dsm72021edw.87.2023.12.26.01.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 01:36:55 -0800 (PST)
Message-ID: <578d6319-5ab5-45e5-8457-00116c7c84ae@linaro.org>
Date: Tue, 26 Dec 2023 10:36:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: coresight: Update the pattern of
 ete node name
Content-Language: en-US
To: Jinlong Mao <quic_jinlmao@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>, coresight@lists.linaro.org
References: <20231220140538.13136-1-quic_jinlmao@quicinc.com>
 <20231220140538.13136-2-quic_jinlmao@quicinc.com>
 <79f88d35-17cc-43b0-bb22-3c854f89d961@linaro.org>
 <8e5e9603-456b-4956-be03-b866feeeafb4@quicinc.com>
 <c41ff7c8-48d6-4f4f-a9df-aafe953a2e98@linaro.org>
 <f2f983b7-4c57-4b1b-925d-ffb18f6350a0@quicinc.com>
 <c64a41af-ff62-43c5-89f7-0558f8456010@linaro.org>
 <16932826-fcc2-49d3-95ab-201eff729360@quicinc.com>
 <d4c6c32f-b1cf-4cf2-9c52-85fa8c1ed73f@linaro.org>
 <9d13e1ce-38b1-4cdd-83ba-eca0c3091ce1@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9d13e1ce-38b1-4cdd-83ba-eca0c3091ce1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 02:50, Jinlong Mao wrote:
> 
> 
> On 12/21/2023 4:44 PM, Krzysztof Kozlowski wrote:
>> On 21/12/2023 09:36, Jinlong Mao wrote:
>>>
>>>
>>> On 12/21/2023 4:17 PM, Krzysztof Kozlowski wrote:
>>>> On 21/12/2023 09:15, Jinlong Mao wrote:
>>>>>
>>>>>
>>>>> On 12/21/2023 4:12 PM, Krzysztof Kozlowski wrote:
>>>>>> On 21/12/2023 04:28, Jinlong Mao wrote:
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>>>>> index f725e6940993..cbf583d34029 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>>>>> @@ -23,7 +23,7 @@ description: |
>>>>>>>>>      
>>>>>>>>>      properties:
>>>>>>>>>        $nodename:
>>>>>>>>> -    pattern: "^ete([0-9a-f]+)$"
>>>>>>>>> +    pattern: "^ete-([0-9a-f]+)$"
>>>>>>>>
>>>>>>>> My concerns are not resolved. Why is it here in the first place?
>>>>>>>
>>>>>>> Hi Krzysztof,
>>>>>>>
>>>>>>> ETE is acronym of embedded trace extension. The number of the name is
>>>>>>> the same as the number of the CPU it belongs to.
>>>>>>
>>>>>> This is obvious and was not my question.

You already said it here...

>>>>>
>>>>> Do you mean why the pattern match of the node name is added here ?
>>>>
>>>> Yes, especially that it is requiring a non-generic name.
>>>>
>>>>>
>>>>> This node should not have the node name match, right ?
>>>>
>>>> Usually. For sure shouldn't be for non-generic names.
>>>>
>>> Hi Suzuki,
>>>
>>> Can we remove the pattern match of the node name and use a generic name
>>> "ete" for the ete DT nodes ?
>>
>> "ete" is not a generic name. What is generic here? It's an acronym of
>> some specific device name.
>>
> 
> The device full name is embedded trace extension. So use ETE as the name 
> here.

That's obvious and my comment was not about it. Second time... This is
my unlucky day... I said, why do you even want to enforce name which is
not generic, since the names should be generic?

I assume you read the DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof


