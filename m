Return-Path: <linux-kernel+bounces-68303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADA857877
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96E42861E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA471BC30;
	Fri, 16 Feb 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM8xGeTM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBEE1BC20;
	Fri, 16 Feb 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074332; cv=none; b=l4JnY53Evy5DAQsboQI1dQloNFxNOx0ueiZ5Hpxl9z0v1GAD7RGTaqnLZS6+TEMbblpdkUYdgG1JGd/nPyd2tuWIEULgBnU61enruqZWXDlVE1xhNmhcGiq511vZUli/HSx+0pBEU7mcV9xT6AAIYO9/Ao/2Exz5I/O0u+8z+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074332; c=relaxed/simple;
	bh=f2wh1QsEa1UsaNBdVYAdNAwqa6OdTmucGngu4R41lrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgmboJBrtyW6lh+eNnebK4kAtOi2muWOoyO8oFGCfv3eaHvsQo+M53fwsTglYwc8lXbmdd0W+KaXklZ1ObToOTgsdPl95Dz0YGppeEuqQTZMe8JavcVUZZizay8Lg6LewlFHFCLsFlNq+cBLvwzXKAWWR3btkdspJoKcHDtdHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM8xGeTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E738C433F1;
	Fri, 16 Feb 2024 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708074330;
	bh=f2wh1QsEa1UsaNBdVYAdNAwqa6OdTmucGngu4R41lrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UM8xGeTMH6VNRn/x6xgWIILBOdW34CH016Ah5Pr6BtdNOWDTxVNYW7CVYcjQKnx1C
	 oB5UPpxsHWVvIdjJAzVtSMQU2V2sCRbbA6okH2gzQqM55bJNyurZ3V9m16wNQKzcBI
	 xbQtyywF85B8kP55MK6T9GMZz7OIE1VF9jlrqZIqGRCJtOAENKRua7ITqvH084oTdk
	 CDH6T1WPnCSGYlp+hP7LCiw/y4DJMdkWXLlPbc6xuwQ9znxLEFkxNFw2mVujk9oxsf
	 Bxykp6LgWXWczNPjJYc/nkNtzxQrkhiFcXBVqjWJeIYl4mYek0RVZel6m0MKgL3F6i
	 gj/V8zESMI34A==
Date: Fri, 16 Feb 2024 10:05:27 +0100
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
Subject: Re: RE: [PATCH v2] drm/imagination: DRM_POWERVR should depend on
 ARCH_K3
Message-ID: <nzrkujogauvn262ucxippwidyub6ikcohcjpbpn4hzj7rymctm@4owntgrmcquf>
References: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
 <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh>
 <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com>
 <CAHCN7xJ65RP8TO7cS0p5DwE6zru5NEF0_JA+8siT_OpSeLD7pA@mail.gmail.com>
 <CAHCN7x+EnSU8qk5dBFco=0vkeknGq18qEN7vFmZs0_q83T_3+w@mail.gmail.com>
 <CAHCN7xKffJ29zyjoJVAcy3b_d=-zkFzbL=URj4yWJWzYvRdB_Q@mail.gmail.com>
 <TYCPR01MB11269CBE8429A31DE5002A5A5864C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7qyxpf6ga5atuhgo"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11269CBE8429A31DE5002A5A5864C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>


--7qyxpf6ga5atuhgo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 08:47:46AM +0000, Biju Das wrote:
> Hi Adam Ford,
>=20
> > -----Original Message-----
> > From: Adam Ford <aford173@gmail.com>
> > Sent: Thursday, February 15, 2024 11:36 PM
> > Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend on
> > ARCH_K3
> >=20
> > On Thu, Feb 15, 2024 at 11:22=E2=80=AFAM Adam Ford <aford173@gmail.com>=
 wrote:
> > >
> > > On Thu, Feb 15, 2024 at 11:10=E2=80=AFAM Adam Ford <aford173@gmail.co=
m> wrote:
> > > >
> > > > On Thu, Feb 15, 2024 at 10:54=E2=80=AFAM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > >
> > > > > Hi Maxime,
> > > > >
> > > > > On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard <mripard@ke=
rnel.org>
> > wrote:
> > > > > > On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoeven
> > wrote:
> > > > > > > Using the Imagination Technologies PowerVR Series 6 GPU
> > > > > > > requires a proprietary firmware image, which is currently only
> > > > > > > available for Texas Instruments K3 AM62x SoCs.  Hence add a
> > > > > > > dependency on ARCH_K3, to prevent asking the user about this
> > > > > > > driver when configuring a kernel without Texas Instruments K3
> > Multicore SoC support.
> > > > > >
> > > > > > This wasn't making sense the first time you sent it, and now
> > > > > > that commit log is just plain wrong. We have firmwares for the
> > > > > > G6110, GX6250, GX6650, BXE-4-32, and BXS-4-64 models, which can
> > > > > > be found on (at least) Renesas, Mediatek, Rockchip, TI and
> > > > > > StarFive, so across three
> > > > >
> > > > > I am so happy to be proven wrong!
> > > > > Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e.g. R-Car =
M3-
> > W.
> > > > >
> > > > > > architectures and 5 platforms. In two months.
> > > > >
> > > > > That sounds like great progress, thanks a lot!
> > > > >
> > > > Geert,
> > > >
> > > > > Where can I find these firmwares? Linux-firmware[1] seems to lack
> > > > > all but the original K3 AM62x one.
> > > >
> > > > I think PowerVR has a repo [1], but the last time I checked it, the
> > > > BVNC for the firmware didn't match what was necessary for the GX6250
> > > > on the RZ/G2M.  I can't remember what the corresponding R-Car3 model
> > > > is.  I haven't tried recently because I was told more documentation
> > > > for firmware porting would be delayed until everything was pushed
> > > > into the kernel and Mesa.  Maybe there is a better repo and/or newer
> > > > firmware somewhere else.
> > > >
> > > I should have doubled checked the repo contents before I sent my last
> > > e-mail , but it appears the firmware  [2] for the RZ/G2M, might be
> > > present now. I don't know if there are driver updates necessary. I
> > > checked my e-mails, but I didn't see any notification, or I would have
> > > tried it earlier.  Either way, thank you Frank for adding it.  I'll
> > > try to test when I have some time.
> > >
> >=20
> > I don't have the proper version of Mesa setup yet, but for what it's
> > worth, the firmware loads without error, and it doesn't hang.
>=20
> Based on [1] and [2],
>=20
> kmscube should work on R-Car as it works on RZ/G2L with panfrost as earli=
er version of RZ/G2L
> which uses drm based on RCar-Du, later changed to rzg2l-du.

IIRC, the mesa support isn't there yet for kmscube to start.

Maxime

--7qyxpf6ga5atuhgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZc8lVgAKCRDj7w1vZxhR
xepyAQCELyUwolN79rHm8W/imYO1o+sXScI/7WVY7KyqlDvzfwD/af+pQ1kUutaA
1pOy7cp+cy96j/y6GiXH461qSXg2GAQ=
=qTsf
-----END PGP SIGNATURE-----

--7qyxpf6ga5atuhgo--

