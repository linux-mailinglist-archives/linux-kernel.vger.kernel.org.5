Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB41C7A8C77
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjITTNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjITTMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614A8E5E;
        Wed, 20 Sep 2023 12:12:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-503065c4b25so339581e87.1;
        Wed, 20 Sep 2023 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237142; x=1695841942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gewAssQsy3DL4fnx2jYYjoNFT27/4qEDJvjdzsaw8U=;
        b=VDEHjv416neOGmxpt/NCv+PTFNZFA04u7Ea8azAgZS7IaPPI4ofJ0jBYp0z1g1LtpE
         KMjzaQPPw5FxopXNwfzjZ3cX3C9SrCOyBykI7acYtr34bUDiZxoprPpu5CA4wYpS4kU7
         GzXgwvlUzeehqoUNRz+GXUOmlxl6WTWLAk7H65L+Vz1nBgrQDvUV36QsiI1lsNEKGNMq
         5PdjCjO2qV3v+XgML7tubvzGlx8Uo9imS6uo9zQcAZjIWbO3BTBG3Z2f3QqQJgDp2eBt
         eSzdeOBmlLfxsvaXaaYGU6QTsVkPRaddI5UZNKA9j+eKXmr5xDUtkyjr7FMzCX3QfyFn
         DiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237142; x=1695841942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gewAssQsy3DL4fnx2jYYjoNFT27/4qEDJvjdzsaw8U=;
        b=I1ikIS5arIUN/CBy9K0yu4ZFY1MIDyralo0WgDsmMb9jC7TYIAhxlLeYHTuPY+7LWB
         ZNiRNsq29e8trgSZNo2qdDUxKFNEhFf97sXV2k3YG9tK1asaC/3wFgyUrpMJxpPU0qHL
         zS/nU/3oUFiwRg3w/PVtkpr5RYqMRgU4hx4n3VyaFEXVE0XKJ4EF6FQR12PlT69uN6Ez
         /dQI9rqRQu30FMrM/7SeDZ9mN7VUN3YiVumNBFgU4GvPREeLyprJXcZoEw/mJL2bkutb
         yQglLR/5/4EYRUhH3yduXUJkFAVrDye3rHyRrrxaUxzbDj9iSkiFbDige3HGibv76/HW
         CF4w==
X-Gm-Message-State: AOJu0YzIRgheKUJ14CKsH2n2La/dHU4fOiPcqTv4Vvl4N3f64xA/XcS5
        AKeTMKUzw5z+4LyO0k4RtUw=
X-Google-Smtp-Source: AGHT+IFBow7TY/rA6kICI6lM0bMeycNtU15JfCtI1e8+Skt/16OLRm+ILMx+BgukQcMUiRHZD3QaLQ==
X-Received: by 2002:a05:6512:3292:b0:503:9eb:d277 with SMTP id p18-20020a056512329200b0050309ebd277mr2529333lfe.49.1695237142256;
        Wed, 20 Sep 2023 12:12:22 -0700 (PDT)
Received: from localhost ([178.176.82.53])
        by smtp.gmail.com with ESMTPSA id w18-20020a05651203d200b004fe15a2f0f6sm2801194lfp.62.2023.09.20.12.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:12:21 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/20] EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros
Date:   Wed, 20 Sep 2023 22:10:44 +0300
Message-ID: <20230920191059.28395-21-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
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

Instead of using the very handy helpers denoted in the subject the driver
has been created with the open-coded {mask,shift} statements. It makes the
code bulky, prone to mistakes and much harder to read. Seeing there are
many places in the driver implementing the CSR fields get/set pattern use
the FIELD_GET()/FIELD_PREP() macros introduced in the kernel specifically
for that case. In addition use the BIT() and GENMASK() macros to generate
the CSR flags/masks. While at it unify the row, column, rank, bank and
bank group macros names to be having a suffix similar to the
snps_ecc_error_info structure fields name.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 137 +++++++++++++++++------------------
 1 file changed, 67 insertions(+), 70 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index bf23ed6e1779..327023e35d42 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2012 - 2014 Xilinx, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -90,33 +92,29 @@
 #define ZYNQMP_DDR_QOS_IRQ_DB_OFST	0x2020C
 
 /* DDR Master register definitions */
-#define DDR_MSTR_DEV_CFG_MASK		0xC0000000
-#define DDR_MSTR_DEV_CFG_SHIFT		30
+#define DDR_MSTR_DEV_CFG_MASK		GENMASK(31, 30)
 #define DDR_MSTR_DEV_X4			0
 #define DDR_MSTR_DEV_X8			1
 #define DDR_MSTR_DEV_X16		2
 #define DDR_MSTR_DEV_X32		3
-#define DDR_MSTR_BUSWIDTH_MASK		0x3000
-#define DDR_MSTR_BUSWIDTH_SHIFT		12
+#define DDR_MSTR_BUSWIDTH_MASK		GENMASK(13, 12)
 #define DDR_MSTR_BUSWIDTH_16		2
 #define DDR_MSTR_BUSWIDTH_32		1
 #define DDR_MSTR_BUSWIDTH_64		0
