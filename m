Return-Path: <linux-kernel+bounces-32324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE0F835A28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AC92830DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BF4C83;
	Mon, 22 Jan 2024 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oP9PqvpM"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA637B;
	Mon, 22 Jan 2024 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705899342; cv=none; b=YJEeQsQAjPjPjB/E2iqacl4ENASUKhIXhrC6WqIks4Cu6uoxd4/jb55VyB3rVq/DPTDtsuyS+28OXE3RiiJp6XeVAR/QxH02m7jzvgttfx+doNmbc6CZscBx2h2kxdzwnnimyxPmW9Auz51mS8jXEVICUXtvzASaeHuuwU9Ib+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705899342; c=relaxed/simple;
	bh=WdFX8jgbcR8BQulqKt1Rc1DE9dTSHKZ63A30QpN33s4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=L9v1gNA3NLMObh4unkAKNYaTsjvNZDSdaqXJKFsA5EX8AQ96ARnuJnYqEHcYqHKyjpMfa95e9MQmbC75b3j8sCl9nxjC9LrZ/X6Xhec2yfMbLXPLKhZgFA7IS8Zl0mo0bxSu1C+JmBlbWTxkSDrmkxWmAM6JB18QIDqQIGmo/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oP9PqvpM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705899335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaQh+8yhOwOyEdvsy4EqrUjzPEtKP3cZ5MZ5et/P3ZM=;
	b=oP9PqvpM9UcgRjsr0ZF5Qb5zJdhpkzJzeT6hO43CPJnvTd2bOs+RfIoz0IWCo/a4kBJpZe
	a9l6oQKNThzWx3oSW1pivw361HJLoFZB2KY67R9/SsKjrtqQnUNXKEKqGVyHk3tPyYFp1K
	mL5fZpwQQCl0gv6/EdepH0qCcFHh7MtKeXRt84MGXFmDOVp71pt7r8PyiJLTkOPj1XCUjg
	Dk/d3OaKkSFqeByc+m3zNxxXxgBB3XJd4Fuy3EhYJiI0gZ+IrhcBOtNYX0IyCbZgJPMhF1
	6TWvqxzIzVqix8m8psAfvXjRWn7jEZ8SKFQptyPXiXwXraQ0K3ubkcoREZHv7w==
Date: Mon, 22 Jan 2024 05:55:35 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Christopher Obbard
 <chris.obbard@collabora.com>, =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?=
 <szucst@iit.uni-miskolc.hu>, Shreeya Patel <shreeya.patel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Chris Morgan
 <macromorgan@hotmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable built-in thermal monitoring
 on rk3588
In-Reply-To: <CABjd4Yz11D8ThcT-oCWsQf9jL2idChFYSRYVVu3KNnzwoOwkKQ@mail.gmail.com>
References: <20240106222357.23835-1-alchark@gmail.com>
 <e0302da12345e5539583b2c96d747592@manjaro.org>
 <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
 <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org>
 <CABjd4Yz11D8ThcT-oCWsQf9jL2idChFYSRYVVu3KNnzwoOwkKQ@mail.gmail.com>
Message-ID: <f5c05015e042b11a51a9af26c35f18ed@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-01-21 19:56, Alexey Charkov wrote:
> On Thu, Jan 18, 2024 at 10:48 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-01-08 14:41, Alexey Charkov wrote:
>> I apologize for my delayed response.  It took me almost a month to
>> nearly fully recover from some really nasty flu that eventually went
>> into my lungs.  It was awful and I'm still not back to my 100%. :(
> 
> Ouch, I hope you get well soon!

