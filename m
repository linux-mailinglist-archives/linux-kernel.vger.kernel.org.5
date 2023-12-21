Return-Path: <linux-kernel+bounces-7758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDC081ACB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243921F23C83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734E441A;
	Thu, 21 Dec 2023 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iiWvjyLm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7163C34;
	Thu, 21 Dec 2023 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703126730;
	bh=4JUUkyq4Szf2FSLo/m+X1SFuBiyu9JLbhik0x5Gd5lU=;
	h=Date:From:To:Cc:Subject:From;
	b=iiWvjyLmySbjYGHbpm4TDCKsdaA28J+R0REpM+lcfjXuIvRpmIZOO7pDr8vw3ekH1
	 SY4zm7AdPgvialOdj1ceqvza5A2KvvAvvqHC+AvN9R0LlgSQWU2URcPYfKXYR2zJXx
	 eH/XgignUCT2GEpNObkiCyQVcHZIFzVHPk/vYM+R5shtVEk7/wraijBJShynGxVvTc
	 vbVeHzNq10Xnzwx6qfS4gNiIH6B/ptiNSf11Vhp30FOp7tdMsGht8XP0U8qfG48Z7W
	 aaznfA+NI4YFiPinGVWtAViVaO/3hmV0fxmxUjPp8uRQ6K2aGc+U2+l7UdjgzxsEd7
	 n8hUZKj5bF79g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwZY53yx6z4xGC;
	Thu, 21 Dec 2023 13:45:28 +1100 (AEDT)
Date: Thu, 21 Dec 2023 13:45:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the btrfs tree
Message-ID: <20231221134527.38493677@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ubuOmb9ut+BJKLRVkyv6T+I";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ubuOmb9ut+BJKLRVkyv6T+I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/btrfs/zoned.h

between commit:

  eefaf0a1a6f1 ("btrfs: fix typos found by codespell")

from the btrfs tree and commit:

  7437bb73f087 ("block: remove support for the host aware zone model")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/zoned.h
index f24a5ffb7807,bc1b540c1597..000000000000
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@@ -319,8 -323,8 +319,8 @@@ static inline bool btrfs_check_device_z
  			(bdev_zone_sectors(bdev) << SECTOR_SHIFT);
  	}
 =20
 -	/* Do not allow Host Manged zoned device */
 +	/* Do not allow Host Managed zoned device. */
- 	return bdev_zoned_model(bdev) !=3D BLK_ZONED_HM;
+ 	return !bdev_is_zoned(bdev);
  }
 =20
  static inline bool btrfs_check_super_location(struct btrfs_device *device=
, u64 pos)

--Sig_/ubuOmb9ut+BJKLRVkyv6T+I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWDpscACgkQAVBC80lX
0Gy96ggAhDofuBU3W/sZc+bvZ1KvpgZLxYrW2i8B0BNQYp3liP1j9Nki2WTYQ88Z
nQ19IBL6RFf9c4YriQ6W5N+mrW2UUZXTfNpS/XBLwrokGN5yfh0GD5vIlTFRLTKE
CCnehcDr4GMd2Yre+jbr2CeS5d2u38PyY7jTosK4alwAKUO3NemDcFl8oO5y+3HJ
dbhXxQzog4cacB+Z4X54pz2NLFpwVHI/Arlz1Q3gTymqpjciut9bxGv2ErDH8tdi
LXuMwh/ywI9TGCYVYrr/Gc4yL+UANqkrpJ0jSD65d7ThymyHwex7CwsfZ8Q5dOF4
4Gims0dr+xCyoP9koHaprhgmGwFwTA==
=A2P9
-----END PGP SIGNATURE-----

--Sig_/ubuOmb9ut+BJKLRVkyv6T+I--

