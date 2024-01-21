Return-Path: <linux-kernel+bounces-32170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041D48357A4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D1B281CCA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AEF383A7;
	Sun, 21 Jan 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD+yhH89"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78040182DC;
	Sun, 21 Jan 2024 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705867094; cv=none; b=EzJEG8mrtueslyZvBtyLbT3VLimtseQa2hkYHEjNIpezCTtW/Cpvb80X926CbtxkJoabKl9X8yydLvOiEYOdm/jeOJDt5vLzS/2QbQiBjIgP1GocS0OkihMT8K6X2XJH4q5xAt2Uv3aN+C8+xbpdv56meu2KzVOMgoBkfVl8gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705867094; c=relaxed/simple;
	bh=b+7Bh3lzNYG8i8zMid2dE2fci4YL0eLAJ4fJqNACR2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKnj/Hlx/hycGT5Zaq3K48s/L/TYJ0Q9kwuQwiDTR94k+U23nObOIQTWtWeL86DyJJotDgD/XtA0aff55WsaUZUNB7szDfGESGTaCDIQYImJNUegqpR4Sqw9RtzsV+rwJVv0XALFPrMZUTo8lJ/zsS081T8OaqXvBN1CtuYT8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD+yhH89; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26fa294e56so243600366b.0;
        Sun, 21 Jan 2024 11:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705867090; x=1706471890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAbQEDdwZsefO9D8MBU/Wh50sFP9LP0OeG4eEpAp404=;
        b=VD+yhH896mlzoC9/5aLXDTewbDF25MYTnylfe/08UXsofS0vkLE2DpV0Xv4/c1uNR9
         qJMa4mb5BZLKhrKHmlDtEOuGmOcahorW1l0onEgrm6Z+w8nRvPR979C0jYnvjMN5v6nY
         1VBbRPz3cVz6LU6nhbCM+4qCqlIY7sJJWnolD3bMxZiOInxOwa191kZIbR7gWUMol9uG
         zvx5IPaFyOYjTA0BarGGTj7BmSGydnwP0YExdm+7dXXAolm6eoJvWtTVjX1ru4TGNvIw
         lGCSvTdni2p13Tqi1aTmpIdoGywXQn93Geey8ZOBAotSEPWd/dnnrfe+Exxpe7/pKnWL
         +n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705867090; x=1706471890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAbQEDdwZsefO9D8MBU/Wh50sFP9LP0OeG4eEpAp404=;
        b=Jguzc+OhSdW2r6TqLNG/lPHWT5TRHMS7BaysTguF3Lt0qxWvh7eXkHdORbWdErd881
         Utcgs8bnAMl9nBgpWvDzzS+VGsB/irUIPg+pX59QEhntwhoANfY5SbWV9d+ver09Gc/j
         B7q0Jzq4JaxxtrW1lMbqCmceOmW/fDbDIkmN6YyUc/mgVW/CeBuo++QSKmc5rhKZxCtz
         /3zRLE1isW/AqQDaBZc72ZsJn3goBajpFK5L3CAd3N817l9uWDC6p3VK4hrg2QmIMoJX
         j8pbIhTG+mQVK5TKTaNXm9oecuTp77jy62gfK+Fw7CkZXrtPs5dzbgjuWM1HWK+poont
         Q/4A==
X-Gm-Message-State: AOJu0Yy9gwmNpSfpeZoaiENDd6bkSHP/9WRdovKc33SFZr1zRt+f6PfI
	xwS+Bm04IShHdkbtCAwLOqs1n3tIZsDIsE1hOuRm+xSnIKDg5QOrv8uDGppbKJOe/8kwcp93Qpg
	QSFf53Gm1v/Jy4NRjKtwCV9NMe6w=
X-Google-Smtp-Source: AGHT+IFAB701dJZ0Vxsg39wC+sKGpZzi4at9ikNgixHnT4wOU6IVvrCQEVtymp3cVHsHzzUsMeRc+pitO0uPv3yt37k=
X-Received: by 2002:a17:906:6852:b0:a2f:62c3:5322 with SMTP id
 a18-20020a170906685200b00a2f62c35322mr1924685ejs.120.1705867090551; Sun, 21
 Jan 2024 11:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106222357.23835-1-alchark@gmail.com> <20240109192608.5981-1-alchark@gmail.com>
 <c517f26c-34bc-4b99-b744-8e2549cd28b5@linaro.org>
