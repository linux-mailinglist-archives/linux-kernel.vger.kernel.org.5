Return-Path: <linux-kernel+bounces-7772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6A81ACDA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27188284398
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEEEB662;
	Thu, 21 Dec 2023 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="msOHwjfu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED0AD39;
	Thu, 21 Dec 2023 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703127686;
	bh=S0WymPy34W2d4KzOacMTp93C73SdBRl/bJcClUs3eoQ=;
	h=Date:From:To:Cc:Subject:From;
	b=msOHwjfu7US9+VCSsdS1JvVAofWaoFe70cw9xuT7t/u7pDUj6MsSMSCeKLXLXJj0d
	 eQ/I8y1voSqwcS6BdP8AOw5PzAw9CPjScO7jnu7ZCC8AKEs0Q1Dy80oUBgxYfIeBvP
	 TCAmE3I6X7/l/URdHiMROLiDL3R3Z2mVxFYcRRFK67scTe4vLqQgpQUS9gD8NIUeuo
	 a+oqN1f0Uupr+tgJ6sELHxEt5o/zw2cZs9cqLqXDuEGZZVT2RNAQ++5C59MssKK6Or
	 IdsJylkweHI5VNlWDCP5Wv7MbBeWgZUA9fY9Y8ZO4pelOPu0Slwo7XsFEspyJIAcz1
	 PrlKXr66DEKLw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwZvV3xSRz4x5m;
	Thu, 21 Dec 2023 14:01:26 +1100 (AEDT)
Date: Thu, 21 Dec 2023 14:01:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20231221140124.16418659@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OqGlL=TCOqe9Hw_H4pzM0/q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/OqGlL=TCOqe9Hw_H4pzM0/q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "disk_clear_zoned" [drivers/scsi/sd_mod.ko] undefined!

Caused by commit

  d73e93b4dfab ("block: simplify disk_set_zoned")

I have used the block tree from next-20231220 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/OqGlL=TCOqe9Hw_H4pzM0/q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWDqoQACgkQAVBC80lX
0GxFgAf9GRxZ9eE3qM7WS9sJzmUmBQLp6b95Ab4n2cwqm7Jy51zrwBbLebEQb5nC
j4RZVunCTL6zqvEjNr+Tme21GthEnzm55/lu8vqsbDz5FIkrTIVcoVhSDN/BUGDo
Hyor18lkc75tIHU70HAJVn4fctOJXTnviSuTcJdIV0n625NqzvGkseNOTQR3Do31
4XTGHMvcBiIYS4bIsyjKyxw4Sp6kxGSKP7YJJAcCX+uE2WDBvISj9H/rJ19YUOu6
DqRn2Y6bZX3ZOv46zhDRMuhDo7ij3B4oWggirlniMm0LppfjhNz2lWP4Nc05eYGi
H2o6I22dZ2zUDxC7Y7DHd8+cbRVH1A==
=nq7S
-----END PGP SIGNATURE-----

--Sig_/OqGlL=TCOqe9Hw_H4pzM0/q--

