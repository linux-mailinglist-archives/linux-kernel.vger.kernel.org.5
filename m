Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BCB7ADBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjIYPmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjIYPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:41:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C5E121
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40537481094so65651125e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656481; x=1696261281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wmbicm6J4n1g5d7DX/duVuL47dLgNvi79FpU0w8H5SU=;
        b=NRm4fSnpFvDsW6Jr4rdUTjcAbGd6JikwA7/d1fPaninn7NujAvYtG6Fsz4e1Mq/qj6
         +K8phIvpghzi2M7yEo/3MeU2eUgXWItsR+awdDAToRFvcWyfYnQ1EHLYkoPDeDIuCXlt
         BYpcBGuCChGGySE1Xhm/CBEvOBDslowxmWT90SMYK4TrnqQCmyLJHJLtki2dJuI8Z7SA
         iIy4LwUw6TVZ6W38EaoYrfs1r7ATeDVb7bpBEDQ7yP7t68LcKRGvwoqlhkXFMnv+MkBb
         xxqA8rBEFgdewdCR9PzSlANQQ5aUPFi9letPWvTCiQrHlTudGwpbscbTQtCSpM9vMUzu
         ZFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656481; x=1696261281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wmbicm6J4n1g5d7DX/duVuL47dLgNvi79FpU0w8H5SU=;
        b=At4Bp4txJTmvYTLd9Zo/zf+JYn8wGaV08Y/qPD+zoOY7b3W3PWmdeUAZyY6PmFsDvl
         UNjSheQtQhtUyfNUzCFuT1upYYtW09vsayCR/NLYcBhmp8r4DBA+Y7/tjxujOp/qHSwF
         hv24lcfjbdTPDb9X8Z6lHnV9HMSPhuNtkUY8rJ1Wt2VFJzSvZOuw7gAm47a4SjYOf1zD
         3SWHJb2BkhPpsF36h3y6d+oI04CCE8zc/28z/igSAbTpNehM+BWJQq2gaptkeYH3XoeS
         4tvJDx3wCJI7vgst+qyd3KU8ZLg/gCuRYbbIN5gif6jhnxJO/Lgv12aJ/x+SwE7DIHhP
         r83A==
X-Gm-Message-State: AOJu0YzpFIvf+NPPlPMtrIIIJSRAO26UgbrjlKduQsjD1b9KdI1DvC19
        QaFVt6qX19Tb5PGIRQsWn2a6dA==
X-Google-Smtp-Source: AGHT+IF4ffHYCajHItB+Zw7hQT5FtPY9YqWIsQFL95yZYD+1glIwj3Rn2s56PTVcvtmlBMqtnT9j7g==
X-Received: by 2002:a7b:c8ca:0:b0:404:72fe:ed5c with SMTP id f10-20020a7bc8ca000000b0040472feed5cmr6057883wml.29.1695656481495;
        Mon, 25 Sep 2023 08:41:21 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bca4f000000b003fe4548188bsm15206155wml.48.2023.09.25.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:41:21 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6 15/17] media: qcom: camss: Move vfe_disable into a common routine where applicable
Date:   Mon, 25 Sep 2023 16:40:57 +0100
Message-ID: <20230925154059.837152-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
References: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
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

We can move vfe_disable() into a common routine in the core VFE file
provided we make wm_stop() a VFE specific callback.

The callback is required to capture the case where VFE 17x currently isn't
VC enabled where as VFE 480 is.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-vfe-170.c | 40 +------------------
 .../media/platform/qcom/camss/camss-vfe-480.c | 40 +------------------
 drivers/media/platform/qcom/camss/camss-vfe.c | 39 ++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.h |  9 +++++
 4 files changed, 50 insertions(+), 78 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index a5aa799501861..0b211fed12760 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -494,22 +494,6 @@ static int vfe_enable_output(struct vfe_line *line)
 	return 0;
 }
 
