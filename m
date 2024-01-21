Return-Path: <linux-kernel+bounces-32151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5E83574E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF0F1C20B12
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECF38392;
	Sun, 21 Jan 2024 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ4nQryc"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D63374FC;
	Sun, 21 Jan 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705863426; cv=none; b=ZR3Mm/WHTWfN6bQcbJu6BE61m0lwDvOOhjbwtZSlKQ8JW4gyCz41ja1o/DYFQsebOvY9QZ6Y9FsKGhHghiaTrumlJT1ey5tHDvQW8IRhSJFoPED8TPn+nPytk2+FSZHkYjZ0bWqYMSfUg4o2BmEcoIT6dCcTJ7BVWmQycgQrJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705863426; c=relaxed/simple;
	bh=Bdn7qDe8/Sz5W1tIz1blcNpXVkpZFJhPhA80wWB91cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3TG+oBf4nWfWViNtZwbKXy52acmQeObIdjhsQFdc9NGpU8XQp38xEx2DFl+SZV0rcQ3aQrdFAG+oTmh/CnZfMNOdhUiUV9bvLIHQRMBjSSX3jJaklGadN0t6kTcyUw5jMB+OFQOduDSWXLw5E4EK4r+twZXwqiJU+IwlLDYTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ4nQryc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2dd05e02ffso229421766b.3;
        Sun, 21 Jan 2024 10:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705863423; x=1706468223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAC/MAs8sDhQ2A52cnBwttm+Y/uqCzYoFUfLNS1dkik=;
        b=XQ4nQrycJoyifO8dnq5Tf5tqTAaz0mMjkCkqFlwqGhsnYr6FycgPpm98cvqkyCE/Nh
         pG5igAwVOUCaAbMM7EJoa7Red9u/BFc9viMWV2NPu8Q/LmtMRwXWTwv5U+6Nk8Joke+f
         nVZ1wgXF4dweyDnLHoEORoOYdnpWO8/IZkRs5tfniHKICtz48s8M/zUra2oJonpX43EF
         pUQX5YkRPrF7hhca2P/ykveKO9yAqx55IfPwWVcpowrQYO3fvOsO9MgeyqAQZ0eStSjA
         rjgAwcAJWcI/j34q1PUbOzG8aVRxSDCt/tm3rD3OrWgzEvYr4Wuc6JVHJxBjnUGg5SIM
         KwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705863423; x=1706468223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAC/MAs8sDhQ2A52cnBwttm+Y/uqCzYoFUfLNS1dkik=;
        b=dxAVB7Bt3oWFRBHJUpJao7xbOssH5uHVKwcRhJ3ezimFvAW4H5fU6w1kVbNFiTml/7
         iTs474tXl4l3zuV1Jyu5UV6vvnnsJ2p2fo+cLScMq66NpznPFRKdFougZBCrdOoY/TLV
         xlCmiGcSXlvwwRWsBRihHulzxG0fsSmT8n8wEcRkksPTASPR4Tk74gFX8lGhe2hk+Br3
         VvlA0Yczyq2I9ckpaX6uugOuBWusTQOIeoSbfNvgZN5gH8avPDoKN1IXyr3BAmFd676U
         Kgf28EmxN8OJkD496HXsH1sw9yqoHSSkxUZqQ3f2Gzz8vBGv2hWYEknSoRwfcvuCXsNh
         YnCA==
X-Gm-Message-State: AOJu0Yxqv+i7u7Oyel0PJQMQFCEFIgbPDuNbS01KlXNPECmm0hdcTgEH
	5Grl9fOY1sljeLZ9VM14AA0A9YNvIaphkdxur2QcFgaScYuXiz3JD4uOuvWX6C/9Sn2IeDr+ym3
	KVHkGBoaU2+pZQo90nMVCI/HWYbY=
