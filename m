Return-Path: <linux-kernel+bounces-54168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2520C84ABC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58EF28578A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCC456768;
	Tue,  6 Feb 2024 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BPUcxvTJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0254756757;
	Tue,  6 Feb 2024 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184140; cv=none; b=RSl1udqDZMmmMvNyXBvz9dxf3NAF9fZ7HFVvP3SZMt5Hmlvo+dkyTj8GvYsttv8Y3AYC2TTdzP2aGxCrx5V1mGxhRUWdzsq9guuPYVamEmhJkamLSCwjzGQj30Nddbm7PjDf85BuyGeL0CbSzozcM/U1pVo4V3raqCroKySIRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184140; c=relaxed/simple;
	bh=hqIHF8ItYDKFpuclvDRmaeWoAmrK3v+Ya7wiLubCuSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iUgV0CZ/hI+eNOfjXRxKCYZO/pFLvViz1erlsmEnJuSwszHnWMdxR0y9b/rWJyQDqlmg7XR4Mk+f/EH9BpHC8FJGvFtItyvrcAOv7y3l7Whv39RlP5hl5jVL69S0V0POaB8/DTKeslLcBHBpCtM2Zci9XK1z7BaNRAXlARtR4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BPUcxvTJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707184135;
	bh=WzsXiNNKB4NmRGTpIGfaSGaM5x0AzChJVK0ybEpCxf8=;
	h=Date:From:To:Cc:Subject:From;
	b=BPUcxvTJUIvzT83R3FGTemqP99Be6WAIdWVx3vnqxdD77Hm3+vZHWCFwG9pCc6U01
	 RSVufkuBFlHSysLoeMaHxhD7dR6haoDgZ4YjFtUFjH0WeXOv7Z0AgouBlSEpWAa4vU
	 AHLICBLtPkMGRgTGlkSyDN5z1Fr7dGhheZyD5hz3mhvvPlzvS3nFMgYa74rcS0DBR9
	 zFunwZGiiV9Ck03Sj+d3ipNNdWHPodasmvUJOCf+aeoyNlccbczbM5EI/iADKiVg0F
	 vLogMpbw6o8Y5qrUoKG/BuBVrgdCfuU+CsKC2c2QfRF/uyem8OprL+Y5vVP03cmv+B
	 vMMf3ogPinfPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTR466s9mz4wcJ;
	Tue,  6 Feb 2024 12:48:54 +1100 (AEDT)
Date: Tue, 6 Feb 2024 12:48:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the vfs-brauner
 tree
Message-ID: <20240206124852.6183d0f7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D7oW_TMfIZT0RDgaGKQjVSc";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/D7oW_TMfIZT0RDgaGKQjVSc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  block/blk.h

between commits:

  19db932fd2b0 ("bdev: make bdev_{release, open_by_dev}() private to block =
layer")
  09f8289e1b74 ("bdev: make struct bdev_handle private to the block layer")
  d75140abba91 ("bdev: remove bdev pointer from struct bdev_handle")

from the vfs-brauner tree and commits:

  c4e47bbb00da ("block: move cgroup time handling code into blk.h")
  08420cf70cfb ("block: add blk_time_get_ns() and blk_time_get() helpers")
  da4c8c3d0975 ("block: cache current nsec time in struct blk_plug")
  06b23f92af87 ("block: update cached timestamp post schedule/preemption")

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

diff --cc block/blk.h
index f02b25f22e8b,913c93838a01..000000000000
--- a/block/blk.h
+++ b/block/blk.h
@@@ -516,8 -517,70 +517,75 @@@ static inline int req_ref_read(struct r
  	return atomic_read(&req->ref);
  }
 =20
 +void bdev_release(struct file *bdev_file);
 +int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 +	      const struct blk_holder_ops *hops, struct file *bdev_file);
 +int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
