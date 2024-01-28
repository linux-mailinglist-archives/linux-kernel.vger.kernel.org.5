Return-Path: <linux-kernel+bounces-41522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C9C83F3A6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247DA1C21384
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F50469E;
	Sun, 28 Jan 2024 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Lvds9SRs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9B1C36;
	Sun, 28 Jan 2024 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706413546; cv=none; b=mf7djzneiRhPE92EhzhEQegAhNx3amYHezDWBCbHd8aP9QQqWKOmjvnNLQhylJIj9BN39K9bmA7KFXb3Pbget5BzCQKE8p7yIRNZWqveRrPOoaCaxV7FR6HwIAsHwbcmHUsUSRBRzQghwJv1GyrKYt7b7zyLdS/UKkRZDwFAIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706413546; c=relaxed/simple;
	bh=GyG3XRmmIxmkIx2xPPpLaY05k99GraX++O3IXXHsvT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MIIkL+X6mWOeN4s0ZhSTwlAQJKLxs1WGUjqPANxTinXRZ2He6bTZHLiK+LaYALitdoZFlgT80PSX4JugEyYtX+PDjKZYOX3jk/7BudfLWq8GlUzCvjFjkg4lib2m9f1bbXkXAVrP6UBNP/qTDgLTokgizpLSnIGXQ88dmLO8Vnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Lvds9SRs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706413541;
	bh=taedcObMTGubyjHmYKbWTUWvc+pOzIOAUb6FsIlbmwQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Lvds9SRseLB/SNUsH33Lvdlb4cA9CtIPjNvBPwYv0+3o8JhAH3LF0SUpPIz5AE+de
	 MubJ66ewulp88YFaiY/Cyaeay3Zaz0JyeKaZNeMtwHkCETp5lnnR3cJ0cFN+4EOj8W
	 NIEvuXLUKOr5KHa0GosnXkFrxgWJWxzi2dl6Kgiafu2ghVxOC9Y+dYNwV49BToDIrS
	 CAPa67N3paYAXfAGbFB6+UDpcu2X3o98f98hNg2dTz2jPVoWg43FT8InPiPtWlA8Hr
	 SFLHqGF9jKHB583Jf+9tXjrwl38r1MF1H/+MuTXp3gEnUPvKk0ffpwEfO0LoBx7p+7
	 w+YjVix5mM8yA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TMy504p0gz4wd4;
	Sun, 28 Jan 2024 14:45:40 +1100 (AEDT)
Date: Sun, 28 Jan 2024 14:45:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Conor Dooley <Conor.Dooley@microchip.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the riscv-dt-fixes tree
Message-ID: <20240128144537.78dcaf09@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XEFbEvd_==u+4Nf/dOIVpLZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/XEFbEvd_==u+4Nf/dOIVpLZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  a75f0b6e6f74 ("riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to =
fit aclint format")

This is commit

  1f4a994be2c3 ("riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to =
fit aclint format")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/XEFbEvd_==u+4Nf/dOIVpLZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW1zeEACgkQAVBC80lX
0GySzAf6Al+em9H/h1YZYBNoSJRLTOd+L9oKqEliHMeDe+mjhj9w07D5SYRwydAi
SQaVlzyvWxX78M6uysYPkKsu3OFO2gP/BYq6N+fiBZc35Dtr6E//p3zY1Og2Y/TX
rPGN6mhBAx5UkzLM5ueXSfyHN8YTr1oq6+rxYFREN306mcFxLVerRZhLdgh1jlA7
QUmq9y6OJXzhux278tjqKXtmSpDBd3HpLLNQzSoOvXtT6ji/w24AmcUSYO4qG+kC
g17gh+ppRjWGovSc41Hlg60VUDtEEP38oqz0ho1iAYig4Tad0zxIcDOT2al04UmY
wykZHashBwTlVAzCdWDn+hXJp+bMJg==
=xM/8
-----END PGP SIGNATURE-----

--Sig_/XEFbEvd_==u+4Nf/dOIVpLZ--