X-Google-Smtp-Source: AGHT+IHJ9Z0SOxpKbs/ZPvQclFjb6eD3X8+HhpiS5bGel15Xf65B+skTcyZhBnwK8JlmDS0HUQcto76rF196oyc9rsg=
X-Received: by 2002:a17:906:1399:b0:a30:4618:8252 with SMTP id
 f25-20020a170906139900b00a3046188252mr197053ejc.186.1705863422591; Sun, 21
 Jan 2024 10:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106222357.23835-1-alchark@gmail.com> <e0302da12345e5539583b2c96d747592@manjaro.org>
 <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com> <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org>
In-Reply-To: <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Sun, 21 Jan 2024 22:56:49 +0400
Message-ID: <CABjd4Yz11D8ThcT-oCWsQf9jL2idChFYSRYVVu3KNnzwoOwkKQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: enable built-in thermal monitoring
 on rk3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Christopher Obbard <chris.obbard@collabora.com>, =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <szucst@iit.uni-miskolc.hu>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Kever Yang <kever.yang@rock-chips.com>, 
	Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:48=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> On 2024-01-08 14:41, Alexey Charkov wrote:
> > Hello Dragan,
>
> Hello Alexey! :)
>
> I apologize for my delayed response.  It took me almost a month to
> nearly fully recover from some really nasty flu that eventually went
> into my lungs.  It was awful and I'm still not back to my 100%. :(

Ouch, I hope you get well soon!

