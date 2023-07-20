Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6892975A5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGTFo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGTFo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:44:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ACA273B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:43:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8c81e36c0so2504455ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831797; x=1690436597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93rZVq+nQZbieDirfxMQeUUlun6XgrX6rWeshnX356E=;
        b=MzIhYsChG4GLU0KYjhZWwm/1noH7leAPerLHt9hDa7n632irnyZY6W8R11Kf8ZS0XW
         jD0T+VChMw4QKx6WxJM/A/NLLfw3CBzMbBTOYIPcMX61hyB8TvLoRbd5l4l3euD+H+lZ
         Xs9DmiDWTKkfkEDi0qZ2bkYFLKhyKihhF+FI2yucuGgntFZrWyO+wRcHHy9zGxJkBJIl
         HvJ8HH/HxXgAPBG8e7QQsUWPrD/XCYFlxVCTNCroKkLPCbgqgvh29U6ff0mIR7x3dyDw
         ChN4dktnQyv5yXOoufAPXdRwrS419DzlI9bxT1Bd5zR/XcHCCdJEsIGsTBzctSgtk1SL
         Ecdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831797; x=1690436597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93rZVq+nQZbieDirfxMQeUUlun6XgrX6rWeshnX356E=;
        b=B2WXBXwAfwYTVIBjChS1HlBRaEcElI3A5dTjDzd8qn6E9zZdB2BM+wKeV83O6JBHCM
         DvIZRFLzi9nZttki63Yc22fmLkz19yjndVGwrAhFQVxwWxXxXADHDqJeTF0Nn80tL/XB
         uOAbQfe+fjZSL6yHgNRgCKjHq7UhVbNXd5+fL0aMtnFwT88zgT1ruR4us3zDYtdaxG7f
         hjtNqnnry+g1H2eyuJG97pCZraMinymVyBv0rMuBG4SN8sPm3MYgbJZTV8P848ML7C2o
         c6T4h8Mrror9eeZxteIr0A0HoUMAj7l/Omn4W7k0sww77FwYiIZ/gcSVfe0m1ngCGdYm
         c2Eg==
X-Gm-Message-State: ABy/qLbLvbGI7PHyEarKCbfEw1G7bGckrHXQt27XM7Ex2bnPRncBRZ7j
        eHvAEK1e9ggq+UI7tHaG1gGH
X-Google-Smtp-Source: APBJJlG5iFdToW2qee+uHlZ3VICGz9vPK9xr5coHt1oYeKeXg86mG1bX6iFZw+OED8mrXCa8y2NHKA==
X-Received: by 2002:a17:903:41c7:b0:1b8:a720:f513 with SMTP id u7-20020a17090341c700b001b8a720f513mr1025062ple.30.1689831797590;
        Wed, 19 Jul 2023 22:43:17 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm263367pls.119.2023.07.19.22.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:43:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 14/15] scsi: ufs: core: Add enums for UFS lanes
Date:   Thu, 20 Jul 2023 11:10:59 +0530
Message-Id: <20230720054100.9940-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
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

Since there are enums available for UFS gears, let's add enums for lanes
as well to maintain uniformity.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd.c        | 4 ++--
 drivers/ufs/host/ufshcd-pltfrm.c | 4 ++--
 include/ufs/unipro.h             | 6 ++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6207afac729d..4496a23eaa83 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4447,8 +4447,8 @@ static void ufshcd_init_pwr_info(struct ufs_hba *hba)
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
index 068c22378c88..8d20cbb552aa 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -415,8 +415,8 @@ EXPORT_SYMBOL_GPL(ufshcd_get_pwr_dev_param);
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

