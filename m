Return-Path: <linux-kernel+bounces-77057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3292860098
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F51F268D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E61586D7;
	Thu, 22 Feb 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWsjGL8x"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569215698D;
	Thu, 22 Feb 2024 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625666; cv=none; b=ZIBlZW1vPMSEfc10ez+gzc6Ihh6tI92hoLSkZ7FoxhBOo84aikVGnf6HVXLZZ89bVWG0P4kNhzrk/TINHOOOAM+vHzGFpWpHtN5Q+SfmD1NNFCTXdx35clDMd7AdVVcbolyS2Xq0lJFFf8zJI8N4XyL6f2gjkpUvnCYYB9g10jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625666; c=relaxed/simple;
	bh=7XY4zi+Yr5ULD/hwfnv1NJqH1CIh9FIpNo5fuTrVk5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OChQrqXwrf1hBAg8QlsWnvqWEZ+k19DoxA/H0HHVXwvDu1u+PqOh472ok3FtVfIp5+bWWMzUUBsqOZhVIJ8vn4rizsm6vfbKUx2xAh+MprtT4kz+3rDT2MXXawxxxTy5oJpJutdCaStrTv0OxxfdUtOl95Bw5AHgeMOc/FLNjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWsjGL8x; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5101cd91017so76568e87.2;
        Thu, 22 Feb 2024 10:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625663; x=1709230463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qyJghl0xqwmscdyWmOAn7eBB6UolwNf9WzGJ00ORnM=;
        b=fWsjGL8xTJUHnrTKSV9+4lDgNieI1NXFCpYHyy2RXGgqH9am6AVVsKfDMN+zoXg65a
         xIwpKgZIv2L3IHuQVWLPPm0DXiVZWI2f+mN0Q3PaQRSOYN2D7gFpZ0AmTbCAg3FFPWyU
         vmm3zcs68n/r4ElsoR3q69HMoUAAgiCT//v+t00anLrJ84g2B8PERpY84vj3g0Q9bF2f
         OV1Ndc5qA2b78siJHRT9ghTA2ZGHDcNB7daDV72t+moIfwZ0PKAHCymuLvSBrd/LKY/W
         2Espxo20iUJOVgCdhurKOzwCe8J7xhvLLB4fi8YHI5BJNgRSe1KPDV/EKr71UJk9wNU6
         zVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625663; x=1709230463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qyJghl0xqwmscdyWmOAn7eBB6UolwNf9WzGJ00ORnM=;
        b=XzitL7bqfTs2sTELRAarKZwCUnTAXPyP5lcS/lX1tTwVwhlgXYTeAf/rReefNiwYea
         Fo1qLHbXiWV2MJR9OVTn68SUMeoYlAj7w9TJ4q1h97ZJBaWW4lfIDFjpjYAt4cNlVlDG
         hOd6lwEhfjTJTZIwA5uCRFvO5ZzlYaxsH6hcW9QPOh702BBGcYYXpT/vVpmr9CQi6IxK
         hswMRuYi8XptijUZUf0yLXDaRlQdTQqUsS1B3UFoZjul8TdbccEJhrW/bRd/f3oiv/Ph
         ZvzVKAtFOpRcHxB8pYia+AMJWiGBDqrDFscWXqNY0E8OHo6gYc3Q5SfwGYHjVxVdt63m
         /5xA==
X-Forwarded-Encrypted: i=1; AJvYcCW/YCvMWWcAGFfb8v2+UO3OPpFOYRbubXOdtejbyTxcPLLn11ooyPlYRrjY356Z2s/VHf9/AgOfjb4xFHSjJLvMSQ1IxaFzvl/8Pp+RW/HRKdNAAufDJwzhI1PUricGltzhuQSJmoKqmw==
X-Gm-Message-State: AOJu0Yx3WtsZBzIyONe8sYabDMC2VLewR/okdrorB1eX/60HFTLB7SBP
	c/euMjMe/tCIIbx486Yn/I5pZ579tGB/9DsAumE4CflwlXBDEkDO
