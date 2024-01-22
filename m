Return-Path: <linux-kernel+bounces-32227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310CC8358DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538212822E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362036B;
	Mon, 22 Jan 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwXseGBQ"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9906D360
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705881883; cv=none; b=MbyVn8vPwQMfjOLYUATUyXioJD6RPkJkYxKVk+PR2IAbtLKdNeoGSKLcDxPRptNV9pZwT8vntj/R/G/o+hA44VUh/HkUcHRuXz0dZEaD0pZN8AwRnxeARb7Hnkw5QSvUvGgBZnpkKyWK688Nf2ov5OAXU1aDDS3jG/4wxLFg1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705881883; c=relaxed/simple;
	bh=/ULamA22NiwL3lkm0oOrpcSQqP16Wr27ft5NeIDulhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9XTF3fVQ6W8Np7Ns0VUEH00YIfaOFSD8tthHLNwV7wI5zPLPlEbOMAll22qowTd5HSqBpLKVtheHUw/sxt9eHQ+e7RkCfLbniToB3eW1Hwd9BPPh7wR4youQoE7R9gvq3cpZGRxZjrqKtQtvidd0CAZbHSCpGfd6rwnIv06Zk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JwXseGBQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33931b38b65so687731f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 16:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705881880; x=1706486680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zlEZyotr7lQewRwJXfl4AVVs7IqSe9mLqbTp7FrGZ4c=;
        b=JwXseGBQ1lfhoj/2oIPD/uz7JZmGVkY3Gi9DpR0CpCTrm5C2DgKaMYuooL52eInCrf
         XG3jRickLoKGv+l1IuIwYN7PxkdSjkg4fkd6GcbKdb0o/rYloe78thufRw+MgVAngdRb
         iOTveASUzW0n3rqamvKflf8CX1aT1b/kcLK2jxVOPjEcJP19VYObuY3MPqQyyjs3SmSc
         tA31wmLi20vL4S+kaF5sKuhtdUEmqkhXmdlV5VJkorjmM/Laim0xV8rh12hi7qhoOpwC
         39mF0FF2+28cJVxHT8Su2wPjQr0xoJywz+JdZH/uvXYJRsktBG86hHMVCkJ63Ltt0ZKV
         gpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705881880; x=1706486680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlEZyotr7lQewRwJXfl4AVVs7IqSe9mLqbTp7FrGZ4c=;
        b=TI9lihPP3+1boDkWRnf+EAY5eE6GC0TplljKouJqCfY7BGwj2kmCj6sOkA1N6ffQBQ
         XSLoi1tYEWjaOfRBtoP3OHe7A/oQP8XzZttEiIKZpGwziFaHIpQ8xILY4Ce/Ee4f79k0
         DSauN6LDpi89XqTTvGHPwEHQQUYI7WqdVG6eH7QwXpYyrgSr4zV0d1bNzelKvjAi0KDu
         mbf4pbQd78zX7AZgqYCZ54Q/bGuUqo/MQ0ubqWqv/kYt3UUwUCNqgyJGaxFeNdGe+e0r
         kK/NkO2kkhI3elPwlx2RhXPkjMmM15acyo/2C5YFgxKLKMQpmN5B6ibVbXq0P7ZeJ/Eg
         iguQ==
X-Gm-Message-State: AOJu0YzocoDMWGStdbREpnZmB9zOCLwwoxw+5Wvs+LV3E3I54SQTQrD1
	PXBReZTJclTtaVLxuszfN7B4GqI1+8jT6sThJvZrJ3KBCC3qDkxz0U9ZH/iW4Vo=
X-Google-Smtp-Source: AGHT+IGRUcJnOFsQp7DY+zsXgFaLMfVCir7fUcEIhdDpS5U3lN7oKicfCyySWRw9DEHt6YVffn2IfQ==
X-Received: by 2002:a05:6000:142:b0:337:d4ca:d754 with SMTP id r2-20020a056000014200b00337d4cad754mr910481wrx.263.1705881879492;
        Sun, 21 Jan 2024 16:04:39 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:371e:2a86:62f0:bc48? ([2a05:6e02:1041:c10:371e:2a86:62f0:bc48])
        by smtp.googlemail.com with ESMTPSA id s15-20020a5d6a8f000000b00336898daceasm10011000wru.96.2024.01.21.16.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 16:04:39 -0800 (PST)
