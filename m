Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549AC769A13
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGaOuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjGaOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:50:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FDB1BC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:50:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so36502935ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690815043; x=1691419843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORkdSUboiT8QANjRcMWUstawFwsHxB8PmOCD2FE6rOU=;
        b=Tpxs9iTsmJkVJjfJuMGB90N1ogwlgVyJ9DLcP7HBjIH/E2wtMvsHutqXyArMbHMNDn
         JN9yqrTnSTq3804Q0naOZoIaPLQJkQpjuF2kRV9Jhpp0AdMarufAXhz9G98Pb24rsUv1
         yzNSiqFUwUgYKUUMqpAbMHN+dYMilFqxRUflU32/8HNopRr15sZo6X8AhbJxkovwYiak
         8XVd88CXAadmZotMQMPEfdIWVxCa31/pG0RjKnZkvjAbXG1ZMrXfocBLXHWae4+CZjXG
         KAYKSKugV2c43krnaWT+9HWhF33kKwlLUruC+xfQabcpAHyRapJPXbZ80ZMgK8TgZCZw
         dntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690815043; x=1691419843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORkdSUboiT8QANjRcMWUstawFwsHxB8PmOCD2FE6rOU=;
        b=V+IYBg46guY29NhbOBOiEwHhkdfxwjGBoFqrOrSD+LV6Znh7glwLnhyJvitd/Qzah0
         +SFX/o73mijEfUVo/3Q0T2bQ/AVY87svD6kmrJ9LMADOVArqCw9vLRuakor0yrHNDlb8
         NA66NvTk1OBioX4tTpwbb6VhFdzCl4JSTNbJIi4oyUdW/vKhdwAvjszR2haJMzB67mZb
         aymp3dMe9Mclv/tuAJmnRr1KuEp0EYvw4OyGNbwMxKLWqh0Dg/L/0pHn23DCA6bI0br0
         YfnUiaPTShAyI0xeglY2UgMADhVQ8TiJf4qsfDbohd+8jUyqYQLkhrJEB3QJckQCFnbu
         VGfQ==
X-Gm-Message-State: ABy/qLZUhkq2Ush6AibFTvzWrVhu/bGTnHmHVNGUqHRtORdomGCftD4x
        mSbD/+E+lPBOXfI+PCv9audy
X-Google-Smtp-Source: APBJJlHPC0AAoqyJNDvJijDAa7dATI3ejtagf3v1wKhGX6u8ghNI94wntjasu9HYIQU73LPhySdYHQ==
X-Received: by 2002:a17:902:e847:b0:1b8:b41a:d4be with SMTP id t7-20020a170902e84700b001b8b41ad4bemr12535286plg.10.1690815043085;
        Mon, 31 Jul 2023 07:50:43 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.129])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001b06c106844sm8730185plb.151.2023.07.31.07.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:50:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] scsi: ufs: core: Add enums for UFS lanes
Date:   Mon, 31 Jul 2023 20:20:19 +0530
Message-Id: <20230731145020.41262-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
References: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there are enums available for UFS gears, let's add enums for lanes
as well to maintain uniformity.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd.c        | 4 ++--
 drivers/ufs/host/ufshcd-pltfrm.c | 4 ++--
 include/ufs/unipro.h             | 6 ++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 90a7c817b7be..3839b58dc892 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4375,8 +4375,8 @@ static void ufshcd_init_pwr_info(struct ufs_hba *hba)
 {
 	hba->pwr_info.gear_rx = UFS_PWM_G1;
 	hba->pwr_info.gear_tx = UFS_PWM_G1;
-	hba->pwr_info.lane_rx = 1;
-	hba->pwr_info.lane_tx = 1;
+	hba->pwr_info.lane_rx = UFS_LANE_1;
+	hba->pwr_info.lane_tx = UFS_LANE_1;
 	hba->pwr_info.pwr_rx = SLOWAUTO_MODE;
 	hba->pwr_info.pwr_tx = SLOWAUTO_MODE;
 	hba->pwr_info.hs_rate = 0;
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index 0b7430033047..7005046e8a69 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -305,8 +305,8 @@ EXPORT_SYMBOL_GPL(ufshcd_get_pwr_dev_param);
 void ufshcd_init_pwr_dev_param(struct ufs_dev_params *dev_param)
 {
 	*dev_param = (struct ufs_dev_params){
-		.tx_lanes = 2,
-		.rx_lanes = 2,
+		.tx_lanes = UFS_LANE_2,
+		.rx_lanes = UFS_LANE_2,
 		.hs_rx_gear = UFS_HS_G3,
 		.hs_tx_gear = UFS_HS_G3,
 		.pwm_rx_gear = UFS_PWM_G4,
diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h
index dc9dd1d23f0f..256eb3a43f54 100644
--- a/include/ufs/unipro.h
+++ b/include/ufs/unipro.h
@@ -230,6 +230,12 @@ enum ufs_hs_gear_tag {
 	UFS_HS_G5		/* HS Gear 5 */
 };
 
+enum ufs_lanes {
+	UFS_LANE_DONT_CHANGE,	/* Don't change Lane */
+	UFS_LANE_1,		/* Lane 1 (default for reset) */
+	UFS_LANE_2,		/* Lane 2 */
+};
+
 enum ufs_unipro_ver {
 	UFS_UNIPRO_VER_RESERVED = 0,
 	UFS_UNIPRO_VER_1_40 = 1, /* UniPro version 1.40 */
-- 
2.25.1

