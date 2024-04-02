Return-Path: <linux-kernel+bounces-127237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3FA894873
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C92FB21DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E752CA7;
	Tue,  2 Apr 2024 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qBhA8C90"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC9C81E;
	Tue,  2 Apr 2024 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017309; cv=none; b=e/Q9xOw5GfDVohXp65LStY7E/lX2xghRe2wtiAYsKPSJNleqXiUx47cAaF18AVLnvvfpeomJLNp1yI7gkkHxxLZJMK80PuBSVHg3SY/s+0EXnPD9PM+X7xXw4DpREa5N7y29HJR3ScD+QChHzFEsX/tZhSW9SVKn1N2+P8TizqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017309; c=relaxed/simple;
	bh=w/+a/gEdJV0jfT4VPwgdXJs9Gu+Y7ljqsDSN+O7LGjI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Aw3uN3+ZAWQrDyjNsdAie7pDJVgrqZGrbeNt8Lllavs/jdY1bicF84XtonmyWsOTzdMma+1xZ7rsYKHuiEW7H9dYgWSNqFUw7gZOBK9l04ZFIKojumt0a1QO/KGhkJ2GVz6RMR2eVp91FezuGCWvJUebzM5qVA9I+cu+TiFN7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qBhA8C90; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712017302;
	bh=gMMtVq5Lf5HuxAgdXLsccd9foneJW+RAfAaeZNb8sp0=;
	h=Date:From:To:Cc:Subject:From;
	b=qBhA8C90srhrosWy9stwVD223mZeSuijkjdCZPnMfE31qi6Xw2wV9OLiSAJ739rxp
	 OUuNqL9NmR96aZXfz+i3hynfTpIGtpl4/Y4pPVRWwmKeE3HNGEO9B47seNAN6slvWx
	 9OX4ZeHWegcQyeo0ZuVReFPUmRypimIIcST2l3wjPUydlmGw0/xVOzbGlrhTwAd7r7
	 LF8N7gTXPH11h+1SiIjRurU2HHgqM9cpG1iTA/ELInUulrBlD7OFJVfFQ8Q2Di0G76
	 t8m4KQ+5OIFCKnYFbkytL58y7pM8SlQSPGQdT3c1jy9kq84SGSYV8srd1GqdJRBLDT
	 MTMVkOgVd14sg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7pTf1GLRz4wd7;
	Tue,  2 Apr 2024 11:21:41 +1100 (AEDT)
Date: Tue, 2 Apr 2024 11:21:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the vfs-brauner
 tree
Message-ID: <20240402112137.1ee85957@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BxCzTd0iDCwaZ201janyBC4";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/BxCzTd0iDCwaZ201janyBC4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  io_uring/rw.c

between commit:

  80a07849c0b8 ("fs: claw back a few FMODE_* bits")

from the vfs-brauner tree and commit:

  40ffda3dc1a1 ("io_uring/rw: always setup io_async_rw for read/write reque=
sts")

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

diff --cc io_uring/rw.c
index d9dfde1142a1,3134a6ece1be..000000000000
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@@ -1021,13 -1003,13 +1004,13 @@@ int io_write(struct io_kiocb *req, unsi
  	if (force_nonblock) {
  		/* If the file doesn't support async, just async punt */
  		if (unlikely(!io_file_supports_nowait(req)))
- 			goto copy_iov;
+ 			goto ret_eagain;
 =20
 -		/* File path supports NOWAIT for non-direct_IO only for block devices. =
*/
 +		/* Check if we can support NOWAIT. */
  		if (!(kiocb->ki_flags & IOCB_DIRECT) &&
 -			!(kiocb->ki_filp->f_mode & FMODE_BUF_WASYNC) &&
 -			(req->flags & REQ_F_ISREG))
 +		    !(req->file->f_op->fop_flags & FOP_BUFFER_WASYNC) &&
 +		    (req->flags & REQ_F_ISREG))
- 			goto copy_iov;
+ 			goto ret_eagain;
 =20
  		kiocb->ki_flags |=3D IOCB_NOWAIT;
  	} else {

--Sig_/BxCzTd0iDCwaZ201janyBC4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLT5EACgkQAVBC80lX
0Gx1iAf+NrBJVTcz8K/6ezjUANPifsGkqwpKblsc6vyphLQiJUQKyh6qwC4hTjTr
7XUm3/ji8aU+vCpzYyeW/t5JGOi12co3tXwFLKFbxy5T9zQZX+b+bpEEKZ3mXc4x
3ctrmBlVLALe8Nt3KdawTsl4nvwswvBOzmemZyyu5+saHEC0HapImLyzuvEeFg+9
eINhHu8zoEjTuEpAxleJ7RnBlPFpdYbjAFCiHO0hVuzBNFxcDN+T6myR8fHdgQth
sNaE+peJbbJXmezN3jeiZNW/oiVJ+M7gKK7J7JaAPFPQ3/5nH5NyuaJ+M+O2TeHt
MSvzvk9QIC2e5yaxLF2EJlhtKef/7g==
=06Jt
-----END PGP SIGNATURE-----

--Sig_/BxCzTd0iDCwaZ201janyBC4--

