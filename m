Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1084A7A8D10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjITTrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjITTrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:47:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC5B9;
        Wed, 20 Sep 2023 12:47:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-502153ae36cso382930e87.3;
        Wed, 20 Sep 2023 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239233; x=1695844033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsdrfYeqptfMWbElOCcxrDUsL4RROO8o0AF8EPJzHss=;
        b=c/gRjfOw9dmTnxtzo7sBfACCqEXDPfz98CVaBXUfyrxX4u+W+QnBKBs0V1XtMj57RY
         c47vQ/5foZQZSFJiVzGUUyFMGFGQA4+pHHn4R1O5qkOwd5JtLvE7E2hca7JpsRpJg88U
         VPcK+bu5QjN5F0T97OHCP8T41jam/4cIGkusnD/fCw/sO/YHjpos6/FpcgydiVzmVPbg
         Fhe6O4IkRUy5b2u2OMJ4PSj3kr6ZIOrErYV3HvTnykKNvMrl/NADrFsK3ivZIjW+58pH
         ad7BWLwJwp72O2PX0hhaZTLMkE6srNdJ8O9Hp91XW40WcIGKoZXzZvp7PnNf2uowhCIL
         rXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239233; x=1695844033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsdrfYeqptfMWbElOCcxrDUsL4RROO8o0AF8EPJzHss=;
        b=iQrWqaz+Vzt1BS4foztSAHkW8235wFkKTlnT8PCzk27H0qXRWyI86f5YyZcwy5fcb3
         Ri0vlAgwck0VAkI6OH3CeulqrmIwQ8bFNsXQNqJ0wL5zOTlNbbBQvwZ6x2F0IYQFQ96r
         nYEPh+oV+96dN1sTcTR+1+ZlZaEwrVs13bXIhf04CSCEtCu1qJLGadNO0FdpZqwpYw+5
         nIvLgYq+EuImFYW+3dJ79c6HWwMSjD8u8GgUrV2OEXG66GTLfOEDsjfM56nX00whvo7H
         6B6Oc321e8sVyhqke813zmhfxfTBHQC3Y68XfpBE6yH+DKylzrcFIg406L0ImnBCmUwo
         gqBg==
X-Gm-Message-State: AOJu0YwO3aP12wNyQPNmi5x/JlOKyOPp6ADsbDsc4lLzwOthSQC3HPFv
        aKRtBW1s3NYq+ONcxCMnVms=
X-Google-Smtp-Source: AGHT+IF2EECUChEDs96AZIqyG2t+5+DnqORvDjSbDx+3X391xaVVAM70vp3LMepGVoihIJSTPWJe+g==
X-Received: by 2002:a2e:96c4:0:b0:2bd:1804:29fa with SMTP id d4-20020a2e96c4000000b002bd180429famr3383605ljj.39.1695239233454;
        Wed, 20 Sep 2023 12:47:13 -0700 (PDT)
Received: from localhost ([178.176.81.142])
        by smtp.gmail.com with ESMTPSA id v5-20020a2e7a05000000b002bcda31af28sm3240999ljc.42.2023.09.20.12.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:47:12 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/18] EDAC/synopsys: Add erroneous page-frame/offset reporting
Date:   Wed, 20 Sep 2023 22:46:53 +0300
Message-ID: <20230920194656.30879-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A full System/SDRAM address translation interface is now available. Use it
to determine the system address causing the ECC faults: add the System->
Application->HIF->SDRAM address translation procedures based on the DW
uMCTL2 DDRC DQ-bus config and HIF/SDRAM mapping table retrieved on the
device probe stage; for the sake of simplification convert the
snps_ecc_error_info structure to containing the snps_sdram_addr structure
instance, since the erroneous SDRAM address will now participate in the
address translation chain; issue the SDRAM->System address translation
before passing the later to the edac_mc_handle_error() method.

