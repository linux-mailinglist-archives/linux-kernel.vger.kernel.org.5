Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95BD7ADC22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjIYPro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjIYPrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEBB124
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40537481094so65803465e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656837; x=1696261637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNmLk2/hMJ8q4cG9CX8+EYjM5qVrNntkoJGG0Zi7eVo=;
        b=tkRp68MZGtH6RuRjKcpHuWJkmu0XPN6+Y2oY/Z2vVyiT4lydyv2t65NM7i30bKYfSV
         KlotrCHwERtfcwzbFyRR607PzukfgcJRtMLLfWaHaBYKAAFc+Z3aBUS2udvSZW7ktg6a
         nAGacDaZekEdMMbNBdwkVw4t25v2uqv9YiEUxeskd0Wl/MlNYftHITYik7QAglOyj8Sv
         56KRjcklwj80UWL3oknZazeNmvCwSrvEQVjbpZ8fuYwZ3LkZgDVmHDNW2GSBgCxrCC2S
         jkxMkoupboMa46lawZUieMz3If+9dnybG9nLbsvsiwPagZ6dDn33GdM8PmYyu2Vhz2sO
         sqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656837; x=1696261637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNmLk2/hMJ8q4cG9CX8+EYjM5qVrNntkoJGG0Zi7eVo=;
        b=BO4umrUpLrxPxINZccXBHjy4YNVDoZycp65UB0EBGB7ZBOO3Yc4logMKnDiqRSHO6x
         ICvevGby2GrEyNY5y3TtcrTjz69XS8SAtRKjYjJ3z9hl5q2zi9Cj/Cq7tu7NMZNF81jI
         ocPpAxaIkaAk4HSBmRp/puGztTnErywQe1nt20Yq71KI5Sm1qGB+7iHvwD39+ZRXvhun
         QQzlengt14xzcSWdq0zi59gm6iZMwO9sM9dhUCCF0VzPYwC6hQFe+MXX8YwLJKrcHBoH
         oofZCBqk6FgoAN9kP/VFaOghAq1LHeV04FTgK8HAw5bd1e+2Hnd9ZPhFRXykGqHaWXCm
         J69w==
X-Gm-Message-State: AOJu0YwWOkMxO7ywio25iPDymDrhQVhmvfvSpBPOdb/Pv4iOX7O2mzDi
        +KWsRwTNIljx/OtMIUm1xLek2w==
X-Google-Smtp-Source: AGHT+IHRkaU3W48QquIkOqiMmSx2ZuuMyUCsStorj5wNGllICkXj0jgwAf9R6BttedGne+1BdUkRtQ==
X-Received: by 2002:a05:600c:21cb:b0:402:8896:bb7b with SMTP id x11-20020a05600c21cb00b004028896bb7bmr6230722wmj.6.1695656837529;
        Mon, 25 Sep 2023 08:47:17 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:16 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 06/17] media: qcom: camss: Pass line_num from compat resources
Date:   Mon, 25 Sep 2023 16:46:56 +0100
Message-ID: <20230925154707.837542-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
References: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

line_num indicates the number of RDI - raw data interface channels which
are associated with a given IFE/VFE - image/video front end.

On several SoCs the RDI number is not static for each VFE - for example
on sm8250 VFE Lite has four RDIs where regular VFE has three.

Assigning line_num statically in the subdev_init() phase initialises
each VFE to the lower number, meaning in practical terms that we are
lobbing off one RDI on some VFEs.

Interrupt handling uses static for (i = RDI0; i < RDI2; i++) {} in some
of our VFE blocks but this can't work for situations where we have a
mixture of VFE @ 3 RDI and VFE-lite @ 4 RDI blocks.

First step to remediate is to pass line_num from a compat string
controlled data-structure and do so on a per-VFE basis.

Later patches will assign the correct number of RDI blocks per VFE.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../media/platform/qcom/camss/camss-vfe-170.c |  2 --
 .../media/platform/qcom/camss/camss-vfe-4-1.c |  2 --
 .../media/platform/qcom/camss/camss-vfe-4-7.c |  2 --
 .../media/platform/qcom/camss/camss-vfe-4-8.c |  2 --
 .../media/platform/qcom/camss/camss-vfe-480.c |  1 -
 drivers/media/platform/qcom/camss/camss-vfe.c |  5 +++
 drivers/media/platform/qcom/camss/camss.c     | 36 ++++++++++++-------
 drivers/media/platform/qcom/camss/camss.h     |  1 +
 8 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 82d2392022dd1..2ba7160b3bd1e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -753,8 +753,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 {
 	vfe->isr_ops = vfe_isr_ops_170;
 	vfe->video_ops = vfe_video_ops_170;
-
-	vfe->line_num = VFE_LINE_NUM_GEN2;
 }
 
 const struct vfe_hw_ops vfe_ops_170 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index bc309f326f519..2911e4126e7ad 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -992,8 +992,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 	vfe->isr_ops = vfe_isr_ops_gen1;
 	vfe->ops_gen1 = &vfe_ops_gen1_4_1;
 	vfe->video_ops = vfe_video_ops_gen1;
