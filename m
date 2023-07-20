Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880E75AA47
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjGTJAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGTItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:49:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40E7FD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:49:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e6541c98so450551b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689842948; x=1690447748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sBMJpDyItnzqWmy2aNUsMJagDM84bbHkArmMp29yfb8=;
        b=KW+xgangek+Of71GV6+78KS6bQhvicOfRIonYCazciiUjQ9FaZOGt3AAtgm9JVsY5P
         3D4oWw3iQ/qmIDRF2cHu8v1dRHlJFdzCwf3+RRT4l29uRWl93ibk5Krda+snkJdwpVD8
         97jYTKO73nksmbBHYrQjYY+2j7yj9T9MmcNvpmXacFWM1CCaK+WadKYTlanPv4aaCavq
         qS3nRVtLKkDwL0H6vnmk7EheGHlGoE67i4d/mBPw3ElH2FN34fBBGHX0in9OULLbqdME
         g6N6NU+50Ptse51XDMFwuj/4L8VQhd3dSoWZS9kk49ypJRdnmTJAJGNnNEjFeNY0N/5G
         tRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689842948; x=1690447748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBMJpDyItnzqWmy2aNUsMJagDM84bbHkArmMp29yfb8=;
        b=HXgbQ40evPYQKFI6CpqrmI7fjpxohSLMSHP0qstKj9pFrNOg1frqlpTqKFB69HPqDY
         bv0RrqlaqG9wrBr55lE31Sx2w9fVYeN+u0n9+M0Q7vFLnJF+bG3Wy3Ve0pXRFmPdSMCZ
         16GQL6xcAWVGIocjxKNSM5B5wjM/l82Rl0T32tbvSeZZ3BywQlagn6h0ufpXF80syDU6
         yjVEL83fVgY8uQCxhnCcJ3cjSVX7tYofaKqAiLYNEtnlKU46QLZIU3eMaKdQCiDng/lg
         zuzZT91uNHjq75X3UJrE+DZUqBnbIISOEymyanoHIFRqNRhgeOx+MKYLcyFwsaC7YAhc
         EGFQ==
X-Gm-Message-State: ABy/qLZRhMq3cAqi512VfYi8VmfOhfeMk/8PSTOU9LCqQSXsrOr27luh
        yN6gcIH6EdEFcInG3vH7uDPP
X-Google-Smtp-Source: APBJJlFIAqb3MRR0M7M6dUYduFnut83aN0mVypldnTsMftw0d3Itv+M+vqzqZFESpwa1wVIGfkJhrg==
X-Received: by 2002:a05:6a00:8ce:b0:63a:ea82:b7b7 with SMTP id s14-20020a056a0008ce00b0063aea82b7b7mr1962948pfu.28.1689842948427;
        Thu, 20 Jul 2023 01:49:08 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id k23-20020aa790d7000000b0068285a7f107sm613277pfk.177.2023.07.20.01.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 01:49:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PM / devfreq: Reword the kernel-doc comment for devfreq_monitor_start() API
Date:   Thu, 20 Jul 2023 14:18:54 +0530
Message-Id: <20230720084854.18975-1-manivannan.sadhasivam@linaro.org>
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

Current kernel-doc comment doesn't specify the default timer used for the
load monitoring. Also, it uses the term "default delayed work" which could
be misunderstood as "default delayer timer". So reword the comment to
clearly specify the default timer and also reword the last sentence to make
it more understandable.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/devfreq/devfreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7686993d639f..e2939c1b7d1f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -472,10 +472,11 @@ static void devfreq_monitor(struct work_struct *work)
  * devfreq_monitor_start() - Start load monitoring of devfreq instance
  * @devfreq:	the devfreq instance.
  *
- * Helper function for starting devfreq device load monitoring. By
- * default delayed work based monitoring is supported. Function
- * to be called from governor in response to DEVFREQ_GOV_START
- * event when device is added to devfreq framework.
+ * Helper function for starting devfreq device load monitoring. By default,
+ * deferrable timer is used for load monitoring. But the users can change this
+ * behavior using the "timer" type in devfreq_dev_profile. This function will be
+ * called by devfreq governor in response to the DEVFREQ_GOV_START event
+ * generated while adding a device to the devfreq framework.
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-- 
2.25.1

