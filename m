Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8C790D43
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbjICRad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbjICRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:30:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDB7E5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23F42B80CC2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 17:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A637C433C8;
        Sun,  3 Sep 2023 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693762224;
        bh=jXHLtr6p8CWsu8nPp+KOiuNCRgQwS3QJhN6cj5kyiI4=;
        h=Date:From:To:Cc:Subject:From;
        b=m/s7bsXoGoLEGaJygiTHWk7E4kr1UNdYhw/XZhHEjHPI/yHQJ7lIKFHIMFcjxsyVg
         wMBzF7FPp5tFbrdX+HQzM4mKMFbc2PEJh1xVvJaENmnMX39eykzQeMvTk1+hCf9ehA
         WQXWS/3u1QL3F324kJx4XpvSa0lMwnooeSEE2dY7z1lllKWS+9ki1yGDrT6Rykfpfa
         ooI3HRNiSDjPVQNpaQGz/HFRUjAaDRslnkrHNQLE1DKk8xVI1W56VNWRbbcvOeOoeu
         xx9rrRI2KsQQqDSgb/k81T+6WLkht1gIOnlxndyB1auLX54YtcpaTGZDf5rm9Exi7m
         WIcC7k/fGmCQQ==
Date:   Sun, 3 Sep 2023 23:00:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for v6.6
Message-ID: <ZPTCrHYAUP/+wXJ8@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RJ2QyRK77m5vqscS"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RJ2QyRK77m5vqscS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates that as usual includes couple of new
drivers, bunch of new device support and few updates to existing drivers

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.6

for you to fetch changes up to 691525074db97d9b684dd1457fd8dc9842a36615:

  phy: exynos5-usbdrd: Add Exynos850 support (2023-08-22 19:41:15 +0530)

----------------------------------------------------------------
phy-for-6.6

- New Support
  - Starfive dphy rx, JH7110 usb and pcie support
  - Rockchip rv1126 inno-dsi phy, rk3588 usb and pcie support
  - Qualcomm sa8775p PCIe support, M31 USB PHY driver
  - Samsung Exynos850 usb support

- Updates
  - Mediatek dsi driver clock  updates
  - Qualcomm sm8150 combo phy with reworking of qmp pcie driver
  - Xilinx zynqmp runtime PM support

----------------------------------------------------------------
Alex Bee (1):
      phy/rockchip: inno-hdmi: add more supported pre-pll rates

Alexander Stein (1):
      phy: fsl-imx8mq-usb: add dev_err_probe if getting vbus failed

Andrew Davis (1):
      phy: ti: gmii-sel: Allow parent to not be syscon node

AngeloGioacchino Del Regno (3):
      phy: mediatek: mipi-dsi: Convert to register clk_hw
      phy: mediatek: mipi-dsi: Use devm variant for of_clk_add_hw_provider()
      phy: mediatek: mipi-dsi: Compress of_device_id match entries

Changhuang Liang (2):
      dt-bindings: phy: Add starfive,jh7110-dphy-rx
      phy: starfive: Add mipi dphy rx support

Dan Carpenter (1):
      phy: starfive: fix error code in probe

Dmitry Baryshkov (26):
      dt-bindings: phy: qcom,sc7180-qmp-usb3-dp-phy: add sm8150 USB+DP PHY
      phy: qcom-qmp-combo: add support for the USB+DP PHY on SM8150 platform
      dt-bindings: phy: qcom,msm8996-qmp-usb3-phy: drop legacy bindings
      phy: qcom-qmp-usb: split off the legacy USB+dp_com support
      phy: qcom: qmp-combo: correct bias0_en programming
      phy: qcom: qmp-combo: reuse register layouts for more registers
      phy: qcom: qmp-combo: reuse register layouts for even more registers
      phy: qcom: qmp-combo: reuse register layouts for some more registers
      phy: qcom: qmp-combo: drop similar functions
      phy: qcom: qmp-combo: drop qmp_v6_dp_aux_init()
      phy: qcom: qmp-combo: extract common function to setup clocks
      dt-bindings: phy: migrate QMP UFS PHY bindings to qcom,sc8280xp-qmp-u=
fs-phy.yaml
      phy: qcom-qmp-ufs: populate offsets configuration
      dt-bindings: phy: migrate combo QMP PHY bindings to qcom,sc8280xp-qmp=
-usb43dp-phy.yaml
      phy: qcom-qmp-combo: simplify clock handling
      phy: qcom-qmp-combo: populate offsets for all combo PHYs
      phy: qcom-qmp-combo: add qcom,sc7280-qmp-usb3-dp-phy compat entry
      phy: qcom: qmp-ufs: add missing offsets to sm8150 configuration
      dt-bindings: phy: migrate QMP PCIe PHY bindings to qcom,sc8280xp-qmp-=
