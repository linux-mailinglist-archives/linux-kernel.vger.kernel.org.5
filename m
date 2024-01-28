Return-Path: <linux-kernel+bounces-41524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7AC83F3AB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1010CB217D7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662BB6FB0;
	Sun, 28 Jan 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I+adwXhx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABB6117;
	Sun, 28 Jan 2024 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706414055; cv=none; b=b1gKSWjXFy1LYEJFha+Wsqa3KjWFj5HGnLspYDfbD+3x/+10dpi7YKRVdqscEfUmcqtEPBcOC63WDZ11Hjxkj9VgnljW1OKvGl+qeBqu8poccIibBl+RU3HokmxnFql2z1TM3AF6Gt+GOx2w4XVyC+yE8C9Io5ZXhCaZGOmfscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706414055; c=relaxed/simple;
	bh=fNMX/Tld062cU1k8P29zXDpNo7Svmh8J5eBukjGgUHE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=scb8MbDP119CSmKX/9mtDXXC+B00MiDnI0ljDf07/Mufs4ez7N/Tk5dgscP0IW78gxP/sUEdXU3+x3AMuq0nl0X1dlwjAk23uv3I9A6P5nkiMelKyP+mPIbI5z+CPvevnLxaYSS/RhEfHF0jHMlmIiGfu86H12lerdVLSDj4l6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=I+adwXhx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706414051;
	bh=55SU5zNdXO7dQdWo50LtAdWazBc6pNXxRM+z/IsN2z8=;
	h=Date:From:To:Cc:Subject:From;
	b=I+adwXhxtB27MaY4Bzt4IGnPSpa6N1UXEVPa+x+BgSoF27QaBSAMBMLJTgVpxaRX5
	 ODSZYmDGP2P4DYNkeGCkHKBdNtDRSmUIdGjdiTso7KXzdL93sreBze+17atSVa+CKS
	 7UZMqBYzitiMSWLwiUz5dyx6t+x63JX7rWmYtz12du06oNhnwcSX/vbOA7729QWxjH
	 NNNkjbCkhZ/FKjagCp/yb4lyd+4mLzsPEBtW/R+Eqhi+IRCHFNWNWDG8ljBdCB4GwC
	 8Ey+XAQrqwobGU3IEFCmZu8zB40SMmReogeSOwkwgm06126RUApXhiYTKbpm/he8Xy
	 UYYmM7c8T5gnw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TMyGq25wtz4wxv;
	Sun, 28 Jan 2024 14:54:11 +1100 (AEDT)
Date: Sun, 28 Jan 2024 14:54:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the asm-generic tree
Message-ID: <20240128145410.65bd7980@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M4iQUNdvrHgRAAe7bNPM+CH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/M4iQUNdvrHgRAAe7bNPM+CH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  34b2321cc648 ("MAINTAINERS: Add Andreas Larsson as co-maintainer for arch=
/sparc")

This is commit

  61f61c89fa5d ("MAINTAINERS: Add Andreas Larsson as co-maintainer for arch=
/sparc")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/M4iQUNdvrHgRAAe7bNPM+CH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW1z+IACgkQAVBC80lX
0GynRwf8Cbxi4pA5yWAWps3N13Tu/ifi4yt4tHQywQOwZQdmuiasEwcqZVmfKjLa
90uVCoWSmQq/WixjJEyXS2VVE1ZbE0072buUTBF/w3WadzKi/T2zObMKVBgj8sgB
wrfufh2Ez5mDXfpuwlGqugdlgDNTkPplBqYnF0KtMLwPRVLmvaMw1sCtkVmPiC8e
ZVaceC/uwZ18sd7o+1CY9lb5KYLaWB1uwm63navauLqTpnlzTq4D7oe5Gj/vANqp
1CxgJpBGBHTwT1Dtb/jk80/hIpIq/0h3wGLznM1Vv8gYoG/3pChuJ+vA4oDcQY5T
UB8Y4R104IroQBeFFO+GWQlLgzfolQ==
=fg4w
-----END PGP SIGNATURE-----

--Sig_/M4iQUNdvrHgRAAe7bNPM+CH--

