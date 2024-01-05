Return-Path: <linux-kernel+bounces-17407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A75B824CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5B11C21B3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F97613A;
	Fri,  5 Jan 2024 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pTgQgJBm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DDF5255;
	Fri,  5 Jan 2024 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704420703;
	bh=8zHJ31DhC1Lvs+CITjrFIsJWiZrY43yUu1UaoB0v8ZQ=;
	h=Date:From:To:Cc:Subject:From;
	b=pTgQgJBmYzUzOq6yuE6ow78PxuIEcChbLeEpkNFhAfKtkcx+iNspmUI5ke02qR/IA
	 28RQGw8cAzpIhjyBP5CkzZy+r6U/iIeo+9IjtsPTL579LWKfe60bWkByUC6YmOGtNk
	 chzoy80hMiEN2p2PdwHSpdai+2Lvaqbx2CNkLyWQOMtjbi15vOWipMLa8JNn5UjyWK
	 3x4fMUVsNe0rpVWLimhu7eAk4nI8GrHj0If7t72h4zm2WIToENjsK2jMQU7xaVyxTn
	 cgKx/NaC29yJWyZ1iC2sXA4Ht68jUJM+qL0vMPk4hqkogDe5avY4FMzLwkMEPtWJfb
	 j4U6tJPvBn+EQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5n5B2wdgz4x1x;
	Fri,  5 Jan 2024 13:11:42 +1100 (AEDT)
Date: Fri, 5 Jan 2024 13:11:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Kees Cook
 <keescook@chromium.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>
Subject: linux-next: manual merge of the security tree with the jc_docs tree
Message-ID: <20240105131140.7afdbbe3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w=_xNN+Bd06jW.HsLm/wN.A";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/w=_xNN+Bd06jW.HsLm/wN.A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  Documentation/userspace-api/index.rst

between commits:

  77e075579e88 ("Documentation: move driver-api/isapnp to userspace-api/")
  bb67bf1c4a56 ("Documentation: move driver-api/dcdbas to userspace-api/")

from the jc_docs tree and commit:

  f3b8788cde61 ("LSM: Identify modules by more than name")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/userspace-api/index.rst
index 74bc0716432e,8be8b1979194..000000000000
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@@ -30,9 -33,7 +30,10 @@@ place where this information is gathere
     sysfs-platform_profile
     vduse
     futex2
 +   tee
 +   isapnp
 +   dcdbas
+    lsm
 =20
  .. only::  subproject and html
 =20

--Sig_/w=_xNN+Bd06jW.HsLm/wN.A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXZV0ACgkQAVBC80lX
0GzJUAf9HmWLD88EC+YlGuWOM5s1g5Gr044Vk76+rr5OXJ4k+exYa2VvtOHe8FWK
Gyh5ajnoqiqVxU1mcqhrLq7T4YD9NBja4C/dq8vVMr2KxOhh8NW4ByBFpT05pUaY
RlVUStaS7Bozz/b84+NK4FIZZ7zLbjwloQ9V6qgV+emeZ55hYQC9bTA5sX8WyEKm
EStn55pigJa05mhQBn6ZtC6SkeYOkDIBU6m9q7OMymqTQrFoBY2QXBYjsz1DK+lR
V3kRxOZTVsUYo67kRatgJ4FbdqBA5Wneph3zvGFwPuUtbnO1AdceaqKaJDumWgQT
u+NlyOu25eKPkW4wWRc4Oeslrje3rg==
=a/kJ
-----END PGP SIGNATURE-----

--Sig_/w=_xNN+Bd06jW.HsLm/wN.A--

