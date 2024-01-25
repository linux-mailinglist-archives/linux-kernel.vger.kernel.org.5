Return-Path: <linux-kernel+bounces-38354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598583BE3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056EC1F23FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CAE1CAAE;
	Thu, 25 Jan 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnSFae0l"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7641CA85
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176954; cv=none; b=MfdczWyXB7ljlNfDvTxoNsTo8hoBXkaBZP8sOIrEIobS/8fZ+dlTaxZ/WCPRvDrFzkwkGyBr8sIZkf1pBlzj2SCcYtjAYlVN2vQVyFSuFhp5mp5BjrmoRzF4/cvSzfA2ZURsOkqXVAt4Y3GY1DjUHqel04RMrj3WZx6XpXZDaxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176954; c=relaxed/simple;
	bh=WLH6StazTgM8C9aOXaK4jJ1qIhJ+zjAVs+DFPg1cSrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPWpqUCaB6C5+QrcPPQLUdyohcrfe40RGzIoHwaWIxyn7cNNBIWVHeKxc/oR6j3Mlhh/tPF6Tu2HNYZ9t7exZThSp0kBJdYJidkY4SYcjcnRDiVanml8pnlAUpy+2WCnFnupH99jSdKgIFbK2Gr017guDdu394auMDtzGA6GKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnSFae0l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so71229315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706176949; x=1706781749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcuP9Suezw085ATY2+TEf2JH/9ZzcycdKepZHtrB0i0=;
        b=pnSFae0lrSo/Xv085NcyEm6GLNDdGInPmN1IV6XDR146XxRmA3jP2t2wmvk03TLsnI
         GX53IWFa6rC38eqTbAMv3rbyC2WVpkYD5LR4rzA9jg0T8iOMcI8LZE+YcNTeQEI1qS/i
         +yd68bAhcmMBgYk+Trlalvae4BoVw7xM4/2uMq91pX6m1qdFybRpypvzmmTylxZbjDj6
         RzJ/vwBRuR4UWuQNBVxM3zyvK+GohruvHBW9o9+muOIiZ9DzAJ8GSnL3GFctQQoOOHmi
         mzc3TxI+9fA0nBkx6CEsLSc36HzFI12BAo09phkQxV00/CBzOF6epNXbgHzfTxJObFcH
         tQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176949; x=1706781749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcuP9Suezw085ATY2+TEf2JH/9ZzcycdKepZHtrB0i0=;
        b=WB0hWDYR4QhcNdHh0P16yTc+l6XiScskn9ZnbpxwQtzekYZFTXgma03XGP7AaBQPbZ
         aWG7hZwxDqY6lbkpZtgH1xqsElpm8d+IY+TJl8a4/wZiMEZzPR9ENFdkVJQiO2strgo6
         W2JZUGzQOqmHLPwoWV84Of5IcZ5gsJ4Cqhuw7XNz1m9PMnMp6JicpckigjyZLD5SOD3e
         +ZI12ZezGxIjrl5b00gEdGaulygmatKVYGMkZn6yTlf3Pddk7PYK8+V+2hDFDaVewJp/
         yQtrqnGAlOgGSqNuV46+hfDZG6LiIxUEBa/DQ/p0m0DXfJWlXf91FALNgW59C5cC8HxE
         Y07Q==
X-Gm-Message-State: AOJu0Yy2GoTdUZI78Mqn2oEk2730QKfxH75gjq7TXaN8QlInQdyXBCFp
	Zwco+butoDyso1RLI9O0jRIBsnqGVHBEUHjGRb0QKd2XhoD0iO1HizLDB6bIb0I=
X-Google-Smtp-Source: AGHT+IHFxwb67WBKSitE4bHwvziRwgau3GaH95wfg0D8B8S/BgrD+o15VZJ3Jl+4qxBfnHN2wyrSFg==
X-Received: by 2002:a7b:c856:0:b0:40c:2c40:8c with SMTP id c22-20020a7bc856000000b0040c2c40008cmr199697wml.154.1706176949500;
        Thu, 25 Jan 2024 02:02:29 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:3efc:18bf:254:203f? ([2a05:6e02:1041:c10:3efc:18bf:254:203f])
        by smtp.googlemail.com with ESMTPSA id u15-20020a05600c19cf00b0040e39cbf2a4sm1981944wmq.42.2024.01.25.02.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 02:02:29 -0800 (PST)
