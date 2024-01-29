Return-Path: <linux-kernel+bounces-42032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF4483FB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 289F4B22277
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59578BF1;
	Mon, 29 Jan 2024 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RK2cwpIL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968CA5664;
	Mon, 29 Jan 2024 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706489220; cv=none; b=RL/CchCw0TakZdYreFD+rqIgqng9DSLqOOor9QIwAqFq8GYcKV9TbfowRTUyUplM50QZsCk+s2N2oyKHXrfe7L05TgvJqBm+rf8fGNUDrg5Q/POEOew907gJNcMHDJF29wpNqrsoLoSJNT4gCXBd1YAHK0dtYHVAQaBPv+Hc4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706489220; c=relaxed/simple;
	bh=tpybrTrmtAFnc0DQtXFoyBZT4xdv5dsEXBErqx4Obq4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PFKSoXBlXYuVbDfvove0fxbqsXj3eXM7qb1tGGa+EQfdNp2HJ5Ru1FKxOQ9lA3atc8OoFzh4ligkhGDIjz1toA9EV59zG3hiUDTeS+AwR2z2nrof7HoqwP6rbg7uNn1Xynykc61K27RZHpdCC8Z4938KQXG/ttO6dRAVHT1/M0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RK2cwpIL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706489215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GS+RVzeqWuOYqDG8OOVdlRlDHcgTfVGr4oMD5uktGSQ=;
	b=RK2cwpIL6QJhedwwn2vimofLkN640Q1yIRS8nV7mKqHnpPs4khbTtWfBQw9GOjFrqup7X2
	T60hPs+CFGUsYNmHLh4ZCGwOhnLYci0cXAO5bgp/ub7hyhfkQNmOi87vjk+chYvz6RDNgM
	OWUPC1SiKFxFz8c6OEqU+BlYixm5P5QC/lxgMesK/T8Rf7JzralM/UaRLpJs7yigGJdwcK
	OfUtT3VFWYGVk8vgoU1eFHGaz1w8gmC/v8432P27cuQ7R9G9bigc5N/88HddgCggZ+8oWi
	dQ91yIRtF58P1PnHShNpB2s97gQaI+3jR7uR5OEqQdaVmSFixFikV7paIlpF1Q==
Date: Mon, 29 Jan 2024 01:46:54 +0100
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
In-Reply-To: <CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-3-5879275db36f@gmail.com>
 <df062818d21f3318c033859d0e95efc7@manjaro.org>
 <b5b1900a6e309890f449ec91594b8d6c@manjaro.org>
 <CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com>
