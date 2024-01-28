Return-Path: <linux-kernel+bounces-41928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5583F9AE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CDC1F21A06
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BEE3BB48;
	Sun, 28 Jan 2024 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9oXllqS"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E452E633;
	Sun, 28 Jan 2024 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472537; cv=none; b=JVu/Tgi5Qvk5oUKCXtHS42Mdbxscke37UJIdXQ1sA2rG58of+bFj14iNywGx6DGLr4L+vJOzGj1dTsCOD5mdfD8EwHtuFtEe+K3xdMytc5m/tq+F5Pb4EsJ2MQv1I+wbGBkSVjWlWnzkSaA7l9wupmrqFyYPMpZaGljgOAK4Cac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472537; c=relaxed/simple;
	bh=0kZcbYb2bPI3GpT2W3oFrJwC0e+CxQQTZjnEcqPUZQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgQIWusEn+CpLF4DJ40P9SDMdJNvZgnDXfTB2ua0MIjbHu1zc+aNE399lMcwfSTTXg8y720J6GoKAhRMhg866IgxWFqY6BQ9f7WGRNrPRghfR3vY5a0KzOzBgReaBC+uEGFHaRsBUtMlbcr92gDDQjfBbuZVPkRGfU5veDVjDQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9oXllqS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso122070a12.0;
        Sun, 28 Jan 2024 12:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706472533; x=1707077333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpcFb9CQUcmE0qw9BfWGbhCG2pDHXS8RAhRX4upBQ/0=;
        b=H9oXllqSUfxbbyc6L7czNAvelVHH59bSm4dloCUl6fw6/uDjbPOFnn7G3xMrhtWkf4
         BmTICtECgGkyfVwUJKvBi+NdyXbyOjg7d8Id/PwPhLNktxmsX0xrDKepRXAETT1i82ve
         6YwJERD3qA8CpyP4kZsT0FHuCLp0Cym+Gt1IZ9txUsWn4Jr0D5VeM94irxHttAkeGCw4
         WcpfrY87Y0OR0Hsoh4L33jMNezwwxqEPI1YAVIWKXJHHniJcu2gmEsPII89wlDD7PytE
         BooBoM0fETWg7Wi276APhyaLTWnpeQ9ySLF8VhHIluvrjQ44deuOsbtKViQLcEEwPEZH
         IJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706472533; x=1707077333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpcFb9CQUcmE0qw9BfWGbhCG2pDHXS8RAhRX4upBQ/0=;
        b=X8He8+NjlJgUhhmkrVl6OpzRztLBOH6o+mVdWBbuQ5pBMYjgTDxmbPCp2AqTxee26Q
         fiN6p5SjT7jn651xMgPEh++MuI/babE9Rj/eWCpB5A2cDbfuQ7DgZAyFKeEoVI5b1gtW
         erUsNammBS9qAXLLCbLxmn4PlnpyA4aOP9CrY2w1Q57MeEAuNUPnnOYdAjDLRVD5YUR1
         tgDaC82idKCR1l4bNMgvpdiFCRbCfKftVpNoeTfxKKjO/ETqcjHYmC2J23yZhJxE8XkU
         mBG+oe9XaBhKQo0RDvPD5M+H5G/hktiYwKIScIp7OM313hiJrd8ireekO+7DQ9QT7uuj
         XDsA==
X-Gm-Message-State: AOJu0YxhZimbjas5RnF3rOSo+GxN4RcbIMIMmUNGQubj69FhVCN9BrZh
	d2dCXFNz/Uv+7lcNMyNtpGQhqHZrxqShJd4hu6/b/XGeig7RqITj6sw+oyhSyaqp8BlG0zD8o2c
	m6ODA8nc8Jxv4ryD+MRIh54q07y4=
X-Google-Smtp-Source: AGHT+IEOEjeCTkeOpSuhG+HjHqJqutXlzhA2zejgtwIdHI9kusmjwwmozj7v/6JbFoiL4ZomYyqtT+oyEnlfzY2Vm0g=
X-Received: by 2002:a17:906:65cf:b0:a31:8b26:47ee with SMTP id
 z15-20020a17090665cf00b00a318b2647eemr2671421ejn.55.1706472533292; Sun, 28
 Jan 2024 12:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-3-5879275db36f@gmail.com> <df062818d21f3318c033859d0e95efc7@manjaro.org>
 <b5b1900a6e309890f449ec91594b8d6c@manjaro.org>
In-Reply-To: <b5b1900a6e309890f449ec91594b8d6c@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 29 Jan 2024 00:08:41 +0400
Message-ID: <CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: enable temperature driven fan
 control on Rock 5B
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 12:27=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Alexey,

