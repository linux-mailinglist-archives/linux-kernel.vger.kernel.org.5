Return-Path: <linux-kernel+bounces-32381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09DC835AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817581F22864
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA263B2;
	Mon, 22 Jan 2024 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ySbi0Bup"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E67E544;
	Mon, 22 Jan 2024 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904574; cv=none; b=VC2/Hld4+tCIUbTIH1jIe2z43zaa9WO9GuOdoyKy8mwYjGq7yQpHYQeZPivcvTejOq6CGgbHQ141gzYidaYZOIjK5ZuQVIa86yfsDTnwUAjoTa4V4IXA2wC7Cwz5jUsJ65wi73eUTEtp/FUEDv232qP4t7TCqV5uMhQqOd5g6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904574; c=relaxed/simple;
	bh=CzhiHN6u0gpFlsap7Hp3kow/s+0QRoaF21t02f0p+KM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Xvh6Sa5AU9uzCx7vk4z7iyTKCLoeq7GkmVlb1MMKgzu6y5guiO1Enkw5QqQ7JpaZg+YgRMVC0yTdChAIKXK5S3kDg0GL5Vs4XpyA45H9ef/PSzCWsbenUejYs+3S6rNqAUlyuzSAF1CIu8EjzfR44WJjPbijltgdfFUILxXa3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ySbi0Bup; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705904568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGW+mj+q9tiz/KdV2tQu1Nhq7mIgOYFGcF0u7JC10Do=;
	b=ySbi0BupnyQJqV5I0AfVFTNF97XV7NaLZohRQwdLCMBg6d4a6rzdpaii3BHac/f6BAubei
	KKX0rKndatvwgHUerkUzCB5slKXgdQRXxL4kIDBGuICo/BognxOxgtuuUj3GVLIkVDKxTu
	uDIS0btQT7zg3P4yCfHreo1pqt2rvYVfhF6lRUXW9qo2FjMhIGM9kCA6iriHeSkadgyaBZ
	byeXgk49myFXSh3fgyfzIGO/yiAHKbpt8FnoUgeEarSQOl4Qz9kEYtXgaEgsRJeWoli/iH
	BYr6T9K/nHaw8YNdg74dXTzxnHHPuLfl6FjBsVCIpbU2GJlaoMSCJyfBzUAFyg==
Date: Mon, 22 Jan 2024 07:22:48 +0100
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
In-Reply-To: <CABjd4Yy91MAd2wALp4KQiEub9OyxU+MR+ti5KA_c+yvZT5xaqQ@mail.gmail.com>
References: <20240106222357.23835-1-alchark@gmail.com>
 <e0302da12345e5539583b2c96d747592@manjaro.org>
 <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
 <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org>
 <CABjd4Yz11D8ThcT-oCWsQf9jL2idChFYSRYVVu3KNnzwoOwkKQ@mail.gmail.com>
 <f5c05015e042b11a51a9af26c35f18ed@manjaro.org>
 <CABjd4Yy91MAd2wALp4KQiEub9OyxU+MR+ti5KA_c+yvZT5xaqQ@mail.gmail.com>
