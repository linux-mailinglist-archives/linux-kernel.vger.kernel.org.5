Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792BF771106
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjHERmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjHERmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:42:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1F5103
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:42:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso3005452b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691257333; x=1691862133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWgVvz/rSzQAaNBR+0GRt5Tgri/Am0g/0Utn1T92Y2Y=;
        b=spmuW2205c4AMxvmTZqta+KfpbmGiMADfX552zTgjqqhuoU5jB50Rvj6YA5huHCmxS
         Clj8Tc/0sYIjn8v3eOqz9XQ/ICo1AOxtgTjNwJn285MAh7sCg0B6/9qmkvNTKmqY31KM
         kF1ntOt634CLv/Qdwqiiwb2WbWP5MocBnkT7Hj96LUqUuSGE8g9FdfBT64hp5UemWICs
         uwVemBDY2CR9JB7S/JBkewlSzcg2alQG4DzmdXAuZQpoTdUqiYiHwIo2cw9fbXvyOaip
         vDDwiawt5foQ3dgQ2Och6bf1DoT/UDLHoj87uHzsYv/h3mQQcFlvkFrYqiB/E/U1Bb+m
         +0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691257333; x=1691862133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWgVvz/rSzQAaNBR+0GRt5Tgri/Am0g/0Utn1T92Y2Y=;
        b=D+CQyq2sjXT3HX/VpTVIIaUBSu+H1Ep3MbDBZ63ctodWb1l9EtBEyOSNCasFhQhDvg
         wrmEbwIvFeZVjMkL6B5kn4kK8WuVk8b7NxAN5Y/LuZKRRBsQa4OmIjQXYhD/sFemG2z2
         CKmfDbIHP4zEJl3NodY3uOTDeGMsw6dnOti7fzPveN2K7CagTxnZp/4+uvqsPRe68zXH
         a0B9nLCcFxqb77QVBsQVdeFnjmeELNs3e45q3id/eDd+qsjQAP73IMza8e4FowwAfjNS
         R6l1KuRXIDoxpjoh5U5tBZZiUZuZHycBGcpgV02M8ZVTtCI5NgxEUIP/J32H/xRiloh3
         14xg==
X-Gm-Message-State: AOJu0YwweCn5M9pLnWoA64nzJN0zB4OWt17F3bTXV5/yo6zXTkwDkBe0
        cL116M/zJ4/o4NSqWKdej9Hb
X-Google-Smtp-Source: AGHT+IElfmMvpoXzEv7T8xFD3V6MeRB4DjmbKf0fKAgK1eie9hb1tQx+4CUQdeE1PPVXG/iSNIBwXQ==
X-Received: by 2002:a05:6a20:1456:b0:13f:5234:24ce with SMTP id a22-20020a056a20145600b0013f523424cemr6875817pzi.28.1691257333498;
        Sat, 05 Aug 2023 10:42:13 -0700 (PDT)
Received: from localhost.localdomain ([103.28.246.21])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78b4e000000b006874a6850e9sm3363160pfd.215.2023.08.05.10.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 10:42:13 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 03/10] mtd: rawnand: qcom: Handle unsupported opcode in qcom_op_cmd_mapping()
Date:   Sat,  5 Aug 2023 23:11:39 +0530
Message-Id: <20230805174146.57006-4-manivannan.sadhasivam@linaro.org>
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

Handle the scenario where the caller has passed an unsupported opcode to
qcom_op_cmd_mapping(). In that case, log the error and return the
-EOPNOTSUPP errono. Also, let's propagate this error code all the way up.

This also fixes the following smatch warning:

drivers/mtd/nand/raw/qcom_nandc.c:2941 qcom_op_cmd_mapping() error: uninitialized symbol 'ret'.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202308032022.SnXkKyFs-lkp@intel.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 35 ++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index be428b80a39b..4957e9253878 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2585,20 +2585,23 @@ static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 opcode,
 		q_op->flag = OP_PROGRAM_PAGE;
 		nandc->exec_opwrite = true;
 		break;
+	default:
+		dev_err(nandc->dev, "Opcode not supported: %u\n", opcode);
+		return -EOPNOTSUPP;
 	}
 
 	return cmd;
 }
 
 /* NAND framework ->exec_op() hooks and related helpers */
-static void qcom_parse_instructions(struct nand_chip *chip,
+static int qcom_parse_instructions(struct nand_chip *chip,
 				    const struct nand_subop *subop,
 				    struct qcom_op *q_op)
 {
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	const struct nand_op_instr *instr = NULL;
 	unsigned int op_id;
-	int i;
+	int i, ret;
 
 	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
 		unsigned int offset, naddrs;
@@ -2608,7 +2611,11 @@ static void qcom_parse_instructions(struct nand_chip *chip,
 
 		switch (instr->type) {
 		case NAND_OP_CMD_INSTR:
-			q_op->cmd_reg = qcom_op_cmd_mapping(nandc, instr->ctx.cmd.opcode, q_op);
+			ret = qcom_op_cmd_mapping(nandc, instr->ctx.cmd.opcode, q_op);
+			if (ret < 0)
+				return ret;
+
+			q_op->cmd_reg = ret;
 			q_op->rdy_delay_ns = instr->delay_ns;
 			break;
 
@@ -2641,6 +2648,8 @@ static void qcom_parse_instructions(struct nand_chip *chip,
 			break;
 		}
 	}
+
+	return 0;
 }
 
 static void qcom_delay_ns(unsigned int ns)
@@ -2689,7 +2698,9 @@ static int qcom_read_status_exec(struct nand_chip *chip,
 
 	host->status = NAND_STATUS_READY | NAND_STATUS_WP;
 
-	qcom_parse_instructions(chip, subop, &q_op);
+	ret = qcom_parse_instructions(chip, subop, &q_op);
+	if (ret)
+		return ret;
 
 	num_cw = nandc->exec_opwrite ? ecc->steps : 1;
 	nandc->exec_opwrite = false;
@@ -2749,7 +2760,9 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	unsigned int len = 0;
 	int ret;
 
-	qcom_parse_instructions(chip, subop, &q_op);
+	ret = qcom_parse_instructions(chip, subop, &q_op);
+	if (ret)
+		return ret;
 
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
@@ -2797,7 +2810,9 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 	struct qcom_op q_op = {};
 	int ret;
 
-	qcom_parse_instructions(chip, subop, &q_op);
+	ret = qcom_parse_instructions(chip, subop, &q_op);
+	if (ret)
+		return ret;
 
 	if (q_op.flag == OP_PROGRAM_PAGE)
 		goto wait_rdy;
@@ -2843,7 +2858,9 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	unsigned int len = 0;
 	int ret;
 
-	qcom_parse_instructions(chip, subop, &q_op);
+	ret = qcom_parse_instructions(chip, subop, &q_op);
+	if (ret)
+		return ret;
 
 	q_op.cmd_reg |= PAGE_ACC | LAST_PAGE;
 
@@ -2937,7 +2954,9 @@ static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_su
 	struct qcom_op q_op = {};
 	int ret;
 
-	qcom_parse_instructions(chip, subop, &q_op);
+	ret = qcom_parse_instructions(chip, subop, &q_op);
+	if (ret)
+		return ret;
 
 	q_op.cmd_reg |= PAGE_ACC | LAST_PAGE;
 
-- 
2.25.1

