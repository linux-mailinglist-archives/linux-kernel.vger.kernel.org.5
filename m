Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB78800E55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379459AbjLAPPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379423AbjLAPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:15:13 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B6F19A5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:15:12 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso1915117b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443712; x=1702048512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbyUrAaftLH0a6pAoGx1Rl9IDQRbi9vKE/mvsuJjc8A=;
        b=civyD6qH10xgCdwlR5Oza3I6Aj2gy3qnQUJ9hL/6XcV5kOwyBNzfgfkEe/rH07/1m6
         MFcwdNVNHLk8GTXrR/4xLPULHMnQlHp1kWfHlq1iKNUCHkNtMdPIavZOogvaFJ9PsFG7
         8EXiO143NHCzdEGEnsH8vxnl88bSdQhErJfpvEwhOL60Nb9hqLmDatULZEqCgLRI4dtm
         qspGlc3059J9XcGhduZ8xcX3onfKyElk8R+n1pweNJ8U74OjRXJTzRLVNxaBLKYKgeqf
         aOrJSMo9NjbduC87IZkZp6OMwen+cdtU8PuaVZ1uQjAiPd/sIls0yz7RFI9ewPux/TZI
         ZjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443712; x=1702048512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbyUrAaftLH0a6pAoGx1Rl9IDQRbi9vKE/mvsuJjc8A=;
        b=ledSuFt0wxa7tL+PI0q2JDCmWCDdWYCrPaIK0Fizf3FS6sBW2td1aAEb5f3xNHUpF4
         P0tJdBMjY5DrWq5LuLxmfgemr8YF2xopCSgvENgdf4yAPoZhOCKedzo/Vs7AId9n4F11
         +PUxywQz2ug1da3zE8qxtK1Xa3W3no+I5E37wtc/NUGdaYpt/jTkDRNMI1OIEO2/RTrY
         dXl4Tft9SiA2aAqDajhahO0fsyMLlZpXfddxFpnfAT9UJEKMnANI2/r3v26ccSXQFM2X
         qHumnED8K3QnIQXb9t5AcJ32h9IIDFyYJNyQc2ykilo6njDsHhvf4BT3WvpRaRWIReLV
         6amg==
X-Gm-Message-State: AOJu0YzGHLBiHsp1o6Ol++sijos5n4c31sRGJXCGL4kvWZAuT/Zo334K
        cb9p32/qsXkHRyizgCduubHm
X-Google-Smtp-Source: AGHT+IFuCo2HXUNTDZ89i3ZUB/xN8N1lk9JFjN5kV2JC6maA9HXjbyuOLP1pqtskP+HahJYnCrsHJw==
X-Received: by 2002:a05:6a21:7891:b0:18b:950d:de3b with SMTP id bf17-20020a056a21789100b0018b950dde3bmr31394907pzc.38.1701443712159;
        Fri, 01 Dec 2023 07:15:12 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:15:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/13] scsi: ufs: qcom: Remove unused ufs_qcom_hosts struct array
Date:   Fri,  1 Dec 2023 20:44:15 +0530
Message-Id: <20231201151417.65500-12-manivannan.sadhasivam@linaro.org>
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

ufs_qcom_hosts array is assigned, but not used anywhere. So let's remove
it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index a86f6620abc8..824c006be093 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -90,8 +90,6 @@ static const struct __ufs_qcom_bw_table {
 	[MODE_MAX][0][0]		    = { 7643136,	307200 },
 };
 
-static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
-
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
 static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up);
 
@@ -1192,9 +1190,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 
 	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
 
-	if (hba->dev->id < MAX_UFS_QCOM_HOSTS)
-		ufs_qcom_hosts[hba->dev->id] = host;
-
 	ufs_qcom_get_default_testbus_cfg(host);
 	err = ufs_qcom_testbus_config(host);
 	if (err)
-- 
2.25.1

