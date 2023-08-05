Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E380771103
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjHERmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjHERmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:42:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98852106
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:42:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686be3cbea0so2837331b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691257327; x=1691862127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzHoBg1aTtFdNgIFHIxm61nutJbPmolyU88qKYX8avE=;
        b=e1bZg3WPmbUxYy4tVUd2YabTZ8JXTzEPZRnA0bqC3L7uQXcn6U887EK3lAeNlDZyNC
         vQjEbD9X1fJLxuU5Zv/7ik4UhOHvvdSysx4b4cCOLfdSo9+IbFEQx/QDw9Zair9WhJyJ
         0pDNjZAmedfhhDhiC+hcnm6hLq+kf2Ma3ecnjHM/R6tfqcRftOpsw1bXYOrQVsOLJjas
         J4p85ACOLMtCOVfV3nW/3jAGe11uzBmQzbdlzmGs/O+TIpgy8SLk3TpWPKtYyvnk5v4d
         hkHTWzB5dWlbQWhRalHEGZghsjx5CPq/FKL3q4R5PtlvenwD61jnGfrZk9y6vn4kTYIG
         YIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691257327; x=1691862127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzHoBg1aTtFdNgIFHIxm61nutJbPmolyU88qKYX8avE=;
        b=IUpmAr2/ssv4DqMkrty4wXD7qXJN44iimQVyryKmnPbUL3EVTcWF/KX2pHlW4boycw
         Jln4S9s5YJ3nN79/l+mPgZQqWYk4oZh++L3mEkssjgA67ArMgxdt6hc3AAJid50Y7qHk
         OuQg7cC8SyKzKRwAtENRFV3+LVAUFZAYfzH/E1XFC2+J8kd+B9iZqN2IDVw1xKkaYnGM
         +qAFARhUtxkLYRlBr599+cTvRSPWEI5wqqTqXwyBVxZWAR0P3Kau7g6xjnEW/Fr9gsQd
         t1KsJSzT6/IbwhcMXxPELNq6KxIM9hWBFhP/NjXucb1e/Hj+u4rbEnRl5CdCROKZuNzH
         oQ+Q==
X-Gm-Message-State: AOJu0YybdgzlIdM+z4Nh5LxHJaJeOGQGMSHloj3unDioyPzXKgHO4Hqo
        bebPCX7h+qyuEy+yTgLd5p76
X-Google-Smtp-Source: AGHT+IEOiKPKt0ItAknA4l5B8LXP+gGY8RF1sPeFYB7R7juUVo86q4NWggmSxvfpHBmQc9/dyHihKQ==
X-Received: by 2002:a05:6a20:7fa3:b0:12f:d350:8a12 with SMTP id d35-20020a056a207fa300b0012fd3508a12mr4024851pzj.21.1691257326933;
        Sat, 05 Aug 2023 10:42:06 -0700 (PDT)
Received: from localhost.localdomain ([103.28.246.21])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78b4e000000b006874a6850e9sm3363160pfd.215.2023.08.05.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 10:42:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/10] mtd: rawnand: qcom: Remove superfluous initialization of "ret"
Date:   Sat,  5 Aug 2023 23:11:37 +0530
Message-Id: <20230805174146.57006-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230805174146.57006-1-manivannan.sadhasivam@linaro.org>
References: <20230805174146.57006-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all the cases, "ret" variable is assigned a value before returning it.
So there is no need to explicitly initialize it with 0.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b485d8517fce..b6751fb17587 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1554,7 +1554,7 @@ check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *cw_data_buf, *cw_oob_buf;
-	int cw, data_size, oob_size, ret = 0;
+	int cw, data_size, oob_size, ret;
 
 	if (!data_buf)
 		data_buf = nand_get_data_buf(chip);
@@ -2684,7 +2684,7 @@ static int qcom_read_status_exec(struct nand_chip *chip,
 	const struct nand_op_instr *instr = NULL;
 	unsigned int op_id = 0;
 	unsigned int len = 0;
-	int ret = 0, num_cw, i;
+	int ret, num_cw, i;
 	u32 flash_status;
 
 	host->status = NAND_STATUS_READY | NAND_STATUS_WP;
@@ -2747,7 +2747,7 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	const struct nand_op_instr *instr = NULL;
 	unsigned int op_id = 0;
 	unsigned int len = 0;
-	int ret = 0;
+	int ret;
 
 	qcom_parse_instructions(chip, subop, &q_op);
 
@@ -2795,7 +2795,7 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_op q_op = {};
-	int ret = 0;
+	int ret;
 
 	qcom_parse_instructions(chip, subop, &q_op);
 
@@ -2841,7 +2841,7 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	const struct nand_op_instr *instr = NULL;
 	unsigned int op_id = 0;
 	unsigned int len = 0;
-	int ret = 0;
+	int ret;
 
 	qcom_parse_instructions(chip, subop, &q_op);
 
@@ -2935,7 +2935,7 @@ static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_su
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct qcom_op q_op = {};
-	int ret = 0;
+	int ret;
 
 	qcom_parse_instructions(chip, subop, &q_op);
 
-- 
2.25.1

