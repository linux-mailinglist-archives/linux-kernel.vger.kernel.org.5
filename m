Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27C97E02F7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376549AbjKCMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376499AbjKCMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:33:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26BDD52
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:33:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED25EC433C8;
        Fri,  3 Nov 2023 12:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699014826;
        bh=S5RbmgAEk3d6S9g1EGbSOLWoibu68Kj+Cw8AUrk1LhM=;
        h=Date:From:To:Cc:Subject:From;
        b=uSbLbUcK1dZK5V2L9LI1vPbdwEZV656EQdlqjJgUBVur4XVvXHA7zgiXaSE8rseZh
         5w5jKTZEfnUvnkISjkun0giUe3x1AlaXyHKvPYucZqea95USvwrnCQ0pPtpkpyf7V9
         QCVBUEo6g7LIl/hDlsmeGAqi5J4BM9fQ7ruEWvuZwYmOYbVRR2rW1g89YWzNM1qIA2
         oyLnroAE9m1RsaU3d+mxeCIaBn6c0fwJiWsldqSpbzwnwTxBiz34xJnAPdjV3cAJJz
         7BXVvUJHofgHI/cXrsr0Ogenv8kAb228xfVV+6zzP2sRdmbauWc4x0X67PKiQPQKVX
         mg/MgHGh/+Mcg==
Date:   Fri, 3 Nov 2023 18:03:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for v6.7
Message-ID: <ZUTopnFSSzruomdk@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7eqj/arVVoPM/J8k"
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7eqj/arVVoPM/J8k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive generic phy updates for v6.7. This has couple of
Qualcomm & Mediatek device support, with Qualcomm, ST, Renesas driver
updates and device tree calls device_get_match_data() usage and
dropping of_match_device().

