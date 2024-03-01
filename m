Return-Path: <linux-kernel+bounces-87943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ECD86DB4F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441D6B23434
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5A524B1;
	Fri,  1 Mar 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rjBYQB6Y"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0443FE23;
	Fri,  1 Mar 2024 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709272630; cv=none; b=sVCPrzpHiRkOx4It5jq49/dcctqnATFTrt7QxTkOqdaMDAfxukDjM6+M0ovS4pVQzl7P+4QFwsk8DBHupElorY1wtyKbfFTWpwdxr+4ES1eJgkVO8dWux66F8A23x6ZS4KLLBvAy2GOdCz15WAzQo6mdq/9VI1u/lBVkTXNaq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709272630; c=relaxed/simple;
	bh=l47iUyg9wCatqJdlC0jQVUoG+cN+9n5/X5KDjdpi2K4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bP/FTut1+2qwKi5qzIHy9LbgFpE4NL2q0wWcMi8F4ifx1LFas5wT93HR+cQUwROyF3IuUFdb8zU3TpkKJSMTO/E72ajpoU+4FzQYOXgmfM7qNdQWhJ1p/OVHBde5HHTQK/RvraEIuctbBQtcWkzo0OBIqWXbcS8iumMEoYp9leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rjBYQB6Y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709272317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=al53Q+SSTc4fMPWhY6/Zakwoz5CeeSEasXtkvUeqKwE=;
	b=rjBYQB6Yswp00bh0tEX2/NKQwx72+O8acqDNm6wVn4nVvw8OQ3N6ifS5oDA2OnPW/Vus+o
	N44zwFtaGDLfC1b2NHrDZLSHHa9TGqYMB+/GCvADuM5IQyf3EHzb87tk4Q8gXVQrX6C590
	ay8bh0ovPSiGcZ/Vx9wpSR4xC9T/ZmXi5773Q/Ktas9+w0Nl9qtbtm84H4o5s2JSabXr2H
	IFdskBotxI4Z+axnCQgoA6/Nsn9Sev9lZzeN/kvW6x6s4/wGClYO4r+gJj3w5V6VBYacpr
	l2Kx7AHpmMQsMr2BdzgElnc1f4rb6SJ5Hi2GJRIy/njh9439qq/Zk0nX2et7KQ==
Date: Fri, 01 Mar 2024 06:51:56 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
In-Reply-To: <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
 <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
 <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com>
Message-ID: <ad00189e1a25ca90128be6c8b3841b77@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-01 06:12, Alexey Charkov wrote:
> On Fri, Mar 1, 2024 at 12:21 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-02-29 20:26, Alexey Charkov wrote:
>> > Include thermal zones information in device tree for RK3588 variants.
>> >
>> > This also enables the TSADC controller unconditionally on all boards
>> > to ensure that thermal protections are in place via throttling and
>> > emergency reset, once OPPs are added to enable CPU DVFS.
>> >
>> > The default settings (using CRU as the emergency reset mechanism)
>> > should work on all boards regardless of their wiring, as CRU resets
>> > do not depend on any external components. Boards that have the TSHUT
>> > signal wired to the reset line of the PMIC may opt to switch to GPIO
>> > tshut mode instead (rockchip,hw-tshut-mode = <1>;)
>> 
>> Quite frankly, I'm still not sure that enabling this on the SoC level
>> is the way to go.  As I already described in detail, [4] according to
>> the RK3588 Hardware Design Guide v1.0 and the Rock 5B schematic, we
>> should actually use GPIO-based handling for the thermal runaways on
>> the Rock 5B.  Other boards should also be investigated individually,
>> and the TSADC should be enabled on a board-to-board basis.
> 
> With all due respect, I disagree, here is why:
>  - Neither the schematic nor the hardware design guide, on which the
> schematic seems to be based, prescribes a particular way to handle
> thermal runaways. They only provide the possibility of GPIO based
> resets, along with the CRU based one

Please note that other documents from Rockchip also exist.  Below is
a link to a screenshot from the Thermal developer guide, version 1.0,
which describes the whole thing further.  I believe it's obvious that
the thermal runaway is to be treated as a board-level feature.

- https://i.imgur.com/IJ6dSAc.png

To be fair, that version of the Thermal developer guide dates back to
2019, meaning that it technically applies to the RK3399, for example,
but the TSADC and reset circuitry design has basically remained the
same for the RK3588.

