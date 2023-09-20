Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942547A8CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjITT2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjITT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:42 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CBF114;
        Wed, 20 Sep 2023 12:28:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b703a0453fso2524441fa.3;
        Wed, 20 Sep 2023 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238109; x=1695842909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p8U90biBaY98m+/7YTgOwqeSiRSThvzebPVxAHZ0NU=;
        b=YU5zbwGKx/ICAPjZvijMNjTAiNNyrDSv8Z701ckije+DwAzWZbArwY0k/qtxfAI22k
         e+CJ8BBNqFJNjx9KwV4s8Vw+lH7ccWiwuRIsB2gD3YZnWW4YwwygwuhMkILVU8JaHTMz
         aH5Z0boQNbSXtnlS1gU8Knvi6TphsV8vKO89od6kjMT7bTldTbRpwFaglys5it5Uef2K
         SpzJvYpSl3UUsb6nq9svjRzqvyJKjLKDSflp3xoUZ0iQwtZ5xVr6z7LQUHb6PHqopyKv
         05TKkt+ElArn+CqxT4IiCoE2Vo42CgpO2iTNf+0DTUI4fX/SwDtW95roZQFqO7r8uv47
         PrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238109; x=1695842909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p8U90biBaY98m+/7YTgOwqeSiRSThvzebPVxAHZ0NU=;
        b=WmHUpH2yFZjPHE4BNisYO/yQPuP/s5M73HULW21qmg584wD2cfy5Chfugn7S3ReoJ1
         iDi1yphBInTQO3n2byr59nl6pWAAbvecxe//PPf/XGVwFjO6lvu08DrisFSdQ18lXh3L
         i5hCA2vWFLJjRyJBOJs0vHuKL1pnYk9rkRu/TGpQRsrWGQ2ai21pZM30PBlSNIvUxhJj
         R6HjUd9yEBUgeB6H+LplFt1YUN71io1bVGgucL9h/F80rvgOzkCUdZicdHURRehR5kfe
         fDEEcKCCD9BSwcjiCGwOgL1onq3audR51L1kH1GBcqOmrYmFP+npDyUDGaICbf+IwenR
         OZVg==
X-Gm-Message-State: AOJu0YyyORO3KutCPK7cIAHsych4cag2/n/JcGJx8RQB9WzZYgKwymkq
        hIY9ORzEQO9Aa+XpGZjqF5Y=
X-Google-Smtp-Source: AGHT+IGIdInnubjIeWh18A6utltiooTc5XhoZwMANbo8N+mo1k1GV2zYTk6K/MsLe6Nk9T2xrOWP9w==
X-Received: by 2002:a05:6512:3da7:b0:503:38ef:eb54 with SMTP id k39-20020a0565123da700b0050338efeb54mr4177670lfv.37.1695238109286;
        Wed, 20 Sep 2023 12:28:29 -0700 (PDT)
Received: from localhost ([83.149.21.189])
        by smtp.gmail.com with ESMTPSA id q26-20020a05651232ba00b0050307bf2bcdsm1933853lfe.247.2023.09.20.12.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:28 -0700 (PDT)
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
Subject: [PATCH v4 04/18] EDAC/synopsys: Detach private data from mci instance
Date:   Wed, 20 Sep 2023 22:26:49 +0300
Message-ID: <20230920192806.29960-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A comprehensive DW uMCTL2 DDRC parameters detection procedure and some
resources requests (clocks and resets) are about to be added to the
driver. Since these parameters will be utilized in the various parts of
the driver and in particular used for the Memory Controller data instance
pre-initialization, they need to be: first retrieved before the MCI is
allocated; second preserved in the driver private data. Therefore the best
approach would be to add the parameters structure right into the driver
private data and just allocate the data separately from the mem_ctl_info
instance. For that: add a new static method snps_data_create(), which
aside with the snps_edac_priv structure allocation will also perform the
private data basic initialization like CSRs region mapping, device data
getting, platform data pointer copying and spin-lock initialization;
convert the snps_mc_init() method to snps_mc_create(), which from now will
be used to allocate and initialize the mem_ctl_info structure instance.

Note in order to have an access to the snps_edac_priv structure instance
as before this change, the mem_ctl_info.pvt_info field will be initialized
with the pointer to that structure instance.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 137 +++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 47 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e08e9f3c81cb..e177a36646c0 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -242,6 +242,7 @@ struct snps_ecc_status {
 
 /**
  * struct snps_edac_priv - DDR memory controller private data.
+ * @pdev:		Platform device.
  * @baseaddr:		Base address of the DDR controller.
  * @reglock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
@@ -255,6 +256,7 @@ struct snps_ecc_status {
  * @rank_shift:		Bit shifts for rank bit.
  */
 struct snps_edac_priv {
+	struct platform_device *pdev;
 	void __iomem *baseaddr;
 	spinlock_t reglock;
 	char message[SNPS_EDAC_MSG_SIZE];
@@ -463,6 +465,34 @@ static irqreturn_t snps_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * snps_create_data - Create private data.
+ * @pdev:	platform device.
+ *
+ * Return: Private data instance or negative errno.
+ */
+static struct snps_edac_priv *snps_create_data(struct platform_device *pdev)
+{
+	struct snps_edac_priv *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->baseaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->baseaddr))
+		return ERR_CAST(priv->baseaddr);
+
+	priv->p_data = of_device_get_match_data(&pdev->dev);
+	if (!priv->p_data)
+		return ERR_PTR(-ENODEV);
+
+	priv->pdev = pdev;
+	spin_lock_init(&priv->reglock);
+
+	return priv;
+}
+
 /**
  * snps_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
@@ -594,18 +624,36 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 }
 
 /**
- * snps_mc_init - Initialize one driver instance.
- * @mci:	EDAC memory controller instance.
- * @pdev:	platform device.
+ * snps_mc_create - Create and initialize MC instance.
+ * @priv:	DDR memory controller private data.
+ *
+ * Allocate the EDAC memory controller descriptor and initialize it
+ * using the private data info.
  *
- * Perform initialization of the EDAC memory controller instance and
- * related driver-private data associated with the memory controller the
- * instance is bound to.
+ * Return: MC data instance or negative errno.
  */
