Return-Path: <linux-kernel+bounces-77082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7764D8600FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24621F24A12
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2F6AF8B;
	Thu, 22 Feb 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPeod5jO"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F27548ED;
	Thu, 22 Feb 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625696; cv=none; b=e0B9fU2+hepS0OLmTSDtq7bo/20jfDj7gVYLO+ezOEg3OKnGeqZbuUbEeHT14Mvxkl+27YQoHpAKnpsLokFogu3m+tnuFmMAnsC4JUJ6w7+7obMtTqiZ40ExJHWAcwEEBYvXAeCW/5cWIR2S/vE+5rPx2NlrNrcVfbNl9l3Rxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625696; c=relaxed/simple;
	bh=Tp8bNQTKZvXyUuRv2VzAkrzXbt8xfHFlNuVT1cFXNuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7k0XPCCMVDDc2RC24ExUFg/f+oSIKjUMd+tCcRxGnKHVFdCHkwOsJnHgiSoSZ62gaYj/ZF2ty4xx3Y7RVKczzLeBSBaqENmho8Ao4W821Ls+MSyrrasrmfrNQHdMxFcAQE4QhePtcD+iKjmV/NEThoAWh0Vhyaf8NRG3FkGfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPeod5jO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512cba0f953so84199e87.2;
        Thu, 22 Feb 2024 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625692; x=1709230492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl1k5+lYKw5HlM2KYot8vM467N06m05HgUvKEyN6tJ8=;
        b=ZPeod5jOabEoQFYSykgwmH0WDgsPI1V+mQQIEVYiHuu8cXzP0+b1tLCv36Gs/TDPM3
         QsK5KV+t1PnKCq1ekBwPFo3xoAim3v3i1uUqRxfZKdRaIX8Fp4Y3YA6iqjku0MKGmtHW
         ycHNTunGXV02uJHt7eSubJ2pxiEzZoJOz19PhPyqP0elZ6fCRT+Zse6IKR46Irg5QYjb
         CFRK1QhMwEYV0UX12p5Z+u/VltDBlB62B7vDc0asbNglZhZbzCwbHGLBCSgcN4r6o/ih
         XXKUFFo46ogN75qz0+aqkWCHLs29Ok4fCcjoJ2NK8vXZechqq4mwc8PDrJuQSN+dhXdR
         wu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625692; x=1709230492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl1k5+lYKw5HlM2KYot8vM467N06m05HgUvKEyN6tJ8=;
        b=wQxjnGm15h00gh2iV6ggjYDGhiXMygK6CkFyOfDU63zfcqja1cmXeTBu0PZxaH82py
         0BLW5A2tx5I2Wu5TvrbV9XCcknZ3Bl1DHw9HbsR0EZeOBz0BI8o0Q2q+Fa4jJ5XAvj8j
         o/k4K7qTBMUPh7RA5k+gR3WY6nHHCTwf42Iymk/WiFTtGSgc4qZRvcKdUkuB/JGUA6Jy
         e7d5qL6lYG9oBpDLK8eRh9y/tAHwd4CbTLdPm9lr2QgdIwly2V5GUkmR723Q/6k5Iaou
         blbFK9BxS4mYjnUX6ET4dy9zTYUuzEes6gcHkpLaWIKExiLJ2HekWun2lfgtWvmQcA2X
         zXMw==
X-Forwarded-Encrypted: i=1; AJvYcCVJs+atnzoDLWBRfxvzIFkgQQuk/CqXKXrqB+OIOMCEGlpbODeJXzu4IZG8PZ8/QeyYjUDGLd0r/CfmsiP91FBEioGzg/NfmYtb7V0UJGgfPpaqbFzRT3+VQ9q+lKEjAjs0lGadeNuaZg==
X-Gm-Message-State: AOJu0YwCEoKmaXlQ5bE3QBTfbFYPchI4A+l/BXH731t1BLwwDUt+v01v
	gkJlqK2+YWCRQ3H595ibD7/1eqy47sB+dnEpQi0k6bs2pkY2CE8Q
X-Google-Smtp-Source: AGHT+IFoL/XCZ2Ks7+fgcMasDWSs9e7/s1j3RQC/zsHVDmpXyqG5t29RRkx/5c0GJbUyvUd9eAkJnw==
X-Received: by 2002:ac2:5f72:0:b0:512:b051:7b06 with SMTP id c18-20020ac25f72000000b00512b0517b06mr8468525lfc.31.1708625692016;
        Thu, 22 Feb 2024 10:14:52 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u14-20020ac248ae000000b005115430488bsm2148044lfg.243.2024.02.22.10.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:51 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/20] EDAC/synopsys: Drop unused platform-specific setup API
