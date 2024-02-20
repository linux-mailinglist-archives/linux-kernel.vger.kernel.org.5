Return-Path: <linux-kernel+bounces-73828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D785CC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CBC1C20E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8651552E1;
	Tue, 20 Feb 2024 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="my1Q+Cs3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26409154C16;
	Tue, 20 Feb 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471928; cv=none; b=qHG/iWKHgszqB9QDN5wJyjugkZNX32YtKnTF24FfvTbVZTND2ifh/2K0jQG76CmYUNVkVAaUb0mU6OT/W4pG03cBq3RE4sR4Pd+EoZuEuB5tpAhrdGJSb0B2WmCTAa5XVIXy2xj9rLanQ/S4fm72hvcd/BBHSo2sNL5A8sPnPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471928; c=relaxed/simple;
	bh=BJ19qv7GFg+vlFq8aaBiroQPJ7P7u3BEvAJixg8bWoI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rbBBtavegXZrLyUAf/um10iAJ5HDDXESIG7H8JCgQGpDv2mAYKSj9bQugyU470xt5KeQsDDYzygsJjQy09W4uGDQenUQAWhXE0kTjrd+3WHNofMJKnxltL70guw2DzTQGPv5D0GRMD7zS/i2Am958vMWoe925QWgMk3JapSRncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=my1Q+Cs3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708471923;
	bh=w8kDmFrF2L1b1RaP6xowkIbVaoTngjrjgitT0ttTX78=;
	h=Date:From:To:Cc:Subject:From;
	b=my1Q+Cs3zAWTpdJajvX/hZP0NIvgv3IxXaUwkY5e8zzoHSGY5dw103p6sl7Lc+66g
	 ttVT1rCWb5myBIAjo7tLPjU8YohhY+5nZ6soCdNArL84mEcLUjGIj2fT8HfXlVJvue
	 g/AtDGLxbm562g4UdnuPualA/rwme9v+zmkKDwif0tCTV2Hi+xKW9tdiLCdl+DBsjC
	 hP81GM4Z87A64l56YGCz0hwlm0dk9HIvugI35mK/2r8CA+DYyOPXNlUygG4rPyOuRN
	 UhoOFbBgl63Kfiv5zBteC/S7ghn8XOwvZuNSAqzAcmQ2z71xx8oeSZSn3MdedIt8Y8
	 SD3vO+ZzPR54w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TfbKG0l2cz4wxs;
	Wed, 21 Feb 2024 10:32:02 +1100 (AEDT)
Date: Wed, 21 Feb 2024 10:32:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the mm tree
Message-ID: <20240221103200.165d8cd5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J6Y5ZV4BVzCPcQ_+Y9K_ikT";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/J6Y5ZV4BVzCPcQ_+Y9K_ikT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  init/main.c

between commit:

  4728b74d1992 ("arm64, powerpc, riscv, s390, x86: ptdump: refactor CONFIG_=
DEBUG_WX")

from the mm-unstable branch of the mm tree and commit:

  193d98b1d3aa ("pidfd: add pidfs")

from the vfs-brauner tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc init/main.c
index bc3b6b49b3d8,2fbf6a3114d5..000000000000
--- a/init/main.c
+++ b/init/main.c
@@@ -100,7 -99,7 +100,8 @@@
  #include <linux/init_syscalls.h>
  #include <linux/stackdepot.h>
  #include <linux/randomize_kstack.h>
 +#include <linux/ptdump.h>
+ #include <linux/pidfs.h>
  #include <net/net_namespace.h>
 =20
  #include <asm/io.h>

--Sig_/J6Y5ZV4BVzCPcQ_+Y9K_ikT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVNnAACgkQAVBC80lX
0GzjSwf+MzgOiyByJd3pqa1+S47TXbC1xCzpd/dD5BM9hYsgs3f6S/oyAJ8y2UV5
Ls6MQtlLKKoCVSVlgn8L4G1/eNjK5CNHVoED+YlpdhQvWmyVowIgtnxuvDWC0KVE
WmGQZvPJ3bQxJ/LyWqJXzbcvhq0TVaKj4LF/oj62OWc4dz5UyZxYfegIp+QB/RMd
Nbt8X+YYyTnpr7t9C+8mK6vSqRBckRwTzSG2v7zN4GhaYt/MftTcpJiSy1+lo/2l
Gd/jdNO/n1mvRKjoeqfXfBCu5KcPCezaPEULdF1+Z+xxb3W7U5gzPcDHU0mVhA8w
xcDQYSvgpyrbXDpkmRtz/Oh8rw9s1A==
=Jr1c
-----END PGP SIGNATURE-----

--Sig_/J6Y5ZV4BVzCPcQ_+Y9K_ikT--

