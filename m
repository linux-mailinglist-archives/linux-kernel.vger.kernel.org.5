Return-Path: <linux-kernel+bounces-149509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6678A922D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843AE1C20FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE9F535A2;
	Thu, 18 Apr 2024 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cBWseeei"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549E3BB47;
	Thu, 18 Apr 2024 04:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713416171; cv=none; b=h618pAY/MnCeyM+TARdJkljbXMO7PAyd39B3XX4AW0Fe9TrnS9E5tLo8HrfaKhhuV2D4bgQOPODSKQdJS5YosTm/qa1qx1deaLKDJ1H9UN7kGlgL9EkJKww9z8nsIXn26NTjB0Gx8KbNlTtDzihLDc9jffxT8oQA/vQ864L/6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713416171; c=relaxed/simple;
	bh=IQjjZeZYM+9qKryWMyYm3/1/UmAKiRjliklC27orBvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hvxo7qF+gCVFbqmxWy7J/s+l7X0fo4sc0h7mf/ZVBMZcpypebzC5hdp+Z9qB/lMW2XHAMoynTJ4Po8x0balhZ4FxruO85cgcbraxCbldaEgC78/bqzNEMWiGP1JhF9dC1HKmfQW8uxcI5CYBvyTDnDqrr7izxUYuQ7bNEn5dF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cBWseeei; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713416160;
	bh=Y4gBqHAEeaXP8iaxJwfvnXx0Ux5HBsw811oPCB8+7Do=;
	h=Date:From:To:Cc:Subject:From;
	b=cBWseeeiTM2sxCoffpRoeCyLpQ7bTWWQmyCvd2HSMxyQt8X0tYzLbYua3x0ImVnQK
	 Rc9HqxmozsCwmTHK41zQB/t3Z62PyrHSCArnOvcJ1FRz5up1JFCQNsc0jcZZeZOKim
	 D8jSr7GAhe23BMC1o08ME6ibKnsS7yFqbfRTmo4rHpgzo5IM7YL1GGrmadsC/Nz9c5
	 bve0zTAje5zzRH43gkbr6upXMM0Im1UachdKKLXSz/znQGTJRqCl8+Vof+XdGj4yeU
	 +o7LyQsn5743t1BoBzxaxj6DUFOT8Sk2rQZ16xzPkEKOHRKbPAQ5xhN6s8Y49ht/Dk
	 G91BACMgUf5+g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKlpk0XSqz4wx6;
	Thu, 18 Apr 2024 14:55:57 +1000 (AEST)
Date: Thu, 18 Apr 2024 14:55:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe
 <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the scsi-mkp tree with the block tree
Message-ID: <20240418145554.7a93325b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mkf38BI6EyEwDoB03V8_Pyd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/mkf38BI6EyEwDoB03V8_Pyd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got conflicts in:

  block/blk-settings.c
  include/linux/blkdev.h

between commit:

  e4eb37cc0f3e ("block: Remove elevator required features")

from the block tree and commit:

  ec84ca4025c0 ("scsi: block: Remove now unused queue limits helpers")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc block/blk-settings.c
index 8e1d7ed52fef,292aadf8d807..000000000000
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@@ -1048,28 -822,22 +825,6 @@@ void blk_queue_write_cache(struct reque
  }
  EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 =20
--/**
-  * blk_queue_can_use_dma_map_merging - configure queue for merging segmen=
ts.
-  * @q:		the request queue for the device
-  * @dev:	the device pointer for dma
 - * blk_queue_required_elevator_features - Set a queue required elevator f=
eatures
 - * @q:		the request queue for the target device
 - * @features:	Required elevator features OR'ed together
-- *
-  * Tell the block layer about merging the segments by dma map of @q.
 - * Tell the block layer that for the device controlled through @q, only t=
he
 - * only elevators that can be used are those that implement at least the =
set of
 - * features specified by @features.
-- */
- bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
- 				       struct device *dev)
 -void blk_queue_required_elevator_features(struct request_queue *q,
 -					  unsigned int features)
--{
- 	unsigned long boundary =3D dma_get_merge_boundary(dev);
-=20
- 	if (!boundary)
- 		return false;
-=20
- 	/* No need to update max_segment_size. see blk_queue_virt_boundary() */
- 	blk_queue_virt_boundary(q, boundary);
-=20
- 	return true;
 -	q->required_elevator_features =3D features;
--}
- EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
 -EXPORT_SYMBOL_GPL(blk_queue_required_elevator_features);
--
  /**
   * disk_set_zoned - inidicate a zoned device
   * @disk:	gendisk to configure
diff --cc include/linux/blkdev.h
index 2c535af79529,e3c7082efa39..000000000000
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@@ -924,9 -942,15 +926,6 @@@ disk_alloc_independent_access_ranges(st
  void disk_set_independent_access_ranges(struct gendisk *disk,
  				struct blk_independent_access_ranges *iars);
 =20
- extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
- 					      struct device *dev);
 -/*
 - * Elevator features for blk_queue_required_elevator_features:
 - */
 -/* Supports zoned block devices sequential write constraint */
 -#define ELEVATOR_F_ZBD_SEQ_WRITE	(1U << 0)
 -
 -extern void blk_queue_required_elevator_features(struct request_queue *q,
 -						 unsigned int features);
--
  bool __must_check blk_get_queue(struct request_queue *);
  extern void blk_put_queue(struct request_queue *);
 =20

--Sig_/mkf38BI6EyEwDoB03V8_Pyd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYgp9oACgkQAVBC80lX
0GyXJggAlb1LfuqNQ7nRFEnjVTgF59JKG+yoYzqNjXEuor5WZuHeJxh2SoZiaXts
OXYbC/0YiaJSIrgNF4HpZzyruOqlzYFRhH/T758cd74/L0VvjuZUJPsRIIq9dQkL
1mGrZmqjy6A/eR0gBB25SkhtSlDr9ata3V9zJZw+f3RPksZcan6R+8lmTsFeW52r
FlGm5y9bV53cgEY6wLLTOwe5Km/5zLyCTSe71pnddfejaMJIEDevP8EMunWayQhj
lya6ACvCYNdT5vcNG7BrASrk3h4deVhdPrhSEe65Lp2ZuIf3d6p09I9fnxNrIG4i
9rpQ2oC9zukzUjbB29HUF82NjlTIqw==
=Qe5W
-----END PGP SIGNATURE-----

--Sig_/mkf38BI6EyEwDoB03V8_Pyd--

