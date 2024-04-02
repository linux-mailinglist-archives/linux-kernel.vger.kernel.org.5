Return-Path: <linux-kernel+bounces-127239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49B1894878
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994CC283363
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF41E33DD;
	Tue,  2 Apr 2024 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="joenTY2f"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E6ECF;
	Tue,  2 Apr 2024 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017671; cv=none; b=Q57yBlD3sOB5Do/i/2OY5wGGpZ0qT+NrOPHlqI7JAesk+mnQvT9ir7SfF9NFb/Qfk9Z0/vI5tKEZdtW+k0wuU9tPSzdvV9dPgmpX6K4Biwd5RCYzY/Bc/paBSAzxI3FGFvw215OU57cj1ri4XcxC8+as4vVMhACiX60i896IJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017671; c=relaxed/simple;
	bh=6jlFcAuxxoQdEkeDSU9uqT7eAMtD4R0vSIfzBlfF7J8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rKN0ubs9o6mRcB1NQ+wXwLuGtVjX9NGJZHbgBXi6v+cEtsGtXCN3Yjn+40jI+zeCFBJuUfCUn4EqhrfaZroWesHDzCd+GkPvxmDsDjTwFaTi6JdIOhvasIwyQQyG9wd5VUhIw324qLZUY3TX4J8CJ08x+1O1RZG+49TMi0JMjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=joenTY2f; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712017667;
	bh=jaHzo1qsg1YeMeDhBu188OTMGpmSBamVzfdb+BTdZDc=;
	h=Date:From:To:Cc:Subject:From;
	b=joenTY2funCnXlyGTKAOt9cYNd4ttZlk7RHVXRrqd843NIESN2ptQ9N4KyOFusEzH
	 FFFWrdzK3L7+bY55RfNRE29vuQCoWiHLQHQpLWGtsx+reptYwsvvWrYZi1rbrO7wqo
	 jnQLnmKsdG+ECR6X1lke0txoP3h19LGM0etPebQFormNJO3blZ3xUWaWhUJ44DtY61
	 6YEfGN6bPFAM3Rhb/kQNP4tnU/axgLXd5e0Xb27r6oc7l4zM9W6S6MXMSjBOJD0OIf
	 ZvllToLic2bUboLosoKfVloG2lpjfnYCS9vYDOoK4MJ6BNbr84NNhOej6047jNF9yJ
	 HM7CEDJi8I7Og==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7pcf4x2Fz4wxt;
	Tue,  2 Apr 2024 11:27:46 +1100 (AEDT)
Date: Tue, 2 Apr 2024 11:27:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>
Subject: linux-next: manual merge of the block tree with the mm tree
Message-ID: <20240402112746.3864d8a6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LHq.6lj5WucWIARp22HzB/I";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LHq.6lj5WucWIARp22HzB/I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the block tree got a conflict in:

  io_uring/io_uring.c

between commit:

  d3329b3a9d72 ("mm: switch mm->get_unmapped_area() to a flag")

from the mm-unstable branhc of the mm tree and commit:

  624d801ce45b ("io_uring: move mapping/allocation helpers to a separate fi=
le")

from the block tree.

I fixed it up (I used the latter version of this file and applied the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 2 Apr 2024 11:25:46 +1100
Subject: [PATCH] fix up for "mm: switch mm->get_unmapped_area() to a flag"

from the mm tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 io_uring/memmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index acf5e8ca6b28..5c9e70132cd1 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -302,7 +302,7 @@ unsigned long io_uring_get_unmapped_area(struct file *f=
ilp, unsigned long addr,
 #else
 	addr =3D 0UL;
 #endif
-	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
 }
=20
 #else /* !CONFIG_MMU */
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/LHq.6lj5WucWIARp22HzB/I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLUQIACgkQAVBC80lX
0GwjGwf9HOE0ss2ozYG1VeUfBrXbbsDsrcBJyZ89NUBSSWM8TetAsbl7dWDjNc9Q
T9L7jfb0HGMtErUtjcAZ35O7cqv9Hq1Hpxbc7ty3xDJRP3ohK7RbhkpCORmyf7u3
9SrhkZvQf+PTHVhpgXLWkUjaFu1SHyIyZ58fdRXxAxoUU7mJ5E3oexbCnBfbU4+L
hpX0ROEs7bIZU51kauJj5EQQpZ5Cbodk2Xb/pirKT5oWrSH9RzhcXTIiCs6Rvb8n
1nXqt5rL2c2Wu9isJaLgbNPS34rplHQPQ6BnIrt6vm7+DKLX1sOjk/+B2vJS5HRn
ep4J5fxFJFPFTlx4xGpjiCrfRC6ZkA==
=kQCt
-----END PGP SIGNATURE-----

--Sig_/LHq.6lj5WucWIARp22HzB/I--

