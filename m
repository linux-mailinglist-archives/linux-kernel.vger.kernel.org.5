Return-Path: <linux-kernel+bounces-46180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4FB843BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B541F220D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27686996E;
	Wed, 31 Jan 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="LMwVQErL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D569D00;
	Wed, 31 Jan 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695739; cv=none; b=B0LSnyEULZNEftQQyLAMS4pFJEjRHJ/v22QSntJ+soEitiU6KbXXlCLtJoOVx0Gien16/WQaroZjQa8gYabyyQ/GHRETGSYEkHuUP0+G/5SY6Ovpx5rrMnTGQn9eN8K6NJO6jktqqzYtvB4ZZI4maD4M5ZToaOYtx1RAX+nHgXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695739; c=relaxed/simple;
	bh=VGccL/d9Jh3SX3ofkFgHSICtp5humDPOSw2NmoTxOZ0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sFMkDKB6WGXwwubq4hgcWxzyHuM2ZWl+4IABTE3H6enH28CU2K3GDzF9kHQrpE7DXh5+UGeZ0hKGjVGaAGyYcjoko0OUHU5Hg7LcPHEKlM0xiDAVci45x0fWr7G51Ww3VOHovG/KHM0xM+/BiDG1TptglZIqCisYP8Ua2YNVuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=LMwVQErL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706695733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JCmGi/vABcqFbAYIX4DWFvcJjSKxoxQP5nERWYlDuk=;
	b=LMwVQErLZnUMAfgvZ7dCsBTivEFe6gy4V+Xi+6cEKyXmHDGO2jBQnR6ud7cQIq4fZEfgfv
	Q/thtdW5cVTaNfJAPA5/hUUbQMVkzxvRpQeedcHE/Uwe4vJaZUe7AX37JOTRYhdVKSX/eK
	XfX1N3yWG+XEm7rZW6Jyw2xt/FwG+kWWHlUkD6iRmqlokNQ3xTHyEmdibwawUMhLb75TkP
	ds3h/Mo16J00q2gmqQwNp7A97Ex78CPS1wNo8rnsIBQy2DocFBsYH7IGE0CeFF1m4Q3aBy
	wHR+F431p+UBfFxkX44ffCGT1V5KUHhJXNdsHuBehCNNozk9E5GX38d8F1tzWQ==
Date: Wed, 31 Jan 2024 11:08:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
In-Reply-To: <CABjd4Ywx4-3BN7tF=Lv6LNTry_+j=jjM_v7SdzLaWHbuePip3g@mail.gmail.com>
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-1-c6222c4c78df@gmail.com>
 <0702542c8d7dc4139ba5da690fd98e67@manjaro.org>
 <CABjd4Ywx4-3BN7tF=Lv6LNTry_+j=jjM_v7SdzLaWHbuePip3g@mail.gmail.com>