In-Reply-To: <c517f26c-34bc-4b99-b744-8e2549cd28b5@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Sun, 21 Jan 2024 23:57:58 +0400
Message-ID: <CABjd4YxYpsvf+ghHTn1z8TAZxQb-2dFOQaVSm8zHKSSWOokqww@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Christopher Obbard <chris.obbard@collabora.com>, =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <szucst@iit.uni-miskolc.hu>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Kever Yang <kever.yang@rock-chips.com>, 
	Jagan Teki <jagan@edgeble.ai>, Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 8:21=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
Hello Daniel,

Thanks a lot for your review and comments! Please see some reflections belo=
w.

> On 09/01/2024 20:19, Alexey Charkov wrote:
> > Include thermal zones information in device tree for rk3588 variants
> > and enable the built-in thermal sensing ADC on RADXA Rock 5B
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> > Changes in v2:
> >   - Dropped redundant comments
> >   - Included all CPU cores in cooling maps
> >   - Split cooling maps into more granular ones utilizing TSADC
> >     channels 1-3 which measure temperature by separate CPU clusters
> >     instead of channel 0 which measures the center of the SoC die
> > ---
> >   .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
> >   arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 151 +++++++++++++++++=
+
> >   2 files changed, 155 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm=
64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index a5a104131403..f9d540000de3 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -772,3 +772,7 @@ &usb_host1_ehci {
> >   &usb_host1_ohci {
> >       status =3D "okay";
> >   };
> > +
> > +&tsadc {
> > +     status =3D "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boo=
t/dts/rockchip/rk3588s.dtsi
> > index 8aa0499f9b03..8d54998d0ecc 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > @@ -10,6 +10,7 @@
> >   #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> >   #include <dt-bindings/phy/phy.h>
> >   #include <dt-bindings/ata/ahci.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >   / {
> >       compatible =3D "rockchip,rk3588";
> > @@ -2112,6 +2113,156 @@ tsadc: tsadc@fec00000 {
> >               status =3D "disabled";
> >       };
> >
> > +     thermal_zones: thermal-zones {
> > +             /* sensor near the center of the whole chip */
> > +             soc_thermal: soc-thermal {
> > +                     polling-delay-passive =3D <20>;
>
> There is no mitigation set for this thermal zone. It is pointless to
> specify a passive polling.

Indeed, it makes sense to me. There seems to be a catch though in that
the driver calls the generic thermal_of_zone_register during the
initial probe, which expects both of those polling delays to be
present in the device tree, otherwise it simply refuses to add the
respective thermal zone, see drivers/thermal/thermal_of.c:502

> > +                     polling-delay =3D <1000>;
>
> The driver is interrupt driven. No need to poll.

Same here as above

> > +                     sustainable-power =3D <2100>;
>
> There is no mitigation with this thermal zone. Specifying a sustainable
> power does not make sense.

Thanks, will drop this in v3!

> > +                     thermal-sensors =3D <&tsadc 0>;
> > +
> > +                     trips {
> > +                             soc_crit: soc-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <2000>;
>
> This trip point leads to a system shutdown / reboot. It is not necessary
> to specify a hysteresis.

Similar to the above, the generic thermal_of code refuses to add the
trip point if it has no hysteresis property defined (regardless of the
trip type), see drivers/thermal/thermal_of.c:109

> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between A76 cores 0 and 1 */
> > +             bigcore0_thermal: bigcore0-thermal {
> > +                     polling-delay-passive =3D <20>;
> > +                     polling-delay =3D <1000>;
>
> The driver is interrupt driven. No need to poll.
>
> > +                     thermal-sensors =3D <&tsadc 1>;
> > +
> > +                     trips {
> > +                             bigcore0_alert: bigcore0-alert {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             bigcore0_crit: bigcore0-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&bigcore0_alert>;
> > +                                     cooling-device =3D
> > +                                             <&cpu_b0 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_b1 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> > +                                     contribution =3D <1024>;
>
> If you specify the contribution, that means it is expected to use the
> IPA governor. However, this one needs an extra trip point before 'alert'
> to begin collecting temperatures in order to initialize the PID loop of
> the IPA.

Thank you! Will add extra passive cooling trip points at 75C to all
three CPU clusters.

Best regards,
Alexey