-static void vfe_disable_output(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-	struct vfe_output *output = &line->output;
-	unsigned long flags;
-	unsigned int i;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-	for (i = 0; i < output->wm_num; i++)
-		vfe_wm_stop(vfe, output->wm_idx[i]);
-	output->gen2.active_num = 0;
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	vfe_reset(vfe);
-}
-
 /*
  * vfe_enable - Enable streaming on VFE line
  * @line: VFE line
@@ -555,29 +539,6 @@ static int vfe_enable(struct vfe_line *line)
 	return ret;
 }
 
-/*
- * vfe_disable - Disable streaming on VFE line
- * @line: VFE line
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_disable(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-
-	vfe_disable_output(line);
-
-	vfe_put_output(line);
-
-	mutex_lock(&vfe->stream_lock);
-
-	vfe->stream_count--;
-
-	mutex_unlock(&vfe->stream_lock);
-
-	return 0;
-}
-
 /*
  * vfe_isr_sof - Process start of frame interrupt
  * @vfe: VFE Device
@@ -770,4 +731,5 @@ const struct vfe_hw_ops vfe_ops_170 = {
 	.vfe_enable = vfe_enable,
 	.vfe_halt = vfe_halt,
 	.violation_read = vfe_violation_read,
+	.vfe_wm_stop = vfe_wm_stop,
 };
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index 43a2964121f22..f2368b77fc6d6 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -327,22 +327,6 @@ static int vfe_enable_output(struct vfe_line *line)
 	return 0;
 }
 
-static void vfe_disable_output(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-	struct vfe_output *output = &line->output;
-	unsigned long flags;
-	unsigned int i;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-	for (i = 0; i < output->wm_num; i++)
-		vfe_wm_stop(vfe, output->wm_idx[i]);
-	output->gen2.active_num = 0;
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	vfe_reset(vfe);
-}
-
 /*
  * vfe_enable - Enable streaming on VFE line
  * @line: VFE line
@@ -390,29 +374,6 @@ static int vfe_enable(struct vfe_line *line)
 	return ret;
 }
 
-/*
- * vfe_disable - Disable streaming on VFE line
- * @line: VFE line
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_disable(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-
-	vfe_disable_output(line);
-
-	vfe_put_output(line);
-
-	mutex_lock(&vfe->stream_lock);
-
-	vfe->stream_count--;
-
-	mutex_unlock(&vfe->stream_lock);
-
-	return 0;
-}
-
 /*
  * vfe_isr_reg_update - Process reg update interrupt
  * @vfe: VFE Device
@@ -581,4 +542,5 @@ const struct vfe_hw_ops vfe_ops_480 = {
 	.vfe_disable = vfe_disable,
 	.vfe_enable = vfe_enable,
 	.vfe_halt = vfe_halt,
+	.vfe_wm_stop = vfe_wm_stop,
 };
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 4db0d0a1c6a51..b3d5af7f09690 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -410,6 +410,45 @@ int vfe_put_output(struct vfe_line *line)
 	return 0;
 }
 
+static int vfe_disable_output(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	struct vfe_output *output = &line->output;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+	for (i = 0; i < output->wm_num; i++)
+		vfe->ops->vfe_wm_stop(vfe, output->wm_idx[i]);
+	output->gen2.active_num = 0;
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return vfe_reset(vfe);
+}
+
+/*
+ * vfe_disable - Disable streaming on VFE line
+ * @line: VFE line
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int vfe_disable(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+
+	vfe_disable_output(line);
+
+	vfe_put_output(line);
+
+	mutex_lock(&vfe->stream_lock);
+
+	vfe->stream_count--;
+
+	mutex_unlock(&vfe->stream_lock);
+
+	return 0;
+}
+
 /**
  * vfe_isr_comp_done() - Process composite image done interrupt
  * @vfe: VFE Device
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index 4783afa73a365..09baded0dcdd6 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -114,6 +114,7 @@ struct vfe_hw_ops {
 	int (*vfe_enable)(struct vfe_line *line);
 	int (*vfe_halt)(struct vfe_device *vfe);
 	void (*violation_read)(struct vfe_device *vfe);
+	void (*vfe_wm_stop)(struct vfe_device *vfe, u8 wm);
 };
 
 struct vfe_isr_ops {
@@ -192,6 +193,14 @@ int vfe_reserve_wm(struct vfe_device *vfe, enum vfe_line_id line_id);
  */
 int vfe_reset(struct vfe_device *vfe);
 
+/*
+ * vfe_disable - Disable streaming on VFE line
+ * @line: VFE line
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int vfe_disable(struct vfe_line *line);
+
 extern const struct vfe_hw_ops vfe_ops_4_1;
 extern const struct vfe_hw_ops vfe_ops_4_7;
 extern const struct vfe_hw_ops vfe_ops_4_8;
-- 
2.42.0

