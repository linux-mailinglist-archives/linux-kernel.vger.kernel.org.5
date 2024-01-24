Return-Path: <linux-kernel+bounces-36210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F16839D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F8C28341E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843FC64E;
	Wed, 24 Jan 2024 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7CkrZQp"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E4368
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055296; cv=none; b=Zq4QI9kxU/IEnCFImm4qzqEC8STLxeUu8bkjXRn45MY3zSUoL/s16Qxg61ocoFHP1p0hgE/iE4YPOl3VLTpaDw7WtTHg97m0adDcVCFzBT649iACmfgfnit8khhce74VPf218S+g9j6/WHuLjRtAWvSx0/6oejGEqrDYUfn4UqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055296; c=relaxed/simple;
	bh=wu4CTPpVmSWZivP6mq6ykOws6HQjFnFI3ysivvrayfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QS7N9pyArbmPxTrh+hPDXY2q2zy6Ypo5Q/odQ0x9AwZZgh9rmFKWjzppiaMT/xu71oBYEVHHS1hegubwBsmCqdcxRDJwZt19pOaAN/YA3FxzNN8AkNAgpDF8YdvEbXsbr1vJOaUcSlVb9seaSilAndgajyBNlOlz8WL0mCCFTN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T7CkrZQp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so53542585e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706055293; x=1706660093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2nZ6S0mDBWrSLkiA4VI6JYuJMOmUsW/tHuIdM7KpMU=;
        b=T7CkrZQpfRDDkxPYpXiBu80aPGJF/S2kfap5vLb52kPH6RjGlZNTNuTjKKKCGJ6KqQ
         gxZmn5qseVzbmUfj9tWz2CnVfx3MXl59jpjBoD0MLRmUS3k9lrj+Gt2w+W2XUfxvcRBs
         RdFOtzokL8PnfJzAO6r+dH5tx/B4+KcE23SkOp8glYrRpyciw5gNPLi3XQVEIkFbyw7W
         pX9dKf1GBmZgla0h6wnGOqelO1bOZW5WH6kvs4f0v1W5VCkeyIV38W6xgy3g7+SqTsVN
         kbiJ7alafPq25ThoteaOphrh3q6NQqT1G6bLOTyPyG+fosIdeuxItBljj6FgnEXvP02S
         lV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706055293; x=1706660093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2nZ6S0mDBWrSLkiA4VI6JYuJMOmUsW/tHuIdM7KpMU=;
        b=ltY0iu8P/LY3lFFwuTp62fHvzLPNa8Hn5ZBJPfBJyMgLps8Vulpw2QgfVTEWS+Vlw4
         U88s33kWoKIVpnxxZwssWWrRBqAitMtfe1oXlLxAMSz7s4Z8KA4YVXaaHGgF53MAxxr+
         Se5Ypv9qH8l7/bYl0rSUyo+lkyF1Uix+PJeG/WOc+UeV3CgpH3efNrcr32G15kejwyXh
         /KfnuQZaILwN3nhn//F88VW3IqiflUN0hZjI+rPbk1JCIw7vU1fLvaogHbI7Ucy4wzAw
         HQphoKCVf/XUnFGa5JKECLmJrDQSXMnxP3QXF7A7QHIxAy8J5uPCqDGhSS66B+ReFRrC
         RpcA==
X-Gm-Message-State: AOJu0YyAFLerD1GJ1RkOpQOygh5FEVUp7rBlReULNAO6xtecAt+8Eo2/
	Tjm37VKiz7udYIBG0UTRyHkcUq7y4gwWu/zi0Uf0Q/8ITW/LqEuPSMprAj17WEk=
X-Google-Smtp-Source: AGHT+IGI5YPKFXD5TjwdPMdVu/mGtQFGrCy1XYQV+KrG7wGiPJsSjO/sWkXGpoAK7E4UafYcO9yT7w==
X-Received: by 2002:a05:600c:314c:b0:40e:abdc:dad0 with SMTP id h12-20020a05600c314c00b0040eabdcdad0mr536489wmo.105.1706055292708;
        Tue, 23 Jan 2024 16:14:52 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m11-20020a056000008b00b00338ca0ada22sm7436769wrx.111.2024.01.23.16.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 16:14:52 -0800 (PST)
Message-ID: <f7c7f8fe-cccc-4e67-aa4a-7758be0a912c@linaro.org>
Date: Wed, 24 Jan 2024 01:14:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
Content-Language: en-US
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <szucst@iit.uni-miskolc.hu>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240106222357.23835-1-alchark@gmail.com>
 <20240109192608.5981-1-alchark@gmail.com>
 <c517f26c-34bc-4b99-b744-8e2549cd28b5@linaro.org>
 <CABjd4YxYpsvf+ghHTn1z8TAZxQb-2dFOQaVSm8zHKSSWOokqww@mail.gmail.com>
 <e45f72c2-0b5b-44dd-ad39-e7e5bd17ae26@linaro.org>
 <CABjd4Yz+tqaS38B9uRUZC2nz_VeZ-Db6BpF5oWL3ahmskfbTMA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CABjd4Yz+tqaS38B9uRUZC2nz_VeZ-Db6BpF5oWL3ahmskfbTMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/01/2024 20:47, Alexey Charkov wrote:
