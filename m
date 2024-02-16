Return-Path: <linux-kernel+bounces-68255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679958577DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF5D284652
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F09C1CA89;
	Fri, 16 Feb 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0PUo7gj"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC831CA82
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072879; cv=none; b=pKijOK47tOuz/L2JDhY6H9iq9cnXjF5OJpFWeiTEuzeQfg23BGciinf5p++mpfEo96BEFzE1GNbWnw1r68kaIPJA22lVB3gqHC0KhbENujPa5JeTWdjTQKnOln11pZZ69ph+eZE6ksyrh5zx5gDYSPb6dtsLNXyU0Qdy9GOITi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072879; c=relaxed/simple;
	bh=yeAPzY7e7kL2l5cR9MSpRd3hP7jSlDo72LHJs57k6iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQ+Hf5OPHUkXf893KeAXSGhGiYQaFzKlznoVuvKUF8ikdIcDspowseY7s0x4ysuXMeOprYTCKSXFi3YcUVGtsjoNGkCJ7CUeHdnJUs4Cft1spMHj19IDbosxtV+SyzpNV2laefhV0uUo2wkSq3CyrXH0K9Iw7q4FOFwr3uRBa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0PUo7gj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-511976c126dso2310434e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708072875; x=1708677675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dH/NWws6eSTpoEw+0q4ey+Se96RL2bWn+Y8RSTo49wI=;
        b=D0PUo7gjdI9WOhlH+m5h8TIOvX3cQKsM4BxgRLtoQBFIVXq3GAJUEwXuvNqEBwynmE
         1o2hwZwSXmDRvkfZ/R2q3iKPObr+f59MBPRhUMbwx5n6gKf80cErTaIMU8RYj01DfX6c
         MxvwV5EocBrxpq7HUK3JhGyGF4OTjrFQ+61+BEGJki64wp4ULzUXHcINjJjRZX/eQ4KE
         LoHdmf26wdp6vSth+/UBWd9lcBMVplsmJTUAi5IZA4lQpi3sF2HQT1eVy9LcyxrAICxV
         ZlnOjbzKINyr+mto8tblrysVbhpUszXj+iQpR+EKAvd75IPN+4V4OmSs7TdI+a6zXdaE
         30Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708072875; x=1708677675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dH/NWws6eSTpoEw+0q4ey+Se96RL2bWn+Y8RSTo49wI=;
        b=sqAQ39Lji64HWgr6Rban8KjM+D0R8pgJ6pV7WfoW6ruAG8dia/FbJTRMHVsf1iHKeQ
         E4XLopCU8cW6FxS8waB3PUE2P+0/xjKz5+aACbP06yt4xZ3sJWkaC1KjI9KYpB4brZjE
         +pCz9arbUb/9pzn7L4GGGRxpJYx7e1Tk2UGRrScpNnTIey7hM/ogSDj6NqiQn0Fg42Kd
         c4AN0yKIwjV0DF8yJb2qV327oC2A8TEB+9VvRwJdYmZSFMOCiy0AEkeAHM2Gc6oIRizx
         JQ6ZPErVX3urkXY5izva2J9sKgmSRJ7dhgQEsKP/0+dLrFsuD2HZQyYYe6YHDueLWHE6
         WXmw==
X-Forwarded-Encrypted: i=1; AJvYcCWoDCaFaj9c+MrJiG/B6k54Lz2i7AvhOdm5kkdx01H7qLYbiJ5huQ/DUmGI7iW6mcme1eDshvN1xtcU4g9oxpH74VvM1MPsJ8210a75
X-Gm-Message-State: AOJu0Yxg7XS2yRai2sP63DaZ/+G38wY6VVtrS+gVgvl7yepQbdvpUBMe
	q+QUfBoAl/yRWzetbox3NV4lalgkIoortKGKjCBQRAE77I/XxMm4+t7LjVX427Y=
X-Google-Smtp-Source: AGHT+IFEP/ilFZ9OxcCFH5jfdKLFWuNmUdyOvNIX/yeBqimBEj7bzmsupkQ0+3+Qn42FkTpLfq9i6A==
X-Received: by 2002:a19:5e12:0:b0:511:97f6:83b with SMTP id s18-20020a195e12000000b0051197f6083bmr2468295lfb.61.1708072874738;
        Fri, 16 Feb 2024 00:41:14 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id h13-20020a50cdcd000000b0056400d02cc0sm111853edj.23.2024.02.16.00.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 00:41:14 -0800 (PST)
