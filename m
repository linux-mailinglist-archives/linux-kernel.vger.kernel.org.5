Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41AC75A8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGTIJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGTIIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:08:54 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4300135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:08:52 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230720080849euoutp0232f74a3101e8858306e012bf6a136201~zhQI1rqt72326523265euoutp02k
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:08:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230720080849euoutp0232f74a3101e8858306e012bf6a136201~zhQI1rqt72326523265euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689840529;
        bh=6mlO5pEmP1kCfZ0JJ7a+HVnKdTbVIKx3eVZbQs5lYdU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cRsRNRZ1ERl6D+4YE3zpHMB3QbxhSGc6YLBsFVEHrd27l9/05dP3ABZqfE4ar2twy
         p0SSyv9/KBm3XLtE2hZataDVlKKoozJIDQpG1tHno59nZcojOVNZXpyx48bWj/+K9y
         XKw1nvcrYXVmRNIWAKaqLBVMhroA0mvlE7lN/xuc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230720080849eucas1p28c7aeb7a045c64869778ce4934b313f2~zhQIiC_tZ0039900399eucas1p2p;
        Thu, 20 Jul 2023 08:08:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.C0.42423.19BE8B46; Thu, 20
        Jul 2023 09:08:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230720080848eucas1p2c18ac25b06cb0b89d61db4ab2df1d8dd~zhQIBxyOc2873128731eucas1p2J;
        Thu, 20 Jul 2023 08:08:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230720080848eusmtrp11115655375843bd0fc4a3e1db6969ef1~zhQIBCAyn0727607276eusmtrp1g;
        Thu, 20 Jul 2023 08:08:48 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-24-64b8eb91d9c6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 42.5C.10549.09BE8B46; Thu, 20
        Jul 2023 09:08:48 +0100 (BST)
Received: from AMDC4653.eu.corp.samsungelectronics.net (unknown
        [106.120.51.32]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230720080848eusmtip101f3d5195e37e6f9e08dfdc184245ffc~zhQHZ_tvf2792127921eusmtip1Y;
        Thu, 20 Jul 2023 08:08:48 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Dan Johansen <strit@manjaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3] arm64: defconfig: Enable drivers for the Odroid-M1 board
Date:   Thu, 20 Jul 2023 10:08:38 +0200
Message-Id: <20230720080838.933890-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7oTX+9IMfhwVcDi76Rj7BY3p61h
        sXi/rIfR4v+j16wWmx5fY7W4vGsOm8WnB/+ZLdZtvMVusfbIXXaLnqfrmC1a7pg6cHusmbeG
        0eP3r0mMHn1L5zF57Jx1l91j06pONo/NS+o9Gg4DJfu2rGL02H5tHrPH501yAVxRXDYpqTmZ
        ZalF+nYJXBlfD0xgK9ghUbHl3xymBsZtol2MnBwSAiYSq07NYuli5OIQEljBKLH6+j12COcL
        o8TEdZOYIJzPjBKPNy1jhmm5evQcVNVyRonzh3+xQTitTBKLn0xiA6liEzCU6HrbBWaLCORI
        NMy9ywpSxCywnkniVd9soFEcHMICPhKve8EOYRFQlWjYMZUFxOYVsJO48vIiG8Q2eYn9B88y
        Q8QFJU7OfAJWwwwUb94KMoYLqOYJh8TJlrlQ57lINF57xQphC0u8Or6FHcKWkTg9uYcFoqGd
        UWLB7/tMEM4ERomG57cYIaqsJe6cA/mHA2iFpsT6XfoQYUeJu5v3MIKEJQT4JG68FYQ4gk9i
        0rbpzBBhXomONiGIajWJWcfXwa09eOESVImHxOdn5SBhIYFYidsHZ7BPYFSYheSzWUg+m4Vw
        wgJG5lWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBKez0v+OfdjDOffVR7xAjEwfjIUYJ
        DmYlEd5Hl7elCPGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCU
        amBiXjF9ZZzARnuj7weNd1ycc+CZPtsjKy7r/Rv2X2M6WG3yn/nd4g22LZ17z/GvD+HgeOOh
        m7BEa93x+7s+XL7isp/juNSkd4fmfPgibGr+NnTZPb7HT87UWd982ndbulfhumnfZQ+m80ye
        iQvc5h/kDfuV/DDu2Me9px6tWG14QDHBrdMkwpo9sOLAeg4hWa7QTkfB6HnrF4ko8cw/0Vl6
        +kkDZ4FeZM9Ro+1Vq2uO6Z1+toz92MdH/oet/JMnF+6fFbR++hyRI6bWMpx7z7efL+n8l7/k
        /aPsNu/+LjdGT9ljbZ5FAvuPfe1RbPlevCV4XarQTNv/VmUiZi/nhMud+X6q4fEZvvJbH+Vu
        Gs1RVmIpzkg01GIuKk4EAIEPR6PQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7oTXu9IMXhwU9/i76Rj7BY3p61h
        sXi/rIfR4v+j16wWmx5fY7W4vGsOm8WnB/+ZLdZtvMVusfbIXXaLnqfrmC1a7pg6cHusmbeG
        0eP3r0mMHn1L5zF57Jx1l91j06pONo/NS+o9Gg4DJfu2rGL02H5tHrPH501yAVxRejZF+aUl
        qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlfD0xgK9ghUbHl
        3xymBsZtol2MnBwSAiYSV4+eY+9i5OIQEljKKHFg0gt2iISMxMlpDawQtrDEn2tdbBBFzUwS
        r95uZAZJsAkYSnS9BUlwcogI5En8OPqWFaSIWWArk8SU5iuMXYwcHMICPhKve8G2sQioSjTs
        mMoCYvMK2ElceXmRDWKBvMT+g2eZIeKCEidnPgGrYQaKN2+dzTyBkW8WktQsJKkFjEyrGEVS
        S4tz03OLDfWKE3OLS/PS9ZLzczcxAmNn27Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHeR5e3pQjx
        piRWVqUW5ccXleakFh9iNAW6byKzlGhyPjB680riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNIT
        S1KzU1MLUotg+pg4OKUamMS9jvuvmVZwdcE8k716tx/M3aZ3zSzvb6DrzPndqx+a+jx0+bLf
        7FGMpnDghd4ktQObNwkduCW5acMitk89My+d21CssXDz/Cdt8zheLL18doFna8qx7b7LeRJM
        XvUzfY5T2zm3baJb154l0rt3ztq91GfzG41XIguKpqokZO9ZfCGEZYpW1b3GxFqeW5L9qku+
        VN+vXhtjtW0+l+/Tw9YWJRpaC5I2VV34rF9cxrhogXaDxqST35QXCXx9eCDjMaPBjpkmpjFd
        bRzbXjNK179a7C97/vFc22l+alxh8kF1hRWqb/ST5Zz6F7yQr+d44fA0R8Ui6oJZxNXkQtOG
        Ux9Snz3X2xfImi2VkfXGTVaJpTgj0VCLuag4EQDgMn2kJgMAAA==
