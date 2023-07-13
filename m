Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87849752AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjGMTBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjGMTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:01:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123CB2710
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:01:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DJ1GB6099715;
        Thu, 13 Jul 2023 14:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689274876;
        bh=EEqhmZjbr+AD9oHJVBD78KIQnCJTNzAP+X4I2+YdZqA=;
        h=From:To:CC:Subject:Date;
        b=UdyeaVoyVX6MlrVXpKMqJgrbttTBBhFVdt3C1yopgZ+Pxaef0Eh8A3a7YVJ9IsTKS
         FoDynRYCbfZxx45elXhKDO74tIkL9AC2Y+MI92GxsVzYgPei0BE2V0aSaYHyziVg5r
         iF9WFla31ptX3R72T3oTPRQ/LMsUEobJUumXyThk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DJ1FfB055925
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 14:01:15 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 14:01:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 14:01:15 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DJ1FDi089715;
        Thu, 13 Jul 2023 14:01:15 -0500
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable OMAP audio/display support
Date:   Thu, 13 Jul 2023 14:01:14 -0500
Message-ID: <20230713190114.28816-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to support some additional OMAP class devices using the
common multi_v7_defconfig. To start, enable some audio/display related
modules:

DRM_OMAP/OMAP5_DSS_HDMI: For base DRM display support.
DRM_TI_TFP410: Used as a display bridge for several EVM's panels.
DRM_TI_TPD12S015: HDMI encoder on several OMAP/Sitara EVMs.
SND_SOC_TLV320AIC3X_I2C: For I2C attached TLV320AIC3x codecs.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1:
 - Rebased on v6.5-rc1

 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f0800f806b5f6..b4bc40f647e76 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -714,6 +714,8 @@ CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_SUN4I=m
+CONFIG_DRM_OMAP=m
+CONFIG_OMAP5_DSS_HDMI=y
 CONFIG_DRM_MSM=m
 CONFIG_DRM_FSL_DCU=m
 CONFIG_DRM_TEGRA=y
@@ -737,6 +739,8 @@ CONFIG_DRM_SII9234=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_TOSHIBA_TC358764=m
 CONFIG_DRM_TOSHIBA_TC358768=m
+CONFIG_DRM_TI_TFP410=m
+CONFIG_DRM_TI_TPD12S015=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_STI=m
@@ -825,6 +829,7 @@ CONFIG_SND_SOC_SGTL5000=m
 CONFIG_SND_SOC_STI_SAS=m
 CONFIG_SND_SOC_TLV320AIC32X4=m
 CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
+CONFIG_SND_SOC_TLV320AIC3X_I2C=m
 CONFIG_SND_SOC_WM8960=m
 CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WM8978=m
-- 
2.39.2

