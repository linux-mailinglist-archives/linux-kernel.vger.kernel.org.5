Return-Path: <linux-kernel+bounces-62518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB86852245
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D271B1F23766
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854CF4F897;
	Mon, 12 Feb 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="thg/0U7R"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A34F885;
	Mon, 12 Feb 2024 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779107; cv=none; b=O/lvKzpnI56Pc7A/Ls9REU45tJ7TTYGxYlsE05W+SuwvJqCJwtFKMeD5iJsN6UF4T5YuEBBiyHUd5+e0Ez3fTabcZbjO4H/RKloScrCq1NlaQMDWkDzX+OmhE9qXKFoZsDWP9I8gXs7qbemANJLuucrT3B9pVlpifxTYzyyOnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779107; c=relaxed/simple;
	bh=ktd9h9qlvN0UnUZCeYB3SASIwovngcWwR2R8apaMxQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HDUVDe4s3C4wYNq8eA7Vvi+oEbBgJi/6WG6nwJ09ByJVUFJkzlYs1EUkZxkD0o6R+NtMonyB5djFq6mTb5A36Maa9XSfrcBORkOXkA6/FGkAiNkRyERFtkXChFLJodyyvF9hiDzGXulY+rw2ki3T3DOsd+GBgu+H9fJnWF2Uiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=thg/0U7R; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707779097;
	bh=Eq4c4CTqsb904CNVrto0W+3RppC+ap2MIeph085cVZI=;
	h=Date:From:To:Cc:Subject:From;
	b=thg/0U7RaOeHsJnGHVczSuCbmZ7WGVRJVHbL3ftNvsahjXyn6W6UbGHHEuIaJ1LLG
	 MCqyzJCJlj2VWgcLCTvHn/PMu2sHKociAgWLp9H6Lb8el8vxap3xkZAMQpKW+CrA6N
	 6fgpj6CwwwDSaev0AG3DB4ojzcbm+1DRxLAj7hHEKimJDiltYlPFkz92XEmc68z5rr
	 981wdJHJbGPkANSOrWOuqojGyQwjPM49ObRidxJOrl2xLDRBS1u7EJ9GXcsDDGDRr5
	 N0QErv0yiGd4FFJUX768xruEdc/X9v2QrP7ikqpVms91BW+Naw+YQC/m99IGn6n36E
	 mjQMsJGB1aZhw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TYg5j22y7z4wcM;
	Tue, 13 Feb 2024 10:04:57 +1100 (AEDT)
Date: Tue, 13 Feb 2024 10:04:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Su Yue <glass.su@suse.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the bcachefs
 tree
Message-ID: <20240213100455.07e181c8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H0EfUVqgf5.7zwqJumzUvD/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/H0EfUVqgf5.7zwqJumzUvD/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/bcachefs/super-io.c

between commit:

  7dcfb87af973 ("bcachefs: fix kmemleak in __bch2_read_super error handling=
 path")

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
index 36988add581f,ce8cf2d91f84..000000000000
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@@ -715,11 -715,11 +715,11 @@@ retry
  			opt_set(*opts, nochanges, true);
  	}
 =20
- 	if (IS_ERR(sb->bdev_handle)) {
- 		ret =3D PTR_ERR(sb->bdev_handle);
+ 	if (IS_ERR(sb->s_bdev_file)) {
+ 		ret =3D PTR_ERR(sb->s_bdev_file);
 -		goto out;
 +		goto err;
  	}
- 	sb->bdev =3D sb->bdev_handle->bdev;
+ 	sb->bdev =3D file_bdev(sb->s_bdev_file);
 =20
  	ret =3D bch2_sb_realloc(sb, 0);
  	if (ret) {

--Sig_/H0EfUVqgf5.7zwqJumzUvD/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXKpBcACgkQAVBC80lX
0Gzx+wf6An58J97tEuatYeYEIt8pk1bEdS9bSUaYQ8Snn3y9gsGi2ipO7w+sjS5s
h57DFCILTvyM0IkpPMUzxkjeZMkoudQyGR0Xib5tvHb9FmYN8jSGln/5XLdOoATK
aPJ3UP/la8W+I1IVsZVjiE13p+6xTw1XxT7uIJocoowuWMfB7CqZ5j2DF9/W/Non
mgr5ADxt8e0tn9060ad6bpgBo1usE0iYezXOiGFleipDEPNnrqNyow8/2UjrbS8r
XtxXR2z96LbotYx1aVwmzwxwu6mrb/pEaXtk1+ZualT5XiSHgFuo3V8W+T+p73Qb
EQo98cOpiaioRVD5dSkdI+UrFezMcQ==
=DFQ6
-----END PGP SIGNATURE-----

--Sig_/H0EfUVqgf5.7zwqJumzUvD/--

