Return-Path: <linux-kernel+bounces-127070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C818894667
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5532821F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190054BD3;
	Mon,  1 Apr 2024 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sXjMUqJZ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCEF53E35;
	Mon,  1 Apr 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005794; cv=none; b=FzsqjWS/crW5e73039ejBJsyeCiCj5JHjnzRtn8RAo/rneiPE2qgcEWo2tEuWvqvxoHBYuMNFmdZzXKEvmwjPiyFZzKdN1mUOGAhTXQlgYpKVlOJR7nx2hFHjANuSDLjyuTLDHRo7V0YvM8/N2QrVLzLfgNI8UWwyW6VPUiyCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005794; c=relaxed/simple;
	bh=tA+LAgwHvXVBYCf5xFYuoaXlhCog5CNRglD0+y0EJVM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oI3cs3TR7OsrsYj0WNMJqvRXa0+wkzkOFAHdhaQ69ERRoA3Q/+rXeXRel40D+CjVOWHuGFxtX8jZWShNLdb/9dK+xb352mZQ8CkQIXiBCtIiWO0A8fgyd5/2q03kgMiuYnKl5zW01ztmCB6GWlfzlD5qSnP12R5XN2LA8VhhOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sXjMUqJZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712005790;
	bh=FdraD/HXMlrnb9uIEk8mlAmMFORLDh7t0a5WqHXVvGU=;
	h=Date:From:To:Cc:Subject:From;
	b=sXjMUqJZG2i7YS7aLTVQPIkn+MfkpM//I45Ek55qGpAj7gLy00uruBNfcLwv5zUcl
	 zXr38RDNDP/cTDpZdmcVqVyyhbgrcC/UBGgTiuKjsG5X0WGlGcfbr5xPUhOo115kLP
	 0ltG+o7QQKkZYwlddSemoJ4tRhg/YpNvDsBhqx61zFiDWb9GvABsDEAMl++l+yhUSF
	 apb5dgUIBD9Y8EPDvF87N6GXuuCA5slYEeipNkrigiFAwIhpjvybVE8Omtq8hhh98H
	 I/l66ACmvXtuRTzOvIU521/KEI00rJSfscx8au5iYUQqBIPipBsPLqQQtWQjBit65W
	 MiViJfFrD6aqg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7kDG2hxWz4wcq;
	Tue,  2 Apr 2024 08:09:50 +1100 (AEDT)
Date: Tue, 2 Apr 2024 08:09:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Corey Minyard <cminyard@mvista.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the ipmi tree
Message-ID: <20240402080949.20b4a9b5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W+My7znABgA3dPIVe37kFlm";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/W+My7znABgA3dPIVe37kFlm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  090251a7852d ("MAINTAINERS: erofs: add myself as reviewer")
  912635053a01 ("erofs: drop experimental warning for FSDAX")

These are commits

  7557d296ad43 ("MAINTAINERS: erofs: add myself as reviewer")
  a97b59ed7968 ("erofs: drop experimental warning for FSDAX")

in Linus' tree.

These commits in the ipmi tree are also missing Signed-off-bys from their
committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/W+My7znABgA3dPIVe37kFlm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLIp0ACgkQAVBC80lX
0GzOSAf/QgmmMNatz+uxrBC2yEEKcHBesdIseEJ71NXev+ZqQuspM3qS70lmuv7f
Zu6nDTl0y2qgYqeXkFK2EIdhWOzqvNeHPkVL9tMOzLs32+JMlViNJdxSKHw0SOXt
QBh3s2N1dbTJ4bswcswxhQyOYukXWKRxL4s83Yiak12sQx+f/j5mIj9907yf61dU
A1pTmd6YHM4x+Uwr2KeBPmbVDKuEtF+FMvWa4HjP5gWpjABYL/B70eupXni4ufBB
3E8Gw9CIKxz2ynqnvouZpiWYrIBc3ONQVzBRcqA8qFxViGvcg73/0Qbtqrevflqk
p+tMFQtkQcQTF/MMwM78iJxHYrUhCw==
=DVIW
-----END PGP SIGNATURE-----

--Sig_/W+My7znABgA3dPIVe37kFlm--

