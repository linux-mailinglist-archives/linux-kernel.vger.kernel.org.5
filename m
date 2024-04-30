Return-Path: <linux-kernel+bounces-163478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4248B6BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15C71C21F23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719AD57302;
	Tue, 30 Apr 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AGYCS9k1"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8A3B185;
	Tue, 30 Apr 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462247; cv=none; b=KpnQU1Z2fvvOrBaXVO8fqYnm8Kem5IoOjRBpeWYcu0jbT3jv1pM7U5l/3tIk5qWe1zASXJE9sIXtvUwyEvGnmQzcSiB6c+tSWKHpYGjh7aSwdAAXxL7X8q/g51kTRksYQgbTnqLyIgJXjKoY5tWlC4NBAneimXVHAvLL3TOl3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462247; c=relaxed/simple;
	bh=uPdJ5zLRePWJFYniZ56mSpMXsJZnGk5J/HnqfyeKTN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oAJgmqax8tbUiaSgkWjl1gj1+59mNqHODi3iBl3YdTQ9Q19BgF2KoQIFyP0zbfeVfXgDgKna+LZkFqKnajIwFSvYpOJOXWUte7xqLtR91RR1KV277HQQIKdMDchKC79FQa/AVBGONXLfmOSQLXGVeuzaqsdPVyDmsX5Wl1JP2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=AGYCS9k1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714462243;
	bh=YV02u5QwV20mBAAMzjI0KxnXRUSnPsS3js26fPhuJPw=;
	h=Date:From:To:Cc:Subject:From;
	b=AGYCS9k1EP7H05s/ThHnmc3QRAlizmshTYSOIK3OfiJC35tT9no8SuJ1db2mWqvcM
	 M84xH4yIo2HCUepeTXdQPcMlTG1BopYwV6NVfpB4QWBV+OOIvuvxaHJnJ3745V2cLF
	 08oY22/Z6xauDLtafAccF1eQ3z1Df2u9ZWIU/f494xluh4cr/uf7r1aOpNIJEGhw04
	 wA//5gDBPr98cB9YdincvxgHGNPC7r7svJVpNOtBtbvOO/fMlHzj9vsPccA4bOC8cq
	 Nx6nMaTWVFijLq6s8P+zYuKPj/WcMqUhmDZJwLOmvzdggMyc8E5slLrgPQXjgqcJUu
	 OWsLigBObI1+g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTBgl0GTqz4x1N;
	Tue, 30 Apr 2024 17:30:43 +1000 (AEST)
Date: Tue, 30 Apr 2024 17:30:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joel Stanley <joel@jms.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the aspeed tree
Message-ID: <20240430173042.09beb33b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w_ZqG8u7mIbU1rRIfJ0hXfq";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/w_ZqG8u7mIbU1rRIfJ0hXfq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  7ad71c3ab70c ("ARM: dts: aspeed: Remove Facebook Cloudripper dts")
  822918de8113 ("ARM: dts: aspeed: drop unused ref_voltage ADC property")
  1c59d3bb17bd ("ARM: dts: aspeed: harma: correct Mellanox multi-host prope=
rty")
  b1438072a1b8 ("ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host =
property")
  7a18def88f5c ("ARM: dts: aspeed: yosemite4: correct Mellanox multi-host p=
roperty")
  6868ea774af9 ("ARM: dts: aspeed: greatlakes: correct Mellanox multi-host =
property")
  c6216502844a ("ARM: dts: aspeed: Modify I2C bus configuration")
  820b26245c01 ("ARM: dts: aspeed: Disable unused ADC channels for Asrock X=
570D4U BMC")
  c3cbae95b768 ("ARM: dts: aspeed: Modify GPIO table for Asrock X570D4U BMC=
")
  b082ef171796 ("ARM: dts: aspeed: yosemite4: set bus13 frequency to 100k")
  05d841927ca4 ("ARM: dts: Aspeed: Bonnell: Fix NVMe LED labels")
  c9afc6de3235 ("ARM: dts: aspeed: yosemite4: Enable ipmb device for OCP de=
bug card")
  60f246d9a779 ("ARM: dts: aspeed: ahe50dc: Update lm25066 regulator name")
  2fa83625243b ("ARM: dts: aspeed: Add vendor prefixes to lm25066 compat st=
rings")
  066abbcbe068 ("ARM: dts: aspeed: asrock: Use MAC address from FRU EEPROM")
  f7576de02d66 ("ARM: dts: aspeed: Harma: Modify GPIO line name")
  65976d4bf07a ("ARM: dts: aspeed: Harma: Add retimer device")
  f06b561729cb ("ARM: dts: aspeed: Harma: Revise node name")
  0cd34ddc24ea ("ARM: dts: aspeed: Harma: Add ltc4286 device")
  ef24783564e5 ("ARM: dts: aspeed: Harma: Add NIC Fru device")
  e27a45b54b8e ("ARM: dts: aspeed: Harma: Revise max31790 address")
  6d06fe68aea5 ("ARM: dts: aspeed: Harma: Add PDB temperature")
  3a353bce1b6f ("ARM: dts: aspeed: Harma: Add spi-gpio")
  dc086e298c12 ("ARM: dts: aspeed: Harma: Add cpu power good line name")
  bf3e7f0c2242 ("ARM: dts: aspeed: Harma: Remove Vuart")
  94b3ac0eaee6 ("ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.")
  1690f5b8008c ("ARM: dts: aspeed: Harma: Revise SGPIO line name.")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/w_ZqG8u7mIbU1rRIfJ0hXfq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYwniIACgkQAVBC80lX
0GzWcAf/V3HQUPK6MF7V1fEI9ya32YTwUMjt8JV02pe47XKmUdKKyAGkeRSUtyJZ
hO7FjVfrWU7xvZ1ORRLCX2Ods5/32IsLmDQUhUsrzO5dqUyh0/lqrdaLULTtHecY
Xp6zGhmw10Tp1rhkNAICuHBFc09BPWkhi/NIqZuYZcbB7qTO+6IIFigyEDbL1+cz
sMVByFCoCzKxR6l9xszIjQngzFmuec/povY7kRN9ubS/n1ZXoZWmyTzKo69uiRLc
EqUV4lDklsHLFC8jIITEOSGnyf1gR+Z/y7DEcuUMbKwRu++GLssWULI5bLx99WYp
LH0/kvVv04XPVrGGgh2McCAzVBE07A==
=FVs7
-----END PGP SIGNATURE-----

--Sig_/w_ZqG8u7mIbU1rRIfJ0hXfq--

