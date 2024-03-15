Return-Path: <linux-kernel+bounces-104299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCB887CBD4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7D51C21F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9DC1B593;
	Fri, 15 Mar 2024 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC7MpCSE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362331B279
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500614; cv=none; b=lhRYlSslCZRtquNet1pBm/qLFvqyW4fPjesF74UKB//WCawWRXqDp2ej9YAxWWbgLKsiqWJYKJlGlPQVRbS5Gx06sGGB/K4qyp+dMpjTsIKle8IIMIRkWdWIDWcZL8bFj/ZSoaDLnvOwjU8CX6/fMy42doDMZrQbfdvcXhnVxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500614; c=relaxed/simple;
	bh=1COyDMmmJiNRNc3M9ZaJ7GtQaw2OBn8CeGKWpZq0O60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iJu5htits9XUIykRTeZKFOrv7AwTJKrJbFAQVsu4QmiKyNKO1StrXKHhDj77ddgDL6DO3j+z4mq11+htX/8hNPJnPJX9PSFpEAsSKr3g9qQRkh2bvZLDvbn4if1D0BHgiD00VUJtgATnYHaaxvLJkTxpXzMEJ8DGKk4MUdfmQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC7MpCSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A095C433F1;
	Fri, 15 Mar 2024 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710500613;
	bh=1COyDMmmJiNRNc3M9ZaJ7GtQaw2OBn8CeGKWpZq0O60=;
	h=Date:From:To:Cc:Subject:From;
	b=IC7MpCSEBKo+4kB1CIG7hG3GntgMkQf6IXvgzYYR9raVcjweAKHsz7nsdJKEEYxzw
	 P5bme69y+R9/Kvf13QVdbyXKbyyHlfa84f9sttVQEF7e1mDEsHAYtjtbN8Jlw1Wo7F
	 8pq7I67J9D8zxVlJOvhwMVAP1ZTa9P2tcZznz+GZMEEIcXxacI2I914IFVI9DSZ9OW
	 DN0fqIjIZbGhEJkDhIcFOXsDG8MrkY/xq0Vg7fwkzJclZh+DEc1SI98bZvBlPTlBjl
	 j/CmXgJ5mbrEfUR7xm2he8c0BlKh+0YexIbkLu4fKWXWS/RHCcE3R3ZZXR98DhSARd
	 Tzn/oHAbYzXmQ==
Date: Fri, 15 Mar 2024 16:33:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for v6.9
Message-ID: <ZfQrAdJodRKKXeBj@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qOZeTSJdGLuE8TiT"
Content-Disposition: inline


--qOZeTSJdGLuE8TiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Linus,

Please pull to receive Generic phy subsystem which consists of bunch of
driver updates, new driver, new support etc.

Please note that we have a merge conflict, I would expect you would
resolve it just fine. The resolution can also be found in linux-next.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git next

for you to fetch changes up to 00ca8a15dafa990d391abc37f2b8256ddf909b35:

  phy: constify of_phandle_args in xlate (2024-02-23 17:43:14 +0530)

----------------------------------------------------------------
Abel Vesa (3):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 Q=
MP PCIe PHYs
      phy: qcom: qmp-pcie: Add QMP v6 registers layout
      phy: qcom-qmp-pcie: Add support for X1E80100 g3x2 and g4x2 PCIE

Andy Shevchenko (2):
      phy: ti: tusb1210: Use temporary variable for struct device
      phy: ti: tusb1210: Define device IDs

Can Guo (2):
      phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for SM=
8550
      phy: qcom: qmp-pcie: Update PCIe1 PHY settings for SM8550

Cristian Ciocaltea (2):
      dt-bindings: phy: Add Rockchip HDMI/eDP Combo PHY schema
      phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver

David Wronek (2):
      dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
      phy: qcom: qmp-ufs: Add SC7180 support

Dmitry Baryshkov (17):
      dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: split from sc8280xp PHY =
