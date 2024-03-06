Return-Path: <linux-kernel+bounces-94665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAD8742DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749D51C23101
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737451CFB2;
	Wed,  6 Mar 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jGYX2Tra"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B71B59D;
	Wed,  6 Mar 2024 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764695; cv=none; b=jkHieqV5h7+Zs2BuGFJmL2U2/2b3Vybv2CuRtnYk8Meyt5qL1cUas71W51EgaqDDm4Oxea0/5aR7KQepRoscDjrzGKDHfCOYpe/CvJRr/WCloNXc3ilmG0AxT7MuCOp0m491O9Fc85zWV6MCZ7i0ft18KCW00cVimRuTx0Z6cpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764695; c=relaxed/simple;
	bh=R4xsTq/tiZoSj/ansOgUHLdKonXs5pW4R9ISFDl7Sck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pyndZ/efEt3lt4GvFlKhUvx2cVGPQB1pJobRLlamcM6yEKn0UMxKBVKZA6Ecdp5b1ZbSewLFv3iZQRxIDEpjBqEPctu7OIaX0X3muG9Nd4ihXRpDCXMzX7RSZK2c3a96WCKqpfTkDqGyvprQ6XVXXoMDtS4sbwsrHQSAyXndYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jGYX2Tra; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709764690;
	bh=zhijCnxFkV6185Bb5e5Q/93MYL4TiiPRpNSkZwu9TMQ=;
	h=Date:From:To:Cc:Subject:From;
	b=jGYX2Tramw7n+JcGYNxqCy2gfQvTWE32x5rIsDE1jOxAghpLDBGeudUInZfwNRp8k
	 bO3XexsNVIANLnbNTT5LGClySpUez4pVBu7ehV3tPrZLgklTUP5TuAKHUiQGZNuUB7
	 MY/jKYDl2bcsuqekTebBbWjE29To3mtc8G+trUA8v8Y8ITOjfysHJ2B9wlDwUU2fiA
	 YtfIMkv39P8aTeQJkZXPMnW0p8XQFB73Le8b/b/DSrbIE5f8oxZ5o/a3uC90yDRnB6
	 L7CQjYrYcfb7I7P4JDlSB3k20hL7hHDBnP8e1yJdnNiVCJy65EQOB6pRnXYNGOtbRb
	 t9foq2Sc7n9lA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqnQB1xldz4wb0;
	Thu,  7 Mar 2024 09:38:08 +1100 (AEDT)
Date: Thu, 7 Mar 2024 09:38:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the asm-generic tree with the kbuild
 tree
Message-ID: <20240307093807.60efa4ec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W7d5n0irWATyfuVsUI.eq6O";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/W7d5n0irWATyfuVsUI.eq6O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the asm-generic tree got a conflict in:

  arch/hexagon/Kconfig

between commit:

  6b1c2a19cb30 ("hexagon: select FRAME_POINTER instead of redefining it")

from the kbuild tree and commit:

  ba89f9c8ccba ("arch: consolidate existing CONFIG_PAGE_SIZE_*KB definition=
s")

from the asm-generic tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/hexagon/Kconfig
index 89672ef0666f,1414052e7d6b..000000000000
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@@ -7,9 -7,11 +7,13 @@@ config HEXAGO
  	select ARCH_32BIT_OFF_T
  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
  	select ARCH_NO_PREEMPT
 +	select ARCH_WANT_FRAME_POINTERS
  	select DMA_GLOBAL_POOL
 +	select FRAME_POINTER
+ 	select HAVE_PAGE_SIZE_4KB
+ 	select HAVE_PAGE_SIZE_16KB
+ 	select HAVE_PAGE_SIZE_64KB
+ 	select HAVE_PAGE_SIZE_256KB
  	# Other pending projects/to-do items.
  	# select HAVE_REGS_AND_STACK_ACCESS_API
  	# select HAVE_HW_BREAKPOINT if PERF_EVENTS

--Sig_/W7d5n0irWATyfuVsUI.eq6O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXo8E8ACgkQAVBC80lX
0GzvWQf+Po1Nfk5uOk0jKhSiyOTubYGFJk0pJDE/TRjiHqN2XH0fp8unDiU3w1p/
vxc3tpCHvVrpZynfmkLV+7jeYz3PTk3kwjhj3x1EMcTw5Exc7cL+loTiCCznIhnK
0k9IrFawKzuRJa8aNWjN6QhH3RReWkHDhLU9yQyy/sHIcFiXO0rP3T9LccA1B4JW
FwhTcxGScJkYZsd7iHdzaCZ9ZNtVeO7swuKJgcNYTDyRJf3Q3/Fw7ynw5mNLYnb8
SRmG26Qu5esgaYCGo+cDoKUMVvIK0+pEtF448GPFCKR2tYclJbMdiCqcyE7GlzBW
EOj5SjvCqsEn4QK/L9CRwi7bTaLBfg==
=0SxG
-----END PGP SIGNATURE-----

--Sig_/W7d5n0irWATyfuVsUI.eq6O--

