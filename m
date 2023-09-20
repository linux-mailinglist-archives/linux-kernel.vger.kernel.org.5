Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69E17A8CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjITT2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjITT2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3CFE6;
        Wed, 20 Sep 2023 12:28:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50300141a64so447877e87.0;
        Wed, 20 Sep 2023 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238101; x=1695842901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slA2GCsU+M93cytZBZ/cPNG/4Z+l1JlZLJUZAsah/2M=;
        b=XLsawXZMEqnncaPl7LJzYzIBdWiaF1/WpNYwNa8fjHKuNn7ofvDXg2dpxqJeXqChz4
         Yu3RKtliN+O4iYvPoKh0VESxNnUVJZk0I+YBdw1+tk/udaI/Q8EMZGwOii87B80FyoM/
         f44/dxX6ClOYZ38d0aG5RyeVFdvw2KD0KHchQWwKAngeaQmujx9KaDyzxw+6jCHooNo0
         Gsvyiytad4kdzY+lsgVqAweB/bnhjUlujAEvHUAesIqP3BQeD182UbYHZQ2BzosVu0Cu
         xIKVJCMP28G4aKWH65WnKFax37e+zEyh58/Y87+Usz1Tl4FewNNSHaC8GhXasuZFOCQu
         ZxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238101; x=1695842901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slA2GCsU+M93cytZBZ/cPNG/4Z+l1JlZLJUZAsah/2M=;
        b=moU4GMz38a+Se5Tzj6MqGglT9L9ht6Xw1vi6IxUyQhFhtDexQx+xCIpzS2Sgt75CPK
         dcA4FkuqhMIJSTdLNBUzAq5NUB71SPSSWvwwXSWL8pPFFWuPjdwfI46bqth0Q9Mw5OQW
         TrJzM8nt+pB9gMLb1YupvfSIm8DeRLC0B+v9urimCmAxRN5aJrwNp/MBSshZLRNB4XlY
         GoInPPQSBVoYqLZpHBFaH9NgBsYs210jF1xWJUeMlZPqZ2hW/qsbCXrHEiLlNzbH9c4j
         2Qs0qvt4Q303AHDErCEfLPKcNZ7gXhmZz6vQwQCkuUg8gS+td52Lv+MRBaSKYVykEb35
         WYjw==
X-Gm-Message-State: AOJu0YzlQsYI7F7X/tSK+5cQP1y2tFj4JdqAGXxm7DPgDA5D82OUbAuG
        C61ZZ/uuZe967YSRI4PNztk=
X-Google-Smtp-Source: AGHT+IF+ObWvzYHZ8zlMxC7DoVW4y5G1q84HHE1PKwiFaw5asqnXFJ+fr0nnN/Rho8M8vEajlLTXNg==
X-Received: by 2002:a19:6905:0:b0:502:adbb:f9db with SMTP id e5-20020a196905000000b00502adbbf9dbmr2142896lfc.65.1695238100510;
        Wed, 20 Sep 2023 12:28:20 -0700 (PDT)
Received: from localhost ([85.26.234.143])
        by smtp.gmail.com with ESMTPSA id v22-20020ac25596000000b005041a71237asm339716lfg.111.2023.09.20.12.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:19 -0700 (PDT)
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
Subject: [PATCH v4 01/18] EDAC/synopsys: Convert sysfs nodes to debugfs ones
Date:   Wed, 20 Sep 2023 22:26:46 +0300
Message-ID: <20230920192806.29960-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DW uMCTL2 DDRC EDAC driver supports creating two sysfs nodes:
"inject_data_error" and "inject_data_poison". First of them is responsible
for setting the error-injecting physical address up. The second one is
supposed to be used to enable the hardware capability of the correctable
and uncorrectable errors injection. The semantics of these nodes is pure
debug. They are even created only if the EDAC_DEBUG kernel config is
enabled. Thus there is no point in having these nodes exported in the
sysfs especially seeing they aren't listed in the sysfs ABI. Just move
them to the device private directory in DebugFS.

