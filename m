Return-Path: <linux-kernel+bounces-5945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2931E8191D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF00B231C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3BE3A1B9;
	Tue, 19 Dec 2023 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Lcx1T6rp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFB39AEA;
	Tue, 19 Dec 2023 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703019473;
	bh=HL+J12pGhDwMatKlkflli5mu1mZB75z2ODA2GA/b1lU=;
	h=Date:From:To:Cc:Subject:From;
	b=Lcx1T6rpxvGwsRI7qdwtAsV2Hefhi8R6YM2K118OqEW1F3b8PLtsE4yV2lIY3rHM5
	 dyYSzCnJEvqYT+iNxV2xFyXWNBatw3/tdOxpJEga+rSYepXMcGIqcqPq/TtVMZUGAO
	 EPz7fjYolqgsx2y+NAK4NbW2CcyOVxSvZ7ZvvIFZzG/k+Hxu4ePsSbaVuI4PU9R7Ia
	 GGuDYCN84FFXIEioDqG/GaYZSSiKA8Y/6UmjYl7xVXIC/d5VF1vzXTehe0Ov0r51as
	 Al5aaRTlAOaBKiiO+0K+PRUGaq7rMfOW+2r5fbpYnfFVuK199H1+V5rfRHdWzGoHhZ
	 ti8hcluPI3eFA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvptT1Rfjz4wdB;
	Wed, 20 Dec 2023 07:57:52 +1100 (AEDT)
Date: Wed, 20 Dec 2023 07:57:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>, Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20231220075750.19541c67@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B9wA7/bc.L3DUIsAuTRRMxS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/B9wA7/bc.L3DUIsAuTRRMxS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  340943fbff3d ("net: mana: select PAGE_POOL")

Fixes tag

  Fixes: ca9c54d2 ("net: mana: Add a driver for Microsoft Azure Network Ada=
pter")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/B9wA7/bc.L3DUIsAuTRRMxS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWCA84ACgkQAVBC80lX
0GwbGggAj9qHrs5DFB1oOI5tpHL58AuwA/yPDi7pXV386Wyk8VFTCSR3QOhqsu0U
80NRS/roDih6w6XcfKTuKSYWHJKf2J7kT6HzaFMpxtmiyKxAcePdsm6ZZDFSbRV7
S4lJi3Qh+34LFpYO4Tb26/1uQdUXvG4KvteWVNX+08/xX3vWR0aeNZxtq424DEeT
whfdU1H1etjN+Lt8tpDmlKgES+iM+fhNeuWN5tyxCw12PVYs0oh2KtlRWNFbvWKP
1sNwzna9nTbHaOtNg0gNTZy7m1DQ0boM+tf5oqv4+DMoz6gy5bOzXOtWI/boW+7+
/FTWRfU6G+uU5Z4CR1tBFwb/U+G4Bw==
=mpp2
-----END PGP SIGNATURE-----

--Sig_/B9wA7/bc.L3DUIsAuTRRMxS--

