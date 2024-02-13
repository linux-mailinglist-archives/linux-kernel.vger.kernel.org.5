Return-Path: <linux-kernel+bounces-64083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657308539FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D45C284F36
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F8101F7;
	Tue, 13 Feb 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M4JttkyG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876782919;
	Tue, 13 Feb 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849304; cv=none; b=rvXoOSvxQp71wHS3MafBZmRg6D8qjWWm6cVTVnsovpr5QqqVAD0bC97DXFnL7Rf8JjPWOPx4iY9tCc1loeiKmlkGIkGleKcVp37jNsiV59+GLJOLS+vxOeRUnUt90oYsRDTdgYvZIy/Ywzzli904Qnh/11m0sFMnB0oC772av1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849304; c=relaxed/simple;
	bh=pMJQFU0nuKzlBdA9y2O/o3Z4I6k/49p3R5XkJkL/Obs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDqe9nS3iUZuKSfEhXjSMxF4ZI3vGcdEbBUpAopUm9uiiLp0vvWbbKBmxg2DrkveeM4XMX919CQ7/dRRkEhrDjSqxlnsrsQ3lPMcWvOm5fP6OEnBbxOAGW8+fb+c4xhCHyNiR+rKoG5D4PyJ2E09lDR7qsga06MqUlfy9Bs+Xek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M4JttkyG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2A00140E01A9;
	Tue, 13 Feb 2024 18:34:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CklShk4rq2gn; Tue, 13 Feb 2024 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707849295; bh=Qnoqpp6UPtVAy039iLb/qnIcn87hN9Ob4iI5jL6p2yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4JttkyGrxlHZ1p4tqswaGwB7nUiwyb59LxzQz0IeR/Yqd6ehuYqNVpFJBAnsqX91
	 2FOPdugf/E6/SfNC1hyvJFBl5WxeWiE+9k+YwrH6/SqN9INSurjU/7U47nHy942Hv6
	 Icfs0psHwy5T8PMC6hbzCxxX1uuwT/dJ6abHyEBuFF513u16ZD55aPZ97tGpnpNGic
	 5R5HDA5+IyPXPkJAzreOx2ENVLgLo/qEyH/2QcPly7z6fELjVuibelY0tRBbvd3Vei
	 ZCAmMT8S8liKzhLFmAg9yW1q1FnOji+Sw5g6vsnQwHsqUdSNfjqPa2HjomWwa8iz2E
	 xxZQL7d+hRQ0Q43camzhdhDmfI1S2kIrPBqaXFmisrH0uFTA36QGrFv1fXPDYVx5wi
	 0iZsceGkwLBP1BYWQeFC9l6+n6zhE67QaJiI8W7MA7OWmjm7us3OcjX2RQ4ME7SARb
	 brXOGHmxcMP/u4jZxSNzgX8drCs2dPkkcCDsRYFeVXRFTctMzWLQeGYSS0zEgKrSfG
	 GQ23B0EgEZ5twfDtwIkAPV29oBuEmL4MvaaHrJHkr3WhKEPTMU1xS5gVADi9GZH/QT
	 Fp/c6cWnrglA27QlmvUz/zYatBJGQdzoJUcIWtbPXZVaNIKhup7pysyigUiy1Mc7ob
	 BUNaLxfqcI9ZbjDxbDPHq/Ps=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE86F40E0192;
	Tue, 13 Feb 2024 18:34:46 +0000 (UTC)
Date: Tue, 13 Feb 2024 19:34:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.org, git@amd.com, sai.krishna.potthuri@amd.com,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Subject: Re: [PATCH v3] EDAC/versal: Make the bits in error injection
 configurable
Message-ID: <20240213183439.GDZcu2PwWnFxsRp7x2@fat_crate.local>
References: <20240208094653.11704-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208094653.11704-1-shubhrajyoti.datta@amd.com>

On Thu, Feb 08, 2024 at 03:16:53PM +0530, Shubhrajyoti Datta wrote:
> Currently the error injection for correctable and uncorrectable errors
> bits are hardcoded. To make it configurable add separate sysfs
> entries to set the bit positions for injecting CE and UE errors.
> It injects single bit error for CE and two bits errors for UE.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---

Did some touchups ontop, especially make inject_data_ce_store() verify
the user input first and then do the injection, just like the ue_store
counterpart does.

Pls check whether injection still works ok.

Thx.

---
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Date: Thu, 8 Feb 2024 15:16:53 +0530
Subject: [PATCH] EDAC/versal: Make the bit position of injected errors configurable

Currently, the bit positions to inject correctable and uncorrectable
errors are hardcoded. To make that configurable add separate sysfs entries
to set the bit positions for injecting CE and UE errors. Allow for
single bit error for CE and two bits errors for UE injection.

  [ bp: Massage. ]

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240208094653.11704-1-shubhrajyoti.datta@amd.com
---
 drivers/edac/versal_edac.c | 193 +++++++++++++++++++++++++++++++------
 1 file changed, 161 insertions(+), 32 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 62caf454b567..3016870689f1 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -42,8 +42,11 @@
 
 #define ECCW0_FLIP_CTRL				0x109C
 #define ECCW0_FLIP0_OFFSET			0x10A0