Date: Thu, 22 Feb 2024 21:13:02 +0300
Message-ID: <20240222181324.28242-18-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver now works with the Synopsys DW uMCTL2 DDRC IP-core-based
devices only (Xilinx Zynq A05 DDRC support has been moved to the separate
driver). All the currently available IP-core revisions have got almost the
same ECC and main part of the DDR-config CSRs map. Thus there is no point
in supporting the no longer used internal abstraction layer like the
callbacks responsible for getting the ECC errors info, memory and device
types, ECC state. All of that data can be retrieved in the same way from
all the Synopys DW uMCTL2 DDR controller versions. Similarly there is no
longer need in the DDR_ECC_INTR_SUPPORT and DDR_ECC_DATA_POISON_SUPPORT
quirk flags since DW uMCTL2 always supports IRQs and data poisoning (as
long as the ECC is supported). Drop that infrastructure for good then.

While at it move the module device table to being defined at the bottom of
the file, above the platform driver descriptor definition.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
---
 drivers/edac/synopsys_edac.c | 192 ++++++++++-------------------------
 1 file changed, 51 insertions(+), 141 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6ea1eaaa7d6f..1cd02859e2b9 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -30,9 +30,7 @@
 #define SYNPS_EDAC_MOD_VER		"1"
 
 /* DDR ECC Quirks */
-#define DDR_ECC_INTR_SUPPORT		BIT(0)
-#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
-#define SYNPS_ZYNQMP_IRQ_REGS		BIT(2)
+#define SYNPS_ZYNQMP_IRQ_REGS		BIT(0)
 
 /* Synopsys DDR memory controller registers that are relevant to ECC */
 
@@ -280,28 +278,20 @@ struct synps_edac_priv {
 };
 
 /**
- * struct synps_platform_data -  synps platform data structure.
- * @get_error_info:	Get EDAC error info.
- * @get_mtype:		Get mtype.
- * @get_dtype:		Get dtype.
- * @get_ecc_state:	Get ECC state.
- * @quirks:		To differentiate IPs.
+ * struct synps_platform_data - Synopsys uMCTL2 DDRC platform data.
+ * @quirks:	IP-core specific quirks.
  */
 struct synps_platform_data {
-	int (*get_error_info)(struct synps_edac_priv *priv);
-	enum mem_type (*get_mtype)(const void __iomem *base);
-	enum dev_type (*get_dtype)(const void __iomem *base);
-	bool (*get_ecc_state)(void __iomem *base);
-	int quirks;
+	u32 quirks;
 };
 
 /**
- * zynqmp_get_error_info - Get the current ECC error info.
+ * synps_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
  *
  * Return: one if there is no error otherwise returns zero.
  */
-static int zynqmp_get_error_info(struct synps_edac_priv *priv)
+static int synps_get_error_info(struct synps_edac_priv *priv)
 {
 	struct synps_ecc_status *p;
 	u32 regval, clearval;
@@ -375,17 +365,11 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
-				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
-				 pinf->bitpos, pinf->data);
-		} else {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Bank %d Col %d Bit: %d Data: 0x%08x",
-				 pinf->row, pinf->bank, pinf->col,
-				 pinf->bitpos, pinf->data);
-		}
+
+		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
+			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+			 pinf->bitpos, pinf->data);
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
@@ -394,15 +378,10 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Col %d Bank %d Bank Group %d",
-				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
-		} else {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Bank %d Col %d",
-				 pinf->row, pinf->bank, pinf->col);
-		}
+
+		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+			 "Row %d Col %d Bank %d Bank Group %d",
+			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
@@ -464,13 +443,11 @@ static void disable_intr(struct synps_edac_priv *priv)
  */
 static irqreturn_t intr_handler(int irq, void *dev_id)
 {
-	const struct synps_platform_data *p_data;
 	struct mem_ctl_info *mci = dev_id;
 	struct synps_edac_priv *priv;
 	int status, regval;
 
 	priv = mci->pvt_info;
-	p_data = priv->p_data;
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
@@ -479,7 +456,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 			return IRQ_NONE;
 	}
 
-	status = p_data->get_error_info(priv);
+	status = synps_get_error_info(priv);
 	if (status)
 		return IRQ_NONE;
 
