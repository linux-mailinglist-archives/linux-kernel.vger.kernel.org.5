Return-Path: <linux-kernel+bounces-160905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27DB8B445D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DCA1C223C6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35663FE47;
	Sat, 27 Apr 2024 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKKA3Z6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA93FBAD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714195776; cv=none; b=nGbvfSXwCsVDuMZE5WpMP19OFy+s6I2j5gi6yUu6+ItCFKqSgZOL545I4MFHXFD8ywnOoBWm5VjTXNm+760qbBPtP+UgpGISwU/KrfidLlu9cdTlvmwoTso+MpUGLN9qtXxwqZtkjy/fokyAPDdtmJbUr+pWBTZYLAUFY4uPLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714195776; c=relaxed/simple;
	bh=cxFCc9m3i453HzfhFFFwpgri92SmKlhlPho+pBollPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BOpkfninIutUdgSB24rFk5+GtM8Z+WneQdmcCzUnDVzdOanOwstnxGRcHAsmos/VnY8Fuai8UUtNV6hVBah55rWIraghaOSuV0FS74fyHCA+OOJB9pIMDf5Reorn7qT1FmusG//E1v94hN3ihlVkM4ULV3TnSCu1ljm2KkWIPwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKKA3Z6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41137C113CE;
	Sat, 27 Apr 2024 05:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714195775;
	bh=cxFCc9m3i453HzfhFFFwpgri92SmKlhlPho+pBollPo=;
	h=Date:From:To:Cc:Subject:From;
	b=ZKKA3Z6Y2gZQ4v5cgrXsLe5XRpTdLMF7FEktfdz1QdspakRrkRklJWlPAR8i6qlm3
	 IAu4rvGAPDt1sX04HnN2sEALKPJrQEmM05YSjj6+RwfGmp63o0ihg1aHNTtDacmJXP
	 oJCr46bNFq6jslscpiso1zaly2ooQ1uJAR3KJU3BtZKdSOZX5UB7jmaVCUaCQrSpJf
	 EKKSrkk8n50MbWOGtMzNiwkcOHbc3pSYm+Shuyh3+4RZPc0VU2EhbXjby4fS0iRHBI
	 1lE+7oJIvZTOKBFwkbLosEQeLkCFbuAuuGWcMbf/rxp9n4JUs5T8LBCFANWYKriVw+
	 OXmtAMz1P8RRQ==
Date: Sat, 27 Apr 2024 10:59:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.9
Message-ID: <ZiyNOxDiY_Y7TucF@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FUUQuHR/oqE8OGED"
Content-Disposition: inline


--FUUQuHR/oqE8OGED
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive Generic phy subsystem fixes for v6.9. This has
bunch of odd driver fixes for the subsystem

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.9

for you to fetch changes up to bf6e4ee5c43690e4c5a8a057bbcd4ff986bed052:

  phy: ti: tusb1210: Resolve charger-det crash if charger psy is unregister=
ed (2024-04-12 16:57:19 +0530)

----------------------------------------------------------------
phy fixes for 6.9

 - static checker (array size, bounds) fix for marvel driver
 - Rockchip rk3588 pcie fixes for bifurcation and mux
 - Qualcomm qmp-compbo fix for VCO, register base and regulator name for
   m31 driver
 - charger det crash fix for ti driver

----------------------------------------------------------------
Cristian Ciocaltea (1):
      phy: phy-rockchip-samsung-hdptx: Select CONFIG_RATIONAL

Gabor Juhos (1):
      phy: qcom: m31: match requested regulator name with dt schema

Hans de Goede (1):
      phy: ti: tusb1210: Resolve charger-det crash if charger psy is unregi=
stered

Johan Hovold (1):
      phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6

Marcel Ziswiler (1):
      phy: freescale: imx8m-pcie: fix pcie link-up instability

Michal Tomek (1):
      phy: rockchip-snps-pcie3: fix bifurcation on rk3588

Mikhail Kobuk (2):
      phy: marvell: a3700-comphy: Fix out of bounds read
      phy: marvell: a3700-comphy: Fix hardcoded array size

Sebastian Reichel (2):
      phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits
      phy: rockchip: naneng-combphy: Fix mux on rk3588

Stephen Boyd (2):
      phy: qcom: qmp-combo: Fix VCO div offset on v3
      phy: qcom: qmp-combo: Fix register base for QSERDES_DP_PHY_MODE

 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |  6 ++--
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c       |  9 +++---
 drivers/phy/qualcomm/phy-qcom-m31.c                |  2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 12 ++++++--
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h      |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h      |  1 +
 drivers/phy/rockchip/Kconfig                       |  1 +
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 36 ++++++++++++++++++=
++--
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     | 31 ++++++++-----------
 drivers/phy/ti/phy-tusb1210.c                      | 23 +++++++-------
 10 files changed, 80 insertions(+), 42 deletions(-)
--=20
~Vinod

--FUUQuHR/oqE8OGED
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmYsjTsACgkQfBQHDyUj
g0eEfxAApKzkTg/S0CXH4xrTQpzwsK9l/EcHeRGqBwl4eBjYO08na68PJMFeYq6B
07exlE4Nsts0sifYwtsviFpYgsUfC5n7lDR35CD0vF7mSgK7xg4qGUYn8Bv/lr5u
jn3eWxBgczB7RpVLZ3ktONzKWTJ0Htm59ZEELU03mm4bgmPYfmpliKwWNho52Y0b
tGj945ZILfflQQeD2o9b/V/FjR+a+lseAAGM8/6gwxZzOcg1c42mAoVFentf5VaF
fOBYfTXNLyDqS3Az4JLd6zyN2vGCrwjNt9QGObOJ7QXNhugJUyOis3a1S2O++NmG
4w1108gAD7WlJfaomDiYjUrUvWYX2HGUe/b0nCNgzqQcKjpDNHLE4IdbZGv8QnL8
AVReH/qx3Q+2mPjgttSdCSFz8QYrhCASqF08mU9y6CGvuF5aoMd8HC6wR+8Pd+8M
b4aSvGGKgLsKA/LYGD0ta03ye3N3zRUTJwguCCwPv3F4UqLdvKL5VDU5qNCXNgMe
US5K4DhXPJPdnMuq9Xkn9q8StwnhnOWW+m6Duxq7ms2Qse9mdHCOXbLjL3jnh+q6
fGVjcQVz46eKqhb1FbIIyVUZHg04K5G3H42iUV2ddNDibwc+Wk8lHP1yB8qr7Uub
9PWVZEmRvI7bh4kf9fsU7PyXAYzz5gHXzXEImk/fqETJruYmpUc=
=Sf8h
-----END PGP SIGNATURE-----

--FUUQuHR/oqE8OGED--

