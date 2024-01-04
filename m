Return-Path: <linux-kernel+bounces-16331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6154823CED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663E2B214F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7076B200A5;
	Thu,  4 Jan 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkFEL6Hz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43F200A6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso275104a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704354434; x=1704959234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGF4/vmIJ8o7IJvlJQyYKaxW9KtTtwYjR9BBLu19fK4=;
        b=mkFEL6HzI8xj4xcJEgGtfq2/GQfxmpYfCM6qKsp/DwjdhHavpkkdYUNWqZe4tZnbpj
         nummQLXCZGmtl3W/LPaBOpVBxSLlENm/joY/SgTTfbouINsw8USktKevRISs8zFuewb+
         olIiZzsqmf5C/b1WyvS/jRc5qi85L6TnOlQLeAkSk2IRBghZDeJDDm6ZiFjNfxK13lJW
         syVCKMHEvRgKxAlpM1R6Q9agccCRPEosXITT7OS9ZEW71GKv6c3KdBCJXwrFS46CG6ML
         J/uCEciNYweY5UKPtX5e562LGcpzjXKpA0HLXCRJ6TzEKHT0gMGgjksWdv726GiysYfN
         YcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354434; x=1704959234;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGF4/vmIJ8o7IJvlJQyYKaxW9KtTtwYjR9BBLu19fK4=;
        b=vMUxD/mHvd10p7vhy54CHIbBfDWmFgppezaDa2mYPKG0e8abuYALmT0KfuFgNRU0LC
         Maj/UsYpUMY6236wx97wg8wnlw0BFZPaE4LMiJu9B8oREz5BUbKAOkj252WYYJ3RgJZN
         sN240aH8ui/XFS13rLABUoyLMVL0lPoXlw7/85Y7BbKBtmAD4zi3v+u2oz8NNP4w/ByH
         NyaeNfrEqDPC/SVNxF83WA1/4Vuu28h3qvWz/tgJhceFEWngJT0lsitBTSPDs2sLtpwj
         kF1pkID1mosTb/ubO6PKeQG93tCh9F+91rip4E2zFYhdp71ajRHF6yZ/PtMWnPDFuaKR
         dAPg==
X-Gm-Message-State: AOJu0YwVZp31Np217XNHJWmUS+SvEwCL6E4VX7hsgpacueTfK8RAZW28
	pno2nvId5em84w88P85BWE4OXyX/kuqsMA==
X-Google-Smtp-Source: AGHT+IHD4M0r8yDP/YsO00ANonos/KjanteYCjmiTxyH/zJvMcNhKtTUPBA9N36eVzDrvVyTOgmzew==
X-Received: by 2002:a50:9b4f:0:b0:555:ea2f:a97f with SMTP id a15-20020a509b4f000000b00555ea2fa97fmr98511edj.13.1704354434368;
        Wed, 03 Jan 2024 23:47:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id p12-20020a05640243cc00b0055493aa8905sm14982937edc.63.2024.01.03.23.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 23:47:13 -0800 (PST)
Message-ID: <c4831e26-5ff0-40b1-98d4-addfdc1ee5a8@linaro.org>
Date: Thu, 4 Jan 2024 08:47:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
 <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
 <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
 <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>
 <06ddbae8-1502-41fb-8cf8-9a3390dad557@quicinc.com>
 <28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org>
 <d231b7e2-51f5-4676-8fc0-e4bc6154e2d7@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d231b7e2-51f5-4676-8fc0-e4bc6154e2d7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/12/2023 08:38, Jie Luo wrote:
>>> Sorry for this confusion.
>>> Rob said the internal reference source can be decided by the absence of
>>> the property combined with compatible string, because i said the
>>
>> So all your three DT maintainers agree that lack of property for
>> choosing clock, defines the usage of interrupt source.
> 
> This is the reference clock source selection of CMN block, which
> generates the clocks for the Ethernet devices.
> 
>>
>> Now we had huge amount of arguments that you do not represent properly
>> the clock relationships. Still.
> 
> here is the clock topology.
> reference clock sources ---> CMN PLL ---> various output clocks

How do you guarantee that these clocks are enabled without proper
relationships described in DT? In current and future designs?

> 
> the output clocks are provided to the Ethernet devices(such as the
> qca808x PHY devices).
> 
> These information is also provided the commit message of the patch
> <net: mdio: ipq4019: configure CMN PLL clock for ipq5332>.
> 
>>
>>> internal 96MHZ is used on ipq5018 currently in the previous message.
>>>
>>> per double checked the current IPQ platforms, the internal 96MHZ is also
>>> possible on ipq9574, and the reference clock source should be kept as
>>> configurable instead of limited by the compatible string, maybe the
>>> different reference clock source is acquired in the future, even
>>> currently it is not used on the special platform for now.
>>>
>>> so i update the solution with a little bit of changes.
>>
>> You still do not want to implement our suggestions and I don't
>> understand your arguments. Nothing in above paragraph explains me why
>> you cannot use clock provider/consumer relationships.
> 
> Hi Krzysztof,
> 
> The reference clock source can be registered as the fix clock provider,
>  From the current fix clock provider, the clock rate is useful for the
> clock consumer, the fix clock rate is used to generate the output clocks
> by the divider or multiplier.
> 
> For the CMN block to select reference clock, which is configuring the
> clock source, we don't know the formula to get the output clock value
> based on the reference clock value.

I don't understand what does it mean. You do not know how to program CMN
block?

> 
> i also see there is an example in the upstream code, which is same as
> the CMN block to select the reference clock source.

Oh, the old argument. So if there is a bug in the code, you are going
for example to implement it as well?

> 
> the property "ref-clock-frequency" is defined in the yaml file below.
> Documentation/devicetree/bindings/net/wireless/ti,wlcore.yaml.

And how does the hardware look like there? It's TI, so how do you even know?



Best regards,
Krzysztof