++
+ static inline u64 blk_time_get_ns(void)
+ {
+ 	struct blk_plug *plug =3D current->plug;
+=20
+ 	if (!plug)
+ 		return ktime_get_ns();
+=20
+ 	/*
+ 	 * 0 could very well be a valid time, but rather than flag "this is
+ 	 * a valid timestamp" separately, just accept that we'll do an extra
+ 	 * ktime_get_ns() if we just happen to get 0 as the current time.
+ 	 */
+ 	if (!plug->cur_ktime) {
+ 		plug->cur_ktime =3D ktime_get_ns();
+ 		current->flags |=3D PF_BLOCK_TS;
+ 	}
+ 	return plug->cur_ktime;
+ }
+=20
+ static inline ktime_t blk_time_get(void)
+ {
+ 	return ns_to_ktime(blk_time_get_ns());
+ }
+=20
+ /*
+  * From most significant bit:
+  * 1 bit: reserved for other usage, see below
+  * 12 bits: original size of bio
+  * 51 bits: issue time of bio
+  */
+ #define BIO_ISSUE_RES_BITS      1
+ #define BIO_ISSUE_SIZE_BITS     12
+ #define BIO_ISSUE_RES_SHIFT     (64 - BIO_ISSUE_RES_BITS)
+ #define BIO_ISSUE_SIZE_SHIFT    (BIO_ISSUE_RES_SHIFT - BIO_ISSUE_SIZE_BIT=
S)
+ #define BIO_ISSUE_TIME_MASK     ((1ULL << BIO_ISSUE_SIZE_SHIFT) - 1)
+ #define BIO_ISSUE_SIZE_MASK     \
+ 	(((1ULL << BIO_ISSUE_SIZE_BITS) - 1) << BIO_ISSUE_SIZE_SHIFT)
+ #define BIO_ISSUE_RES_MASK      (~((1ULL << BIO_ISSUE_RES_SHIFT) - 1))
+=20
+ /* Reserved bit for blk-throtl */
+ #define BIO_ISSUE_THROTL_SKIP_LATENCY (1ULL << 63)
+=20
+ static inline u64 __bio_issue_time(u64 time)
+ {
+ 	return time & BIO_ISSUE_TIME_MASK;
+ }
+=20
+ static inline u64 bio_issue_time(struct bio_issue *issue)
+ {
+ 	return __bio_issue_time(issue->value);
+ }
+=20
+ static inline sector_t bio_issue_size(struct bio_issue *issue)
+ {
+ 	return ((issue->value & BIO_ISSUE_SIZE_MASK) >> BIO_ISSUE_SIZE_SHIFT);
+ }
+=20
+ static inline void bio_issue_init(struct bio_issue *issue,
+ 				       sector_t size)
+ {
+ 	size &=3D (1ULL << BIO_ISSUE_SIZE_BITS) - 1;
+ 	issue->value =3D ((issue->value & BIO_ISSUE_RES_MASK) |
+ 			(blk_time_get_ns() & BIO_ISSUE_TIME_MASK) |
+ 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
+ }
+=20
  #endif /* BLK_INTERNAL_H */

--Sig_/D7oW_TMfIZT0RDgaGKQjVSc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXBkAQACgkQAVBC80lX
0Gx3xgf9FzFvrp2EHNuPlUAmZYojBfQsvvBLXLYI1FCh0Z7o5I6rEG4PYB50bwEe
1EjnNAd966blP1Z3rZhBrbrSnS5Vy7E62BLz+qQN5NMZoUcr2IOGWGtrfLAcvRx4
DHYHzdfuH/SCK2LEMyCeO/056aVd+PYLDnVO/0WiQXPmmeCOiDvLci//1DAwcMjp
2jm2xQTYGc2BKOC+V6fOewaiT51Qinm50y0MHZ9vVtRtPrLA3s5QfNQi//3wEnq3
SqLw6KvlXGE+H+qVNKEbM5apc50+Tl4mSDvk8q7XG0wSn03e9jP6aoq5v/lHcLy2
o7OQ+PrPHofGObews9yrfnhcjfhvvQ==
=1eWX
-----END PGP SIGNATURE-----

--Sig_/D7oW_TMfIZT0RDgaGKQjVSc--