Message-ID: <8abfeca7-cecf-4d36-856e-bebabd3f72d6@linaro.org>
Date: Fri, 16 Feb 2024 09:41:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: mmc: dw-mshc-hi3798cv200: rename to
 dw-mshc-histb
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
 <20240216-b4-mmc-hi3798mv200-v1-3-7d46db845ae6@outlook.com>
 <36450b1e-7a80-4d6b-9046-9a57b7c845e2@linaro.org>
 <SEZPR06MB69592A3F9737DFA6E0E9096C964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69592A3F9737DFA6E0E9096C964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 09:29, Yang Xiwen wrote:
>>>     reg:
>>>       maxItems: 1
>>> @@ -48,6 +46,12 @@ properties:
>>>         control the clock phases, "ciu-sample" is required for tuning
>>>         high speed modes.
>>>   
>>> +  hisilicon,sap-dll-reg:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      A phandle points to the sample delay-locked-loop(DLL)
>>> +      syscon node, used for tuning.
>> Does hi3798cv200 have it?
> No it does not. Currently only hi3798mv200 has it (it's called himci 
> v300 in downstream, while cv200 is using himci v200).

then in your if:
else:
  properties:
    hisilicon,sap-dll-reg: false

>>
>>> +
>>>   required:
>>>     - compatible
>>>     - reg
>>> @@ -55,13 +59,25 @@ required:
>>>     - clocks
>>>     - clock-names
>>>   
>>> +allOf:
>>> +  - $ref: synopsys-dw-mshc-common.yaml#
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: hisilicon,hi3798mv200-dw-mshc
>>> +    then:
>>> +      required:
>>> +        - hisilicon,sap-dll-reg
>>> +
>>>   unevaluatedProperties: false
>>>   
>>>   examples:
>>>     - |
>>>       #include <dt-bindings/clock/histb-clock.h>
>>>       #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> -    emmc: mmc@9830000 {
>>> +    mmc@9830000 {
>> ???
> It's complaining about duplicated label when i added emmc label to both 
> nodes. I'll remove it in previous patch in v2.
>>>         compatible = "hisilicon,hi3798cv200-dw-mshc";
>>>         reg = <0x9830000 0x10000>;
>>>         interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>>> @@ -84,3 +100,31 @@ examples:
>>>         bus-width = <8>;
>>>         status = "okay";
>>>       };
>>> +  - |
>>> +    #include <dt-bindings/clock/histb-clock.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    mmc@9830000 {
>>> +      compatible = "hisilicon,hi3798mv200-dw-mshc";
>> No need for new example.
>>
>>> +      reg = <0x9830000 0x10000>;
>>> +      interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>>> +      clocks = <&crg HISTB_MMC_CIU_CLK>,
>>> +               <&crg HISTB_MMC_BIU_CLK>,
>>> +               <&crg HISTB_MMC_SAMPLE_CLK>,
>>> +               <&crg HISTB_MMC_DRV_CLK>;
>>> +      clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
>>> +      resets = <&crg 0xa0 4>;
>>> +      reset-names = "reset";
>>> +      pinctrl-names = "default";
>>> +      pinctrl-0 = <&emmc_pins>;
>>> +      fifo-depth = <256>;
>>> +      clock-frequency = <50000000>;
>>> +      max-frequency = <150000000>;
>>> +      cap-mmc-highspeed;
>>> +      mmc-ddr-1_8v;
>>> +      mmc-hs200-1_8v;
>>> +      mmc-hs400-1_8v;
>>> +      non-removable;
>>> +      bus-width = <8>;
>>> +      hisilicon,sap-dll-reg = <&emmc_sap_dll_reg>;
>>> +      status = "okay";
>> No, really...
> The property "hisilicon,sap-dll-reg" is introduced in this patch, i want 
> to add an example for it here since the common dtsi will use this 
> binding and will be submitted when it gets ready.

One new property does not justify new example.

Best regards,
Krzysztof


