Return-Path: <linux-kernel+bounces-28629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD648300EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9567128950D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0446111CB0;
	Wed, 17 Jan 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFvdvmcP"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF1CA47
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478507; cv=none; b=b9xeunamFHwuthmb0ApdRayz6qfx9ArmqjV14FZ7B+ZUx+XDm7MbiSnJCSiisYs2EixaCYMC6eQPLPprCj96FF/YZlM0kA5xohZfGbSdVN9CtsiAxCob85lo58Wl660jXnCuB2eZ443kJzUzEofH+UirDLSE8k7r7BnAsfwjtKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478507; c=relaxed/simple;
	bh=F55qoKOJjTn6GVNRwLeHYRjE+ufEIO6YYFLSm7WvZSk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=lk254i00hlEZF8AUby6cnm+JHiyZykd2kgQhwvsjRySqpmIR4PpwStHijDgJ9ZD2ey1qseNTc65VOLXpYgvL/LqTP4kHQypSeFb1e6NminDepsHbmRh8R/Znp+yg9h10feUPY/+EsrcxACp8uzYu+nvTQwAKpxyVJNwyEmb91uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hFvdvmcP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-559dbeba085so305297a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 00:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705478504; x=1706083304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+9yrua8jaQ3UWEtc4S7B3IN/U5TN0y1kQRQzc9y9zQ=;
        b=hFvdvmcP33eFW65l3Hc3HlJFqi8LjGsjG+yyhBV0s2hIIl+2pcLPR44CIg3esqW2kq
         J91Pz3mcporJhcDPUWnYVcfdSNTUHWu8MCxjFTVMAvjYrpjdCXqu+C5EKQgC/R4lDVOB
         lyZmXWqQ19n/rJvIFRWdUsmOezsqE+7D55lAvzqWBLd+Z6UiVUNdC/+BWKub8D18RMVc
         eAbdzDcakSBnHuHtmyMlzjI4uMcEGuuq6mst018Ix5Q6efIKxVCfUMl58itOo2bRlfW0
         ZUhDRAbSUaaO2onGT7gTWBgxV3dqO1Evl9T39LD5PqsrRcvYqK+10hICByfPSETq+N9z
         +HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705478504; x=1706083304;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+9yrua8jaQ3UWEtc4S7B3IN/U5TN0y1kQRQzc9y9zQ=;
        b=jAe2hC97IF9QVDUjP2GaaS4Ktxn/oHCSCnsHqeQJRx2p87ij9FyyxG6W02prIKLPPh
         lJjYpNR9pYNHd1lBwD1bEQaf1nEpY8t3ybriRRsNEk8ux0Wzfmf4K/JxpdlFzfzClr3m
         JQ047YlfkWFhdt8rlFUcTfpbp/ZVWNLzXyb3mCNXehn/CSgE94q7u6LTWyfFQDzj1yie
         3wQkwSerUmha5XUhrH58m6b6tjSAiKTD+X2rGyPeHx5UJtlzy6LKrGLfX7j2DkiLaSKD
         EUHlnZrKSfqUvcwVdrMGeGq68nJl6gTFvWp8IdzVGmSL1nUYNYzvoSR0WZfS48m9ObAt
         sRyA==
X-Gm-Message-State: AOJu0YxHnp/2i8U6C50LloakRQz9RvnRkca3M6GxwuUP7YcFjL7lLJJJ
	9RPbani/itzMR/Z8Y4eG+hHJjMSdHQY14w==
X-Google-Smtp-Source: AGHT+IGvF+GUqknPS4nkh6LGmrUMl3+K4PglNi70UEqZ1NLNx3ln8xuDF0I20mxoVVa98aDkOzzItQ==
X-Received: by 2002:aa7:c388:0:b0:555:2b97:3f57 with SMTP id k8-20020aa7c388000000b005552b973f57mr4064992edq.84.1705478503907;
        Wed, 17 Jan 2024 00:01:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402040800b0055703db2c9fsm7817386edv.1.2024.01.17.00.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 00:01:43 -0800 (PST)
Message-ID: <b30ed845-5900-470d-aa73-f47332b539ba@linaro.org>
Date: Wed, 17 Jan 2024 09:01:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: tps65217: add power regulator & backlight
 drivers support
Content-Language: en-US
To: Xulin Sun <xulin.sun@windriver.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240117043323.2008454-1-xulin.sun@windriver.com>
 <70d52400-13b8-4f2f-81e3-0753e77e129f@linaro.org>
 <c9f5b6b7-7e01-5b99-c2a9-1bbfd50ebb27@windriver.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c9f5b6b7-7e01-5b99-c2a9-1bbfd50ebb27@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 08:56, Xulin Sun wrote:
> On 1/17/24 15:24, Krzysztof Kozlowski wrote:
>> On 17/01/2024 05:33, Xulin Sun wrote:
>>> Support TPS65217 voltage regulator driver and TPS65217 Backlight driver.
>>> And enable them by default. This will avoid below booting failed
>>> information:
>>> tps65217-pmic: Failed to locate of_node [id: -1]
>>> tps65217-bl: Failed to locate of_node [id: -1]
>>>
>>> Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
>>> ---
>>>   arch/arm/boot/dts/tps65217.dtsi | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
>>> index 0d463de5650f..f412e7476660 100644
>>> --- a/arch/arm/boot/dts/tps65217.dtsi
>>> +++ b/arch/arm/boot/dts/tps65217.dtsi
>>> @@ -13,6 +13,16 @@ &tps {
>>>   	interrupt-controller;
>>>   	#interrupt-cells = <1>;
>>>   
>>> +	pmic {
>>> +		compatible = "ti,tps65217-pmic";
>>> +		status = "okay";
>> Why do you need status here?
> 
> 
> It corresponds to the drvier: drivers/regulator/tps65217-regulator.c, 
> and regulator is one of the main function of TPS65217.

status does not correspond to the driver.

> 
> I think it should be enabled by default, so set status to "okay" here.

It is the default. Is it disabled anywhere?

Best regards,
Krzysztof