-#define DDR_MSTR_MEM_LPDDR4		0x20
-#define DDR_MSTR_MEM_DDR4		0x10
-#define DDR_MSTR_MEM_LPDDR3		0x8
-#define DDR_MSTR_MEM_DDR2		0x4
-#define DDR_MSTR_MEM_DDR3		0x1
+#define DDR_MSTR_MEM_LPDDR4		BIT(5)
+#define DDR_MSTR_MEM_DDR4		BIT(4)
+#define DDR_MSTR_MEM_LPDDR3		BIT(3)
+#define DDR_MSTR_MEM_DDR2		BIT(2)
+#define DDR_MSTR_MEM_DDR3		BIT(0)
 
 /* ECC CFG0 register definitions */
-#define ECC_CFG0_MODE_MASK		0x7
+#define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
 #define ECC_CFG0_MODE_SECDED		0x4
 
 /* ECC status register definitions */
-#define ECC_STAT_UECNT_MASK		0xF0000
-#define ECC_STAT_UECNT_SHIFT		16
-#define ECC_STAT_CECNT_MASK		0xF00
-#define ECC_STAT_CECNT_SHIFT		8
-#define ECC_STAT_BITNUM_MASK		0x7F
+#define ECC_STAT_UE_MASK		GENMASK(23, 16)
+#define ECC_STAT_CE_MASK		GENMASK(15, 8)
+#define ECC_STAT_BITNUM_MASK		GENMASK(6, 0)
 
 /* ECC control/clear register definitions */
 #define ECC_CTRL_CLR_CE_ERR		BIT(0)
@@ -127,34 +125,26 @@
 #define ECC_CTRL_EN_UE_IRQ		BIT(9)
 
 /* ECC error count register definitions */
-#define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
-#define ECC_ERRCNT_UECNT_SHIFT		16
-#define ECC_ERRCNT_CECNT_MASK		0xFFFF
-
-/* ECC Corrected Error Register Mask and Shifts*/
-#define ECC_CEADDR0_RW_MASK		0x3FFFF
-#define ECC_CEADDR0_RNK_MASK		BIT(24)
-#define ECC_CEADDR1_BNKGRP_MASK		0x3000000
-#define ECC_CEADDR1_BNKNR_MASK		0x70000
-#define ECC_CEADDR1_COL_MASK		0xFFF
-#define ECC_CEADDR1_BNKGRP_SHIFT	24
-#define ECC_CEADDR1_BNKNR_SHIFT		16
-
-/* ECC Poison register shifts */
-#define ECC_POISON0_RANK_SHIFT		24
-#define ECC_POISON0_RANK_MASK		BIT(24)
-#define ECC_POISON0_COLUMN_SHIFT	0
-#define ECC_POISON0_COLUMN_MASK		0xFFF
-#define ECC_POISON1_BG_SHIFT		28
-#define ECC_POISON1_BG_MASK		0x30000000
-#define ECC_POISON1_BANKNR_SHIFT	24
-#define ECC_POISON1_BANKNR_MASK		0x7000000
-#define ECC_POISON1_ROW_SHIFT		0
-#define ECC_POISON1_ROW_MASK		0x3FFFF
+#define ECC_ERRCNT_UECNT_MASK		GENMASK(31, 16)
+#define ECC_ERRCNT_CECNT_MASK		GENMASK(15, 0)
+
+/* ECC Corrected Error register definitions */
+#define ECC_CEADDR0_RANK_MASK		GENMASK(27, 24)
+#define ECC_CEADDR0_ROW_MASK		GENMASK(17, 0)
+#define ECC_CEADDR1_BANKGRP_MASK	GENMASK(25, 24)
+#define ECC_CEADDR1_BANK_MASK		GENMASK(23, 16)
+#define ECC_CEADDR1_COL_MASK		GENMASK(11, 0)
+
+/* ECC Poison register definitions */
+#define ECC_POISON0_RANK_MASK		GENMASK(27, 24)
+#define ECC_POISON0_COL_MASK		GENMASK(11, 0)
+#define ECC_POISON1_BANKGRP_MASK	GENMASK(29, 28)
+#define ECC_POISON1_BANK_MASK		GENMASK(26, 24)
+#define ECC_POISON1_ROW_MASK		GENMASK(17, 0)
 
 /* DDRC ECC CE & UE poison mask */
-#define ECC_CEPOISON_MASK		0x3
-#define ECC_UEPOISON_MASK		0x1
+#define ECC_CEPOISON_MASK		GENMASK(1, 0)
+#define ECC_UEPOISON_MASK		BIT(0)
 
 /* DDRC Device config shifts/masks */
 #define DDR_MAX_ROW_SHIFT		18
@@ -210,9 +200,9 @@
 #define RANK_B0_BASE			6
 
 /* ZynqMP DDR QOS Interrupt register definitions */