Thank you, let's hope so.  It's been really exhausting. :(

>> > On Sun, Jan 7, 2024 at 2:54 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> On 2024-01-06 23:23, Alexey Charkov wrote:
>> >> > Include thermal zones information in device tree for rk3588 variants
>> >> > and enable the built-in thermal sensing ADC on RADXA Rock 5B
>> >> >
>> >> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> >> > ---
>> >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> >> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> >> > index 8aa0499f9b03..8235991e3112 100644
>> >> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> >> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> >> > @@ -10,6 +10,7 @@
>> >> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>> >> >  #include <dt-bindings/phy/phy.h>
>> >> >  #include <dt-bindings/ata/ahci.h>
>> >> > +#include <dt-bindings/thermal/thermal.h>
>> >> >
>> >> >  / {
>> >> >       compatible = "rockchip,rk3588";
>> >> > @@ -2112,6 +2113,148 @@ tsadc: tsadc@fec00000 {
>> >> >               status = "disabled";
>> >> >       };
>> >> >
>> >> > +     thermal_zones: thermal-zones {
>> >> > +             soc_thermal: soc-thermal {
>> >>
>> >> It should be better to name it cpu_thermal instead.  In the end,
>> >> that's what it is.
>> >
>> > The TRM document says the first TSADC channel (to which this section
>> > applies) measures the temperature near the center of the SoC die,
>> > which implies not only the CPU but also the GPU at least. RADXA's
>> > kernel for Rock 5B also has GPU passive cooling as one of the cooling
>> > maps under this node (not included here, as we don't have the GPU node
>> > in .dtsi just yet). So perhaps naming this one cpu_thermal could be
>> > misleading?
>> 
>> Ah, I see now, thanks for reminding;  it's all described on page 1,372
>> of the first part of the RK3588 TRM v1.0.
>> 
>> Having that in mind, I'd suggest that we end up naming it 
>> package_thermal.
>> The temperature near the center of the chip is usually considered to 
>> be
>> the overall package temperature;  for example, that's how the 
>> user-facing
>> CPU temperatures are measured in the x86_64 world.
> 
> Sounds good, will rename in v3!

Thanks, I'm glad you agree.

>> >> > +                     trips {
>> >> > +                             threshold: trip-point-0 {
>> >>
>> >> It should be better to name it cpu_alert0 instead, because that's what
>> >> other newer dtsi files already use.
>> >
>> > Reflecting on your comments here and below, I'm thinking that maybe it
>> > would be better to define only the critical trip point for the SoC
>> > overall, and then have alerts along with the respective cooling maps
>> > separately for A76-0,1, A76-2,3, A55-0,1,2,3? After all, given that we
>> > have more granular temperature measurement here than in previous RK
>> > chipsets it might be better to only throttle the "offending" cores,
>> > not the full package.
>> >
>> > What do you think?
>> >
>> > Downstream DT doesn't follow this approach though, so maybe there's
>> > something I'm missing here.
>> 
>> I agree, it's better to fully utilize the higher measurement 
>> granularity
>> made possible by having multiple temperature sensors available.
>> 
>> I also agree that we should have only the critical trip defined for 
>> the
>> package-level temperature sensor.  Let's have the separate temperature
>> measurements for the CPU (sub)clusters do the thermal throttling, and
>> let's keep the package-level measurement for the critical shutdowns
>> only.  IIRC, some MediaTek SoC dtsi already does exactly that.
>> 
>> Of course, there are no reasons not to have the critical trips defined
>> for the CPU (sub)clusters as well.
> 
> I think I'll also add a board-specific active cooling mechanism on the
> package level in the next iteration, given that Rock 5B has a PWM fan
> defined as a cooling device. That will go in the separate patch that
> updates rk3588-rock-5b.dts (your feedback to v2 of this patch is also
> duly noted, thank you!)

Great, thanks.  Sure, making use of the Rock 5B's support for attaching
a PWM-controlled cooling fan is the way to go.

Just to reiterate a bit, any "active" trip points belong to the board 
dts
file(s), because having a cooling fan is a board-specific feature.  As a
note, you may also want to have a look at the RockPro64 dts(i) files, 
for
example;  the RockPro64 also comes with a cooling fan connector and the
associated PWM fan control logic.

>> >> > +                                     temperature = <75000>;
>> >> > +                                     hysteresis = <2000>;
>> >> > +                                     type = "passive";
>> >> > +                             };
>> >> > +                             target: trip-point-1 {
>> >>
>> >> It should be better to name it cpu_alert1 instead, because that's what
>> >> other newer dtsi files already use.
>> >>
>> >> > +                                     temperature = <85000>;
>> >> > +                                     hysteresis = <2000>;
>> >> > +                                     type = "passive";
>> >> > +                             };
>> >> > +                             soc_crit: soc-crit {
>> >>
>> >> It should be better to name it cpu_crit instead, because that's what
>> >> other newer dtsi files already use.
>> >
>> > Seems to me that if I define separate trips for the three groups of
>> > CPU cores as mentioned above this would better stay as soc_crit, as it
>> > applies to the whole die rather than the CPU cluster alone. Then
>> > 'threshold' and 'target' will go altogether, and I'll have separate
>> > *_alert0 and *_alert1 per CPU group.
>> 
>> It should perhaps be the best to have "passive", "hot" and "critical"
>> trips defined for all three CPU groups/(sub)clusters, separately of
>> course, to have even higher granularity when it comes to the resulting
>> thermal throttling.
> 
> I looked through drivers/thermal/rockchip_thermal.c, and it doesn't
> seem to provide any callback for the "hot" trip as part of its struct
> thermal_zone_device_ops, so I guess it would be redundant in our case
> here? I couldn't find any generic mechanism to react to "hot" trips,
> and they seem to be purely driver-specific, thus no-op in case of
> Rockchips - or am I missing something?

That's a good question.  Please, let me go through the code in detail,
and I'll get back with an update soon.  Also, please wait a bit with
sending the v3, until all open questions are addressed.

>> >> > +                                     hysteresis = <2000>;
>> >> > +                                     type = "critical";
>> >> > +                             };
>> >> > +                     };
>> >> > +                     cooling-maps {
>> >> > +                             map0 {
>> >> > +                                     trip = <&target>;
>> >>
>> >> Shouldn't &threshold (i.e. &cpu_alert0) be referenced here instead?
>> >>
>> >> > +                                     cooling-device = <&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> >>
>> >> Shouldn't all big CPU cores be listed here instead?
>> >
>> > I guess if a separate trip point is defined for cpu_l0,1,2,3 then it
>> > would need to throttle at 75C, and then cpu_b0,1 and cpu_b2,3 at 85C
>> > each. Logic being that if a sensor stacked in the middle of a group of
>> > four cores shows 75C then one of the four might well be in abnormal
>> > temperature range already (85+), while sensors next to only two big
>> > cores each will likely show temperatures similar to the actual core
>> > temperature.
>> 
>> I think we shouldn't make any assumptions of how the CPU cores heat up
>> and affect each other, because we don't really know the required 
>> details.
>> Instead, we should simply define the reasonable values for the 
>> "passive",
>> "hot" and "critical" trips, and leave the rest to the standard thermal
>> throttling logic.  I hope you agree.
>> 
>> In the end, that's why we have separate thermal sensors available.
> 
> Indeed! I'll add extra "passive" alerts though (at 75C) to enable the
> power allocation governor to initialize its PID parameters calculation
> before the control temperature setpoint gets hit (per Daniel's
> feedback under separate cover).

I'm glad you agree.  Adding one more "passive" trip point makes sense,
but please let me go through the code in detail first.

