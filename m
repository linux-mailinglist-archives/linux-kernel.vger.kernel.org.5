Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A447A8CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjITT3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjITT3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B6CCC;
        Wed, 20 Sep 2023 12:29:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-503065c4b25so364579e87.1;
        Wed, 20 Sep 2023 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238139; x=1695842939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqBb3j7kZv1svEf6sHTFvZChySF0UAHxjiT2Ls2Akek=;
        b=fJzisKqvYBK3m7qetj0q8ol2HcrJzV7Qmu0HYMbkAepxA5isVM2QCz4vOIbvVmiXy5
         9PKaMNhN1PSyFxCIhRxb+KyDldXoFpL6G1fXD4DifNRFgdKJQCBUH3u86ctK0zudKPf9
         at5rcBASP+iGWZvK0POAHpEpKNpHNaxzmnAuR7FB97isZgkTp720hX/ngoM7y/1WOuiA
         la/JWB4mP4J6TfBOp1Eg8qK2K3HxesE25/Cm3AgpImIafh/X5yt3GPdfjyNDMIg8QjJi
         Bxy6jN2qcdYNOeq8PJYh8P0bXh6Mulds/n3BKWHy+zXR/to5XxsWxFxmZe0RSu3nFEqN
         /TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238139; x=1695842939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqBb3j7kZv1svEf6sHTFvZChySF0UAHxjiT2Ls2Akek=;
        b=KW+5NbUfv18tfTD10BLyh1wICZPsAzveDDXsxnmp/j/sqs7lvoYIuVrt2+tqn/xdB2
         9RXPAE2i6ICG0sFtzx4M1SOiFXGp9dg/YEM8Wq5brtaaXF7+Nh9rj4mlby+o207iYLJC
         5ianqITm1sZ1BVDFJqKOJRIU2fN4nxQkVOCvN0k5PkTdSYZwTItIW8ObtmG4aQyvloh8
         2dE2EqKkqdE5FLuz/7V+s8BN1csEOUXXvGLOZx6bM53Tbs1r9nuw7SPiOl7V04MoOmtg
         +tUUaVqyLzaLz53MGORgPI7x3TXQ3AfmttWBVtcW/m4Wc5I2W1SwDot94NakubCWeNc9
         AXlg==
X-Gm-Message-State: AOJu0YzTp83yDY36oeR9UbBQQZJEvxWp1yPQx0p066BrIQe2Y/LNX9kM
        189CN2j228wnzLN2ApJDtcc=
X-Google-Smtp-Source: AGHT+IGR+wqT1IZCsN8BwpelDunWHlppDt+ckZw/f6gkalBZjyHHw9oeTt8SYJvf8EPjwOvyp2pgkQ==
X-Received: by 2002:ac2:4bd1:0:b0:503:3805:e902 with SMTP id o17-20020ac24bd1000000b005033805e902mr3479722lfq.30.1695238138594;
        Wed, 20 Sep 2023 12:28:58 -0700 (PDT)
Received: from localhost ([85.26.234.143])
        by smtp.gmail.com with ESMTPSA id d9-20020ac244c9000000b005007da9f823sm524439lfm.168.2023.09.20.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:58 -0700 (PDT)
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
Subject: [PATCH v4 12/18] EDAC/synopsys: Read full data+ecc pattern on errors
Date:   Wed, 20 Sep 2023 22:26:57 +0300
Message-ID: <20230920192806.29960-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

DW uMCTL2 DDRC calculates ECC for the Full DQ-bus word. If non-Full bus
width mode is activated the leftover DQ-bits will be padded with zeros,
but the ECC code is calculated for the whole width anyway [1]. For some
reason the DW uMCTL2 DDRC driver currently doesn't read the whole SDRAM
word in if ECC errors happens even though the 64-bits DQ-bus has been
supported for a long time. Moreover a Full ECC value is also available in
the ECC(C|U)SYN2 register. In a less than 64-bits DQ-bus setups the higher
ECC bits are just unused.

So update the errors handler to reading the entire data+ecc pattern:
extend the data field of the ECC error info structure since it may contain
64-bit data; add a new ECC field there since it's a part of the erroneous
data pattern; read the upper 32-bits part of the data pattern only if an
ECC error happens and the DDR controller has been configured with the
64-bits DQ bus; read the full ECC value from the ECC(C|U)SYN2 register.
The data+ecc couple will be printed as a part of the custom error message
passed then to the edac_mc_handle_error() method.

Note since the full data+ecc info is now always logged into the EDAC core
there is no longer need in the debug print of the Syndrome Registers
content. Drop it then.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.424-425

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Retrieve ECC too.
---
 drivers/edac/synopsys_edac.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index fbf1f8af9788..7376a0fc6394 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -305,6 +305,7 @@ struct snps_ddrc_info {
  * @syndrome:	Error syndrome.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
+ * @ecc:	Data ECC.
  */
 struct snps_ecc_error_info {
 	u32 row;
@@ -313,7 +314,8 @@ struct snps_ecc_error_info {
 	u32 bankgrp;
 	u32 syndrome;
 	u32 bitpos;
-	u32 data;
+	u64 data;
+	u32 ecc;
 };
 
 /**
@@ -422,10 +424,10 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	p->ceinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	if (priv->info.dq_width == SNPS_DQ_64)
+		p->ceinfo.data |= (u64)readl(base + ECC_CSYND1_OFST) << 32;
 
-	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
-		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
-		 readl(base + ECC_CSYND2_OFST));
+	p->ceinfo.ecc = readl(base + ECC_CSYND2_OFST);
 
 ue_err:
 	if (!p->ue_cnt)
@@ -440,6 +442,11 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	p->ueinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+	if (priv->info.dq_width == SNPS_DQ_64)
+		p->ueinfo.data |= (u64)readl(base + ECC_UESYND1_OFST) << 32;
+
+	p->ueinfo.ecc = readl(base + ECC_UESYND2_OFST);
+
 out:
 	spin_lock_irqsave(&priv->reglock, flags);
 
@@ -469,9 +476,9 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 		pinf = &p->ceinfo;
 
 		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
+			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08llx:0x%02x",
 			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
-			 pinf->bitpos, pinf->data);
+			 pinf->bitpos, pinf->data, pinf->ecc);
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, pinf->syndrome, 0, 0, -1,
@@ -482,8 +489,9 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 		pinf = &p->ueinfo;
 
 		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %d Col %d Bank %d Bank Group %d",
-			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
+			 "Row %d Col %d Bank %d Bank Group %d Data 0x%08llx:0x%02x",
+			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+			 pinf->data, pinf->ecc);
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
-- 
2.41.0

