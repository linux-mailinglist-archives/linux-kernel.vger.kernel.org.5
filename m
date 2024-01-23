Return-Path: <linux-kernel+bounces-35992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A538399D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D8528E154
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0D82D77;
	Tue, 23 Jan 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPPUwHPc"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262081207;
	Tue, 23 Jan 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039294; cv=none; b=CYmRoyltc+xgCMIbdtiCtpOESn5onYSHO556olqA7woMMeLgkoDb4rNkC3++R3izPtxjJ2Q/QQOVpBNuD/xepUNaM6V7hME2JesHO+P9P6cos8vJKrtknYGbCmU722Ox2QrwK2QV+WeQA0Bzk6ElymPguYkUWQn36czrfOyhhSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039294; c=relaxed/simple;
	bh=dIt5Io/oxapQTL0cgujU3110DTiODpzJbHKjZUEISms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBx4DHkbP08Tdn1u5a0VOIblN5R9CdDN2mFpWWBWaVXJXvBPpuBZ8PttbmdQoDrD9oW8BKOoxc4gAdYm8xINi04yOm3gXgwVe325ZrU0xJh2LGRnse2ts2Gll50X/tw20qYhKPCba54Wk17m8+5ybTuj04++eZI3XIX6XCkwb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPPUwHPc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a310f4b3597so2190366b.3;
        Tue, 23 Jan 2024 11:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706039290; x=1706644090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErC+/ZkGQ3Loz8EHkG675aqy4eM2oDlUc1hoqX6MvnU=;
        b=mPPUwHPcR5gZl2nX/Kg7R7LZHaRC0Vuh8qjR9lcwq9zy0IrdRM2FYjLhxcsuXk1Vix
         2008tVIhyAqUltRsaD5SU3//SAKkEyuG+bNLSI+DL3cu84TDvHy5TSObNvMgboInFCcO
         4lVizO06g6VMBlWrOahoxTBVBPVcoMO9jpEyHp2eo1EE7smjCmSSXOzRES9uqOESgSCE
         vCY8fTeENMSJSQdnfCZn5GBSd3a5MR0i2Tvni3YOm0lSNmldXeI3DMqqT8IQDlnQRDPt
         utnj6tbJKc3AW8fzPHBOWj26iS2CJbQyCLEZdFRSXpFiVv4/Yv++laj0QDo+44m9ruc1
         otIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039290; x=1706644090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErC+/ZkGQ3Loz8EHkG675aqy4eM2oDlUc1hoqX6MvnU=;
        b=oLZbwgsBPCN0ofzIyYCTw7LKhz4KX2ZubtgOn4gn+Ps4SfTLp9SDegbY+XfW98+h+i
         WRjifXU0vjv/q7x2dNn6511cg/xHmKIQoKbkMLrcqKX9wiR820xeToBSCVfGhb7V2YzC
         CM75xJ3LIDCFi9QKXOJ07CbwEVX35tfN287kqVeXKcw0aQfGaDF1xNf7OdkUu0BrfeOO
         Bl4kBHMVdEU3bqQ/XGcLNc/Ns/nTdf3Q9o9LMDtWUYCLvf0Un2HYi2bkrLlTZcOHLlsU
         bopxGzCyNA8UJWx1beeBt38iv3JzZ9LcKt84NleOxJIQSS2T9+O/SH2aUzamEi2QJMnl
         +dWA==
X-Gm-Message-State: AOJu0Yy0Px0xJWxTRb/6MBkpyE02CwArYFLY/G/G/hUUhWJPM7SipxR4
	duB9JR+Ln/miRIEbLbKv5rtE0gSlg3zRlc6QD3TUcs1emgPjsO0bjN/OQ7zMZU2dEvumCMZSut2
	3Ad72fv0Qb5hGcI0OqezM6+9SP48=
X-Google-Smtp-Source: AGHT+IE7Xa6EaS2tw064//+LZ0qIXqlD517DZIOrh7h8y20z6YIfE+YprQ29Rceyk9ATcFsNARKzeKKgO+oMWPo76YI=
X-Received: by 2002:a17:907:a642:b0:a2c:dfa:4f7 with SMTP id
 vu2-20020a170907a64200b00a2c0dfa04f7mr327771ejc.82.1706039290312; Tue, 23 Jan
 2024 11:48:10 -0800 (PST)
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
Date: Tue, 23 Jan 2024 23:47:58 +0400
Message-ID: <CABjd4Yz+tqaS38B9uRUZC2nz_VeZ-Db6BpF5oWL3ahmskfbTMA@mail.gmail.com>
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

For some reason when I have both polling-delay-passive and
polling-delay set to 0, the active cooling map I have in my board DT
(using a PWM controlled fan) behaves weirdly.

I use the following fragment in my board DTS:

+&package_thermal {
+       trips {
+               package_fan: package-fan {
+                       temperature =3D <55000>;
+                       hysteresis =3D <2000>;
+                       type =3D "active";
+               };
+       };
+
+       cooling-maps {
+               map-fan {
+                       trip =3D <&package_fan>;
+                       cooling-device =3D <&fan THERMAL_NO_LIMIT
THERMAL_NO_LIMIT>;
+               };
+       };
+};

If I add polling-delay =3D <1000>; at the top, the fan speeds up and
down dynamically as the package temperature swings around 55C. If I
remove that (having set polling-delay =3D <0>; in rk3588s.dtsi), the fan
speeds up to the midpoint cooling state once the package temperature
approaches 55C, and then it just stays there forever: it doesn't speed
up above the midpoint even as the temperature climbs above 70C, nor
does it spin down as it falls back to around 45C.

Is that the expected behavior for when the polling is disabled?

I haven't yet studied in detail if passive cooling kicks in correctly
with polling disabled, but this behavior with active cooling left me
quite confused - any pointers would be much appreciated.

Thanks a lot,
Alexey