-
-	vfe->line_num = VFE_LINE_NUM_GEN1;
 }
 
 const struct vfe_hw_ops vfe_ops_4_1 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index 8acd76c9746ba..b65ed0fef595e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -1188,8 +1188,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 	vfe->isr_ops = vfe_isr_ops_gen1;
 	vfe->ops_gen1 = &vfe_ops_gen1_4_7;
 	vfe->video_ops = vfe_video_ops_gen1;
-
-	vfe->line_num = VFE_LINE_NUM_GEN1;
 }
 
 const struct vfe_hw_ops vfe_ops_4_7 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
index 3a0167ecf873a..7b3805177f037 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -1173,8 +1173,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 	vfe->isr_ops = vfe_isr_ops_gen1;
 	vfe->ops_gen1 = &vfe_ops_gen1_4_8;
 	vfe->video_ops = vfe_video_ops_gen1;
-
-	vfe->line_num = VFE_LINE_NUM_GEN1;
 }
 
 const struct vfe_hw_ops vfe_ops_4_8 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index 074fa4e38163e..43a2964121f22 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -569,7 +569,6 @@ static const struct camss_video_ops vfe_video_ops_480 = {
 static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 {
 	vfe->video_ops = vfe_video_ops_480;
-	vfe->line_num = MAX_VFE_OUTPUT_LINES;
 }
 
 const struct vfe_hw_ops vfe_ops_480 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 94ee7c7039eb3..f381c82f1f877 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1305,6 +1305,11 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	default:
 		return -EINVAL;
 	}
+
+	if (!res->line_num)
+		return -EINVAL;
+
+	vfe->line_num = res->line_num;
 	vfe->ops->subdev_init(dev, vfe);
 
 	/* Memory */
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index d1152a7db9cd2..54886a2a449b0 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -123,7 +123,8 @@ static const struct camss_subdev_resources vfe_res_8x16[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	}
 };
 
@@ -263,7 +264,8 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	},
 
 	/* VFE1 */
@@ -281,7 +283,8 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe1" },
-		.interrupt = { "vfe1" }
+		.interrupt = { "vfe1" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	}
 };
 
@@ -442,7 +445,8 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	},
 
 	/* VFE1 */
@@ -463,7 +467,8 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe1" },
-		.interrupt = { "vfe1" }
+		.interrupt = { "vfe1" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	}
 };
 
@@ -621,7 +626,8 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 19200000, 75000000, 384000000, 538666667 },
 				{ 384000000 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = VFE_LINE_NUM_GEN2,
 	},
 
 	/* VFE1 */
@@ -641,7 +647,8 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 19200000, 75000000, 384000000, 538666667 },
 				{ 384000000 } },
 		.reg = { "vfe1" },
-		.interrupt = { "vfe1" }
+		.interrupt = { "vfe1" },
+		.line_num = VFE_LINE_NUM_GEN2,
 	},
 
 	/* VFE-lite */
@@ -660,7 +667,8 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 19200000, 75000000, 384000000, 538666667 },
 				{ 384000000 } },
 		.reg = { "vfe_lite" },
-		.interrupt = { "vfe_lite" }
+		.interrupt = { "vfe_lite" },
+		.line_num = VFE_LINE_NUM_GEN2,
 	}
 };
 
@@ -787,7 +795,8 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = 4,
 	},
 	/* VFE1 */
 	{
@@ -805,7 +814,8 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe1" },
-		.interrupt = { "vfe1" }
+		.interrupt = { "vfe1" },
+		.line_num = 4,
 	},
 	/* VFE2 (lite) */
 	{
@@ -822,7 +832,8 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 400000000, 480000000 },
 				{ 0 } },
 		.reg = { "vfe_lite0" },
-		.interrupt = { "vfe_lite0" }
+		.interrupt = { "vfe_lite0" },
+		.line_num = 4,
 	},
 	/* VFE3 (lite) */
 	{
@@ -839,7 +850,8 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 400000000, 480000000 },
 				{ 0 } },
 		.reg = { "vfe_lite1" },
-		.interrupt = { "vfe_lite1" }
+		.interrupt = { "vfe_lite1" },
+		.line_num = 4,
 	},
 };
 
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 3b6562b515d46..fc02aa84a5dd7 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -48,6 +48,7 @@ struct camss_subdev_resources {
 	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
 	char *reg[CAMSS_RES_MAX];
 	char *interrupt[CAMSS_RES_MAX];
+	u8 line_num;
 };
 
 struct icc_bw_tbl {
-- 
2.42.0

