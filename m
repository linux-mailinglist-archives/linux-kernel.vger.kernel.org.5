Return-Path: <linux-kernel+bounces-39349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D2B83CF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A351F26E05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C72B13B787;
	Thu, 25 Jan 2024 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eyt0jOaE"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F4130E3C;
	Thu, 25 Jan 2024 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221184; cv=none; b=PvMdxzm5WUS2VJPAldA/l/xC8wDr8gZhJefY6i1G6/ZHD+wbvSW0BcepcPDdC4XJG11ITBVdWAcAXQe7nXKM6VS1GhOVXHm+xtIrdqab3MYmHVQW9In7Jo24O9prhqOcpPmvQ/yPkb/rmzwN8K6XYs3kvtu7RXMaPcRJJD7mzMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221184; c=relaxed/simple;
	bh=d38WnNQvNhLYVOelkDEd5MQzIBOLr526Ysbk5Qc+buQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ieblc2XBwQKWthLecbQ1+u42fSC6vsjaOc5Xwb1nQgdUfVS0gkQq5HZ4x0TMhXf0K2Lf7unMW5QTohBtVi+ttR2MPvZZssyi06ze//KZW//hYxiNYFNaMS2Fr7jtrk266WLjt7ARndG+etSVNI3EyB2T+zgrKYhTTaImcssWESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=eyt0jOaE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706221177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzRBY22pMxg+4h3uegQXsyfdNf8+dTMvBpIgXoWqSig=;
	b=eyt0jOaEsijExn+j088mTxQDy9lXfFJjPxpYQdEj9EbDxTGKHRwvUcuQF1id8O6cwASHXz
	GfOj6eUOQ9wnlcooyjzUpzIEQIVlsGaYMIQdBgJyqGoW/rMa8lrVKAkNCsK91AxCbm2+3r
	+PBCwz67BWEZ6Mwd+lRmfhPGzfOsxZ6p/PI9pkfHBKlMLQ80ThSsywTPmimowLHX0PfRsh
	O7AP5je7EUg3U64kk99NEoZtPYR5ObXlvQgROCNJCFtvgVDx9r4wy7pH32v12/fNCK7qMt
	m9f1stk72WwOMvRBz/BimKw1B4Dt388YHj5c9Btq7Fo++nhQZ5PFcasE0MssnA==
Date: Thu, 25 Jan 2024 23:19:35 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
In-Reply-To: <CABjd4Yz3RTeog0gvYaSK3A5H8NzQpYeqmjRWN1QDHjVPG9qTpA@mail.gmail.com>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-2-5879275db36f@gmail.com>
 <245f5692-be30-4216-8b13-988092793732@linaro.org>
 <CABjd4Yz3RTeog0gvYaSK3A5H8NzQpYeqmjRWN1QDHjVPG9qTpA@mail.gmail.com>