-static void snps_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
+static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 {
-	mci->pdev = &pdev->dev;
-	platform_set_drvdata(pdev, mci);
+	struct edac_mc_layer layers[2];
+	struct mem_ctl_info *mci;
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = SNPS_EDAC_NR_CSROWS;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = SNPS_EDAC_NR_CHANS;
+	layers[1].is_virt_csrow = false;
+
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers, 0);
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed memory allocation for mc instance\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mci->pvt_info = priv;
+	mci->pdev = &priv->pdev->dev;
+	platform_set_drvdata(priv->pdev, mci);
 
 	/* Initialize controller capabilities and configuration */
 	mci->mtype_cap = MEM_FLAG_LPDDR | MEM_FLAG_DDR2 | MEM_FLAG_LPDDR2 |
@@ -625,24 +673,43 @@ static void snps_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	mci->ctl_page_to_phys = NULL;
 
 	snps_init_csrows(mci);
+
+	return mci;
 }
 
+/**
+ * snps_mc_free - Free MC instance.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Just revert what was done in the framework of the snps_mc_create().
+ *
+ * Return: MC data instance or negative errno.
+ */
+static void snps_mc_free(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+
+	platform_set_drvdata(priv->pdev, NULL);
 
+	edac_mc_free(mci);
+}
 
-static int snps_setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
+
+
+static int snps_setup_irq(struct mem_ctl_info *mci)
 {
 	struct snps_edac_priv *priv = mci->pvt_info;
 	int ret, irq;
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq(priv->pdev, 0);
 	if (irq < 0) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "No IRQ %d in DT\n", irq);
 		return irq;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, snps_irq_handler,
-			       0, dev_name(&pdev->dev), mci);
+	ret = devm_request_irq(&priv->pdev->dev, irq, snps_irq_handler,
+			       0, dev_name(&priv->pdev->dev), mci);
 	if (ret < 0) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
 		return ret;
@@ -1066,49 +1133,24 @@ static inline void snps_create_debugfs_nodes(struct mem_ctl_info *mci) {}
  */
 static int snps_mc_probe(struct platform_device *pdev)
 {
-	const struct snps_platform_data *p_data;
-	struct edac_mc_layer layers[2];
 	struct snps_edac_priv *priv;
 	struct mem_ctl_info *mci;
-	void __iomem *baseaddr;
 	int rc;
 
-	baseaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(baseaddr))
-		return PTR_ERR(baseaddr);
-
-	p_data = of_device_get_match_data(&pdev->dev);
-	if (!p_data)
-		return -ENODEV;
+	priv = snps_create_data(pdev);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
 	if (!snps_get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
 
-	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = SNPS_EDAC_NR_CSROWS;
-	layers[0].is_virt_csrow = true;
-	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = SNPS_EDAC_NR_CHANS;
-	layers[1].is_virt_csrow = false;
-
-	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
-			    sizeof(struct snps_edac_priv));
-	if (!mci) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "Failed memory allocation for mc instance\n");
-		return -ENOMEM;
-	}
-
-	priv = mci->pvt_info;
-	priv->baseaddr = baseaddr;
-	priv->p_data = p_data;
-	spin_lock_init(&priv->reglock);
+	mci = snps_mc_create(priv);
+	if (IS_ERR(mci))
+		return PTR_ERR(mci);
 
-	snps_mc_init(mci, pdev);
-
-	rc = snps_setup_irq(mci, pdev);
+	rc = snps_setup_irq(mci);
 	if (rc)
 		goto free_edac_mc;
 
@@ -1124,7 +1166,7 @@ static int snps_mc_probe(struct platform_device *pdev)
 	return 0;
 
 free_edac_mc:
-	edac_mc_free(mci);
+	snps_mc_free(mci);
 
 	return rc;
 }
@@ -1143,7 +1185,8 @@ static int snps_mc_remove(struct platform_device *pdev)
 	snps_disable_irq(priv);
 
 	edac_mc_del_mc(&pdev->dev);
-	edac_mc_free(mci);
+
+	snps_mc_free(mci);
 
 	return 0;
 }
-- 
2.41.0

