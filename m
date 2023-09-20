Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274057A8C72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjITTNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjITTMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5092AF;
        Wed, 20 Sep 2023 12:12:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5041cc983f9so325873e87.3;
        Wed, 20 Sep 2023 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237137; x=1695841937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLTTfDVt3x/Jm561DU5yxgfHxW/FsVH03Q1MNq6prTw=;
        b=eY6xgJA3StOskG8VRjzI3P1DqohUYaBF/2JlMbaKQlcigKqRwQyWaFDLzAdtjLnOYk
         7swz7LrrDII7fBHZO6880UbPWqpa4ier9W7YUF8Y+MkLjRT9TuRkz3bdn1BPiFTBBC1B
         Cy3CC6ydzN22c9UfwgD+PJVPCNY/HXt4nOhNeKxgyhnrG2rdx0aAnPeNePVaiNkg5ygZ
         TSx3MA1zpbZ/ECUVqpHp+/vumFmPUWC1s00n8+sZKtS/vm5kpnqWnNQfNwwqnHRNjPIa
         9ouHM2Kn5AeGhBlT9UPRwHabJOlzc98sN3n46ztRdwsnMs6qeS14odw/b9bcNHNzvAut
         4moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237137; x=1695841937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLTTfDVt3x/Jm561DU5yxgfHxW/FsVH03Q1MNq6prTw=;
        b=UqvsiRxhAaBXLeHzynBV8sIsKuMAEEoguL3VjcYh2RTqwqbJvnwz9QvskLjEH50ZI7
         lwKrI19NuOCtzIYBnKsqtdPRlhDTYktS599yAbepspydZRxmy+PL1uP4mbmzBhbO1dOe
         eqA3xihXGFlcVZ5CPrU7eEP9KOcyYOM3tMa9K3qAa3hG6SDx8e+q1k5DUXBda3HttEBH
         evJyTmFbHQw/hgaMmkohqR6auL+ifkmLuOBYZRX3Jj0tHO72zE37DuED5UT1d4oE3XIv
         WFi4QJYS6BhJjBAZ0uDe8Nb7ZLFep8ZGimU9izHm2fwMHgJ2kVk+MlJve4nOwar5DmHV
         CDBg==
X-Gm-Message-State: AOJu0YyJ3JOp4E1Gd5QkanGv3AYSL+4SlN2gVwGrlXOO0780Ciu01LDA
        c0Svoju1xpXnHsr1F8CKZHs=
X-Google-Smtp-Source: AGHT+IHjK55uDoyWfIuEduz4auOKEuwWhRvzin7do9wdBjgFKQIyHZQMZqqb+j1nfU78Y8bTcYJOBw==
X-Received: by 2002:a05:6512:2103:b0:500:c89a:2a28 with SMTP id q3-20020a056512210300b00500c89a2a28mr2831583lfr.28.1695237136701;
        Wed, 20 Sep 2023 12:12:16 -0700 (PDT)
Received: from localhost ([85.140.0.168])
        by smtp.gmail.com with ESMTPSA id br41-20020a056512402900b0050300e013f3sm2074825lfb.254.2023.09.20.12.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:12:16 -0700 (PDT)
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
Subject: [PATCH v4 18/20] EDAC/synopsys: Unify CSRs macro declarations
Date:   Wed, 20 Sep 2023 22:10:42 +0300
Message-ID: <20230920191059.28395-19-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally the device CSR macros were supposed to be defined following the
next local convention: first CSR offsets are listed, then their fields and
flags are described in the same order; CSRs offset macros are supposed to
have _OFST suffix; ECC-related macros shall have ECC_ prefix, generic
DDR-related macros - DDR_ prefix. After all the years the driver has been
living in kernel the CSRs macros have turned to be partly deviated away
from the denoted convention. Fix all the related inconsistencies: move
several CSRs offset macros to be defined before the CSRs fields and flags
macros; replace OFFSET suffix with OFST; replace DDRC_ prefix with DDR_
and ECC_ with DDR_ where it's appropriate; group DDR_MSTR and ECC_CTRL
(ECC_CLR) sibling fields macros together and make sure their prefixes
match to the CSRs offset macros. In addition to that drop _MASK suffix
from the macros which aren't used as masks and add ZYNQMP_ prefix to the
ZYNQMP-specific macros to distinguish them from the generic Synopsys
memory controller macros.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- This is a new patch collected from the rest of the series to simplify
  the review process.
