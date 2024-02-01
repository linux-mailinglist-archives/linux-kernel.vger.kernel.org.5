Return-Path: <linux-kernel+bounces-48750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC98460C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72111F26F57
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3B85274;
	Thu,  1 Feb 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3QGX0FS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05E84FAC;
	Thu,  1 Feb 2024 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814944; cv=none; b=FKjuiO93JiEMgQ1NVKZnV8g2M636yRSl1WHBGRoXREss7tN2NKqoD4QtZ8l/rtb7WV/b2yMlVj0ogROlVL/mW8jjPMRBDfigOXztrxn1o2I5jewgigA1qj0jgvFMNfmZ5mowOSINqUHvFQVYuRo7GUY3agV5Dm8PDzS0i/rJQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814944; c=relaxed/simple;
	bh=RyCAyIobUR4W5nP36+wkjusLA4nQx4LLwnCyj36xkhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtEv8YqF36WYIFdkEP4QTfiN9swPFeMY+AG2qnBejBHQ29ZlNrAueYJIZfwRJ1JQkvqhzePTLDVsvC5Vmwroz0V/MHdVWMx/5Cil0UNMOIpry/Wa331wfnUyC6GP5tW9ue+jSS+DqpFGDA1Tuk1ua7S7CwZXUmkvarhWoTIvZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3QGX0FS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a364b5c5c19so221730266b.1;
        Thu, 01 Feb 2024 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814941; x=1707419741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jI8uqnU2Vc4rvU4x/h8F0oStlnQZndU9gGWlOQPijbk=;
        b=A3QGX0FSIK3jECWZNmz092KaqfTgW1yVP3YPQVd9y77kmo3vOsmyHYgb0CVu0bydWR
         lkDF9FOLhfALne+2mndp/0oIMY56GPE1h2e4JWVGkCHci+IFTweFlulNVGKTqbgPnHlK
         AlNurGTJYyKBclWaaf6fz0tJsDmAn/0xpBHy8HTnUOtoP6cscEmT9IOQs2naxW50U9lE
         DEhYJekCU9npJeL9mDnPZRsirZtiQ30Ga6ZCCyl7z1Eg3KtB0TBjOQppdkCxeG04sCZN
         j15vKllUBhBySJEar4PPgrRngsSBtakfjw9T/h0fwFF6kXmzuxDJoqa1eXK9R/77neBu
         d5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814941; x=1707419741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jI8uqnU2Vc4rvU4x/h8F0oStlnQZndU9gGWlOQPijbk=;
        b=TOM766Gu4gW9kK8TuW+R1Al2exMDxidduI+TDdo8K4Aa3vG5sCkixgLPy3MGD4ZvIn
         8b9d//x7+GuqCx6snMkSosquoaItWXrEezP3NZuoHAJ58dcHALa8QQFwJ3WHbBn6zOij
         L+IV3OC6l7OwYal48bjxS0WqMOCCGjQiRQZeuaGVB/9x8U61Ez8BA7m1qX9oAbh+BKZb
         cWcEGoyWGNc/g0kweAa3OJ3gxK2q12UNAD+uvKt2KJiy31uIaPEmyX0b3QLvzuLut5zD
         nW0I2QpQlNUYTgxBQRM2eMECBCZsTCrgvjctL1eywk/5hxjhjcBu1OSPNrEp4Foxhv3A
         S6Ng==
X-Gm-Message-State: AOJu0YyKOsHO6dJJ8+bAl8EKbVT8EXHH/QdWmPF6MkoZlej0ARCKUAVl
	Lt8MRdICnj5pRH+5hHuGlcvSdm20VcbMm6fqqfvvsqu0ciYaMzpvmQpvbrVLivHAQXZpBcqiu5A
	ah76D6XYjy6hhBFDmDlZI1bXllFU=
X-Google-Smtp-Source: AGHT+IGGH+Ad9eE65DLXqQRZjO0osYEVlcM/foILFZ83ZPaRmyt1ORRANDxBS6dKp82WDLeBewFcVgRL7/tu6Os6dws=
X-Received: by 2002:a17:906:3082:b0:a36:f42f:83a3 with SMTP id
 2-20020a170906308200b00a36f42f83a3mr186494ejv.41.1706814940618; Thu, 01 Feb
 2024 11:15:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com> <CAGb2v65--rgb2FqmG_0-w1-jUL0odqKXxiZJ-XPYA4uomfYmaQ@mail.gmail.com>
 <5e3e12d65e4919372e7fb02d56202393@manjaro.org>