pcie-phy.yaml
      dt-bindings: phy: qcom,qmp-pcie: describe SM8150 PCIe PHYs
      phy: qcom-qmp-pcie: drop ln_shrd from v5_20 config
      phy: qcom-qmp-pcie: keep offset tables sorted
      phy: qcom-qmp-pcie: simplify clock handling
      phy: qcom-qmp-pcie: populate offsets configuration
      phy: qcom-qmp-pcie: support SM8150 PCIe QMP PHYs
      phy: qcom-qmp-combo: fix clock probing

Eugen Hristev (1):
      dt-bindings: phy: mediatek,tphy: allow simple nodename pattern

Geert Uytterhoeven (1):
      phy: starfive: StarFive PHYs should depend on ARCH_STARFIVE

Huicong Xu (1):
      phy/rockchip: inno-hdmi: force set_rate on power_on

Jagan Teki (2):
      dt-bindings: phy: rockchip-inno-dsidphy: Document rv1126
      phy: rockchip: inno-dsidphy: Add rv1126 support

Jonas Karlman (3):
      phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
      phy/rockchip: inno-hdmi: remove unused no_c from rk3328 recalc_rate
      phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write

Krzysztof Kozlowski (5):
      phy: broadcom: sata: fix Wvoid-pointer-to-enum-cast warning
      phy: broadcom: ns-usb3: fix Wvoid-pointer-to-enum-cast warning
      phy: broadcom: sr-usb: fix Wvoid-pointer-to-enum-cast warning
      phy: marvell pxa-usb: fix Wvoid-pointer-to-enum-cast warning
      phy: amlogic: meson-g12a-usb2: fix Wvoid-pointer-to-enum-cast warning

Lukas Bulwahn (1):
      MAINTAINERS: correct file entry in STARFIVE JH7110 DPHY RX DRIVER

Marcin Wierzbicki (1):
      phy: cadence: Sierra: Add single link SGMII register configuration

Minda Chen (4):
      dt-bindings: phy: Add StarFive JH7110 USB PHY
      dt-bindings: phy: Add StarFive JH7110 PCIe PHY
      phy: starfive: Add JH7110 USB 2.0 PHY driver
      phy: starfive: Add JH7110 PCIE 2.0 PHY driver

Mrinmay Sarkar (2):
      dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY
      phy: qcom-qmp-pcie: add support for sa8775p

Piyush Mehta (2):
      phy: xilinx: add runtime PM support
      phy: xilinx: phy-zynqmp: dynamic clock support for power-save

Rob Herring (1):
      phy: Explicitly include correct DT includes

Roger Quadros (1):
      phy: cadence-torrent: Use key:value pair table for all settings

Rohit Agarwal (1):
      dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for PM7550=
BA

Sam Protsenko (4):
      dt-bindings: phy: samsung,usb3-drd-phy: Add Exynos850 support
      phy: exynos5-usbdrd: Make it possible to pass custom phy ops
      phy: exynos5-usbdrd: Add 26MHz ref clk support
      phy: exynos5-usbdrd: Add Exynos850 support

Sean Anderson (1):
      phy: zynqmp: Allow variation in refclk rate

Sebastian Reichel (8):
      dt-bindings: phy: rockchip,inno-usb2phy: add rk3588
      phy: phy-rockchip-inno-usb2: add rk3588 support
      phy: phy-rockchip-inno-usb2: add reset support
      phy: phy-rockchip-inno-usb2: add rk3588 phy tuning support
      phy: phy-rockchip-inno-usb2: simplify phy clock handling
      phy: phy-rockchip-inno-usb2: simplify getting match data
      phy: phy-rockchip-inno-usb2: improve error message
      dt-bindings: phy: rockchip: add RK3588 PCIe v3 phy

Swapnil Jakhade (1):
      phy: cadence-torrent: Add single link USXGMII configuration for 156.2=
5MHz refclk

Varadarajan Narayanan (2):
      dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
      phy: qcom: Introduce M31 USB PHY driver

Vinod Koul (1):
      phy: starfive: make phys depend on HAS_IOMEM

Yang Li (1):
      phy: Remove duplicated include in xusb.c

Yangtao Li (3):
      phy: marvell: phy-mvebu-cp110-comphy: Use devm_platform_get_and_iorem=
