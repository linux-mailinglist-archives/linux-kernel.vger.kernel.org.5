Return-Path: <linux-kernel+bounces-19057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D0826757
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5631C20819
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B136D6D5;
	Mon,  8 Jan 2024 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ba7B1aEe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178E1364;
	Mon,  8 Jan 2024 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704683234;
	bh=5a+m4uiBLce08WIeCid5K2za95zqkWU2/ciHOKAyf7U=;
	h=Date:From:To:Cc:Subject:From;
	b=ba7B1aEesenpyizvEpCUdOXw4l5PsJGx3BEzvSkxRyNiGUjNEd96PvSh8UHMfYQQh
	 Blq6h9I1AWaY1hs7xv0f5p7b9frJDoHPsFVqgrnjEOxrWUZIS8iO2xUsfekeSdOLCS
	 ycTAHucXgFKjcdL7R+nI66j0YlrahdM/c4yZVisD/jFHPXI+bTTuYkr8q09euWak6j
	 HTzoOWMVLOESeA/wx5gZ9et4LiEJoSLomaXaEzaNfeeKiPjcyeFWr3hoTKRJ/T8Jvs
	 A7GYKwhyzD+U1RkOVmOkI5le5xd5w40ADzBDiycxmaH5kA9uzKFZDIfTfCtWcYAeE6
	 22D4dVrPpzOsQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7f9t07Ykz4wch;
	Mon,  8 Jan 2024 14:07:13 +1100 (AEDT)
Date: Mon, 8 Jan 2024 14:07:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>, Tzung-Bi Shih
 <tzungbi@kernel.org>
Cc: Chrome Platform <chrome-platform@lists.linux.dev>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the char-misc tree
Message-ID: <20240108140713.143f27e1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BYnEZsThSNEHzOW2YdvWmzt";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/BYnEZsThSNEHzOW2YdvWmzt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the chrome-platform-firmware tree as a
different commit (but the same patch):

  f69583d32fcb ("firmware: coreboot_table: Convert to platform remove callb=
ack returning void")

This is commit

  09aeaabebdaf ("firmware: coreboot: Convert to platform remove callback re=
turning void")

in the chrome-platform-firmware tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/BYnEZsThSNEHzOW2YdvWmzt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbZuEACgkQAVBC80lX
0GxtpAf7B6xUxFHzDSAa0ICEtFT3C1zVbX6Rjq686Pxw9woWau3joExL6w85DngI
r8Q8SlyeVHYq6oMYbh7BZVNMlc2cx7mjsdWa8FvGUrZ4LXnAvUbHsJbSFjUY8oI0
igRjMoMOcYkIoWSoeevnmfj2JIE7sn3nJe5JSMUfpobZ634ijADxQZqYEpGg+QG6
82G0zZ/lHmnJibCynMzpjVWBSU2rMogUJGN+X02uhZbSp2o8Y26aBK6vPdr4DfYM
CgopsP/fZ9iryibLd8v0Gjer9wyHJv6lAuZqr1y6PIl8rnhWSvr+bT3B4gZG1cMC
VVkKX5dOGZw7L98MRotXWOgV/faWsQ==
=l3uy
-----END PGP SIGNATURE-----

--Sig_/BYnEZsThSNEHzOW2YdvWmzt--

