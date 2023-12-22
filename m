Return-Path: <linux-kernel+bounces-9742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A20881CA8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F931F23DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC16199A1;
	Fri, 22 Dec 2023 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdxtu3RV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E518C20;
	Fri, 22 Dec 2023 13:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B373C433C7;
	Fri, 22 Dec 2023 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703250741;
	bh=xS/5BkwNjiV5hpdPugZJOwMiBhSFW+hk0HU2Bv6voh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdxtu3RVRyGkr7oHJwIx469kclPpWiKmkQsLgLwoeOgAV8kj4j1Mp3hZWfDCQIXjV
	 Kq6u/c+mAXgNReDmX9lpy10wUcVwNGAN/sBxUG4qovAz+7fMFwYJ/N1KNZE5IsZzT1
	 iqmEwHbbVAaS+tU286mq4vuUf6bCJB+wj+iYCYfMWfJvbVkxJSArWwplAu4lR/oVKq
	 gtCLgNf9Uldggif9zfA4ow/JLeD3ouBciDd8VPld3VuLcztt5NzWeH/QcEBv/U5esV
	 x2miXDH7ckIPAs3QaNQH64AK5/HbLzLQzExPSaEzhazvgIRmDy8O7xOPi7U0W7hhO6
	 Uhl9ScBMFsSCA==
Date: Fri, 22 Dec 2023 13:12:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: do not use regcache
Message-ID: <59d1b8c5-d57f-4e0c-a083-2afa1151823b@sirena.org.uk>
References: <491aeed0e2eecc3b704ec856f815db21bad3ba0e.1703202126.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XgMk3W0ruc1CbKKK"
Content-Disposition: inline
In-Reply-To: <491aeed0e2eecc3b704ec856f815db21bad3ba0e.1703202126.git.soyer@irl.hu>
X-Cookie: Familiarity breeds attempt.


--XgMk3W0ruc1CbKKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:48:56AM +0100, Gergo Koteles wrote:
> There are two problems with using regcache in this module.
>=20
> The amplifier has 3 addressing levels (BOOK, PAGE, REG). The firmware
> contains blocks that must be written to BOOK 0x8C. The regcache doesn't
> know anything about BOOK, so regcache_sync writes invalid values to the
> actual BOOK.

Acked-by: Mark Brown <broonie@kernel.org>

--XgMk3W0ruc1CbKKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWFiy8ACgkQJNaLcl1U
h9BUmggAhajnsdiUj4Nk7Jcnz2WIP3eRE2vHqZPTJhYsfkBd7u3Yn9DMdoH0goPc
UcxQT53S55+f6UNFGS6NcrDs+h3iM0i5PIfrfCSMCdIuYs+87yGJhITecY/cT828
JYN7tDEHav3SrMdpbEqtEFpSUhyaoRkxCN3l/e4RP5Szi4uYGtqcxAXP7xR5HjsJ
fHwyDCYucrE5cBDKUCkhInxWVP5X2pxrTN9KbgRYuc3TTKW05q4AeRKObrHGuDlc
8kIoxdeyzC8Kp30037CJdJftbR+Zolyy4s3WGpMugFSuJvizSVqh/pIS1Y/cA5Mo
IWOo4LBa+sesOuYFbs2nUbhdTB5sLw==
=Z9xT
-----END PGP SIGNATURE-----

--XgMk3W0ruc1CbKKK--