Message-ID: <e65d4640-9bb0-4c34-8eab-865ce8dd59bf@linaro.org>
Date: Thu, 25 Jan 2024 11:02:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-2-5879275db36f@gmail.com>
 <245f5692-be30-4216-8b13-988092793732@linaro.org>
 <CABjd4Yz3RTeog0gvYaSK3A5H8NzQpYeqmjRWN1QDHjVPG9qTpA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CABjd4Yz3RTeog0gvYaSK3A5H8NzQpYeqmjRWN1QDHjVPG9qTpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/01/2024 09:26, Alexey Charkov wrote:
> On Thu, Jan 25, 2024 at 1:56 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 24/01/2024 21:30, Alexey Charkov wrote:
>>> Include thermal zones information in device tree for rk3588 variants
>>
>> There is an energy model for the CPUs. But finding out the sustainable
>> power may be a bit tricky. So I suggest to remove everything related to
>> the power allocator in this change and propose a dedicated change with
>> all the power configuration (which includes proper k_p* coefficients to
>> be set from userspace to have a flat mitigation figure).
>>
>> That implies removing the "contribution" properties in this description.
> 
> Alright, I'll just drop those "contribution" properties, thanks!
> 
>> Some comments below but definitively this version is close to be ok.
> 
> Yay! :)
> 
>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>>> ---
>>>    arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 165 ++++++++++++++++++++++++++++++
>>>    1 file changed, 165 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>>> index 36b1b7acfe6a..131b9eb21398 100644
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
>>> @@ -2228,6 +2229,170 @@ tsadc: tsadc@fec00000 {
>>>                status = "disabled";
>>>        };
>>>
>>> +     thermal_zones: thermal-zones {
>>> +             /* sensor near the center of the whole chip */
>>> +             package_thermal: package-thermal {
>>> +                     polling-delay-passive = <0>;
>>> +                     polling-delay = <0>;
>>> +                     thermal-sensors = <&tsadc 0>;
>>> +
>>> +                     trips {
>>> +                             package_crit: package-crit {
>>> +                                     temperature = <115000>;
>>> +                                     hysteresis = <0>;
>>> +                                     type = "critical";
>>> +                             };
>>> +                     };
>>> +             };
>>> +
>>> +             /* sensor between A76 cores 0 and 1 */
>>> +             bigcore0_thermal: bigcore0-thermal {
>>> +                     polling-delay-passive = <20>;
>>
>> 20ms seems very short, is this value on purpose? Or just picked up
>> arbitrarily?
> 
> Frankly, I simply used the value that Radxa's downstream DTS sets for
> my board. 100ms seem to work just as well.
> 
>> If it is possible, perhaps you should profile the temperature of these
>> thermal zones (CPUs ones). There is a tool in
>> <linuxdir>/tools/thermal/thermometer to do that.
>>
>> You can measure with 10ms sampling rate when running for instance
>> dhrystone pinned on b0 and b1, then on b2 and b3. And finally on the
>> small cluster.
> 
> It seems tricky to isolate the effects from just one of the CPU
> clusters, as their individual thermal outputs are not that high.
> 
> For my testing I disabled the fan (but didn't remove the heatsink to
> avoid wasting the thermal interface tape),

It is ok but the system will have more heat capacity and it will be 
necessary to saturate it before running the tests. IOW warm up the 
system by running thermal stress tests several times.

> and tried loading CPUs with
> stress-ng. Here are the observations:

Usually I use drhystone to thermal stress the cores (e. one minute).

>   - Little cores alone stressed with 4 threads pegged to them with
> taskset never reach the throttling temperature (85C), and balance out
> around 60C
>   - Either of the big core clusters stressed individually with 2
> threads pegged to them with taskset never reach the throttling
> temperature either

Not sure what does stress-ng but you may want to test with dhrystone. 
I'm pretty sure it will make the expected thermal stress.

On the rk3388, the temperature on the big cores raises to the threshold 
in a few seconds (after a warmup).

>   - Four big cores with 4 threads heat up very slowly (>30 minutes to
> reach throttling temperature, I didn't have enough patience to let
> them actually reach it - maybe they never do)
>   - Eight cores with 8 threads heat up to the throttling temperature
> within ~5 minutes (again, with the fan off), and then, as soon as just
> one of the big core clusters gets throttled, the temperature of all
> cores balances out just below the throttling threshold. In my
> observation cores 6,7 go from 2.4GHz down to 1.8GHz while the rest
> stay at their respective top performance states (2.4GHz for big cores
> 4,5 and 1.8GHz for little cores 0-3)

Yeah, definitively it is probable stress-ng is not the right tool for 
that. I gave a try and it does not thermal stress my rk3388 board.

Just try "dhrystone -t 2 -l 10000" pinned on a big cluster


> Adding to it the fact that the temperature measurement resolution is
> not very granular (almost 1C) it's somewhat difficult to estimate how
> fast throttling action on a single cluster really brings its
> temperature within bounds, as they all affect each other at relevant
> temperature-load combinations. Perhaps it means that too granular
> polling doesn't add much value.
> 
>> But if you don't have spare time and 20 is ok for you. Then it is fine
>> for me too.
> 
> I guess I'll go for 100 as other upstream Rockchip .dtsi's do, given
> all of the above. Thanks for pointing this out!
> 
>> Some nits below.
>>
>>> +                     polling-delay = <0>;
>>> +                     thermal-sensors = <&tsadc 1>;
>>> +
>>> +                     trips {
>>> +                             bigcore0_alert0: bigcore0-alert0 {
>>> +                                     temperature = <75000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>> +                             bigcore0_alert1: bigcore0-alert1 {
>>> +                                     temperature = <85000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>> +                             bigcore0_crit: bigcore0-crit {
>>> +                                     temperature = <115000>;
>>> +                                     hysteresis = <0>;
>>> +                                     type = "critical";
>>> +                             };
>>> +                     };
>>> +                     cooling-maps {
>>> +                             map0 {
>>> +                                     trip = <&bigcore0_alert1>;
>>> +                                     cooling-device =
>>> +                                             <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +                                             <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +                                     contribution = <1024>;
>>> +                             };
>>> +                     };
>>> +             };
>>> +
>>> +             /* sensor between A76 cores 2 and 3 */
>>> +             bigcore2_thermal: bigcore2-thermal {
>>> +                     polling-delay-passive = <20>;
>>> +                     polling-delay = <0>;
>>> +                     thermal-sensors = <&tsadc 2>;
>>> +
>>> +                     trips {
>>> +                             bigcore2_alert0: bigcore2-alert0 {
>>> +                                     temperature = <75000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>> +                             bigcore2_alert1: bigcore2-alert1 {
>>> +                                     temperature = <85000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>> +                             bigcore2_crit: bigcore2-crit {
>>> +                                     temperature = <115000>;
>>> +                                     hysteresis = <0>;
>>> +                                     type = "critical";
>>> +                             };
>>> +                     };
>>> +                     cooling-maps {
>>> +                             map1 {
>>
>> s/map1/mpa0/
> 
> Noted, thanks!
> 
>>> +                                     trip = <&bigcore2_alert1>;
>>> +                                     cooling-device =
>>> +                                             <&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +                                             <&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +                                     contribution = <1024>;
>>> +                             };
>>> +                     };
>>> +             };
>>> +
>>> +             /* sensor between the four A55 cores */
>>> +             little_core_thermal: littlecore-thermal {
>>> +                     polling-delay-passive = <20>;
>>> +                     polling-delay = <0>;
>>> +                     thermal-sensors = <&tsadc 3>;
>>> +
>>> +                     trips {
>>> +                             littlecore_alert0: littlecore-alert0 {
>>> +                                     temperature = <75000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>> +                             littlecore_alert1: littlecore-alert1 {
>>> +                                     temperature = <85000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>> +                             littlecore_crit: littlecore-crit {
>>> +                                     temperature = <115000>;
>>> +                                     hysteresis = <0>;
>>> +                                     type = "critical";
>>> +                             };
>>> +                     };
>>> +                     cooling-maps {
>>> +                             map2 {
>>
>> s/map2/map0/
> 
> Noted, thanks!
> 
> Best regards,
> Alexey

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