While at it move the address map initialization procedure call to the
DebugFS nodes creating function (it's useless with no DebugFS nodes being
available anyway) and create an empty snps_create_debugfs_nodes() method
in case if the EDAC_DEBUG config is disabled. Thus the DW uMCTL2 DDRC EDAC
probe procedure will get to be a bit simpler and redundant work won't be
performed.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 221 +++++++++++++++++++----------------
 1 file changed, 122 insertions(+), 99 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 327023e35d42..10716f365c6f 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/edac.h>
+#include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -641,6 +642,16 @@ static int snps_setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev
 
 #ifdef CONFIG_EDAC_DEBUG
 
+#define SNPS_DEBUGFS_FOPS(__name, __read, __write) \
+	static const struct file_operations __name = {	\
+		.owner = THIS_MODULE,		\
+		.open = simple_open,		\
+		.read = __read,			\
+		.write = __write,		\
+	}
+
+#define SNPS_DBGFS_BUF_LEN 128
+
 /**
  * snps_data_poison_setup - Update poison registers.
  * @priv:		DDR memory controller private instance data.
@@ -701,90 +712,6 @@ static void snps_data_poison_setup(struct snps_edac_priv *priv)
 	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
 }
 
-static ssize_t inject_data_error_show(struct device *dev,
-				      struct device_attribute *mattr,
-				      char *data)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct snps_edac_priv *priv = mci->pvt_info;
-
-	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
-			"Error injection Address: 0x%lx\n\r",
-			readl(priv->baseaddr + ECC_POISON0_OFST),
-			readl(priv->baseaddr + ECC_POISON1_OFST),
-			priv->poison_addr);
-}
-
-static ssize_t inject_data_error_store(struct device *dev,
-				       struct device_attribute *mattr,
-				       const char *data, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct snps_edac_priv *priv = mci->pvt_info;
-
-	if (kstrtoul(data, 0, &priv->poison_addr))
-		return -EINVAL;
-
-	snps_data_poison_setup(priv);
-
-	return count;
-}
-
-static ssize_t inject_data_poison_show(struct device *dev,
-				       struct device_attribute *mattr,
-				       char *data)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct snps_edac_priv *priv = mci->pvt_info;
-	const char *errstr;
-	u32 regval;
-
-	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
-	errstr = FIELD_GET(ECC_CEPOISON_MASK, regval) == ECC_CEPOISON_MASK ?
-		 "Correctable Error" : "UnCorrectable Error";
-
-	return sprintf(data, "Data Poisoning: %s\n\r", errstr);
-}
-
-static ssize_t inject_data_poison_store(struct device *dev,
-					struct device_attribute *mattr,
-					const char *data, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct snps_edac_priv *priv = mci->pvt_info;
-
-	writel(0, priv->baseaddr + DDR_SWCTL);
-	if (strncmp(data, "CE", 2) == 0)
-		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
-	else
-		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
-	writel(1, priv->baseaddr + DDR_SWCTL);
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(inject_data_error);
-static DEVICE_ATTR_RW(inject_data_poison);
-
-static int snps_create_sysfs_attributes(struct mem_ctl_info *mci)
-{
-	int rc;
-
-	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
-	if (rc < 0)
-		return rc;
-	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
-	if (rc < 0)
-		return rc;
-	return 0;
-}
-
-static void snps_remove_sysfs_attributes(struct mem_ctl_info *mci)
-{
-	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
-	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
-}
-
 static void snps_setup_row_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	u32 addrmap_row_b2_10;
@@ -1005,7 +932,115 @@ static void snps_setup_address_map(struct snps_edac_priv *priv)
 
 	snps_setup_rank_address_map(priv, addrmap);
 }
-#endif /* CONFIG_EDAC_DEBUG */
+
+static ssize_t snps_inject_data_error_read(struct file *filep, char __user *ubuf,
+					   size_t size, loff_t *offp)
+{
+	struct mem_ctl_info *mci = filep->private_data;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	char buf[SNPS_DBGFS_BUF_LEN];
+	int pos;
+
+	pos = scnprintf(buf, sizeof(buf), "Poison0 Addr: 0x%08x\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST));
+	pos += scnprintf(buf + pos, sizeof(buf) - pos, "Poison1 Addr: 0x%08x\n\r",
+			 readl(priv->baseaddr + ECC_POISON1_OFST));
+	pos += scnprintf(buf + pos, sizeof(buf) - pos, "Error injection Address: 0x%lx\n\r",
+			 priv->poison_addr);
+
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+}
+
+static ssize_t snps_inject_data_error_write(struct file *filep, const char __user *ubuf,
+					    size_t size, loff_t *offp)
+{
+	struct mem_ctl_info *mci = filep->private_data;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	int rc;
+
+	rc = kstrtoul_from_user(ubuf, size, 0, &priv->poison_addr);
+	if (rc)
+		return rc;
+
+	snps_data_poison_setup(priv);
+
+	return size;
+}
+
+SNPS_DEBUGFS_FOPS(snps_inject_data_error, snps_inject_data_error_read,
+		  snps_inject_data_error_write);
+
+static ssize_t snps_inject_data_poison_read(struct file *filep, char __user *ubuf,
+					    size_t size, loff_t *offp)
+{
+	struct mem_ctl_info *mci = filep->private_data;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	char buf[SNPS_DBGFS_BUF_LEN];
+	const char *errstr;
+	u32 regval;
+	int pos;
+
+	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
+	errstr = FIELD_GET(ECC_CEPOISON_MASK, regval) == ECC_CEPOISON_MASK ?
+		 "Correctable Error" : "UnCorrectable Error";
+
+	pos = scnprintf(buf, sizeof(buf), "Data Poisoning: %s\n\r", errstr);
+
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+}
+
+static ssize_t snps_inject_data_poison_write(struct file *filep, const char __user *ubuf,
+					     size_t size, loff_t *offp)
+{
+	struct mem_ctl_info *mci = filep->private_data;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	char buf[SNPS_DBGFS_BUF_LEN];
+	int rc;
+
+	rc = simple_write_to_buffer(buf, sizeof(buf), offp, ubuf, size);
+	if (rc < 0)
+		return rc;
+
+	writel(0, priv->baseaddr + DDR_SWCTL);
+	if (strncmp(buf, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDR_SWCTL);
+
+	return size;
+}
+
+SNPS_DEBUGFS_FOPS(snps_inject_data_poison, snps_inject_data_poison_read,
+		  snps_inject_data_poison_write);
+
+/**
+ * snps_create_debugfs_nodes -	Create DebugFS nodes.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Create DW uMCTL2 EDAC driver DebugFS nodes in the device private
+ * DebugFS directory.
+ *
+ * Return: none.
+ */
+static void snps_create_debugfs_nodes(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+
+	snps_setup_address_map(priv);
+
+	edac_debugfs_create_file("inject_data_error", 0600, mci->debugfs, mci,
+				 &snps_inject_data_error);
+
+	edac_debugfs_create_file("inject_data_poison", 0600, mci->debugfs, mci,
+				 &snps_inject_data_poison);
+}
+
+#else /* !CONFIG_EDAC_DEBUG */
+
+static inline void snps_create_debugfs_nodes(struct mem_ctl_info *mci) {}
+
+#endif /* !CONFIG_EDAC_DEBUG */
 
 /**
  * snps_mc_probe - Check controller and bind driver.
@@ -1071,17 +1106,9 @@ static int snps_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
-#ifdef CONFIG_EDAC_DEBUG
-	rc = snps_create_sysfs_attributes(mci);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_MC, "Failed to create sysfs entries\n");
-		goto free_edac_mc;
-	}
+	snps_create_debugfs_nodes(mci);
 
-	snps_setup_address_map(priv);
-#endif
-
-	return rc;
+	return 0;
 
 free_edac_mc:
 	edac_mc_free(mci);
@@ -1102,10 +1129,6 @@ static int snps_mc_remove(struct platform_device *pdev)
 
 	snps_disable_irq(priv);
 
-#ifdef CONFIG_EDAC_DEBUG
-	snps_remove_sysfs_attributes(mci);
-#endif
-
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 
-- 
2.41.0