Message-ID: <81a5410c3dbedbd4fe9ce60ab236700c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-22 07:03, Alexey Charkov wrote:
> On Mon, Jan 22, 2024 at 8:55 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-01-21 19:56, Alexey Charkov wrote:
>> > On Thu, Jan 18, 2024 at 10:48 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> On 2024-01-08 14:41, Alexey Charkov wrote:
>> >> > On Sun, Jan 7, 2024 at 2:54 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> >> On 2024-01-06 23:23, Alexey Charkov wrote:
>> >> >> > Include thermal zones information in device tree for rk3588 variants
>> >> >> > and enable the built-in thermal sensing ADC on RADXA Rock 5B
>> >> >> >
>> >> >> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> >> >> > ---
>> >> >> > +                     trips {
>> >> >> > +                             threshold: trip-point-0 {
>> >> >>
>> >> >> It should be better to name it cpu_alert0 instead, because that's what
>> >> >> other newer dtsi files already use.
>> >> >
>> >> > Reflecting on your comments here and below, I'm thinking that maybe it
>> >> > would be better to define only the critical trip point for the SoC
>> >> > overall, and then have alerts along with the respective cooling maps
>> >> > separately for A76-0,1, A76-2,3, A55-0,1,2,3? After all, given that we
>> >> > have more granular temperature measurement here than in previous RK
>> >> > chipsets it might be better to only throttle the "offending" cores,
>> >> > not the full package.
>> >> >
>> >> > What do you think?
>> >> >
>> >> > Downstream DT doesn't follow this approach though, so maybe there's
>> >> > something I'm missing here.
>> >>
>> >> I agree, it's better to fully utilize the higher measurement
>> >> granularity
>> >> made possible by having multiple temperature sensors available.
>> >>
>> >> I also agree that we should have only the critical trip defined for
>> >> the
>> >> package-level temperature sensor.  Let's have the separate temperature
>> >> measurements for the CPU (sub)clusters do the thermal throttling, and
>> >> let's keep the package-level measurement for the critical shutdowns
>> >> only.  IIRC, some MediaTek SoC dtsi already does exactly that.
>> >>
>> >> Of course, there are no reasons not to have the critical trips defined
>> >> for the CPU (sub)clusters as well.
>> >
>> > I think I'll also add a board-specific active cooling mechanism on the
>> > package level in the next iteration, given that Rock 5B has a PWM fan
>> > defined as a cooling device. That will go in the separate patch that
>> > updates rk3588-rock-5b.dts (your feedback to v2 of this patch is also
>> > duly noted, thank you!)
>> 
>> Great, thanks.  Sure, making use of the Rock 5B's support for 
>> attaching
>> a PWM-controlled cooling fan is the way to go.
>> 
>> Just to reiterate a bit, any "active" trip points belong to the board
>> dts file(s), because having a cooling fan is a board-specific feature.
>> As a note, you may also want to have a look at the RockPro64 dts(i)
>> files, for example;  the RockPro64 also comes with a cooling fan
>> connector and the associated PWM fan control logic.
> 
> Thanks for the pointer! There is also a helpful doc within devicetree
> bindings descriptions, although it sits under hwmon which was a bit
> confusing to me. I've already tested it locally (by adding to the
> board dts), and it spins up and down quite nicely, and even modulates
> the fan speed swiftly when the load changes - yay!

Nice!  Also, isn't it like magic? :)  To me, turning LEDs on/off and
controlling fans acts as some kind of a "bridge" between the virtual
and the real world. :)

As a suggestion, it would be good to test with a couple of different
fans, to make sure that the PWM values work well for more that one fan
model.  The Rock 5B requires a 5 V fan, if I'm not mistaken?

>> >> >> > +                                     temperature = <75000>;
>> >> >> > +                                     hysteresis = <2000>;
>> >> >> > +                                     type = "passive";
>> >> >> > +                             };
>> >> >> > +                             target: trip-point-1 {
>> >> >>
>> >> >> It should be better to name it cpu_alert1 instead, because that's what
>> >> >> other newer dtsi files already use.
>> >> >>
>> >> >> > +                                     temperature = <85000>;
>> >> >> > +                                     hysteresis = <2000>;
>> >> >> > +                                     type = "passive";
>> >> >> > +                             };
>> >> >> > +                             soc_crit: soc-crit {
>> >> >>
>> >> >> It should be better to name it cpu_crit instead, because that's what
>> >> >> other newer dtsi files already use.
>> >> >
>> >> > Seems to me that if I define separate trips for the three groups of
>> >> > CPU cores as mentioned above this would better stay as soc_crit, as it
>> >> > applies to the whole die rather than the CPU cluster alone. Then
>> >> > 'threshold' and 'target' will go altogether, and I'll have separate
>> >> > *_alert0 and *_alert1 per CPU group.
>> >>
>> >> It should perhaps be the best to have "passive", "hot" and "critical"
>> >> trips defined for all three CPU groups/(sub)clusters, separately of
>> >> course, to have even higher granularity when it comes to the resulting
>> >> thermal throttling.
>> >
>> > I looked through drivers/thermal/rockchip_thermal.c, and it doesn't
>> > seem to provide any callback for the "hot" trip as part of its struct
>> > thermal_zone_device_ops, so I guess it would be redundant in our case
>> > here? I couldn't find any generic mechanism to react to "hot" trips,
>> > and they seem to be purely driver-specific, thus no-op in case of
>> > Rockchips - or am I missing something?
>> 
>> That's a good question.  Please, let me go through the code in detail,
>> and I'll get back with an update soon.  Also, please wait a bit with
>> sending the v3, until all open questions are addressed.
> 
> Of course. Thank you for taking the time to dig through this one with 
> me!

I'm glad to help.  It's important to have working thermal throttling on
the supported RK3588-based boards.