Message-ID: <55aa69e8b9fb0868091e4b2651a99beb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-25 09:26, Alexey Charkov wrote:
> On Thu, Jan 25, 2024 at 1:56 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> 
>> On 24/01/2024 21:30, Alexey Charkov wrote:
>> > Include thermal zones information in device tree for rk3588 variants
>> 
>> There is an energy model for the CPUs. But finding out the sustainable
>> power may be a bit tricky. So I suggest to remove everything related 
>> to
>> the power allocator in this change and propose a dedicated change with
>> all the power configuration (which includes proper k_p* coefficients 
>> to
>> be set from userspace to have a flat mitigation figure).
>> 
>> That implies removing the "contribution" properties in this 
>> description.
> 
> Alright, I'll just drop those "contribution" properties, thanks!
> 
>> Some comments below but definitively this version is close to be ok.
> 
> Yay! :)
> 
>> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> > ---
>> >   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 165 ++++++++++++++++++++++++++++++
>> >   1 file changed, 165 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > index 36b1b7acfe6a..131b9eb21398 100644
>> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > @@ -10,6 +10,7 @@
>> >   #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>> >   #include <dt-bindings/phy/phy.h>
>> >   #include <dt-bindings/ata/ahci.h>
>> > +#include <dt-bindings/thermal/thermal.h>
>> >
>> >   / {
>> >       compatible = "rockchip,rk3588";
>> > @@ -2228,6 +2229,170 @@ tsadc: tsadc@fec00000 {
>> >               status = "disabled";
>> >       };
>> >
>> > +     thermal_zones: thermal-zones {
>> > +             /* sensor near the center of the whole chip */
>> > +             package_thermal: package-thermal {
>> > +                     polling-delay-passive = <0>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 0>;
>> > +
>> > +                     trips {
>> > +                             package_crit: package-crit {
>> > +                                     temperature = <115000>;
>> > +                                     hysteresis = <0>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +             /* sensor between A76 cores 0 and 1 */
>> > +             bigcore0_thermal: bigcore0-thermal {
>> > +                     polling-delay-passive = <20>;
>> 
>> 20ms seems very short, is this value on purpose? Or just picked up
>> arbitrarily?
> 
> Frankly, I simply used the value that Radxa's downstream DTS sets for
> my board. 100ms seem to work just as well.

I think that 100 ms should be just fine (and should lower the resulting
CPU usage a bit), especially because the resolution of the TSADCs is
quite low at 1 oC, according to the RK3588 TRM.  If the resolution were
higher, sampling the temperatures more often might make more sense.

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
> avoid wasting the thermal interface tape), and tried loading CPUs with
> stress-ng. Here are the observations:
>  - Little cores alone stressed with 4 threads pegged to them with
> taskset never reach the throttling temperature (85C), and balance out
> around 60C
>  - Either of the big core clusters stressed individually with 2
> threads pegged to them with taskset never reach the throttling
> temperature either
>  - Four big cores with 4 threads heat up very slowly (>30 minutes to
> reach throttling temperature, I didn't have enough patience to let
> them actually reach it - maybe they never do)
>  - Eight cores with 8 threads heat up to the throttling temperature
> within ~5 minutes (again, with the fan off), and then, as soon as just
> one of the big core clusters gets throttled, the temperature of all
> cores balances out just below the throttling threshold. In my
> observation cores 6,7 go from 2.4GHz down to 1.8GHz while the rest
> stay at their respective top performance states (2.4GHz for big cores
> 4,5 and 1.8GHz for little cores 0-3)
> 
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
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 1>;
>> > +
>> > +                     trips {
>> > +                             bigcore0_alert0: bigcore0-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             bigcore0_alert1: bigcore0-alert1 {
>> > +                                     temperature = <85000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             bigcore0_crit: bigcore0-crit {
>> > +                                     temperature = <115000>;
>> > +                                     hysteresis = <0>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +                     cooling-maps {
>> > +                             map0 {
>> > +                                     trip = <&bigcore0_alert1>;
>> > +                                     cooling-device =
>> > +                                             <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> > +                                             <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> > +                                     contribution = <1024>;
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +             /* sensor between A76 cores 2 and 3 */
>> > +             bigcore2_thermal: bigcore2-thermal {
>> > +                     polling-delay-passive = <20>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 2>;
>> > +
>> > +                     trips {
>> > +                             bigcore2_alert0: bigcore2-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             bigcore2_alert1: bigcore2-alert1 {
>> > +                                     temperature = <85000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             bigcore2_crit: bigcore2-crit {
>> > +                                     temperature = <115000>;
>> > +                                     hysteresis = <0>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +                     cooling-maps {
>> > +                             map1 {
>> 
>> s/map1/mpa0/
> 
> Noted, thanks!
> 
>> > +                                     trip = <&bigcore2_alert1>;
>> > +                                     cooling-device =
>> > +                                             <&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> > +                                             <&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> > +                                     contribution = <1024>;
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +             /* sensor between the four A55 cores */
>> > +             little_core_thermal: littlecore-thermal {
>> > +                     polling-delay-passive = <20>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 3>;
>> > +
>> > +                     trips {
>> > +                             littlecore_alert0: littlecore-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             littlecore_alert1: littlecore-alert1 {
>> > +                                     temperature = <85000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             littlecore_crit: littlecore-crit {
>> > +                                     temperature = <115000>;
>> > +                                     hysteresis = <0>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +                     cooling-maps {
>> > +                             map2 {
>> 
>> s/map2/map0/
> 
> Noted, thanks!