Message-ID: <e45f72c2-0b5b-44dd-ad39-e7e5bd17ae26@linaro.org>
Date: Mon, 22 Jan 2024 01:04:38 +0100
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
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CABjd4YxYpsvf+ghHTn1z8TAZxQb-2dFOQaVSm8zHKSSWOokqww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Alexey,


On 21/01/2024 20:57, Alexey Charkov wrote:
> On Fri, Jan 19, 2024 at 8:21 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> Hello Daniel,
> 
> Thanks a lot for your review and comments! Please see some reflections below.
> 
>> On 09/01/2024 20:19, Alexey Charkov wrote:
>>> Include thermal zones information in device tree for rk3588 variants
>>> and enable the built-in thermal sensing ADC on RADXA Rock 5B
>>>
>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>>> ---
>>> Changes in v2:
>>>    - Dropped redundant comments
>>>    - Included all CPU cores in cooling maps
>>>    - Split cooling maps into more granular ones utilizing TSADC
>>>      channels 1-3 which measure temperature by separate CPU clusters
>>>      instead of channel 0 which measures the center of the SoC die
>>> ---
>>>    .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
>>>    arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 151 ++++++++++++++++++
>>>    2 files changed, 155 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> index a5a104131403..f9d540000de3 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> @@ -772,3 +772,7 @@ &usb_host1_ehci {
>>>    &usb_host1_ohci {
>>>        status = "okay";
>>>    };
>>> +
>>> +&tsadc {
>>> +     status = "okay";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>>> index 8aa0499f9b03..8d54998d0ecc 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>>> @@ -10,6 +10,7 @@
>>>    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>>>    #include <dt-bindings/phy/phy.h>
>>>    #include <dt-bindings/ata/ahci.h>
>>> +#include <dt-bindings/thermal/thermal.h>
>>>
>>>    / {
>>>        compatible = "rockchip,rk3588";
>>> @@ -2112,6 +2113,156 @@ tsadc: tsadc@fec00000 {
>>>                status = "disabled";
>>>        };
>>>
>>> +     thermal_zones: thermal-zones {
>>> +             /* sensor near the center of the whole chip */
>>> +             soc_thermal: soc-thermal {
>>> +                     polling-delay-passive = <20>;
>>
>> There is no mitigation set for this thermal zone. It is pointless to
>> specify a passive polling.
> 
> Indeed, it makes sense to me. There seems to be a catch though in that
> the driver calls the generic thermal_of_zone_register during the
> initial probe, which expects both of those polling delays to be
> present in the device tree, otherwise it simply refuses to add the
> respective thermal zone, see drivers/thermal/thermal_of.c:502

Usually:

polling-delay-passive = <0>;
polling-delay = <0>;

cf:

git grep "polling-delay = <0>" arch/arm64/boot/dts

>>> +                     polling-delay = <1000>;
>>
>> The driver is interrupt driven. No need to poll.
> 
> Same here as above
> 
>>> +                     sustainable-power = <2100>;
>>
>> There is no mitigation with this thermal zone. Specifying a sustainable
>> power does not make sense.
> 
> Thanks, will drop this in v3!
> 
>>> +                     thermal-sensors = <&tsadc 0>;
>>> +
>>> +                     trips {
>>> +                             soc_crit: soc-crit {
>>> +                                     temperature = <115000>;
>>> +                                     hysteresis = <2000>;
>>
>> This trip point leads to a system shutdown / reboot. It is not necessary
>> to specify a hysteresis.
> 
> Similar to the above, the generic thermal_of code refuses to add the
> trip point if it has no hysteresis property defined (regardless of the
> trip type), see drivers/thermal/thermal_of.c:109

hysteresis = <0>;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


