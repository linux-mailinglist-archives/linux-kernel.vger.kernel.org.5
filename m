Return-Path: <linux-kernel+bounces-49963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4075784721F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4F6B26582
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9706C46B98;
	Fri,  2 Feb 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajj968zZ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7DF145334;
	Fri,  2 Feb 2024 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884978; cv=none; b=O9XuYJq8W/l6wkJcJRrA+UHHHeqwg3EbkfIn34i+aq/Q5MIcO9UiNIlPN3EOgFSaUJkLxhA5cw0gvSAcnzsP69OHiYUyNMclTe3hQrIsSFORIPMiYuVA9IVVSmjKlBzWcx+WauR8jfYy7rbtXKWSvsjPj57FFrCWa4jEUnCf5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884978; c=relaxed/simple;
	bh=Skl0uNsAfIqnGfpunFUR+l+xqfAMlFPfSnT85gXQXn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPOhQJai4IHXUeQaf6kJd56AHwOPGyIy0PYY8gGxgrIr/De6Ntt9rskDAlorZpXM0sPQg/gEGH7IkCbr6/QdSk1VQVBUNcK4b6+qxGGb0hK97feShHei1IavmqOdI/UROCmJa4PAdRauYhalQKDwxXMiOn9KjjZAI2lhz8cLj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajj968zZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a354fc17f24so281443866b.0;
        Fri, 02 Feb 2024 06:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706884975; x=1707489775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFAaQtnlWIpYNCTfSJwnfI9Pa1J9XaJ9vd8HlS5BD0g=;
        b=Ajj968zZcOT1V2l6N8zVWbD8B0i/a9Byzx8lBtN6HSa56qC1lurToDp7pSxu9mG68/
         qCzUJAuHVn2OXoMD+Bd8y93lla2QRpNVPqkuAtisr+WmYm5bABf8nwyxcctyQnxwjCxZ
         ukOr036j92mmpwpkgNh6WUC/Evg5c7ARkQMX5ALacIeJHajcNbbLBEnbZ4MOcljSv0Uj
         n0ImNtgCCoiEniz/j0lHzy/dYhiLunYGjs2ZgLvLLNYf/BFerfBxdhZAUZ+5BWvaZSeW
         U8+nk0BZ2U5Vhto1dakCoKS6p4KP0ZZJeRrIte9ogX8kOHdvN6bNUR44jMT4xcO0YOoT
         1lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706884975; x=1707489775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFAaQtnlWIpYNCTfSJwnfI9Pa1J9XaJ9vd8HlS5BD0g=;
        b=mIkKaljF/eDGut6SrUqOR3FwhvqM/xA8n2UTbiG3ZI6v+NZ2TnsK00NzMWTaBxib09
         HlvZIAoU9W06gcBYmzElayFQ7vfjcwTiB+7Vt+ukj5sOah55RoLaNbxub1uvE/+yeh6U
         cXWZWjPRTLT4+O/s8OM0xZpIzfD25hxDP9HwXFFyWNAMVVeaRcsiYbKxV9do2eRv34Pe
         FHy+87cSxk/T1IEF0qV/Ijhws49zOSOENO9wvg+BSULi/PXHj6ULmJjG4raXd+XNp3Oj
         WFqO+GneFGuoN4b6Ew/nyRvERNgdvj2JOeYytxt2EScygX/XtI6KK4pm+JoWiFTz0qCV
         HVuQ==
X-Gm-Message-State: AOJu0YyvC1m+YuurxxDFmp1us2ULr3xTUA2WmxFqmEEFkriDNmQ07Ea7
	8twuj0pMe2t1eFaqrpob17EUos6VuNdQw6F9+EDRnjoSMAIGC1us9o6JblkVxZS1szG6Xcqgwdv
	nXZN5gA24AYH9ISJyxB8MnynieHE=
X-Google-Smtp-Source: AGHT+IFXc9CbCMbG0P1xkr7bGxDOS5NAA5dEWhpmpCM29j0rfVYYLcY+C4KdkWt3VeStlnk5oln8ereDmQ/lQXbimeU=
X-Received: by 2002:a17:906:ae9a:b0:a36:5079:d6cb with SMTP id
 md26-20020a170906ae9a00b00a365079d6cbmr4184988ejb.56.1706884974435; Fri, 02
 Feb 2024 06:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com> <CAGb2v65--rgb2FqmG_0-w1-jUL0odqKXxiZJ-XPYA4uomfYmaQ@mail.gmail.com>
 <5e3e12d65e4919372e7fb02d56202393@manjaro.org> <CABjd4Yx0kQ67fScrFVavjObMLaNt_PJ3TVOhLpCmj00Dx9dOqA@mail.gmail.com>
 <a8aa04ca0061cd09c7b3eb5336e534a4@manjaro.org> <bd6e93cf907572e86697dc10a50bfe66@manjaro.org>
