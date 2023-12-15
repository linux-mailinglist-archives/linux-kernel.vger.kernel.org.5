Return-Path: <linux-kernel+bounces-959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D581488E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A373C1C23557
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D52D047;
	Fri, 15 Dec 2023 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCEG2K7I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F02D033
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C4EC433C7;
	Fri, 15 Dec 2023 12:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702644906;
	bh=GiYX2dByBC38vzkmfO+cvnHpKmaS1UwkM/jOuD6+MsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCEG2K7IiXiNW0BI/LX22IFcDdFusaB0moxk4gM3tIFE17Vusj49rkITKod49BNzQ
	 OxVv+oG3u0n7o5+DW57hrGNpYug3BGRf6cp3SxPegL+ozSQEOv4K+Ci6/93SRG35Kd
	 vxueSxAxnbKat/x7UDCu3vElVp5A1abi0elOXYrB1mBPR/pQ3oCAOcr1fTdZcnAGTg
	 tqJS3Eci1X+DdZhiSG+dUXr6c3hgEmGpQnlzCPqg2p/lyqjLXVH07YiOluruNjr4e2
	 ll/xiGi5OPW8PNKJ/2ORIQ4Xg/xHTSON/76jxQI3hp0romU3I8wGDHQACqGc3SqF4O
	 kN9Y2xYa6KH0Q==
Date: Fri, 15 Dec 2023 12:55:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
Message-ID: <5b2eb7eb-761e-406d-8d55-b7ea8cddefa8@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
 <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
 <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
 <47097f19398808b64f4cc87c2a3c7cc462fb2416.camel@irl.hu>
 <5f3f0306-799f-4f3b-9e05-fbd300c59d5d@sirena.org.uk>
 <b0ab21657f2e4f0825579de97ca012e294d1e743.camel@irl.hu>
 <bf24488f-e4e1-4d3e-a67e-fe74c05acda4@sirena.org.uk>
 <9a2b85a8a19e002093e2471a97850d26e335900f.camel@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="shU18Ze4Jixd/qwv"
Content-Disposition: inline
In-Reply-To: <9a2b85a8a19e002093e2471a97850d26e335900f.camel@irl.hu>
X-Cookie: PARDON me, am I speaking ENGLISH?


--shU18Ze4Jixd/qwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2023 at 02:17:01AM +0100, Gergo Koteles wrote:
> On Thu, 2023-12-07 at 22:39 +0000, Mark Brown wrote:
> > On Thu, Dec 07, 2023 at 10:12:13PM +0100, Gergo Koteles wrote:
> > > On Thu, 2023-12-07 at 20:36 +0000, Mark Brown wrote:

> > > > The code creates the impression that writing to one tas2781 writes to
> > > > all of them, is that not the case?

> > > Yes, the tasdevice_* functions, but the regcache_sync doesn't know
> > > this.

> > So this syncing is done in software not hardware?  My understanding was
> > that this was a hardware thing.

> If you mean that the amplifier does not know that there are several
> programs or configurations or profiles, but only runs the current one,
> yes.

No, I mean that the amplifiers don't talk to each other at a hardware
level and the grouping is all in software.

--shU18Ze4Jixd/qwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV8TKQACgkQJNaLcl1U
h9BTCwf+Pa4K2iMEqoqOz+oegGtyQpvdi/qVCmxb4ZTXaxolUdaQy2PaXjRLd8HX
JvKRqh83icW7itxjaoT9Agm9u5YYtIitbHZa0EZgFPu7W7wbssEMC/PJDVde1FcF
roRv64St87ObvZdagd/XFu2ZGqmFkVbRuvwsiDMAL6XImcCmZPixV8rT73+Vef+U
FmJ7f31B6G07xb2nO5MklywF98z97eXc75Rg8QDleMNPe4/H6bDyLbfTDUF5DAnG
vIzC6Qxm5+dXLLa2V5yZhY0xWOCNJDrmwv7bv0c9M74QigdTTtsI/JmOIj0yJjg/
m5ZFOlNVFJgDi9IzWD5gcsxzhvTymA==
=DJ8M
-----END PGP SIGNATURE-----

--shU18Ze4Jixd/qwv--

