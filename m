Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059FC800E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379427AbjLAPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379488AbjLAPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:15:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF8D1BF3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:15:19 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cde4aeea29so1897578b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443719; x=1702048519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99jwCtueYKuqHSnO06pq+vanF2UHvfzCABwBvmt41SY=;
        b=dqpTXmDoXE6wytJPhm2PCBQfp/5HV7AtqtFuSibrn7aUkYe89B32Er6GSctfWsodS3
         5adNy7vLCG/+vARD/4JbpdWTFJb8JGike3Oa9YjC3A18kQ5paNKCktHOGIWb5SY8rFdx
         hYwMu2edywVkLpgNa1FYcalgADmyGnWCieRxbjpkzNO96Q+qqi7AxLB3HcbyhJup1WKe
         9nAw/W4/BGMt8cMwavX5YXBQo2jeXN1wMH7Jxa/8X88R7KKhsq0gpmNI97pOpt2IC8lo
         ZdXDc5tnZxdwXd1Aekcl8X9VjzPKXRjDe60PRrzGBVhNdZUMd4PmmlSipE1Tu7p1+FCc
         po+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443719; x=1702048519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99jwCtueYKuqHSnO06pq+vanF2UHvfzCABwBvmt41SY=;
        b=YRcOBAh4wYT/VPi++LBEYd1xu95/WtzV18yrNBV6w3C3HqmNx3w9bQk2h/PoDIq+E8
         AWBuPumvmqgbRPfXaSoHccgx/LtvS26qlwz6cVadgNciVfBh+77DvqQDPHhzl4hGxqkG
         lZIESNgIVvFI40axaIzbgWOY4aSUWoXKZ4bWBgSb8oOtREVsw7AmaBUQWqHMNfKCV/3p
         DxhqWUoYBwcoMRkMqTz0iB9iGeh1yug5D3pXG0onh6JDSn3qJUEaMyfS5J6gI1Rcb9Ee
         GOhikrCzayVNvzEAdzJDBtfJ2H9cdc/ojxsJa5ZrJ4YX7L1xaV7RKsJFe1f1poytQMf1
         N5/Q==
X-Gm-Message-State: AOJu0YyjUEHxp2Akn1wlgPURAAyfcTy4TZ531LuwDoR6yjX3ZVeR0srD
        v0cFGiITukZ+bIQNaphbKxr3
X-Google-Smtp-Source: AGHT+IG0lDGObraHLt0PSday0c1vddh/0X4DzkGcDUEtJFQ4rieNhf2pWlFV1r7BSDu6rIgWhh5OOA==
X-Received: by 2002:a05:6a00:938d:b0:6cd:faa6:fc36 with SMTP id ka13-20020a056a00938d00b006cdfaa6fc36mr3968638pfb.30.1701443718764;
        Fri, 01 Dec 2023 07:15:18 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:15:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/13] scsi: ufs: qcom: Initialize cycles_in_1us variable in ufs_qcom_set_core_clk_ctrl()
Date:   Fri,  1 Dec 2023 20:44:17 +0530
Message-Id: <20231201151417.65500-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the "core_clk_unipro" clock is not provided, "cycles_in_1us"
variable will be used as uninitialized. So initialize it with 0.

Issue reported by Smatch tool:

drivers/ufs/host/ufs-qcom.c:1336 ufs_qcom_set_core_clk_ctrl() error: uninitialized symbol 'cycles_in_1us'.
drivers/ufs/host/ufs-qcom.c:1341 ufs_qcom_set_core_clk_ctrl() error: uninitialized symbol 'cycles_in_1us'.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 590a2c67cf7d..208543a62d43 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1296,7 +1296,7 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct list_head *head = &hba->clk_list_head;
 	struct ufs_clk_info *clki;
-	u32 cycles_in_1us;
+	u32 cycles_in_1us = 0;
 	u32 core_clk_ctrl_reg;
 	int err;
 
-- 
2.25.1

