Return-Path: <linux-kernel+bounces-69874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA07858FB6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7A01F21ECB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E7C7AE58;
	Sat, 17 Feb 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iB7aCVxG"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15EC2E403
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177174; cv=none; b=IzlTAL5q9pZIuj29ffWP8gm6k76KxpO6kEofVnATYemekbtjWMtBXJY07CV+iZi0RmrWeAJUqfMyzSKR4MHPWuc7GHYcuuZbeSaxQu6rocJ80b1O3s/Z6GvvOUmYS4VKq8WYR6gw04G4l1v5u1RNPajSOSZAOzTlsBVXTRLHghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177174; c=relaxed/simple;
	bh=K04iPTyjk1j8inm6nlrW91sxz8ftcLlQT0VDbyibynU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJfIdfIBAjlT2r3JPixcU+K0q1hE3p3JotHZ33PD7KuP/Q6LzipvudJY+dxfy8I+xKebC36g039nAaE7/UP44V2N9IS1mg3urEd1fiQ+fVFrYOzisXnft5TS5nsFPEhR4e+ZRPUSRAXGRaZw8AjYr3sOYqcsU/vNYTnnh/ZnxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iB7aCVxG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso3122077a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708177171; x=1708781971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd2SDGlkT7ET69Q/kzxiym8LVvJt2afawRbhHuf81jQ=;
        b=iB7aCVxG7LefOGRLKYny09c/J+3h69Mu0Fbbe3fO/gO7uo++1OD2SkFJ2B7NefAStG
         HO3ixdaiOP6wHBagcVYP6YdlzFcpGhBqzu2hi2ZJvmcH2bHVZH2vCrOLJm9vIRu/oPF1
         UrH8YLuSdHEgCSM4Z3smKU+WwE9mt2RzMNq3lDs1zn6yNQkXbymc9qRLGzLl9qotUKI5
         mw/9nfNqZ90LwPjMtzQWVZ+bBsFs/qtvjuGgSIT/9THqtgVil+H8hGD/KXcKV7mCX543
         sr+HH1vwwgQBLoSH8jcqj3uhnTxO4UjQa8/uvWbFDWkhfZJSDpPb4sx5PpJ68QUiC02M
         dH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708177171; x=1708781971;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dd2SDGlkT7ET69Q/kzxiym8LVvJt2afawRbhHuf81jQ=;
        b=sMwMTCj5aSNz1ormjptC8rufcytw5SJa/74jRMmZEyboAyO9gXZQus4kjp7rzfSv76
         hYbOvDpY8ESGKsnEp1u7K76pNVADZ26YIyy1LinDq2RLbS58abTYoIAyS3qh3MGfvmDC
         OY9NTv7i4SyhqKL/cARYuqBQhT7kARCW5P/rjdd/Q0R0P7r/0oIyKgf8awNDYHeKOqhL
         sdW4UwuYR6oqNUgT15VLSx+4zEHvRbwTQ9vuLNkMcgnk9Cv2D7KWCCOM7fgVQjyZhgE5
         MJl+uag5K9vL37soo06gRf63xdqrnESfxpC9PC1YfyEfPYlxFN5h1BcQK5divAT0VKIK
         DbTg==
X-Forwarded-Encrypted: i=1; AJvYcCU6wb8VnCI5C9fQmsbfTn5Sqin0jykOqPBrM359wazL78v/QJpF0akSW9HK4a8+ebuRJCyDn2U333EF8PLmDu8UOd5Pn32peiDJ8wpn
X-Gm-Message-State: AOJu0Yy3V89QGt4FnO/gjzGseLq112ctjWDIDtosVRd3lHOy9Uk/wClt
	4eN9AJvpk+ZabSEWLts9+C1q30DSeuARXoLk31/yEVhf45+Rsqby3oBnCbp09Sg=
X-Google-Smtp-Source: AGHT+IEdWMbHPDe+GqpY6IsOXazyfzhxTJX9qYAfUknm6i+SUZziPyO8qS2bK4wJLF3BKrODJWncbA==
X-Received: by 2002:a05:6402:8c7:b0:563:f606:3b3f with SMTP id d7-20020a05640208c700b00563f6063b3fmr2623534edz.5.1708177171054;
        Sat, 17 Feb 2024 05:39:31 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id bf2-20020a0564021a4200b00562149c7bf4sm892560edb.48.2024.02.17.05.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 05:39:30 -0800 (PST)
Message-ID: <712f8904-4b63-4a3b-8135-f17f41bbb501@linaro.org>
Date: Sat, 17 Feb 2024 14:39:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] dt-binding: phy: hisi-inno-usb2: convert to YAML
To: Yang Xiwen <forbidden405@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
 <20240216-inno-phy-v1-1-1ab912f0533f@outlook.com>
 <63b3eff6-49eb-46f3-a6d9-878eddf6de53@linaro.org>
 <SEZPR06MB69593B898A42192D134B01A896532@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <dfecd473-dcc1-4977-901d-6c7bb615bc97@linaro.org>
 <SEZPR06MB695983231D04A2E1947AF61896532@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB695983231D04A2E1947AF61896532@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/02/2024 11:54, Yang Xiwen wrote:
> On 2/17/2024 6:29 PM, Krzysztof Kozlowski wrote:
>> On 17/02/2024 11:24, Yang Xiwen wrote:
>>
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/clock/histb-clock.h>
>>>>> +
>>>>> +    peripheral-controller@8a20000 {
>>>>> +        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
>>>>> +        reg = <0x8a20000 0x1000>;
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <1>;
>>>>> +        ranges = <0x0 0x8a20000 0x1000>;
>>>> Drop the node, not related to this binding. If this binding is supposed
>>>> to be part of other device in case of MFD devices or some tightly
>>>> coupled ones, then could be included in the example there.
>>> For CV200, this binding is supposed to be always inside the perictrl
>>> device. The PHY address space are accessed from a bus implemented by
>>> perictrl.
>> Every node is supposes to be somewhere in something, so with this logic
>> you would start from soc@. What's wrong in putting it in parent schema?
> 
> When the ports reg property only has an dummy address (no size), it must 
> be inside the perictrl node, accessed from the bus implemented by perictrl.
> 
> But when the ports has its own MMIO address space (mv200), it should be 
> located under a simple-bus node instead.
> 
> So it's either:
> 
> perictrl@8a20000 {
> 
>      usb2-phy@120: {
> 
>          reg = <0x120 0x4>; // this is the register that controls writes 
> and reads to the phy, implemented by perictrl. (just like SPI/I2C)
> 
>          phy@0: {
> 
>              reg = <0>; // the reg is used as an index
> 
>          };
> 
>      };
> 
> };
> 
> or:
> 
> soc@0 {
> 
>      usb2-phy@f9865000 { // MMIO
> 
>          reg = <0xf9865000 0x1000>
> 
>          port0@0 {
> 
>              reg = <0x0 0x400>; // used as MMIO address space
> 
>          };
> 
>      };
> 
> };
> 
> So here is why i include perictrl node in the example. If the ports are 
> not mmio, the phy must be under a perictrl node. Or if the ports has its 
> own address space, it should not be under a perictrl node, but rather an 
> simple-bus node.

I don't understand why you keep insisting and discussing this. You are
adding other compatibles to this schema example, which usually we try to
avoid. You entirely ignored my comment above and pasted DTS which is no
related to the topic we discuss here. I did not question whether this
can be or cannot be in some node.

Best regards,
Krzysztof


