Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35648130A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573163AbjLNMzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573145AbjLNMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:55:37 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE88C113
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:55:43 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-425e58bd4c8so16487921cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702558543; x=1703163343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYvEigRoKhZbgGLuv/4wRFyGkLXXYVjXdCoJrdge4oY=;
        b=Sqi3qwLlbp9FeKdI8GmTTRhMRTWkZp9S19FW4xUBP6+ZaUbH1O+R0Lmo4ayjaOpsHr
         VlwnVZBNQCtyzgu/xLlxjmKZTnTyBUfmgRNsjwIhNTlsqDAtGt3oT+IemsSoXbWm+pxn
         xevbT7swASnyBLZBUQK6u+2QSjwpVNauCD3iJx0DxGwaDrbR0ehQ+7VEA2XPSI3+dQz9
         zMzpqNHStUnbBItYmEcghuBzlrQyweXyJYMoz2IaqrC3dXtlr2FeqExB5UmEMFzfF8kZ
         5zDHu9wOHsjNYkFUfDAmnsqg6Yma/H29Kx6zb9xhBIeLFnaMYYLUP/vv64xSwVpQ0eXd
         NFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558543; x=1703163343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYvEigRoKhZbgGLuv/4wRFyGkLXXYVjXdCoJrdge4oY=;
        b=uGKzJc4e9NgBGllQF50fhM14AVDa8z4OZ1l7Ss/Hr8n/bc9CvAtAdZ6+8IuhZeeBcT
         Ah9uYDI8/Tci5Ty3tpAonQ9VtP91TFsSVA7UBozot7YST4vHfCjyXCPAZhQi8ROKOdNi
         iZJh/UrcYS01QQTbwF5NwLOYcYppoTJFUiz8JaLBx4av91idu8kCcUrNGa786tIpG3/L
         Umov9X0nPtxgTl68ODH0nCBSrlyXTscsMmxQ9mEOS063eUwf2/04ORQ5Fn2/4WM4tcby
         BCQcLgpvJiDF9N3p8B7/joy47I3u7RkWK8wFSdFun2f75ruKh+0YF3wY1qAYxnyDCnhN
         XjPg==
X-Gm-Message-State: AOJu0Yxkcn1cpvJZNtbMXTwnALYhuMaYze1QbxwIQS6N5YFdg7SGU6kn
        NV/C3tb6qsXM39OoQ6e/uUXZ
X-Google-Smtp-Source: AGHT+IEy7mhPx0wsyEsM+VLjF3KlKQ6SL9f68/1wLMmcgtKQD6pj0h3a0IGYh27ImtTH/GZ7DXYtFw==
X-Received: by 2002:ac8:5fce:0:b0:423:77aa:163b with SMTP id k14-20020ac85fce000000b0042377aa163bmr11944057qta.51.1702558542823;
        Thu, 14 Dec 2023 04:55:42 -0800 (PST)
Received: from localhost.localdomain ([117.216.120.87])
        by smtp.gmail.com with ESMTPSA id hj1-20020a05622a620100b0042601b60861sm302377qtb.26.2023.12.14.04.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:55:42 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] scsi: ufs: qcom: Fix ESI vector mask
Date:   Thu, 14 Dec 2023 18:25:32 +0530
Message-Id: <20231214125532.55109-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

While cleaning up the code to use ufshcd_rmwl() helper, the ESI vector mask
was changed incorrectly. Fix it and also define a proper macro for the
value together with FIELD_PREP().

Reported-by: Andrew Halaney <ahalaney@redhat.com>
Fixes: 0e9f4375db1c ("scsi: ufs: qcom: Use ufshcd_rmwl() where applicable")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 4 +++-
 drivers/ufs/host/ufs-qcom.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index d5cca5d3a98f..9fd8d737edea 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1744,7 +1744,9 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	} else {
 		if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
 		    host->hw_ver.step == 0)
-			ufshcd_rmwl(hba, ESI_VEC_MASK, 0x1f00, REG_UFS_CFG3);
+			ufshcd_rmwl(hba, ESI_VEC_MASK,
+				    FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
+				    REG_UFS_CFG3);
 		ufshcd_mcq_enable_esi(hba);
 	}
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 9026fe243307..9dd9a391ebb7 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -15,6 +15,7 @@
 #define HBRN8_POLL_TOUT_MS      100
 #define DEFAULT_CLK_RATE_HZ     1000000
 #define MAX_SUPP_MAC		64
+#define MAX_ESI_VEC		32
 
 #define UFS_HW_VER_MAJOR_MASK	GENMASK(31, 28)
 #define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)

base-commit: ed340d13aa1db6773667ed4bf907738df203fbda
-- 
2.25.1

