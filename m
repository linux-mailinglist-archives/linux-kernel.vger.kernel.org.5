Return-Path: <linux-kernel+bounces-38742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C527C83C51E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726B12924EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7696E2DE;
	Thu, 25 Jan 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqDoQVCF"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D676E2D9;
	Thu, 25 Jan 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194031; cv=none; b=UzSH1J4PsfCR1kw9XtSLlrUpYAIVHPW6AXmOR28iiB+TzD+H1htA4al0nXgWU2evWhmsyRzDCKAQImLtnokuH03DcQ2X5uUkmew7Hxf1nA0Zk5QcUGtgSJdVCa8Gm96pQRneAmy/Sh6kobCCpqbZ+CHxRDrTMKTvj21+9oVC9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194031; c=relaxed/simple;
	bh=hfDxzQWo/PGBd3L2W8+BoRAcKd91eLKtldatvc5IaEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0Xh74XzRP4j8M65x5UEXRbXEcqOrH1wUyYW9D+nFTqamZ+Vk9EHdvb1BGTm/MguXuNAtMKqDDMke1H2iR/4iyI1crGDvTknpvs61KLd95dTlP1I7mhnNjPrMZLdA1JPm0ZQz90/znWGK/MgTvJTYPUh3hNCU1nli782zITrE8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqDoQVCF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so7535961a12.3;
        Thu, 25 Jan 2024 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706194028; x=1706798828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4hX8W9xNuyyOSQCgz2SgdgTnuDIhAWJKxtpQ17e4fg=;
        b=iqDoQVCFNDWB3hUgJrN6EnhQH2EbPZ2hAp3t+Cbd9fVN7OyplLoKGoBs/xYae8C4mJ
         g8epmqiF3Hfdl0dgXzgv2oZZgA0hj0d2N9ZLsMDBcsqto1zIp3JCpCj1UsE7kzISf8qb
         i91QjgCsbG33viZHToz1eMz/AzfsscdwLGnYv7qU4nTIXsi4lCTWJ5DETMaRoP/PlDqC
         IGwpWAtoBXXa3V0wlAjx9KkPOl83aoBNfcdoBp0qd69kFcHDBrpRLKW/2mcPlY9D3SWP
         dCbdgJ6F9fGTAdgUjf0Kbx5WOE71jMlzJtAd1SYHDdCGq+KId1cUgbR6keFDh0acSLtE
         GD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194028; x=1706798828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4hX8W9xNuyyOSQCgz2SgdgTnuDIhAWJKxtpQ17e4fg=;
        b=U/hdphr1CS+GREwRyz6VxmrXP3GVgmsXI17Xa2Z834A8BXhlZYpMRE2tYAQKq9xB5Z
         xt3pyrDXEorWRMjYUc0EnUCZE2tHHaYPcVTSA1w3pDAaLCoh/oXQyioJ/TXCqnCOa38K
         QJBL39Blsg1aiX3voacuapWvxBUUzdZ+XXWiPvWCI0BvRwEE8WrKB8B7uYG8w+nQHXra
         xc9kZyHIu1JcO+2cygxfcoCBzduzXwlbsts0CZ/Bff8fwdHuKgWTAGeiD92WMsL8li4u
         ZNF5ROoyuDF+EO5CxzLyR8rIaJ9MePzT1Fl+s9z0wgmy0yWSazTIiJxevaduDJKxMLT6
         kNHw==
X-Gm-Message-State: AOJu0YwxfFXP9NBmpLpuf4lwXxhKEca9Pu7VLDMcowbhakqIL4n7nl+n
	BAMlzcAFqGPLb+4butHqvnWHsv31Mu9EgC+//x8/5dWfpaOP6fU+n0SRgwEhWGnt3WMpMBgWRCU
	cjzgI9TTMsmZCvZALo+mRSGyjf4k=
X-Google-Smtp-Source: AGHT+IERmim/LImtnzip9nkUi3TvGcZu8W1l3NIHibtypa8XUy+GTjk74KgDQQaqjeana1FBSWPhP1KA24QsBIRzYyE=
X-Received: by 2002:a17:907:1591:b0:a2e:d32b:6fc7 with SMTP id
 cf17-20020a170907159100b00a2ed32b6fc7mr537611ejc.119.1706194027557; Thu, 25
 Jan 2024 06:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-2-5879275db36f@gmail.com> <245f5692-be30-4216-8b13-988092793732@linaro.org>
 <CABjd4Yz3RTeog0gvYaSK3A5H8NzQpYeqmjRWN1QDHjVPG9qTpA@mail.gmail.com> <e65d4640-9bb0-4c34-8eab-865ce8dd59bf@linaro.org>
