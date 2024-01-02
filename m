Return-Path: <linux-kernel+bounces-14058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF0821774
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0820628237D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B02F56;
	Tue,  2 Jan 2024 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gmxWiEhC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECB2578;
	Tue,  2 Jan 2024 05:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704174042;
	bh=d6xn+WIHTzsqP8ORICwjmZ/ZzVaJexHGtmoB98rSg9g=;
	h=Date:From:To:Cc:Subject:From;
	b=gmxWiEhCowbP35fpsyYDRDOoQu/hu6cUwvkoBVeAl0IwtmswWhsvM2Vf1viuOVVxg
	 ijYy5iM+RQ5rtrwHJuRpAMj11KhHDH8Gy01DnXS+ah3RVsN/s7dj9BUxndRMLVEQLy
	 IsXIEQ9cxU0ro8dU7vdsG0j0m9PSkqO1PIufo09bv4Rh8RuLTx66uzxU8ddWr9Sswj
	 Z2/s3ARLt9mIdqCX7eMlSmOZ3WfmIAgL/73gOwos6d9ZSXjHG1cAUX9fr/GJWmMQkf
	 k0Oe1aCbmuTg/Hv3D9WVugMOLy8qcAO7pcl59a82f1psnABw8p+NL7d5Z+l6n3l1wC
	 Fr0cGkvlVY+ew==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T41sj3d3lz4wbp;
	Tue,  2 Jan 2024 16:40:41 +1100 (AEDT)
Date: Tue, 2 Jan 2024 16:40:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20240102164040.2ea3e1f0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pahxHYb0EYNbXm_Urb2dmD5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pahxHYb0EYNbXm_Urb2dmD5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/admin-guide/kdump/vmcoreinfo.rst:193: WARNING: Title underlin=
e too short.

(zone.free_area, NR_PAGE_ORDERS)
-------------------------------

Introduced by commit

  bfbd51786990 ("mm, treewide: introduce NR_PAGE_ORDERS")

--=20
Cheers,
Stephen Rothwell

--Sig_/pahxHYb0EYNbXm_Urb2dmD5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTodgACgkQAVBC80lX
0GzIZQf/SYrCG4got9Nhx5Js+OJTIRsfMY+EbEIpXZtDcw3JI5Yoi5LRex6s6EcF
A0X8N77vVetcfcC2MqdP87J8WMIejxWGwXz+0wcSQhwUc3DEq0YLhuDyEUHIk9mF
zXJnOa78gHvNtZ3vZrbQA0/Y+pLm+SC+Qqs/+uW4vh6vaFQsM8bmCZTw5B3Y65xR
Oy34ccizG4763TMbaH7+IVhYClccnpjS5z2xOBIagMP3gTn0j3ENHFMgLjpzU9ir
2kf9EpzlMSRIhi/VJl2tjL73x0tY0Qyve8Q5Gjl6qyQOplDmr92nPQC49zJ4Z2Fz
eYVwX/Y3imVnnNwrvUDJ3ncgALYd3g==
=+oVT
-----END PGP SIGNATURE-----

--Sig_/pahxHYb0EYNbXm_Urb2dmD5--

