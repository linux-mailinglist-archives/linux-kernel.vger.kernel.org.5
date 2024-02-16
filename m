Return-Path: <linux-kernel+bounces-68725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169D857F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81034B2172E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBF412C817;
	Fri, 16 Feb 2024 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV068Mks"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56F12C7E3;
	Fri, 16 Feb 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092851; cv=none; b=qRAiryb84hMbm2IFQyaHnaIKR3t9feucs05aej5dW+S6xH7VLX4F3MGuvh8BCNWd4/WOmkch7BIPJIj7gJRQP+OUPI/+EfbStfda5T8YM9DqTkLlEB1Snvorswy7jtXR46T456w1y2h+YSkPx43ykRhgCu7+ZdWy45y9yOlxiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092851; c=relaxed/simple;
	bh=ulooY3k/9kjdy6juICpuC9BZLtxZZtvHi1HuciUwdIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu5OikseD1y4KYgwCfOUNRNF99gf+sfs1xte0ViNNYtuFOrZyi/GN5SveKIKT6z2wqddGeRp7wGYU+Wa5G3flDiXHdmpMIB98MX3hVP0yb+ZZoWc0woAk7hi+DbduHJ+GSXZEjca0Uvzp1PYFDKhWX6vbTYW8bn1xildOKNMsO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV068Mks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D03C433F1;
	Fri, 16 Feb 2024 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708092851;
	bh=ulooY3k/9kjdy6juICpuC9BZLtxZZtvHi1HuciUwdIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lV068Mks1mgMbPWPWpAQSOU/t+Fo4s5NnRVE0PHpNb0MgnVnEcCeIeXqvMhtXbuKC
	 U2FRuVwoW7w3iZAUjrUBs1rFjdjFz94YHnv7/G8ipeLf/EVqpUrlG0ieVwkd1TF9JJ
	 z4nr9nsNtZ5vUdkUqZrKds39GmlN4ki6xhtku07BVI8GaF/MwlSA+jJKTPItxtsV2p
	 LkyREhW5+ml4TlKQxIkFej2ZKg68T4lCNuXVRC+vHbOE7u4hdUo8J2YMtT6dSVhgDL
	 uVOX/DzBJI1rsxXAm6dYVXzGXpg6DhcK7ZRl6WLRvXyM7QEOIhsZ+JlTr2s3OPjjWQ
	 kgoviwRy/KQLw==
Date: Fri, 16 Feb 2024 15:14:08 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Adam Ford <aford173@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Sarah Walker <sarah.walker@imgtec.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Nishanth Menon <nm@ti.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: RE: RE: [PATCH v2] drm/imagination: DRM_POWERVR should depend on
 ARCH_K3
Message-ID: <wxwad77x2mxhhwdsbgiytzn6x54t4sywodjhzefwldo277njiz@ru7z54wxgelu>
References: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
 <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh>
 <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com>
 <CAHCN7xJ65RP8TO7cS0p5DwE6zru5NEF0_JA+8siT_OpSeLD7pA@mail.gmail.com>
 <CAHCN7x+EnSU8qk5dBFco=0vkeknGq18qEN7vFmZs0_q83T_3+w@mail.gmail.com>
 <CAHCN7xKffJ29zyjoJVAcy3b_d=-zkFzbL=URj4yWJWzYvRdB_Q@mail.gmail.com>
 <TYCPR01MB11269CBE8429A31DE5002A5A5864C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <nzrkujogauvn262ucxippwidyub6ikcohcjpbpn4hzj7rymctm@4owntgrmcquf>
 <TYCPR01MB11269CBAA20275E11D9AD6500864C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v6zk4jxmpuh5uajd"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11269CBAA20275E11D9AD6500864C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>