In-Reply-To: <5e3e12d65e4919372e7fb02d56202393@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 1 Feb 2024 23:15:28 +0400
Message-ID: <CABjd4Yx0kQ67fScrFVavjObMLaNt_PJ3TVOhLpCmj00Dx9dOqA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: rockchip: enable temperature driven
 fan control on Rock 5B
To: Dragan Simic <dsimic@manjaro.org>
Cc: wens@kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 9:34=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Hello Chen-Yu,
>
> On 2024-02-01 15:26, Chen-Yu Tsai wrote:
> > On Wed, Jan 31, 2024 at 2:22=E2=80=AFAM Alexey Charkov <alchark@gmail.c=
om>
> > wrote:
> >>
> >> This enables thermal monitoring on Radxa Rock 5B and links the PWM
> >> fan as an active cooling device managed automatically by the thermal
> >> subsystem, with a target SoC temperature of 65C and a minimum-spin
> >> interval from 55C to 65C to ensure airflow when the system gets warm
> >>
> >> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 34
> >> ++++++++++++++++++++++++-
> >>  1 file changed, 33 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> index a0e303c3a1dc..b485edeef876 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> @@ -52,7 +52,7 @@ led_rgb_b {
> >>
> >>         fan: pwm-fan {
> >>                 compatible =3D "pwm-fan";
> >> -               cooling-levels =3D <0 95 145 195 255>;
> >> +               cooling-levels =3D <0 120 150 180 210 240 255>;
> >>                 fan-supply =3D <&vcc5v0_sys>;
> >>                 pwms =3D <&pwm1 0 50000 0>;
> >>                 #cooling-cells =3D <2>;
> >> @@ -173,6 +173,34 @@ &cpu_l3 {
> >>         cpu-supply =3D <&vdd_cpu_lit_s0>;
> >>  };
> >>
> >> +&package_thermal {
> >> +       polling-delay =3D <1000>;
> >> +
> >> +       trips {
> >> +               package_fan0: package-fan0 {
> >> +                       temperature =3D <55000>;
> >> +                       hysteresis =3D <2000>;
> >> +                       type =3D "active";
> >> +               };
> >> +               package_fan1: package-fan1 {
> >> +                       temperature =3D <65000>;
> >> +                       hysteresis =3D <2000>;
> >> +                       type =3D "active";
> >> +               };
> >> +       };
> >> +
> >> +       cooling-maps {
> >> +               map0 {
> >> +                       trip =3D <&package_fan0>;
> >> +                       cooling-device =3D <&fan THERMAL_NO_LIMIT 1>;
> >> +               };
> >> +               map1 {
> >> +                       trip =3D <&package_fan1>;
> >> +                       cooling-device =3D <&fan 1 THERMAL_NO_LIMIT>;
> >> +               };
> >> +       };
> >> +};
> >> +
> >>  &i2c0 {
> >>         pinctrl-names =3D "default";
> >>         pinctrl-0 =3D <&i2c0m2_xfer>;
> >> @@ -731,6 +759,10 @@ regulator-state-mem {
> >>         };
> >>  };
> >>
> >> +&tsadc {
> >> +       status =3D "okay";
> >> +};
> >> +
> >
> > Is there any reason this can't be enabled by default in the .dtsi file?
> > The thermal sensor doesn't depend on anything external, so there should
> > be no reason to push this down to the board level.
>
> Actually, there is a reason.  Different boards can handle the critical
> overheating differently, by letting the CRU or the PMIC handle it.  This
> was also the case for the RK3399.
>
> Please, have a look at the following DT properties, which are consumed
> by drivers/thermal/rockchip_thermal.c:
>    - "rockchip,hw-tshut-mode"
>    - "rockchip,hw-tshut-polarity"
>
> See also page 1,372 of the RK3588 TRM v1.0.
>
> This has also reminded me to check how is the Rock 5B actually wired,
> just to make sure.  We actually need to provide the two DT properties
> listed above, at least to avoid emitting the warnings.

Well the defaults are already provided in rk3588s.dtsi, so there won't
be any warnings (see lines 2222-2223 in Linus' master version), and
according to the vendor kernel those are also what Rock 5B uses.

This made me think however: what if a board doesn't enable TSADC, but
has OPPs in place for higher voltage and frequency states? There won't
be any throttling (as there won't be any thermal monitoring) and there
might not be a critical shutdown at all if it heats up - possibly even
causing hardware damage. In this case it seems that having TSADC
enabled by default would at least trigger passive cooling, hopefully
avoiding the critical shutdown altogether and making those properties
irrelevant in 99% cases.

Best regards,
Alexey

