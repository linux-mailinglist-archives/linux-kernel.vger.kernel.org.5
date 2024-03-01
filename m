Return-Path: <linux-kernel+bounces-88034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E786DC69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B332B2672C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B769D18;
	Fri,  1 Mar 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAzKGl3F"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8E6930E;
	Fri,  1 Mar 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279531; cv=none; b=hT/uhkv4+JXeWgBSOi3yBLumNv9OmXwk66EAbo3jc1HIzM93tfoztdMoBdeH9w3SpxUNQ6N4BsywF7YMsO+NsSmRgxNeynw+JTMVTg7Jt4BZH0KcxY5mmaUbu6FrmPK62XH373h451zD2uhI39YMR8YnjflLZTuIE3QBGGOLd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279531; c=relaxed/simple;
	bh=bwGwuN3I8+Gi5Abe4YFrdv0+3daP+lMaLVTOlnHEcTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWBYszqpagG4B2WVZbGhEun1PKBSHP9/dPS76AJmPgcqC7z8Db5dcbapTRBhX4f4WfoYTnDV1hRVKBkImLNePcUFT0v1k3OhG77PV3u/bGfqivmxo/1XLXiE2+lf/Fz8FM5POVetGACVqf7GTjUmqnzA/cvcPTPukE5Qzn+jNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAzKGl3F; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso2660387a12.2;
        Thu, 29 Feb 2024 23:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709279528; x=1709884328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjRED4N553XEXI5Rtvk5JEdQ+G4+1D6ZpvBBjUxLoiM=;
        b=MAzKGl3FjxKvzRP/MxS4Fd0Adr8L8yKhNoDhRQl38jklS+DopaYgb3zx+jA6X63nEj
         yTQ4AzE8bDD+PaQYNM04CPb8JgdHAG43KthZGPrqyTkblvTFTjjOCCVtkKtxjGFvnNkm
         hCKPFxnUpgKxYhyS5/yXnn3rHWbkXfsOHN6pebe+JhEQEgArwlRDNly51DkdbCXmQQV+
         tOpdLmHa1SyRZoX5OhfGkDUrnKgGAluNmTRceyzLgw71JgWXo3Ya14we9YN6JTkbSnhd
         /naMLxtHf5Wz3DHLrG4zbuRDGZyOoRrKW8URULMR7HdXyyJKdsLjVdNmzw+STIICFtKF
         6DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279528; x=1709884328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjRED4N553XEXI5Rtvk5JEdQ+G4+1D6ZpvBBjUxLoiM=;
        b=qyGufdKmV8J0oUlAwSWDIP+M6P3DOj+ppQ4HOQTsdqQ5sYfBvnDf3kC7DBGdClsnQM
         Ovtu5gwcvT9MFUO/UaVMZLA7Uk5qBOWVm/CE+qsZyuTRcidib/HN3rGYBE8R07K/iHQg
         Bf9Wc93WRvqQpAgGOPsoO0yrU0Gw15tfjH6SqOK4lqsFel/3t7qOnpj2Ek4I43jUssLH
         V1THKskA6AFR7xF8TjyEpZk3ihTAnqh0MTbuRNKTWQ7FL5WlU8SxksuvzJBzIBRx3FvO
         FE4F92tYaZHmPCwhgFTMR87OXLXDq2Tmbkp/MCLWcNdl/9+m7I0/pryxvW5zO5c0p2Fr
         zMxw==
X-Forwarded-Encrypted: i=1; AJvYcCVL1epIOWm1XtMMydXCSLhf/OzHeAgvdPdFF+EsbOHxd4N1/hhkrFzfR97u7rD9LArsFOvvJRAwxVI2N5j3lp+51ZeOB2YI+uc+PJzURS1FFG09eFD/3buQ5hnp6en6Wx3oLe0687rZsQ==
X-Gm-Message-State: AOJu0Yxl2EJjQzxulLaWno2DbUPmEriJ1wo2SiltUMLnhyhCnirG5nM5
	iZM7qdSXOojbdfWKgW7Usr2EMaai3jN7hHdOqH2v+RVyfs8AeNrQPynzv0nJJNotHv/ha5Kbp9S
	yxApMiRTgDZhlqXqogSLFMfh9AFvzsRr7FJ0ynQ==
X-Google-Smtp-Source: AGHT+IEOKM2TDaDf2kpCzYd+hKnXahebUjnVZ+dJz6yZ+lQnN5+xluHc6aNdAXebEUqYLzLqfIOg3AADhHt3Vmh8zak=
X-Received: by 2002:a17:906:71d1:b0:a44:9cdb:9ec1 with SMTP id
 i17-20020a17090671d100b00a449cdb9ec1mr296185ejk.11.1709279527552; Thu, 29 Feb
 2024 23:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com> <5eb9193a44fb9f9b1e976412874cecef@manjaro.org>
 <CABjd4YzFuhfS9RhJ6svb9ZD0NqMT5B6GmqigHFLr8YG6FR5k=w@mail.gmail.com> <90d0cfd9b7d018e7332213f624f0f658@manjaro.org>
