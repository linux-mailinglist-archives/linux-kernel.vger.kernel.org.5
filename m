Return-Path: <linux-kernel+bounces-3011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9594816617
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743DF2827FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB663DA;
	Mon, 18 Dec 2023 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DbhgfMK9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44C63C5;
	Mon, 18 Dec 2023 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702878125;
	bh=x9ABy5vCpnKgmRlRZ90DI4YDdJgQGcJKqGSjNRufGGk=;
	h=Date:From:To:Cc:Subject:From;
	b=DbhgfMK9uGSsLqdZdbHpDmrkuzRR4RL9INGBMWPAp2g0IT8hbDRCn/xlPP4dO+ZN5
	 LXs6iLXio2AX3siw+/E+PKCpFRiQxDTOBEV9dbxZjOMNgpJpIh4dA3Ll/5d9W4lnLm
	 hEmktBpyMWkUOQr8/o221dGFh3Rwrgh+hQfgS6P35zj6VXt5Z3vrUGW9lKdtI+1Ilx
	 +cNY05PSYOt0UpV5UMg+XOF50lFlXTfQcjIBXb8iocrNqreWeJs7qgsD1qz8Epso7P
	 fN9PJF/nJOvXCbdoOwWakAB5/FDXmUfA5SiKrwZc6tBrnoLs4xRVAB0ZbWCol5S2lS
	 SnxgXrBKbletg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4StpcD29n3z4xM2;
	Mon, 18 Dec 2023 16:42:04 +1100 (AEDT)
Date: Mon, 18 Dec 2023 16:42:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>, Greg KH <greg@kroah.com>, Arnd Bergmann
 <arnd@arndb.de>, Jarkko Sakkinen <jarkko@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the devicetree tree
Message-ID: <20231218164203.530ad4f7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qsN_.e7Or5x+KDHl86iA0Qy";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qsN_.e7Or5x+KDHl86iA0Qy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in various other trees as different
commits (but the same patches):

  11844f340318 ("cdx: Explicitly include correct DT includes, again")
  319e31686b9f ("tpm: nuvoton: Use i2c_get_match_data()")
  5adf0863e467 ("serial: esp32_acm: Add explicit platform_device.h include")
  68398c844813 ("serial: esp32_uart: Use device_get_match_data()")
  72cc46a84b80 ("pci: rcar-gen4: Replace of_device.h with explicit of.h inc=
lude")

These are commits

  aaee477e3e2c ("cdx: Explicitly include correct DT includes, again")

from the char-misc tree

  ebf2d4e8e582 ("tpm: nuvoton: Use i2c_get_match_data()")

from the tpmdd tree

  2600d9939440 ("serial: esp32_acm: Add explicit platform_device.h include")
  3d19ff562d06 ("serial: esp32_uart: Use device_get_match_data()")

from the tty tree

  ec2152374804 ("PCI: rcar-gen4: Replace of_device.h with explicit of.h inc=
lude")

from the pci tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/qsN_.e7Or5x+KDHl86iA0Qy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/26sACgkQAVBC80lX
0GyAWgf/WzLidDn/pnzIIYfzXPAdRsuUenXGZZQdqu9bGMTvUAPM2TaD6/z6osP5
b2/Ue6gzVmDFZkJxv39is00Aipp5VZUCcdZU1LUzEHSSLTwctSy8W5i51LZO9Xr/
Eh5BsHLp26LraWORjl9QhLF7AppRfGub/Wr41b2z8S1GG/DiwXrN195R2g9dM+je
czLoZeh1SakzlJgBWx9ynofl4cJDQYvhEK6/XH9cuv13K3BIa0DUIp3g6RYF/k94
4cp91wJo5sZFkxoNH4iRQnIdh9QGijAxBDBYc2k9BdJf+DM8Zt0nXzaak4CXeau9
hFTQjXns+541l2EbySp/8x1qX3xstw==
=g5tz
-----END PGP SIGNATURE-----

--Sig_/qsN_.e7Or5x+KDHl86iA0Qy--

