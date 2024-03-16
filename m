Return-Path: <linux-kernel+bounces-105263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC2D87DB2D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45F8281F60
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181441BF27;
	Sat, 16 Mar 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGK3tHie"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE51BC58
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710612346; cv=none; b=pMzYi+l0juDGICJOdm3UjypVq1DLs4ICppL+Wi0XsWI8jV1blbBQit/pHtKRXmgz43Fqa3rC8mk+PPC7Qzs11ndbcZkZMI+PbGESGgDv6HYN/eA3QMWyHItqnP1tKVIHAb+CSSTu3x1XbnTNtJVyn+GDAxiomR9OYCuyNyFm83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710612346; c=relaxed/simple;
	bh=lfxoWzuW3H/P0O8kV29DkMA1WC2xIN3TTICbtOuGAVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ+MXRZAzc63Z8/1MUOnOV5aA+kYZVfk/v3bMtlVarDExzIhgSxhy7ua3UFWJpAdSON1PszRR8r1Py+QE8cmKgSYQ8oG5YKuNBaime1l5sDrwcC4CU0ZQGV0O74g+My500z20qMNc/b42lHqJ9Wo4sfRWdkhAtI9e5B41KzGqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGK3tHie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07234C433F1;
	Sat, 16 Mar 2024 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710612345;
	bh=lfxoWzuW3H/P0O8kV29DkMA1WC2xIN3TTICbtOuGAVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGK3tHie9O673vt6eyBEVHJcLTdclTQkptZeKkjFpdOlaYGt8FxYu0n9yLGz+svnm
	 a5t4hLgDrRX55XA8c4nySX0AygZTTGxn8VWjiUfj47MmjmtMuUdJVZ1fvwIaCRVueg
	 wxz/QaFFEytn9PhAnJXbxddyfqGedEFSXIy1hEu8ANqlLdqV6MnE3ps+fKWtuKZW3J
	 JdmkNInETc3FQZLhDAFo0nZuUUhkM8C10ktyjh8NQzvQca0u8NgvieFofDRbE0z3ZT
	 FnAGTuT/BhdxWE7qg6+gPXQNS9NqQNGXdSrVuDjaOZHksGK9AViXt3RvIHVQCjLsmN
	 jnBa/Wz6prGuA==
Date: Sat, 16 Mar 2024 23:35:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic phy updates for v6.9
Message-ID: <ZfXfdTFjbHEoIdXr@matsya>
References: <ZfQrAdJodRKKXeBj@matsya>
 <CAHk-=wi1DTEQpOokQRXeKoAhSgyFJbs3jDKV9r0rc0M7aHDO0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qk+C/g7cFjuLtKJ3"
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1DTEQpOokQRXeKoAhSgyFJbs3jDKV9r0rc0M7aHDO0g@mail.gmail.com>


--Qk+C/g7cFjuLtKJ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On 15-03-24, 12:22, Linus Torvalds wrote:
> On Fri, 15 Mar 2024 at 04:03, Vinod Koul <vkoul@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git next
>=20
> That is not a valid signed tag, and I can't find one in that repo.

It was pushed: tags/phy-for-6.9, I erred in generating the request for
sure

> I know you know how to do this right, so please send me a proper pull
> request with a signed tag like you usually do...

Apologies for the error, here is the updated request:

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.9

for you to fetch changes up to 00ca8a15dafa990d391abc37f2b8256ddf909b35:

  phy: constify of_phandle_args in xlate (2024-02-23 17:43:14 +0530)

----------------------------------------------------------------
phy-for-6.9

- New Support
  - Qualcomm X1E80100 PCIe phy support, SM8550 PCIe1 PHY, SC7180 UFS PHY
    and SDM630 USBC support
  - Rockchip HDMI/eDP Combo PHY driver
  - Mediatek MT8365 CSI phy driver

- Updates
  - Rework on Qualcomm phy PCS registers and type-c handling
  - Cadence torrent phy updates for multilink configuration
  - TI gmii resume support

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

--Qk+C/g7cFjuLtKJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmX133QACgkQfBQHDyUj
g0di5Q/4sUn3hlbqWRC2ZomDiM7cDRL5I9ykLjGOrquRe0FT0nXXTo9vUZnS6w2U
s/d/FDarJNYpV45YpV3S5UO4xiakl/b1kh3tBoF5VfPHluPW92X2qoAk9hSVzu7B
QrQbK2UVk+PMVbtvnCypJunu4HzwmphExVCrwpoD1AV3uqat2gAQm8TLCzcOT++Q
MclgT7gHiMJSl+AmDpRaP+DCTS7pU6t8tAYzEQCoW4EMgnqBeNLh5zZKiYxHk3g+
mau2JNODINob7BAzxvrkf6waq1Gv4dQ/Dbte9+DdNRocrZNsvILL5fk4dVA/p+XO
6qB2/qTsmnh9C6Lq5R5X8m/g3qLL8KZ8yJYUHz1NNGOY9ggBXSF/fWJRfWjFNl7Y
x2/mOL0bA+Ynxhc3rbOB31kGtsZWrGIiH5WVixcAqdhv2lWqbYB7KvW95EVleEuo
QepTv6KCZdz6pAIWJKXYdq19VThN1dZObE8OoIjEzupPa5LHvjBp/oJUa2XhInAW
fI8W0bmdo7ROaAO/iJUTPOWArATgMIPYFGHGPVwDir2ATwPgKcMlKB6InHk0zqp2
stZehegq+orLxiz+YrNWtz2S1UZ6fyaf6meNPAHJUQ2fM370wcHT+pgoRgd8GbaL
R+kvKe0NP5FB4yYmLP5Ro4CFdlSfRA6blLbNH8fIDY1OsPZtNQ==
=Mtvj
-----END PGP SIGNATURE-----

--Qk+C/g7cFjuLtKJ3--