Note the ECC address rank needs to be retrieved now too in order to
determine a correct system address. But the rank won't be passed to the
MCI core for now since the MCI device is registered with a single ranked
layer 0.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 143 +++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 25 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6b8949c66eef..5384e93ec58c 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/pfn.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
@@ -346,20 +347,14 @@ struct snps_sdram_addr {
 
 /**
  * struct snps_ecc_error_info - ECC error log information.
- * @row:	Row number.
- * @col:	Column number.
- * @bank:	Bank number.
- * @bankgrp:	Bank group number.
+ * @sdram:	SDRAM address.
  * @syndrome:	Error syndrome.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  * @ecc:	Data ECC.
  */
 struct snps_ecc_error_info {
-	u32 row;
-	u32 col;
-	u32 bank;
-	u32 bankgrp;
+	struct snps_sdram_addr sdram;
 	u32 syndrome;
 	u32 bitpos;
 	u64 data;
@@ -420,6 +415,21 @@ static void snps_map_app_to_hif(struct snps_edac_priv *priv,
 	*hif = app >> priv->info.dq_width;
 }
 
+/**
+ * snps_map_hif_to_app - Map HIF address to Application address.
+ * @priv:	DDR memory controller private instance data.
+ * @hif:	HIF address (source).
+ * @app:	Application address (destination).
+ *
+ * Backward HIF-to-App translation is just the opposite DQ-width-based
+ * shift operation.
+ */
+static void snps_map_hif_to_app(struct snps_edac_priv *priv,
+				u64 hif, u64 *app)
+{
+	*app = hif << priv->info.dq_width;
+}
+
 /**
  * snps_map_hif_to_sdram - Map HIF address to SDRAM address.
  * @priv:	DDR memory controller private instance data.
@@ -471,6 +481,58 @@ static void snps_map_hif_to_sdram(struct snps_edac_priv *priv,
 	}
 }
 
+/**
+ * snps_map_sdram_to_hif - Map SDRAM address to HIF address.
+ * @priv:	DDR memory controller private instance data.
+ * @sdram:	SDRAM address (source).
+ * @hif:	HIF address (destination).
+ *
+ * SDRAM-HIF address mapping is similar to the HIF-SDRAM mapping procedure, but
+ * we'll traverse each SDRAM rank/bank/column/row bit.
+ *
+ * Note the unmapped bits of the SDRAM address components will be just
+ * ignored. So make sure the source address is valid.
+ */
+static void snps_map_sdram_to_hif(struct snps_edac_priv *priv,
+				  struct snps_sdram_addr *sdram, u64 *hif)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	unsigned long addr;
+	int i;
+
+	*hif = 0;
+
+	addr = sdram->row;
+	for_each_set_bit(i, &addr, DDR_MAX_ROW_WIDTH) {
+		if (map->row[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->row[i]);
+	}
+
+	addr = sdram->col;
+	for_each_set_bit(i, &addr, DDR_MAX_COL_WIDTH) {
+		if (map->col[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->col[i]);
+	}
+
+	addr = sdram->bank;
+	for_each_set_bit(i, &addr, DDR_MAX_BANK_WIDTH) {
+		if (map->bank[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->bank[i]);
+	}
+
+	addr = sdram->bankgrp;
+	for_each_set_bit(i, &addr, DDR_MAX_BANKGRP_WIDTH) {
+		if (map->bankgrp[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->bankgrp[i]);
+	}
+
+	addr = sdram->rank;
+	for_each_set_bit(i, &addr, DDR_MAX_RANK_WIDTH) {
+		if (map->rank[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->rank[i]);
+	}
+}
+
 /**
  * snps_map_sys_to_sdram - Map System address to SDRAM address.
  * @priv:	DDR memory controller private instance data.
@@ -492,6 +554,27 @@ static void snps_map_sys_to_sdram(struct snps_edac_priv *priv,
 	snps_map_hif_to_sdram(priv, hif, sdram);
 }
 
+/**
+ * snps_map_sdram_to_sys - Map SDRAM address to SDRAM address.
+ * @priv:	DDR memory controller private instance data.
+ * @sys:	System address (source).
+ * @sdram:	SDRAM address (destination).
+ *
+ * Perform a full mapping of the SDRAM address (row/column/bank/etc) to
+ * the system address specific to the controller system bus ports.
+ */
+static void snps_map_sdram_to_sys(struct snps_edac_priv *priv,
+				  struct snps_sdram_addr *sdram, dma_addr_t *sys)
+{
+	u64 app, hif;
+
+	snps_map_sdram_to_hif(priv, sdram, &hif);
+
+	snps_map_hif_to_app(priv, hif, &app);
+
+	*sys = app;
+}
+
 /**
  * snps_get_bitpos - Get DQ-bus corrected bit position.
  * @syndrome:	Error syndrome.
@@ -544,12 +627,13 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	p->ceinfo.bitpos = snps_get_bitpos(p->ceinfo.syndrome, priv->info.dq_width);
 
 	regval = readl(base + ECC_CEADDR0_OFST);
-	p->ceinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+	p->ceinfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
+	p->ceinfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
 	regval = readl(base + ECC_CEADDR1_OFST);
-	p->ceinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
-	p->ceinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
-	p->ceinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+	p->ceinfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ceinfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ceinfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
 	if (priv->info.dq_width == SNPS_DQ_64)
@@ -562,12 +646,13 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 		goto out;
 
 	regval = readl(base + ECC_UEADDR0_OFST);
-	p->ueinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+	p->ueinfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
+	p->ueinfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
 	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
-	p->ueinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
-	p->ueinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+	p->ueinfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ueinfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ueinfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 	if (priv->info.dq_width == SNPS_DQ_64)
@@ -599,31 +684,39 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 {
 	struct snps_edac_priv *priv = mci->pvt_info;
 	struct snps_ecc_error_info *pinf;
+	dma_addr_t sys;
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
 
+		snps_map_sdram_to_sys(priv, &pinf->sdram, &sys);
+
 		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08llx:0x%02x",
-			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+			 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Bit %d Data 0x%08llx:0x%02x",
+			 pinf->sdram.row, pinf->sdram.col, pinf->sdram.bank,
+			 pinf->sdram.bankgrp, pinf->sdram.rank,
 			 pinf->bitpos, pinf->data, pinf->ecc);
 
-		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
-				     p->ce_cnt, 0, 0, pinf->syndrome, 0, 0, -1,
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, p->ce_cnt,
+				     PHYS_PFN(sys), offset_in_page(sys),
+				     pinf->syndrome, 0, 0, -1,
 				     priv->message, "");
 	}
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
 
+		snps_map_sdram_to_sys(priv, &pinf->sdram, &sys);
+
 		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %d Col %d Bank %d Bank Group %d Data 0x%08llx:0x%02x",
-			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+			 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Data 0x%08llx:0x%02x",
+			 pinf->sdram.row, pinf->sdram.col, pinf->sdram.bank,
+			 pinf->sdram.bankgrp, pinf->sdram.rank,
 			 pinf->data, pinf->ecc);
 
-		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
-				     priv->message, "");
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, p->ue_cnt,
+				     PHYS_PFN(sys), offset_in_page(sys),
+				     0, 0, 0, -1, priv->message, "");
 	}
 
 	memset(p, 0, sizeof(*p));
-- 
2.41.0