--v6zk4jxmpuh5uajd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 09:13:14AM +0000, Biju Das wrote:
> Hi Maxime Ripard,
>=20
> > -----Original Message-----
> > From: Maxime Ripard <mripard@kernel.org>
> > Sent: Friday, February 16, 2024 9:05 AM
> > Subject: Re: RE: [PATCH v2] drm/imagination: DRM_POWERVR should depend =
on
> > ARCH_K3
> >=20
> > On Fri, Feb 16, 2024 at 08:47:46AM +0000, Biju Das wrote:
> > > Hi Adam Ford,
> > >
> > > > -----Original Message-----
> > > > From: Adam Ford <aford173@gmail.com>
> > > > Sent: Thursday, February 15, 2024 11:36 PM
> > > > Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend
> > > > on
> > > > ARCH_K3
> > > >
> > > > On Thu, Feb 15, 2024 at 11:22=E2=80=AFAM Adam Ford <aford173@gmail.=
com> wrote:
> > > > >
> > > > > On Thu, Feb 15, 2024 at 11:10=E2=80=AFAM Adam Ford <aford173@gmai=
l.com>
> > wrote:
> > > > > >
> > > > > > On Thu, Feb 15, 2024 at 10:54=E2=80=AFAM Geert Uytterhoeven
> > > > > > <geert@linux-m68k.org> wrote:
> > > > > > >
> > > > > > > Hi Maxime,
> > > > > > >
> > > > > > > On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard
> > > > > > > <mripard@kernel.org>
> > > > wrote:
> > > > > > > > On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoeven
> > > > wrote:
> > > > > > > > > Using the Imagination Technologies PowerVR Series 6 GPU
> > > > > > > > > requires a proprietary firmware image, which is currently
> > > > > > > > > only available for Texas Instruments K3 AM62x SoCs.  Hence
> > > > > > > > > add a dependency on ARCH_K3, to prevent asking the user
> > > > > > > > > about this driver when configuring a kernel without Texas
> > > > > > > > > Instruments K3
> > > > Multicore SoC support.
> > > > > > > >
> > > > > > > > This wasn't making sense the first time you sent it, and now
> > > > > > > > that commit log is just plain wrong. We have firmwares for
> > > > > > > > the G6110, GX6250, GX6650, BXE-4-32, and BXS-4-64 models,
> > > > > > > > which can be found on (at least) Renesas, Mediatek,
> > > > > > > > Rockchip, TI and StarFive, so across three
> > > > > > >
> > > > > > > I am so happy to be proven wrong!
> > > > > > > Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e.g.
> > > > > > > R-Car M3-
> > > > W.
> > > > > > >
> > > > > > > > architectures and 5 platforms. In two months.
> > > > > > >
> > > > > > > That sounds like great progress, thanks a lot!
> > > > > > >
> > > > > > Geert,
> > > > > >
> > > > > > > Where can I find these firmwares? Linux-firmware[1] seems to
> > > > > > > lack all but the original K3 AM62x one.
> > > > > >
> > > > > > I think PowerVR has a repo [1], but the last time I checked it,
> > > > > > the BVNC for the firmware didn't match what was necessary for
> > > > > > the GX6250 on the RZ/G2M.  I can't remember what the
> > > > > > corresponding R-Car3 model is.  I haven't tried recently because
> > > > > > I was told more documentation for firmware porting would be
> > > > > > delayed until everything was pushed into the kernel and Mesa.
> > > > > > Maybe there is a better repo and/or newer firmware somewhere el=
se.
> > > > > >
> > > > > I should have doubled checked the repo contents before I sent my
> > > > > last e-mail , but it appears the firmware  [2] for the RZ/G2M,
> > > > > might be present now. I don't know if there are driver updates
> > > > > necessary. I checked my e-mails, but I didn't see any
> > > > > notification, or I would have tried it earlier.  Either way, thank
> > > > > you Frank for adding it.  I'll try to test when I have some time.
> > > > >
> > > >
> > > > I don't have the proper version of Mesa setup yet, but for what it's
> > > > worth, the firmware loads without error, and it doesn't hang.
> > >
> > > Based on [1] and [2],
> > >
> > > kmscube should work on R-Car as it works on RZ/G2L with panfrost as
> > > earlier version of RZ/G2L which uses drm based on RCar-Du, later chan=
ged
> > to rzg2l-du.
> >=20
> > IIRC, the mesa support isn't there yet for kmscube to start.
>=20
> What about glmark2? I tested glmark2 as well.

It's not really a matter of kmscube itself, but the interaction with the
compositor entirely. You can run a headless vulkan rendering, but an
application that renders to a window won't work.

Maxime

--v6zk4jxmpuh5uajd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZc9tsAAKCRDj7w1vZxhR
xcnGAQD5CBylgkDZNdCl/pKDpsaGrLRJbCmkrP4nBuIIyATfgQD7BuOie/iGRBWI
hBlixgDo5tqqY/4QNJmZ88R6yPkUyg8=
=cjDh
-----END PGP SIGNATURE-----

--v6zk4jxmpuh5uajd--

