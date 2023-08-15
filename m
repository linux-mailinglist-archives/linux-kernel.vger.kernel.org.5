Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA59177CFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbjHOQLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbjHOQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:11:37 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F7127
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:11:34 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id BB6A6100006;
        Tue, 15 Aug 2023 19:11:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BB6A6100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692115891;
        bh=Zh58zgKGmujKY7UolkYnE5HNgDvOOGFPvKhbvkD39RU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=McYrbTyZJZGj5ArzerRzpoWxzCbotm44xmgDlv2xy7HK/0ZilsimsdsBZ8MxCLbt+
         tgBWG4f3PuYO+TM1Nrb0xSlbs9XJVlaMeleBUaqmAd5fgS5tPDrphCROdBFwz52ypV
         9tsd40DSAuLH7DVTQtCeKL65j3FeHrlGtJVriBXrM9rTPxF5b1ciR4zklBCG5m+iwm
         DySW5d+ONSHrciSbwNw+XqulgIsQtGMAuQae1j+M/Uu8fR618JXD81jk+XxHfNCPtU
         P55/orl9jR/YKEQC8tYoMf4jHIp0Rba+FnL0SewtmKvMnWwJ6PiaNLJ/A1HD/z8xIo
         4KaMjWNogFEjg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 15 Aug 2023 19:11:31 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 15 Aug 2023 19:11:21 +0300
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v1] mtd: spinand: micron: correct parameters
Date:   Tue, 15 Aug 2023 19:10:24 +0300
Message-ID: <20230815161024.810729-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179259 [Aug 15 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: MMKurbanov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/15 09:54:00 #21621202
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes following fixes:
  1. Correct bitmask for ecc status. Valid bitmask is 0x70 in the
      status register.
  2. Fix oob layout:
        - The first 4 bytes are reserved for bad block data.
        - Use only non-protected ECC bytes for free data:
          OOB ECC protected Area is not used due to partial
          programming from some filesystems (like JFFS2 with
          cleanmarkers).

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 drivers/mtd/nand/spi/micron.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 50b7295bc922..897e70913ed0 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -12,7 +12,7 @@
 
 #define SPINAND_MFR_MICRON		0x2c
 
-#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
+#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
@@ -57,6 +57,20 @@ static SPINAND_OP_VARIANTS(x1_write_cache_variants,
 static SPINAND_OP_VARIANTS(x1_update_cache_variants,
 			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
+/*
+ * OOB spare area map (128 and 256 bytes)
+ *
+ *           +-----+-----------------+-------------------+---------------------+
+ *           | BBM |     Non ECC     |   ECC protected   |      ECC Area       |
+ *           |     | protected Area  |       Area        |                     |
+ * ----------+-----+-----------------+-------------------+---------------------+
+ *  oobsize  | 0:3 | 4:31 (28 bytes) | 32:63 (32 bytes)  | 64:127 (64 bytes)   |
+ * 128 bytes |     |                 |                   |                     |
+ * ----------+-----+-----------------+-------------------+---------------------+
+ *  oobsize  | 0:3 | 4:63 (60 bytes) | 64:127 (64 bytes) | 127:255 (128 bytes) |
+ * 256 bytes |     |                 |                   |                     |
+ * ----------+-----+-----------------+-------------------+---------------------+
+ */
 static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -75,9 +89,15 @@ static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
 	if (section)
 		return -ERANGE;
 
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = (mtd->oobsize / 2) - 2;
+	/* Reserve 4 bytes for the BBM. */
+	region->offset = 4;
+
+	/* The OOB Free (User) area is divided into two equal parts:
+	 *   the first part is not protected by ECC;
+	 *   the second part is protected by ECC.
+	 * Use only non-protected ECC bytes.
+	 */
+	region->length = (mtd->oobsize / 2) / 2 - 4;
 
 	return 0;
 }
-- 
2.40.0