+#define ECCW0_FLIP0_BITS			31
+#define ECCW0_FLIP1_OFFSET			0x10A4
 #define ECCW1_FLIP_CTRL				0x10AC
 #define ECCW1_FLIP0_OFFSET			0x10B0
+#define ECCW1_FLIP1_OFFSET			0x10B4
 #define ECCR0_CERR_STAT_OFFSET			0x10BC
 #define ECCR0_CE_ADDR_LO_OFFSET			0x10C0
 #define ECCR0_CE_ADDR_HI_OFFSET			0x10C4
@@ -116,9 +119,6 @@
 #define XDDR_BUS_WIDTH_32			1
 #define XDDR_BUS_WIDTH_16			2
 
-#define ECC_CEPOISON_MASK			0x1
-#define ECC_UEPOISON_MASK			0x3
-
 #define XDDR_MAX_ROW_CNT			18
 #define XDDR_MAX_COL_CNT			10
 #define XDDR_MAX_RANK_CNT			2
@@ -133,6 +133,7 @@
  * https://docs.xilinx.com/r/en-US/am012-versal-register-reference/PCSR_LOCK-XRAM_SLCR-Register
  */
 #define PCSR_UNLOCK_VAL				0xF9E8D7C6
+#define PCSR_LOCK_VAL				1
 #define XDDR_ERR_TYPE_CE			0
 #define XDDR_ERR_TYPE_UE			1
 
@@ -142,6 +143,7 @@
 #define XILINX_DRAM_SIZE_12G			3
 #define XILINX_DRAM_SIZE_16G			4
 #define XILINX_DRAM_SIZE_32G			5