-#define ZYNQMP_DDR_QOS_UE_MASK		0x4
-#define ZYNQMP_DDR_QOS_CE_MASK		0x2
-#define ZYNQMP_DDR_QOS_IRQ_MASK		0x6
+#define ZYNQMP_DDR_QOS_UE_MASK		BIT(2)
+#define ZYNQMP_DDR_QOS_CE_MASK		BIT(1)
+#define ZYNQMP_DDR_QOS_IRQ_MASK		(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK)
 
 /**
  * struct snps_ecc_error_info - ECC error log information.
@@ -304,38 +294,40 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	if (!regval)
 		return 1;
 
-	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+	p->ceinfo.bitpos = FIELD_GET(ECC_STAT_BITNUM_MASK, regval);
 
 	regval = readl(base + ECC_ERRCNT_OFST);
-	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
-	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
+	p->ce_cnt = FIELD_GET(ECC_ERRCNT_CECNT_MASK, regval);
+	p->ue_cnt = FIELD_GET(ECC_ERRCNT_UECNT_MASK, regval);
 	if (!p->ce_cnt)
 		goto ue_err;
 
 	regval = readl(base + ECC_CEADDR0_OFST);
-	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	p->ceinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+
 	regval = readl(base + ECC_CEADDR1_OFST);
-	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
-					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ceinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
-					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
+	p->ceinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ceinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ceinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+
 	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
 		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
 		 readl(base + ECC_CSYND2_OFST));
+
 ue_err:
 	if (!p->ue_cnt)
 		goto out;
 
 	regval = readl(base + ECC_UEADDR0_OFST);
-	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	p->ueinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+
 	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
-					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
-					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ueinfo.col = (regval & ECC_CEADDR1_COL_MASK);
+	p->ueinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ueinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ueinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 out:
 	spin_lock_irqsave(&priv->reglock, flags);
@@ -484,7 +476,7 @@ static enum dev_type snps_get_dtype(const void __iomem *base)
 	if (!(regval & DDR_MSTR_MEM_DDR4))
 		return DEV_UNKNOWN;
 
-	regval = (regval & DDR_MSTR_DEV_CFG_MASK) >> DDR_MSTR_DEV_CFG_SHIFT;
+	regval = FIELD_GET(DDR_MSTR_DEV_CFG_MASK, regval);
 	switch (regval) {
 	case DDR_MSTR_DEV_X4:
 		return DEV_X4;
@@ -511,7 +503,8 @@ static bool snps_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
-	regval = readl(base + ECC_CFG0_OFST) & ECC_CFG0_MODE_MASK;
+	regval = readl(base + ECC_CFG0_OFST);
+	regval = FIELD_GET(ECC_CFG0_MODE_MASK, regval);
 
 	return (regval == ECC_CFG0_MODE_SECDED);
 }
@@ -698,13 +691,13 @@ static void snps_data_poison_setup(struct snps_edac_priv *priv)
 	if (priv->rank_shift[0])
 		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
 
-	regval = (rank << ECC_POISON0_RANK_SHIFT) & ECC_POISON0_RANK_MASK;
-	regval |= (col << ECC_POISON0_COLUMN_SHIFT) & ECC_POISON0_COLUMN_MASK;
+	regval = FIELD_PREP(ECC_POISON0_RANK_MASK, rank) |
+		 FIELD_PREP(ECC_POISON0_COL_MASK, col);
 	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
 
-	regval = (bankgrp << ECC_POISON1_BG_SHIFT) & ECC_POISON1_BG_MASK;
-	regval |= (bank << ECC_POISON1_BANKNR_SHIFT) & ECC_POISON1_BANKNR_MASK;
-	regval |= (row << ECC_POISON1_ROW_SHIFT) & ECC_POISON1_ROW_MASK;
+	regval = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, bankgrp) |
+		 FIELD_PREP(ECC_POISON1_BANK_MASK, bank) |
+		 FIELD_PREP(ECC_POISON1_ROW_MASK, row);
 	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
 }
 
@@ -743,10 +736,14 @@ static ssize_t inject_data_poison_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct snps_edac_priv *priv = mci->pvt_info;
+	const char *errstr;
+	u32 regval;
+
+	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
+	errstr = FIELD_GET(ECC_CEPOISON_MASK, regval) == ECC_CEPOISON_MASK ?
+		 "Correctable Error" : "UnCorrectable Error";
 
-	return sprintf(data, "Data Poisoning: %s\n\r",
-			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
-			? ("Correctable Error") : ("UnCorrectable Error"));
+	return sprintf(data, "Data Poisoning: %s\n\r", errstr);
 }
 
 static ssize_t inject_data_poison_store(struct device *dev,
@@ -853,7 +850,7 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 	int index;
 
 	memtype = readl(priv->baseaddr + DDR_MSTR_OFST);
-	width = (memtype & DDR_MSTR_BUSWIDTH_MASK) >> DDR_MSTR_BUSWIDTH_SHIFT;
+	width = FIELD_GET(DDR_MSTR_BUSWIDTH_MASK, memtype);
 
 	priv->col_shift[0] = 0;
 	priv->col_shift[1] = 1;
-- 
2.41.0