> > Thanks a lot for your review and comments! Some reflections below.
>
> Thank you for your work and for your detailed response.  Please see my
> comments below, which apply to your v2 submission as a well, to which
> I'll respond separately a bit later.
>
> > On Sun, Jan 7, 2024 at 2:54=E2=80=AFAM Dragan Simic <dsimic@manjaro.org=
> wrote:
> >> On 2024-01-06 23:23, Alexey Charkov wrote:
> >> > Include thermal zones information in device tree for rk3588 variants
> >> > and enable the built-in thermal sensing ADC on RADXA Rock 5B
> >> >
> >> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> > ---
> >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > index 8aa0499f9b03..8235991e3112 100644
> >> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > @@ -10,6 +10,7 @@
> >> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> >> >  #include <dt-bindings/phy/phy.h>
> >> >  #include <dt-bindings/ata/ahci.h>
> >> > +#include <dt-bindings/thermal/thermal.h>
> >> >
> >> >  / {
> >> >       compatible =3D "rockchip,rk3588";
> >> > @@ -2112,6 +2113,148 @@ tsadc: tsadc@fec00000 {
> >> >               status =3D "disabled";
> >> >       };
> >> >
> >> > +     thermal_zones: thermal-zones {
> >> > +             soc_thermal: soc-thermal {
> >>
> >> It should be better to name it cpu_thermal instead.  In the end,
> >> that's
> >> what it is.
> >
> > The TRM document says the first TSADC channel (to which this section
> > applies) measures the temperature near the center of the SoC die,
> > which implies not only the CPU but also the GPU at least. RADXA's
> > kernel for Rock 5B also has GPU passive cooling as one of the cooling
> > maps under this node (not included here, as we don't have the GPU node
> > in .dtsi just yet). So perhaps naming this one cpu_thermal could be
> > misleading?
>
> Ah, I see now, thanks for reminding;  it's all described on page 1,372
> of the first part of the RK3588 TRM v1.0.
>
> Having that in mind, I'd suggest that we end up naming it
> package_thermal.
> The temperature near the center of the chip is usually considered to be
> the overall package temperature;  for example, that's how the
> user-facing
> CPU temperatures are measured in the x86_64 world.

Sounds good, will rename in v3!

> >> > +                     trips {
> >> > +                             threshold: trip-point-0 {
> >>
> >> It should be better to name it cpu_alert0 instead, because that's what
> >> other newer dtsi files already use.
> >
> > Reflecting on your comments here and below, I'm thinking that maybe it
> > would be better to define only the critical trip point for the SoC
> > overall, and then have alerts along with the respective cooling maps
> > separately for A76-0,1, A76-2,3, A55-0,1,2,3? After all, given that we
> > have more granular temperature measurement here than in previous RK
> > chipsets it might be better to only throttle the "offending" cores,
> > not the full package.
> >
> > What do you think?
> >
> > Downstream DT doesn't follow this approach though, so maybe there's
> > something I'm missing here.
>
> I agree, it's better to fully utilize the higher measurement granularity
> made possible by having multiple temperature sensors available.
>
> I also agree that we should have only the critical trip defined for the
> package-level temperature sensor.  Let's have the separate temperature
> measurements for the CPU (sub)clusters do the thermal throttling, and
> let's keep the package-level measurement for the critical shutdowns
> only.
> IIRC, some MediaTek SoC dtsi already does exactly that.
>
> Of course, there are no reasons not to have the critical trips defined
> for the CPU (sub)clusters as well.

I think I'll also add a board-specific active cooling mechanism on the
package level in the next iteration, given that Rock 5B has a PWM fan
defined as a cooling device. That will go in the separate patch that
updates rk3588-rock-5b.dts (your feedback to v2 of this patch is also
duly noted, thank you!)

> >> > +                                     temperature =3D <75000>;
> >> > +                                     hysteresis =3D <2000>;
> >> > +                                     type =3D "passive";
> >> > +                             };
> >> > +                             target: trip-point-1 {
> >>
> >> It should be better to name it cpu_alert1 instead, because that's what
> >> other newer dtsi files already use.
> >>
> >> > +                                     temperature =3D <85000>;
> >> > +                                     hysteresis =3D <2000>;
> >> > +                                     type =3D "passive";
> >> > +                             };
> >> > +                             soc_crit: soc-crit {
> >>
> >> It should be better to name it cpu_crit instead, because that's what
> >> other newer dtsi files already use.
> >
> > Seems to me that if I define separate trips for the three groups of
> > CPU cores as mentioned above this would better stay as soc_crit, as it
> > applies to the whole die rather than the CPU cluster alone. Then
> > 'threshold' and 'target' will go altogether, and I'll have separate
> > *_alert0 and *_alert1 per CPU group.
>
> It should perhaps be the best to have "passive", "hot" and "critical"
> trips defined for all three CPU groups/(sub)clusters, separately of
> course, to have even higher granularity when it comes to the resulting
> thermal throttling.

I looked through drivers/thermal/rockchip_thermal.c, and it doesn't
seem to provide any callback for the "hot" trip as part of its struct
thermal_zone_device_ops, so I guess it would be redundant in our case
here? I couldn't find any generic mechanism to react to "hot" trips,
and they seem to be purely driver-specific, thus no-op in case of
Rockchips - or am I missing something?

> >> > +                                     hysteresis =3D <2000>;
> >> > +                                     type =3D "critical";
> >> > +                             };
> >> > +                     };
> >> > +                     cooling-maps {
> >> > +                             map0 {
> >> > +                                     trip =3D <&target>;
> >>
> >> Shouldn't &threshold (i.e. &cpu_alert0) be referenced here instead?
> >>
> >> > +                                     cooling-device =3D <&cpu_l0 TH=
ERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >>
> >> Shouldn't all big CPU cores be listed here instead?
> >
> > I guess if a separate trip point is defined for cpu_l0,1,2,3 then it
> > would need to throttle at 75C, and then cpu_b0,1 and cpu_b2,3 at 85C
> > each. Logic being that if a sensor stacked in the middle of a group of
> > four cores shows 75C then one of the four might well be in abnormal
> > temperature range already (85+), while sensors next to only two big
> > cores each will likely show temperatures similar to the actual core
> > temperature.
>
> I think we shouldn't make any assumptions of how the CPU cores heat up
> and affect each other, because we don't really know the required
> details.
> Instead, we should simply define the reasonable values for the
> "passive",
> "hot" and "critical" trips, and leave the rest to the standard thermal
> throttling logic.  I hope you agree.
>
> In the end, that's why we have separate thermal sensors available.

Indeed! I'll add extra "passive" alerts though (at 75C) to enable the
power allocation governor to initialize its PID parameters calculation
before the control temperature setpoint gets hit (per Daniel's
feedback under separate cover).

Thanks again for your review and comments on this one!

Best regards,
Alexey

