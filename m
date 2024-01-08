Return-Path: <linux-kernel+bounces-19071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF6826771
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625C41C215A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE9C3FDC;
	Mon,  8 Jan 2024 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QUg1mS/a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D110F5;
	Mon,  8 Jan 2024 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704684989;
	bh=rLJkeC1ri2q4IsnLMJ/ivzjYisiUMhtXCeHKxDAJr+k=;
	h=Date:From:To:Cc:Subject:From;
	b=QUg1mS/aHOvGTBet0I0I8iQnVx0Ys+qcANNMupVtI+QZFhCl/nFR+1UoCPAtcjqgj
	 +GQKfYYYN2q60h1OitWOYlZQSLgGy8L8++befyIuM09aI2P8/Mm8M+FmfKu/S0+1mw
	 nF2xsmLo+XSQJa2pyIp5J99mTiU2K+Y4vdmHN9EwaE/uvoC7YOv5o/ZJw8b5sX5FQO
	 AeYLYCfxHFjpsJOK1mjyASAdjdDcKNdyGVBs9YELY4fhF4k0Wu3jbY3du4lQm4jK3f
	 TfP1fTdRhRzKDobDHREm3XlmERKlMd+GGRgq5tZajMDD2ojEhlQ42iYgE4jALMt4jN
	 MVJYwk0J56DdQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7fqc5lSfz4wcg;
	Mon,  8 Jan 2024 14:36:28 +1100 (AEDT)
Date: Mon, 8 Jan 2024 14:36:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Yury Norov <yury.norov@gmail.com>, Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bitmap tree with the tty tree
Message-ID: <20240108143627.29ac91fe@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/joe/0VJoWKMra3/TtN=Q_XD";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/joe/0VJoWKMra3/TtN=Q_XD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  drivers/tty/serial/sc16is7xx.c

between commits:

  8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in=
 case of probe error")
  3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one reg=
map per port")

from the tty tree and commit:

  e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line()")

from the bitmap tree.

I fixed it up (the former removed the function updated by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/joe/0VJoWKMra3/TtN=Q_XD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbbbsACgkQAVBC80lX
0GwWIwf/UTC0V4/vsfmGBdLPKQTKU10BciR19F+wmCfF5gbfHpjHabEzVPVK8HIF
C2pEfpFYfsm2dmMooUvcd3cnxYHyynq94U2omzBgPTgtXUjbSpDDH34eylehQHc3
nPFeUtvfkxhLCcoBAf3O6W5ubwzo1rNNLsJIP23/Sk2eDJJem/u4D9hH/Dxky6iU
Y2zuL7s0lCtLqiM15by9STcKUJjiSkDG2LUuIP5SULbool2XGcvGC0nKrGgRHE3P
7pFkO1/r6AUN6NXthYlqVOPzSroupqKu/HQ0klvsXpdaLcBLh3/+UUkEILBIDMRP
2gnN8vJVua9XmtOO7lX4z8l8Dq9yVw==
=s768
-----END PGP SIGNATURE-----

--Sig_/joe/0VJoWKMra3/TtN=Q_XD--