@@ -492,29 +469,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 }
 
 /**
- * check_errors - Check controller for ECC errors.
- * @mci:	EDAC memory controller instance.
- *
- * Check and post ECC errors. Called by the polling thread.
- */
-static void check_errors(struct mem_ctl_info *mci)
-{
-	const struct synps_platform_data *p_data;
-	struct synps_edac_priv *priv;
-	int status;
-
-	priv = mci->pvt_info;
-	p_data = priv->p_data;
-
-	status = p_data->get_error_info(priv);
-	if (status)
-		return;
-
-	handle_error(mci, &priv->stat);
-}
-
-/**
- * zynqmp_get_dtype - Return the controller memory width.
+ * synps_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -522,7 +477,7 @@ static void check_errors(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+static enum dev_type synps_get_dtype(const void __iomem *base)
 {
 	u32 regval;
 
@@ -546,14 +501,14 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 }
 
 /**
- * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
+ * synps_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
  * Get the ECC enable/disable status for the controller.
  *
  * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool zynqmp_get_ecc_state(void __iomem *base)
+static bool synps_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
@@ -577,7 +532,7 @@ static u32 get_memsize(void)
 }
 
 /**
- * zynqmp_get_mtype - Returns controller memory type.
+ * synps_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -585,7 +540,7 @@ static u32 get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type zynqmp_get_mtype(const void __iomem *base)
+static enum mem_type synps_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -614,14 +569,11 @@ static enum mem_type zynqmp_get_mtype(const void __iomem *base)
 static void init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
-	const struct synps_platform_data *p_data;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	u32 size, row;
 	int j;
 
-	p_data = priv->p_data;
-
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = get_memsize();
@@ -629,10 +581,10 @@ static void init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_SECDED;
-			dimm->mtype	= p_data->get_mtype(priv->baseaddr);
+			dimm->mtype	= synps_get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= p_data->get_dtype(priv->baseaddr);
+			dimm->dtype	= synps_get_dtype(priv->baseaddr);
 		}
 	}
 }
@@ -648,10 +600,7 @@ static void init_csrows(struct mem_ctl_info *mci)
  */
 static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
-	struct synps_edac_priv *priv;
-
 	mci->pdev = &pdev->dev;
-	priv = mci->pvt_info;
 	platform_set_drvdata(pdev, mci);
 
 	/* Initialize controller capabilities and configuration */
@@ -665,12 +614,7 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-		edac_op_state = EDAC_OPSTATE_INT;
-	} else {
-		edac_op_state = EDAC_OPSTATE_POLL;
-		mci->edac_check = check_errors;
-	}
+	edac_op_state = EDAC_OPSTATE_INT;
 
 	mci->ctl_page_to_phys = NULL;
 
@@ -702,47 +646,6 @@ static int setup_irq(struct mem_ctl_info *mci,
 	return 0;
 }
 
-static const struct synps_platform_data zynqmp_edac_def = {
-	.get_error_info	= zynqmp_get_error_info,
-	.get_mtype	= zynqmp_get_mtype,
-	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT | SYNPS_ZYNQMP_IRQ_REGS
-#ifdef CONFIG_EDAC_DEBUG
-			  | DDR_ECC_DATA_POISON_SUPPORT
-#endif
-			  ),
-};
-
-static const struct synps_platform_data synopsys_edac_def = {
-	.get_error_info	= zynqmp_get_error_info,
-	.get_mtype	= zynqmp_get_mtype,
-	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT
-#ifdef CONFIG_EDAC_DEBUG
-			  | DDR_ECC_DATA_POISON_SUPPORT
-#endif
-			  ),
-};
-
-
-static const struct of_device_id synps_edac_match[] = {
-	{
-		.compatible = "xlnx,zynqmp-ddrc-2.40a",
-		.data = (void *)&zynqmp_edac_def
-	},
-	{
-		.compatible = "snps,ddrc-3.80a",
-		.data = (void *)&synopsys_edac_def
-	},
-	{
-		/* end of table */
-	}
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 #ifdef CONFIG_EDAC_DEBUG
 
 /**
@@ -1133,7 +1036,7 @@ static int mc_probe(struct platform_device *pdev)
 	if (!p_data)
 		return -ENODEV;
 
-	if (!p_data->get_ecc_state(baseaddr)) {
+	if (!synps_get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -1160,11 +1063,9 @@ static int mc_probe(struct platform_device *pdev)
 
 	mc_init(mci, pdev);
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-		rc = setup_irq(mci, pdev);
-		if (rc)
-			goto free_edac_mc;
-	}
+	rc = setup_irq(mci, pdev);
+	if (rc)
+		goto free_edac_mc;
 
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
@@ -1174,17 +1075,13 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_EDAC_DEBUG
-	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
-		rc = edac_create_sysfs_attributes(mci);
-		if (rc) {
-			edac_printk(KERN_ERR, EDAC_MC,
-					"Failed to create sysfs entries\n");
-			goto free_edac_mc;
-		}
+	rc = edac_create_sysfs_attributes(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to create sysfs entries\n");
+		goto free_edac_mc;
 	}
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
-		setup_address_map(priv);
+	setup_address_map(priv);
 #endif
 
 	return rc;
@@ -1206,18 +1103,31 @@ static void mc_remove(struct platform_device *pdev)
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 	struct synps_edac_priv *priv = mci->pvt_info;
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
-		disable_intr(priv);
+	disable_intr(priv);
 
 #ifdef CONFIG_EDAC_DEBUG
-	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
-		edac_remove_sysfs_attributes(mci);
+	edac_remove_sysfs_attributes(mci);
 #endif
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 }
 
+static const struct synps_platform_data zynqmp_edac_def = {
+	.quirks = SYNPS_ZYNQMP_IRQ_REGS,
+};
+
+static const struct synps_platform_data synopsys_edac_def = {
+	.quirks = 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = &zynqmp_edac_def },
+	{ .compatible = "snps,ddrc-3.80a", .data = &synopsys_edac_def },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.43.0


