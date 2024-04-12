Return-Path: <linux-kernel+bounces-141994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B98A25DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF991F22DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFB71BC4E;
	Fri, 12 Apr 2024 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iUQ3Io8O"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902CCA6F;
	Fri, 12 Apr 2024 05:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900776; cv=none; b=Gln9dQCadxFi1hMVNEzA5mIBsk0mstO2oujyyz6uKjtk9nqPDyo2zRqpix6UmbgZkz/s9dEOD4TuVWiuJrj0rYOwuS4GTaBUZD0/Iu6EdHrMlBodFFKqaS707rQEse1I2KrsNqZFWuGdmpMrAwYUTpRVNb3gIgaF95RyyWvLakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900776; c=relaxed/simple;
	bh=rXIK8VtkdhVmsAblY71GsUzQ8Dd21JdSDvf4s/jax3A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dgrLsxS+QSY7KOPHUHs+MtuvBw76PON0dSY91fiXl3XneA3XEl/yLEVa8oSPEfGagQnMBeNe0QJWYr+KzCI5xb0gvuSQtdPMnIOiEGthBs7Rs6ZMXWv2uVJyOxmgYjyN0/AYvyOiWKUjCM3hyPkd3zC9Jp6Fji3Ug8Pp3YNIvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iUQ3Io8O; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712900771;
	bh=gvQoxZ4IJnyUZsu/Lle10vTyY6xNeFLmwmCbgC0qlrE=;
	h=Date:From:To:Cc:Subject:From;
	b=iUQ3Io8Ohuy9OStDWFQUkx0+ZVEmHRyFwGW99RuEOUGm927paEHRNhKNV/VKXdaei
	 gacINKWq6bU12tfMG8y6gybzNe9Kuwcckl3Z56R2+GrQ1DshCm3IvNJxw9wmZ7ohTM
	 bR5rPSqqH3/r/0/GPE3LLFyJtje4sxXN5N34/GF0D9FwjMWOSez9PItPg9P5sylJxu
	 0jXQafw8zhj0K6VKawmlGgCrEj54Q5lUGt8CqnUlvY8TNOQTsg2reggzqB3n+Byk7w
	 TMMUHWErIAQSkaIm4y/KM16krYXQbRtbb0kXQUVNcL2a85q6iETGUAFXsIL/kn898Y
	 1QxJv5gb67pWw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG5CR0383z4wnr;
	Fri, 12 Apr 2024 15:46:10 +1000 (AEST)
Date: Fri, 12 Apr 2024 15:46:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20240412154607.1b5096b3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_CZJRndn/WapJE.==_6XcmN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_CZJRndn/WapJE.==_6XcmN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/usb/storage/uas.c: In function 'uas_slave_alloc':
drivers/usb/storage/uas.c:826:17: error: implicit declaration of function '=
blk_queue_max_hw_sectors'; did you mean 'queue_max_hw_sectors'? [-Werror=3D=
implicit-function-declaration]
  826 |                 blk_queue_max_hw_sectors(sdev->request_queue, 64);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
      |                 queue_max_hw_sectors
cc1: some warnings being treated as errors

Caused by commit

  a2ad002485c4 ("scsi: block: Remove now unused queue limits helpers")

I have used the scsi-mkp tree from next-20240411 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/_CZJRndn/WapJE.==_6XcmN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYyp8ACgkQAVBC80lX
0Gyckwf9Ft2cVQ9AahQ/8S+qN11b7qVFoGvCOLvWx3xgj1NtwMIWhPa/W9/33r5j
UJL7+l+pqZLNQrDn1w9FuV/qqf6eYfsGeCA+lTjWMiMrB9lApb4W5sV+JUz7zTNp
6mnk8T26QBPxf2xqgfZ4oyIDmlIZy5kcw8YRaZNUx/NilRjSmFp3sf7F0Db6IRgz
oUft4I4ugrORR5T35yOvD0xLFFObnR2YBEZ7lrIZlQTZDV5DtrylLa2bQ6RBxV75
TmNLY6f6vB4vTyjFErV/3WlCypppETgNLiXjheVhVIdOD/oGPbejIvgs79VibTGv
0eUg73alKT7WXojzN/+L8UAm78DdsQ==
=ugdD
-----END PGP SIGNATURE-----

--Sig_/_CZJRndn/WapJE.==_6XcmN--

