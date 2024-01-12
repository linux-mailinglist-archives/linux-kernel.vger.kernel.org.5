Return-Path: <linux-kernel+bounces-24837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE382C33B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5568C1F2533E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89B73167;
	Fri, 12 Jan 2024 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdXz1stN"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5D6EB78
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33770772136so3297308f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705075221; x=1705680021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KNSnE31mUWTtAu62zxte7+wGFbNxIAXcVNWvFpXarq8=;
        b=VdXz1stNKCLwLQ/mnKJ4pCKXFCH2R3W95NvhAsG3UaYzV7EeVoYvLCMSkLeUPUpe8C
         C8pt35XbrgtcDkRqxKon/pPVakcqHyn57h8vje1CoCajstWaf1zGl6ffSj/ufN8H+4gi
         gPfeOX5VYVYSvyRTwyj4fomIrhEVdvYOA5hLoIW24fzi452kYyLBt9wXdUfIgSwARHL5
         61Z5fhHJMQo30SvnjT8CjJfehVXmdjU+0VAzSjyMd16nxFMyR1n9v4tmIAP+rJTxvZTH
         KyiZA/MCVr4ZFtGyHxEKXp/4X2GErFjvGefCwiY3svGWBrQipu2nF+PfebB4j6By+k7O
         btsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705075221; x=1705680021;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNSnE31mUWTtAu62zxte7+wGFbNxIAXcVNWvFpXarq8=;
        b=SHtiSVPCBPEHK90A16ADRBzX2wi8XKlaS6kimR1pbSUV0Celz4J+nQOW/xHt+r+BRy
         LX/S/LYlcngw6Jp/LS3gpBrps9GggccBYlGa1ylvfTatdHMDxTVm9pFzqv49zkk2J2SA
         Xm8Q5OEc0jZAI5yWqkFnJdSSmPB8B9U4+33tSbvMDS1Yw8o1HBKxvWXsjlwJhiNip+/q
         hfLT5DoW9d0RTLwPmA8epvnh+jymk8jreL9FEFRFoRxH2tmuZYZNrqA+F8QQ8mjpV8gU
         7KdI7oBCRKGeNIF9ByWlfK6NHRTkjWYIwLhRfmychxpqVJ4vEbyNb8DJ0Yco3aRuQDmz
         bbyg==
X-Gm-Message-State: AOJu0YyQhQtCeoinyzuxPqRSVSWtWkWMymUij3R6hPseBdw0SisYvN1U
	mzB0+wuA03UJ7R4AFANlTFR3Pyn4ZI/bPQ==
X-Google-Smtp-Source: AGHT+IG0t8vwy4/T+jnfap/4JzmpTGUHJHK3NjF9tz0RjHW21dsfZTqkn2BSN+XKUADqV25rHt7bjA==
X-Received: by 2002:adf:e8c6:0:b0:336:1182:6475 with SMTP id k6-20020adfe8c6000000b0033611826475mr875372wrn.34.1705075221351;
        Fri, 12 Jan 2024 08:00:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id b6-20020adfee86000000b00337478efa4fsm4200905wro.60.2024.01.12.08.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 08:00:20 -0800 (PST)
Message-ID: <a1e673be-9c4e-4bbc-abe6-56466f8a01ad@linaro.org>
Date: Fri, 12 Jan 2024 17:00:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: robh@kernel.org, alexandre.belloni@bootlin.com,
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 jirislaby@kernel.org, joe@perches.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 miquel.raynal@bootlin.com, zbigniew.lukwinski@linux.intel.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
 <20240110175221.2335480-3-Frank.Li@nxp.com>
 <3c0be658-e7a6-4231-b206-86ffb47e0cb2@linaro.org>
 <ZaFbbeQrC7o2dchO@lizhi-Precision-Tower-5810>
 <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2024 16:50, Krzysztof Kozlowski wrote:
> On 12/01/2024 16:31, Frank Li wrote:
>> I review previous comments. The previous RFC patches and I just want I3C
>> expert review to check if there are comments about whole software
>> architecture. Of course, thank you for your comments about "slave".
>>
>> Go back this binding doc problem. 
>>
>>   "No, it's the same device.
>>
>>    Anyway, this was not tested.
>>
>>    Please use scripts/get_maintainers.pl to get a list of necessary people
>>    and lists to CC. It might happen, that command when run on an older
>>    kernel, gives you outdated entries. Therefore please be sure you base
>>    your patches on recent Linux kernel.
>>
>>    You missed at least devicetree list (maybe more), so this won't be
>>    tested by automated tooling. Performing review on untested code might be
>>    a waste of time, thus I will skip this patch entirely till you follow
>>    the process allowing the patch to be tested.
>>
>>    Please kindly resend and include all necessary To/Cc entries.
>>    "
>>
>> It is the same devices, work at difference mode (master  and target).
>> what's do you want to change to?
>>
>> Copy to new file like pci/pci-ep? all context is the same, except for
>> compatible string. 
>>
> 
> Apologies, I mixed up a bit patches, so this was not obvious. I meant
> this comment:
> 
> https://lore.kernel.org/all/20231017201404.GA2570433-robh@kernel.org/
> 
> There is no indication in your commit msg that these concerns were
> addressed.

And here:

https://lore.kernel.org/all/6110c58a-8003-4889-9a4b-6a7d1821c00e@linaro.org/

Best regards,
Krzysztof


