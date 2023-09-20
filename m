Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D627A8D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjITT6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjITT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0706F18D;
        Wed, 20 Sep 2023 12:58:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5041335fb9cso436336e87.0;
        Wed, 20 Sep 2023 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239881; x=1695844681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrRK5L9lpHhRENUQie0IeqI/zXBFLNMqTNeRQQ8QIwE=;
        b=iX6yqidyQGAmQyBIbmL96eDtHpbpgUFxR17b4YKtCoH0mKaSSdCgLIe0Kw/l2kAynk
         I2ezIckwVAgt98K3CqBiAHmaW+u5VmDAvUEQ+wHiptwyRqrrlpjkdlgY3NW9rZ+VfZgV
         nHMgNC43joUSdMqFV+XV9goYkz7xLDIjolWcATn/LfBUppU+8Ng7FD4dUdeTfN1rbYnD
         Iv+J117Z3Nzv3k6N5+PSaKKWCdw1+56ALm7UFesl/3pBMmH6eko4BBj+rydhnNogiu45
         Atm77kmD/CmYmKZ+g7ffRtLNrBcyVpacOm3DgwSe0c80e9aUGPSeoADmT6mioTw2NQH2
         FN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239881; x=1695844681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrRK5L9lpHhRENUQie0IeqI/zXBFLNMqTNeRQQ8QIwE=;
        b=tw2ZBXcbHkJVGRnpzmSm646bM18rlu+fjvOlMvzoXTAO1D7PtpvD57+ZrS27EUKqTj
         hbykxQooT+tucgKzw8sfU9ey0gstBZcWsQ7Zoi+hUMe7yVwrFnwf95/CnC45bjecWBpy
         EQTbiCFEDF7Q0WAAuppSyc+KtZ99SF19TB8Ks5g/Frz2aG6Rx7UhmaQWSwWbUs98oNwP
         /PVuMvwsvpp6QapDBXyNdJPjkv1NDeTI2xss47wgd9Opv/AMYlqYvxOjYem7QDWb1ra1
         XAPiUtCG/Ypguq8Qm/EydRA/0kKNi8tHSwmzblXbisFeTvFLy1pzWRAKblTBGhzdUEUS
         n7KQ==
X-Gm-Message-State: AOJu0YzTp7PtZ3aNfwC5OCFZchARx4hGu1zE/56X+aSnufBR17uiuW9Y
        ytRCoRFFQQLoX58nJTt6xTs=
X-Google-Smtp-Source: AGHT+IELcXzgoxksxSLl1fr+Cex+T1A7S5rgvsr0dgl6Bd0BggOW+N4wolbD3uQrQSzJrX/1RVX9ig==
X-Received: by 2002:ac2:5303:0:b0:503:221:6b1a with SMTP id c3-20020ac25303000000b0050302216b1amr3157801lfh.0.1695239880862;
        Wed, 20 Sep 2023 12:58:00 -0700 (PDT)
Received: from localhost ([178.176.86.251])
        by smtp.gmail.com with ESMTPSA id g10-20020a19ac0a000000b005032907710asm966347lfc.237.2023.09.20.12.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:58:00 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/13] EDAC/synopsys: Drop ECC poison address from private data
Date:   Wed, 20 Sep 2023 22:56:36 +0300
Message-ID: <20230920195720.32047-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the driver now has the generic Sys/SDRAM address translation
interface there is no need in preserving the poisonous address in the
driver private data especially seeing it is used in the framework of the
DebugFS node anyway. So drop the snps_edac_priv.poison_addr field
and just perform Sys/SDRAM back and forth address translation right in
place of the "inject_data_error" node accessors.

It causes a bit more modifications than a simple field removal. Since the
poisonous address is not preserved now there is no point in having the
snps_data_poison_setup() method so its content can be moved right into the
"inject_data_error" write operation. For the same reason there is no point
in printing the ECCPOISONADDR{0,1} registers content in the
"inject_data_error" read operation. Since the CSRs content is now parsed
anyway print the SDRAM address instead.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Fix inject_data_error string printing "Rank" word where "Col" is
  supposed to be.
