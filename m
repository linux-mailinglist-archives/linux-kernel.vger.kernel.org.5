Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD480AD52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjLHTpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjLHTph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:45:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9C1732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702064743; x=1733600743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IroCbTU3D4h208aODf904Dc8f/TADn7N7vXRTCdBR+E=;
  b=Hw2etIshbbEpWK5z5rYQHbPubeSxoVGuojkE1EMOIo5TWKhTw4a73lQP
   ZeYhhyAQx1TKlcRiTwuCbaYapDJ2uior0cY9TSl4kqyEprWhDYZNJWV81
   GF5uKDCrIxHWi1LIS/jwRl86q12Ni+xN/9CsQElf9keIjgaA35od2LmeN
   Hi3NGbN27CA+rI80Gz1+pcYlnlIM03Pwc7csinVYbvwVslFTF19Z8hfM1
   AL4tQo8DwIpj7oawZMMRrJ9U0p67QZR5KDz/QfgdnQoU2nce2RPLQpwBq
   hhz1mXAOQT5mTmmNC8bjS78lbUKWHM9sVztLE5NFuhpzsdwsaIR+Ab6Lw
   g==;
X-CSE-ConnectionGUID: X4oDrwj6SZyrcZeTYIwwlg==
X-CSE-MsgGUID: PQnfMIkTSTaeOckEFDgAEA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="180178235"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2023 12:45:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 12:45:12 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 12:45:12 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v2] drivers: soc: atmel: Adjust defines to follow aphabetical order
Date:   Fri, 8 Dec 2023 12:45:32 -0700
Message-ID: <20231208194532.579893-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Move the defines so that they are in aphabetical order based on SOC.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
Changes from v1 -> v2:
- Remove defines that are not yet in v6.7.

 drivers/soc/atmel/soc.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 7a9f47ce85fb..1f2af6f74160 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -39,10 +39,10 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9261_CIDR_MATCH		0x019703a0
 #define AT91SAM9263_CIDR_MATCH		0x019607a0
 #define AT91SAM9G20_CIDR_MATCH		0x019905a0
-#define AT91SAM9RL64_CIDR_MATCH		0x019b03a0
 #define AT91SAM9G45_CIDR_MATCH		0x019b05a0
-#define AT91SAM9X5_CIDR_MATCH		0x019a05a0
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
+#define AT91SAM9RL64_CIDR_MATCH		0x019b03a0
+#define AT91SAM9X5_CIDR_MATCH		0x019a05a0
 #define SAM9X60_CIDR_MATCH		0x019b35a0
 #define SAMA7G5_CIDR_MATCH		0x00162100
 
@@ -61,23 +61,15 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9N12_EXID_MATCH		0x00000006
 #define AT91SAM9CN11_EXID_MATCH		0x00000009
 
+#define AT91SAM9XE128_CIDR_MATCH	0x329973a0
+#define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
+#define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
+
 #define SAM9X60_EXID_MATCH		0x00000000
 #define SAM9X60_D5M_EXID_MATCH		0x00000001
 #define SAM9X60_D1G_EXID_MATCH		0x00000010
 #define SAM9X60_D6K_EXID_MATCH		0x00000011
 
-#define SAMA7G51_EXID_MATCH		0x3
-#define SAMA7G52_EXID_MATCH		0x2
-#define SAMA7G53_EXID_MATCH		0x1
-#define SAMA7G54_EXID_MATCH		0x0
-#define SAMA7G54_D1G_EXID_MATCH		0x00000018
-#define SAMA7G54_D2G_EXID_MATCH		0x00000020
-#define SAMA7G54_D4G_EXID_MATCH		0x00000028
-
-#define AT91SAM9XE128_CIDR_MATCH	0x329973a0
-#define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
-#define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
-
 #define SAMA5D2_CIDR_MATCH		0x0a5c08c0
 #define SAMA5D21CU_EXID_MATCH		0x0000005a
 #define SAMA5D225C_D1M_EXID_MATCH	0x00000053
@@ -113,6 +105,14 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA5D43_EXID_MATCH		0x00000003
 #define SAMA5D44_EXID_MATCH		0x00000004
 
+#define SAMA7G51_EXID_MATCH		0x3
+#define SAMA7G52_EXID_MATCH		0x2
+#define SAMA7G53_EXID_MATCH		0x1
+#define SAMA7G54_EXID_MATCH		0x0
+#define SAMA7G54_D1G_EXID_MATCH		0x00000018
+#define SAMA7G54_D2G_EXID_MATCH		0x00000020
+#define SAMA7G54_D4G_EXID_MATCH		0x00000028
+
 #define SAME70Q21_CIDR_MATCH		0x21020e00
 #define SAME70Q21_EXID_MATCH		0x00000002
 #define SAME70Q20_CIDR_MATCH		0x21020c00
@@ -127,6 +127,11 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMS70Q19_CIDR_MATCH		0x211d0a00
 #define SAMS70Q19_EXID_MATCH		0x00000002
 
+#define SAMV70Q20_CIDR_MATCH		0x21320c00
+#define SAMV70Q20_EXID_MATCH		0x00000002
+#define SAMV70Q19_CIDR_MATCH		0x213d0a00
+#define SAMV70Q19_EXID_MATCH		0x00000002
+
 #define SAMV71Q21_CIDR_MATCH		0x21220e00
 #define SAMV71Q21_EXID_MATCH		0x00000002
 #define SAMV71Q20_CIDR_MATCH		0x21220c00
@@ -134,9 +139,4 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMV71Q19_CIDR_MATCH		0x212d0a00
 #define SAMV71Q19_EXID_MATCH		0x00000002
 
-#define SAMV70Q20_CIDR_MATCH		0x21320c00
-#define SAMV70Q20_EXID_MATCH		0x00000002
-#define SAMV70Q19_CIDR_MATCH		0x213d0a00
-#define SAMV70Q19_EXID_MATCH		0x00000002
-
 #endif /* __AT91_SOC_H */
-- 
2.39.2

