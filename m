Return-Path: <linux-kernel+bounces-19074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E334826780
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 05:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9791C20F16
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3263C15CC;
	Mon,  8 Jan 2024 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z3Hr1bSw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31677F;
	Mon,  8 Jan 2024 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704686429;
	bh=ZWGmc/TkEIoBlD4uE6QwGw4qomASZF7QNyn2Q4in65E=;
	h=Date:From:To:Cc:Subject:From;
	b=Z3Hr1bSwxmMTMcXIS/1wWK7xvuoKrVPZlol67u3kLY3NxCZNcGMYMGCUWN89OpA/y
	 oQT0VkBBYnlf0z3KjVF9WkwK5XsFjvtnzGVwxkAOVnq42YAN+lN4l4FtvphIBv30qh
	 JrUrWMIJ/B2M8hYClhz+qWV/Ftn58ve1brobaCLW19dCsKSa4tclgPade9LmDgDUhU
	 iHlOyV7kwsBkZuP1qI79ng90zxm+d5O/vcVl2QqX1KGWPX7RvmL7Yld5iNI9A0hvGQ
	 B7yj5czOg8QMkNktZ4w36UHg41dFbe1KDNCf7HSYd5k4do4uNbNEIfKP5Fj1WERTl5
	 6x2wUIRWuS7/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7gMJ45B4z4wc6;
	Mon,  8 Jan 2024 15:00:28 +1100 (AEDT)
Date: Mon, 8 Jan 2024 15:00:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>, Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kyle Tso
 <kyletso@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the usb tree
Message-ID: <20240108150026.2c5930a4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nGXUT6ynV7LJ=XDwtFSJuTR";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nGXUT6ynV7LJ=XDwtFSJuTR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/connector/usb-connector.yaml

between commit:

  501b15207138 ("dt-bindings: connector: Add child nodes for multiple PD ca=
pabilities")

from the usb tree and commit:

  0d3a771610d0 ("dt-bindings: connector: Add child nodes for multiple PD ca=
pabilities")

from the devicetree tree.

I fixed it up (I used the former version as there were other changes
in this file in that version) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/nGXUT6ynV7LJ=XDwtFSJuTR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbc1oACgkQAVBC80lX
0GxAuwgAk2wG3m2LPCX8vvELuAaf22OVt6Cd5F9elyfgyIiiUcQUxmh1F9Q6b7uE
XOJSILsKRYePW7QffT0akWwWGlni+Ze6faPXWG7rVXeaULyYQ63PVoZ/YMrYUyRd
ym9jS6xwZNqTvEVFxFZQ+aJIycWaQ4ykEWnEKe4P8v3RzhKFQGBEJzfrlKkvZcuK
zOSvKteA/EETbfmEUgDZiTy8bi6B3aLzs7YW4p+r5xQ8aAjzAIYpXNu1qHBizvYl
gpVjfkU9EiXc1u8LZ3DlReW93pWhqFeY42m0AeLd/VJW42n+jYc2JeyW24ghTRnb
R6HgJi0ZaJVHFSVeHgjqGnGe/PpUzg==
=IyDL
-----END PGP SIGNATURE-----

--Sig_/nGXUT6ynV7LJ=XDwtFSJuTR--

