Return-Path: <linux-kernel+bounces-19634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE595827015
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FC6283076
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5845943;
	Mon,  8 Jan 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+3J+XMR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD344C89;
	Mon,  8 Jan 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28d61ba65eso191970766b.3;
        Mon, 08 Jan 2024 05:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704721320; x=1705326120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz451h4edKTDxxrbgcD1oSNjJcR0EigWDIHD2PnYOVE=;
        b=m+3J+XMR4iL83v72r0gAYuStMyrfB6bnvWOFQ6Ob1SPCSaTZN7pxkKOM/fjFQOEi3j
         lQL8fX24lrMzR+yvFfljyKZpER1uMeP+JSHf3H34Ija+iHCWAV9zMx7+611e2CzKLOnl
         AOPSr60f4zMl2rctDwzBVoffGPaT0xz2MgEyrUDOV6DZ8caeXimqBGpqkOQO8bAc7py9
         Ueq66JwWsNCWPbXjJZ1Fy+Hqncu3xIRU59g3AT2WCWqYxBRbeqqfxXpXi24djLVv3msg
         bPxYB6zugoYR3+JYM0qiXXjX9pFL5J7GGr09DX/obeUvSqsymYdm4CHZpzmRPZuAVgAk
         qfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721320; x=1705326120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz451h4edKTDxxrbgcD1oSNjJcR0EigWDIHD2PnYOVE=;
        b=Uk1X39FzbzwNdEBOvrRAB/40xe4d6sj0mW0uVgSqGc2fhToVqWWxDEaN2O5I2RLbNw
         BCtK/S7ld+5dgOdOLRFrDg0ECaza5SVhSVhPOATyDXmjejxTcY6klpY9PKaGOJu1RJGo
         mcVeLr6py+Bot2iEyiyn8JVrShkI/NP1kuP1WHHiYLv0PTUphbQVWEBq7SrWKyYOtTvA
         UYPZcrwZYng6v0R77w8EFD85D77DTCjjyoM2AMGEGSL9jxxhPnuAQ5yurxW+E1o7nKkU
         +QWhxlkGggDb6y35kK22OotpgTBaTrLNe3fe9zBJZ0Yy/ZVUHSmE87JcjPblHNhjso4C
         3muA==
X-Gm-Message-State: AOJu0Yxp3c9i6huQA12pFb/Jq7W2IUZMZX77DOerHunoXxqY1Pe0XzuJ
	YxMqHb9wHNquePJP86x7RtGWQ5L2bNYbcA71JQw=
X-Google-Smtp-Source: AGHT+IGXbRFoqA9qDYjxSi3PLlRL9naxZ7RhWvNz/4NCr2zTe6Y1ejAzJkv3U1SymHn89v33PdackSRpy4eeYzVT3nw=
X-Received: by 2002:a17:906:24d3:b0:a28:b92e:c226 with SMTP id
 f19-20020a17090624d300b00a28b92ec226mr1173855ejb.59.1704721320298; Mon, 08
 Jan 2024 05:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106222357.23835-1-alchark@gmail.com> <e0302da12345e5539583b2c96d747592@manjaro.org>
In-Reply-To: <e0302da12345e5539583b2c96d747592@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 8 Jan 2024 17:41:48 +0400
Message-ID: <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
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

Hello Dragan,

Thanks a lot for your review and comments! Some reflections below.

