Return-Path: <linux-kernel+bounces-87947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112986DB5E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074AA287AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D515F569;
	Fri,  1 Mar 2024 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qySRO/TL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC255BACB;
	Fri,  1 Mar 2024 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273649; cv=none; b=VlRxf5wUQolRik/YRzR6d2pkYTgM8puRdd8o2pZgNMYNEnxM5Gqj2AAT+uQ+11GwH2HIIfJ4ippLdGvwKqZ/plZ6oluDbYZzWKCsOBi144tp5SuJ7UfH+CyypayAqfXtniqpMNr3fjZRKzNHtLhej70y6EE8Q+C9mHC19uSjtUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273649; c=relaxed/simple;
	bh=WvsBPf4vIF00cV7LlaJ0HwB/q/0+7IFTdr6I5bOohtk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aDokj5grc3hazQ0Td8CI1py2gNgFJNZ9Rxw+upvH3R5G7xPpbIuXXvZcNS5zZ03A6CKzI+De+HOs0Le6ZDq5LaHgD1sXqC0vh2uUXjn16oY5ewik3wHpmCBCFGLrUw/zAhp60/Xl5Mv4jCmw16Bhz2m2XhnEAam+xoiBjAo9f4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qySRO/TL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709273644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dloJ0xKHf4rdhrAuYKaaTGxcNPoWkhcX/MfjzCn9kC4=;
	b=qySRO/TLatfTbVa2HmZNjhyFJ1tpPhlkh4dZE282dzjHX5Zultzmb7tGgmYAG7//aJWD8T
	ZLT6mG6wpwZSgJhQ3D5gfXw3GPYYWniKKjaaegv94IavHsvLu2j6RNkgBiYxIAq9+1aeSj
	R8ZLvyEArvU8N4geOvMSn+R9QuGqnEBJnxweIsSlUPbYzQcjooHIjbEIP9nqfFnUClImTy
	2L1sJ0oSPUZoOuBOHfRx/eMC3TJ6y7qOxP9ERjpyKyy62AYvTXD0hy6JeFL5r8uR7AdhwC
	dNHzMmPrLc9qP5JmtaAcNovXuggbjtrFE6+9cXpiHQHvZ4hdhE2IVBeVnsQzzg==
Date: Fri, 01 Mar 2024 07:14:03 +0100
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
In-Reply-To: <CABjd4YzFuhfS9RhJ6svb9ZD0NqMT5B6GmqigHFLr8YG6FR5k=w@mail.gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
 <5eb9193a44fb9f9b1e976412874cecef@manjaro.org>
 <CABjd4YzFuhfS9RhJ6svb9ZD0NqMT5B6GmqigHFLr8YG6FR5k=w@mail.gmail.com>
Message-ID: <90d0cfd9b7d018e7332213f624f0f658@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-01 06:20, Alexey Charkov wrote:
> On Fri, Mar 1, 2024 at 1:11 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> Please see also some nitpicks below, which I forgot to mention in
>> my earlier response.  I'm sorry for that.
>> 
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
>> >
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
>> 
>> See, I'm not a native English speaker, but I've spent a lot of time
>> and effort improving my English skills.  Thus, perhaps these comments
>> may or may not seem like unnecessary nitpicking, depending on how much
>> someone pays attention to writing style in general, but I'll risk to
>> be annoying and state these comments anyway. :)
>> 
>> The comment above could be written in a much more condensed form like
>> this, which would also be a bit more accurate:
>> 
>> 
>>                                 /* IPA threshold, when IPA governor is 
>> used */
>> 
>> IOW, we're writing all this for someone to read later, but we should
>> (and can) perfectly reasonably expect some already existing background
>> knowledge from the readers.  In other words, we should be as concise
>> as possible.
> 
> In fact, the power allocation governor code itself doesn't call those
> trips threshold or target as your suggested wording would imply.
> Instead, it calls them "switch on temperature" and "maximum desired
> temperature" [1]. Maybe we can call them that in the comments (and
> also avoid calling the governor IPA, because upstream code only calls
> it a "power allocator").

Hmm, but "IPA" is still mentioned in exactly three places in the files
under drivers/thermal.  I think that warrants the use of "IPA", which
is also widely used pretty much everywhere.

Perhaps a win-win would be to have only the very first of the comments
like this, to introduce "IPA" as an acronym:

                                   /* Power allocator (IPA) thermal 
governor       */
                                   /* switch-on point, when IPA governor 
is used   */

Next, "the target temperature" is mentioned more than a few times in
drivers/thermal/gov_power_allocator.c, which I believe makes the use
of "IPA target" perfectly valid.  Actually, let's use "IPA target
temperature", if you agree, to make it self descriptive.

Finally, the threshold...  Based on 
drivers/thermal/gov_power_allocator.c,
I think "IPA switch-on point" would be a good choice, which I already
used above in the proposed opening comment.

> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/gov_power_allocator.c#n483
> 
>> > +                             bigcore0_alert0: bigcore0-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             /* actual control temperature */
>> 
>> Similarly to the above, I'd suggest this:
>> 
>>                                 /* IPA target, when IPA governor is 
>> used */
>> 
>> Having such brief comments should make it all perfectly understandable
>> to anyone who's already familiar with the way IPA governor works.
>> Everyone else should be welcome to read up a bit on IPA first.
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
>> > +                             /* threshold to start collecting temperature
>> > +                              * statistics e.g. with the IPA governor
>> > +                              */
>> 
>> The same as above.
>> 
>> > +                             bigcore2_alert0: bigcore2-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             /* actual control temperature */
>> 
>> The same as above.
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
>> > +                             /* threshold to start collecting temperature
>> > +                              * statistics e.g. with the IPA governor
>> > +                              */
>> 
>> The same as above.
>> 
>> > +                             littlecore_alert0: littlecore-alert0 {
>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             /* actual control temperature */
>> 
>> The same as above.
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
>> >       };
>> >
>> >       saradc: adc@fec10000 {

