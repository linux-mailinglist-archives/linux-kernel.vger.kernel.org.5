Return-Path: <linux-kernel+bounces-70805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D747859C98
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4841F229B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7311208D7;
	Mon, 19 Feb 2024 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXDkfEhL"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203542033B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326665; cv=none; b=rKYwqOkK9iphzI0B6prYlxBQlUiEh0G6MvC4xNly19bgPAmhAzUu9Wr2Tv7N6utuxgZx/sHFBWBariJJvf1kegdhFpGRhCPnyoxZ5qYmktGW91DDto9agIX7t8EeEPM5/ganfDvWPwDeGA6DamiwWiDKE3ex+TWjb0NS/jxoVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326665; c=relaxed/simple;
	bh=24NTwolwJK2kSJFxyyQ2p4e8IfTm7IiVK19kvsy/o5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxCAUpddiECZ3GhwZvy14sAqhQf68kaZjOVsqk2/X8qDEqsj+wQ9Ds1gglouI2YLMUcEUNnSTKkXr2w7F+Mt8lW56ptM6wcPCFeRrpHsUZDyZ7L878hhn9LRxH5zdqVpYlMz5CUv51YajhiFkMzZU3FwT30U+L0Lv8oDzdRwdzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXDkfEhL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5129cdae3c6so2209695e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708326662; x=1708931462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcJEPOnkRYZTRDvzXIMN85T5MV7yYn8X/AvnE6g07n4=;
        b=bXDkfEhL7UHnDrkodUAuIByMhj7K+PyD8ieUdg9vEdIBUY+7ZN6aCweScr0BgOfPZ6
         AZvm8YcGNj++d8svMntCh4gjElq0oTaAVZeS7Qz/9CkaCdfNkTv8vlwpxqeAeuLtxLca
         IYm7lHvFWJTcs2/LWra2AX7tixcG0u8X0NJ/sKcc2gw57aMLKM9CmPjoxwnvcVnWUuVK
         rYRHB2O2aW0mzcQaosvu3vUJPDk3PomgjaU6CmNfe2CY0y9CvOpizZ/nK3eamgksCy/5
         YS0C4CMv+1WcmJrOez40ogHbwZpltOLEU8Y90PUaE8uGZsJXX9mO2SS18CSWo7/j7RZx
         j/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708326662; x=1708931462;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcJEPOnkRYZTRDvzXIMN85T5MV7yYn8X/AvnE6g07n4=;
        b=GXTj2dOPy5cBP8u7+t6hFIS+gcm8dpET+K5RKJSObeuspr7ngxaNwixMIpUk2qWYIy
         Vp1s2orZzA63vTBt5xM2DFBy4tZALfyIMFgxAXyDsBecaI0zMDRcYNSkUIfBCWH5GijO
         8KHP+XLQeL6me3loNINoypj8zA+c2SF2vA9wU41EObfprTRuZe6AjgFQ4fS5IncMtmfj
         ane7eaEmue9m81wNKAcOsvIXI1m7pe+wBawVo5hJ1ZKDYb/p1IO4z/z0gFoqqYmmmmp3
         MkRFo2j19gAs7jD9BFhyXIg0eBB3YF1qkvCCPDkSrduvEV91y8T7OBvKYTzoBuaUHT3x
         HZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCW+p4XTSDMEqgrysKvSYd5tO8Q4e1cNT35BbLGuwC6v9yrQSwVbzqgZAQQYkKIb8iuAZLb498xRBbJuT2OB0h1Jub0D6hFvIEKa8vrx
X-Gm-Message-State: AOJu0Yx//cAoBA8p3a0emSbuJiP+FSCpo7mHNKwt8MpMzdQ4TjtN31WM
	HHaiOB5REWeLkEEuV9GHpP5aQ1Dn6k1y6IJPVX+137KNUMf3IeizX9PJwwPF+XA=
X-Google-Smtp-Source: AGHT+IE3tWdkDgRPBx0cmA0ZvhyTBxY/ZlI3eB73v1EpbBXv76eaO9tApBei4yn9qk5YdhM3HJdgjA==
X-Received: by 2002:a05:6512:159a:b0:511:8492:69ec with SMTP id bp26-20020a056512159a00b00511849269ecmr8174078lfb.5.1708326662239;
        Sun, 18 Feb 2024 23:11:02 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id je11-20020a05600c1f8b00b0040fdf5e6d40sm10488570wmb.20.2024.02.18.23.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 23:11:01 -0800 (PST)
Message-ID: <ba71fe48-eabb-40c8-ba3f-6cb763508f23@linaro.org>
Date: Mon, 19 Feb 2024 08:11:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] dt-bindings: bus: imx-weim: convert to YAML
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240216223654.1312880-1-sre@kernel.org>
 <20240216223654.1312880-3-sre@kernel.org>
 <e3b54b1c-79ab-4f25-8b42-fadc922c0d25@linaro.org>
 <znyqirhcxfigmenthyrkpivraj43g23gbbx2e774uy3oc375dd@c6pmvckv3gjs>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <znyqirhcxfigmenthyrkpivraj43g23gbbx2e774uy3oc375dd@c6pmvckv3gjs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 02:59, Sebastian Reichel wrote:
> Hi Krzysztof,
> 
> On Sat, Feb 17, 2024 at 09:39:52AM +0100, Krzysztof Kozlowski wrote:
>> On 16/02/2024 23:34, Sebastian Reichel wrote:
>>> +properties:
>>> +  reg: true
>>
>> Your pattern in weim schema suggests you have here minItems: 2.
>> maxItems: can be 2 or 255.
> 
> Which part suggests minItems: 2?
> 
> It's minItems: 1 with each item consisting of two address cells and
> one size cell. Most in-tree users actually have exactly one item.
> The only exception seems to be arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts,
> which has "davicom,dm9000" using two reg items. Considering this is an
> external bus, any number is possible in theory. Should I keep it as is,
> or use minItems: 1, maxItems: 255 instead?

Hm, indeed, existing 'true' is fine.

Best regards,
Krzysztof