In-Reply-To: <90d0cfd9b7d018e7332213f624f0f658@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 1 Mar 2024 11:51:56 +0400
Message-ID: <CABjd4YxhL7m-neLFCQG5Aja2=stFdou7ji8m==UGPSSH-CybVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 10:14=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-03-01 06:20, Alexey Charkov wrote:
> > On Fri, Mar 1, 2024 at 1:11=E2=80=AFAM Dragan Simic <dsimic@manjaro.org=
> wrote:
> >> Please see also some nitpicks below, which I forgot to mention in
> >> my earlier response.  I'm sorry for that.
> >>
> >> On 2024-02-29 20:26, Alexey Charkov wrote:
> >> > Include thermal zones information in device tree for RK3588 variants=
.
> >> >
> >> > This also enables the TSADC controller unconditionally on all boards
> >> > to ensure that thermal protections are in place via throttling and
> >> > emergency reset, once OPPs are added to enable CPU DVFS.
> >> >
> >> > The default settings (using CRU as the emergency reset mechanism)
> >> > should work on all boards regardless of their wiring, as CRU resets
> >> > do not depend on any external components. Boards that have the TSHUT
> >> > signal wired to the reset line of the PMIC may opt to switch to GPIO
> >> > tshut mode instead (rockchip,hw-tshut-mode =3D <1>;)
> >> >
> >> > It seems though that downstream kernels don't use that, even for
> >> > those boards where the wiring allows for GPIO based tshut, such as
> >> > Radxa Rock 5B [1], [2], [3]
> >> >
> >> > [1]
> >> > https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/bo=
ot/dts/rockchip/rk3588-rock-5b.dts#L540
> >> > [2]
> >> > https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/bo=
ot/dts/rockchip/rk3588s.dtsi#L5433
> >> > [3] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock_5b_v1423_sch.pd=
f
> >> > page 11 (TSADC_SHUT_H)
> >> >
> >> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> > ---
> >> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 176
> >> > +++++++++++++++++++++++++++++-
> >> >  1 file changed, 175 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > index 36b1b7acfe6a..9bf197358642 100644
> >> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > @@ -10,6 +10,7 @@
> >> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> >> >  #include <dt-bindings/phy/phy.h>
> >> >  #include <dt-bindings/ata/ahci.h>
> >> > +#include <dt-bindings/thermal/thermal.h>
> >> >
> >> >  / {
> >> >       compatible =3D "rockchip,rk3588";
> >> > @@ -2225,7 +2226,180 @@ tsadc: tsadc@fec00000 {
> >> >               pinctrl-1 =3D <&tsadc_shut>;
> >> >               pinctrl-names =3D "gpio", "otpout";
> >> >               #thermal-sensor-cells =3D <1>;
> >> > -             status =3D "disabled";
> >> > +             status =3D "okay";
> >> > +     };
> >> > +
> >> > +     thermal_zones: thermal-zones {
> >> > +             /* sensor near the center of the SoC */
> >> > +             package_thermal: package-thermal {
> >> > +                     polling-delay-passive =3D <0>;
> >> > +                     polling-delay =3D <0>;
> >> > +                     thermal-sensors =3D <&tsadc 0>;
> >> > +
> >> > +                     trips {
> >> > +                             package_crit: package-crit {
> >> > +                                     temperature =3D <115000>;
> >> > +                                     hysteresis =3D <0>;
> >> > +                                     type =3D "critical";
> >> > +                             };
> >> > +                     };
> >> > +             };
> >> > +
> >> > +             /* sensor between A76 cores 0 and 1 */
> >> > +             bigcore0_thermal: bigcore0-thermal {
> >> > +                     polling-delay-passive =3D <100>;
> >> > +                     polling-delay =3D <0>;
> >> > +                     thermal-sensors =3D <&tsadc 1>;
> >> > +
> >> > +                     trips {
> >> > +                             /* threshold to start collecting tempe=
rature
> >> > +                              * statistics e.g. with the IPA govern=
or
> >> > +                              */
> >>
> >> See, I'm not a native English speaker, but I've spent a lot of time
> >> and effort improving my English skills.  Thus, perhaps these comments
> >> may or may not seem like unnecessary nitpicking, depending on how much
> >> someone pays attention to writing style in general, but I'll risk to
> >> be annoying and state these comments anyway. :)
> >>
> >> The comment above could be written in a much more condensed form like
> >> this, which would also be a bit more accurate:
> >>
> >>
> >>                                 /* IPA threshold, when IPA governor is
> >> used */
> >>
> >> IOW, we're writing all this for someone to read later, but we should
> >> (and can) perfectly reasonably expect some already existing background
> >> knowledge from the readers.  In other words, we should be as concise
> >> as possible.
> >
> > In fact, the power allocation governor code itself doesn't call those
> > trips threshold or target as your suggested wording would imply.
> > Instead, it calls them "switch on temperature" and "maximum desired
> > temperature" [1]. Maybe we can call them that in the comments (and
> > also avoid calling the governor IPA, because upstream code only calls
> > it a "power allocator").
>
> Hmm, but "IPA" is still mentioned in exactly three places in the files
> under drivers/thermal.  I think that warrants the use of "IPA", which
> is also widely used pretty much everywhere.
>
> Perhaps a win-win would be to have only the very first of the comments
> like this, to introduce "IPA" as an acronym:
>
>                                    /* Power allocator (IPA) thermal
> governor       */
>                                    /* switch-on point, when IPA governor
> is used   */

Yes, good point, thanks!

> Next, "the target temperature" is mentioned more than a few times in
> drivers/thermal/gov_power_allocator.c, which I believe makes the use
> of "IPA target" perfectly valid.  Actually, let's use "IPA target
> temperature", if you agree, to make it self descriptive.

Or perhaps simply "target temperature"? Stepwise governor will also
use this trip as its target, so it's not IPA specific, unlike the
switch-on point.

> Finally, the threshold...  Based on
> drivers/thermal/gov_power_allocator.c,
> I think "IPA switch-on point" would be a good choice, which I already
> used above in the proposed opening comment.

Agreed, that sounds good to me, will reflect in the next iteration.
Thanks for bringing it up!

Best,
Alexey

