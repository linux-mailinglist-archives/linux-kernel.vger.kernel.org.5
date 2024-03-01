Return-Path: <linux-kernel+bounces-88780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49B86E67C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABA0287983
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2BE8BE3;
	Fri,  1 Mar 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l45mJ6sZ"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2446B3;
	Fri,  1 Mar 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312163; cv=none; b=gyKT4zAoXUFKfUBamUw15sEic8suqrksm+A8knGjoATgdFVT3yi9D3fJf/wftKk6jSNFR9UQkjkissDVSimx2NuYE3YiQNDB+k0az9aVbFx/nMHxpJ8Um75JUrcF6oDzIo4APpT5WU2nV3LRB0917E2Cz19TByANmKofB90ZX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312163; c=relaxed/simple;
	bh=tcWwucxZhE6pxYFHGKRVseFc+s2my29VBUkiq6oiXAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbiJ/NEWePO3o+bPNaVQMa2eNGjps//BBIw+skIMPlUCJjtxdq32lj+YPOK3egIszfYWdgQ7g0PkdYSAP33JHSVkxtxb65qSyV9y8fGyWWxqWR1WDDTAK/ILZLMJMiLsiR2KzbVJUxgMbL0pd/Un4cxazhUDRNaVYQLmh3l2/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l45mJ6sZ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4caabc3f941so1907519e0c.1;
        Fri, 01 Mar 2024 08:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709312161; x=1709916961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPAJ6R6o80p6wf3uDCdNNC+SWw3RQ8ctedBqfsViuIc=;
        b=l45mJ6sZDhtcAAqByEUzojstig+2Wv3XnCLQG3foa+KZN6eXpf0UqbIh8qNT9bUnnw
         VMvL7ayRbilVcxiuHQuVm/94RB/B2DKKXU8bYt5O/5Ksiu6U9U+II1ESZsDULLknGJu+
         9hTnGZBprG8/GVjVZPZCoXEPKryAbHgUPi3DTBcczMzfNy3zZO8QWUWlnUylopCxnJoJ
         GTmLOaz1uUtafcPqpII40yYhR49ddCLW/EvhQYwgozwIshmylFmSVuMtPMHcoKxw3hAL
         HxuBAddLX8NaHfaUVQ5QOlveAKHNRZbyKh4OHFKHMncLXekph/Yc1adq2u2PHA3PGI4W
         mjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312161; x=1709916961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPAJ6R6o80p6wf3uDCdNNC+SWw3RQ8ctedBqfsViuIc=;
        b=Sb677c2/Zn1hzFu1bkfnve+FHHm8zNCz2jmB45CmJNwH+LDiRV1k/BksEnik4el8S0
         zDE/8FuV3slyltoksN7GxgNalMWCUr7Egbf3fKsdGNTjLRW1nNrnOB9QEcfA8F3sy1O0
         GwvN8twfPGEKj22jrl9ZjXMK1VivEKZUsHh0fpJZgiBX46XkUD7NloRGZZe0eYP/G/9T
         jIWyH6BnligGd3tZy/8MKTbr9FrKPhUJ/GhFWo2Lo9A7PDYmuBRH0Se4CVRx6fvWE6mK
         ojb1xMF2Yv+NsoC/PJz9yoVdabkdnr5UKN/ZKxo4WBSCNp0FF13lnWIdcXZ7xszswAP7
         8EMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt4Gd90ONpZVWNxNvnUp4W2Znzct/TQjx/jyP30gF3q6q/n9FNZ6ey9NhmoPH81tcKWIJyCC2IOmp88PyKaoalmUCmlW2w4RiO6ui7TE7AnAnrbbcmsKo/25qOvI/1OIPald/mdgO1EA==
X-Gm-Message-State: AOJu0YySDwjnBDfEoDAzILjEVliM+bsULPzpRRicoFxjS98y9RO9sHHM
	obb0tV4lylvmo5U23Tbj+5UhXf/y+Jm99Ui4DwtUIwNO/GpM9mF/
