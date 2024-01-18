Return-Path: <linux-kernel+bounces-30484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B461831F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFA4284ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9972E3F9;
	Thu, 18 Jan 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RF1atSkW"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EB51E4A9;
	Thu, 18 Jan 2024 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603741; cv=none; b=gsUZGu7MYyatwuoKswRHBE+AdS4yb6EHXgcXfvzNpo1nDuCloCQCrf/Nx31iNuPmzcMqEIt507vwfEN6rOPBiIsySbu0bqjbiTiWM61LlHTQYa4brwamE1rhER2WXHay+2hGkVsLiIpUUDcnLLs/vq/kZk7DCMVyxR+wboJKEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603741; c=relaxed/simple;
	bh=JQjiFVULmEML58lsdDXgZq1OZra7IlxMDt66yWR6Em4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pwDL+oDMh8ex1P5SFElUVfZylhRbhtdx2fMsnzsGuQ4gNfRTkoq/mTZLTstyxeWfeUfJdVK6DpwpqLmtlm6dbdQHWM3j7JB0m8j81g1FE+vv5kZXLwqAfiMfisTgHeD8pKkLgBfnk2/4kkOOxtcHYIkEPKdxvf7CPjlbLHnzyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RF1atSkW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705603735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hihwF0J7BfIK6RvrjCa3XMzS4nEYJZcotMhLsDWzew=;
	b=RF1atSkW9W7u05pqa5iEaev9NFGTGqziTJruMnSh+9Qs1daCAJVliDKQZlmee4KItbtvKn
	BR7CQVW8wNXgtOLjtEMjCV7ZCPv/e7XXTyXc3Ijx5E84tAuhRahtXqMb76Oe7cBmCrZIps
	5wDLXf8GlPpnTNT3w5fK9JEJDYRQWbB7JiHsPy+lHDWr81JF6AKjFwnaXXclZ/UcbPAqud
	yjm8dR3/Fkv0RaZ4hUvcycXC6Hj7LFxQdMlqNwPpc0cAQ8wlKhzHFfgXMkCc6myZXO+6+U
	HFOE46VYX/n0xWIZYI5w0IlzQMK3KmBemVjw5my1wTLUaxXM+Jvy7XpScmPylg==
Date: Thu, 18 Jan 2024 19:48:52 +0100
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
In-Reply-To: <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
References: <20240106222357.23835-1-alchark@gmail.com>
 <e0302da12345e5539583b2c96d747592@manjaro.org>
 <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
Message-ID: <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-08 14:41, Alexey Charkov wrote:
> Hello Dragan,

Hello Alexey! :)

I apologize for my delayed response.  It took me almost a month to
nearly fully recover from some really nasty flu that eventually went
into my lungs.  It was awful and I'm still not back to my 100%. :(

> Thanks a lot for your review and comments! Some reflections below.

Thank you for your work and for your detailed response.  Please see my
comments below, which apply to your v2 submission as a well, to which
I'll respond separately a bit later.

> On Sun, Jan 7, 2024 at 2:54 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-01-06 23:23, Alexey Charkov wrote:
>> > Include thermal zones information in device tree for rk3588 variants
>> > and enable the built-in thermal sensing ADC on RADXA Rock 5B
>> >
>> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> > ---
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > index 8aa0499f9b03..8235991e3112 100644
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
>> > @@ -2112,6 +2113,148 @@ tsadc: tsadc@fec00000 {
>> >               status = "disabled";
>> >       };
>> >
>> > +     thermal_zones: thermal-zones {
>> > +             soc_thermal: soc-thermal {
>> 
>> It should be better to name it cpu_thermal instead.  In the end, 
>> that's
>> what it is.
> 
> The TRM document says the first TSADC channel (to which this section
> applies) measures the temperature near the center of the SoC die,
> which implies not only the CPU but also the GPU at least. RADXA's
> kernel for Rock 5B also has GPU passive cooling as one of the cooling
> maps under this node (not included here, as we don't have the GPU node
> in .dtsi just yet). So perhaps naming this one cpu_thermal could be
> misleading?

Ah, I see now, thanks for reminding;  it's all described on page 1,372
of the first part of the RK3588 TRM v1.0.

Having that in mind, I'd suggest that we end up naming it 
package_thermal.
The temperature near the center of the chip is usually considered to be
the overall package temperature;  for example, that's how the 
user-facing
CPU temperatures are measured in the x86_64 world.

>> > +                     trips {
>> > +                             threshold: trip-point-0 {
>> 
>> It should be better to name it cpu_alert0 instead, because that's what
>> other newer dtsi files already use.
> 
> Reflecting on your comments here and below, I'm thinking that maybe it
> would be better to define only the critical trip point for the SoC
> overall, and then have alerts along with the respective cooling maps
> separately for A76-0,1, A76-2,3, A55-0,1,2,3? After all, given that we
> have more granular temperature measurement here than in previous RK
> chipsets it might be better to only throttle the "offending" cores,
> not the full package.
> 
> What do you think?
> 
> Downstream DT doesn't follow this approach though, so maybe there's
> something I'm missing here.

I agree, it's better to fully utilize the higher measurement granularity
made possible by having multiple temperature sensors available.

I also agree that we should have only the critical trip defined for the
package-level temperature sensor.  Let's have the separate temperature
measurements for the CPU (sub)clusters do the thermal throttling, and
let's keep the package-level measurement for the critical shutdowns 
only.
IIRC, some MediaTek SoC dtsi already does exactly that.

Of course, there are no reasons not to have the critical trips defined
for the CPU (sub)clusters as well.

>> > +                                     temperature = <75000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             target: trip-point-1 {
>> 
>> It should be better to name it cpu_alert1 instead, because that's what
>> other newer dtsi files already use.
>> 
>> > +                                     temperature = <85000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             soc_crit: soc-crit {
>> 
>> It should be better to name it cpu_crit instead, because that's what
>> other newer dtsi files already use.
> 
> Seems to me that if I define separate trips for the three groups of
> CPU cores as mentioned above this would better stay as soc_crit, as it
> applies to the whole die rather than the CPU cluster alone. Then
> 'threshold' and 'target' will go altogether, and I'll have separate
> *_alert0 and *_alert1 per CPU group.

It should perhaps be the best to have "passive", "hot" and "critical"
trips defined for all three CPU groups/(sub)clusters, separately of
course, to have even higher granularity when it comes to the resulting
thermal throttling.

>> > +                                     hysteresis = <2000>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +                     cooling-maps {
>> > +                             map0 {
>> > +                                     trip = <&target>;
>> 
>> Shouldn't &threshold (i.e. &cpu_alert0) be referenced here instead?
>> 
>> > +                                     cooling-device = <&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> 
>> Shouldn't all big CPU cores be listed here instead?
> 
> I guess if a separate trip point is defined for cpu_l0,1,2,3 then it
> would need to throttle at 75C, and then cpu_b0,1 and cpu_b2,3 at 85C
> each. Logic being that if a sensor stacked in the middle of a group of
> four cores shows 75C then one of the four might well be in abnormal
> temperature range already (85+), while sensors next to only two big
> cores each will likely show temperatures similar to the actual core
> temperature.

I think we shouldn't make any assumptions of how the CPU cores heat up
and affect each other, because we don't really know the required 
details.
Instead, we should simply define the reasonable values for the 
"passive",
"hot" and "critical" trips, and leave the rest to the standard thermal
throttling logic.  I hope you agree.

In the end, that's why we have separate thermal sensors available.

