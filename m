Return-Path: <linux-kernel+bounces-73996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE885CEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C3284925
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACE236B08;
	Wed, 21 Feb 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iJvg2D1x"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4D15AB;
	Wed, 21 Feb 2024 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708485668; cv=none; b=EiLPKrGZ+KLk6x5jne1JhjEac9Z9qdolNBJZP7QBtYc+kDaUwytsPq3KpOUs65oBtNQd+Fs088sP3G2ytK5Zx3JkCXrXKm+arFKU02EiS5JV18CYO4ulqUei8GoDdPkDmNFjzjoTejeWWFfeOwVsw3JTUJJvip0m2N9KO+yU0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708485668; c=relaxed/simple;
	bh=3FVD/bQ/bZkFsEqNdtsPOy0/dKFOsdBX7/CfAPg/Zeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZVN8F9HYEiFFmziZfmszOHh8SpyRfnzhz++2SCyyyMqxFqPWhbgTlmNmy61gtwM26o/v+B+hmNgH8GbQOp2bVZoV2NE6RCPGxZbobg64ZvKIt9YSTKE/BRzSMvpael5L+64UFHxIormgV0jA+QedteVKjVrpS5F+Y9mtEXwUWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iJvg2D1x; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708485654;
	bh=Kiq0QnAWq3G8N6dzzJ1Pm1mz5087U4HdyszqA5U5H1E=;
	h=Date:From:To:Cc:Subject:From;
	b=iJvg2D1xgq3I00V8dGS/N4N9jGBV0hc1jJCpS29SAFoVUR7lhz7b5TSC1Ol6N/tLI
	 fhrLVf/QmEZ3yiT78BvxFjbjRfhZ/Ganb7C2VXYEZhzmYMLV+8gnbJ1zVFq2iNCsLb
	 7BqYwKUdPGuzAjgdapyTSaP0oZc4vEdLs2DjI7D7yUplVFdhTLWppZDvY+xFgbEig3
	 XalabBAZjjik8bznZqsSwu+rHcgScojIQbDmBtmpznJNCBuKQZUaFXnaaSw+1YA5jq
	 L5wUTy1EaYcQYlB5/mXemcrfjHcqfjxXoaMdaTonCG2nIenLA7KOaABcTqejQawb1q
	 FVpnddPX6ox4g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TfhPK4RWdz4wbr;
	Wed, 21 Feb 2024 14:20:53 +1100 (AEDT)
Date: Wed, 21 Feb 2024 14:20:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bitmap tree with the block tree
Message-ID: <20240221142051.4509d214@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XSxZsETA=CNUVatTwTG+TcD";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/XSxZsETA=CNUVatTwTG+TcD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  drivers/block/null_blk/main.c

between commit:

  8b631f9cf0b8 ("null_blk: remove the bio based I/O path")

from the block tree and commit:

  f3687f2f7db4 ("block: null_blk: replace get_tag() with a generic find_and=
_set_bit_lock()")

from the bitmap tree.

I fixed it up (the former removed the code updated by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/XSxZsETA=CNUVatTwTG+TcD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVbBMACgkQAVBC80lX
0Gyjowf7BxyoPVDebT4dzznMrC+aB8yDVU0b7lzxSgvNFSHiblNwLdfpA/SJk01M
RzQH61dtM4Rew8XhongGm1VyM9ybBfQsOKyRX8jfat6nldsN53agwE8Kic40Ic5h
U77pxmSxyFGadRK6OqtnU/lwlyUGMg8Ed19xcN0UWZ3ieq+Cn8inElDwsSChb2oV
aJ+kvPmJibBOvTpSMj2oajqU5zOunRn4F0MCR0dgBtUcJevmrffVgPEL8Rb9GgQl
bqUx/+mqoQOGUz3gMcsmG9uTq87twXwp4KHmzuXWCyJ0A6eVsFnd2UIWpAHGt4CL
eF99yF6azPzaJ/NM+ciVtHLHqBVgqA==
=fcfk
-----END PGP SIGNATURE-----

--Sig_/XSxZsETA=CNUVatTwTG+TcD--