X-Google-Smtp-Source: AGHT+IEXv5sPjY0IX0b69xli3x9+etwkVq0o/XCPKPjVDoSuX9MHOluxkIQzzJVAIH4VqCDYQ1PWiQ==
X-Received: by 2002:a05:6122:280a:b0:4c8:aaf1:1558 with SMTP id en10-20020a056122280a00b004c8aaf11558mr4519010vkb.3.1709312160820;
        Fri, 01 Mar 2024 08:56:00 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id h14-20020ac5cbce000000b004c880fc9728sm497196vkn.46.2024.03.01.08.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 08:56:00 -0800 (PST)
Message-ID: <f97cfe34-88e6-4444-876d-7eb6a636e877@gmail.com>
Date: Fri, 1 Mar 2024 17:55:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: thermal: convert st,stih407-thermal to
 DT schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240226-thermal-v1-0-8b03589ece73@gmail.com>
 <20240226-thermal-v1-1-8b03589ece73@gmail.com>
 <6db2491d-5f8f-43e7-a8c2-b9018bdb7617@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <6db2491d-5f8f-43e7-a8c2-b9018bdb7617@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Le 29/02/2024 à 20:15, Krzysztof Kozlowski a écrit :
> On 26/02/2024 08:48, Raphael Gallais-Pou wrote:
>> Converts st,stih407-thermal binding to DT schema format and cleans
> 
> Please use imperative for your future patches.
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
>> unused property "st,passive_cooling_temp" which does not appear in the
>> device-tree.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>>   .../bindings/thermal/st,stih407-thermal.yaml       | 61 ++++++++++++++++++++++
>>   .../devicetree/bindings/thermal/st-thermal.txt     | 32 ------------
>>   2 files changed, 61 insertions(+), 32 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
>> new file mode 100644
>> index 000000000000..807f8d77edf5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/st,stih407-thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STi digital thermal sensor (DTS)
>> +
>> +maintainers:
>> +  - Patrice Chotard <patrice.chotard@foss.st.com>
>> +  - Lee Jones <lee@kernel.org>
>> +
>> +description:
>> +  Binding for Thermal Sensor device for STMicroelectronics STi SoCs series.
> 
> Drop "Binding for" and describe the hardware. If you repeat the title,
> then the description is not really needed.
> 
>> +
>> +allOf:
>> +  - $ref: thermal-sensor.yaml
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stih407-thermal
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: Phandle of the clock used by the thermal sensor.
> 
> Drop description, it's obvious.
> 
>> +
>> +  clock-names:
>> +    items:
>> +      - const: thermal
>> +
>> +  reg:
>> +    description:
>> +      For non-sysconf based sensors, this should be the physical base
>> +      address and length of the sensor's registers.
> 
> That's odd, probably old binding was incomplete. You have only one
> device described here, so I expect this to be always present (thus
> description is obvious).

It is indeed missing in the old file.
> 
>> +
>> +  interrupts:
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +      Standard way to define interrupt number.
> 
> ???
> 
>> +      For thermal sensor's for which no interrupt has been
>> +      defined, a polling delay of 1000ms will be used to read the
>> +      temperature from device.
> 
> Missing thermal-sensor-cells.
> 
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
> 
> Missing reg and please mention the change from pure conversion in commit
> msg.
> 
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    temp0@91a0000 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
>> +        compatible = "st,stih407-thermal";
>> +        reg = <0x91a0000 0x28>;
>> +        clock-names = "thermal";
>> +        clocks = <&CLK_SYSIN>;
>> +        interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
>> +        #thermal-sensor-cells = <0>;
>> +    };
> 
> 
> 
Thanks for your review. I will send a v2 with the changes your mentioned 
above.

Regards,
Raphaël

> Best regards,
> Krzysztof
> 