In-Reply-To: <bd6e93cf907572e86697dc10a50bfe66@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 2 Feb 2024 18:42:42 +0400
Message-ID: <CABjd4Yy0HYFEdW-XA4vmX4aMhCS-fKd7X_f=ar3qcm_4ROxk1A@mail.gmail.com>
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

On Thu, Feb 1, 2024 at 11:43=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-02-01 20:31, Dragan Simic wrote:
> > On 2024-02-01 20:15, Alexey Charkov wrote:
> >> On Thu, Feb 1, 2024 at 9:34=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>
> >> wrote:
> >>> On 2024-02-01 15:26, Chen-Yu Tsai wrote:
> >>> > On Wed, Jan 31, 2024 at 2:22=E2=80=AFAM Alexey Charkov <alchark@gma=
il.com>
> >>> > wrote:
> >>> >>
> >>> >> This enables thermal monitoring on Radxa Rock 5B and links the PWM
> >>> >> fan as an active cooling device managed automatically by the therm=
al
> >>> >> subsystem, with a target SoC temperature of 65C and a minimum-spin
> >>> >> interval from 55C to 65C to ensure airflow when the system gets wa=
rm
> >>> >>
> >>> >> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >>> >> ---
> >>> >>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 34
> >>> >> ++++++++++++++++++++++++-
> >>> >>  1 file changed, 33 insertions(+), 1 deletion(-)
> >>> >>
> >>> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> >> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> >> index a0e303c3a1dc..b485edeef876 100644
> >>> >> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> >> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> >> @@ -52,7 +52,7 @@ led_rgb_b {
> >>> >>
> >>> >>         fan: pwm-fan {
> >>> >>                 compatible =3D "pwm-fan";
> >>> >> -               cooling-levels =3D <0 95 145 195 255>;
> >>> >> +               cooling-levels =3D <0 120 150 180 210 240 255>;
> >>> >>                 fan-supply =3D <&vcc5v0_sys>;
> >>> >>                 pwms =3D <&pwm1 0 50000 0>;
> >>> >>                 #cooling-cells =3D <2>;
> >>> >> @@ -173,6 +173,34 @@ &cpu_l3 {
> >>> >>         cpu-supply =3D <&vdd_cpu_lit_s0>;
> >>> >>  };
> >>> >>
> >>> >> +&package_thermal {
> >>> >> +       polling-delay =3D <1000>;
> >>> >> +
> >>> >> +       trips {
> >>> >> +               package_fan0: package-fan0 {
> >>> >> +                       temperature =3D <55000>;
> >>> >> +                       hysteresis =3D <2000>;
> >>> >> +                       type =3D "active";
> >>> >> +               };
> >>> >> +               package_fan1: package-fan1 {
> >>> >> +                       temperature =3D <65000>;
> >>> >> +                       hysteresis =3D <2000>;
> >>> >> +                       type =3D "active";
> >>> >> +               };
> >>> >> +       };
> >>> >> +
> >>> >> +       cooling-maps {
> >>> >> +               map0 {
> >>> >> +                       trip =3D <&package_fan0>;
> >>> >> +                       cooling-device =3D <&fan THERMAL_NO_LIMIT =
1>;
> >>> >> +               };
> >>> >> +               map1 {
> >>> >> +                       trip =3D <&package_fan1>;
> >>> >> +                       cooling-device =3D <&fan 1 THERMAL_NO_LIMI=
T>;
> >>> >> +               };
> >>> >> +       };
> >>> >> +};
> >>> >> +
> >>> >>  &i2c0 {
> >>> >>         pinctrl-names =3D "default";
> >>> >>         pinctrl-0 =3D <&i2c0m2_xfer>;
> >>> >> @@ -731,6 +759,10 @@ regulator-state-mem {
> >>> >>         };
> >>> >>  };
> >>> >>
> >>> >> +&tsadc {
> >>> >> +       status =3D "okay";
> >>> >> +};
> >>> >> +
> >>> >
> >>> > Is there any reason this can't be enabled by default in the .dtsi f=
ile?
> >>> > The thermal sensor doesn't depend on anything external, so there sh=
ould
> >>> > be no reason to push this down to the board level.
> >>>
> >>> Actually, there is a reason.  Different boards can handle the
> >>> critical
> >>> overheating differently, by letting the CRU or the PMIC handle it.
> >>> This
> >>> was also the case for the RK3399.
> >>>
> >>> Please, have a look at the following DT properties, which are
> >>> consumed
> >>> by drivers/thermal/rockchip_thermal.c:
> >>>    - "rockchip,hw-tshut-mode"
> >>>    - "rockchip,hw-tshut-polarity"
> >>>
> >>> See also page 1,372 of the RK3588 TRM v1.0.
> >>>
> >>> This has also reminded me to check how is the Rock 5B actually wired,
> >>> just to make sure.  We actually need to provide the two DT properties
> >>> listed above, at least to avoid emitting the warnings.
> >>
> >> Well the defaults are already provided in rk3588s.dtsi, so there won't
> >> be any warnings (see lines 2222-2223 in Linus' master version), and
> >> according to the vendor kernel those are also what Rock 5B uses.
> >
> > Yes, I noticed the same a couple of minutes after sending my last
> > message, but didn't want to make more noise about it. :)  I would've
> > mentioned it in my next message, of course.
>
> Just checked the Rock 5B schematic and it expects the CRU to be used
> to perform the hardware reset in case of a thermal runaway, so the
> defaults in the RK3588s dtsi are fine.  I had to double-check it. :)

I've just looked at Rock 5B, Rock 5A and NanoPC T6 schematics, and
they all seem to have the TSADC_SHUT line connected to RESET_L. At the
same time, Radxa's device tree uses the default CRU-based option. To
me this seems to imply that the CRU option should always work, by the
virtue of CRU being on-chip. At the same time, if the right GPIOs are
wired to the PMIC reset line for a particular board, the board may
also choose to use the GPIO option - or stick with CRU.

If that interpretation is correct, then I suggest we enable TSADC by
default in the .dtsi, and let it handle both throttling and CRU-based
critical resets on all boards. Those who know what they are doing may
then elect to switch their board to GPIO-PMIC based reset.

What do you think?

> However, now I have some open questions related to interrupt-driven
> operation.  I'll research it further and come back with an update.
>
> >> This made me think however: what if a board doesn't enable TSADC, but
> >> has OPPs in place for higher voltage and frequency states? There won't
> >> be any throttling (as there won't be any thermal monitoring) and there
> >> might not be a critical shutdown at all if it heats up - possibly even
> >> causing hardware damage. In this case it seems that having TSADC
> >> enabled by default would at least trigger passive cooling, hopefully
> >> avoiding the critical shutdown altogether and making those properties
> >> irrelevant in 99% cases.
> >
> > Those are very good questions.  Thumbs up!
> >
> > The trouble is that the boards can use different wiring to handle the
> > thermal runaways, by expecting the PMIC to handle it or not.  Thus,
> > it's IMHO better to simply leave that to be tested and enabled on a
> > board-by-board basis, whenever a new RK3588(s)-based board is added.
> >
> > Thus, the only right way at this point would be to merge the addition
> > of the OPPs and the enabling of the TSADC for all currently supported
> > RK3588(s)-based boards at once, instead of just for the Rock 5B.

If we can agree on a workable 'default-on' configuration for TSADC to
be included in the .dtsi I think that would be preferable, because it
would enable all boards to benefit from higher OPPs and throttling.

This would also save us from a scenario when OPPs get included in the
default .dtsi, but TSADC is off by default, and then some poor soul
tries to add a new board with a minimal .dts, forgetting to enable
TSADC and having their SoC fried under high load...

> > I can handle the required changes for the QuartzPro64 dts file.  For
> > other supported RK3588(s)-based boards, if there are no people having
> > access to them and willing to perform the dts changes and the testing,
> > I'd be willing to go through the board schematics, to enable the
> > TSADC for them as well.
>
> Please, let me know are you fine with the above-described approach.

I believe it's great if we can go through the schematics no matter
what! Although if we agree that CRU is an always-working default
option for all, then why don't we just enable TSADC for all, and leave
the conversion to GPIO-PMIC resets for later and for where it's
needed?

Best regards,
Alexey

