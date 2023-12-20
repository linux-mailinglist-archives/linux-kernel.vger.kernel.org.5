Return-Path: <linux-kernel+bounces-6455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2640819923
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C865A1C21558
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E314F65;
	Wed, 20 Dec 2023 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwOcpL0f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A31F5E4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso67746615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703056218; x=1703661018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okON4GLE4m7eiuy8+UmbhgqUVUUKuGj5zHFUalwl3UU=;
        b=dwOcpL0fLttH/XN6bs6yQkd2hdG8no9MKctUf2wTGNmmkhVKWAd86t7pB79CfqNJb1
         3qa6PfZCHx9o9AADrW69zvBegw+iW4c/R6eP1z9gQ6ijwMfetfVZvSo7RQgr/yeewYRo
         V65nG+YGvYO9MylaJnTt7BX9ybhO9Un4Af2ul7UYa8Z/Thnid6Itss3zckFnPCKxC8cl
         voF7UPCQqir06TX5BmbPP36/ptsErcwZdLzgD+zVlqLpGHJpPzBMpbH4eafnqBzpFzd/
         2tfCe1Cna4T+WiG+sFplTtRNAQuoyO73ADcfsv0zgqgJwcm/NTqklJwyRGbhD3OdlOmN
         p6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703056218; x=1703661018;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okON4GLE4m7eiuy8+UmbhgqUVUUKuGj5zHFUalwl3UU=;
        b=LtWA7rf09ZdhImPpPoNoGUAgXAWoVQB94fIrLBNAt5i67qSAClewF3O+T9qKBGESb3
         2SVbghKXKvmngSuFg5R7pEW/9eaDSICtgrQCYeBdP93kB7Za1F2KwNtQpTnZPLF2rH31
         dyu+Es2Vb4LZAil4J/ao+ZhOnn0mE8ybXa7brbRnsRRmOywYA68ElRjDpAciBWU812qe
         EAGoo9nWqEbp4PPSt5BcwLxDrC9jApBjWa/7+0kD7xr09hc80Io8LFW7CZGC9TrreBql
         oQwCyRCNh8Sp5n09iIMcjK1UY2m8YL5cOBsNMoojdOcVnWt6Za9pe5G9nGtfr0PlaMjY
         IBbg==
X-Gm-Message-State: AOJu0YzAgoo2AvBDkClCZIbHwJGwy7Lqpaxriy6BfltW/aqYImuriNUB
	x/qeiApn1rwe33Zn7fxfFmvmeQ==
X-Google-Smtp-Source: AGHT+IGPunQAyApSaIKE+PxD7CbrP/uD8PsgqvhsUXidXH/rWlukClfDqBMmd+lpEbteqlHtQ6Yrbg==
X-Received: by 2002:a05:600c:3146:b0:40c:3e7c:9e45 with SMTP id h6-20020a05600c314600b0040c3e7c9e45mr8699714wmo.179.1703056218421;
        Tue, 19 Dec 2023 23:10:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05600c1f0700b0040c420eda48sm6382647wmb.22.2023.12.19.23.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 23:10:17 -0800 (PST)
Message-ID: <6265dc95-57fe-4e02-b68c-03d60b1cdabc@linaro.org>
Date: Wed, 20 Dec 2023 08:10:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
Content-Language: en-US
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com>
 <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
 <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com>
 <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
 <38604415-b410-4995-9c4f-525536435699@quicinc.com>
 <CAA8EJpo07gE7ZeNP6wSGTLtmF_3PKQAKFyMRZ8dk1K+f7PAxrg@mail.gmail.com>
 <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/2023 01:53, Aiqun Yu (Maria) wrote:
> 
> 
> On 12/19/2023 6:21 PM, Dmitry Baryshkov wrote:
>> On Tue, 19 Dec 2023 at 12:09, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 12/19/2023 5:41 PM, Krzysztof Kozlowski wrote:
>>>> On 19/12/2023 10:36, Aiqun Yu (Maria) wrote:
>>>>>
>>>>>
>>>>> On 12/19/2023 3:17 PM, Krzysztof Kozlowski wrote:
>>>>>> On 19/12/2023 01:31, Tengfei Fan wrote:
>>>>>>> The address/size-cells in mdss_dsi1 node have not ranges and child also
>>>>>>> have not reg, then this leads to dtc W=1 warnings:
>>>>>>
>>>>> Comments can be more readable:
>>>>> "mdss_dsi1" node don't have "ranges" or child "reg" property, while it
>>>>> have address/size-cells properties. This caused
>>>>> "avoid_unnecessary_addr_size" warning from dtb check.
>>>>> Remove address/size-cells properties for "mdss_dsi1" node.
>>>>>
>>>>>> I cannot parse it. Address/size cells never have ranges or children.
>>>>>> They cannot have. These are uint32 properties.
>>>>> Pls help to comment on the revised commit message. Every time I write a
>>>>> commit message, also takes a while for me to double confirm whether
>>>>> others can understand me correctly as well. Feel free to let us know if
>>>>> it is not readable to you. It will help us as non-English native developers.
>>>>>>
>>>>>>>
>>>>>>>      sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
>>>>>>>        unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>>>>>>
>>>>>>>
>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>>>> ---
>>>>>>
>>>>>> I disagreed with the patch before. You resubmit it without really
>>>>>> addressing my concerns.
>>>>>>
>>>>>> I am not sure if this is correct fix and I want to fix all of such
>>>>>> errors (there are multiple of them) in the same way. Feel free to
>>>>>> propose common solution based on arguments.
>>>>> Per my understanding, "qcom,mdss-dsi-ctrl" driver node like "mdss_dsi1"
>>>>> don't need to have address/size-cells properties.
>>>>
>>>> Just because dtc says so? And what about bindings?
>>> I don't find any reason why "qcom,mdss-dsi-ctrl" driver node need to
>>> have address/size-cells properties. Document Bindings should also be fixed.
>>>>
>>>>> Feel free to let us know whether there is different idea of
>>>>> "address/size-cells" needed for the "qcom,mdss-dsi-ctrl" driver node.
>>>>
>>>> The bindings expressed that idea. If the binding is incorrect, fix the
>>>> binding and the DTS. If the binding is correct, provide rationale why it
>>>> somehow does not apply here etc.
>>> Our plan is to fix the bindings as well.
>>>
>>> In case you have missed the question, I just re-place it here:
>>> While there are about 22 different soc dtsi and it's document binding
>>> files needed to be fixed. Shall we fix it for all qcom related soc usage
>>> in one patch, or we'd better to split into different patches according
>>> to soc specifically?
>>
>> Don't touch the bindings unless you understand what you are doing.
>> Your patch will be NAKed. There can be a DSI panel attached to the DSI
>> host, which means there is a need for #address-cells / #size-cells.
>>
> Could you please help to elaborate more on details? Like what's the 
> right example here for the "qcom,mdss-dsi-ctrl" driver node needed to 
> have "#address-cells"/"#size-cells".

Isn't the binding describing such example?

> 
> Thx to chime in that we have put a good amount of time here.
>> Please stop wasting the time on dtc warning. The bindings (and the
>> file) are correct.
> I don't agree here.
> Either it is a wrong usage of "#address-cells"/"#size-cells", or dtc 
> warning should be fixed with this usage take into account.
> "dtb check" will be a good guideline for developers to follow, I don't 
> think it is wasting time here.

You don't agree but you don't know how this binding works?

Best regards,
Krzysztof


