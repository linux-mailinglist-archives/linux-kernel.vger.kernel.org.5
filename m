Return-Path: <linux-kernel+bounces-167128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5138BA4C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE5B1F22CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061CCA7D;
	Fri,  3 May 2024 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LoFPl7ql"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607408F47;
	Fri,  3 May 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714698010; cv=none; b=n17vPsiswRyR1VWKrAcz6ZM4Yxqs9KHmcfmAIdHkx4YgZfEHv6LceYa42u77T+eb+dMHTXY1RfXN3IbgJpMqhJMT89mHXYorsGRzIcYRt116iM8LfVv9LdkvFiVnCwOo/mi5JEYkk0OzyyinqGfX/N3JS/HcYAbdmQ2L/WRIhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714698010; c=relaxed/simple;
	bh=yxJwCPihuRqqd1kUbk8+WYJAkUPTMDNlheVeKCyLEwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bUaZzgVOPq4kqFaqc5+jMyS6CPoqCpnFFhguyfB7RO9UEMqPL7g2kmG/IH6PHM+ENRnOEUVbHedkP+jQPqNUs15X01A15JK5N0MmAeLeQI5/WHnJp+Fki9lDEctCQGKufjVmdQ5W1Ux3B6ZMJwIPl9fyJnP7SEXt6aSiIt84xaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LoFPl7ql; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714698003;
	bh=6SUkfLsG74L+ZhAIXSq9Lgji0S8rIZz//HYd/+rSK5A=;
	h=Date:From:To:Cc:Subject:From;
	b=LoFPl7qlm/S4eXi9QmCy6eoUS05RFH5cwswjTFeIPzvfgbUkhgVpcW++8t/o8EX+f
	 FIXfc4R+20dbn3/GSunoaZ0mj2pzW8dd+NoENch1A5Ps1vOXWYHHHevOylP2u4TUXD
	 8Fr6h/p93PbqPabdlJ557rLraaQRcu9lwncV/ZHMzjtNPljc658NfzO34DObKEksGz
	 tHrC8KmDK/wHhWmkO8nmtYr8G/ewROSgQmyX7i5IZj1mDWFpZ4Ew9LA9kC+JFUWQ+m
	 4S2G+MOaYsn2BdgWdZwgB6wjczhOoUu/Q6X0lbFRNtpGPL966inajswogvBAPxzv7a
	 Y3Eufl9VJ40Bg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVssY6DvNz4wcn;
	Fri,  3 May 2024 11:00:01 +1000 (AEST)
Date: Fri, 3 May 2024 11:00:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20240503110001.336f3286@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c2+12t4sm9qWFHK6RQvAFSz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/c2+12t4sm9qWFHK6RQvAFSz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/btrfs/disk-io.c

between commits:

  4a63bd0ffbd2 ("btrfs: convert super block writes to folio in wait_dev_sup=
ers()")
  545799bb1bb9 ("btrfs: count super block write errors in device instead of=
 tracking folio error state")

from the btrfs tree and commit:

  db3102368e1b ("use ->bd_mapping instead of ->bd_inode->i_mapping")

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

diff --cc fs/btrfs/disk-io.c
index e8aca9f0e692,f10e894b0bf5..000000000000
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@@ -3739,9 -3738,10 +3739,9 @@@ static int write_dev_supers(struct btrf
  			    struct btrfs_super_block *sb, int max_mirrors)
  {
  	struct btrfs_fs_info *fs_info =3D device->fs_info;
- 	struct address_space *mapping =3D device->bdev->bd_inode->i_mapping;
+ 	struct address_space *mapping =3D device->bdev->bd_mapping;
  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
  	int i;
 -	int errors =3D 0;
  	int ret;
  	u64 bytenr, bytenr_orig;
 =20
@@@ -3857,21 -3855,30 +3857,21 @@@ static int wait_dev_supers(struct btrfs
  		    device->commit_total_bytes)
  			break;
 =20
- 		folio =3D filemap_get_folio(device->bdev->bd_inode->i_mapping,
 -		page =3D find_get_page(device->bdev->bd_mapping,
 -				     bytenr >> PAGE_SHIFT);
 -		if (!page) {
 -			errors++;
 -			if (i =3D=3D 0)
 -				primary_failed =3D true;
++		folio =3D filemap_get_folio(device->bdev->bd_mapping,
 +					  bytenr >> PAGE_SHIFT);
 +		/* If the folio has been removed, then we know it completed. */
 +		if (IS_ERR(folio))
  			continue;
 -		}
 -		/* Page is submitted locked and unlocked once the IO completes */
 -		wait_on_page_locked(page);
 -		if (PageError(page)) {
 -			errors++;
 -			if (i =3D=3D 0)
 -				primary_failed =3D true;
 -		}
 +		ASSERT(folio_order(folio) =3D=3D 0);
 =20
 -		/* Drop our reference */
 -		put_page(page);
 -
 -		/* Drop the reference from the writing run */
 -		put_page(page);
 +		/* Folio will be unlocked once the write completes. */
 +		folio_wait_locked(folio);
 +		folio_put(folio);
  	}
 =20
 -	/* log error, force error return */
 +	errors +=3D atomic_read(&device->sb_write_errors);
 +	if (errors >=3D BTRFS_SUPER_PRIMARY_WRITE_ERROR)
 +		primary_failed =3D true;
  	if (primary_failed) {
  		btrfs_err(device->fs_info, "error writing primary super block to device=
 %llu",
  			  device->devid);

--Sig_/c2+12t4sm9qWFHK6RQvAFSz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmY0NxEACgkQAVBC80lX
0Gz+kAf/acdGAbG+oPqLzxkeFWZBnUXp4+Fypgo1ZVdq1u1Q/V+QCW0KR1OcZmPj
lyHp6nzaSdkoWj1eSJhfau084T3ssHycz6/3VV4iQamPQu2gXPVY3mtAV3Hf330h
zv4PBvfP9UjVhQhWJ9yRMHroTHjeLottR+6AK0/59ZNUuXdGDhF8TodX8aALnTGQ
sBN1CriHVMBOAjXVvoZfKsi61GhhH6b4RkyE9g5Rr9oMWvx0oIv5eAmQyHUCMET6
cD4XGuYjakJ3s9faF1ai+va9tLyHeCLbUJTXV7VFm/qZf0rKzKiOzYGxUxGSKXeR
dA2umd7mRuPdEJJ+mSUX6hA3j+iQJg==
=c36x
-----END PGP SIGNATURE-----

--Sig_/c2+12t4sm9qWFHK6RQvAFSz--

