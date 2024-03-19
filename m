Return-Path: <linux-kernel+bounces-107298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C408F87FAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556321F22323
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A668C7CF30;
	Tue, 19 Mar 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKjaR6uV"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4E50A6A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840507; cv=none; b=CDh01VbS/sN7TcdZByB6v90iNdijPjgXquO1lAbg5nDPXducxRCo7Q6ZbwKT3RJ/880WszF08xhU8Z+Mvk1ZJgWGjTmv7ifybuAQEq31VaBQVCL+hciCxjHNbZBb2/iZ7YUqFoDz8XEtmgrlq0aFSSz8wYcQNedAzfh3CfxGUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840507; c=relaxed/simple;
	bh=HjBuG9xd7AaXCYgSmfp2B7iX2Cs8p0FwGGbH/0NJwUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nz+P94eVnX9CzMoEDI9fGdwH0TKdjvrL0az5p5VSElCXJKVIv+T83rw+HBXERfa6C6gz74Ww+9jY538G/8Cd4t6WOrzS1RAgxmpiRwQ5lyYB3UogPOP2FDnb/Oemo38Pd+mJygDgOCtuh2Sf2dd3UJGX5h4bhx131nv+P6A62/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nKjaR6uV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a466a27d30aso687386966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710840503; x=1711445303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kymKEteOVObESDNW5Fg6UlQetyaf6y6BwpOtbOdOW3o=;
        b=nKjaR6uVayQjCag9YmkHKchRIjrb2InDky1mXIpEbFRH9jlRuazPVtxFYajQw4F374
         BxoPjJkOIWknzIYDbpIJdpLcKrHdGSSJafZCKOWFgQjMQS0CeueY8FtJz5pAb0HoZ9D6
         d77A76OKaiKhwPF5w6IyeJqR3pWEYNe1mWClolIHIjoTlx7lBE2jfUUfcrJp7rEgXclM
         frFHFrc/CLj9I6p5fzLTzA/dGWZFP6li4uF6kOqFA/U+9XWrRqqgv2mgCXWj4txYATZZ
         B3/j66BYQjl1hXmljtEAfEm7AxvBFAo+/x8IgmVvLUU+v2ETJtK74RidpsimKHLeybAC
         FMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840503; x=1711445303;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kymKEteOVObESDNW5Fg6UlQetyaf6y6BwpOtbOdOW3o=;
        b=nsXplkp72NzNz3hJlknfWz1TBfm7jk34lEcumW08z241rBEBABKoGIylsdYQ5oLf7S
         e6Z2FXCHow5RGNJqRH/RMwftEdx7WQhTMOtXcllVEAfy8NmcCXttHyqkKMseg2Y6qDqM
         DZctTyBnysuS9j53WA36EEDSe3p91bwp+8C+kEIGnBWyZ4guLL4KGqPJKUuqBocIxF50
         Kf86gipEfuoKekUMrxWRXNDmzaK6akuBYS+iMkK/lBmMenvdhgNYOSdhaS3hOdW98DWB
         tEyT23slWTeAXdExHINTvqYrKy53mT1EH8hslBcN5w9EPm5CntHWpmTplTBF6mSMsNm6
         mT5w==
X-Forwarded-Encrypted: i=1; AJvYcCWO+rS6dI7ZskEUeM7XlJ0SBEeTZgrPmeh9CcE0NBJHCn0U6DJogSPPSaQuBpEEainPFJRayfGQ5Iy42/pnqPoBBSvn1m0q0QFCRs4Q
X-Gm-Message-State: AOJu0YxgEpRzhtC/v/oWBLXQzv2J6lmZQuIAFJXlIg0ju/bEJjqNCc9J
	2dqYE8Bri2DeUc2n3IUBzwwZmytoE/kYM+ko0p+5rc8LbTD6avhYdhXFw19BgCU=
X-Google-Smtp-Source: AGHT+IGOpC0whwjzVjMTL4s1NEti9lQQP192YRINNtx2TmmxGlmcu2J/vJb13KVgo2sM3979VaF1Gw==
X-Received: by 2002:a17:907:7248:b0:a46:e4dc:25ab with SMTP id ds8-20020a170907724800b00a46e4dc25abmr623554ejc.47.1710840503538;
        Tue, 19 Mar 2024 02:28:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id q21-20020a1709066b1500b00a46524d06afsm5784034ejr.8.2024.03.19.02.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 02:28:23 -0700 (PDT)
Message-ID: <0ad56d9d-9ba4-40ff-9917-0b71bb530673@linaro.org>
Date: Tue, 19 Mar 2024 10:28:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: hwmon: adc128d818: convert to dtschema
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318-adc128d818_dtschema-v1-1-d0af2caef145@gmail.com>
 <de0b32b3-348a-4d42-89cd-df2c439b8009@linaro.org>
 <beddae56-caef-4684-958b-d11ca0808055@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <beddae56-caef-4684-958b-d11ca0808055@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 08:01, Javier Carrasco wrote:
> On 3/19/24 06:49, Krzysztof Kozlowski wrote:
>> On 18/03/2024 21:12, Javier Carrasco wrote:
>>> Convert adc128d818 bindings to dtschema to support validation.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>
>>> +$id: http://devicetree.org/schemas/hwmon/ti,adc128d818.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Texas Instruments ADC128D818 ADC System Monitor With Temperature Sensor
>>> +
>>> +maintainers:
>>> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> +
>>> +description: |
>>> +  The ADC128D818 is a 12-Bit, 8-Channel Analog to Digital Converter (ADC)
>>> +  with a temperature sensor and an I2C interface.
>>> +
>>> +  Datasheets:
>>> +    https://www.ti.com/product/ADC128D818
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,adc128d818
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  ti,mode:
>>
>> You need | to preserve the formatting.
>>
> 
> Thanks, I overlooked that. If I am not mistaken, 2 are still missing 
> (ti,mode and vref-supply descriptions).

No, although I commented in a bit wrong place. It should be in
description of ti,mode. Not in vref-supply.

> 
> By the way, do you know why dtschema does not complain about that? If I 
> place a '|' in a wrong place, it does complain, though.

This is formatting, there is no reason to complain. How would dtschema
understand that you want or not want formatting?

Best regards,
Krzysztof


