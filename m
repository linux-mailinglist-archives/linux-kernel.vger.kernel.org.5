Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457BA771102
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjHERmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjHERmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:42:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA0194
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:42:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68706b39c4cso2161382b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691257330; x=1691862130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXEH8Wa3ojD+esCQhV22he8Pc5JwMdbmIGFKAtqq3lU=;
        b=i9tbqf5TzsxdR8yFifphKZWnrPl1Ckv74LxFEHOMpMMvv5kdJzVDtoDtExAZ7t0N9t
         KzG638x7INF+Mac7aTRK4k7wN2umrVA+od63KF/I/lzeYFvljlGw64ocISCIS3r2OxqU
         nZAjyQ2VCY15S2Va+1eFSMG3rK0RbgmLaFC6VJLxa9rODoISrce5p32Kr4G1cn85p6Qi
         8twOkwW0nP5ucMoTQ59lLnVlpkxHcIHdLd3FseL8GOWelgkX3m7jrUKqdPWMMkrakER+
         vlUgPoF/zCoAbcvoiUdWHiNlMnFtN33kkQarBJtlyWG/av+eu8MN5H6qne6JGZb0ElWK
         F0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691257330; x=1691862130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXEH8Wa3ojD+esCQhV22he8Pc5JwMdbmIGFKAtqq3lU=;
        b=E7uSLVRttr67lGDX9wD5m+sv7uRZCzVungwRQTTfg5EQqOsNGF2dFQzptOhK9yTdth
         Gunp+IwUKNBoluaHtp/v3YTV4FEzMOegUTZqG6ufIngA2Yp44Xg4Vp9UepFCVKL3ifv8
         bL4ZUxNp/N0dBSdOI1zywdCLKZnVJ3tFCps4vFkrrOrnGgiXqscUB/V8KDrTbF3uO+th
         sJ4LRVaIBqwU/xS1/buHTFq9db6pl+A9IJmYpTRGlZOyksCpqvd1C0BERNr/OIrGtbyJ
         WzwSOmG1eoDAa65FB7fkEmOOPSd27v7nE3gZIEknoNoNZBiU27Op50fXDnq8q1vUQVNd
         WzGQ==
X-Gm-Message-State: AOJu0YxBg8wVkYuGw22Znpg/oEZQYhO86xppdlpNE6pWnTGLXhXOtxvU
        XZl7niPnNyDsO2aBJOvz+Atc
X-Google-Smtp-Source: AGHT+IEQZKy6eZ9zB73Nlmrdh8OA6cfrfr262pAHVYOI+3rkx6/lhGQc0+CoG0aVyM/nTPlKCjypgA==
X-Received: by 2002:a05:6a00:1501:b0:675:ef91:7922 with SMTP id q1-20020a056a00150100b00675ef917922mr4571732pfu.4.1691257330155;
        Sat, 05 Aug 2023 10:42:10 -0700 (PDT)
Received: from localhost.localdomain ([103.28.246.21])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78b4e000000b006874a6850e9sm3363160pfd.215.2023.08.05.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 10:42:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 02/10] mtd: rawnand: qcom: Rename variables in qcom_op_cmd_mapping()
Date:   Sat,  5 Aug 2023 23:11:38 +0530
Message-Id: <20230805174146.57006-3-manivannan.sadhasivam@linaro.org>
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

qcom_op_cmd_mapping() function accepts opcode and returns the corresponding
command register. So let's rename the local variables and parameters to
reflect the same.

Reported-by: Miquel Raynal <miquel.raynal@bootlin.com>
Closes: https://lore.kernel.org/all/20230804190750.3367a044@xps-13/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b6751fb17587..be428b80a39b 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2555,39 +2555,39 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 	return 0;
 }
 
-static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cmd,
+static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 opcode,
 			       struct qcom_op *q_op)
 {
-	int ret;
+	int cmd;
 
-	switch (cmd) {
+	switch (opcode) {
 	case NAND_CMD_RESET:
-		ret = OP_RESET_DEVICE;
+		cmd = OP_RESET_DEVICE;
 		break;
 	case NAND_CMD_READID:
-		ret = OP_FETCH_ID;
+		cmd = OP_FETCH_ID;
 		break;
 	case NAND_CMD_PARAM:
 		if (nandc->props->qpic_v2)
-			ret = OP_PAGE_READ_ONFI_READ;
+			cmd = OP_PAGE_READ_ONFI_READ;
 		else
-			ret = OP_PAGE_READ;
+			cmd = OP_PAGE_READ;
 		break;
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
-		ret = OP_BLOCK_ERASE;
+		cmd = OP_BLOCK_ERASE;
 		break;
 	case NAND_CMD_STATUS:
-		ret = OP_CHECK_STATUS;
+		cmd = OP_CHECK_STATUS;
 		break;
 	case NAND_CMD_PAGEPROG:
-		ret = OP_PROGRAM_PAGE;
+		cmd = OP_PROGRAM_PAGE;
 		q_op->flag = OP_PROGRAM_PAGE;
 		nandc->exec_opwrite = true;
 		break;
 	}
 
-	return ret;
+	return cmd;
 }
 
 /* NAND framework ->exec_op() hooks and related helpers */
-- 
2.25.1

