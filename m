Return-Path: <linux-kernel+bounces-156131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF48C8AFE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765FD1F2374B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9081CD2B;
	Wed, 24 Apr 2024 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Gd0qg5l3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4251C6BD;
	Wed, 24 Apr 2024 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925243; cv=none; b=FMLTILr7ToD1YVgghporKdVkTq4oc4BJnCFa17cvkeqfBZsOPnsKJlMCMTbMz20P8kJIJL3pOnhitMeMR8wIqfZ6XKY0GYu3LDSQs8bxGTa9cpihOFGweeZqXS4TdiX7EndZRhumBq57WtoIcmX3CKmy/L1UbZox2NQWmJI99to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925243; c=relaxed/simple;
	bh=/IBQ9UaOk78Qjtch3BUHtK6o8y0xEN6Rjb/8jpj4E6w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XI1JenuAAd04x10PdvtDQfPVhYkRcnRY0g7gEzUZnz0s13W4D/SsvtSWb/Cvbat6M2yAHu8/nWJutdjKa8thh0/2gJzSl246socNJHbDjCklYG4g9dBE1nvxtiZtE0Yhmt5axSjzG4/Whrlqy7vY1iPa9VGw+tnOJqIEZLYhUk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Gd0qg5l3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713925237;
	bh=640fTtfxXa31FKB6D2phChlcHfYmgE6v+FReGt0p9CY=;
	h=Date:From:To:Cc:Subject:From;
	b=Gd0qg5l3dQ+aLUqPA0Gfn0UQ2Vu11y2g9IpXyO2T4AifjR360jrPiCpYhS1z/LARL
	 lYmQR4Y+PJdQUOjMXyMMqoccO0CtTqz6TXkY9RlDBDnLyQD5W8FFBnzSNV+xhZK6Gw
	 Ak/wYuBiTmvLZdIUVtTEBnDGwO7Jy+mrDLoXZlT+CBUoZtnhBhKMDiXhvH/CORgNS6
	 icZprMM9CyQG9iJfUIrr4xpKIPhhblCFwdb/wcSbwFPy8QZS0jfdaof35ysPWgse1e
	 oH93WeaWN+R8rHH/Mlz5GGzhyY8fdchA6StCZUxyQ7v0VCFt2N6xm0FNwaMGAOtCVV
	 0E4jMYagO8nZg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPN4h6Wdvz4wc7;
	Wed, 24 Apr 2024 12:20:36 +1000 (AEST)
Date: Wed, 24 Apr 2024 12:20:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the modules tree with the mm tree
Message-ID: <20240424122034.5b4a1a01@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H/+E5WcEms/IdccAZrVLtmR";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/H/+E5WcEms/IdccAZrVLtmR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  arch/powerpc/mm/mem.c

between commit:

  c22e503ced5b ("fix missing vmalloc.h includes")

from the mm-unstable branch of the mm tree and commit:

  7aa7eb8269ea ("arch: make execmem setup available regardless of CONFIG_MO=
DULES")

from the modules tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/mm/mem.c
index a197d4c2244b,5de62a3c1d4b..000000000000
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@@ -16,7 -16,7 +16,8 @@@
  #include <linux/highmem.h>
  #include <linux/suspend.h>
  #include <linux/dma-direct.h>
 +#include <linux/vmalloc.h>
+ #include <linux/execmem.h>
 =20
  #include <asm/swiotlb.h>
  #include <asm/machdep.h>

--Sig_/H/+E5WcEms/IdccAZrVLtmR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYobHIACgkQAVBC80lX
0GzHLwf/T0fiy+3h+FiR5SrA3FMVBpVHDjptBdZ5nzyZr5xWmJe4ZzTwbD1TMY87
KEWJMusc2M1mAhqKzzGXxNASMCvctLW5qYo7LijJamkQIs9SwUObV4QQAUrtTkTD
jABxLGZ5vhqRwGyeejPc/8XKw1oZvMWhFcWdlNedKXE7P38F2XiDES1Q8UITQ2No
Ekd1t/2BiwoLQbiDFaf38eUnqsxTc47kVMkBAJD3TiTOmqk15exovN7oPOBiX0KD
IOPVU97iD1VcFX4tPC88V5fk/FcObyRXZQyPe8US5kinjI3WkpeV2qLUUk6tI31x
w+EOh9lv0Wdb2vW/RclVyrPZ8ned6w==
=GpxW
-----END PGP SIGNATURE-----

--Sig_/H/+E5WcEms/IdccAZrVLtmR--

