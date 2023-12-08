Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A7B80A9F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjLHRCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjLHRCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:02:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A45BA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702054958; x=1733590958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mh27JQlOb6arH7PgW+Gp1KbuEg/QqrNfpjle10/O130=;
  b=Vr1k8hWdENiTey62ZPpPIf2LdU2k0sA+0bSiAGjcHkTZPyrG1kdHfZ+M
   GcENdvJ94gFTLvE987anBDdP96/F70u9dE3Od3fXqo8N7eYr/1HmrYWVG
   z/S6SITEzG8ofFoHiRXWjwCAV2aHsu1UuQDzoIqZC9MGTlnB1RzORS52l
   za0FdFxgg6RH9lPfsi7+vJTj+nyhuEx22/4VkWcMJCxTTLWOeqQ8/sCgr
   oadT/GZQvFOdLPEJpBajIkaqiaOkrX5EyAofn9TXFsDRo0DvChO5jliUn
   bmkHq3QoWJslRPqtf6Shq4TwIvc/QsSs0tI5T/JYqhTaGnxutY8jSLH4E
   w==;
X-CSE-ConnectionGUID: z5vkwNd3ShyqqUT0gld90A==
X-CSE-MsgGUID: hghTHFs3TTqCTfo76SH1DA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="243689112"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2023 10:02:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 10:02:17 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 10:02:17 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH] drivers: soc: atmel: Adjust defines to follow alphabetical order
Date:   Fri, 8 Dec 2023 10:02:30 -0700
Message-ID: <20231208170230.551265-1-Ryan.Wanner@microchip.com>
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
 drivers/soc/atmel/soc.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 26dd26b4f179..9b2d31073b88 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -39,13 +39,13 @@ at91_soc_init(const struct at91_soc *socs);
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
-#define SAMA7G5_CIDR_MATCH		0x00162100
 #define SAM9X7_CIDR_MATCH		0x09750020
+#define SAMA7G5_CIDR_MATCH		0x00162100
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
 #define AT91SAM9M10_EXID_MATCH		0x00000002
@@ -62,19 +62,15 @@ at91_soc_init(const struct at91_soc *socs);
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
 #define SAM9X75_EXID_MATCH		0x00000000
 #define SAM9X72_EXID_MATCH		0x00000004
 #define SAM9X70_EXID_MATCH		0x00000005
@@ -83,10 +79,6 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAM9X75_D1M_EXID_MATCH		0x00000003
 #define SAM9X75_D2G_EXID_MATCH		0x00000006
 
-#define AT91SAM9XE128_CIDR_MATCH	0x329973a0
-#define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
-#define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
-
 #define SAMA5D2_CIDR_MATCH		0x0a5c08c0
 #define SAMA5D21CU_EXID_MATCH		0x0000005a
 #define SAMA5D225C_D1M_EXID_MATCH	0x00000053
@@ -122,6 +114,14 @@ at91_soc_init(const struct at91_soc *socs);
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
-- 
2.39.2

