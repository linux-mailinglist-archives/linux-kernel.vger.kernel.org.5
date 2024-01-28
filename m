Return-Path: <linux-kernel+bounces-41545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE3A83F440
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDA61C21FA1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA088BF7;
	Sun, 28 Jan 2024 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="VBklWV0x"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC847484;
	Sun, 28 Jan 2024 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706421214; cv=none; b=Xe7kw+9UZ0HXrAxVuZBCg3pLMgZTJ5SWPcbnNnvrkyLoGGGEOnohWaTwlxbRouvMJMRJ/tiUhktqErjM+pSmFROg96N614sq1L705XCYD4bbuXXhEtORZL9h+pWyHPcCy6KGy2AlI3Y7kbcqzkxMlCD++WvEjg6rN5K6T8Ct5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706421214; c=relaxed/simple;
	bh=ghuqAVEd3oaGLjuiR4Jx/XjOr/RW3i3vBZYuvTFT7es=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I04VcDOMBDvX46xqlZW7m7EbxPYE9ft/jCS3vURSPMiiVi5IlJ9/McITSKmM0IQMDr4NI4fJGV01K+nxBA7ZJlhDtpxDJt2CFohI2SAK/9XLEqA94ux6hXchpID3/HqdUI1BDOE8PxKoqgUILQXEuugC6bA3wI13AkE1MfOaKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=VBklWV0x; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1706421200;
	bh=ghuqAVEd3oaGLjuiR4Jx/XjOr/RW3i3vBZYuvTFT7es=;
	h=Date:From:To:Subject:From;
	b=VBklWV0xwrqGtzcJLES3UwV2RGw33yXXWVHI1ERfoXktt2wetU4jYxclGKP01phrl
	 Gdu/+LHtKRjt2eMedRLfBxnli9xnp6mJEATl5eDKuKOnwopBMKSvg5ah4u3wmW9984
	 ESWBmRgP7MuihI3I2AqdoLCT9GKFslFOiDzjEHyg8OF6WxR4DIdcqtW/UJ6zc6Qz+x
	 82euWzauXfT9yAxBFFcAE9jAhP4hxrY5ct9NfwYrhLQtjgbpf35hF4gG2227zs+0xx
	 HgMIhz+rrHsm5AT4RcmWgVXrz3tDk1JzGqpz2IqtrnQ/Yel4JiTFE99f98oyLTjwfA
	 NR65vJetf3PLg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1AEE866A;
	Sun, 28 Jan 2024 06:53:20 +0100 (CET)
Date: Sun, 28 Jan 2024 06:53:19 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Kconfig: cap[c]ability
Message-ID: <lq6gstev3sd7i4iw2btiq3gg7lhsraj5w74fkbp6lpbl6nkyff@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l6vk4hkabiji5e3b"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--l6vk4hkabiji5e3b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ddae0fde798e..bc7021da2fe9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -694,7 +694,7 @@ config SPI_MTK_SNFI
 	  This enables support for SPI-NAND mode on the MediaTek NAND
 	  Flash Interface found on MediaTek ARM SoCs. This controller
 	  is implemented as a SPI-MEM controller with pipelined ECC
-	  capcability.
+	  capability.
=20
 config SPI_WPCM_FIU
 	tristate "Nuvoton WPCM450 Flash Interface Unit"
--=20
2.39.2

--l6vk4hkabiji5e3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmW1688ACgkQvP0LAY0m
WPG2KA/+IFI65pbCFK2PV4oxgUvRFkItAh8bfASw7zDuPl8WYGr2cETwLGbB7chg
m5nKmNtj8QyOdgnBpO39IQL72O9RiqqwvHwoSC6KXTb1SRPPk68VzULYS4uI/09a
UEhVyPRA8fxKQaISRsBkQd6MRK8KS9risdh1DZpXiqVene0iFWvofN/mQv9ZZ4Jl
uLFxZmjvLAqrfluLQ0AMOeODr/FrfCVoqufqIS/KPSVfsjQlBmLJgj56dU/FaGG7
vANpbbldDBz6PbdhT0pNRPg2QttD2l4LQCpdGVzD5l2DaaLZadONFSoLj+wV34WM
wQcgWBG6pDUI9NGxxWF5SWaovTbdeauu9DvsFg+qJe2PlbqBAYDfMP54yc5BnSQi
/2kLNd0kzUMUpWu2cMPOIGXUwjJVHeG5Z30FQ+8PGfFIa0D5qcml9rElYm9hV3iK
+iUe3FRheJBShAkK+0h4vouIeuNJFLk9OMa8y+g8X9mTh2j464e7DnQU6OWfFt6o
jglJB1tOPKSoN5wU1bE0y9H/TRRdOyi8042KYYQ03WGSjms4HC4wB6BMmBcD3gfP
ksqtIn8e+Dx3TPogtd8LcjQiDsGbkhN6Vuv9K4zv9W6/OvJrznbdCfta6frLm+BN
dRPrVETHZvEsHMHZMAW2idWP3jRD8wApkJuj52aHR7/+hW6Rvy8=
=teq6
-----END PGP SIGNATURE-----

--l6vk4hkabiji5e3b--