>  - My strong belief is that defaults (regardless of context) should be
> safe and reasonable, and should also minimize the need to override
> them

Please note that the TSADC is disabled in the RK3399 SoC dtsi, so having
it disabled in the RK3588(s) SoC dtsi would provide some consistency.
Though, the RK3399 still does it in a safe way, by moving the OPPs into
a separate dtsi file, named rk3399-opp.dtsi, which the board dts files
then include together with enabling the TSADC.

If you agree, let's employ the same approach for the RK3588(s), by 
having
the its OPPs defined in a separate file, named rk3588s-opp.dtsi, etc.

>  - In context of dts/dtsi, as far as I understand the general logic
> behind the split, the SoC .dtsi should contain all the things that are
> fully contained within the SoC and do not depend on the wiring of a
> particular board or its target use case. Boards then
> add/remove/override settings to match their wiring and use case more
> closely

Of course, but the thermal shutdown is obviously a board-level feature,
which I described further above.

> In the light of the last two points, I believe that enabling TSADC by
> default is the more safe and reasonable choice, because it provides
> crucial thermal protection logic for the SoC, and it can do so in a
> board-agnostic way (if the CRU based reset is selected, which is the
> current default).
> 
> Furthermore, TSADC and CRU are fully contained within the SoC, and I
> cannot think of a use case where a board might be somehow
> disadvantaged by TSADC being enabled, and thus need to disable it
> altogether (maybe I'm missing something). The only thing that the
> board might be adjusting is the thermal reset handling, and even then
> it's rather a matter of choice/preference to switch away from CRU to
> GPIO resets where the wiring permits it, rather than an existential
> need. I presume that a PMIC-assisted reset causes deeper power cycling
> of the SoC and might therefore help in some rare cases where the CRU
> reset alone is not enough, but that would be niche.
> 
> All summed up, I believe that the default of "fry my board if I have
> no heatsink and forget to include &tsadc {status = <okay>;}; in my
> .dts" is substantially inferior to the default of "my board could do a
> deep power-cycle in this weird corner-case thermal-runaway situation
> that somehow didn't get handled by active cooling, then by passive
> cooling, then by a CRU reset, but I didn't include
> rockchip,hw-tshut-mode = <1>; so poor luck for me".

Please see my comments above, regarding the separate dtsi for the OPPs.
I think it's a win-win, and I hope you'll agree.

>> [4]
>> https://lore.kernel.org/linux-rockchip/4e7c2b5a938bd7c919b852699c951701@manjaro.org/
>> 
>> > It seems though that downstream kernels don't use that, even for
>> > those boards where the wiring allows for GPIO based tshut, such as
>> > Radxa Rock 5B [1], [2], [3]
>> >
>> > [1]
>> > https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts#L540
>> > [2]
>> > https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#L5433
>> > [3] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock_5b_v1423_sch.pdf
>> > page 11 (TSADC_SHUT_H)
>> >
>> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> > ---
>> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 176
>> > +++++++++++++++++++++++++++++-
>> >  1 file changed, 175 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > index 36b1b7acfe6a..9bf197358642 100644
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
>> > @@ -2225,7 +2226,180 @@ tsadc: tsadc@fec00000 {
>> >               pinctrl-1 = <&tsadc_shut>;
>> >               pinctrl-names = "gpio", "otpout";
>> >               #thermal-sensor-cells = <1>;
>> > -             status = "disabled";
>> > +             status = "okay";
>> > +     };
>> > +
>> > +     thermal_zones: thermal-zones {
>> > +             /* sensor near the center of the SoC */
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
>> > +                             /* threshold to start collecting temperature
>> > +                              * statistics e.g. with the IPA governor
>> > +                              */
>> > +                             bigcore0_alert0: bigcore0-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             /* actual control temperature */
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
>> > +                             /* threshold to start collecting temperature
>> > +                              * statistics e.g. with the IPA governor
>> > +                              */
>> > +                             bigcore2_alert0: bigcore2-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             /* actual control temperature */
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
>> > +                             /* threshold to start collecting temperature
>> > +                              * statistics e.g. with the IPA governor
>> > +                              */
>> > +                             littlecore_alert0: littlecore-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             /* actual control temperature */
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
>> >       };
>> >
>> >       saradc: adc@fec10000 {
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

