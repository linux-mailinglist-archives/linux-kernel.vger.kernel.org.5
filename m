Return-Path: <linux-kernel+bounces-41391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB783EFF8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613CC1F22D10
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27D92E657;
	Sat, 27 Jan 2024 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oJDeP+0V"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF12C19C;
	Sat, 27 Jan 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706387250; cv=none; b=nxL2jEtx2CaLYJQDhtURvWI5Abutcgjtt1YuojMnexS3EmkfF6SONXuS+JkNvAH+rqOnIrpi+N14ar7meqPMH6JssRLckpflQganMvT9lgUcbDCxGozadmQvzTfgXXiLjz9ctZ49Q5037fgBby/nzAoa+XjDweVh+i189UK/Zzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706387250; c=relaxed/simple;
	bh=V8mSSm3//X6n2PCn+rVSWmInHVXe52iY5cZ+sxkRsJw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=C787/ukrOONZO7bLhKY2KI3yU7URguuyjvwDGnkhaCwZsxMA+GCQkOaq2ItUks4kbJ1L1o1NA3bZEk2Yoz8kaMJDvRnn40xxDYC39fo93OerHuOoEuMjC1C/ALPIkD19/YzTb6N2urd5fmrnZxV4V+R9w8SF6ISaTkEajbW5CHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oJDeP+0V; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706387245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PJkgdYtRWh3Hfjewf0AGZ17Ug0EyMY0uQp/L8hg8yw=;
	b=oJDeP+0VIRu2SqO9xRdnQLFQh0JsKxCaNBrSkuKEMvgzCsuNQNmUuOMopqU6500Aq83DG0
	z1mOi+yEw3zKZYEU7SLj/hBMpmopscEZ4N3xtKNr38uBl1k5QEhjJnuKfjV0pV2vgv2ytv
	5gdluaqnZ0ULtKEWgrVGxrRsCgIGbPoTx5g1iIQNa+sYfhc+vlv3BVHIOyr0s1da8SSugG
	ZUdTpxJLqFQaY6HXlT/Z2z1Tdkw6blhIK4HDiyPfNcqgt6hnS1ft0WvPEHiAI7IIfedlpE
	X2LZcWv5oO6peYyAE9xF16YKkC6Y0fLsSs3V/5BcmF4TVkwBb0wDXK18Zhy7Lw==
Date: Sat, 27 Jan 2024 21:27:24 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: enable temperature driven fan
 control on Rock 5B
In-Reply-To: <df062818d21f3318c033859d0e95efc7@manjaro.org>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-3-5879275db36f@gmail.com>
 <df062818d21f3318c033859d0e95efc7@manjaro.org>
Message-ID: <b5b1900a6e309890f449ec91594b8d6c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-01-26 00:13, Dragan Simic wrote:
> On 2024-01-24 21:30, Alexey Charkov wrote:
>> This enables thermal monitoring on Radxa Rock 5B and links the PWM
>> fan as an active cooling device managed automatically by the thermal
>> subsystem, with a target SoC temperature of 55C
>> 
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 25 
>> ++++++++++++++++++++++++-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> index 9b7bf6cec8bd..c4c94e0b6163 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> @@ -52,7 +52,7 @@ led_rgb_b {
>> 
>>  	fan: pwm-fan {
>>  		compatible = "pwm-fan";
>> -		cooling-levels = <0 95 145 195 255>;
>> +		cooling-levels = <0 120 150 180 210 240 255>;
>>  		fan-supply = <&vcc5v0_sys>;
>>  		pwms = <&pwm1 0 50000 0>;
>>  		#cooling-cells = <2>;
>> @@ -180,6 +180,25 @@ &cpu_l3 {
>>  	cpu-supply = <&vdd_cpu_lit_s0>;
>>  };
>> 
>> +&package_thermal {
>> +	polling-delay = <1000>;
>> +
>> +	trips {
>> +		package_fan: package-fan {
>> +			temperature = <55000>;
>> +			hysteresis = <2000>;
>> +			type = "active";
>> +		};
>> +	};
>> +
>> +	cooling-maps {
>> +		map-fan {
>> +			trip = <&package_fan>;
>> +			cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +		};
>> +	};
>> +};
> 
> It should be better to have two new trips and two new cooling maps
> defined, instead of having just one trip/map pair, like this:
> 
> &package_thermal {
> 	polling-delay = <1000>;
> 
> 	trips {
> 		package_warm: package-warm {
> 			temperature = <55000>;
> 			hysteresis = <2000>;
> 			type = "active";
> 		};
> 
> 		package_hot: package-hot {
> 			temperature = <65000>;
> 			hysteresis = <2000>;
> 			type = "active";
> 		};
> 	};
> 
> 	cooling-maps {
> 		mapX {
> 			trip = <&package_warm>;
> 			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> 		};
> 
> 		mapY {
> 			trip = <&package_hot>;
> 			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> 		};
> 	};
> };
> 
> The idea behind this approach is to keep the fan spinning at the lowest
> available speed until the package temperature reaches the second trip's
> temperature level, at which point the fan starts ramping up.  An 
> approach
> like this is already employed by the Pine64 RockPro64 SBC.
> 
> This way, we'll be doing our best to keep the fan noise down;  of 
> course,
> it will depend on the particular heatsink and fan combo how long the 
> fan
> can be kept at the lowest speed, but we should aim at supporting as 
> many
> different cooling setups as possible, and as well as possible, out of 
> the
> box and with no additional tweaking required.
> 
> Please notice "mapX" and "mapY" as the names of the additional cooling 
> maps,
> where X and Y are simply the next lowest available indices, which is 
> pretty
> much the usual way to name the additional cooling maps.

Just checking, have you seen this?  Quite a few messages were exchanged
on the same day, so just wanted to make sure you didn't miss this one.

>>  &i2c0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&i2c0m2_xfer>;
>> @@ -738,6 +757,10 @@ regulator-state-mem {
>>  	};
>>  };
>> 
>> +&tsadc {
>> +	status = "okay";
>> +};
>> +
>>  &uart2 {
>>  	pinctrl-0 = <&uart2m0_xfer>;
>>  	status = "okay";

