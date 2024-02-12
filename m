Return-Path: <linux-kernel+bounces-62009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F144851A07
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D4BB237EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4663D54D;
	Mon, 12 Feb 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNT2mCxz"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6123B2A4;
	Mon, 12 Feb 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756624; cv=none; b=S0g1T4P63WJAd6ANO5FZX1pn+dCkvC66gN2SWsSCiypAna1aI/0hLNVDblwshiDLeFqWKBFF1K+dpuU5nfOy3yMdx344GPdvK46COru4WdtsgbeIZk3pGWcLUJLiaN+DMQ8yWnTR2BELSCS0rEoJfNoe+cRbCUdBwV800TSJIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756624; c=relaxed/simple;
	bh=psAYolLubLnXKh+kFdLshH1IwolSJgEuJAOQ4J6CcLU=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Dflv+8i5hjEA9M+2CFJts669y+y2ibGCZ7UQ1FBm9c2zy7UGTe+KHIk3lCi3duFpUIapNp/hOjPflm61MYCaisbyA8ugMHKnbtYL5tH7Yruf6jS8GmX/zOFSOygxj/SOHMcMnaHGz0kvSjIxPhdEejzRgc+PWsDcql2UD0FZTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNT2mCxz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55ff5f6a610so4064821a12.3;
        Mon, 12 Feb 2024 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707756620; x=1708361420; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DbtCOz3u26hElchW0PWcPewu+ZG78Aj7zeMZmqh8H1Y=;
        b=dNT2mCxzWEr53u2iUy94Ob2lLxy1+oONvYndOERnxF1t8JTnl+zutiVmPUomkG1oun
         RrgOBxRneraUvByoknqwhckgHUiqtclhA1gO4NyIoLqi4AUzrw7eYq28GWYjRcWJjDqj
         q4HBvL+2rFh2ydvwKQtONNE3BHMHLE1Twa7dmLGzqg1O5sJeP2QBL9+DX0v8uUxkJqom
         hy3nrMzScBBGJpK7rvRnfndoqTpJhaIsW5Z1G8ivQtqQEoLeLJt3ksXTJ3ENjEjVavK0
         ULUSV6FBgDBA/Xo44chKfbSN2pFPTuW/5JeQ45I191kz/mTaZQjIJKmbugoCVX4HNHHm
         uWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756620; x=1708361420;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbtCOz3u26hElchW0PWcPewu+ZG78Aj7zeMZmqh8H1Y=;
        b=nbHFMLY/PJXa/WN5sRqQNnuRVW8a6RolkarSBw3wkNwqM5Y3/IEElbdv4uageau+Ml
         GVpqp8GFAEw427erg4PQ7gaxgx0QpIC/l1mZG6eKcMqXLDOUzTAWFOeAnOEp+nQuhlWv
         zn6nGBJeLM4pfrxwk6bRxWYct1fuRACLRXpJlVbkCfHLEAytGUUqM916AgdpfQaTT1S/
         adKASSY4IMzl7WaKwUCaYahrIxfw9S2Nj1jCFbbfpQht0qpM0U2AatySXiANA+v8AZnM
         qVu0Dd3uOUFkWa9cr525Vtc3XaXh4ERokWB91I8ddPdxOir5YfFeX92Zrauf7GjAzzq4
         EmiA==
X-Forwarded-Encrypted: i=1; AJvYcCWwWuViV01a/4f4KsL2NPutsmvLkxNCYKeoW3+cwFCJB2p+uNKEKhziBs5VvoWln+Ol7F0YLF2U4w5S/ponwlL08TQJEKL9DkTjbPBla7Ly7/LCuRS3FphHo9unfMhRbyRolgLhnDKniZU=
X-Gm-Message-State: AOJu0Yw8BJJf3RsVT+1CtcJC634nYnEgZMXPTC8zyuQ9ABjW80JRsocc
	6aOSyn3DqhZ2Pa9tg0J2kM9nsszi4aoq/Ln2Q4lDzlASum+psQJP
X-Google-Smtp-Source: AGHT+IFftF7HlCObOuwBQ/Rn6Zi2lSFub53JoK52ItcnhXkLZH4AbtnP3IeLI2bAJ9AZkCoRml7RVw==
X-Received: by 2002:a05:6402:5d90:b0:561:9f62:8db3 with SMTP id if16-20020a0564025d9000b005619f628db3mr3335969edb.29.1707756620298;
        Mon, 12 Feb 2024 08:50:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjZZUQ9opbitxcj18TgINb330mLd5bs/QgDlAbVc+/b+TQo4HTAg3GgfMZ8auVW03Z1K+zY+oia7eAq3u5uS7adDcegYT2WYL8wWZxXkIaVCZW1t3ew+5ZopdP7hUwUNJ3VN9LK7iW3Lsrkct/FM5lg+yVeash9cqoJ6lSzXFHnR+6kCG+2usplPZH2qJlwCr+FAADAKNkiKU9NR0+4jbN8yQUJ5HGHmZ6sPtcLn9ygubDuPIzQ01ytxWScUDKCXou2wIcSabOInIYxvJHqUyIBae0aJx9kTe5ZlEH
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fd9-20020a056402388900b005607f899175sm2927160edb.70.2024.02.12.08.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 08:50:19 -0800 (PST)
Content-Type: multipart/signed;
 boundary=7c640255eac135c68b597b52d418781ce4ba02d5840e4f5c2d60ce4c9520;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 12 Feb 2024 17:50:19 +0100
