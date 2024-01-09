Return-Path: <linux-kernel+bounces-21450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB7828F49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CC01C234D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F913DBA6;
	Tue,  9 Jan 2024 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AVj6yteo"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B193DB89;
	Tue,  9 Jan 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704837255;
	bh=bK+g9H87ZJFe49viHBWpaTjXD1juq9S1VHhVegPbUww=;
	h=Date:From:To:Cc:Subject:From;
	b=AVj6yteoox2sCdqB9brWyxzKoq43yL5NU1MTv7VN86nOAp3X3XIO/t8EVlrtqv88p
	 7zlXsfmfSMPao5GaDv9LS4cLNewgmS8o7+osnJxx9DvjCpENr/JNQ34evViK8UGLBa
	 GehBWKJzimMASQXzRByhp+U2UeolTV9Qak2xjSC/M5FWYPJxZwYqc/Rtzrn19Uwz6T
	 iV+U0E5i/pD5utg2jQknzQ8oQpHO2GMEZ/U0kx1odk+D3rQCJ9Ph7+DzMYJCT3iVR+
	 VZ+u98mTvpw6zUc2Lf2loDo179r7QK15NeLFN/QXgn9n4IiVfs4eIPm00c4D4KooXH
	 5iPDO0E6eMXUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8l7q3WmWz4wxZ;
	Wed, 10 Jan 2024 08:54:15 +1100 (AEDT)
Date: Wed, 10 Jan 2024 08:54:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-unstable branch of the mm 
 tree
Message-ID: <20240110085414.69e2d424@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l_VNm.Nf=3rH6n7wxzyLh1x";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/l_VNm.Nf=3rH6n7wxzyLh1x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  feddd92661f8 ("mm, treewide: rename MAX_ORDER to MAX_PAGE_ORDER")

This is commit

  5e0a760b4441 ("mm, treewide: rename MAX_ORDER to MAX_PAGE_ORDER")

in Linus' tree.

Also note that commit

  789a86dac353 ("mm, treewide: introduce NR_PAGE_ORDERS")

from the mm-unstable branch is very similar to commit

  fd37721803c6 ("mm, treewide: introduce NR_PAGE_ORDERS")

in Linus tree (presumably because commit

  f090f8606e97 ("mm-treewide-introduce-nr_page_orders-fix")

was folded into the Linus tree commit.)

--=20
Cheers,
Stephen Rothwell

--Sig_/l_VNm.Nf=3rH6n7wxzyLh1x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWdwIYACgkQAVBC80lX
0Gx5ygf+JTddrg/0NhgEtZgSqsXCnfW16n/iiG0yN8k5gZ4cM40zmjUlycfth1uV
YuKHdGU39mijUqb5Xbolq9RC5pG92A4FzMsPk/7hmfA7zAvWuLT/nJ97eQtRxPWO
ZHQoN+I01iDtPJ6hCD45Xe11Oi3ifYBmmeuVIhJ0UkitMt+7RRyESHV9pmz8xLX5
IkTyLAAHhiEM1GueGH0blUKoKh+Ej9xqfU75pWWFHFoVROtRB9pXFVdVRQdx5hoH
TMt6N2nGllndkR1TsPyoSd6jEl0So/UT1xWR9ddoj+wa/EBvzLcL5qNlzynfYzXv
BBoXLB6kOkyInotVqaDV5OclQWMhXQ==
=1B3i
-----END PGP SIGNATURE-----

--Sig_/l_VNm.Nf=3rH6n7wxzyLh1x--

