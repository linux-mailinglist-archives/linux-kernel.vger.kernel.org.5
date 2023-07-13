Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4127527FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjGMQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjGMQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:04:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EC11BD;
        Thu, 13 Jul 2023 09:04:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6831e80080dso610242b3a.0;
        Thu, 13 Jul 2023 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689264261; x=1691856261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=taEVHdr4pvzKgtMuMloJCVX65jKf8PA7Mk4Tb/kjNxM=;
        b=bVms6k0kLQPKpGIUp87YvXL8ObnejcptYGbmbArU5sybguU8wHbbIpbkgZ5rEIo/J4
         MggVkhBOdtN/AeQjFMu+IsI3plCHVlI+/yooJwP7hbJUeOUYoSVQ8y8CQ8o62wqQSDbH
         T5GQug/dApqm8iqBMuw9JMD6saPEm9BysoC0i2s8UZgoMU7GhzGPCZNiczn3c4Di/xJ5
         p8HLnt+iOwhbkpeGjfSqSZhR6FeFdHezTNgYUgaVCkq15fMJpj6m+amZ7t74nZOTsbxq
         9bZ/jj0/+isTiz0U7swoi2THLMbTI+EfApJbSPT07DVpWOPrOs9fCg9TIt4Y0gRdgslp
         sIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689264261; x=1691856261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taEVHdr4pvzKgtMuMloJCVX65jKf8PA7Mk4Tb/kjNxM=;
        b=MiRWHV9cooQONDw6mrzmxIULuTPWdpzOBULNjbXoL8OIzGA3M26w40rSje9zLtDNXA
         1IG5kOL2VTMBCinZNuGpBBJxYo6nDCH9OCiMXzLbsfqM4NKMPZyrWfMd1p3xa2XjgFnA
         d9gjhf2RV1wdc0ODyrPpDRhd850XLPJFkW7u46Q0/OfqDH9Uxpp+K7qFLn9pJOe3e2v3
         TgqqtZDxNzeuQNEXwIsIlNMbv2xMqU7NG09q6199CQVVeX7ddvmWNNEXljyqI3zml3i+
         XNbHDuGxP9aHc1B4h5zoMmaFhCSlyJ4Q2UsfJu9OEK8gBfoDgIOzB7Ze4IgsH2mmEp/a
         r/tQ==
X-Gm-Message-State: ABy/qLausL4e2L0RDw+1DOvZIwKE6C/aJceBtp1uyN5J5nPt2LXweHQd
        +CH07tuTVVkelFZ0TRNRT5E=
X-Google-Smtp-Source: APBJJlFfZLXTk3oWzVqZgL8g5tVQdslc3vl2eiC/uLxmUp888yqA47AW26dr67p04hypxfEh0x+qXw==
X-Received: by 2002:a05:6a20:3206:b0:131:4d40:3c9d with SMTP id hl6-20020a056a20320600b001314d403c9dmr1311135pzc.9.1689264261277;
        Thu, 13 Jul 2023 09:04:21 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-70-13.dynamic-ip.hinet.net. [36.228.70.13])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78757000000b0067a1f4f4f7dsm5610837pfo.169.2023.07.13.09.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:04:20 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/tsens: make tsens_xxxx_nvmem static
Date:   Fri, 14 Jul 2023 00:04:14 +0800
Message-Id: <20230713160415.149381-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sparse warnings:

drivers/thermal/qcom/tsens-v1.c:24:40: sparse: warning: symbol 'tsens_qcs404_nvmem' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v0_1.c:26:40: sparse: warning: symbol 'tsens_8916_nvmem' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v0_1.c:42:40: sparse: warning: symbol 'tsens_8974_nvmem' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v0_1.c:64:40: sparse: warning: symbol 'tsens_8974_backup_nvmem' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 6 +++---
 drivers/thermal/qcom/tsens-v1.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index a941b4241b0a..87c09f62ee81 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -23,7 +23,7 @@
 
 #define BIT_APPEND		0x3
 
-struct tsens_legacy_calibration_format tsens_8916_nvmem = {
+static struct tsens_legacy_calibration_format tsens_8916_nvmem = {
 	.base_len = 7,
 	.base_shift = 3,
 	.sp_len = 5,
@@ -39,7 +39,7 @@ struct tsens_legacy_calibration_format tsens_8916_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_8974_nvmem = {
+static struct tsens_legacy_calibration_format tsens_8974_nvmem = {
 	.base_len = 8,
 	.base_shift = 2,
 	.sp_len = 6,
@@ -61,7 +61,7 @@ struct tsens_legacy_calibration_format tsens_8974_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_8974_backup_nvmem = {
+static struct tsens_legacy_calibration_format tsens_8974_backup_nvmem = {
 	.base_len = 8,
 	.base_shift = 2,
 	.sp_len = 6,
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 51322430f1fe..dc1c4ae2d8b0 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -21,7 +21,7 @@
 #define TM_HIGH_LOW_INT_STATUS_OFF		0x0088
 #define TM_HIGH_LOW_Sn_INT_THRESHOLD_OFF	0x0090
 
-struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
+static struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
 	.base_len = 8,
 	.base_shift = 2,
 	.sp_len = 6,
-- 
2.34.1