ap_resource()
      phy: rockchip: phy-rockchip-typec: Use devm_platform_get_and_ioremap_=
resource()
      phy: renesas: r8a779f0-ether-serdes: Convert to devm_platform_ioremap=
_resource()

Zheng Yang (1):
      phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

 .../devicetree/bindings/phy/mediatek,tphy.yaml     |    2 +-
 .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       |   59 +
 .../bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml    |  278 +---
 .../bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml     |  228 ---
 .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    |   80 -
 .../bindings/phy/qcom,msm8998-qmp-pcie-phy.yaml    |   97 ++
 .../bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml  |  282 ----
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   55 +-
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |   48 +-
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   46 +-
 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |    7 +-
 .../bindings/phy/rockchip,inno-usb2phy.yaml        |   21 +-
 .../bindings/phy/rockchip,pcie3-phy.yaml           |   33 +-
 .../bindings/phy/rockchip,px30-dsi-dphy.yaml       |    1 +
 .../bindings/phy/samsung,usb3-drd-phy.yaml         |    1 +
 .../bindings/phy/starfive,jh7110-dphy-rx.yaml      |   71 +
 .../bindings/phy/starfive,jh7110-pcie-phy.yaml     |   58 +
 .../bindings/phy/starfive,jh7110-usb-phy.yaml      |   50 +
 MAINTAINERS                                        |   15 +
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |    2 -
 drivers/phy/allwinner/phy-sun50i-usb3.c            |    1 +
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c      |    2 +-
 .../phy/amlogic/phy-meson-axg-mipi-pcie-analog.c   |    1 +
 drivers/phy/amlogic/phy-meson-axg-pcie.c           |    1 +
 .../phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c  |    1 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c          |    4 +-
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     |    2 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           |    2 +-
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c           |    2 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c             |    2 +-
 drivers/phy/broadcom/phy-bcm-ns-usb3.c             |    2 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c              |    2 +-
 drivers/phy/broadcom/phy-bcm63xx-usbh.c            |    1 +
 drivers/phy/broadcom/phy-brcm-sata.c               |    2 +-
 drivers/phy/broadcom/phy-brcm-usb.c                |    1 -
 drivers/phy/cadence/cdns-dphy-rx.c                 |    1 +
 drivers/phy/cadence/cdns-dphy.c                    |    3 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |   98 ++
 drivers/phy/cadence/phy-cadence-torrent.c          | 1734 +++++++---------=