---
 drivers/edac/synopsys_edac.c | 134 +++++++++++++++++------------------
 1 file changed, 66 insertions(+), 68 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 655a32792883..315eebe52923 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -78,20 +78,34 @@
 #define ECC_POISON0_OFST		0xB8
 #define ECC_POISON1_OFST		0xBC
 
-#define ECC_ADDRMAP0_OFFSET		0x200
-
-/* Control register bitfield definitions */
-#define ECC_CTRL_CLR_CE_ERR		BIT(0)
-#define ECC_CTRL_CLR_UE_ERR		BIT(1)
-#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
-#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
-
-/* DDR Control Register width definitions  */
+/* DDR Address Map Registers */
+#define DDR_ADDRMAP0_OFST		0x200
+
+/* DDR Software Control Register */
+#define DDR_SWCTL			0x320
+
+/* ZynqMP DDR QOS Registers */
+#define ZYNQMP_DDR_QOS_IRQ_STAT_OFST	0x20200
+#define ZYNQMP_DDR_QOS_IRQ_EN_OFST	0x20208
+#define ZYNQMP_DDR_QOS_IRQ_DB_OFST	0x2020C
+
+/* DDR Master register definitions */
+#define DDR_MSTR_DEV_CFG_MASK		0xC0000000
+#define DDR_MSTR_DEV_CFG_SHIFT		30
+#define DDR_MSTR_DEV_X4			0
+#define DDR_MSTR_DEV_X8			1
+#define DDR_MSTR_DEV_X16		2
+#define DDR_MSTR_DEV_X32		3
 #define DDR_MSTR_BUSWIDTH_MASK		0x3000
 #define DDR_MSTR_BUSWIDTH_SHIFT		12
-#define DDRCTL_EWDTH_16			2
-#define DDRCTL_EWDTH_32			1
-#define DDRCTL_EWDTH_64			0
+#define DDR_MSTR_BUSWIDTH_16		2
+#define DDR_MSTR_BUSWIDTH_32		1
+#define DDR_MSTR_BUSWIDTH_64		0
+#define DDR_MSTR_MEM_LPDDR4		0x20
+#define DDR_MSTR_MEM_DDR4		0x10
+#define DDR_MSTR_MEM_LPDDR3		0x8
+#define DDR_MSTR_MEM_DDR2		0x4
+#define DDR_MSTR_MEM_DDR3		0x1
 
 /* ECC CFG0 register definitions */
 #define ECC_CFG0_MODE_MASK		0x7
@@ -104,23 +118,19 @@
 #define ECC_STAT_CECNT_SHIFT		8
 #define ECC_STAT_BITNUM_MASK		0x7F
 
+/* ECC control/clear register definitions */
+#define ECC_CTRL_CLR_CE_ERR		BIT(0)
+#define ECC_CTRL_CLR_UE_ERR		BIT(1)
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+#define ECC_CTRL_EN_CE_IRQ		BIT(8)
+#define ECC_CTRL_EN_UE_IRQ		BIT(9)
+
 /* ECC error count register definitions */
 #define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
 #define ECC_ERRCNT_UECNT_SHIFT		16
 #define ECC_ERRCNT_CECNT_MASK		0xFFFF
 
