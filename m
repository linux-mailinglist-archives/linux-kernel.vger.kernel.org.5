Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE87BA1C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjJEO6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjJEO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:56:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F3959CC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696516727; x=1728052727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=clMieQ+QMkHSdT9d4F7nn/gWoA9a/sW5aS2YjuB+3ag=;
  b=N+DXoRsD02jqR7ORRM5wOGf9bEH6Q5E57+m20JL/Aqq4vxw7YuW0Kovi
   2PLTEC9Rjt2D42VgvPfut2To0zWE8w02s3Bj3/oVKcmIeJSy3IdnLuaAs
   rzABzA5kls2g/RMGmK7F/Mj1xg7uyhnFdtza9YssEDoe2PezJVoiZPFal
   hZpuOljneqeObcM4rS3EO95lKxtQX/zzLmOSgFjLdLFvkCYPB9JGislJO
   ANVXv493RvRCeIdlzF+CivPcWRf1zKWDr2DTispUQzHDLIEWT4+01GO3u
   /d2CD2B+MX9EqAgGV4tGKeyDMyQUT09sOaxcMECbwDDaJSUKqufk/yezR
   A==;
X-CSE-ConnectionGUID: 7jg8y5vPSH6BMU1bmf/p7Q==
X-CSE-MsgGUID: dOzT9A5WTMy7RrIEpfanPQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="8182814"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 02:30:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 5 Oct 2023 02:30:27 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 5 Oct 2023 02:30:20 -0700
From:   Manikandan Muralidharan <manikandan.m@microchip.com>
To:     <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee@kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>,
        Manikandan Muralidharan <manikandan.m@microchip.com>,
        Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH v7 3/7] drm: atmel-hlcdc: Define SAM9X7 SoC XLCDC specific registers
Date:   Thu, 5 Oct 2023 14:59:50 +0530
Message-ID: <20231005092954.881059-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005092954.881059-1-manikandan.m@microchip.com>
References: <20231005092954.881059-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Durai Manickam KR <durai.manickamkr@microchip.com>

The register address of the XLCDC IP used in SAM9X7 SoC family
are different from the previous HLCDC. Defining those address
space with valid macros.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
[manikandan.m@microchip.com: Remove unused macro definitions]
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 42 ++++++++++++++++++++
 include/linux/mfd/atmel-hlcdc.h              | 10 +++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index d5e01ff8c7f9..e6b4b0bb11b9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -15,6 +15,7 @@
 
 #include <drm/drm_plane.h>
 
+/* LCD controller common registers */
 #define ATMEL_HLCDC_LAYER_CHER			0x0
 #define ATMEL_HLCDC_LAYER_CHDR			0x4
 #define ATMEL_HLCDC_LAYER_CHSR			0x8
@@ -128,6 +129,47 @@
 
 #define ATMEL_HLCDC_MAX_LAYERS			6
 