---
 drivers/edac/synopsys_edac.c | 68 +++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 4ee39d6809cc..90640b2f877a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -411,7 +411,6 @@ struct snps_ecc_status {
  * @reglock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
- * @poison_addr:	Data poison address.
  */
 struct snps_edac_priv {
 	struct snps_ddrc_info info;
@@ -422,9 +421,6 @@ struct snps_edac_priv {
 	spinlock_t reglock;
 	char message[SNPS_EDAC_MSG_SIZE];
 	struct snps_ecc_status stat;
-#ifdef CONFIG_EDAC_DEBUG
-	ulong poison_addr;
-#endif
 };
 
 /**
@@ -1719,44 +1715,32 @@ static int snps_hif_sdram_map_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(snps_hif_sdram_map);
 
-/**
- * snps_data_poison_setup - Update poison registers.
- * @priv:		DDR memory controller private instance data.
- *
- * Update poison registers as per DDR mapping.
- * Return: none.
- */
-static void snps_data_poison_setup(struct snps_edac_priv *priv)
-{
-	struct snps_sdram_addr sdram;
-	u32 regval;
-
-	snps_map_sys_to_sdram(priv, priv->poison_addr, &sdram);
-
-	regval = FIELD_PREP(ECC_POISON0_RANK_MASK, sdram.rank) |
-		 FIELD_PREP(ECC_POISON0_COL_MASK, sdram.col);
-	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
-
-	regval = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, sdram.bankgrp) |
-		 FIELD_PREP(ECC_POISON1_BANK_MASK, sdram.bank) |
-		 FIELD_PREP(ECC_POISON1_ROW_MASK, sdram.row);
-	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
-}
-
 static ssize_t snps_inject_data_error_read(struct file *filep, char __user *ubuf,
 					   size_t size, loff_t *offp)
 {
 	struct mem_ctl_info *mci = filep->private_data;
 	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_sdram_addr sdram;
 	char buf[SNPS_DBGFS_BUF_LEN];
+	dma_addr_t sys;
+	u32 regval;
 	int pos;
 
-	pos = scnprintf(buf, sizeof(buf), "Poison0 Addr: 0x%08x\n\r",
-			readl(priv->baseaddr + ECC_POISON0_OFST));
-	pos += scnprintf(buf + pos, sizeof(buf) - pos, "Poison1 Addr: 0x%08x\n\r",
-			 readl(priv->baseaddr + ECC_POISON1_OFST));
-	pos += scnprintf(buf + pos, sizeof(buf) - pos, "Error injection Address: 0x%lx\n\r",
-			 priv->poison_addr);
+	regval = readl(priv->baseaddr + ECC_POISON0_OFST);
+	sdram.rank = FIELD_GET(ECC_POISON0_RANK_MASK, regval);
+	sdram.col = FIELD_GET(ECC_POISON0_COL_MASK, regval);
+
+	regval = readl(priv->baseaddr + ECC_POISON1_OFST);
+	sdram.bankgrp = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, regval);
+	sdram.bank = FIELD_PREP(ECC_POISON1_BANK_MASK, regval);
+	sdram.row = FIELD_PREP(ECC_POISON1_ROW_MASK, regval);
+
+	snps_map_sdram_to_sys(priv, &sdram, &sys);
+
+	pos = scnprintf(buf, sizeof(buf),
+			"%pad: Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu\n",
+			&sys, sdram.row, sdram.col, sdram.bank, sdram.bankgrp,
+			sdram.rank);
 
 	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
 }
@@ -1766,13 +1750,25 @@ static ssize_t snps_inject_data_error_write(struct file *filep, const char __use
 {
 	struct mem_ctl_info *mci = filep->private_data;
 	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_sdram_addr sdram;
+	u32 regval;
+	u64 sys;
 	int rc;
 
-	rc = kstrtoul_from_user(ubuf, size, 0, &priv->poison_addr);
+	rc = kstrtou64_from_user(ubuf, size, 0, &sys);
 	if (rc)
 		return rc;
 
-	snps_data_poison_setup(priv);
+	snps_map_sys_to_sdram(priv, sys, &sdram);
+
+	regval = FIELD_PREP(ECC_POISON0_RANK_MASK, sdram.rank) |
+		 FIELD_PREP(ECC_POISON0_COL_MASK, sdram.col);
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+
+	regval = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, sdram.bankgrp) |
+		 FIELD_PREP(ECC_POISON1_BANK_MASK, sdram.bank) |
+		 FIELD_PREP(ECC_POISON1_ROW_MASK, sdram.row);
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
 
 	return size;
 }
-- 
2.41.0

