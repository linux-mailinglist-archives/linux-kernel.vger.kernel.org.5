Return-Path: <linux-kernel+bounces-38172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA883BBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3F31C234B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381ED17BA9;
	Thu, 25 Jan 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGoOcx7t"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6EA175AA;
	Thu, 25 Jan 2024 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171191; cv=none; b=SawzTYSxVbtoy15jjqiBLshXYFxZUdTfHrI0xZ5wahEbrpyFiuY4Z9UnIgDZjXXIhGHAfSPI8l9OF0JLJe8rXzeobvUbRvHE7scklIaTMBWuYym04uxTp4hUx3T8So+ab9RsykKI/uYqTXbhc/qV05RJmzXE92DyDtjqT3OCOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171191; c=relaxed/simple;
	bh=Zw8V8UjUD9M5Akt0Mg0TBvrOODvY6i5uuUFpRRZaGyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqBSmhg1dImFW4lse0bJi2TpyzEFykTLDvDxsxGG/enzhIRd/udVkiAD7EkOCUw2ivIhVMM/Zby/thnpuXdjAhoP0eJc41fDLc0uegPWs+ShiYsXKZZczs5tOzIOpdgyThFRV2BgCEe/xJbEWUU+BNG0MLeoyLyBAhfQZ55AINM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGoOcx7t; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a31a69df7ebso5146866b.2;
        Thu, 25 Jan 2024 00:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706171187; x=1706775987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDj9dyDoJvW3QDD18miYbUUM3hC9uhJPCrBBQYx1s3w=;
        b=XGoOcx7tg6THtesvdnfZQC+S06T1G8feN8HvI+drbK7jSTg+ZgnGfzWtraXNqJrLaE
         VQlTC+jY5DmrcaTLkNimwfvfB5e7vdrDtsRj6XKYaXXMi1LBb42dfUG5/PiV9wrhGpyf
         KoFj6RT3JrCwjCNQrP57JJBPOnYD3WDrkXD0Ir8QddXHIC/ZsZogkNhFWgWB5uiy5gtu
         T2ND/IO/McEyp29M0gBY74CLfpNiezWUwCmoaIVmDbwhg4UvNRASq5CVXW5YVkKWI6wM
         PzNin7kYAxsgC8weXwVeyIIJM2JHCembl5TP6WMAj5L7qPgor53Fg1lk7qlmsmzmaQe6
         4LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171187; x=1706775987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDj9dyDoJvW3QDD18miYbUUM3hC9uhJPCrBBQYx1s3w=;
        b=KNGN4KM1SYuSWDeeEu36n3KnD+6WG3M0qW6SF327wq+/mvw0FKGBp9rQ3tiBJNNY2K
         zXOzW8T4fnh5HXe1MfRCEjwKQxHodlgAXlNPRrVSgmD0dW32h1U+mzrasKVHFf0o8P68
         +/q65lx0oyfKr7CG4rKdoBlkGYGy+BqEVubRS0L3vEh0OfSYhIEDB5qgmpSagzYoIUsq
         UuxgwVPJvCN2jvvk28qv1SwTeveHK07AdUGCO2oemicwryA08ZCN0M4ccRAbC5etfV/L
         XefSN786UbqpEzAYmN+2JaXZ0tBoYq0YB8MNddGUcCMfxtAbOVHev0ccVeaeyzr8SWlb
         9x6A==
X-Gm-Message-State: AOJu0YzQgKn6Y+vHsyZlHp7ijXkTS32m94ByXWPRd98w2zQLRHVbXcwr
	D26IA393zr9xvNhxs1d22udkMDeJtG5fLIaYEhysnizJtwom1qrrePmh6ojRTTvxopekzv1SQDj
	iMa7udJigno/qTVhEygZTG1oclfWAnE+04J6L0tpM
X-Google-Smtp-Source: AGHT+IFe5x9xJqmTBkPbDbVckjTr5VlFUGBZ1jAXSJ0LaemIY/IikLrFwH4+EqivDX2V//P3tQKjtaGhPsWbBksy39U=
X-Received: by 2002:a17:907:a70d:b0:a30:e04b:cbd7 with SMTP id
 vw13-20020a170907a70d00b00a30e04bcbd7mr449239ejc.64.1706171187180; Thu, 25
 Jan 2024 00:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-2-5879275db36f@gmail.com> <245f5692-be30-4216-8b13-988092793732@linaro.org>
In-Reply-To: <245f5692-be30-4216-8b13-988092793732@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 25 Jan 2024 12:26:15 +0400
Message-ID: <CABjd4Yz3RTeog0gvYaSK3A5H8NzQpYeqmjRWN1QDHjVPG9qTpA@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:56=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 24/01/2024 21:30, Alexey Charkov wrote:
> > Include thermal zones information in device tree for rk3588 variants
>
> There is an energy model for the CPUs. But finding out the sustainable
> power may be a bit tricky. So I suggest to remove everything related to
> the power allocator in this change and propose a dedicated change with
> all the power configuration (which includes proper k_p* coefficients to
> be set from userspace to have a flat mitigation figure).
>
> That implies removing the "contribution" properties in this description.

