Return-Path: <linux-kernel+bounces-786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F60A814602
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47365285954
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCA020305;
	Fri, 15 Dec 2023 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7bJj3OD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417781BDDC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so5900361fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702637611; x=1703242411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ky94Slah7vEYb2lMfwMgiZxeElOcz1Re2jQmzmdgNXE=;
        b=z7bJj3ODNyFvp7p8ID4SiyvBY6YzUPtZMCi6C972yad/yotVegk44gp1w3bUQ/doDs
         Tjeuy8DWG89BbS37PSRNSPXCYTqfbYIhu0CariSStl6BiyzzE2q6ruqe1zfYFbVKS3r+
         qmEV0Wlkesy1FUeAtSQxbBedJEycIAAE83Pr/HOdlyodCGrDPmt3la5pXaSoRKzWb3hJ
         Uyd1QMj7kBw0l6KiEVDc3rbiU/Hbeyu+et38azHy7rRq17vGpSepJGXLCKl30S/XjKr6
         JKUH/TbsWDOJ9myTFByTlhIVqjyzdIPYhB2L0JUrJm47WJog2w1Bvkslb8aEGwSu/PzL
         jk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702637611; x=1703242411;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ky94Slah7vEYb2lMfwMgiZxeElOcz1Re2jQmzmdgNXE=;
        b=M4PzUYf/FjagYMWsTodThUjgjFl3HvgYLcaBMAFSMLObYEzVMhIgP2PMEdR0bTnGq/
         /K0YVYpdmbQ0wdMPrTbILumstdyJd+1exax5F6no4wsfS0BYW+oM+h2/s9zmgIKKItov
         oVVqZjY/j+/cECVYWfzodtQjhzfwVxWz1RYztMt0tUejvcyYRYwgQioh+FhJAkV4cs+m
         dhEB2YgRT1p15pTasKNZFDx7FRwL5RNfr+eHx+uJn+nsUUppmGv36ruUBPa3CYGz1y4e
         gUsQKUK43ndVf6Inr9vrtCUM6YrNvA7x9BTVrRRXYwKfjjRqn6JNLny0ueTFFoMKE4Hk
         dD7g==
X-Gm-Message-State: AOJu0YxB0BzlEMUOf6mt6V9LNR5qW5TiXpuKRaPvJXNR9H3YRO/sHgb8
	wI9fF3Os6Ykw7RkqhxIQ/T1rEw==
X-Google-Smtp-Source: AGHT+IEaYGHmfQYNE9iSPshT/L5K+RrPz7l2Y60dAFD1JcQY4/4wj1kqU3TfXDEDLBmltngCEKBlYQ==
X-Received: by 2002:a05:6512:1042:b0:50e:e2c:b39d with SMTP id c2-20020a056512104200b0050e0e2cb39dmr3009229lfb.58.1702637611188;
        Fri, 15 Dec 2023 02:53:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id bn2-20020a170906c0c200b00a23152a543dsm1119517ejb.202.2023.12.15.02.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 02:53:30 -0800 (PST)
Message-ID: <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
Date: Fri, 15 Dec 2023 11:53:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Jie Luo <quic_luoj@quicinc.com>, Conor Dooley <conor@kernel.org>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, robert.marko@sartura.hr,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
 <20231212-caution-improvise-ed3cc6a1d305@spud>
 <11ffc985-3f2b-46b9-ae0b-911f7abe98d1@quicinc.com>
 <20231214-outshine-shush-8a11c68607cd@spud>
 <c5123ce7-6fdc-43c7-ac07-251c39196e66@quicinc.com>
 <a1e5ffec-a20d-4389-83f9-ee09bd9d733d@linaro.org>
 <a84a36af-69f8-46af-967e-b06d028597a3@quicinc.com>
 <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2023 11:40, Jie Luo wrote:
> 
> 
> On 12/15/2023 6:37 PM, Krzysztof Kozlowski wrote:
>> On 15/12/2023 11:33, Jie Luo wrote:
>>>>>>>>>>> +  cmn-reference-clock:
>>>>>>>>>>> +    oneOf:
>>>>>>>>>>> +      - items:
>>>>>>>>>>> +          - enum:
>>>>>>>>>>> +              - 0   # CMN PLL reference internal 48MHZ
>>>>>>>>>>> +              - 1   # CMN PLL reference external 25MHZ
>>>>>>>>>>> +              - 2   # CMN PLL reference external 31250KHZ
>>>>>>>>>>> +              - 3   # CMN PLL reference external 40MHZ
>>>>>>>>>>> +              - 4   # CMN PLL reference external 48MHZ
>>>>>>>>>>> +              - 5   # CMN PLL reference external 50MHZ
>>>>>>>>>>> +              - 6   # CMN PLL reference internal 96MHZ
>>>>>>>>>>
>>>>>>>>>> Why is this not represented by an element of the clocks property?
>>>>>>>>>
>>>>>>>>> This property is for the reference clock source selection of CMN PLL,
>>>>>>>>> CMN PLL generates the different clock rates for the different Ethernet
>>>>>>>>> blocks, this CMN PLL configuration is not located in the GCC, so the
>>>>>>>>> clock framework can't be used, which is the general hardware register
>>>>>>>>> instead of RCG register for GCC.
>>>>>>>>
>>>>>>>> I don't see how the clock being provided by the "GCC" (whatever that is)
>>>>>>>> or by some other clock controller or fixed clock makes a difference.
>>>>>>>> Why can't the other clock provider be represented in the devicetree?
>>>>>>>>
>>>>>>>
>>>>>>> cmn-reference-clock is for selecting the reference clock source for the
>>>>>>> whole Ethernet block, which is just the standalone configure register.
>>>>>>
>>>>>> Sure, you are aware though that all clocks are just configure registers?
>>>>>>
>>>>>> Which clocks are these mentioned in the property? From where do they come?
>>>>>>
>>>>>> Anyway, property is in existing form is not correct - this is not a
>>>>>> generic property.
>>>>>>
>>>>>
>>>>> This property cmn-reference-clock is just the hardware register
>>>>> configuration, since the different IPQ platform needs to select
>>>>> the different reference clock source for the CMN PLL block that
>>>>> provides the various clock outputs to the all kinds of Ethernet
>>>>> devices, which is not from GCC provider.
>>>>
>>>> AGAIN: where do the clocks come from? Which device generates them?
>>>
>>> Oh, OK, the reference clock is from wifi that provides 48MHZ to
>>> Ethernet block.
>>
>> Then WiFi should be providing you the clock and this device should be
>> clock consumer, right?
> 
> Yes, wifi provides 48MHz clock to CMM PLL block, there is no GCC
> for this 48MHZ clock output, it is the hardware PIN connection.

All clocks are some hardware pin connections.

Best regards,
Krzysztof