----
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |    2 +-
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         |    4 +-
 drivers/phy/freescale/phy-fsl-lynx-28g.c           |    1 +
 drivers/phy/hisilicon/phy-hi3660-usb3.c            |    1 +
 drivers/phy/hisilicon/phy-hi3670-usb3.c            |    1 +
 drivers/phy/hisilicon/phy-hi6220-usb.c             |    1 +
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |    3 +-
 drivers/phy/hisilicon/phy-histb-combphy.c          |    3 +-
 drivers/phy/hisilicon/phy-hix5hd2-sata.c           |    1 +
 drivers/phy/ingenic/phy-ingenic-usb.c              |    1 +
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           |    1 -
 drivers/phy/marvell/phy-armada38x-comphy.c         |    1 +
 drivers/phy/marvell/phy-berlin-sata.c              |    1 +
 drivers/phy/marvell/phy-mmp3-hsic.c                |    1 +
 drivers/phy/marvell/phy-mmp3-usb.c                 |    1 +
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c       |    1 +
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c         |    2 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c       |    4 +-
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c         |    2 +-
 drivers/phy/marvell/phy-mvebu-sata.c               |    1 +
 drivers/phy/marvell/phy-pxa-28nm-usb2.c            |    1 -
 drivers/phy/marvell/phy-pxa-usb.c                  |    2 +-
 drivers/phy/mediatek/phy-mtk-hdmi.h                |    1 -
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |   30 +-
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h            |    2 -
 drivers/phy/mediatek/phy-mtk-pcie.c                |    2 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                |    2 +-
 drivers/phy/mediatek/phy-mtk-ufs.c                 |    1 +
 drivers/phy/phy-can-transceiver.c                  |    1 +
 drivers/phy/phy-xgene.c                            |    1 +
 drivers/phy/qualcomm/Kconfig                       |   21 +
 drivers/phy/qualcomm/Makefile                      |    2 +
 drivers/phy/qualcomm/phy-ath79-usb.c               |    1 +
 drivers/phy/qualcomm/phy-qcom-edp.c                |    2 -
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     |    1 -
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c        |    3 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        |    2 +-
 drivers/phy/qualcomm/phy-qcom-m31.c                |  294 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  682 ++++----
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   |    1 -
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  483 +++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |    1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h |    2 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h    |    5 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |   13 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c     | 1407 ++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |  557 -------
 drivers/phy/qualcomm/phy-qcom-qmp.h                |    2 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |    1 -
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c         |    1 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |    1 -
 drivers/phy/qualcomm/phy-qcom-usb-hs.c             |    2 +-
 drivers/phy/ralink/phy-mt7621-pci.c                |    3 +-
 drivers/phy/renesas/phy-rcar-gen2.c                |    1 -
 drivers/phy/renesas/phy-rcar-gen3-pcie.c           |    1 -
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |    2 -
 drivers/phy/renesas/r8a779f0-ether-serdes.c        |   10 +-
 drivers/phy/rockchip/phy-rockchip-dphy-rx0.c       |    1 -
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c   |    5 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |  235 ++-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |  357 +++-
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |    3 +-
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     |    3 +-
 drivers/phy/rockchip/phy-rockchip-typec.c          |    3 +-
 drivers/phy/samsung/phy-exynos-dp-video.c          |    2 -
 drivers/phy/samsung/phy-exynos-mipi-video.c        |    3 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |  184 ++-
 drivers/phy/samsung/phy-samsung-usb2.c             |    2 -
 drivers/phy/socionext/phy-uniphier-pcie.c          |    2 +-
 drivers/phy/st/phy-spear1310-miphy.c               |    3 +-
 drivers/phy/st/phy-spear1340-miphy.c               |    3 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |    3 +-
 drivers/phy/starfive/Kconfig                       |   38 +
 drivers/phy/starfive/Makefile                      |    4 +
 drivers/phy/starfive/phy-jh7110-dphy-rx.c          |  232 +++
 drivers/phy/starfive/phy-jh7110-pcie.c             |  204 +++
 drivers/phy/starfive/phy-jh7110-usb.c              |  152 ++
 drivers/phy/sunplus/phy-sunplus-usb2.c             |    2 +-
 drivers/phy/tegra/phy-tegra194-p2u.c               |    2 +-
 drivers/phy/tegra/xusb.c                           |    2 +-
 drivers/phy/ti/phy-gmii-sel.c                      |    9 +-
 drivers/phy/ti/phy-tusb1210.c                      |    1 +
 drivers/phy/ti/phy-twl4030-usb.c                   |    1 +
 drivers/phy/xilinx/phy-zynqmp.c                    |   95 +-
 125 files changed, 5243 insertions(+), 3183 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-=
hsphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-=
ufs-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-=
pcie-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-u=
sb3-dp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-d=
phy-rx.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-p=
cie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-u=
sb-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-rx.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c


--=20
~Vinod

--RJ2QyRK77m5vqscS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmT0wqwACgkQfBQHDyUj
g0eukQ//XSXXivKXfNk7h0KcmNpENnEWhfe3isumUNt3W3JCE6bOVNEwbMR+/efu
O+xVVYSnI2CJ+zTDoHvxEGFbF/q64BgsgloDrQWu/TagmPOHL/pQhLEEL7dz0Fz7
beUqyWMviWHdF0Xzldivj0wx/S4nBWt1s+waxXjn4bNwbpc5hKJCvkHtRqzgnvhf
QYlypM68qVf9ZyJvBbdIjNNlx7r5GQ895Z49kfnscodivAW7n07qjjpC12nx2fcQ
0srEst8NHzS8XyWpuS7Z5gTNsUsgtpDhOJUjeRzM/3StMJkgAynDUbsXByNKVNtm
3XTm5qTGbK7/qzWyOgJTD9XW0P0not39/qcZbYGQEuMwPRXT1gHqtC5o4pSGpAdG
hUrYLfCRApBaI03zUqa1YU7gAuK3mHds9wtdrdqljAI2HAOA3HgKhll1m+DSrWu9
sdkE+p4vt56gmM5vxdkPoFHCpRRhg4xSrL43EIMQJi08Tcns3CC0OW+7SLGZ8Qkb
goJsHICffBbHkNEZtjIt8on+ozBbrmdAz6kqNAST2tp0pnlmW1DsDnixpH52RqMk
5xeocXW5HJ8pS9doGibrI71Yb1JiHfgPc8eGRNYE9H9ZtxVZENz4c/MTHLMSOX82
1nxF+hOaAvxx1R6TqNgoll/U8ywZuV70upRXd3IYIk7ylhuvtsM=
=yJ8v
-----END PGP SIGNATURE-----

--RJ2QyRK77m5vqscS--
