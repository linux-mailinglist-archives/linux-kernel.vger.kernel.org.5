Return-Path: <linux-kernel+bounces-20221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9FA827C20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60AB1F24204
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EF820FB;
	Tue,  9 Jan 2024 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HjleAEpb"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0501844;
	Tue,  9 Jan 2024 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704760757;
	bh=2UkU1zXuyrj9uhb04wW1flvLjJxw0dBB96g5Co3MsX4=;
	h=Date:From:To:Cc:Subject:From;
	b=HjleAEpb7ZLnCMMrdwOKY6zqLo636fnDECOVXmioER16q3nb1rQAb6JxrWLpkGZ/i
	 NNhTxl18mf+cApkfi2U1SIK99em1x9sllih1p6Ilcv9GUQGVl05DtNpLJdc+x92qN1
	 YJowtLnfYKm7fGkYxOtOYfEC6RSoHtS+pEhceAaj+SmSsCGUbunDFry2trRdRqLYO5
	 otzdBmyCjqEnzwQJ5VvVr7hjSKMqBOpUzcy1p/O9R6e4d7DIWkkI8msnRPgSfKHv4R
	 95vWa+tOC/YfeuCcB2S4bpH4QucWZXcs2x2HUkp7Sz1l1P6jHfFjZ3snroxDJy/f65
	 +S+2sieWNPO/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8Brh3Q3fz4wx5;
	Tue,  9 Jan 2024 11:39:16 +1100 (AEDT)
Date: Tue, 9 Jan 2024 11:39:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Helge Deller <deller@gmx.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Wolfram Sang <wsa@kernel.org>
Subject: linux-next: manual merge of the fbdev tree with the i2c tree
Message-ID: <20240109113914.6178e733@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S4XzLAGRd1An.SU4qJCQTSB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/S4XzLAGRd1An.SU4qJCQTSB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/video/fbdev/intelfb/intelfb_i2c.c

between commit:

  ef2984d633ce ("fbdev: remove I2C_CLASS_DDC support")

from the i2c tree and commit:

  256b7e8673a6 ("fbdev/intelfb: Remove driver")

from the fbdev tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/S4XzLAGRd1An.SU4qJCQTSB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWclbIACgkQAVBC80lX
0Gzypwf+I2UEReqUi4MWfsD7wj28JIiWIcbGGngzRduGQCAI4tQrnuCeV87JTMnK
wPqOsmH3Uws0p9wD3Hfec/yEMMrhtWlfXzW6071T8YEKUnevVIWgEQZJB4w3ahQr
xle8Z4Y25AZA592ytOE7vmtz9hLrN44B5zGLCZdn8D2eNuKn7LvzWqXUg6YydVml
dk2Ra7U3jVCP3LDM2Du+aGP/iSjia5nrIILE2ySnDmObyT54HAMm/BzUwyqn/Se+
STB5csV7Q45plkr/XnUEM5Lv5lv4P8zfWiAKanhY+HwO3e4HuAyppavWaF3ZfMhX
jUy+YIyGuxgTjs4sKpxcu9StfbaNaw==
=Nud9
-----END PGP SIGNATURE-----

--Sig_/S4XzLAGRd1An.SU4qJCQTSB--

