Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3947637A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGZNbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjGZNbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:31:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBC51FFC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:31:43 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36QDV5BY056134;
        Wed, 26 Jul 2023 08:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690378265;
        bh=AY8+Pc5IPWp1NT+ewcv2zfm+dJMg7mR3fCONf7v+77w=;
        h=From:To:CC:Subject:Date;
        b=Es88A3bucs2sSnfsuNzXX/lzLjPU55XQVk3U5QGiVULqymf/06ddl4OOdZabJ8ft6
         yKU30Tv6gY0RH4gnujermpb235gwSnQGx3s0QZ5GJboNKqaYNokbCyijsyN27OUnsW
         EzYimMkX1pln4NXpp7vWiERnNucrl+u/HCf4QgvM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36QDV50a001908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 08:31:05 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 08:31:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 08:31:04 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36QDUxkQ081530;
        Wed, 26 Jul 2023 08:31:00 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Udit Kumar <u-kumar1@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Judith Mendez <jm@ti.com>
Subject: [PATCH v2] arm64: defconfig: Enable various configs for TI platforms
Date:   Wed, 26 Jul 2023 19:00:49 +0530
Message-ID: <20230726133049.2074105-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable TI ECAP, DP83869 driver, TI OMAP2, K3 remote proc
SND_SOC_J721E_EVM, MCAN, UFS and RTI driver to be built
as module.
These are needed on different TI platforms.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
bloat-o-meter reports after this change
add/remove: 4/0 grow/shrink: 2/0 up/down: 1592/0 (1592)
[...]
Total: Before=27997071, After=27998663, chg +0.01%

Change log:
Changes in v2:
 Squashed all patches into one
link to v1:.
https://lore.kernel.org/all/20230725105346.1981285-1-u-kumar1@ti.com/

 arch/arm64/configs/defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6cbf6eb59378..dedf1bd9c29f 100644
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
@@ -375,6 +377,7 @@ CONFIG_AT803X_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
+CONFIG_DP83869_PHY=m
 CONFIG_DP83TD510_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_CAN_FLEXCAN=m
@@ -687,6 +690,7 @@ CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_PM8916_WATCHDOG=m
 CONFIG_BCM2835_WDT=y
 CONFIG_BCM7038_WDT=m
+CONFIG_K3_RTI_WATCHDOG=m
 CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_I2C=y
@@ -927,6 +931,7 @@ CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
 CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
 CONFIG_SND_SOC_RT5640=m
+CONFIG_SND_SOC_J721E_EVM=m
 CONFIG_SND_SOC_RT5659=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_SIMPLE_MUX=m
@@ -1048,10 +1053,13 @@ CONFIG_MMC_SDHCI_XENON=y
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
@@ -1230,6 +1238,7 @@ CONFIG_TEGRA186_TIMER=y
 CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
 CONFIG_IMX_MBOX=y
+CONFIG_OMAP2PLUS_MBOX=m
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
@@ -1242,6 +1251,8 @@ CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
+CONFIG_TI_K3_R5_REMOTEPROC=m
+CONFIG_TI_K3_DSP_REMOTEPROC=m
 CONFIG_MTK_SCP=m
 CONFIG_QCOM_Q6V5_ADSP=m
 CONFIG_QCOM_Q6V5_MSS=m
@@ -1356,6 +1367,7 @@ CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
+CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_VISCONTI=m
 CONFIG_SL28CPLD_INTC=y
@@ -1441,6 +1453,7 @@ CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+CONFIG_MUX_GPIO=m
 CONFIG_MUX_MMIO=y
 CONFIG_SLIMBUS=m
 CONFIG_SLIM_QCOM_CTRL=m
-- 
2.34.1

