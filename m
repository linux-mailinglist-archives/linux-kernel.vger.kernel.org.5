Return-Path: <linux-kernel+bounces-164794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0458B82FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730B11F23EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF861C0DC7;
	Tue, 30 Apr 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LkWu2QpV"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFF29A2;
	Tue, 30 Apr 2024 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519192; cv=none; b=NCc0duVgB8muh8kYD6qMyhTI3FOs/p13JFmIGxYWyJjS8WW8mY6g2jDZ0R3wzBhbaJEud16EVtslFYoayjgsB+27oLgJ75FWvHKIT1ZgkQbJRCTFIV7/cS8AY4TkVJeHSxt4hofab4Bp/ue+tIJqgM4FvBB8jbQHl7yt2NnX6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519192; c=relaxed/simple;
	bh=uJ0gY99LTGWuLFLaj3XnbjegvyOyOpBdzfEAxIFAVTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cIA8lPRYAMvZsQn+lvl1QJvbHO3HzO7U9XF7KfeHtneCLqK1E2sI6OqpH5uuZc3zYn7NE4tofY2yL9crT2Lwg339KzghG9C6i1p+AcObXNiVH4lQMpWHDMnXXwmcSQJiBe5K+1CsekXaalO/3bOm7MP3I2NbTP7S/9csgEDyJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LkWu2QpV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714519186;
	bh=+WEiOInUJQiSX8H7KMPHGgg5nSFkGomVCm+b04fDsdY=;
	h=Date:From:To:Cc:Subject:From;
	b=LkWu2QpVAlt+vkiZoBcxTGU9h8XJ/m1+/C1PJhCzBKJSBt9yLNv2yuhXjns3wHdcW
	 15tf8kFiuxqmAEa0pA9Vw3uvU0KJzCyN7reaJiWN557kRGSrB2jf/VgbIz9BRZy9Do
	 5U3YDDPihyWK89DxqO5ECg/MN0gZqjdDRoN0Wf083zgmrJYi/jtieUlv63sstwfSsN
	 k5i3abD4/Q8mAg6oxWYwOCR/ZYAOyvgJHSJahbgvEovUgVlwVM8fRXKX7X8zc+eOXe
	 gLC9jot61JdYtGszBScF0ncG0HqDRAlUiDH6ookK29Z7c9QYPPy5E6F2TCpqz/1iZq
	 gZ9VV/puqDdXg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTbkn6gqqz4wyk;
	Wed,  1 May 2024 09:19:45 +1000 (AEST)
Date: Wed, 1 May 2024 09:19:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Richard Weinberger <richard@nod.at>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, Tiwei
 Bie <tiwei.btw@antgroup.com>
Subject: linux-next: manual merge of the uml tree with the mm tree
Message-ID: <20240501091942.1999963d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0jI0Ig61DGvLhGsB1skwXzx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0jI0Ig61DGvLhGsB1skwXzx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the uml tree got a conflict in:

  arch/um/include/shared/um_malloc.h

between commit:

  88ae5fb755b0 ("mm: vmalloc: enable memory allocation profiling")

from the mm-unstable branch of the mm tree and commit:

  0c2b208c8b79 ("um: Fix the declaration of vfree")

from the uml tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/um/include/shared/um_malloc.h
index bf503658f08e,d25084447c69..000000000000
--- a/arch/um/include/shared/um_malloc.h
+++ b/arch/um/include/shared/um_malloc.h
@@@ -11,9 -11,8 +11,9 @@@
  extern void *uml_kmalloc(int size, int flags);
  extern void kfree(const void *ptr);
 =20
 -extern void *vmalloc(unsigned long size);
 +extern void *vmalloc_noprof(unsigned long size);
 +#define vmalloc(...)		vmalloc_noprof(__VA_ARGS__)
- extern void vfree(void *ptr);
+ extern void vfree(const void *ptr);
 =20
  #endif /* __UM_MALLOC_H__ */
 =20

--Sig_/0jI0Ig61DGvLhGsB1skwXzx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYxfI4ACgkQAVBC80lX
0Gx0mQf+LJfLl7KCt9vtWc75mp20oGx6xoBGpxZGs6CPmLsaYC24xoGfbrDeCRJy
L+Iwwx8503LXpkROLpeDp3ZX0v9v41UM08spDgTbxovsnIHgAqHOAi/msdzNtW0/
Qf19/0flbc8bAKdimSLHuwdl/ATkALytxypel79+mTs8Nbj5odrPsbQIYtx4azob
Jv5LGDLw7t1Fyhe0EuIvwWHUrrKIVY6WYqgFueH9ZvJn2Bdu3sOw8L0gnMHuSwxT
rI1DuHXp6V79I/AHl9X0jsGBqYJMrLw+Y0c88rtnCiQNhg+9jnHwRV9aqaL/lxyu
Fu4nyTRisd4QPFKK1xDFWAl5E9aDXg==
=Lnty
-----END PGP SIGNATURE-----

--Sig_/0jI0Ig61DGvLhGsB1skwXzx--