schema
      dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: support USB-C data
      phy: qcom: qmp-usb: split USB-C PHY driver
      phy: qcom: qmp-usb: drop dual-lane handling
      phy: qcom: qmp-usbc: add support for the Type-C handling
      dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: add TCSR registers
      phy: qcom: qmp-usbc: handle CLAMP register in a correct way
      dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: support SDM660
      phy: qcom: qmp-usbc: enable SDM630 support
      phy: qcom: qmp-usb-legacy: drop single-lane support
      phy: qcom: qmp-usb-legacy: drop qmp_usb_legacy_iomap
      phy: qcom: qmp: move common functions to common header
      phy: qcom: qmp: split DP PHY registers to separate headers
      phy: qcom: qmp: move common bits definitions to common header
      phy: qcom: qmp-usbc: drop has_pwrdn_delay handling
      phy: qcom: sgmii-eth: use existing register definitions
      phy: qcom: sgmii-eth: move PCS registers to separate header

Florian Sylvestre (1):
      dt-bindings: phy: add mediatek MIPI CD-PHY module v0.5

Josua Mayer (1):
      phy: armada-38x: add mux value for gbe port 0 on serdes 0

Krzysztof Kozlowski (1):
      phy: constify of_phandle_args in xlate

Manivannan Sadhasivam (2):
      dt-bindings: phy: qmp-ufs: Fix PHY clocks
      phy: qcom-qmp-ufs: Switch to devm_clk_bulk_get_all() API

Phi-bang Nguyen (1):
      phy: mtk-mipi-csi: add driver for CSI phy

Qiang Yu (1):
      phy: qcom: qmp-pcie: Update PCIe0 PHY settings for SM8550

Swapnil Jakhade (5):
      dt-bindings: phy: cadence-torrent: Add optional input reference clock=
 for PLL1
      phy: cadence-torrent: Add PCIe(100MHz) + USXGMII(156.25MHz) multilink=
 configuration
      phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz) m=
ultilink configuration
      dt-bindings: phy: cadence-torrent: Add a separate compatible for TI J=
7200
      phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz) m=
ultilink config for TI J7200

Thomas Richard (1):
      phy: ti: gmii-sel: add resume support

 .../bindings/phy/mediatek,mt8365-csi-rx.yaml       |   79 ++
 .../bindings/phy/phy-cadence-torrent.yaml          |   11 +-
 .../bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml    |  184 ++++
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |    6 +
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |   48 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |   22 -
 .../bindings/phy/rockchip,rk3588-hdptx-phy.yaml    |   91 ++
 MAINTAINERS                                        |    7 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |    2 +-
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     |    2 +-
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             |    2 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c              |    2 +-
 drivers/phy/broadcom/phy-bcm63xx-usbh.c            |    2 +-
 drivers/phy/broadcom/phy-brcm-usb.c                |    2 +-
 drivers/phy/cadence/phy-cadence-torrent.c          |  720 +++++++++++-
 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c    |    2 +-
 drivers/phy/freescale/phy-fsl-lynx-28g.c           |    2 +-
 drivers/phy/hisilicon/phy-histb-combphy.c          |    2 +-
 drivers/phy/intel/phy-intel-lgm-combo.c            |    2 +-
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c        |    2 +-
 drivers/phy/marvell/phy-armada375-usb2.c           |    2 +-
 drivers/phy/marvell/phy-armada38x-comphy.c         |    9 +-
 drivers/phy/marvell/phy-berlin-sata.c              |    2 +-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c       |    2 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c       |    2 +-
 drivers/phy/mediatek/Kconfig                       |   12 +
 drivers/phy/mediatek/Makefile                      |    2 +
 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5-rx-reg.h |   62 ++
 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c        |  294 +++++
 drivers/phy/mediatek/phy-mtk-tphy.c                |    2 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c               |    2 +-
 drivers/phy/microchip/lan966x_serdes.c             |    2 +-
 drivers/phy/microchip/sparx5_serdes.c              |    2 +-
 drivers/phy/mscc/phy-ocelot-serdes.c               |    2 +-
 drivers/phy/phy-core.c                             |    8 +-
 drivers/phy/phy-xgene.c                            |    2 +-
 drivers/phy/qualcomm/Makefile                      |    2 +-
 drivers/phy/qualcomm/phy-qcom-edp.c                |    3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  111 +-
 drivers/phy/qualcomm/phy-qcom-qmp-common.h         |   59 +
 drivers/phy/qualcomm/phy-qcom-qmp-dp-com-v3.h      |   18 +
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v3.h      |   21 +
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v4.h      |   19 +
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h      |   13 +
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h      |   13 +
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h         |   62 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   |   70 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  288 +++--
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h    |    2 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h |    2 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-sgmii.h      |   20 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |    2 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h      |    1 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |    2 +
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |    8 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h |    2 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |  305 +++---
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c     |   76 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |  420 +------
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           | 1149 ++++++++++++++++=
++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  101 +-
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c          |  417 +++----
 drivers/phy/ralink/phy-mt7621-pci.c                |    2 +-
 drivers/phy/renesas/phy-rcar-gen2.c                |    2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |    2 +-
 drivers/phy/renesas/r8a779f0-ether-serdes.c        |    2 +-
 drivers/phy/rockchip/Kconfig                       |    8 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |    2 +-
 drivers/phy/rockchip/phy-rockchip-pcie.c           |    2 +-
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  | 1028 +++++++++++++++++
 drivers/phy/samsung/phy-exynos-mipi-video.c        |    2 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |    2 +-
 drivers/phy/samsung/phy-samsung-usb2.c             |    2 +-
 drivers/phy/socionext/phy-uniphier-usb2.c          |    2 +-
 drivers/phy/st/phy-miphy28lp.c                     |    2 +-
 drivers/phy/st/phy-spear1310-miphy.c               |    2 +-
 drivers/phy/st/phy-spear1340-miphy.c               |    2 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |    2 +-
 drivers/phy/tegra/xusb.c                           |    2 +-
 drivers/phy/ti/phy-am654-serdes.c                  |    2 +-
 drivers/phy/ti/phy-da8xx-usb.c                     |    2 +-
 drivers/phy/ti/phy-gmii-sel.c                      |   26 +-
 drivers/phy/ti/phy-tusb1210.c                      |   57 +-
 drivers/phy/xilinx/phy-zynqmp.c                    |    2 +-
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |    2 +-
 include/linux/phy/phy.h                            |   14 +-
 87 files changed, 4636 insertions(+), 1319 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8365-c=