X-Google-Smtp-Source: AGHT+IFijz6QFs1d/1Wsr4KVrtHFrWPHYvhKrodu21VdqHALqVlmpK2g3OEicBVmuVI9kJVbBEFJpw==
X-Received: by 2002:a05:6512:3fc:b0:512:ceae:93d9 with SMTP id n28-20020a05651203fc00b00512ceae93d9mr3374265lfq.28.1708625662700;
        Thu, 22 Feb 2024 10:14:22 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id g12-20020ac24d8c000000b005126ab0e3fasm2152711lfe.124.2024.02.22.10.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:22 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sherry Sun <sherry.sun@nxp.com>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH v5 01/20] EDAC/synopsys: Fix ECC status data and IRQ disable race condition
Date: Thu, 22 Feb 2024 21:12:46 +0300
Message-ID: <20240222181324.28242-2-fancer.lancer@gmail.com>
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

The race condition around the ECCCLR register access happens in the IRQ
disable method called in the device remove() procedure and in the ECC IRQ
handler:
1. Enable IRQ:
   a. ECCCLR = EN_CE | EN_UE
2. Disable IRQ:
   a. ECCCLR = 0
3. IRQ handler:
   a. ECCCLR = CLR_CE | CLR_CE_CNT | CLR_CE | CLR_CE_CNT
   b. ECCCLR = 0
   c. ECCCLR = EN_CE | EN_UE
So if the IRQ disabling procedure is called concurrently with the IRQ
handler method the IRQ might be actually left enabled due to the
statement 3c.

The root cause of the problem is that ECCCLR register (which since v3.10a
has been called as ECCCTL) has intermixed ECC status data clear flags and
the IRQ enable/disable flags. Thus the IRQ disabling (clear EN flags) and
handling (write 1 to clear ECC status data) procedures must be serialised
around the ECCCTL register modification to prevent the race.

So fix the problem described above by adding the spin-lock around the
ECCCLR modifications and preventing the IRQ-handler from modifying the
IRQs enable flags (there is no point in disabling the IRQ and then
re-enabling it again within a single IRQ handler call, see the statements
3a/3b and 3c above).

Fixes: f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Cc: Sherry Sun <sherry.sun@nxp.com>

Changelog v4:
- This is a new patch detached from
  [PATCH v3 01/17] EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
- Rename lock to reglock (Borislav)
---
 drivers/edac/synopsys_edac.c | 50 ++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 709babce43ba..0168b05e3ca1 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -9,6 +9,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 
@@ -299,6 +300,7 @@ struct synps_ecc_status {
 /**
  * struct synps_edac_priv - DDR memory controller private instance data.
  * @baseaddr:		Base address of the DDR controller.
+ * @reglock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @p_data:		Platform data.
@@ -313,6 +315,7 @@ struct synps_ecc_status {
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
+	spinlock_t reglock;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
 	const struct synps_platform_data *p_data;
@@ -408,7 +411,8 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 {
 	struct synps_ecc_status *p;
-	u32 regval, clearval = 0;
+	u32 regval, clearval;
+	unsigned long flags;
 	void __iomem *base;
 
 	base = priv->baseaddr;
@@ -452,10 +456,14 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 out:
-	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
-	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	clearval = readl(base + ECC_CLR_OFST) |
+		   ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
+		   ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
 	writel(clearval, base + ECC_CLR_OFST);
-	writel(0x0, base + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
 
 	return 0;
 }
@@ -515,24 +523,41 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 static void enable_intr(struct synps_edac_priv *priv)
 {
+	unsigned long flags;
+
 	/* Enable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(DDR_UE_MASK | DDR_CE_MASK,
-		       priv->baseaddr + ECC_CLR_OFST);
-	else
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 
+		return;
+	}
+
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	writel(DDR_UE_MASK | DDR_CE_MASK,
+	       priv->baseaddr + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
 static void disable_intr(struct synps_edac_priv *priv)
 {
+	unsigned long flags;
+
 	/* Disable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(0x0, priv->baseaddr + ECC_CLR_OFST);
-	else
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+
+		return;
+	}
+
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	writel(0, priv->baseaddr + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
 /**
@@ -576,8 +601,6 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	/* v3.0 of the controller does not have this register */
 	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-	else
-		enable_intr(priv);
 
 	return IRQ_HANDLED;
 }
@@ -1359,6 +1382,7 @@ static int mc_probe(struct platform_device *pdev)
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
 	priv->p_data = p_data;
+	spin_lock_init(&priv->reglock);
 
 	mc_init(mci, pdev);
 
-- 
2.43.0


