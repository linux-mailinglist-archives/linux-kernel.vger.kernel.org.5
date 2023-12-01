Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB257800E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379340AbjLAPO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379399AbjLAPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:14:52 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD85171F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:14:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so5768605ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443694; x=1702048494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tM3mSD6N99toh6Lxpzp3nqitrKgi3AWBJMN4NKcxwY=;
        b=S5v2iuq0paRROYnATkxyszRbyl0qI37bsf/seHcLz5zg9lO+DWKzcwdqldmYuc71wQ
         BOv5x9pwng6/+OsY3Cp+a5HBJj0FjQC8GsPq0kTZ8mPPKrfm/BkZl5B1BxCM/4etf67d
         u4qR+Ae0hnVqWT13DQN8Ryb3YbN3j4F+xv5hF5357iFOOIXf3K7g+87B6lc+RY+4wXAv
         BSQGLin7IZuA3LHk81ya2zJFOTtG1yk2LIYu0yQe+QICCkwAEWQ9qCzJwczl+D1bZafP
         H6hulE1eHrQV01DouYNqqXNG8mQoYwIHaZ2l+0yIf6SGOaWXBzf3R3To05P9PCeWeDYb
         oHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443694; x=1702048494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tM3mSD6N99toh6Lxpzp3nqitrKgi3AWBJMN4NKcxwY=;
        b=a3FCce19OMwEDZLGXkp4Sd5I9hsJmi00Mtsi7TaBXKQXeg8wgCu8KKEXMeQyN34/97
         VnC+okBFMQzuJg6AOgGTujdMVv7sDQrPHy1U9hHIKTh+Oi/A9Ozog+GefXvzRZHmPPVR
         zHjFMe2TzrEHeVrRLrPKwXdnk+WtBIdio8HmK1SUslNK9uM8cLFa9TcUDpuxO/oKogPk
         unLtVOgBwlLo6F5+zn+z64lM7rPl335rjh+Vr1xMi3AX/tI18Jf78UAB4uAd1rEXd0cb
         vllYcKerEc+CWBV7z7SfaFBW4U1pBAObXeVjChlzw2a2+WQTCJQ2F83H0X71VOokIBco
         bhvg==
X-Gm-Message-State: AOJu0YxTil7cj0WEf10DR/WJyQjCpKz7JhgtoTGSi7bZ8GXEz9UJX1uG
        8aJtm0TL/NNVel9/KCUMOHoT
X-Google-Smtp-Source: AGHT+IEvcSupiS55i7LRMCM1TM6DpAdYYQdvO+GsxJKs6TfD6+W1c+TV0iEwXWd6korXj6X6YAwZkQ==
X-Received: by 2002:a17:903:11c4:b0:1cc:4072:22c6 with SMTP id q4-20020a17090311c400b001cc407222c6mr29718775plh.24.1701443694468;
        Fri, 01 Dec 2023 07:14:54 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:14:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/13] scsi: ufs: qcom: Export ufshcd_{enable/disable}_irq helpers and make use of them
Date:   Fri,  1 Dec 2023 20:44:10 +0530
Message-Id: <20231201151417.65500-7-manivannan.sadhasivam@linaro.org>
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

Instead of duplicating the enable/disable IRQ part, let's export the
helpers available in ufshcd driver and make use of them. This also fixes
the possible redundant IRQ disable before asserting reset (when IRQ was
already disabled).

Fixes: 4a791574a0cc ("scsi: ufs: ufs-qcom: Disable interrupt in reset path")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd.c   | 6 ++++--
 drivers/ufs/host/ufs-qcom.c | 9 +++------
 include/ufs/ufshcd.h        | 2 ++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8b1031fb0a44..671facc73921 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -289,21 +289,23 @@ static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
 static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
 
-static inline void ufshcd_enable_irq(struct ufs_hba *hba)
+void ufshcd_enable_irq(struct ufs_hba *hba)
 {
 	if (!hba->is_irq_enabled) {
 		enable_irq(hba->irq);
 		hba->is_irq_enabled = true;
 	}
 }
+EXPORT_SYMBOL_GPL(ufshcd_enable_irq);
 
-static inline void ufshcd_disable_irq(struct ufs_hba *hba)
+void ufshcd_disable_irq(struct ufs_hba *hba)
 {
 	if (hba->is_irq_enabled) {
 		disable_irq(hba->irq);
 		hba->is_irq_enabled = false;
 	}
 }
+EXPORT_SYMBOL_GPL(ufshcd_disable_irq);
 
 static void ufshcd_configure_wb(struct ufs_hba *hba)
 {
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index d474de0739e4..604273a22afd 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -300,8 +300,7 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 		return 0;
 
 	reenable_intr = hba->is_irq_enabled;
-	disable_irq(hba->irq);
-	hba->is_irq_enabled = false;
+	ufshcd_disable_irq(hba);
 
 	ret = reset_control_assert(host->core_reset);
 	if (ret) {
@@ -324,10 +323,8 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 
 	usleep_range(1000, 1100);
 
-	if (reenable_intr) {
-		enable_irq(hba->irq);
-		hba->is_irq_enabled = true;
-	}
+	if (reenable_intr)
+		ufshcd_enable_irq(hba);
 
 	return 0;
 }
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7f0b2c5599cd..f1fc16ac6af2 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1231,6 +1231,8 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 	ufshcd_writel(hba, tmp, reg);
 }
 
+void ufshcd_enable_irq(struct ufs_hba *hba);
+void ufshcd_disable_irq(struct ufs_hba *hba);
 int ufshcd_alloc_host(struct device *, struct ufs_hba **);
 void ufshcd_dealloc_host(struct ufs_hba *);
 int ufshcd_hba_enable(struct ufs_hba *hba);
-- 
2.25.1

