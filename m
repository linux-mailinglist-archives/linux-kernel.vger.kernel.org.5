Return-Path: <linux-kernel+bounces-3004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307898165FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D241C221FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27E63C5;
	Mon, 18 Dec 2023 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i1Gn4axe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB663A3;
	Mon, 18 Dec 2023 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702876626;
	bh=LWVOdWD/fLbAF9XWd/EZxP0KqVqq36W6xaUInLOkyI4=;
	h=Date:From:To:Cc:Subject:From;
	b=i1Gn4axeu1xP1TncM7AA8O75dLhftWe69pSXlvBmz8zeAVAM1pfvYyUkSyTA23jPF
	 jqEU4lTDMTJ1eV9z66yLosr2bTAHiCvU4c+hKd1d2liFyVuHZmFHTWxiVloOM4/4so
	 LXkTqH+xLOxopmWP4W6eda3qo/Gsn0QiLlfx/NytEtFggGSq9kae9uHubRy/EdHISj
	 ukS3lzB78tUsAjWa79VHs1Hv0MFUBL/SMOp9RgXWU0kHhNyFwspm8mAS+tLztQbwFh
	 PuEowwiomaAvt8q1WAwozbTUdvkBnvelPmsl89HZF5sW/OB65M76gKSBvWd58PefOv
	 gDmhvABmyZMug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Stp3P38L7z4xR5;
	Mon, 18 Dec 2023 16:17:05 +1100 (AEDT)
Date: Mon, 18 Dec 2023 16:17:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Alexey Dobriyan
 <adobriyan@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Trevor Gross <tmgross@umich.edu>
Subject: linux-next: manual merge of the execve tree with the net-next tree
Message-ID: <20231218161704.05c25766@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sb5s7lOXLc2X.vewol.vAXH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Sb5s7lOXLc2X.vewol.vAXH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the execve tree got a conflict in:

  MAINTAINERS

between commit:

  cbaa28f970a1 ("MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LI=
BRARY")

from the net-next tree and commit:

  0a8a952a75f2 ("ELF, MAINTAINERS: specifically mention ELF")

from the execve tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 1f53b4c593dd,08278b9ede48..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -7919,15 -7797,7 +7919,15 @@@ F:	include/uapi/linux/mdio.
  F:	include/uapi/linux/mii.h
  F:	net/core/of_net.c
 =20
 +ETHERNET PHY LIBRARY [RUST]
 +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
 +R:	Trevor Gross <tmgross@umich.edu>
 +L:	netdev@vger.kernel.org
 +L:	rust-for-linux@vger.kernel.org
 +S:	Maintained
 +F:	rust/kernel/net/phy.rs
 +
- EXEC & BINFMT API
+ EXEC & BINFMT API, ELF
  R:	Eric Biederman <ebiederm@xmission.com>
  R:	Kees Cook <keescook@chromium.org>
  L:	linux-mm@kvack.org

--Sig_/Sb5s7lOXLc2X.vewol.vAXH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/1dAACgkQAVBC80lX
0GywbAf/TOkJk8PIJfMxee5eFdEOj53IKYndCRs1kVkMhFjRf8x7pMknWGqxDXZe
AnY2cmCl4WUCybJbTVOJtt1qTRPYrqzxlqOq3DP+vrGvOWwkk9qoGgtk2v8Vr1hZ
0ErE2gFg4sQJw6HtASMgGILc+DBpFSHT/7pnsvanYA+jzydGRPT6N7GITiZNp5MR
tgkhuIr5Uo39Gs/O1YVaplg6vDcKOZW03faVTMT5vLhm0LxgWm7j/Ygh431tb6Ae
a816ZYP2Q61KBXeAEJt6yY6CPEOcR4OFEIYc8D+Q/3RkdG5UGXLUABlVERBNL7LB
4G6ohj2mzKevAWwNiMgFEBVBH9ctBQ==
=9Kgs
-----END PGP SIGNATURE-----

--Sig_/Sb5s7lOXLc2X.vewol.vAXH--

