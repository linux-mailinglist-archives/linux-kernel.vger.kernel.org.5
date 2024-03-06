Return-Path: <linux-kernel+bounces-93447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC490872FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADA3B24F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702EA5CDEC;
	Wed,  6 Mar 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPw4toV/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5DD1B948;
	Wed,  6 Mar 2024 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709711603; cv=none; b=nWOBJTLmxPQOxilEkcODyFsLaQUk4xvEcYjyiz6yn2SSjbrWHVT1ASavVWJaPzPxLCUMdcBeDYasP0WpfqBjxlAwH0vKCdEr69v68ULlzBPmwSN0EkfDuVdT/hap5jmcKkduogN9NbYMfPkvOlhaxQOcKdzXtZ8sje+JgkSiWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709711603; c=relaxed/simple;
	bh=0GhOpeI1TUJBDP7ekLlYqS9Gc0595hYONcODQ1n4X10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1kJvI9aBDE4oEzT6mBAtDn2sZJRly5XoeMlmFcv3qcGvXRml51Uw9jZL/oD2ypbTtDU0cirbJQ8BoOOOZEHBbEvP6zVizgUipbn0/x0LYp884sFAAmN/vEK0outp9QWicu/ygIwbP1NAeJF9i+JE/Xfp/0/EoCN4iDXSyiOv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPw4toV/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412f5e905e2so2368475e9.3;
        Tue, 05 Mar 2024 23:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709711600; x=1710316400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8xbyCoDN1A4ZxIHGpA7D3Gz61UaZom+rI834unCodc=;
        b=HPw4toV/EnsKAyNhzGkLDDQZqld2iQyky05o6/B49WA4QVzbIiWdxXX/VUo27EngER
         IbGj+IOjjw8LWjccQYfx2s8aFRcmtSD0eBJFQWSpuk4F81uUJWrgSQ4g3/YU37cMh7o2
         DUHOqH/He1q1WQvOnMXnZ+NOVMdriGa1VRSTvKyEgNB4hYx9RLr4S0MH0bKssYRCaZx4
         sw/n5SqihzUXQN2vIBkR+koVvNSJghwWBjqrkpD1hxw5jojmp+cp5Fv61KHOhgLTjlcN
         vtEGFBEX9PHG2NVzSJzRf2qe+OuRymQzuzyM6hY4LcynifMWo3sb+Mi/NcGgS9TOssjd
         VSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709711600; x=1710316400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8xbyCoDN1A4ZxIHGpA7D3Gz61UaZom+rI834unCodc=;
        b=tiYsaIcHopITVyMxg7x/iaTMA9Wg62xJ5oc7KxhoE6M4xZwby9geFoGBzFexIa57j/
         N/b954n8gSQ8jBzq3q/ygbY3Mn0oQfwCN0DSfwjKK6uwrlvKQhlLW7kjwk5XwNEGO+19
         ybBLqs9VOEwKhm10/eLDxsxPEOQ4Gx1FPs2K/rkb2/X993Fkgf6IY2ma6DAw3PoT9u/a
         5rf+O9FGVmZetwnv5Nigy9zGE3uNU3kxJX0Iymvz/vp97LxjClbVNpAoPfsVjK/VH6Em
         iLl/+JLG3yBwUjwdWCc6nifVG6q0jSDCKeSIhWBG63Xs5IE4WoFMiZsswUPnFZTmmxcG
         wWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCTjMaYn72WS4jx2vtrF9PMDNOcb9Nrr7E6dN0Xc/4l1m6+Y7Q4i7g/qUBRLT61mx/D8WpQKzTdpBATzw0RIM13ojltPevxMpPvQRcmnirlrT27ZzRJ4y8qDsR51zD4p66ZyMsgRD8w/p9D4/vlpNqKNXhv5QLXwA/JcNucaIUtRFE
X-Gm-Message-State: AOJu0YyjRStaYx4a7/gOHtGvU4jSJMcU+/T3p8nFNoDCmwfPKUahuaMP
	ZrzMOPT6vP1yAKlZh9FxvhQTxLjAT9hDov5ClRZdRvxzk4lfjjQN
X-Google-Smtp-Source: AGHT+IHE4tunHSfTvCO0XcCNXdyOUOoeW8fufiu1ndQaL+PQkZdPibobAf6MEdsXLauFCAe1K6O3HQ==
X-Received: by 2002:a5d:4a4a:0:b0:33a:eb10:e9e8 with SMTP id v10-20020a5d4a4a000000b0033aeb10e9e8mr8876149wrs.43.1709711600184;
        Tue, 05 Mar 2024 23:53:20 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ch14-20020a5d5d0e000000b0033e18421618sm15237270wrb.17.2024.03.05.23.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 23:53:20 -0800 (PST)
Message-ID: <0b5c5487-86e2-421e-a4ee-70b164244fb0@gmail.com>
Date: Wed, 6 Mar 2024 08:53:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: convert st,stih407-thermal
 to DT schema
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
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20240304184032.GA865748-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/03/2024 à 19:40, Rob Herring a écrit :
> On Fri, Mar 01, 2024 at 06:47:28PM +0100, Raphael Gallais-Pou wrote:
>> 'st,passive_colling_temp' does not appear in the device-tree, and 'reg'
>> is missing in the device description.
>>
>> Convert st,stih407-thermal binding to DT schema format in order to clean
>> unused 'st,passive_cooling_temp' and add missing 'reg' property.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>


Hi Rob,

..

>> +  interrupts:
>> +    description:
>> +      For thermal sensors for which no interrupt has been defined, a polling
>> +      delay of 1000ms will be used to read the temperature from device.
> 
> maxItems: 1

Ack.
> 
>> +
>> +  '#thermal-sensor-cells': true
> 
> const: 1
> 
> Also, not in the original binding, so please state in the commit msg
> why you are adding it.

I have mixed feeling regarding the value. Wouldn't this better be 
'const: 0' ?

In the thermal-sensor binding it is specified that it should be 0 for 
single sensor nodes, which is our case.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    temperature-sensor@91a0000 {
>> +        compatible = "st,stih407-thermal";
>> +        reg = <0x91a0000 0x28>;
>> +        clock-names = "thermal";
>> +        clocks = <&CLK_SYSIN>;
>> +        interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
>> +        #thermal-sensor-cells = <0>;

If I misunderstand something and the value must be 1 then I will also 
change the value here and in the dt patches of the serie.

Regards,
Raphaël
>> +    };
>> +...