X-CMS-MailID: 20230720080848eucas1p2c18ac25b06cb0b89d61db4ab2df1d8dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230720080848eucas1p2c18ac25b06cb0b89d61db4ab2df1d8dd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230720080848eucas1p2c18ac25b06cb0b89d61db4ab2df1d8dd
References: <CGME20230720080848eucas1p2c18ac25b06cb0b89d61db4ab2df1d8dd@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardkernel Odroid-M1 board is supported since commit fd3583267703
("arm64: dts: rockchip: Add Hardkernel ODROID-M1 board"). Enable all
drivers needed by that board in the defconfig to let the automated
test systems to check them on the real hardware.

The drivers were configured to be compiled as modules if that was
supported.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v3:
- rebased onto latest kernel release

v2:
https://lore.kernel.org/all/20221209101834.2030-1-m.szyprowski@samsung.com/
---
 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6cbf6eb59378..1b219e5dc314 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -229,6 +229,7 @@ CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
+CONFIG_PCIE_ROCKCHIP_DW_HOST=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
 CONFIG_PCIE_TEGRA194_HOST=m
@@ -297,6 +298,7 @@ CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_AHCI_BRCM=m
+CONFIG_AHCI_DWC=m
 CONFIG_AHCI_CEVA=y
 CONFIG_AHCI_MVEBU=y
 CONFIG_AHCI_XGENE=y
@@ -432,6 +434,7 @@ CONFIG_INPUT_PM8XXX_VIBRATOR=m
 CONFIG_INPUT_TPS65219_PWRBUTTON=m
 CONFIG_INPUT_PWM_BEEPER=m
 CONFIG_INPUT_PWM_VIBRA=m
+CONFIG_INPUT_RK805_PWRKEY=m
 CONFIG_INPUT_HISI_POWERKEY=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
@@ -533,6 +536,7 @@ CONFIG_SPI_OMAP24XX=m
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
+CONFIG_SPI_ROCKCHIP_SFC=m
 CONFIG_SPI_RPCIF=m
 CONFIG_SPI_RSPI=m
 CONFIG_SPI_RZV2M_CSI=m
@@ -548,6 +552,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_SPMI_MTK_PMIF=m
 CONFIG_PINCTRL_MAX77620=y
+CONFIG_PINCTRL_RK805=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_OWL=y
 CONFIG_PINCTRL_S700=y
@@ -631,6 +636,7 @@ CONFIG_BATTERY_MAX17042=m
 CONFIG_CHARGER_MT6360=m
 CONFIG_CHARGER_BQ25890=m
 CONFIG_CHARGER_BQ25980=m
+CONFIG_CHARGER_RK817=m
 CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_GPIO_FAN=m
@@ -741,6 +747,7 @@ CONFIG_REGULATOR_VCTRL=m
 CONFIG_RC_CORE=m
 CONFIG_RC_DECODERS=y
 CONFIG_RC_DEVICES=y
+CONFIG_IR_GPIO_CIR=m
 CONFIG_IR_MESON=m
 CONFIG_IR_SUNXI=m
 CONFIG_MEDIA_SUPPORT=m
@@ -795,6 +802,7 @@ CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_EXYNOS_MIC=y
 CONFIG_DRM_ROCKCHIP=m
+CONFIG_ROCKCHIP_VOP2=y
 CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_CDN_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
@@ -926,6 +934,7 @@ CONFIG_SND_SOC_GTM601=m
 CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
 CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
+CONFIG_SND_SOC_RK817=m
 CONFIG_SND_SOC_RT5640=m
 CONFIG_SND_SOC_RT5659=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
@@ -1399,6 +1408,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=m
 CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=m
 CONFIG_PHY_ROCKCHIP_PCIE=m
+CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PHY_SAMSUNG_UFS=y
 CONFIG_PHY_UNIPHIER_USB2=y
-- 
2.34.1