Hello Dragan,

> On 2024-01-26 00:13, Dragan Simic wrote:
> > On 2024-01-24 21:30, Alexey Charkov wrote:
> >> This enables thermal monitoring on Radxa Rock 5B and links the PWM
> >> fan as an active cooling device managed automatically by the thermal
> >> subsystem, with a target SoC temperature of 55C
> >>
> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 25
> >> ++++++++++++++++++++++++-
> >>  1 file changed, 24 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> index 9b7bf6cec8bd..c4c94e0b6163 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> @@ -52,7 +52,7 @@ led_rgb_b {
> >>
> >>      fan: pwm-fan {
> >>              compatible =3D "pwm-fan";
> >> -            cooling-levels =3D <0 95 145 195 255>;
> >> +            cooling-levels =3D <0 120 150 180 210 240 255>;
> >>              fan-supply =3D <&vcc5v0_sys>;
> >>              pwms =3D <&pwm1 0 50000 0>;
> >>              #cooling-cells =3D <2>;
> >> @@ -180,6 +180,25 @@ &cpu_l3 {
> >>      cpu-supply =3D <&vdd_cpu_lit_s0>;
> >>  };
> >>
> >> +&package_thermal {
> >> +    polling-delay =3D <1000>;
> >> +
> >> +    trips {
> >> +            package_fan: package-fan {
> >> +                    temperature =3D <55000>;
> >> +                    hysteresis =3D <2000>;
> >> +                    type =3D "active";
> >> +            };
> >> +    };
> >> +
> >> +    cooling-maps {
> >> +            map-fan {
> >> +                    trip =3D <&package_fan>;
> >> +                    cooling-device =3D <&fan THERMAL_NO_LIMIT THERMAL=
_NO_LIMIT>;
> >> +            };
> >> +    };
> >> +};
> >
> > It should be better to have two new trips and two new cooling maps
> > defined, instead of having just one trip/map pair, like this:
> >
> > &package_thermal {
> >       polling-delay =3D <1000>;
> >
> >       trips {
> >               package_warm: package-warm {
> >                       temperature =3D <55000>;
> >                       hysteresis =3D <2000>;
> >                       type =3D "active";
> >               };
> >
> >               package_hot: package-hot {
> >                       temperature =3D <65000>;
> >                       hysteresis =3D <2000>;
> >                       type =3D "active";
> >               };
> >       };
> >
> >       cooling-maps {
> >               mapX {
> >                       trip =3D <&package_warm>;
> >                       cooling-device =3D <&fan THERMAL_NO_LIMIT 1>;
> >               };
> >
> >               mapY {
> >                       trip =3D <&package_hot>;
> >                       cooling-device =3D <&fan 2 THERMAL_NO_LIMIT>;
> >               };
> >       };
> > };
> >
> > The idea behind this approach is to keep the fan spinning at the lowest
> > available speed until the package temperature reaches the second trip's
> > temperature level, at which point the fan starts ramping up.  An
> > approach
> > like this is already employed by the Pine64 RockPro64 SBC.
> >
> > This way, we'll be doing our best to keep the fan noise down;  of
> > course,
> > it will depend on the particular heatsink and fan combo how long the
> > fan
> > can be kept at the lowest speed, but we should aim at supporting as
> > many
> > different cooling setups as possible, and as well as possible, out of
> > the
> > box and with no additional tweaking required.
> >
> > Please notice "mapX" and "mapY" as the names of the additional cooling
> > maps,
> > where X and Y are simply the next lowest available indices, which is
> > pretty
> > much the usual way to name the additional cooling maps.
>
> Just checking, have you seen this?  Quite a few messages were exchanged
> on the same day, so just wanted to make sure you didn't miss this one.

Yes, thank you for pointing it out and following up.

I've been testing different setups to get my thoughts together on this
one. Long story short, your suggested setup indeed makes the system
quieter most of the time while still being safely far from hitting the
throttling threshold, though it appears that the main influence is
from the higher temperature value in the second trip (after which the
fan accelerates) rather than from the presence of the first trip and
the corresponding cooling map capped at the minimum-speed fan action.

In my observation, the system rarely crosses the 55C threshold under
partial load, and when the load is high (e.g. compiling stuff with 8
concurrent jobs) it takes ~2 seconds to go from below the first trip
point to above the second trip point, so the fan doesn't really get
the chance to stay at its leisurely first state.

So frankly I'm inclined to leave one trip point here, and simply
change its temperature threshold from 55C to 65C - just to keep it
simple.

What do you think?

Best regards,
Alexey