si-rx.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-=
usb3-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-h=
dptx-phy.yaml
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5-rx-reg.h
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-common.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-dp-com-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-sgmii.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c


--=20
~Vinod

--qOZeTSJdGLuE8TiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmX0KwAACgkQfBQHDyUj
g0fnRg//a1pwusHJnquszpRht3mhPSxr+eDT3d4cDoLsCI4yUVyvN1b0g3ddYrgN
PdVIboUR4YA8VPFJPfyZOu/M6e5fVAdDf1LrERatut3jRcpXGDzkhA9gNMLH+dzn
oRF6wryB/bgITSzzBvnF7qJOrjA+xVcbfHyDQh5R23g0vPAsR4JbhaWvZlVpxUUP
/Y9/m5WDWP0BmkrxGAPZuRbMzZj59N+9vDKeZdauaNapnDJU0ddrQ644UESJaZjX
KSWRAeg5kW2QKq81lzBrPnq5h6D0GSVS8q/dSAibv9DorstmsSrurD43TvnuFi9/
2w8fonEQdFSANdNaoBfVwT+4hM4GqSrtA4m0ifHgec54cGL/Ibclx/u7id1mpCjp
7EN1g4GaECs046foF8ornOg+z+bF96TEYSO50vsBRXkFNkFt2KzT3xXNd4JsIqqf
dWJQRcTFgJ0N0o1ZaZkhq/VHfSyFpLaNqmAomPPSzJD7bMNNMYk7Paf1jBh4z/V3
+m3xGS1+OIQB1Hpy6ybvI/2Jeoy0uN3WXO6gBkCb0l/7aa032MT7vkt5vQj3q3Qu
eqsGsC/NWiTUkxn/iFaEIvh8kb0IBGJ2kLPqmSN+rb8y08hiZVrReTXAPG7g7nPm
fiXBpiYFCKqI5IBB/CLlSQImcyd03nTUwCyJrMiv2HSvsRFr1Tw=
=u3+h
-----END PGP SIGNATURE-----

--qOZeTSJdGLuE8TiT--

