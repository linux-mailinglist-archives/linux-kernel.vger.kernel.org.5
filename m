Return-Path: <linux-kernel+bounces-46156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294B843B59
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F44E1F26E37
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6176994F;
	Wed, 31 Jan 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhtn/ya8"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFBB6994B;
	Wed, 31 Jan 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694214; cv=none; b=nSRIgN5sz/2qGycxlnA1CkWhfimzVosbbE5a7543TZxZwHjPXbtQLHW6bQSqKkWO/tcGJtDym1KOJMUk7MhINAA2XZSJMNrZcMlGc/l127l1tStHyav+/T10cVAR7YDKWa3so6WRBW2j6lKzb/jyJehsxnONzJGjg//TtlZb5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694214; c=relaxed/simple;
	bh=AH+tCjMAx3QC27/6a3aHn8iEY3DhD8c3Sn0bBq9szvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWvbo0uPe9fyJxwWg1Pd64hIwdcxDOsL/emCvGNpS/MqnY40leqnZ/HYj/A1jTD8KDZQ3A5v7IVflIhuq/eFEHNOZLztEEBr6QT3tpdvW06zDi4PlIdxfcTOF7XI28RbGpzJzOWRLVW5mCKHJ+IEvXpLeoNYUp9MXFCwJuQ72Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhtn/ya8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26fa294e56so636935466b.0;
        Wed, 31 Jan 2024 01:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706694210; x=1707299010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITZ+rt9x0Q01XZlNJE668LMM3xiQ7k41PpzKoiIe8e0=;
        b=Bhtn/ya8fSTdLwkiWBtTnytPBzICnxv8nqR6kJuO2Q11Gd1QKVznIGFlY5kwac2Mlb
         EoS2KpC6pEq37MQ1m0gz37HGdsth83IY0xuJisrHZJrsr3PE0p1s6Fs6UBlI23Jx2JaW
         +v8Vupck4OTZNhTnorz0u6nuokB0+WCHXSJ3E/BQq5LHsgnxHmzMiGJDum4nAB7G6Pmk
         SiS18+JM9i0gYZAW1SXiiLNsQaEwp1uzEev2LbQwuJiGeyGSWJGhLRfRjWs6u5USYzKh
         hHnrALtcEuo00y4a25TS+bLAW32xnLEbMfcPZnVX4KkHIU+7ENGf/3CvoZx958DJV8z9
         9tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706694210; x=1707299010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITZ+rt9x0Q01XZlNJE668LMM3xiQ7k41PpzKoiIe8e0=;
        b=GkG9UwnbSwvFVxv5DqqxJb7PNPrCfIychJgfsJE3EYZYPBMgrCSiPTrUBxeoCFNf7h
         MVSQXWdpJ+Hclp87FT54+KJNzNgckdkyxXHk0JZBy2fJ11AFK2fiIYefea6OsV4uV4N9
         DQj3eKg/5XvpGqH6f3EMlgueUztBwELIautuGJ+m4Jrku1JlHwI5NKfdxPxmUWQ0Z7fZ
         bfbBtp+ra7RCi2GGUOnN65v09wA5jXytGi2JOt2jf7Ap7UIMN88Yc/9s9dMpwjWFoxOQ
         AvR8PqVIiOOYrdHi1ZS1V9Bta9PBlPM7iWpuL/ts4hi55Y6VaHIT3W6nPCPkqlxIS7S4
         JM0w==
X-Gm-Message-State: AOJu0YyD1xFEtjWHMrtu9EP/jWDqiXfhLXbo7GQQ5nkdhqOHZbezq9g9
	l4Y+EovlUnLmE+jJ5f6mi4fOtlqjqcwo3cOGTakL2HcvPaM95kE3T2iHmh6p1yiokds30c50cOg
	20Elao+xjk/5M7+CJ+27WUeZbLVQ=
X-Google-Smtp-Source: AGHT+IFpsyjOS9LQ+92/QbFeJKa7OgI/Xrx823sBS/pUCO7DlGoclan6W3wa/VSYWWIQT9HAx2L9ylTJRzjkGRtzT44=
X-Received: by 2002:a17:906:2c19:b0:a36:8711:ee35 with SMTP id
 e25-20020a1709062c1900b00a368711ee35mr415520ejh.40.1706694210472; Wed, 31 Jan
 2024 01:43:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com> <8115ab382115f66aa01dd3d00aaae474@manjaro.org>
In-Reply-To: <8115ab382115f66aa01dd3d00aaae474@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 31 Jan 2024 13:43:19 +0400
Message-ID: <CABjd4YyP0trjBi+Djau-n69vg6-s2SdPWwmWK9fT626sKST8EA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: rockchip: enable temperature driven
 fan control on Rock 5B
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:08=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Alexey,
>
> Some notes below, please have a look.
>
> On 2024-01-30 19:21, Alexey Charkov wrote:
> > This enables thermal monitoring on Radxa Rock 5B and links the PWM
> > fan as an active cooling device managed automatically by the thermal
> > subsystem, with a target SoC temperature of 65C and a minimum-spin
> > interval from 55C to 65C to ensure airflow when the system gets warm
>
> I'd suggest that you replace "temperature driven fan control" with
> "active cooling" in the patch subject.  More concise and reads better.

Agreed, thanks!

> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 34
> > ++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index a0e303c3a1dc..b485edeef876 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -52,7 +52,7 @@ led_rgb_b {
> >
> >       fan: pwm-fan {
> >               compatible =3D "pwm-fan";
> > -             cooling-levels =3D <0 95 145 195 255>;
> > +             cooling-levels =3D <0 120 150 180 210 240 255>;
> >               fan-supply =3D <&vcc5v0_sys>;
> >               pwms =3D <&pwm1 0 50000 0>;
> >               #cooling-cells =3D <2>;
> > @@ -173,6 +173,34 @@ &cpu_l3 {
> >       cpu-supply =3D <&vdd_cpu_lit_s0>;
> >  };
> >
> > +&package_thermal {
> > +     polling-delay =3D <1000>;
> > +
> > +     trips {
> > +             package_fan0: package-fan0 {
> > +                     temperature =3D <55000>;
> > +                     hysteresis =3D <2000>;
> > +                     type =3D "active";
> > +             };
> > +             package_fan1: package-fan1 {
> > +                     temperature =3D <65000>;
> > +                     hysteresis =3D <2000>;
> > +                     type =3D "active";
> > +             };
> > +     };
> > +
> > +     cooling-maps {
> > +             map0 {
>
> Should be "map1" instead of "map0".  There's already "map0"
> defined for "package_thermal" in the RK3588(s) dtsi file.

Indeed. I got overzealous renaming everything to be zero-based.

> > +                     trip =3D <&package_fan0>;
> > +                     cooling-device =3D <&fan THERMAL_NO_LIMIT 1>;
> > +             };
> > +             map1 {
>
> Should be "map2" instead of "map1".

Noted, thanks!

> > +                     trip =3D <&package_fan1>;
> > +                     cooling-device =3D <&fan 1 THERMAL_NO_LIMIT>;
>
> Should be "cooling-device =3D <&fan 2 THERMAL_NO_LIMIT>;"
> (i.e., "2 THERMAL_NO_LIMIT" instead of "1 THERMAL_NO_LIMIT").
>
> The first fan speed is already covered by the first cooling map.
> The second cooling map takes over from the second fan speed.

Makes sense, will adjust, thank you!

Best regards,
Alexey