+/* XLCDC controller specific registers */
+#define ATMEL_XLCDC_LAYER_ENR			0x10
+#define ATMEL_XLCDC_LAYER_EN			BIT(0)
+
+#define ATMEL_XLCDC_LAYER_IER			0x0
+#define ATMEL_XLCDC_LAYER_IDR			0x4
+#define ATMEL_XLCDC_LAYER_ISR			0xc
+#define ATMEL_XLCDC_LAYER_OVR_IRQ(p)		BIT(2 + (8 * (p)))
+
+#define ATMEL_XLCDC_LAYER_PLANE_ADDR(p)		(((p) * 0x4) + 0x18)
+
+#define ATMEL_XLCDC_LAYER_DMA_CFG		0
+
+#define ATMEL_XLCDC_LAYER_DMA			BIT(0)
+#define ATMEL_XLCDC_LAYER_REP			BIT(1)
+#define ATMEL_XLCDC_LAYER_DISCEN		BIT(4)
+
+#define ATMEL_XLCDC_LAYER_SFACTC_A0_MULT_AS	(4 << 6)
+#define ATMEL_XLCDC_LAYER_SFACTA_ONE		BIT(9)
+#define ATMEL_XLCDC_LAYER_DFACTC_M_A0_MULT_AS	(6 << 11)
+#define ATMEL_XLCDC_LAYER_DFACTA_ONE		BIT(14)
+
+#define ATMEL_XLCDC_LAYER_A0_SHIFT		16
+#define ATMEL_XLCDC_LAYER_A0(x)			\
+	((x) << ATMEL_XLCDC_LAYER_A0_SHIFT)
+
+#define ATMEL_XLCDC_LAYER_VSCALER_LUMA_ENABLE		BIT(0)
+#define ATMEL_XLCDC_LAYER_VSCALER_CHROMA_ENABLE		BIT(1)
+#define ATMEL_XLCDC_LAYER_HSCALER_LUMA_ENABLE		BIT(4)
+#define ATMEL_XLCDC_LAYER_HSCALER_CHROMA_ENABLE		BIT(5)
+
+#define ATMEL_XLCDC_LAYER_VXSYCFG_ONE		BIT(0)
+#define ATMEL_XLCDC_LAYER_VXSYTAP2_ENABLE	BIT(4)
+#define ATMEL_XLCDC_LAYER_VXSCCFG_ONE		BIT(16)
+#define ATMEL_XLCDC_LAYER_VXSCTAP2_ENABLE	BIT(20)
+
+#define ATMEL_XLCDC_LAYER_HXSYCFG_ONE		BIT(0)
+#define ATMEL_XLCDC_LAYER_HXSYTAP2_ENABLE	BIT(4)
+#define ATMEL_XLCDC_LAYER_HXSCCFG_ONE		BIT(16)
+#define ATMEL_XLCDC_LAYER_HXSCTAP2_ENABLE	BIT(20)
+
 /**
  * Atmel HLCDC Layer registers layout structure
  *
diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
index a186119a49b5..80d675a03b39 100644
--- a/include/linux/mfd/atmel-hlcdc.h
+++ b/include/linux/mfd/atmel-hlcdc.h
@@ -22,6 +22,8 @@
 #define ATMEL_HLCDC_DITHER		BIT(6)
 #define ATMEL_HLCDC_DISPDLY		BIT(7)
 #define ATMEL_HLCDC_MODE_MASK		GENMASK(9, 8)
+#define ATMEL_XLCDC_MODE_MASK		GENMASK(10, 8)
+#define ATMEL_XLCDC_DPI			BIT(11)
 #define ATMEL_HLCDC_PP			BIT(10)
 #define ATMEL_HLCDC_VSPSU		BIT(12)
 #define ATMEL_HLCDC_VSPHO		BIT(13)
@@ -34,6 +36,12 @@
 #define ATMEL_HLCDC_IDR			0x30
 #define ATMEL_HLCDC_IMR			0x34
 #define ATMEL_HLCDC_ISR			0x38
+#define ATMEL_XLCDC_ATTRE		0x3c
+
+#define ATMEL_XLCDC_BASE_UPDATE		BIT(0)
+#define ATMEL_XLCDC_OVR1_UPDATE		BIT(1)
+#define ATMEL_XLCDC_OVR3_UPDATE		BIT(2)
+#define ATMEL_XLCDC_HEO_UPDATE		BIT(3)
 
 #define ATMEL_HLCDC_CLKPOL		BIT(0)
 #define ATMEL_HLCDC_CLKSEL		BIT(2)
@@ -48,6 +56,8 @@
 #define ATMEL_HLCDC_DISP		BIT(2)
 #define ATMEL_HLCDC_PWM			BIT(3)
 #define ATMEL_HLCDC_SIP			BIT(4)
+#define ATMEL_XLCDC_SD			BIT(5)
+#define ATMEL_XLCDC_CM			BIT(6)
 
 #define ATMEL_HLCDC_SOF			BIT(0)
 #define ATMEL_HLCDC_SYNCDIS		BIT(1)
-- 
2.25.1