> On Mon, Jan 22, 2024 at 4:04 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Alexey,
>>
>>
>> On 21/01/2024 20:57, Alexey Charkov wrote:
>>> On Fri, Jan 19, 2024 at 8:21 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>> Hello Daniel,
>>>
>>> Thanks a lot for your review and comments! Please see some reflections below.
>>>
>>>> On 09/01/2024 20:19, Alexey Charkov wrote:
>>>>> Include thermal zones information in device tree for rk3588 variants
>>>>> and enable the built-in thermal sensing ADC on RADXA Rock 5B
>>>>>
>>>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>     - Dropped redundant comments
>>>>>     - Included all CPU cores in cooling maps
>>>>>     - Split cooling maps into more granular ones utilizing TSADC
>>>>>       channels 1-3 which measure temperature by separate CPU clusters
>>>>>       instead of channel 0 which measures the center of the SoC die
>>>>> ---
>>>>>     .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
>>>>>     arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 151 ++++++++++++++++++
>>>>>     2 files changed, 155 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>>> index a5a104131403..f9d540000de3 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>>> @@ -772,3 +772,7 @@ &usb_host1_ehci {
>>>>>     &usb_host1_ohci {
>>>>>         status = "okay";
>>>>>     };
>>>>> +
>>>>> +&tsadc {
>>>>> +     status = "okay";
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>>>>> index 8aa0499f9b03..8d54998d0ecc 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>>>>> @@ -10,6 +10,7 @@
>>>>>     #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>>>>>     #include <dt-bindings/phy/phy.h>
>>>>>     #include <dt-bindings/ata/ahci.h>
>>>>> +#include <dt-bindings/thermal/thermal.h>
>>>>>
>>>>>     / {
>>>>>         compatible = "rockchip,rk3588";
>>>>> @@ -2112,6 +2113,156 @@ tsadc: tsadc@fec00000 {
>>>>>                 status = "disabled";
>>>>>         };
>>>>>
>>>>> +     thermal_zones: thermal-zones {
>>>>> +             /* sensor near the center of the whole chip */
>>>>> +             soc_thermal: soc-thermal {
>>>>> +                     polling-delay-passive = <20>;
>>>>
>>>> There is no mitigation set for this thermal zone. It is pointless to
>>>> specify a passive polling.
>>>
>>> Indeed, it makes sense to me. There seems to be a catch though in that
>>> the driver calls the generic thermal_of_zone_register during the
>>> initial probe, which expects both of those polling delays to be
>>> present in the device tree, otherwise it simply refuses to add the
>>> respective thermal zone, see drivers/thermal/thermal_of.c:502
>>
>> Usually:
>>
>> polling-delay-passive = <0>;
>> polling-delay = <0>;
>>
>> cf:
>>
>> git grep "polling-delay = <0>" arch/arm64/boot/dts
> 
> For some reason when I have both polling-delay-passive and
> polling-delay set to 0, the active cooling map I have in my board DT
> (using a PWM controlled fan) behaves weirdly.



> I use the following fragment in my board DTS:
> 
> +&package_thermal {
> +       trips {
> +               package_fan: package-fan {
> +                       temperature = <55000>;
> +                       hysteresis = <2000>;
> +                       type = "active";
> +               };
> +       };
> +
> +       cooling-maps {
> +               map-fan {
> +                       trip = <&package_fan>;
> +                       cooling-device = <&fan THERMAL_NO_LIMIT
> THERMAL_NO_LIMIT>;
> +               };
> +       };
> +};
> 
> If I add polling-delay = <1000>; at the top, the fan speeds up and
> down dynamically as the package temperature swings around 55C. If I
> remove that (having set polling-delay = <0>; in rk3588s.dtsi), the fan
> speeds up to the midpoint cooling state once the package temperature
> approaches 55C, and then it just stays there forever: it doesn't speed
> up above the midpoint even as the temperature climbs above 70C, nor
> does it spin down as it falls back to around 45C.
> 
> Is that the expected behavior for when the polling is disabled?

I don't know the rest of the DT this fragment was added to, but I'm not 
surprised there is misbehavior because the configuration is not correct 
in this case.

If there is a thermal zone with an active trip and an associated cooling 
device like a fan, then:
	-> polling-delay = <a_value>;
	-> polling-delay-passive = <0>;

If there is a thermal zone with a passive cooling device like cpufreq 
cooling device, then 2 cases:

  1. The sensor supports interrupt when crossing the trip point
	-> polling-delay = <0>;
	-> polling-delay-passive = <a_value>;

  2. The sensor does not support interrupt when crossing the trip point
	-> polling-delay = <a_value>;
	-> polling-delay-passive = <another_value>;

Why?

When the cooling device is a passive cooling device, then the mitigation 
happens with a higher temperature sampling rate in order to change the 
state of the cooling device hundred of times per second. On a fan, the 
cooling effect is too slow for that so we keep the polling for that.


> I haven't yet studied in detail if passive cooling kicks in correctly
> with polling disabled, but this behavior with active cooling left me
> quite confused - any pointers would be much appreciated.
> 
> Thanks a lot,
> Alexey

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


