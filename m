Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD257855C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjHWKp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjHWKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:45:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3A110DE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:45:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so2382015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692787507; x=1693392307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCsHx28OSfGIG+PvNDPUNK2MaUL6kouSWRdKAXaz/kg=;
        b=H2r5bhMm6ONKKK0NCsANReANW5qbk5jwUWuO/AkUutYicn4F4RtDjIWYgnCWL4sbnM
         9A95zGcf5X27bazHpaANPIy8xXpMpD9+t+7mdnV3hJqi2sHVRBj52GiZi6O8EHltP3DO
         X2wpV2/yuewNNj9SF6gi5c/z2WewNtFHva7hhjBUNfWx3Jbsz3bW0Br5xHIqS6ttQO5z
         PAnLkEbKqpgHh7Re0l1JJgu255k4L2y962HVaPVkgG7qC14iI6100mBfi3eMtYdvXxC5
         rxyGNrRFf6nbZwtTftzC0zvXpXq+w1OFoSSUCdm8Ikt3qn97zBv/k7OLkR6SDWUvOgt7
         CtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787507; x=1693392307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCsHx28OSfGIG+PvNDPUNK2MaUL6kouSWRdKAXaz/kg=;
        b=KMgixNVR13Jijmq5osUsCdpLymamjdGHTa/CLhtFHyZBWdIwwpDTHGpo2tE5zayDFU
         zTsw7+RCg7Vl17HtCGauk8iWm2TBQrW0tTJH6NUs9RgJP81hkHa1EXM5r6FcWcTpKRAg
         8Suc913Jh8m6ezw9DZ75dwCGek15/r0KovA/PVKwFVMfORN2ljd58kECJ6BN10OrNyi+
         1V7O8MvI3F6epF+IpnZDrAEPbs2FkYuRGeJjytwqe1amSFX42Kercd1xO3IwvWdYeRe1
         cw+G4HzGYmX7XEYZCV4TKTH2EDjn8I7svcc9LIiWwpQcEQunrPxCfufQ+en8/Aexj0MZ
         IwMg==
X-Gm-Message-State: AOJu0YyOspRJLDGGu5w1k9zfuwpxuRXkxhWgOmNvifPQs8nYqSG3G500
        svEguC59+qmw2egy9/GzO4i16A==
X-Google-Smtp-Source: AGHT+IGVKSeQ9pWkxj/wfJ5G7eC3j8hb189Gfl4C+aJGuO8hAf/xOXoj4r1JD6nqQSjkTuoTbb7UYw==
X-Received: by 2002:adf:e5c4:0:b0:317:eee2:6fba with SMTP id a4-20020adfe5c4000000b00317eee26fbamr10244304wrn.40.1692787507028;
        Wed, 23 Aug 2023 03:45:07 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0031c5dda3aedsm6281213wrq.95.2023.08.23.03.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:45:06 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/15] media: qcom: camss: Convert vfe_disable() from int to void
Date:   Wed, 23 Aug 2023 11:44:43 +0100
Message-ID: <20230823104444.1954663-15-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No version of vfe_disable() currently returns nor has ever as near as I
can discern ever returned a meaningful error code.

Convert from the unused int return to void.

Fixes: 633b388f85c5 ("media: camss: Refactor VFE HW version support")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c  | 5 ++---
 drivers/media/platform/qcom/camss/camss-vfe-480.c  | 5 ++---
 drivers/media/platform/qcom/camss/camss-vfe-gen1.c | 5 ++---
 drivers/media/platform/qcom/camss/camss-vfe-gen1.h | 3 +--
 drivers/media/platform/qcom/camss/camss-vfe.c      | 5 +----
 drivers/media/platform/qcom/camss/camss-vfe.h      | 2 +-
 6 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index c2487a8196db7..b6b425ac2e867 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -562,9 +562,8 @@ static int vfe_enable(struct vfe_line *line)
  * vfe_disable - Disable streaming on VFE line
  * @line: VFE line
  *
- * Return 0 on success or a negative error code otherwise
  */
-static int vfe_disable(struct vfe_line *line)
+static void vfe_disable(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 
@@ -578,7 +577,7 @@ static int vfe_disable(struct vfe_line *line)
 
 	mutex_unlock(&vfe->stream_lock);
 
-	return 0;
+	return;
 }
 
 /*
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index b1a07e846e25b..be00a713163e1 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -397,9 +397,8 @@ static int vfe_enable(struct vfe_line *line)
  * vfe_disable - Disable streaming on VFE line
  * @line: VFE line
  *
- * Return 0 on success or a negative error code otherwise
  */
-static int vfe_disable(struct vfe_line *line)
+static void vfe_disable(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 
@@ -413,7 +412,7 @@ static int vfe_disable(struct vfe_line *line)
 
 	mutex_unlock(&vfe->stream_lock);
 
-	return 0;
+	return;
 }
 
 /*
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-gen1.c b/drivers/media/platform/qcom/camss/camss-vfe-gen1.c
index 239d3d4ac6661..5e8319e565bbc 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-gen1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-gen1.c
@@ -95,9 +95,8 @@ static int vfe_disable_output(struct vfe_line *line)
  * vfe_gen1_disable - Disable streaming on VFE line
  * @line: VFE line
  *
- * Return 0 on success or a negative error code otherwise
  */
-int vfe_gen1_disable(struct vfe_line *line)
+void vfe_gen1_disable(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 
@@ -114,7 +113,7 @@ int vfe_gen1_disable(struct vfe_line *line)
 
 	mutex_unlock(&vfe->stream_lock);
 
-	return 0;
+	return;
 }
 
 static void vfe_output_init_addrs(struct vfe_device *vfe,
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-gen1.h b/drivers/media/platform/qcom/camss/camss-vfe-gen1.h
index 6d5f9656562c8..b82137a2cb578 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-gen1.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe-gen1.h
@@ -82,9 +82,8 @@ static inline u8 vfe_calc_interp_reso(u16 input, u16 output)
  * vfe_gen1_disable - Disable streaming on VFE line
  * @line: VFE line
  *
- * Return 0 on success or a negative error code otherwise
  */
-int vfe_gen1_disable(struct vfe_line *line);
+void vfe_gen1_disable(struct vfe_line *line);
 
 /*
  * vfe_gen1_enable - Enable VFE module
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 73380e75dbb22..d6c5628d51903 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -766,10 +766,7 @@ static int vfe_set_stream(struct v4l2_subdev *sd, int enable)
 			dev_err(vfe->camss->dev,
 				"Failed to enable vfe outputs\n");
 	} else {
-		ret = vfe->ops->vfe_disable(line);
-		if (ret < 0)
-			dev_err(vfe->camss->dev,
-				"Failed to disable vfe outputs\n");
+		vfe->ops->vfe_disable(line);
 	}
 
 	return ret;
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index cbc314c4e244b..b2f4192576364 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -112,7 +112,7 @@ struct vfe_hw_ops {
 	void (*reg_update_clear)(struct vfe_device *vfe,
 				 enum vfe_line_id line_id);
 	void (*subdev_init)(struct device *dev, struct vfe_device *vfe);
-	int (*vfe_disable)(struct vfe_line *line);
+	void (*vfe_disable)(struct vfe_line *line);
 	int (*vfe_enable)(struct vfe_line *line);
 	int (*vfe_halt)(struct vfe_device *vfe);
 	void (*violation_read)(struct vfe_device *vfe);
-- 
2.41.0

