Return-Path: <linux-kernel+bounces-30395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133A0831E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9B428350A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08862C84B;
	Thu, 18 Jan 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM3sI8z0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C272C6AA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597728; cv=none; b=Vo7KkeOwVL750vhkB8HiVHE9GBiU6gkB6riKOkM/5Wd5fSy7zIk4nPRO0ReUqDHre0yTC3x3crSYAGJlKiCNuAd4OFdzs+Zs/EZwDh105kSTKXIDFt7Md/YFzEq9+KW5ZMOhZEBPUrGxHPgSJSNrWulvNw/9fGsBTH+UeB5rrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597728; c=relaxed/simple;
	bh=BqHMQ6YFIEXyylSMaRcciYAELO9Rvlk6sWFPcaGy7lY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition; b=KrqLXb9oiEKLSTad8q8swXwYE+E1COvaFZmeacJUtCewgEOlBF6CAYYPP97f0THwCC2+zUE6I8A0xIbj3Km2fL+KMWAaBnurcjVAZ9TIx9EHRptKuvV/RVibBVV2ncUPats+aMHqlk/MrZRmWNyLUCgECHd2BdZ4Cz4sMKyb4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM3sI8z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D522EC433F1;
	Thu, 18 Jan 2024 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705597727;
	bh=BqHMQ6YFIEXyylSMaRcciYAELO9Rvlk6sWFPcaGy7lY=;
	h=Date:From:To:Cc:Subject:From;
	b=TM3sI8z0/fLbaBsVARuM0qfPzLel71oCvcuLvOpc1FwFWRpPlQej5E6zDU2UP54mO
	 8BSchZRU5yCGfeP6gb7WY92/yhnS02D8MYlOb8vwPD4K43WDVJ1z+fMdo4x0v8LbBo
	 ap51aUNozhn5FABjiyzxLbwDcUWesRJ+UVcKSa0Q3RZo2GhgVe8rhs7Z4gCOZR1GuC
	 3+7EV95euytlzKQM8cyrfriWgM+6H328wVPNEdD8nNuS7bMdaRqtRuAj7R/eAv+FjR
	 mkUoN0uWvOUMB6jalDgYTDkHYYlyGlJP7pXVJIawVCcau2t831FRnHWcr+Cn9YwWEP
	 lCPKMF7UFg88Q==
Date: Thu, 18 Jan 2024 22:38:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for 6.8
Message-ID: <ZalbG7hfGcZ0USyt@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZTEEkJLh/19BT52x"
Content-Disposition: inline


--ZTEEkJLh/19BT52x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive Generic phy subsystem updates for v6.8-rc1. This
primarily includes bunch of new device support for Qualcomm, mediatek and T=
I soc

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.8

for you to fetch changes up to 2029e71482fcd94dcc7df2c66c7fa635479748bf:

  phy: ti: j721e-wiz: Add SGMII support in WIZ driver for J784S4 (2023-12-2=
2 21:20:08 +0530)

----------------------------------------------------------------
phy-for-6.8

- New Support
  - Qualcomm SM8650 UFS, PCIe and USB/DP Combo PHY, eUSB2 PHY, SDX75 USB3,
    X1E80100 USB3 support
  - Mediatek MT8195 support
  - Rockchip RK3128 usb2 support
  - TI SGMII mode for J784S4

- Updates
  - Qualcomm v7 register offsets updates
  - Mediatek tphy support for force phy mode switch

----------------------------------------------------------------
Abel Vesa (12):
      phy: qcom-qmp: qserdes-com: Add some more v6 register offsets
      phy: qcom-qmp: qserdes-txrx: Add some more v6.20 register offsets
      phy: qcom-qmp: pcs: Add v7 register offsets
      phy: qcom-qmp: pcs-usb: Add v7 register offsets
      phy: qcom-qmp: qserdes-com: Add v7 register offsets
      phy: qcom-qmp: qserdes-txrx: Add V6 N4 register offsets
      phy: qcom-qmp: qserdes-txrx: Add v7 register offsets
      dt-bindings: phy: qcom: snps-eusb2: Document the X1E80100 compatible
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Document X1E80100 co=
mpatible
      phy: qcom-qmp-combo: Add x1e80100 USB/DP combo phys
      dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add X1E80100 USB PHY bi=
nding
      phy: qcom-qmp-usb: Add Qualcomm X1E80100 USB3 PHY support

Alex Bee (2):
      phy: rockchip-inno-usb2: Split ID interrupt phy registers
      phy: phy-rockchip-inno-usb2: Add RK3128 support

