Return-Path: <linux-kernel+bounces-32362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E923835A99
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7351F21D48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8156566B;
	Mon, 22 Jan 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPk/Z4kv"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD335667;
	Mon, 22 Jan 2024 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903044; cv=none; b=ICoKJv956RwEi1o6RI3YDgwpJ1mq1KOFZsN2VyfsE+pUoQOsv/tLrpS0AcfL7pwttMD2Mv1On4FmgIkb+g5aZeek08Qj8w29nNsXR++XVQHi26Iqx5Yrl9hfi6QQeTCAuIH9XBE5GfTKr0Biee3x0wQqrWln0KlLoHUrIn/QHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903044; c=relaxed/simple;
	bh=tp4JlQSpqF7YVv6UlYVYHQprrGoJsNWCQt1u+rfyTqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGwVCoQcUD/L0kQaVtgSO4CkzxFOSGro3fBaEoYhTfd5OHqS+JqWu67CKjrNyMXunWZ87E/f2ccua3Ku5J9ey/wc/SG29OFiuVPgJAsA2mudiO5GsMV0hOQp6pCkaHDViXXl2Rq3KIEN1VaAqYCgg1l2BZGBTgK1NvOLZtAHmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPk/Z4kv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so36071765e9.1;
        Sun, 21 Jan 2024 21:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705903041; x=1706507841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MTYZForVvLZ2hb0Ye49WxTmxEl3DOOa/vhUliBrzGQ=;
        b=mPk/Z4kvxJ7zXvDg3erVc0CwFjbxrL55Gz4bnudcWf/FkzL1G5hQMmeFR+DKQKLqKP
         hyCB8VNRR1ofSkSWWFQRLVLERFFQsFxTXccqf/5p9pz9vBhDxMPBOtmMMMvEV9WXQQyH
         2PKYN3UYe6YswTH2hb60TFklAkaWYt3l9YhN8R/yG1xw2BLWhcfpfE6VLLHsmGAzz1Xx
         0ruJLwEiW+/JcFpvqCSplRLdnC2/NcH5N0EyZi6q/GsSbDBld/lsK33TKGl5QzP2zGyR
         XbckhMb/FiQIN1vEfzREqnd3km771zU8bqIrqFeM9t9aANTHRoCmHQGetqh8WcBoMa4u
         zcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705903041; x=1706507841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MTYZForVvLZ2hb0Ye49WxTmxEl3DOOa/vhUliBrzGQ=;
        b=iiepJEm1pna7XyReFIk4OZb8hPVg9S+6Qf6KL9/gNGwaitkvYgiDI9Ro4ccJOzwJ1b
         50c6p317CX2Nu0ct6xfZJrQZ5WDK/05fWwkR+SbV/w+eWQH4dbzwxKBiS2haYN90Zo9B
         SIULASaG8IqGTFOHTbFheuYMjrUII0gXV1Yp8DNICRtiaE/pHMJkZmQCYyc9YD03pSs3
         3I7oJaMF4n1V8LKGAYl3kgfjkvtZZFEG4tQqxlQ2q3SIYdIBigoGtJTm949iKF9TmQZW
         jPzEqkOybPhygwCmJJlEIhfHnGzoBfYRX3tPt19sEUQDB/ZP7CCeBHq8yor7d9UH1AUn
         SwTQ==
X-Gm-Message-State: AOJu0Ywc95jhskftdXHtLiQ7AR8WU1NMkDMrUI/GW/JBRUgHcW0CA6A2
	rIrxqhkTOBwyPQ1mgmYQrAhym9UOq25c8nfXzgQqPRujWWhlSH+N+ED5Bdxc5F8E2rLQupDSc8B
	aMREFloACMcTvxWbleCNun4b1KvA=
X-Google-Smtp-Source: AGHT+IFGYBIivqZ62ulzHX/smTjXQMJkimNwpt40QKZKF3Q0PXUrtMTpMu7iUstJl6HpzLg6Hcm7DHGwZH6T22Pbz5U=
X-Received: by 2002:a05:600c:290c:b0:40e:6ea4:bf57 with SMTP id
 i12-20020a05600c290c00b0040e6ea4bf57mr2212703wmd.126.1705903040462; Sun, 21
 Jan 2024 21:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106222357.23835-1-alchark@gmail.com> <20240109192608.5981-1-alchark@gmail.com>
 <c517f26c-34bc-4b99-b744-8e2549cd28b5@linaro.org> <CABjd4YxYpsvf+ghHTn1z8TAZxQb-2dFOQaVSm8zHKSSWOokqww@mail.gmail.com>
 <e45f72c2-0b5b-44dd-ad39-e7e5bd17ae26@linaro.org>
