Return-Path: <linux-kernel+bounces-1148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBF5814B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1331C23A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0A4364C3;
	Fri, 15 Dec 2023 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmt/0byx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED997364A7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D9EC433C7;
	Fri, 15 Dec 2023 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702652546;
	bh=7Uq12NB3Lqmbyv5BBuMWFV0Ip7hUgad8tYf8ESmKAd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmt/0byxqdwxs1tIKjUxtRAvGv1Lixtlv6Svzfa1IYAnHHWZi12E9s5m0y6sDh+86
	 wnT3cvE3mCaqBEViRK8vFTkffUFmqilB+aEismErN70gta3lMn4YTSyH5UERIwMPEz
	 64RCbSbd9GDfFzmXRtmPlJVCFBC4wHQUBjxSlwxXmO99ikm/s2fhUYfaosusaTLczK
	 jrIyftKCgAS5jDWH04h14OXed/QxqgkA9q0/JDOqB2SFovtYI5lo/x8jjTzlyGdcMi
	 bPmp9pudhOmkdMX58WT49ICJ+Cac5I47zj2AeeTg9uu2ta2AaXcIObAUU4xNxrXvND
	 o9YELesNRPFIA==
Date: Fri, 15 Dec 2023 15:02:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
Message-ID: <e5ee2ef9-2cf5-46aa-adae-27040faccc3d@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
 <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
 <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
 <47097f19398808b64f4cc87c2a3c7cc462fb2416.camel@irl.hu>
 <5f3f0306-799f-4f3b-9e05-fbd300c59d5d@sirena.org.uk>
 <b0ab21657f2e4f0825579de97ca012e294d1e743.camel@irl.hu>
 <bf24488f-e4e1-4d3e-a67e-fe74c05acda4@sirena.org.uk>
 <9a2b85a8a19e002093e2471a97850d26e335900f.camel@irl.hu>
 <5b2eb7eb-761e-406d-8d55-b7ea8cddefa8@sirena.org.uk>
 <f135963cb14d9bef6cddbe0bd1ce0aaa6d4ac7d9.camel@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NJ1n80rz/G09dKBQ"
Content-Disposition: inline
In-Reply-To: <f135963cb14d9bef6cddbe0bd1ce0aaa6d4ac7d9.camel@irl.hu>
X-Cookie: PARDON me, am I speaking ENGLISH?


--NJ1n80rz/G09dKBQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2023 at 03:42:43PM +0100, Gergo Koteles wrote:
> On Fri, 2023-12-15 at 12:55 +0000, Mark Brown wrote:

> > No, I mean that the amplifiers don't talk to each other at a hardware
> > level and the grouping is all in software.

> No, they don't talk to each other. But they have a global i2c address
> to speed up configuration, but the module doesn't use it yet.

That's hardware level synchronisation between the devices, that makes
all this a bit less horrifying though it seems like a lot of the issues
would go away if the broadcast write address were actually being used
more.

--NJ1n80rz/G09dKBQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV8anwACgkQJNaLcl1U
h9A4aQf/cqN2aD+4gfz7tn5+zGNcYbOnxBwjcif5LeQFESiiPswlZkYhCE9WaV7T
6TiNXejvAQgg4B68jz095xef6UA3iZLlWiBmIjUywYNHfaODdrn8sYAbvzPwn1gC
zVd2mvNaMpUPfEuvlLinLm4+f5t2Ij5n+6v0yfPPpPgXr+Ej+mpX6hwgeV792uBB
hYoPyJP0pBF30PuIA8Hwh8ur1SmGxEUb/jdud2q9BY3L1tsNPC45LfyeNqyWtCkP
crWfXJzmr99txwkARhkybS8d7vzjuYchJsg6W9oDE0pCUSGPK4Yjz4Duor6Z2qT5
w1lTECv+bXmgRL2bcs5iAmKwl+K+KQ==
=bLE1
-----END PGP SIGNATURE-----

--NJ1n80rz/G09dKBQ--