+#define NUM_UE_BITPOS				2
 
 /**
  * struct ecc_error_info - ECC error log information.
@@ -479,7 +481,7 @@ static void err_callback(const u32 *payload, void *data)
 	writel(regval, priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);
 
 	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
@@ -650,7 +652,7 @@ static void enable_intr(struct edac_priv *priv)
 	writel(XDDR_IRQ_UE_MASK,
 	       priv->ddrmc_baseaddr + XDDR_IRQ1_EN_OFFSET);
 	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 }
 
 static void disable_intr(struct edac_priv *priv)
@@ -663,7 +665,7 @@ static void disable_intr(struct edac_priv *priv)
 	       priv->ddrmc_baseaddr + XDDR_IRQ_DIS_OFFSET);
 
 	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 }
 
 #define to_mci(k) container_of(k, struct mem_ctl_info, dev)
@@ -734,38 +736,63 @@ static void poison_setup(struct edac_priv *priv)
 	writel(regval, priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC15_OFFSET);
 }
 
-static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
-					     const char __user *data)
+static void xddr_inject_data_ce_store(struct mem_ctl_info *mci, u8 ce_bitpos)
 {
+	u32 ecc0_flip0, ecc1_flip0, ecc0_flip1, ecc1_flip1;
 	struct edac_priv *priv = mci->pvt_info;
 
-	writel(0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
-	writel(0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);
-
-	if (strncmp(data, "CE", 2) == 0) {
-		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW0_FLIP0_OFFSET);
-		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW1_FLIP0_OFFSET);
+	if (ce_bitpos < ECCW0_FLIP0_BITS) {
+		ecc0_flip0 = BIT(ce_bitpos);
+		ecc1_flip0 = BIT(ce_bitpos);
+		ecc0_flip1 = 0;
+		ecc1_flip1 = 0;
 	} else {
-		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW0_FLIP0_OFFSET);
-		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW1_FLIP0_OFFSET);
+		ce_bitpos = ce_bitpos - ECCW0_FLIP0_BITS;
+		ecc0_flip1 = BIT(ce_bitpos);
+		ecc1_flip1 = BIT(ce_bitpos);
+		ecc0_flip0 = 0;
+		ecc1_flip0 = 0;
 	}
 
-	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
-
-	return 0;
+	writel(ecc0_flip0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
+	writel(ecc1_flip0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);
+	writel(ecc0_flip1, priv->ddrmc_baseaddr + ECCW0_FLIP1_OFFSET);
+	writel(ecc1_flip1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
 }
 
-static ssize_t inject_data_poison_store(struct file *file, const char __user *data,
-					size_t count, loff_t *ppos)
+/*
+ * To inject a correctable error, the following steps are needed:
+ *
+ * - Write the correctable error bit position value:
+ *	echo <bit_pos val> > /sys/kernel/debug/edac/<controller instance>/inject_ce
+ *
+ * poison_setup() derives the row, column, bank, group and rank and
+ * writes to the ADEC registers based on the address given by the user.
+ *
+ * The ADEC12 and ADEC13 are mask registers; write 0 to make sure default
+ * configuration is there and no addresses are masked.
+ *
+ * The row, column, bank, group and rank registers are written to the
+ * match ADEC bit to generate errors at the particular address. ADEC14
+ * and ADEC15 have the match bits.
+ *
+ * xddr_inject_data_ce_store() updates the ECC FLIP registers with the
+ * bits to be corrupted based on the bit position given by the user.
+ *
+ * Upon doing a read to the address the errors are injected.
+ */
+static ssize_t inject_data_ce_store(struct file *file, const char __user *data,
+				    size_t count, loff_t *ppos)
 {
 	struct device *dev = file->private_data;
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct edac_priv *priv = mci->pvt_info;
+	u8 ce_bitpos;
+	int ret;
+
+	ret = kstrtou8_from_user(data, count, 0, &ce_bitpos);
+	if (ret)
+		return ret;
 
 	/* Unlock the PCSR registers */
 	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
@@ -773,17 +800,110 @@ static ssize_t inject_data_poison_store(struct file *file, const char __user *da
 
 	poison_setup(priv);
 
+	xddr_inject_data_ce_store(mci, ce_bitpos);
+	ret = count;
+
 	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	return ret;
+}
+
+static const struct file_operations xddr_inject_ce_fops = {
+	.open = simple_open,
+	.write = inject_data_ce_store,
+	.llseek = generic_file_llseek,
+};
+
+static void xddr_inject_data_ue_store(struct mem_ctl_info *mci, u32 val0, u32 val1)
+{
+	struct edac_priv *priv = mci->pvt_info;
+
+	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
+	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP1_OFFSET);
+	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
+	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
+}
+
+/*
+ * To inject an uncorrectable error, the following steps are needed:
+ *	echo <bit_pos val> > /sys/kernel/debug/edac/<controller instance>/inject_ue
+ *
+ * poison_setup() derives the row, column, bank, group and rank and
+ * writes to the ADEC registers based on the address given by the user.
+ *
+ * The ADEC12 and ADEC13 are mask registers; write 0 so that none of the
+ * addresses are masked. The row, column, bank, group and rank registers
+ * are written to the match ADEC bit to generate errors at the
+ * particular address. ADEC14 and ADEC15 have the match bits.
+ *
+ * xddr_inject_data_ue_store() updates the ECC FLIP registers with the
+ * bits to be corrupted based on the bit position given by the user. For
+ * uncorrectable errors
+ * 2 bit errors are injected.
+ *
+ * Upon doing a read to the address the errors are injected.
+ */
+static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
+				    size_t count, loff_t *ppos)
+{
+	struct device *dev = file->private_data;
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct edac_priv *priv = mci->pvt_info;
+	char buf[6], *pbuf, *token[2];
+	u32 val0 = 0, val1 = 0;
+	u8 len, ue0, ue1;
+	int i, ret;
+
+	len = min_t(size_t, count, sizeof(buf));
+	if (copy_from_user(buf, data, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	pbuf = &buf[0];
+	for (i = 0; i < NUM_UE_BITPOS; i++)
+		token[i] = strsep(&pbuf, ",");
+
+	ret = kstrtou8(token[0], 0, &ue0);
+	if (ret)
+		return ret;
+
+	ret = kstrtou8(token[1], 0, &ue1);
+	if (ret)
+		return ret;
+
+	if (ue0 < ECCW0_FLIP0_BITS) {
+		val0 = BIT(ue0);
+	} else {
+		ue0 = ue0 - ECCW0_FLIP0_BITS;
+		val1 = BIT(ue0);
+	}
 
-	xddr_inject_data_poison_store(mci, data);
+	if (ue1 < ECCW0_FLIP0_BITS) {
+		val0 |= BIT(ue1);
+	} else {
+		ue1 = ue1 - ECCW0_FLIP0_BITS;
+		val1 |= BIT(ue1);
+	}
 
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	poison_setup(priv);
+
+	xddr_inject_data_ue_store(mci, val0, val1);
+
+	/* Lock the PCSR registers */
+	writel(PCSR_LOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 	return count;
 }
 
-static const struct file_operations xddr_inject_enable_fops = {
+static const struct file_operations xddr_inject_ue_fops = {
 	.open = simple_open,
-	.write = inject_data_poison_store,
+	.write = inject_data_ue_store,
 	.llseek = generic_file_llseek,
 };
 
@@ -795,8 +915,17 @@ static void create_debugfs_attributes(struct mem_ctl_info *mci)
 	if (!priv->debugfs)
 		return;
 
-	edac_debugfs_create_file("inject_error", 0200, priv->debugfs,
-				 &mci->dev, &xddr_inject_enable_fops);
+	if (!edac_debugfs_create_file("inject_ce", 0200, priv->debugfs,
+				      &mci->dev, &xddr_inject_ce_fops)) {
+		debugfs_remove_recursive(priv->debugfs);
+		return;
+	}
+
+	if (!edac_debugfs_create_file("inject_ue", 0200, priv->debugfs,
+				      &mci->dev, &xddr_inject_ue_fops)) {
+		debugfs_remove_recursive(priv->debugfs);
+		return;
+	}
 	debugfs_create_x64("address", 0600, priv->debugfs,
 			   &priv->err_inject_addr);
 	mci->debugfs = priv->debugfs;
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