Message-ID: <00cb830bbf9a03787e53de0b05cb076c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-31 10:56, Alexey Charkov wrote:
> On Wed, Jan 31, 2024 at 9:05 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Some small nitpicks below, please have a look.
>> 
>> On 2024-01-30 19:21, Alexey Charkov wrote:
>> > Include thermal zones information in device tree for rk3588 variants
>> 
>> Please use "RK3588" instead of "rk3588", both here and in the
>> patch subject.  Looks much better.
> 
> Noted, thanks!
> 
>> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> > ---
>> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 162
>> > ++++++++++++++++++++++++++++++
>> >  1 file changed, 162 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > index 36b1b7acfe6a..696cb72d75d0 100644
>> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > @@ -10,6 +10,7 @@
>> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>> >  #include <dt-bindings/phy/phy.h>
>> >  #include <dt-bindings/ata/ahci.h>
>> > +#include <dt-bindings/thermal/thermal.h>
>> >
>> >  / {
>> >       compatible = "rockchip,rk3588";
>> > @@ -2228,6 +2229,167 @@ tsadc: tsadc@fec00000 {
>> >               status = "disabled";
>> >       };
>> >
>> > +     thermal_zones: thermal-zones {
>> > +             /* sensor near the center of the whole chip */
>> 
>> It would be good to replace "whole chip" with "SoC".  Simpler and
>> IIRC closer to the official description of the sensor.
> 
> The TRM only says "near chip center" (sic) :)

In that case, it would be good to just replace "whole" with
"entire" in the original wording. :)

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
>> > +                     polling-delay-passive = <100>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 1>;
>> > +
>> > +                     trips {
>> 
>> Please add the following comment here, to make it clear what's
>> the purpose of this thermal trip when the IPA thermal governor
>> is used (more similar comments below):
>> 
>>                                  /* IPA threshold */
> 
> Not so sure about this one: shouldn't the device tree be
> implementation agnostic, and just describe the hardware and its
> expectations? Sounds like references to a particular thermal governor
> would be out of scope.

I'd agree on that, but having two passive thermal trips is already
kinda out of place, because only one is actually needed, so we should
describe the reason why there are multiples of pairs.

I have some plans for getting this resolved in a way that's much
more governor-agnostic, but it will take some time.  In the meantime,
having the comments can only help anyone reading the dtsi file to
understand the need for additional thermal trips.

I hope you agree.

>> > +                             bigcore0_alert0: bigcore0-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> 
>> Please add the following comment here:
>> 
>>                                  /* IPA target */
>> 
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
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +             /* sensor between A76 cores 2 and 3 */
>> > +             bigcore2_thermal: bigcore2-thermal {
>> > +                     polling-delay-passive = <100>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 2>;
>> > +
>> > +                     trips {
>> 
>> Please add the following comment here:
>> 
>>                                  /* IPA threshold */
>> 
>> > +                             bigcore2_alert0: bigcore2-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> 
>> Please add the following comment here:
>> 
>>                                  /* IPA target */
>> 
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
>> > +                             map0 {
>> > +                                     trip = <&bigcore2_alert1>;
>> > +                                     cooling-device =
>> > +                                             <&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> > +                                             <&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +             /* sensor between the four A55 cores */
>> > +             little_core_thermal: littlecore-thermal {
>> > +                     polling-delay-passive = <100>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 3>;
>> > +
>> > +                     trips {
>> 
>> Please add the following comment here:
>> 
>>                                  /* IPA threshold */
>> 
>> > +                             littlecore_alert0: littlecore-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> 
>> Please add the following comment here:
>> 
>>                                  /* IPA target */
>> 
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
>> > +                             map0 {
>> > +                                     trip = <&littlecore_alert1>;
>> > +                                     cooling-device =
>> > +                                             <&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> > +                                             <&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> > +                                             <&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> > +                                             <&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +             /* sensor near the PD_CENTER power domain */
>> > +             center_thermal: center-thermal {
>> > +                     polling-delay-passive = <0>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 4>;
>> > +
>> > +                     trips {
>> > +                             center_crit: center-crit {
>> > +                                     temperature = <115000>;
>> > +                                     hysteresis = <0>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +             gpu_thermal: gpu-thermal {
>> > +                     polling-delay-passive = <0>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 5>;
>> > +
>> > +                     trips {
>> > +                             gpu_crit: gpu-crit {
>> > +                                     temperature = <115000>;
>> > +                                     hysteresis = <0>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +             npu_thermal: npu-thermal {
>> > +                     polling-delay-passive = <0>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 6>;
>> > +
>> > +                     trips {
>> > +                             npu_crit: npu-crit {
>> > +                                     temperature = <115000>;
>> > +                                     hysteresis = <0>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +             };
>> > +     };
>> > +
>> >       saradc: adc@fec10000 {
>> >               compatible = "rockchip,rk3588-saradc";
>> >               reg = <0x0 0xfec10000 0x0 0x10000>;