On Sun, Jan 7, 2024 at 2:54=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Hello Alexey,
>
> Please see my comments below.
>
> On 2024-01-06 23:23, Alexey Charkov wrote:
> > Include thermal zones information in device tree for rk3588 variants
> > and enable the built-in thermal sensing ADC on RADXA Rock 5B
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 143 ++++++++++++++++++
> >  2 files changed, 147 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index a5a104131403..f9d540000de3 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -772,3 +772,7 @@ &usb_host1_ehci {
> >  &usb_host1_ohci {
> >       status =3D "okay";
> >  };
> > +
> > +&tsadc {
> > +     status =3D "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > index 8aa0499f9b03..8235991e3112 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > @@ -10,6 +10,7 @@
> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> >  #include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/ata/ahci.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >       compatible =3D "rockchip,rk3588";
> > @@ -2112,6 +2113,148 @@ tsadc: tsadc@fec00000 {
> >               status =3D "disabled";
> >       };
> >
> > +     thermal_zones: thermal-zones {
> > +             soc_thermal: soc-thermal {
>
> It should be better to name it cpu_thermal instead.  In the end, that's
> what it is.

The TRM document says the first TSADC channel (to which this section
applies) measures the temperature near the center of the SoC die,
which implies not only the CPU but also the GPU at least. RADXA's
kernel for Rock 5B also has GPU passive cooling as one of the cooling
maps under this node (not included here, as we don't have the GPU node
in .dtsi just yet). So perhaps naming this one cpu_thermal could be
misleading?

> > +                     polling-delay-passive =3D <20>; /* milliseconds *=
/
> > +                     polling-delay =3D <1000>; /* milliseconds */
> > +                     sustainable-power =3D <2100>; /* milliwatts */
>
> These three comments above are pretty much redundant.

Noted, will drop in v2

> > +
> > +                     thermal-sensors =3D <&tsadc 0>;
>
> An empty line should be added here.

Noted, will add in v2

> > +                     trips {
> > +                             threshold: trip-point-0 {
>
> It should be better to name it cpu_alert0 instead, because that's what
> other newer dtsi files already use.

Reflecting on your comments here and below, I'm thinking that maybe it
would be better to define only the critical trip point for the SoC
overall, and then have alerts along with the respective cooling maps
separately for A76-0,1, A76-2,3, A55-0,1,2,3? After all, given that we
have more granular temperature measurement here than in previous RK
chipsets it might be better to only throttle the "offending" cores,
not the full package.

What do you think?

Downstream DT doesn't follow this approach though, so maybe there's
something I'm missing here.

> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             target: trip-point-1 {
>
> It should be better to name it cpu_alert1 instead, because that's what
> other newer dtsi files already use.
>
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             soc_crit: soc-crit {
>
> It should be better to name it cpu_crit instead, because that's what
> other newer dtsi files already use.

Seems to me that if I define separate trips for the three groups of
CPU cores as mentioned above this would better stay as soc_crit, as it
applies to the whole die rather than the CPU cluster alone. Then
'threshold' and 'target' will go altogether, and I'll have separate
*_alert0 and *_alert1 per CPU group.

>> > +                                     /* millicelsius */
> > +                                     temperature =3D <115000>;
> > +                                     /* millicelsius */
>
> These two comments above are pretty much redundant.  It also applies to
> all other similar comments below.

Noted, thanks - will drop all the noise in v2.

> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&target>;
>
> Shouldn't &threshold (i.e. &cpu_alert0) be referenced here instead?
>
> > +                                     cooling-device =3D <&cpu_l0 THERM=
AL_NO_LIMIT THERMAL_NO_LIMIT>;
>
> Shouldn't all big CPU cores be listed here instead?

I guess if a separate trip point is defined for cpu_l0,1,2,3 then it
would need to throttle at 75C, and then cpu_b0,1 and cpu_b2,3 at 85C
each. Logic being that if a sensor stacked in the middle of a group of
four cores shows 75C then one of the four might well be in abnormal
temperature range already (85+), while sensors next to only two big
cores each will likely show temperatures similar to the actual core
temperature.

> > +                                     contribution =3D <1024>;
> > +                             };
> > +                             map1 {
> > +                                     trip =3D <&target>;
>
> Shouldn't &target (i.e. &cpu_alert1) be referenced here instead?
>
> > +                                     cooling-device =3D <&cpu_b0 THERM=
AL_NO_LIMIT THERMAL_NO_LIMIT>;
>
> Shouldn't all little and big CPU cores be listed here instead?
>
> > +                                     contribution =3D <1024>;
> > +                             };
> > +                             map2 {
> > +                                     trip =3D <&target>;
> > +                                     cooling-device =3D <&cpu_b2 THERM=
AL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                                     contribution =3D <1024>;
> > +                             };
>
> Isn't this cooling map redundant?

Will refactor the above, thanks.

> > +                     };
> > +             };
> > +
> > +             bigcore0_thermal: bigcore0-thermal {
> > +                     polling-delay-passive =3D <20>; /* milliseconds *=
/
> > +                     polling-delay =3D <1000>; /* milliseconds */
> > +                     thermal-sensors =3D <&tsadc 1>;
> > +
> > +                     trips {
> > +                             big0_crit: big0-crit {
> > +                                     /* millicelsius */
> > +                                     temperature =3D <115000>;
> > +                                     /* millicelsius */
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             bigcore1_thermal: bigcore1-thermal {
> > +                     polling-delay-passive =3D <20>; /* milliseconds *=
/
> > +                     polling-delay =3D <1000>; /* milliseconds */
> > +                     thermal-sensors =3D <&tsadc 2>;
> > +
> > +                     trips {
> > +                             big1_crit: big1-crit {
> > +                                     /* millicelsius */
> > +                                     temperature =3D <115000>;
> > +                                     /* millicelsius */
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             little_core_thermal: littlecore-thermal {
> > +                     polling-delay-passive =3D <20>; /* milliseconds *=
/
> > +                     polling-delay =3D <1000>; /* milliseconds */
> > +                     thermal-sensors =3D <&tsadc 3>;
> > +
> > +                     trips {
> > +                             little_crit: little-crit {
> > +                                     /* millicelsius */
> > +                                     temperature =3D <115000>;
> > +                                     /* millicelsius */
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             center_thermal: center-thermal {
> > +                     polling-delay-passive =3D <20>; /* milliseconds *=
/
> > +                     polling-delay =3D <1000>; /* milliseconds */
> > +                     thermal-sensors =3D <&tsadc 4>;
> > +
> > +                     trips {
> > +                             center_crit: center-crit {
> > +                                     /* millicelsius */
> > +                                     temperature =3D <115000>;
> > +                                     /* millicelsius */
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             gpu_thermal: gpu-thermal {
> > +                     polling-delay-passive =3D <20>; /* milliseconds *=
/
> > +                     polling-delay =3D <1000>; /* milliseconds */
> > +                     thermal-sensors =3D <&tsadc 5>;
> > +
> > +                     trips {
> > +                             gpu_crit: gpu-crit {
> > +                                     /* millicelsius */
> > +                                     temperature =3D <115000>;
> > +                                     /* millicelsius */
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             npu_thermal: npu-thermal {
> > +                     polling-delay-passive =3D <20>; /* milliseconds *=
/
> > +                     polling-delay =3D <1000>; /* milliseconds */
> > +                     thermal-sensors =3D <&tsadc 6>;
> > +
> > +                     trips {
> > +                             npu_crit: npu-crit {
> > +                                     /* millicelsius */
> > +                                     temperature =3D <115000>;
> > +                                     /* millicelsius */
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +
> >       saradc: adc@fec10000 {
> >               compatible =3D "rockchip,rk3588-saradc";
> >               reg =3D <0x0 0xfec10000 0x0 0x10000>;