Message-ID: <30c3afc28da0a241a6397b30d2d7a922@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-01-28 21:08, Alexey Charkov wrote:
> On Sun, Jan 28, 2024 at 12:27 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-01-26 00:13, Dragan Simic wrote:
>> > On 2024-01-24 21:30, Alexey Charkov wrote:
>> >> This enables thermal monitoring on Radxa Rock 5B and links the PWM
>> >> fan as an active cooling device managed automatically by the thermal
>> >> subsystem, with a target SoC temperature of 55C
>> >>
>> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> >> ---
>> >>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 25
>> >> ++++++++++++++++++++++++-
>> >>  1 file changed, 24 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> index 9b7bf6cec8bd..c4c94e0b6163 100644
>> >> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> @@ -52,7 +52,7 @@ led_rgb_b {
>> >>
>> >>      fan: pwm-fan {
>> >>              compatible = "pwm-fan";
>> >> -            cooling-levels = <0 95 145 195 255>;
>> >> +            cooling-levels = <0 120 150 180 210 240 255>;
>> >>              fan-supply = <&vcc5v0_sys>;
>> >>              pwms = <&pwm1 0 50000 0>;
>> >>              #cooling-cells = <2>;
>> >> @@ -180,6 +180,25 @@ &cpu_l3 {
>> >>      cpu-supply = <&vdd_cpu_lit_s0>;
>> >>  };
>> >>
>> >> +&package_thermal {
>> >> +    polling-delay = <1000>;
>> >> +
>> >> +    trips {
>> >> +            package_fan: package-fan {
>> >> +                    temperature = <55000>;
>> >> +                    hysteresis = <2000>;
>> >> +                    type = "active";
>> >> +            };
>> >> +    };
>> >> +
>> >> +    cooling-maps {
>> >> +            map-fan {
>> >> +                    trip = <&package_fan>;
>> >> +                    cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> >> +            };
>> >> +    };
>> >> +};
>> >
>> > It should be better to have two new trips and two new cooling maps
>> > defined, instead of having just one trip/map pair, like this:
>> >
>> > &package_thermal {
>> >       polling-delay = <1000>;
>> >
>> >       trips {
>> >               package_warm: package-warm {
>> >                       temperature = <55000>;
>> >                       hysteresis = <2000>;
>> >                       type = "active";
>> >               };
>> >
>> >               package_hot: package-hot {
>> >                       temperature = <65000>;
>> >                       hysteresis = <2000>;
>> >                       type = "active";
>> >               };
>> >       };
>> >
>> >       cooling-maps {
>> >               mapX {
>> >                       trip = <&package_warm>;
>> >                       cooling-device = <&fan THERMAL_NO_LIMIT 1>;
>> >               };
>> >
>> >               mapY {
>> >                       trip = <&package_hot>;
>> >                       cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
>> >               };
>> >       };
>> > };
>> >
>> > The idea behind this approach is to keep the fan spinning at the lowest
>> > available speed until the package temperature reaches the second trip's
>> > temperature level, at which point the fan starts ramping up.  An
>> > approach
>> > like this is already employed by the Pine64 RockPro64 SBC.
>> >
>> > This way, we'll be doing our best to keep the fan noise down;  of
>> > course, it will depend on the particular heatsink and fan combo how
>> > long the fan can be kept at the lowest speed, but we should aim at
>> > supporting as many different cooling setups as possible, and as
>> > well as possible, out of the box and with no additional tweaking
>> > required.
>> >
>> > Please notice "mapX" and "mapY" as the names of the additional
>> > cooling maps, where X and Y are simply the next lowest available
>> > indices, which is pretty much the usual way to name the additional
>> > cooling maps.
>> 
>> Just checking, have you seen this?  Quite a few messages were 
>> exchanged
>> on the same day, so just wanted to make sure you didn't miss this one.
> 
> Yes, thank you for pointing it out and following up.
> 
> I've been testing different setups to get my thoughts together on this
> one. Long story short, your suggested setup indeed makes the system
> quieter most of the time while still being safely far from hitting the
> throttling threshold, though it appears that the main influence is
> from the higher temperature value in the second trip (after which the
> fan accelerates) rather than from the presence of the first trip and
> the corresponding cooling map capped at the minimum-speed fan action.

Thank you for testing all this!

I see, but having a higher temperature defined in the second active
thermal trip is exactly the trick that should make cooling setups
  more quiet.  More precisely, the intention is to define a dual-trip
configuration that should make as many different active cooling setups
as quiet as possible, simply because some active cooling setups (and
some CPU loads) may result in crossing the second trip's temperature
less frequently than with the other setups.

> In my observation, the system rarely crosses the 55C threshold under
> partial load, and when the load is high (e.g. compiling stuff with 8
> concurrent jobs) it takes ~2 seconds to go from below the first trip
> point to above the second trip point, so the fan doesn't really get
> the chance to stay at its leisurely first state.
> 
> So frankly I'm inclined to leave one trip point here, and simply
> change its temperature threshold from 55C to 65C - just to keep it
> simple.
> 
> What do you think?

I'd much rather have two active thermal trips defined, simply because
a beefier heatsink, with much larger fin surface, may completely change
the behavior of the Rock 5B's active cooling.  Radxa already sells a
much larger heatsink, linked below, to which a fan can rather easily be
attached, or a fan can be used to provide some airflow inside the case
into which the board is mounted.

- 
https://shop.allnetchina.cn/products/rock5-b-passive-heat-sink?variant=39895250239590

In other words, having two active thermal trips at 55 oC and 65 oC does
not hurt the acoustics and the thermal performance of the active
cooling setup you're using, compared with having just one active trip
at 65 oC, while the dual-trip configuration can help with other active
cooling setups that are different from yours.  It's a win-win.

I hope you agree.