Alright, I'll just drop those "contribution" properties, thanks!

> Some comments below but definitively this version is close to be ok.

Yay! :)

> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 165 +++++++++++++++++++++=
+++++++++
> >   1 file changed, 165 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boo=
t/dts/rockchip/rk3588s.dtsi
> > index 36b1b7acfe6a..131b9eb21398 100644
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
> > @@ -2228,6 +2229,170 @@ tsadc: tsadc@fec00000 {
> >               status =3D "disabled";
> >       };
> >
> > +     thermal_zones: thermal-zones {
> > +             /* sensor near the center of the whole chip */
> > +             package_thermal: package-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 0>;
> > +
> > +                     trips {
> > +                             package_crit: package-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between A76 cores 0 and 1 */
> > +             bigcore0_thermal: bigcore0-thermal {
> > +                     polling-delay-passive =3D <20>;
>
> 20ms seems very short, is this value on purpose? Or just picked up
> arbitrarily?

Frankly, I simply used the value that Radxa's downstream DTS sets for
my board. 100ms seem to work just as well.

> If it is possible, perhaps you should profile the temperature of these
> thermal zones (CPUs ones). There is a tool in
> <linuxdir>/tools/thermal/thermometer to do that.
>
> You can measure with 10ms sampling rate when running for instance
> dhrystone pinned on b0 and b1, then on b2 and b3. And finally on the
> small cluster.

It seems tricky to isolate the effects from just one of the CPU
clusters, as their individual thermal outputs are not that high.

For my testing I disabled the fan (but didn't remove the heatsink to
avoid wasting the thermal interface tape), and tried loading CPUs with
stress-ng. Here are the observations:
 - Little cores alone stressed with 4 threads pegged to them with
taskset never reach the throttling temperature (85C), and balance out
around 60C
 - Either of the big core clusters stressed individually with 2
threads pegged to them with taskset never reach the throttling
temperature either
 - Four big cores with 4 threads heat up very slowly (>30 minutes to
reach throttling temperature, I didn't have enough patience to let
them actually reach it - maybe they never do)
 - Eight cores with 8 threads heat up to the throttling temperature
within ~5 minutes (again, with the fan off), and then, as soon as just
one of the big core clusters gets throttled, the temperature of all
cores balances out just below the throttling threshold. In my
observation cores 6,7 go from 2.4GHz down to 1.8GHz while the rest
stay at their respective top performance states (2.4GHz for big cores
4,5 and 1.8GHz for little cores 0-3)

Adding to it the fact that the temperature measurement resolution is
not very granular (almost 1C) it's somewhat difficult to estimate how
fast throttling action on a single cluster really brings its
temperature within bounds, as they all affect each other at relevant
temperature-load combinations. Perhaps it means that too granular
polling doesn't add much value.

> But if you don't have spare time and 20 is ok for you. Then it is fine
> for me too.

I guess I'll go for 100 as other upstream Rockchip .dtsi's do, given
all of the above. Thanks for pointing this out!

> Some nits below.
>
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 1>;
> > +
> > +                     trips {
> > +                             bigcore0_alert0: bigcore0-alert0 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             bigcore0_alert1: bigcore0-alert1 {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             bigcore0_crit: bigcore0-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&bigcore0_alert1>;
> > +                                     cooling-device =3D
> > +                                             <&cpu_b0 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_b1 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> > +                                     contribution =3D <1024>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between A76 cores 2 and 3 */
> > +             bigcore2_thermal: bigcore2-thermal {
> > +                     polling-delay-passive =3D <20>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 2>;
> > +
> > +                     trips {
> > +                             bigcore2_alert0: bigcore2-alert0 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             bigcore2_alert1: bigcore2-alert1 {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             bigcore2_crit: bigcore2-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map1 {
>
> s/map1/mpa0/

Noted, thanks!

> > +                                     trip =3D <&bigcore2_alert1>;
> > +                                     cooling-device =3D
> > +                                             <&cpu_b2 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_b3 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> > +                                     contribution =3D <1024>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between the four A55 cores */
> > +             little_core_thermal: littlecore-thermal {
> > +                     polling-delay-passive =3D <20>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 3>;
> > +
> > +                     trips {
> > +                             littlecore_alert0: littlecore-alert0 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             littlecore_alert1: littlecore-alert1 {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             littlecore_crit: littlecore-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map2 {
>
> s/map2/map0/

Noted, thanks!

Best regards,
Alexey

