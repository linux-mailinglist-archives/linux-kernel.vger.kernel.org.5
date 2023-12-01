Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11B5800E54
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379394AbjLAPPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379428AbjLAPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:15:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7BE1725
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:15:06 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28648be0811so1447986a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443705; x=1702048505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s+dxOARPtmuDtxtrPmYWXFcx5QSwMABsj/xuwm0cfM=;
        b=a/WAEUWwXBU2IwTd/1lnStFpgCNRsM5snta4eqSqhLzBSBwpsjhVCyYVYV2lD/WBVS
         mbK/kKi8hhafFgki7Qke4VWPLBaLVImDjo6NBPn1bm3a1GvCkZ0+dXjGVHMVK+yz+ULe
         oYrdGfOX5MjAeEeT4kdwQP9lF1ejE8xyN2lHRc6ITB5fuWqYJepJip1GcRZ6r3sphNuX
         Qtzf+A6M6VkKAP2DtPIU5aln+GiDMb3JrCAeXSJU6d9i+kCdsm1ElijHkwoTVlLBuS/r
         FeoRBICXTsomzzFwdEpmQnGC+jZXB6VG2ejEmh3/xzob3O/wH+KPR86ty7Nt/YJjAb41
         cXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443705; x=1702048505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s+dxOARPtmuDtxtrPmYWXFcx5QSwMABsj/xuwm0cfM=;
        b=PPii7S7xsHFi0RphdrzuF2n/XIEMuDUo+3yP193nFRRS7Ky64xF42Kt9uyh5RrOe5Z
         uWo2bZ5lXI0Ysw1jTEoKiIGWnjtnkxXtWMBe8d2GD48TMsivoNbG3Rv98d1/zZIv5Jty
         snT/1jz2mo7OWnmu78+HUaEeVKfaY/e9VGBX4/02e27NgsskzFbprJ/0U4uBpubd/5rm
         Lfe/Rbgk3Ew3kQjQde59OMYTzvN6m9JqUwvciwDEt6A2clbcJHypZHLuxPTySmfIs1m/
         OmyBqiZ9GddEW4PAzhwailWweJA3qtYXBr6b/nswhPuIh4xctRD0YUON4GP4H72Gsn2b
         ygfg==
X-Gm-Message-State: AOJu0Yzr+5DUo60atWAOZ4+xA97RfvUKuFGF14whCzHjT2IcLTTsC8Lw
        g/0QdO1r2JR5rEMejAVG6m8l
X-Google-Smtp-Source: AGHT+IFvJZzkDlY46j20YHiJ2dxic5gDp8k5OB44MAkItevykW7t58SjWek1DweEF2vi9nrFLvLUYg==
X-Received: by 2002:a17:90b:1a8d:b0:285:81aa:aec0 with SMTP id ng13-20020a17090b1a8d00b0028581aaaec0mr26173302pjb.12.1701443705444;
        Fri, 01 Dec 2023 07:15:05 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:15:04 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/13] scsi: ufs: qcom: Remove redundant error print for devm_kzalloc() failure
Date:   Fri,  1 Dec 2023 20:44:13 +0530
Message-Id: <20231201151417.65500-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kzalloc() will itself print the error message on failure. So let's get
rid of the redundant error message in ufs_qcom_init().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index e4dd3777a4d4..218d22e1efce 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1107,10 +1107,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	struct ufs_clk_info *clki;
 
 	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		dev_err(dev, "%s: no memory for qcom ufs host\n", __func__);
+	if (!host)
 		return -ENOMEM;
-	}
 
 	/* Make a two way bind between the qcom host and the hba */
 	host->hba = hba;
-- 
2.25.1