-/* DDR QOS Interrupt register definitions */
-#define DDR_QOS_IRQ_STAT_OFST		0x20200
-#define DDR_QOSUE_MASK			0x4
-#define	DDR_QOSCE_MASK			0x2
-#define	ECC_CE_UE_INTR_MASK		0x6
-#define DDR_QOS_IRQ_EN_OFST		0x20208
-#define DDR_QOS_IRQ_DB_OFST		0x2020C
-
-/* DDR QOS Interrupt register definitions */
-#define DDR_UE_MASK			BIT(9)
-#define DDR_CE_MASK			BIT(8)
-
 /* ECC Corrected Error Register Mask and Shifts*/
 #define ECC_CEADDR0_RW_MASK		0x3FFFF
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
@@ -142,28 +152,11 @@
 #define ECC_POISON1_ROW_SHIFT		0
 #define ECC_POISON1_ROW_MASK		0x3FFFF
 
-/* DDR Memory type defines */
-#define MEM_TYPE_DDR3			0x1
-#define MEM_TYPE_LPDDR3			0x8
-#define MEM_TYPE_DDR2			0x4
-#define MEM_TYPE_DDR4			0x10
-#define MEM_TYPE_LPDDR4			0x20
-
-/* DDRC Software control register */
-#define DDRC_SWCTL			0x320
-
 /* DDRC ECC CE & UE poison mask */
 #define ECC_CEPOISON_MASK		0x3
 #define ECC_UEPOISON_MASK		0x1
 
-/* DDRC Device config masks */
-#define DDRC_MSTR_CFG_MASK		0xC0000000
-#define DDRC_MSTR_CFG_SHIFT		30
-#define DDRC_MSTR_CFG_X4_MASK		0x0
-#define DDRC_MSTR_CFG_X8_MASK		0x1
-#define DDRC_MSTR_CFG_X16_MASK		0x2
-#define DDRC_MSTR_CFG_X32_MASK		0x3
-
+/* DDRC Device config shifts/masks */
 #define DDR_MAX_ROW_SHIFT		18
 #define DDR_MAX_COL_SHIFT		14
 #define DDR_MAX_BANK_SHIFT		3
@@ -216,6 +209,11 @@
 
 #define RANK_B0_BASE			6
 
+/* ZynqMP DDR QOS Interrupt register definitions */
+#define ZYNQMP_DDR_QOS_UE_MASK		0x4
+#define ZYNQMP_DDR_QOS_CE_MASK		0x2
+#define ZYNQMP_DDR_QOS_IRQ_MASK		0x6
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @row:	Row number.
@@ -398,8 +396,8 @@ static void enable_intr(struct synps_edac_priv *priv)
 
 	/* Enable UE/CE Interrupts */
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
-		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
+		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_EN_OFST);
 
 		return;
 	}
@@ -410,7 +408,7 @@ static void enable_intr(struct synps_edac_priv *priv)
 	 * IRQs Enable/Disable flags have been available since v3.10a.
 	 * This is noop for the older controllers.
 	 */
-	writel(DDR_UE_MASK | DDR_CE_MASK,
+	writel(ECC_CTRL_EN_CE_IRQ | ECC_CTRL_EN_UE_IRQ,
 	       priv->baseaddr + ECC_CLR_OFST);
 
 	spin_unlock_irqrestore(&priv->reglock, flags);
@@ -422,8 +420,8 @@ static void disable_intr(struct synps_edac_priv *priv)
 
 	/* Disable UE/CE Interrupts */
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
-		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
+		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_DB_OFST);
 
 		return;
 	}
@@ -451,9 +449,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	priv = mci->pvt_info;
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
-		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
-		if (!(regval & ECC_CE_UE_INTR_MASK))
+		regval = readl(priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
+		regval &= (ZYNQMP_DDR_QOS_CE_MASK | ZYNQMP_DDR_QOS_UE_MASK);
+		if (!(regval & ZYNQMP_DDR_QOS_IRQ_MASK))
 			return IRQ_NONE;
 	}
 