In-Reply-To: <e45f72c2-0b5b-44dd-ad39-e7e5bd17ae26@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 22 Jan 2024 09:57:08 +0400
Message-ID: <CABjd4YyL1ZwNOJrWPwZtc7=e4h18a9tQOnuKP6soy=iTHv-WEA@mail.gmail.com>
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

On Mon, Jan 22, 2024 at 4:04=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Alexey,
>
>
> On 21/01/2024 20:57, Alexey Charkov wrote:
> > On Fri, Jan 19, 2024 at 8:21=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > Hello Daniel,
> >
> > Thanks a lot for your review and comments! Please see some reflections =
below.
> >
> >> On 09/01/2024 20:19, Alexey Charkov wrote:
> >>> Include thermal zones information in device tree for rk3588 variants
> >>> and enable the built-in thermal sensing ADC on RADXA Rock 5B
> >>>
> >>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >>> ---
> >>> Changes in v2:
> >>>    - Dropped redundant comments
> >>>    - Included all CPU cores in cooling maps
> >>>    - Split cooling maps into more granular ones utilizing TSADC
> >>>      channels 1-3 which measure temperature by separate CPU clusters
> >>>      instead of channel 0 which measures the center of the SoC die
> >>> ---
> >>>    .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
> >>>    arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 151 ++++++++++++++=
++++
> >>>    2 files changed, 155 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/a=
rm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> index a5a104131403..f9d540000de3 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> @@ -772,3 +772,7 @@ &usb_host1_ehci {
> >>>    &usb_host1_ohci {
> >>>        status =3D "okay";
> >>>    };
> >>> +
> >>> +&tsadc {
> >>> +     status =3D "okay";
> >>> +};
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3588s.dtsi
> >>> index 8aa0499f9b03..8d54998d0ecc 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >>> @@ -10,6 +10,7 @@
> >>>    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> >>>    #include <dt-bindings/phy/phy.h>
> >>>    #include <dt-bindings/ata/ahci.h>
> >>> +#include <dt-bindings/thermal/thermal.h>
> >>>
> >>>    / {
> >>>        compatible =3D "rockchip,rk3588";
> >>> @@ -2112,6 +2113,156 @@ tsadc: tsadc@fec00000 {
> >>>                status =3D "disabled";
> >>>        };
> >>>
> >>> +     thermal_zones: thermal-zones {
> >>> +             /* sensor near the center of the whole chip */
> >>> +             soc_thermal: soc-thermal {
> >>> +                     polling-delay-passive =3D <20>;
> >>
> >> There is no mitigation set for this thermal zone. It is pointless to
> >> specify a passive polling.
> >
> > Indeed, it makes sense to me. There seems to be a catch though in that
> > the driver calls the generic thermal_of_zone_register during the
> > initial probe, which expects both of those polling delays to be
> > present in the device tree, otherwise it simply refuses to add the
> > respective thermal zone, see drivers/thermal/thermal_of.c:502
>
> Usually:
>
> polling-delay-passive =3D <0>;
> polling-delay =3D <0>;
>
> cf:
>
> git grep "polling-delay =3D <0>" arch/arm64/boot/dts

Indeed, thanks a lot for the pointer! Somehow it slipped my attention.
Will test and amend accordingly.

> >>> +                     polling-delay =3D <1000>;
> >>
> >> The driver is interrupt driven. No need to poll.
> >
> > Same here as above
> >
> >>> +                     sustainable-power =3D <2100>;
> >>
> >> There is no mitigation with this thermal zone. Specifying a sustainabl=
e
> >> power does not make sense.
> >
> > Thanks, will drop this in v3!
> >
> >>> +                     thermal-sensors =3D <&tsadc 0>;
> >>> +
> >>> +                     trips {
> >>> +                             soc_crit: soc-crit {
> >>> +                                     temperature =3D <115000>;
> >>> +                                     hysteresis =3D <2000>;
> >>
> >> This trip point leads to a system shutdown / reboot. It is not necessa=
ry
> >> to specify a hysteresis.
> >
> > Similar to the above, the generic thermal_of code refuses to add the
> > trip point if it has no hysteresis property defined (regardless of the
> > trip type), see drivers/thermal/thermal_of.c:109
>
> hysteresis =3D <0>;

Makes sense, thank you! Will amend accordingly.

Best regards,
Alexey