Message-Id: <CZ3974AW5FT3.39WK876PU00AZ@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] ARM: tegra: set correct naming for Tegra Note 7
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Jon Hunter" <jonathanh@nvidia.com>, "Svyatoslav Ryhel"
 <clamor95@gmail.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Shubhi Garg" <shgarg@nvidia.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240212071843.6679-1-clamor95@gmail.com>
 <20240212071843.6679-2-clamor95@gmail.com>
 <8ffbe7ae-67e9-4a3f-9866-3cd744729971@nvidia.com>
In-Reply-To: <8ffbe7ae-67e9-4a3f-9866-3cd744729971@nvidia.com>

--7c640255eac135c68b597b52d418781ce4ba02d5840e4f5c2d60ce4c9520
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Feb 12, 2024 at 5:14 PM CET, Jon Hunter wrote:
>
> On 12/02/2024 07:18, Svyatoslav Ryhel wrote:
> > Correct codename of Tegra Note 7 is "tegratab", while model
> > name should be "NVIDIA Tegra Note 7". Fix this inconsistency.
> >=20
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   arch/arm/boot/dts/nvidia/Makefile                            | 4 ++--
> >   .../{tegra114-tn7.dts =3D> tegra114-nvidia-tegratab.dts}       | 5 ++=
+--
> >   2 files changed, 5 insertions(+), 4 deletions(-)
> >   rename arch/arm/boot/dts/nvidia/{tegra114-tn7.dts =3D> tegra114-nvidi=
a-tegratab.dts} (98%)
> >=20
> > diff --git a/arch/arm/boot/dts/nvidia/Makefile b/arch/arm/boot/dts/nvid=
ia/Makefile
> > index 7a422f150488..474f3fbbd99d 100644
> > --- a/arch/arm/boot/dts/nvidia/Makefile
> > +++ b/arch/arm/boot/dts/nvidia/Makefile
> > @@ -2,8 +2,8 @@
> >   dtb-$(CONFIG_ARCH_TEGRA_114_SOC) +=3D \
> >   	tegra114-asus-tf701t.dtb \
> >   	tegra114-dalmore.dtb \
> > -	tegra114-roth.dtb \
> > -	tegra114-tn7.dtb
> > +	tegra114-nvidia-tegratab.dtb \
> > +	tegra114-roth.dtb
> >   dtb-$(CONFIG_ARCH_TEGRA_124_SOC) +=3D \
> >   	tegra124-apalis-eval.dtb \
> >   	tegra124-apalis-v1.2-eval.dtb \
> > diff --git a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts b/arch/arm/boot/=
dts/nvidia/tegra114-nvidia-tegratab.dts
> > similarity index 98%
> > rename from arch/arm/boot/dts/nvidia/tegra114-tn7.dts
> > rename to arch/arm/boot/dts/nvidia/tegra114-nvidia-tegratab.dts
> > index bfbdb345575a..30b2ed91be23 100644
> > --- a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
> > +++ b/arch/arm/boot/dts/nvidia/tegra114-nvidia-tegratab.dts
> > @@ -5,8 +5,9 @@
> >   #include "tegra114.dtsi"
> >  =20
> >   / {
> > -	model =3D "Tegra Note 7";
> > -	compatible =3D "nvidia,tn7", "nvidia,tegra114";
> > +	model =3D "NVIDIA Tegra Note 7";
> > +	compatible =3D "nvidia,tegratab", "nvidia,tegra114";
> > +	chassis-type =3D "tablet";
>
> No mention of adding the chassis-type in the commit message. Seems like=
=20
> that should be a separate change.

Agreed. Along with Krzysztof's comments maybe this should just be a
single patch that updates the model property and adds the chassis-type.
We haven't used chassis-type before, but I see that the devicetree
specification has it marked as "optional-but-recommended", so maybe we
should make a pass over all files and add these as appropriate.

Thierry

--7c640255eac135c68b597b52d418781ce4ba02d5840e4f5c2d60ce4c9520
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXKTEsACgkQ3SOs138+
s6FMYxAAtw170jJGnf2jjS+4ueekSK3Ym6O38q1r0QQu8S71dwn7SHUFfxLmnvzT
b4eTV+3mSt9S1z2YGxseXo9YCV21ZmhOBqCtjpgnE3hf/yoBCMt6oOGw5O5TYtl7
5Aa7fTdSBEWvG3zKT39kR73o0TtVn4FV5XecsZIu7922LA7IEqAEkb53T4p7mmTo
lHmI6qUTzISgYO2T7JhAPTUsh+R3F66HM0mnDTU6s59Leaazi1WfoWX2gufWfDWP
aUGXb0O+lTJKVIzE83vbGgPeC5MSYMHXlGe9bPIkaThJjbUnO066bUwEZ7e6F/WJ
V+169e6ueZdPNxr7A/gDVbFN28e3KHbYon7khgdJZOPpfp2TWN0EGfkPPj5Jhdya
dMnqvOLEt7OTWbDIcjfIzPNPsiKETsOMN9YrTYkCvJN3yOelvFF+oogrvDCkWFpn
48WFVAxUq83nmPz1Rv71mpwWH2sySWhf6Oe5QesaDxmfaL8gIpmL1MPbtB3o8kz1
U8LZ0G1+5HPUUsyvQDU6BPaU5TQqS9zqu0/YSwQydlAp/ZZ36H5xwkeMN2PBMNr+
LKMJl2Sz5FmM0FkIWTkYEfPmCqQSE0i6vNeZqH8Y++qPXfnTCzoGNiBUouME4Cp+
t5Yh3PnHtu3sCM6rmfWApTqRsJ10UBuDd7fF8BKFlf+tVeBG9Kk=
=U8Ue
-----END PGP SIGNATURE-----

--7c640255eac135c68b597b52d418781ce4ba02d5840e4f5c2d60ce4c9520--