@@ -464,7 +462,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	handle_error(mci, &priv->stat);
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
-		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+		writel(regval, priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
 }
@@ -483,18 +481,18 @@ static enum dev_type synps_get_dtype(const void __iomem *base)
 	u32 regval;
 
 	regval = readl(base + DDR_MSTR_OFST);
-	if (!(regval & MEM_TYPE_DDR4))
+	if (!(regval & DDR_MSTR_MEM_DDR4))
 		return DEV_UNKNOWN;
 
-	regval = (regval & DDRC_MSTR_CFG_MASK) >> DDRC_MSTR_CFG_SHIFT;
+	regval = (regval & DDR_MSTR_DEV_CFG_MASK) >> DDR_MSTR_DEV_CFG_SHIFT;
 	switch (regval) {
-	case DDRC_MSTR_CFG_X4_MASK:
+	case DDR_MSTR_DEV_X4:
 		return DEV_X4;
-	case DDRC_MSTR_CFG_X8_MASK:
+	case DDR_MSTR_DEV_X8:
 		return DEV_X8;
-	case DDRC_MSTR_CFG_X16_MASK:
+	case DDR_MSTR_DEV_X16:
 		return DEV_X16;
-	case DDRC_MSTR_CFG_X32_MASK:
+	case DDR_MSTR_DEV_X32:
 		return DEV_X32;
 	}
 
@@ -548,11 +546,11 @@ static enum mem_type synps_get_mtype(const void __iomem *base)
 
 	memtype = readl(base + DDR_MSTR_OFST);
 
-	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+	if ((memtype & DDR_MSTR_MEM_DDR3) || (memtype & DDR_MSTR_MEM_LPDDR3))
 		mt = MEM_DDR3;
-	else if (memtype & MEM_TYPE_DDR2)
+	else if (memtype & DDR_MSTR_MEM_DDR2)
 		mt = MEM_RDDR2;
-	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+	else if ((memtype & DDR_MSTR_MEM_LPDDR4) || (memtype & DDR_MSTR_MEM_DDR4))
 		mt = MEM_DDR4;
 	else
 		mt = MEM_EMPTY;
@@ -757,12 +755,12 @@ static ssize_t inject_data_poison_store(struct device *dev,
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct synps_edac_priv *priv = mci->pvt_info;
 
-	writel(0, priv->baseaddr + DDRC_SWCTL);
+	writel(0, priv->baseaddr + DDR_SWCTL);
 	if (strncmp(data, "CE", 2) == 0)
 		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
 	else
 		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
-	writel(1, priv->baseaddr + DDRC_SWCTL);
+	writel(1, priv->baseaddr + DDR_SWCTL);
 
 	return count;
 }
@@ -879,8 +877,8 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
 			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
 					COL_MAX_VAL_MASK) + COL_B9_BASE);
-	if (width == DDRCTL_EWDTH_64) {
-		if (memtype & MEM_TYPE_LPDDR3) {
+	if (width == DDR_MSTR_BUSWIDTH_64) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = ((addrmap[4] &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				((addrmap[4] & COL_MAX_VAL_MASK) +
@@ -899,8 +897,8 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
 				 COL_B11_BASE);
 		}
-	} else if (width == DDRCTL_EWDTH_32) {
-		if (memtype & MEM_TYPE_LPDDR3) {
+	} else if (width == DDR_MSTR_BUSWIDTH_32) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 24) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
@@ -920,7 +918,7 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				 COL_B10_BASE);
 		}
 	} else {
-		if (memtype & MEM_TYPE_LPDDR3) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
@@ -995,7 +993,7 @@ static void setup_address_map(struct synps_edac_priv *priv)
 	for (index = 0; index < 12; index++) {
 		u32 addrmap_offset;
 
-		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap_offset = DDR_ADDRMAP0_OFST + (index * 4);
 		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
 	}
 
-- 
2.41.0