In-Reply-To: <e65d4640-9bb0-4c34-8eab-865ce8dd59bf@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 25 Jan 2024 18:46:56 +0400
Message-ID: <CABjd4YwysdWU6CYxC3s13OZFTf2oXc2+bW0bi+19FovcE+hK3Q@mail.gmail.com>
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

On Thu, Jan 25, 2024 at 2:02=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 25/01/2024 09:26, Alexey Charkov wrote:
> > On Thu, Jan 25, 2024 at 1:56=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 24/01/2024 21:30, Alexey Charkov wrote:
> >>> Include thermal zones information in device tree for rk3588 variants
> >>
> >> There is an energy model for the CPUs. But finding out the sustainable
> >> power may be a bit tricky. So I suggest to remove everything related t=
o
> >> the power allocator in this change and propose a dedicated change with
> >> all the power configuration (which includes proper k_p* coefficients t=
o
> >> be set from userspace to have a flat mitigation figure).
> >>
> >> That implies removing the "contribution" properties in this descriptio=
n.
> >
> > Alright, I'll just drop those "contribution" properties, thanks!
> >
> >> Some comments below but definitively this version is close to be ok.
> >
> > Yay! :)
> >
> >>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >>> ---
> >>>    arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 165 ++++++++++++++++++=
++++++++++++
> >>>    1 file changed, 165 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3588s.dtsi
> >>> index 36b1b7acfe6a..131b9eb21398 100644
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
> >>> @@ -2228,6 +2229,170 @@ tsadc: tsadc@fec00000 {
> >>>                status =3D "disabled";
> >>>        };
> >>>
> >>> +     thermal_zones: thermal-zones {
> >>> +             /* sensor near the center of the whole chip */
> >>> +             package_thermal: package-thermal {
> >>> +                     polling-delay-passive =3D <0>;
> >>> +                     polling-delay =3D <0>;
> >>> +                     thermal-sensors =3D <&tsadc 0>;
> >>> +
> >>> +                     trips {
> >>> +                             package_crit: package-crit {
> >>> +                                     temperature =3D <115000>;
> >>> +                                     hysteresis =3D <0>;
> >>> +                                     type =3D "critical";
> >>> +                             };
> >>> +                     };
> >>> +             };
> >>> +
> >>> +             /* sensor between A76 cores 0 and 1 */
> >>> +             bigcore0_thermal: bigcore0-thermal {
> >>> +                     polling-delay-passive =3D <20>;
> >>
> >> 20ms seems very short, is this value on purpose? Or just picked up
> >> arbitrarily?
> >
> > Frankly, I simply used the value that Radxa's downstream DTS sets for
> > my board. 100ms seem to work just as well.
> >
> >> If it is possible, perhaps you should profile the temperature of these
> >> thermal zones (CPUs ones). There is a tool in
> >> <linuxdir>/tools/thermal/thermometer to do that.
> >>
> >> You can measure with 10ms sampling rate when running for instance
> >> dhrystone pinned on b0 and b1, then on b2 and b3. And finally on the
> >> small cluster.
> >
> > It seems tricky to isolate the effects from just one of the CPU
> > clusters, as their individual thermal outputs are not that high.
> >
> > For my testing I disabled the fan (but didn't remove the heatsink to
> > avoid wasting the thermal interface tape),
>
> It is ok but the system will have more heat capacity and it will be
> necessary to saturate it before running the tests. IOW warm up the
> system by running thermal stress tests several times.
>
> > and tried loading CPUs with
> > stress-ng. Here are the observations:
>
> Usually I use drhystone to thermal stress the cores (e. one minute).

Hmm, could you please point to the source package or repo to get the
version of dhrystone you use? I could only find the old shar [1] and a
Debian version with added Makefile [2], but neither seems to produce
multiple threads.

It doesn't seem to be packaged for either Gentoo or Fedora unfortunately.

Indeed, I'm getting higher thermal load (vs. stress-ng --cpu) even by
simply compiling kernel sources, although I'd expect it to wait for
memory and/or IO quite a lot.

[1] https://www.netlib.org/benchmark/dhry-c
[2] https://github.com/qris/dhrystone-deb

Thanks a lot,
Alexey

