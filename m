Return-Path: <linux-kernel+bounces-38406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE783BFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CB9B2C000
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40D22303;
	Thu, 25 Jan 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUJ4F+Az"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062A1CD02
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179246; cv=none; b=EeZ+XXQTSXBjwUk8LW0nKE0osrEkhaUDmZmg1cKfa2D4rF4hKIueuNNw4yz05kOobk2o5ekLB1OWD8DjznLYMfj/1auv63CqOHX1m7cFl6wn7SxHVOZIwo2pg3yyJVrcH8p/LdypPmQqIzmigCQkFdzZOQvm8hutvLC8OjkFCWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179246; c=relaxed/simple;
	bh=b92M9Wx0Kjvz8/GRBKt2gDk64pigjf71puB291ddRj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4VUZqJlQR4U0NsMHD6V4fcpsb3b2Joz6uOZyzaPOQGwoXq7weCK+l9kVCVuUiz4Uht7o7tpQBHsb0Ex2aS2FEzb6M11Rez1l48PhPAH176Jd3nEWd0qiGJ2woaHKI2tt29n5xC1Y3m2ctBJiz0aRRonnsY2Sevo+74CIcNvPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KUJ4F+Az; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e76626170so72481785e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706179243; x=1706784043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wz3t7EJZ1eNdyOYD/Kh4skvS3WQ/kt2sR4TG8rwI5Po=;
        b=KUJ4F+AziXYkMbs6X+o7D6OLvEUopFpuCrn+jobjlSQrRHuHvHoy8WRu6LKwh0xKrO
         g6SE3GtuSE26xQxES5yZIZ5rJr37otz6bTq6tzhNlbmMHRaFGwXJhCoZOrfNEM1z9EnI
         Qrua3yu4dQx52ix3gis19OVTEU++byRRbgZlxnil+b41So+qTiqpJQ4z4P84EqmGknu7
         Fx3jyFEXfALDSL1yYpBQhykqwyf8OJwyLDL+cCM0o/oCgghHXeH910idmS1Dx3SXSvuH
         lRriCkAnFK6wFn05YAEMgR0ESMQXzrQAWNRsS/A4n8Gt1UOpQvuFK6gucc8YVhU4QvS5
         TJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706179243; x=1706784043;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wz3t7EJZ1eNdyOYD/Kh4skvS3WQ/kt2sR4TG8rwI5Po=;
        b=Jndg/2FiepCJCuaZEn7lBTb88FSNVm00f2J0GxCsN/mLQ13/Uq60kan7lkoeDAidZh
         3rFF0zeIjwgXQ72W/kBFfa1idX3+1nGhoGeA6r6TC3T7NPoKHP3lux4hsaWn5Sr4LzJA
         w6qztgaAKiQ+Ze6E86218i62mbavGSHq/n2ttbGr4s8Mx/Rx7BMR59JrPvL5oAYvYBpX
         pIJcd/MT0Mg5kHgerdhJ0hE1go0QOoZxkKUpHlW94wb/Ln7JFpUFSrp+rjHD1hxc439c
         5aX188BQVRTeY9HDs6l201tyAllHQHo1zQ42PQK/oDjyMcxS6Yrg8D8Y/Wima7TSc1m2
         0LYw==
X-Gm-Message-State: AOJu0YyFlGXp247vQAgY9KvrirAcb96NtWr5Zjv/s8itnXpw+x0ZuKMI
	UBDqeqtkqgWNYuDUkGYXpg18i+Nv5IJQC8GAS/liXAxO2HOkieGy3OZAKpDwoTQ=
X-Google-Smtp-Source: AGHT+IHlFpzaQSEfsjUXLD10CregE5JH3j619Oan9H22R6Hoj+cIAxJtAF19gomSvLp/kDE593/Byg==
X-Received: by 2002:a05:600c:1986:b0:40e:b106:d2a with SMTP id t6-20020a05600c198600b0040eb1060d2amr413239wmq.22.1706179242981;
        Thu, 25 Jan 2024 02:40:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b0040e3ac9f4c8sm2099097wmq.28.2024.01.25.02.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 02:40:42 -0800 (PST)
Message-ID: <21eda361-ae7c-48d7-b1ea-ef1bfe8d9104@linaro.org>
Date: Thu, 25 Jan 2024 11:40:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Content-Language: en-US
To: Amrit Anand <quic_amrianan@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
 Elliot Berman <quic_eberman@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
 <1fc9815e-76dd-41d7-aa1a-caa72ef4ad34@linaro.org>
 <b4c27fb4-0cbf-7bad-3fc3-163fb4a5eb3f@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b4c27fb4-0cbf-7bad-3fc3-163fb4a5eb3f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 13:42, Amrit Anand wrote:

>>> +select:
>>> +  anyOf:
>>> +    - required:
>>> +        - 'board-id'
>>> +    - required:
>>> +        - 'board-id-types'
>>> +    - required:
>>> +        - '#board-id-cells'
>> I don't fully get why do you need this select. Isn't the schema selected
>> by nodename? Or maybe it is for the final required: but then this could
>> be just set of dependencies.
> The nodename here would be "/". So it will be applied to all the DTs, right?
> Here, we wanted this to apply only if the above mentioned properties are 
> present.

The nodename will select it.

> Do you suggest moving this to qcom,board-id.yaml and the required: as well.
> So that vendor specific yaml could be applied?

I suggest dropping the select.

Different topic is that we cannot even test it because you did not
provide any user of this binding.

>>> +
>>> +properties:
>>> +  $nodename:
>>> +    const: "/"
>> Blank line.
> Will add it.
>>> +  board-id:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>> +    description: |
>> Do not need '|' unless you need to preserve formatting.
> Ack
>>> +      A list of identifiers that can be used to match with this devicetree.
>> s/devicetree/Devicetree/ ?
> Will update
>>> +      The interpretatation of each cell can be matched with the
>> Typo: interpretation
> Will update
>>> +      board-id-type at the same index.
>>> +
>>> +  board-id-types:
>>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>>> +    description:
>>> +      Defines the type of each cell, indicating to the DeviceTree selection
>> s/DeviceTree/Devicetree/ ?
> Will update
>>
>>> +      mechanism how to parse the board-id.
>>> +
>>> +  '#board-id-cells':
>>   What are the cells for?
> Bootloader will use this to check the number of entries in a tuple of 
> board-id.

Doesn't the board-id-type define number of cells? How could you have the
same board-id-type with different number of elements on board A and board B?


Best regards,
Krzysztof


