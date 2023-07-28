Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C11766AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjG1Kbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjG1Kbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:31:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5A5FD7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540188; x=1722076188;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2bSiBv2FojN9c484FZ3qABscvuszGS0eBuzoqr7FiLA=;
  b=ytDujWoyMkm68YZxxJ5fcdwcS2bDpR0HI5YuP1AjVG8GAeh/W6FbHnWS
   XUXds7j2Pe33TayaPSEumHB9NHYjTQPDNERPclZnz2JtrTt7NG5RT6NeH
   PVrFGIIvMB/wteFzCGA+n0T+3dZmLieFBw/BWbJjaLeg8JdL2CNTIvxGt
   iZjIcNU953yb4tLtwcUcWWs+AH36rovKgFQA9w9w1z2sIPTx5isxcQ1RL
   hMa9SRZbohibqV+qCNjSAyVah//IXZo+XsJY6rJu4Ja5pt/PFTUmQ1U/T
   7m5F1cogNiyvRgyYzOP97Sup1xNkgUKG6uIYtf6lHu4tu/Gf+XAH/a0B5
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="163712793"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:29:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:29:18 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:29:15 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <mihai.sain@microchip.com>,
        <varshini.rajendran@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 36/50] ARM: at91: add support in SoC driver for new sam9x7
Date:   Fri, 28 Jul 2023 15:59:05 +0530
Message-ID: <20230728102905.267131-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SAM9X7 SoC in the SoC driver.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 23 +++++++++++++++++++++++
 drivers/soc/atmel/soc.h |  9 +++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index cc9a3e107479..cae3452cbc60 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -101,6 +101,29 @@ static const struct at91_soc socs[] __initconst = {
 		 AT91_CIDR_VERSION_MASK, SAM9X60_D6K_EXID_MATCH,
 		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
 #endif
+#ifdef CONFIG_SOC_SAM9X7
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X72_EXID_MATCH,
+		 "sam9x72", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X70_EXID_MATCH,
+		 "sam9x70", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1G_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 1Gb DDR3L SiP ", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 512Mb DDR2 SiP", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 128Mb DDR2 SiP", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 2Gb DDR3L SiP", "sam9x7"),
+#endif
 #ifdef CONFIG_SOC_SAMA5
 	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK, SAMA5D21CU_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 7a9f47ce85fb..26dd26b4f179 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -45,6 +45,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
 #define SAM9X60_CIDR_MATCH		0x019b35a0
 #define SAMA7G5_CIDR_MATCH		0x00162100
+#define SAM9X7_CIDR_MATCH		0x09750020
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
 #define AT91SAM9M10_EXID_MATCH		0x00000002
@@ -74,6 +75,14 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA7G54_D2G_EXID_MATCH		0x00000020
 #define SAMA7G54_D4G_EXID_MATCH		0x00000028
 
+#define SAM9X75_EXID_MATCH		0x00000000
+#define SAM9X72_EXID_MATCH		0x00000004
+#define SAM9X70_EXID_MATCH		0x00000005
+#define SAM9X75_D1G_EXID_MATCH		0x00000001
+#define SAM9X75_D5M_EXID_MATCH		0x00000002
+#define SAM9X75_D1M_EXID_MATCH		0x00000003
+#define SAM9X75_D2G_EXID_MATCH		0x00000006
+
 #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
 #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
 #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
-- 
2.25.1

