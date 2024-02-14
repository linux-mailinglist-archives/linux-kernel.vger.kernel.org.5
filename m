Return-Path: <linux-kernel+bounces-66100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7A8556E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AA01C267D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76813DBBE;
	Wed, 14 Feb 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vET0gtzY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075155E48;
	Wed, 14 Feb 2024 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951925; cv=none; b=rPeoBgSUG0eO8l9T6+/zTh4ECPw4Ichz9+sQuKU6bdsyt+PrYUjQbam3G6o1IzyloBlfi9i9OcilrJrpVYkAbaXifhm2dBg++563Zr/79yBLhbnh/0D+LUtYG+f7TlFtGZn0XEwqwyXnQ0kmmL3I182tpWUD66erNzP5Hm0gXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951925; c=relaxed/simple;
	bh=YUeR7xv81BRSzDaMPhaiGhJnCyXHfP6ExNWePpAnJfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kq66i1J4/iies9NLbsxWmCS7/WDhRKFKQq8jG/nOL7nYBJqNVRYrqnmGc/mn43MCBD7gmEKAS3n76moumKEXfEaKD7n9pzQmpMUG7085t+546q5CnC8nQ2uQ4jVfyk9bZbEaXnDcAmoAzmroSHQpHTHWLnxONE0rLjI9Mu0wZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=vET0gtzY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707951919;
	bh=dlodDWkbvAKyraT6eqM71p8m7BA3X3M7k1OAFsQJ/zo=;
	h=Date:From:To:Cc:Subject:From;
	b=vET0gtzYYZV2QwYRNX0+XZfl7xxe528G5yimoPNArmRkT7mQoiGS4VDrrQGU93ykg
	 zIoBBrtu1c+cv0QRxcnnfaxMPlYZBMVnujiS0oUTZf58JlMO6DAtS6/VCh5qB6RMbX
	 QdYm442UOn8fDoGlLjsxiYK9w+3vpEfkwtPdWmv0mWw8KkyziWjZ93kD0ixaFHeb7m
	 xRZmBPTeg9HGKVrbywtwzkvtyAD5bmRWqN0Mr2ODgEHVByC5PR/lGPOK1nZWzS4Q49
	 8MawdU27tMOdMya1Zv1TZnRaaDwFlE31518JVz1jGy8iAhX/XZltEaVJAT5wBzbNOu
	 5cXZ1Z2zOtWIQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZv1B6vljz4x0m;
	Thu, 15 Feb 2024 10:05:18 +1100 (AEDT)
Date: Thu, 15 Feb 2024 10:05:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Su Yue <glass.su@suse.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the bcachefs
 tree
Message-ID: <20240215100517.027fd255@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZTW6UhUTc9z3Ddl8pr43EyZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZTW6UhUTc9z3Ddl8pr43EyZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/bcachefs/super-io.c

between commits:

  7dcfb87af973 ("bcachefs: fix kmemleak in __bch2_read_super error handling=
 path")
  4a3cf4df64fd ("bcachefs: bch2_print_opts()")

from the bcachefs tree and commit:

  1df39a40e912 ("bcachefs: port block device access to file")

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

diff --cc fs/bcachefs/super-io.c
index a3a9e85ab03c,ce8cf2d91f84..000000000000
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@@ -715,12 -715,11 +715,12 @@@ retry
  			opt_set(*opts, nochanges, true);
  	}
 =20
- 	if (IS_ERR(sb->bdev_handle)) {
- 		ret =3D PTR_ERR(sb->bdev_handle);
+ 	if (IS_ERR(sb->s_bdev_file)) {
+ 		ret =3D PTR_ERR(sb->s_bdev_file);
 -		goto out;
 +		prt_printf(&err, "error opening %s: %s", path, bch2_err_str(ret));
 +		goto err;
  	}
- 	sb->bdev =3D sb->bdev_handle->bdev;
+ 	sb->bdev =3D file_bdev(sb->s_bdev_file);
 =20
  	ret =3D bch2_sb_realloc(sb, 0);
  	if (ret) {

--Sig_/ZTW6UhUTc9z3Ddl8pr43EyZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXNRy0ACgkQAVBC80lX
0GylSAgAgckT6Yo2yZVsXcTFHOVNTZSuX+mwLH4JK471+gizpoUND031R8MoX9tB
qxGFjGI+scbi+wS8QGssNZ3KKGxFUS3W+ZJQvRBuTyv93s9mstIR2+jpeYShtI0q
hn+ENcocrTGwqZJcbQEJ4YDwaWfh00oWLYF4Dfu7KfejTV4CyyWO23+SFkLNJKcm
ZU5VNMeaMkCsK+c0JEiiwmWNXaRhgEE5DmxMGhd+oty3tPd5LPggbF/0MTfRJWzz
3sA9lpdXADcyQYaenxHtyZV1mzw/AtKYOovwfaNImC3Imb7z+6+OWLfKl9ZP0qmR
wqs9k8LGS2aNHaVBhTocEKOydels4A==
=rbx2
-----END PGP SIGNATURE-----

--Sig_/ZTW6UhUTc9z3Ddl8pr43EyZ--

