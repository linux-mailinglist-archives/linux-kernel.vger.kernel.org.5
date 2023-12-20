Return-Path: <linux-kernel+bounces-7651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BFA81AB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057B71F24747
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9674B15B;
	Wed, 20 Dec 2023 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TDaD5Y/x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3F4B150;
	Wed, 20 Dec 2023 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703116361;
	bh=m0Lb4XC1o9pGevEvKRp00ahDVelGACJyDn5HW36/lkE=;
	h=Date:From:To:Cc:Subject:From;
	b=TDaD5Y/xTrbNOJB8sFBQ8IQnxAAiZcbA+0jhfROtxkw+s36zrOssin/038VunDiml
	 EX52of0CXd2L6pCxZvKSb206t8md8u20UmXyYZroehONWNJooJceRauUK9pOr+cvUp
	 Qo7MS/EbE0vts2lMgB7SeUcGauw2W+9SU6kQ003MW2iMJgSynvXmgshBR6xMOylt/N
	 HaEBsNIavGrJSV6HVU+PJvAqB5NiDVHrGAoUO3Wx6/vjaAa+0J8eQf08Hnlxk+Y7UC
	 8sg2gX2Pk7UoYjF3mPqaJ9+eK3ExM3dLIlf7pXWRYzJ2GpEEZiW+iRxT3Z0GzBJ8hu
	 psFu9EOZ36DEQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwVjj11BVz4wd4;
	Thu, 21 Dec 2023 10:52:41 +1100 (AEDT)
Date: Thu, 21 Dec 2023 10:52:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the mm-stable
 tree
Message-ID: <20231221105238.4d16892a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UQvRs_nl0/Vvnj2w2aH_dAD";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/UQvRs_nl0/Vvnj2w2aH_dAD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/afs/write.c

between commits:

  8525d5984b7b ("afs: do not test the return value of folio_start_writeback=
()")
  af7628d6ec19 ("fs: convert error_remove_page to error_remove_folio")

from the mm-stable tree and commit:

  874ff39da314 ("afs: Use the netfs write helpers")

from the vfs-brauner tree.

I fixed it up (the latter removed the code modified by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/UQvRs_nl0/Vvnj2w2aH_dAD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWDfkYACgkQAVBC80lX
0Gwxngf9Houx3yuHoZXUI8LLchJdw971OE64uunJGARtuR1GLHU2Y6KmUHWvYV23
wVAjQ+SvU/rYqFmkKDoZM23GFRUhp5nXQjOsUvJ4043xek7pqHSF8aC0GCL08BP0
2yljE68SA7yuqypzDg6wMOfZbTqOfI/GAtCQ/wlzeZIOIj9J+uI1nHcueEH/44rg
nAAVUMaElXCEWQwkfn27GEeRX3lL7o4TVntcp93LJc3ljghc4C5N1IgOTiKWY0Yw
F7yZcEegPuuWqedZfmd/pdmKDf/BZ2iagRHKDVyU/TpNzSbis+cGpv/NaUKEPNr3
kdQrwmHPYW320fTfGc+f8C0ke26jPw==
=p6fs
-----END PGP SIGNATURE-----

--Sig_/UQvRs_nl0/Vvnj2w2aH_dAD--