The following changes since commit 089667aaaa6aa33715d22b21a72216b43af3e896:

  phy: realtek: Realtek PHYs should depend on ARCH_REALTEK (2023-09-29 21:4=
7:37 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.7

for you to fetch changes up to d688c8264b8ed25edbdafac46ea2b41b2e77416a:

  phy: Remove duplicated include in phy-ralink-usb.c (2023-10-23 11:55:36 +=
0530)

----------------------------------------------------------------
phy-for-6.6

- New Support
  - Qualcomm sa8775p qmp-pcie support, IPQ5018 support,
    SC7280 qmp-ufs support
 - Mediatek MT8188 support

- Updates
  - Device tree device_get_match_data() usage and dropping
    of_match_device() calls
  - Qualcomm qmp usb and combo phy updates for v6 register layout
  - Qualcomm eusb2-repeater updates for tuning overrides, regmap fields
  - STih407 usb binding and ralink usb-phy yaml conversion
  - renesas r8a779f0 serdes init sequencing updates

----------------------------------------------------------------
Christophe JAILLET (1):
      phy: sun4i-usb: update array size

Dmitry Baryshkov (9):
      dt-bindings: phy: migrate QMP USB PHY bindings to qcom,sc8280xp-qmp-u=
sb3-uni-phy.yaml
      phy: qcom-qmp-usb: simplify clock handling
      phy: qcom-qmp-usb: rework reset handling
      phy: qcom-qmp-usb: make QPHY_PCS_MISC_CLAMP_ENABLE access conditional
      phy: qcom-qmp: move PCS MISC V4 registers to separate header
      phy: qcom-qmp-usb: populate offsets configuration
      phy: qcom-qmp-combo: fix the prefix for the PCS_USB v6 registers
      phy: qcom-qmp-usb: move PCS v6 register to the proper header
      phy: qcom-qmp-combo: use v6 registers in v6 regs layout

Duje Mihanovi=C4=87 (1):
      dt-bindings: phy: Convert PXA1928 USB/HSIC PHY to DT schema

Konrad Dybcio (4):
      dt-bindings: phy: qcom,snps-eusb2-repeater: Add magic tuning overrides
      phy: qualcomm: phy-qcom-eusb2-repeater: Use regmap_fields
      phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs
      phy: qualcomm: phy-qcom-eusb2-repeater: Add tuning overrides

Mrinmay Sarkar (1):
      phy: qcom-qmp-pcie: add endpoint support for sa8775p

Nitheesh Sekar (2):
      dt-bindings: phy: qcom,m31: Add IPQ5018 compatible
      phy: qcom-m31: Add compatible, phy init sequence for IPQ5018

Nitin Rawat (2):
      dt-bindings: phy: Add QMP UFS PHY comptible for SC7280
      phy: qcom-qmp-ufs: Add Phy Configuration support for SC7280

Raphael Gallais-Pou (1):
      dt-bindings: phy: st: convert phy-stih407-usb to DT schema

Rob Herring (4):
      phy: realtek: Replace of_device.h with explicit includes
      phy: Use device_get_match_data()
      phy: rockchip-inno-usb2: Drop unnecessary DT includes
      phy: Drop unnecessary of_match_device() calls

Sakari Ailus (1):
      phy: Kconfig: Select GENERIC_PHY for GENERIC_PHY_MIPI_DPHY

Sergio Paracuellos (1):
      dt-bindings: phy: ralink-usb-phy: convert to dtschema

Shuijing Li (1):
      dt-bindings: phy: Add compatible for Mediatek MT8188

Varadarajan Narayanan (1):
      phy: qcom: m31: Fix indentation issues

Vinod Koul (1):
      Merge branch 'fixes' into next

Yang Li (1):
      phy: Remove duplicated include in phy-ralink-usb.c

Yoshihiro Shimoda (2):
      phy: renesas: r8a779f0-ether-serdes: Reset in .init()
      phy: renesas: r8a779f0-ether-serdes: Add .exit() ops

 .../bindings/phy/marvell,pxa1928-usb-phy.yaml      |  47 ++++
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |   1 +
 .../bindings/phy/mediatek,mt7628-usbphy.yaml       |  74 ++++++
 .../devicetree/bindings/phy/phy-stih407-usb.txt    |  24 --
 .../devicetree/bindings/phy/pxa1928-usb-phy.txt    |  18 --
 .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       |   4 +-
 .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    | 287 -----------------=
----
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |   2 +
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |  55 +++-
 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |  21 ++
 .../devicetree/bindings/phy/ralink-usb-phy.txt     |  23 --
 .../bindings/phy/st,stih407-usb2-phy.yaml          |  63 +++++
 drivers/phy/Kconfig                                |   2 +-
 drivers/phy/allwinner/phy-sun4i-usb.c              |   2 +-
 drivers/phy/broadcom/phy-bcm-ns-usb3.c             |   9 +-
 drivers/phy/marvell/phy-berlin-usb.c               |   7 +-
 drivers/phy/motorola/phy-cpcap-usb.c               |   7 -
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     | 146 ++++++++---
 drivers/phy/qualcomm/phy-qcom-m31.c                |  59 ++++-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  50 ++--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  37 +++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v4.h    |  17 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h     |  29 +--
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h      |   2 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h         |  20 +-
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 142 ++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 225 ++++++++--------
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   8 -
 drivers/phy/ralink/phy-ralink-usb.c                |   9 +-
 drivers/phy/realtek/phy-rtk-usb2.c                 |   2 +-
 drivers/phy/realtek/phy-rtk-usb3.c                 |   2 +-
 drivers/phy/renesas/r8a779f0-ether-serdes.c        |  16 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |   2 -
 drivers/phy/rockchip/phy-rockchip-pcie.c           |  11 +-
 drivers/phy/rockchip/phy-rockchip-usb.c            |  10 +-
 drivers/phy/ti/phy-dm816x-usb.c                    |  11 +-
 drivers/phy/ti/phy-omap-control.c                  |   9 +-
 drivers/phy/ti/phy-omap-usb2.c                     |  11 +-
 drivers/phy/ti/phy-ti-pipe3.c                      |  14 +-
 39 files changed, 828 insertions(+), 650 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,pxa1928-u=
sb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7628-u=
sbphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih407-usb.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/phy/pxa1928-usb-phy.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-=
usb3-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/ralink-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/st,stih407-usb2-p=
hy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v4.h

--=20
~Vinod

--7eqj/arVVoPM/J8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmVE6KUACgkQfBQHDyUj
g0edrBAAs+VOSjGYv5vM5c6x1RLcrRdeu7pxo8tJyRwoyJzoOsrbLcwMUUh/KA9u
MBZYcrfM2BoZl5iI0/6PjjFQ6RMOtXIOBUqVOUYuak/LVeVM6RRfdSjN4dEYxuWC
0/WhGQhTw1Kr9LcLSi78zBoVodOzRda/f7NDGrbUOG0tprayBjNtNcwoGmFIt8Qo
Y9ia2VK88sFKbYorfPTuvMsqoUa9E6ei3R7r2YTn4O1kKOOvr4qfR5BVroX1CtlV
r1jQtauo5FDRHkmmQDT1EhWvbXNpC7k1WjNuiZJTktwcwm4pnBYyKAhCcVflnNz8
wLSx9AF1znjD/8+A6Jh2CMs4g454UwPlgKcy7ImOZBx/G6V7uTQ98E5SGaSdOyuD
IagGD+DlAyOttDu0cRMvcay3Bd/+oyzPLLJLSmbEkaSZOeUHt8Vi/GhEmuv7v6bV
ocT0JmD9fRlPx15Fz5C4/3TCMnq3R1VxN4cI9/EwYYigWVjY/fzJVDp1cs5pEXCC
4sIzG1SKGmF0+lWVOiRvZjhV8CztSSp5Xx3Y2s/jQTa6Nex0ABGOldx7hn2OjcuJ
I6JGmza64HYTznk8tDbYD7YKHzvNZDfQN3N3eQN9O9npOYzB5AzvZv150r730J1e
U/0yhbHSUV8chCtCtE9KqvUT43SSgN1MfSuMxqxdhK91KCAYmvY=
=nX7r
-----END PGP SIGNATURE-----

--7eqj/arVVoPM/J8k--
