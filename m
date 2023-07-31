Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C091769BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjGaQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjGaQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:11:40 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF387E5D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:11:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36VGB2AA019542;
        Mon, 31 Jul 2023 11:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690819862;
        bh=roEF03BR0TLsi5is9PdSrkT/cuSNsmjx4QDz+G21o8o=;
        h=From:To:CC:Subject:Date;
        b=B5n6MNcwtB1ZYCt8SLxCYhGVWCdoBAjpfbLlhEupqlyXLEgkNWfjISMTMc69KuqMv
         JdU4ZUcQp+zs37lpd7dVqzQjMKC1B9K5cTnSPgXnslPm7AXzLuq3WGAH5M3/mtfraX
         eIH9Gk95Smht+v8zNJsT37PX7Wkg29HpWScHdza4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36VGB29A123794
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 11:11:02 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 11:11:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 11:11:01 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36VGAuHb062500;
        Mon, 31 Jul 2023 11:10:57 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <j-keerthy@ti.com>, <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v4] arm64: defconfig: Enable various configs for TI K3 platforms
Date:   Mon, 31 Jul 2023 21:40:48 +0530
Message-ID: <20230731161048.2522154-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable TI ECAP, DP83869 driver, OMAP2 Mailbox, K3 remote proc
SND_SOC_J721E_EVM, MCAN, UFS and RTI, Thermal driver to be built
as module.

These configs are supported on below TI platforms

ECAP on am642, am65 iot2050 EVM.

DP83869 on AM64x EVM.

OMAP2 Mailbox, K3 remote proc on AM64 on J7200,J721E and J784S4 SOC.

CONFIG_SND_SOC_J721E_EVM on J721E.

MCAN on AM68 SK, J721E, J721S2, AM642 AM642-Phyboards

UFS feature on J721E EVM

RTI watchdog on AM62, AM62A, AM64, AM65, J721E and J7200 SOC.

Thermal driver on AM62, AM62A AM65, J7200, J721E, J721S2,
J784S4  platform.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
bloat-o-meter reports after this change
add/remove: 4/1 grow/shrink: 2/0 up/down: 1592/-8 (1584)
[...]
Total: Before=28027075, After=28028659, chg +0.01%

Change log:

Changes in v4:
  Added CONFIG_K3_THERMAL as module
  Rebased with next-20230731 
Link to v3:
https://lore.kernel.org/all/20230726172411.2075066-1-u-kumar1@ti.com/


Changes in v3:
 Updated commit message along with including platform list
 Updated SOB
Link to v2:
https://lore.kernel.org/all/20230726133049.2074105-1-u-kumar1@ti.com/

Changes in v2:
 Squashed all patches into one
link to v1:.
https://lore.kernel.org/all/20230725105346.1981285-1-u-kumar1@ti.com/

 arch/arm64/configs/defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 03fce1752521..bf13d5c46578 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -180,6 +180,8 @@ CONFIG_NET_ACT_GATE=m
 CONFIG_QRTR_SMD=m
 CONFIG_QRTR_TUN=m
 CONFIG_CAN=m
+CONFIG_CAN_M_CAN=m
+CONFIG_CAN_M_CAN_PLATFORM=m
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
 # CONFIG_BT_LE is not set
@@ -378,6 +380,7 @@ CONFIG_AT803X_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
+CONFIG_DP83869_PHY=m
 CONFIG_DP83TD510_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_CAN_FLEXCAN=m
@@ -658,6 +661,7 @@ CONFIG_THERMAL_EMULATION=y
 CONFIG_IMX_SC_THERMAL=m
 CONFIG_IMX8MM_THERMAL=m
 CONFIG_QORIQ_THERMAL=m
+CONFIG_K3_THERMAL=m
 CONFIG_SUN8I_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
@@ -697,6 +701,7 @@ CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_PM8916_WATCHDOG=m
 CONFIG_BCM2835_WDT=y
 CONFIG_BCM7038_WDT=m
+CONFIG_K3_RTI_WATCHDOG=m
 CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_I2C=y
@@ -940,6 +945,7 @@ CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
 CONFIG_SND_SOC_RK817=m
 CONFIG_SND_SOC_RT5640=m
+CONFIG_SND_SOC_J721E_EVM=m
 CONFIG_SND_SOC_RT5659=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_SIMPLE_MUX=m
@@ -1061,10 +1067,13 @@ CONFIG_MMC_SDHCI_XENON=y
 CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MMC_OWL=y
 CONFIG_SCSI_UFSHCD=y
+CONFIG_SCSI_UFS_BSG=y
 CONFIG_SCSI_UFSHCD_PLATFORM=y
+CONFIG_SCSI_UFS_CDNS_PLATFORM=m
 CONFIG_SCSI_UFS_QCOM=m
 CONFIG_SCSI_UFS_HISI=y
 CONFIG_SCSI_UFS_RENESAS=m
+CONFIG_SCSI_UFS_TI_J721E=m
 CONFIG_SCSI_UFS_EXYNOS=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -1244,6 +1253,7 @@ CONFIG_TEGRA186_TIMER=y
 CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
 CONFIG_IMX_MBOX=y
+CONFIG_OMAP2PLUS_MBOX=m
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
@@ -1256,6 +1266,8 @@ CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
+CONFIG_TI_K3_R5_REMOTEPROC=m
+CONFIG_TI_K3_DSP_REMOTEPROC=m
 CONFIG_MTK_SCP=m
 CONFIG_QCOM_Q6V5_ADSP=m
 CONFIG_QCOM_Q6V5_MSS=m
@@ -1370,6 +1382,7 @@ CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
+CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_VISCONTI=m
 CONFIG_SL28CPLD_INTC=y
@@ -1457,6 +1470,7 @@ CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+CONFIG_MUX_GPIO=m
 CONFIG_MUX_MMIO=y
 CONFIG_SLIMBUS=m
 CONFIG_SLIM_QCOM_CTRL=m
-- 
2.34.1