Can Guo (1):
      phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550 UFS HS-G4 PHY Settings

Chintan Vankar (2):
      phy: ti: gmii-sel: Enable SGMII mode for J784S4
      phy: ti: j721e-wiz: Add SGMII support in WIZ driver for J784S4

Christophe JAILLET (1):
      phy: core: Remove usage of the deprecated ida_simple_xx() API

Chunfeng Yun (2):
      dt-bindings: phy: mediatek: tphy: add a property for force-mode switch
      phy: mediatek: tphy: add support force phy mode switch

Krzysztof Kozlowski (1):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: fix path to header

Michael Walle (1):
      dt-bindings: phy: add compatible for Mediatek MT8195

Neil Armstrong (9):
      dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: document the SM8650 QMP =
UFS PHY
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document the SM8650 QMP=
 PCIe PHYs
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: document the SM8650 =
QMP USB/DP Combo PHY
      dt-bindings: phy: qcom,snps-eusb2: document the SM8650 Synopsys eUSB2=
 PHY
      phy: qcom: qmp-ufs: add QMP UFS PHY tables for SM8650
      phy: qcom: qmp-pcie: add QMP PCIe PHY tables for SM8650
      phy: qcom: qmp-combo: add QMP USB3/DP PHY tables for SM8650
      dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: drop text about=
 parent syscon and drop example
      dt-bindings: phy: amlogic,g12a-mipi-dphy-analog: drop unneeded reg pr=
operty and example

Randy Dunlap (1):
      phy: renesas: phy-rcar-gen2: use select for GENERIC_PHY

Rohit Agarwal (1):
      phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support

Wang Jinchao (1):
      phy: phy-can-transceiver: insert space after include

 .../phy/amlogic,g12a-mipi-dphy-analog.yaml         |  12 -
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml    |  17 -
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |   1 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   9 +
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   5 +
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |   2 +
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |   3 +
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   8 +-
 .../bindings/phy/qcom,snps-eusb2-phy.yaml          |   2 +
 drivers/phy/mediatek/phy-mtk-tphy.c                |  25 ++
 drivers/phy/phy-can-transceiver.c                  |  10 +-
 drivers/phy/phy-core.c                             |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 174 +++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  65 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h     |  17 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h         |  32 ++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   5 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h |  87 ++++++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   8 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h    |   1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h |   4 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h |  51 +++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    |  78 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 114 ++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 344 +++++++++++++++++=
++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   6 +
 drivers/phy/renesas/Kconfig                        |   2 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      | 156 ++++++++--
 drivers/phy/ti/phy-gmii-sel.c                      |   2 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |   1 +
 31 files changed, 1168 insertions(+), 78 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h

--=20
~Vinod

--ZTEEkJLh/19BT52x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmWpWxsACgkQfBQHDyUj
g0cwKQ/8DYJoqw2RMtjHRt6gSY1mjM1QYcg5huMAqqoN5ydO8jZNuIFNEi6TbnNG
U7Z8nX4dEfCh0LGh++6+7oeYDSuhUW5Y9OgWv47zjD0oCh4N7l0oClMkQwvElNmz
+epkNQZ6xSLTtlEU7HnF5t0aBeYj/84yx63S1ybtWtS86bE0kIX4sE++11ABJ/I8
L3lhYi2I6yyCcHiLfsiKPijy5MxajCs/DMrd4Zz5zuGK/1QIgQh2l1Vm8/djqZDs
dac8V0wV5YoCkw23uwQKpSjdoygWJjpUY/FmxcgwACqXsU3UHhPu8xvU4jeeGTik
9W3Rq5jNBJBNe1Y3gYlMgpPxvTjaEm4CG8ld34rKpdhX0BjRnMddXa/gvgCO7ktx
G1pGkYjNg5uRzcjRSCpiR/i9mO53PoxnrRDDhBQiRsyer88XRb0La+T12wmquDSj
fUJGJY+yHGEmrUV02VEE5daiGLMwqntRCjpzlqkTXV0DFzrTtLiXCbX16iH2VQRO
E8LsZg+GlulcFalLpdkoYGlRRK3Waqja3cf+iAw+yeoxJamUSHz6Vjt9MJ+WqZ9b
Qc83cKSRyEuAcVDMkgk1t5Xoqk4+a1poi2hwbgoDbc4tznyxR1Efdh3qKG9Zctkl
hwserpeQQb5h3epLSdO5rTHK4jeelN1SHiWokjucqraOGrIDnVk=
=sslt
-----END PGP SIGNATURE-----

--ZTEEkJLh/19BT52x--

