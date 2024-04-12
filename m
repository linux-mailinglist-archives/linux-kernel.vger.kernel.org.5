Return-Path: <linux-kernel+bounces-141885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5CC8A24A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182791C22F97
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C71BDD5;
	Fri, 12 Apr 2024 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IC89YYYG"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53F1B969;
	Fri, 12 Apr 2024 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894467; cv=none; b=sIl5dm9JAf8Wj9i+ErV5e8tSUVvo2zRankgr10nfJIQyXpnZ0Nbr56/HeOAQxRaieuXZMPb4o0wnAxERGD+XcQbSHq2HrNIgVZyF8iUVI9Wvkcq/2M6C4Ztwp90N2B+d8qD295oKtRUNULIkACCyavz6ly4rn6gFdEBNfi4/jiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894467; c=relaxed/simple;
	bh=uKJEdkuqObNwzsOLjGM8Ryn65+yLfthADNScnD8MS8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bkXGALc3CS/EPEsMcNGjl4pzceQhDIkvSnNBgltt2iZ9awAqA+ZE5u7y9AgQRwC+7VqgvCzc9jGkJSPZJZufIDQsal67NS4n7EWwBPuTJ/DLXLxFoEJ+8zO20ENgcRwIX15TgOglI40s4HpPaUILi6E2zn4Ii2yh1EtN9oN9f1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IC89YYYG; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712894462;
	bh=6m9kXNEyojyEXCojcpQYTQKgcX6AZuvcrDVTGgFNX4Q=;
	h=Date:From:To:Cc:Subject:From;
	b=IC89YYYG5H7TgnWfVbap1fhf7sY6KSve7cY995TxVy7euxT+kpw2i7vJa6V68Js7U
	 OFih7z44rG1UJk9WPZFB5BRGrsErd84NRJ8ZDSB1gVdDOJP4mIKmEs/1e71NoleMxI
	 Fyulv6lfNyUHjzrPaT1a9z64AVkLDrt2yU1Za4y49IRePqqsZ+rF2lKiQkfW71lYky
	 HjAaKmtb73DwC2uG4txPBbyhWSIZJEATEGZ2V0lmr3XWHNgYkzEQkIg6zU1pSM8mQo
	 EE0npIyd9rmEN4FpCGe67Hk9ChPLWSrm0EcF3fGKAo2zFg0U+W8bydNIinBYtlK4aJ
	 bOqlHa4jfetVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG2t630LXz4wnv;
	Fri, 12 Apr 2024 14:01:02 +1000 (AEST)
Date: Fri, 12 Apr 2024 14:01:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the leds-lj tree
Message-ID: <20240412140101.45d125c3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wj9XIGCAbSrdR5P/AjygfG5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Wj9XIGCAbSrdR5P/AjygfG5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the backlight tree as a different commit
(but the same patch):

  da8310b24223 ("video: backlight: Make backlight_class constant")

This is commit

  47e184e212c7 ("video: backlight: make backlight_class constant")

in the backlight ltree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Wj9XIGCAbSrdR5P/AjygfG5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYsf0ACgkQAVBC80lX
0Gwjwgf/QC+nf2jV5y9AcUyq4wsf5Zku+Du4TE/1mqBnIA/XdZwZF+dkvXgboVB5
lTw4R3BtFETJ1vX2i3SYkC0xef3u1mGFdJkb4C3bvQb6cMYuC5Tgd7z75DUmuxJS
27hkhc7+5wVRaIcL/UPuMyZm05iYwu4vsJU1LtNXucOzzD2aBCQh6jDNKo9f0LKG
uhApKZv20vuOakS+6W9UpLmTqHdcBRMdezSZjJHmt1It7Y646KIYseukjZ1ecRwz
xg3EtpXZmpuFOC6RmuEm/DRLq6+Sqj9cdivaC8zpDLNTuZjF4n2Cvrve1Ovbv4cc
NqSKqi4T4+U0rMkp1hLRmdzP0CvxWw==
=QqFd
-----END PGP SIGNATURE-----

--Sig_/Wj9XIGCAbSrdR5P/AjygfG5--

