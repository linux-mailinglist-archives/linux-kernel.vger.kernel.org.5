Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741BD7ADC41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjIYPsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjIYPri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0B8139
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405505b07dfso27159425e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656847; x=1696261647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wmbicm6J4n1g5d7DX/duVuL47dLgNvi79FpU0w8H5SU=;
        b=pu+3vg3KmMC1BDJOrQKyPoAD0WWHEQqu1REzRuIPic/VwYowaq8Q0vWFCrXNNv39E6
         VVlc/P14P1xaRYa21yWGDVgnheaQfNAK0tAL8PKeQ+jBgmN6wLJPuNfMEC0RvNHUwpm9
         2FAyWPS2NaIW0B81e0na/VOxgz+hjcJXwvviImWJe0rgGVZkl9XaCSnNwYvMVibJ8KbF
         PXv8uKgVpmyXuh5gWvfR1ryowplHGvNprxpopVcPgAaRWSsvFEjhXoCA3K7zGOCZV2V2
         D5jtKMpWCFhfFtvEs9MKsPKA774EAsq5y892bhQaaF5StJMgGfjG3g0SkBH9l7UgZS6D
         ODbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656847; x=1696261647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wmbicm6J4n1g5d7DX/duVuL47dLgNvi79FpU0w8H5SU=;
        b=Js9osI8fs+Zhkmjz8MdOBUQObZBBzwrlOgRFMSav+J5OHBr0hO4Bq6FOAzJklQMrFe
         Arqr635RqA5ytDnunmdO1iOoInj0c+HDpnX1NZUknPi1J898RsHYpYgUuccizqbKLnp8
         7DweXWb41OkuNZJsFbmf1K6xtTa7rsuLHsLvX/iNyCU5+QAm51rLK5ozc0zuwAxFBQAw
         IzYG8UGS2JIA69O2sG0Rcf50N38UkIEmoTEdp5Nj7TigcKmG4fR8vcgBdapJbmtbORhF
         oUD2OFvM5At/jaH1SuCONJSxRO19h879fPXiZxoe+QAzu6xx8OzLerjPxpWXkRO97A+c
         SJjA==
X-Gm-Message-State: AOJu0Yypb8vXY1yx+eZ4habKtIxS3pby4q8gnZ6NhDNOBXIa2aCQgP4b
        Kj08UqhylDu2zGt3K0BapRBDNg==
X-Google-Smtp-Source: AGHT+IHcWoDdMuI7kSu4vsSLJ/2Y1jUOmLeUhLb9CixcS6s9pjJzhkwAOlxSNCMo5Q4G/AyLyW/ajQ==
X-Received: by 2002:a05:600c:2249:b0:402:e68f:8a4f with SMTP id a9-20020a05600c224900b00402e68f8a4fmr82970wmm.0.1695656847565;
        Mon, 25 Sep 2023 08:47:27 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 15/17] media: qcom: camss: Move vfe_disable into a common routine where applicable
Date:   Mon, 25 Sep 2023 16:47:05 +0100
Message-ID: <20230925154707.837542-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
References: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

