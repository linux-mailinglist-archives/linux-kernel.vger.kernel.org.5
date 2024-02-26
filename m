Return-Path: <linux-kernel+bounces-80352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0646866745
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E8D1F215DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0F33EC;
	Mon, 26 Feb 2024 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m36aK9SA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9C173;
	Mon, 26 Feb 2024 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708906384; cv=none; b=Oy6BdbxvXoeR+Bao/5VgGPKt8hLzlYfU4lnjIBaOERWIeJ81veJADG2PWL6KpY7ZaxGp4jtM/HrdqoSnsvSE42gvKoScj7vN+8mdFpHqZHckBEri5D8+Baay6sWp4H8vMYE5WHYK0VbXxOcJj4fyiTX3g8V0DUPBTiM9KGP8jK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708906384; c=relaxed/simple;
	bh=8G2GQFgqT5J6j9f2iJiXqAPWrET+M9EJYZquGHpRgbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cnkAqFC+Ib18Bcp9aSqFmmIkqZsqcTJl+MEcnwybeszGKtgUeUh7JaHEkvVqC8wwVAh0eVpSM92Dz5+D4OKR3rYAS+WU6lFVkQ1/sRiJ1od6CxFlM0KYjt9+uj1krCabwybjLmaHnb5gcMffmNp8C/+M5cHZ5B1SoF2n04e6oqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=m36aK9SA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708906379;
	bh=8FVLuN+HvufdQO1z5NwgyTOTi7uQpBZaAL6oAV1JjYw=;
	h=Date:From:To:Cc:Subject:From;
	b=m36aK9SAT6KL5sG7YjZF83CrODkAG1y3SH0eU/IyJwbk7dSqiVGRjJeLf070Aml7K
	 aBDNA1yaytRaXIWSUHZ6c4sb6RhU5yVO9lJYeYD7YAXVw5U8P3HwihqzAsjpHWMySr
	 s1f40z3eIfHPbwuN3Skuuq+EH0lyQFY2Vm9X2MYukbx0LV7kArecu1zF8zeT9KjDUm
	 waDGyedRP8Q7NIMWCHEUSrOPT4pd2xJwTW7+Tr8GC1DS+anqwwDDMbBi4vQbmQP3Qg
	 4l7yI4TZra9mughbFcu7YhiTj2h87w/z/O2C6YTBuLrcwu1g8vCDqXbKAC0AyXeuc4
	 YnQ5BHz/9pNUw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjh0C14TBz4wc8;
	Mon, 26 Feb 2024 11:12:59 +1100 (AEDT)
Date: Mon, 26 Feb 2024 11:12:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the bcachefs
 tree
Message-ID: <20240226111257.2784c310@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FvBqIVN51gPF3Kh4_DJXSW4";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FvBqIVN51gPF3Kh4_DJXSW4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/bcachefs/super-io.c

between commit:

  2881c58d14b6 ("bcachefs: bch2_print_opts()")

from the bcachefs tree and commit:

  9f2f767f5ef8 ("bcachefs: port block device access to file")

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
index 38a5073202c5,bd64eb68e84a..000000000000
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
 +		prt_printf(&err, "error opening %s: %s", path, bch2_err_str(ret));
  		goto err;
  	}
- 	sb->bdev =3D sb->bdev_handle->bdev;
+ 	sb->bdev =3D file_bdev(sb->s_bdev_file);
 =20
  	ret =3D bch2_sb_realloc(sb, 0);
  	if (ret) {

--Sig_/FvBqIVN51gPF3Kh4_DJXSW4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXb14kACgkQAVBC80lX
0GxGLwf/VasNqJLG2gFU6NLzcOAQsarVv4NieTIW1V8HCCWR7M/s5ATTlVY0t0AZ
cpwl2dGNSiNK5UzyzZm2LjTGxy2DTl1s3+wp7S0gwuzaSVQR0N3jgjCofeMHkvA7
abLIOJjnnQB5Fb2hGe2fsjc6p5x1SLoaxn6WGYiQd6dzDAMRQsgTLLNrxlUv0ukd
ewEKvtoGeYDOzpz+RLeSExewOmEHOm5Fh8/X8VvC1iBovvWThs7qhp63xkPG665c
p6JGa515xm2w7/9JyGYyj6/1lHY8XTcmodzXOynnGxx4gQ6y6vtrQuNqHZI6GPoW
+7r1FNEldJpUztP9k7e9I0goparVOw==
=0J84
-----END PGP SIGNATURE-----

--Sig_/FvBqIVN51gPF3Kh4_DJXSW4--

