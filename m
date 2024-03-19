Return-Path: <linux-kernel+bounces-108065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7624880578
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58977B217A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775273A1C7;
	Tue, 19 Mar 2024 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iByUR+re"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D939FE0;
	Tue, 19 Mar 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876731; cv=none; b=D6I74gw7i6CJCIDn4b3mAWXFPQPUwrNdLCJ6dl3ZQw+ZVTVaR6N/x74zeg5yFLGMztFnq8A9OVQA8XRy5OosV6JY7CiHEEHnWVzQnJJv6Vgs5qsWFmp7iRPV0Haoyz4pm3qYmqKoi+9/POlG7Kw5v9OOiXTlUdCDgZ8wL5XjK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876731; c=relaxed/simple;
	bh=YqBp34vKPLCBMBam4lqubkUHO0l3V44ltPc3JgMdLx4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=faFz5lUQM6/sUqBRHfrwmO+dXRFX0QyZg7YPUQEio2RUoJtEhCfarip1CPs3xewbfmpJlkEZwTbzavFjyD0YXSbuxlBRysalzDEg/lO7DDD2hVbjiJCOwFxBfhrYy3emLbnWWKngaX2Z/xLDi2nQuXDfhRcpXfEGU+Z9OH3WBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iByUR+re; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41466dcd397so6499325e9.0;
        Tue, 19 Mar 2024 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710876728; x=1711481528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vy6XTZqO9wmiEsrMzKBUqIwyHIl1ReIJIJkl/N0Tieo=;
        b=iByUR+rex+KmpUQtHQxNRsaBjXIaP2u2NldJRtDMIJ/kPlRboWbhdRc93E1mtVBENR
         FbqpmSPkWklNbauKCsjc+ZJW3kuXks/Yg/9He6d5mtyhMkWoHxOZkT79W9SOLWjpQMdC
         /Rki5NSoQqERHEvk+ENeNa6iifd8iyIgzzW/oqPke1/E8VwoH+4i3Br5ZXluhlvfqg3s
         JcOf6KGrXhJJaeebLSDX/wEAvCjUK4YmjYiB6Rt1LcGu6TuxIAbcYAC3t8AaixO3xmBE
         u1bD5uj788LgE68qm/MdGXLvay1lqvX+a+4WM77qIzBRll/I/8MX4CJx6Oh02/PWk4xp
         8Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710876728; x=1711481528;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy6XTZqO9wmiEsrMzKBUqIwyHIl1ReIJIJkl/N0Tieo=;
        b=Q2xNp1V1z0F4reFco3WOGVlmNFfDAQnyEk6z+P98LWQCHhhyFw5BpsxX8etrHWsNyG
         qkam8bNsID6Amlgp67vlAXNBFjG76vynuN8Ii5f3Dw9w1CRrjAgrer3UTuEN87jLKtUN
         vlrQMOXmGYUiOiuU3xNt7RwzL4uJjwXUReOsjSxoaKcFUMG5zk59kKvV8gF/7nH1eLXJ
         n81wfvUhQheZBYPSAbWiB+uPV4v4D46wT3W3ryfTe4rY6U/IlxzgbLMC0eyrdI7oKhOs
         MwXtT0SAPnNzqjoer2lN/Us/q7bziO2qMGFb7gxjxPSrMKoP1BP7m5eud4xAFAewSP1e
         T9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVzc7wU334WPuC8CaazMSuJpb33sYFp1gln55LQr1u6UzPSj0pA+aDFMY7AFDce19RIWAcO1R1AvxIa8c0RrAqqmxCczcZoNFkpTN8FPtpIWT5qjwZCjr5DbzUMTtS3fqwGjeguiLJDz5AdnoiYyZFQNfNISjxvh3xD8sEbtS536t6V
X-Gm-Message-State: AOJu0Ywqq4JeLVC5rZZpFvxhpNMvXIvEkF/zm3xiaaTrEeIKgPOUytKa
	/xkSDyT/mlia37Wb+g9iRf2HYIU6Ac44+X5LDWdCARk60M44VVJLuXE+TiLOeOE=
X-Google-Smtp-Source: AGHT+IFVWDicIe6Kk4Ovz+PxKm1zKPzKIZY+V4D1BYM61Pz7sYmfgX1kTsmtPN9tEIh/2oW2aT60CA==
X-Received: by 2002:a05:600c:3504:b0:414:1eb:301a with SMTP id h4-20020a05600c350400b0041401eb301amr80867wmq.28.1710876728308;
        Tue, 19 Mar 2024 12:32:08 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c511700b00413fea18735sm16298775wms.13.2024.03.19.12.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 12:32:08 -0700 (PDT)
Message-ID: <010698c5-de92-4c7b-a476-b961b7ae9c72@gmail.com>
Date: Tue, 19 Mar 2024 20:32:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: convert st,stih407-thermal
 to DT schema
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240301-thermal-v2-0-1b32752029ec@gmail.com>
 <20240301-thermal-v2-1-1b32752029ec@gmail.com>
 <20240304184032.GA865748-robh@kernel.org>
 <0b5c5487-86e2-421e-a4ee-70b164244fb0@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <0b5c5487-86e2-421e-a4ee-70b164244fb0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rob,

It's been a few weeks.

Gentle ping :)

Regards,
Raphaël

Le 06/03/2024 à 08:53, Raphaël Gallais-Pou a écrit :
> 
> 
> Le 04/03/2024 à 19:40, Rob Herring a écrit :
>> On Fri, Mar 01, 2024 at 06:47:28PM +0100, Raphael Gallais-Pou wrote:
>>> 'st,passive_colling_temp' does not appear in the device-tree, and 'reg'
>>> is missing in the device description.
>>>
>>> Convert st,stih407-thermal binding to DT schema format in order to clean
>>> unused 'st,passive_cooling_temp' and add missing 'reg' property.
>>>
>>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> 
> 
> Hi Rob,
> 
> ...
> 
>>> +  interrupts:
>>> +    description:
>>> +      For thermal sensors for which no interrupt has been defined, a 
>>> polling
>>> +      delay of 1000ms will be used to read the temperature from device.
>>
>> maxItems: 1
> 
> Ack.
>>
>>> +
>>> +  '#thermal-sensor-cells': true
>>
>> const: 1
>>
>> Also, not in the original binding, so please state in the commit msg
>> why you are adding it.
> 
> I have mixed feeling regarding the value. Wouldn't this better be 
> 'const: 0' ?
> 
> In the thermal-sensor binding it is specified that it should be 0 for 
> single sensor nodes, which is our case.
> 
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - clock-names
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    temperature-sensor@91a0000 {
>>> +        compatible = "st,stih407-thermal";
>>> +        reg = <0x91a0000 0x28>;
>>> +        clock-names = "thermal";
>>> +        clocks = <&CLK_SYSIN>;
>>> +        interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
>>> +        #thermal-sensor-cells = <0>;
> 
> If I misunderstand something and the value must be 1 then I will also 
> change the value here and in the dt patches of the serie.
> 
> Regards,
> Raphaël
>>> +    };
>>> +...

