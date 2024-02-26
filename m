Return-Path: <linux-kernel+bounces-80410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24040866839
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2098281978
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C2F1B977;
	Mon, 26 Feb 2024 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+ORK5Q+"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C53179B5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914486; cv=none; b=sDavs/0t2kuUfNCQerMlyVFJzmQ3wD/GvfpWPPsxiIrCbB4ROIRu+ZsG4o9qGTCdLtHbDg6MVZiZdfsdMDj2X5IgYErB3VVwKGjVHa6CtGvkLIqgEkWyUMwOMyZlAzh1wkVbmJjO/9KdWUf5VeIRTa+LnXr8y9blGndxuMr6Js8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914486; c=relaxed/simple;
	bh=T/nDwtWkZJz2c5DNMYBy+x3YSHr3nDrORy9I9wO68cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6h1o9ruw5L6GRfH75oB8TXixNkfb1oFgqVYE0ORGAi8DYreQXSkQboB7MGwXu7Ud3nn8ygyBatOg7b2srbW00BrunKM03y9aLbYZNEP8hYgyVhDipdvzfFORoNofYhh4GPJMiA96hh5mGhIlf4Nrprdbn9mqwvTY9r/4qSPPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+ORK5Q+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso25681791fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708914482; x=1709519282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV02SgjOyPaysYl2sk5YoJSWDm5/B3zf/otAVWITiRM=;
        b=u+ORK5Q+b+eOvY9sZrnn11LUf7yauQ90E26ri4+kXP3lSmrDlOMrW5oevU0WFM3lr+
         Tx+f4rPYjdnHrxSujvM8wts35rZu79n70QQnw3pUQhDRMruABkxiZbuAk09U9evme/Pr
         C4av3dxkIlqrjtCrz2h/Io5CDDUd61b+OqnX7F7qok55K9ODQagG71+9Q/NfgURP+nXW
         SQSvhiITw+akEBGdvXwSlznZrxqks9bAgl/T8JbZE3sgj2ubTs1W53ZbFe/b4ymvFcQ9
         XEZ005oy5MiUUH9K4tAV4VNVupWnwk5Z+9mMpFNAxZ4DoIS5/dxi1BsCM3iZ2vPqAU5e
         sPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708914482; x=1709519282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV02SgjOyPaysYl2sk5YoJSWDm5/B3zf/otAVWITiRM=;
        b=lqVcuC9xoE8aXrxM8zSkIWhrk0yY28RDIeH/qcD2pLtJ+xDZ/PELmB53Hv+blrmpjA
         qHf7n4rvurzVUoScuYW0R8LZiFqwe7rwA5C0lGeZJ87J5PsH2kirEdbkIlGasSSMb4Nd
         9N5f1oywaBW7bZ1UPQ1H3fR0EXfqI8DNsdIfUpiSp44XDb8UOj/H7xPTbT7m1ZXpEH4r
         fSA/CBjpihlZKQ7Pp+pZQro5Oas7+MlO4JkU5reLD4Xal8LROQXWlas50BkvB9xSpJVt
         8vBuvaCaylK0zozy9NBE4ZIQQ/3jWMvzid9baLxmxxrhI1X0gcnURznIevPHzA2gz0Fw
         KHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsW8c9vwOi6JGAtNq+blY395WDn110OG3XZaxqPXatPuA61ggcgmlPYujN4NW8dfC01Wdi+O9HlF8Xw3lFhFN6OQCPK5PzADXd0llU
X-Gm-Message-State: AOJu0Yx94jlZ0Hc+2a7+BfH8AJrdmLl3Tb0debbi2SHLvWRtRTiGisOH
	LmsWcvkuqwnnFHrF4d0jQY/+Q+IVENhkqnd+wNnqQxELNjqWxaY/5u4eluDopl6Eiq94d38xlxH
	/
X-Google-Smtp-Source: AGHT+IFOoWt/q3O+WMLjwYsFSVJyoWl3OvQCuKY1bopjNqMXAkX3KKekU+txt2kLjF1/Ozr5oKd67A==
X-Received: by 2002:a2e:7d09:0:b0:2d2:40d7:9a55 with SMTP id y9-20020a2e7d09000000b002d240d79a55mr3148011ljc.4.1708914482720;
        Sun, 25 Feb 2024 18:28:02 -0800 (PST)
Received: from umbar.lan (dzyjmhybhls-s--zn36gy-3.rev.dnainternet.fi. [2001:14ba:a00e:a300:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id u19-20020a2e8553000000b002d11ef66881sm713092ljj.91.2024.02.25.18.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 18:28:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 26 Feb 2024 04:28:00 +0200
Subject: [PATCH v4 2/3] drm/msm/dpu: split dpu_encoder_wait_for_event into
 two functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-fd-dpu-debug-timeout-v4-2-51eec83dde23@linaro.org>
References: <20240226-fd-dpu-debug-timeout-v4-0-51eec83dde23@linaro.org>
In-Reply-To: <20240226-fd-dpu-debug-timeout-v4-0-51eec83dde23@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7035;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=T/nDwtWkZJz2c5DNMYBy+x3YSHr3nDrORy9I9wO68cg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBl2/cvHa9Gq7SAR1+xB/8u/bpTCuKYCMf7BYQGF
 HzOBt4WNsaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZdv3LwAKCRCLPIo+Aiko
 1VwwB/9j8v/rw9GsVqw0b0HfZ/eATkxlPA1WzAOSnqcDMjew1j+NOw1xQHiYxBDSRp5WjOhcCL9
 E7Lok1h6uqF2Ob852mParQ5Fs4+6wMe5St6yZC3525Ktww7mNlYF8lLo6oCGWu1qG7gglJLD3MW
 iBunufpYen3vSFNDm6tiRnnp6s8xbi30Jp+XpJrBDHviAto9H5Zyl4U+3FicG4L1YGiyFQxEggA
 82wF4q1gsXWswWAHQXEDAOXeZaZ499e1j/Ve0DlkvgklguqoV1nM9SRITIwoZvaZKg3ajSVPXtN
 12KNcJOXyoXosKcGD+TvB43iBKKIOmKATF+Bxh7J5R/Z+EbD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Stop multiplexing several events via the dpu_encoder_wait_for_event()
function. Split it into two distinct functions two allow separate
handling of those events.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 70 +++++++++++++++++++++--------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h | 22 ++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 +-
 drivers/gpu/drm/msm/msm_drv.h               | 10 -----
 4 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 194dbb08331d..c99c7fd770f6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1282,7 +1282,7 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 	trace_dpu_enc_disable(DRMID(drm_enc));
 
 	/* wait for idle */
-	dpu_encoder_wait_for_event(drm_enc, MSM_ENC_TX_COMPLETE);
+	dpu_encoder_wait_for_tx_complete(drm_enc);
 
 	dpu_encoder_resource_control(drm_enc, DPU_ENC_RC_EVENT_PRE_STOP);
 
@@ -2402,10 +2402,18 @@ struct drm_encoder *dpu_encoder_init(struct drm_device *dev,
 	return &dpu_enc->base;
 }
 
-int dpu_encoder_wait_for_event(struct drm_encoder *drm_enc,
-	enum msm_event_wait event)
+/**
+ * dpu_encoder_wait_for_commit_done() - Wait for encoder to flush pending state
+ * @drm_enc:	encoder pointer
+ *
+ * Wait for hardware to have flushed the current pending changes to hardware at
+ * a vblank or CTL_START. Physical encoders will map this differently depending
+ * on the type: vid mode -> vsync_irq, cmd mode -> CTL_START.
+ *
+ * Return: 0 on success, -EWOULDBLOCK if already signaled, error otherwise
+ */
+int dpu_encoder_wait_for_commit_done(struct drm_encoder *drm_enc)
 {
-	int (*fn_wait)(struct dpu_encoder_phys *phys_enc) = NULL;
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	int i, ret = 0;
 
@@ -2419,23 +2427,47 @@ int dpu_encoder_wait_for_event(struct drm_encoder *drm_enc,
 	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
 		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
 
-		switch (event) {
-		case MSM_ENC_COMMIT_DONE:
-			fn_wait = phys->ops.wait_for_commit_done;
-			break;
-		case MSM_ENC_TX_COMPLETE:
-			fn_wait = phys->ops.wait_for_tx_complete;
-			break;
-		default:
-			DPU_ERROR_ENC(dpu_enc, "unknown wait event %d\n",
-					event);
-			return -EINVAL;
+		if (phys->ops.wait_for_commit_done) {
+			DPU_ATRACE_BEGIN("wait_for_commit_done");
+			ret = phys->ops.wait_for_commit_done(phys);
+			DPU_ATRACE_END("wait_for_commit_done");
+			if (ret)
+				return ret;
 		}
+	}
+
+	return ret;
+}
+
+/**
+ * dpu_encoder_wait_for_tx_complete() - Wait for encoder to transfer pixels to panel
+ * @drm_enc:	encoder pointer
+ *
+ * Wait for the hardware to transfer all the pixels to the panel. Physical
+ * encoders will map this differently depending on the type: vid mode -> vsync_irq,
+ * cmd mode -> pp_done.
+ *
+ * Return: 0 on success, -EWOULDBLOCK if already signaled, error otherwise
+ */
+int dpu_encoder_wait_for_tx_complete(struct drm_encoder *drm_enc)
+{
+	struct dpu_encoder_virt *dpu_enc = NULL;
+	int i, ret = 0;
+
+	if (!drm_enc) {
+		DPU_ERROR("invalid encoder\n");
+		return -EINVAL;
+	}
+	dpu_enc = to_dpu_encoder_virt(drm_enc);
+	DPU_DEBUG_ENC(dpu_enc, "\n");
+
+	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
+		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
 
-		if (fn_wait) {
-			DPU_ATRACE_BEGIN("wait_for_completion_event");
-			ret = fn_wait(phys);
-			DPU_ATRACE_END("wait_for_completion_event");
+		if (phys->ops.wait_for_tx_complete) {
+			DPU_ATRACE_BEGIN("wait_for_tx_complete");
+			ret = phys->ops.wait_for_tx_complete(phys);
+			DPU_ATRACE_END("wait_for_tx_complete");
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index fe6b1d312a74..0c928d1876e4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -93,25 +93,9 @@ void dpu_encoder_kickoff(struct drm_encoder *encoder);
  */
 int dpu_encoder_vsync_time(struct drm_encoder *drm_enc, ktime_t *wakeup_time);
 
-/**
- * dpu_encoder_wait_for_event - Waits for encoder events
- * @encoder:	encoder pointer
- * @event:      event to wait for
- * MSM_ENC_COMMIT_DONE -  Wait for hardware to have flushed the current pending
- *                        frames to hardware at a vblank or ctl_start
- *                        Encoders will map this differently depending on the
- *                        panel type.
- *	                  vid mode -> vsync_irq
- *                        cmd mode -> ctl_start
- * MSM_ENC_TX_COMPLETE -  Wait for the hardware to transfer all the pixels to
- *                        the panel. Encoders will map this differently
- *                        depending on the panel type.
- *                        vid mode -> vsync_irq
- *                        cmd mode -> pp_done
- * Returns: 0 on success, -EWOULDBLOCK if already signaled, error otherwise
- */
-int dpu_encoder_wait_for_event(struct drm_encoder *drm_encoder,
-						enum msm_event_wait event);
+int dpu_encoder_wait_for_commit_done(struct drm_encoder *drm_encoder);
+
+int dpu_encoder_wait_for_tx_complete(struct drm_encoder *drm_encoder);
 
 /*
  * dpu_encoder_get_intf_mode - get interface mode of the given encoder
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index d6412395bacc..26b5e54031d9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -476,7 +476,7 @@ static void dpu_kms_wait_for_commit_done(struct msm_kms *kms,
 		 * mode panels. This may be a no-op for command mode panels.
 		 */
 		trace_dpu_kms_wait_for_commit_done(DRMID(crtc));
-		ret = dpu_encoder_wait_for_event(encoder, MSM_ENC_COMMIT_DONE);
+		ret = dpu_encoder_wait_for_commit_done(encoder);
 		if (ret && ret != -EWOULDBLOCK) {
 			DPU_ERROR("wait for commit done returned %d\n", ret);
 			break;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 762e13e2df74..91cf57f72321 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -74,16 +74,6 @@ enum msm_dsi_controller {
 #define MSM_GPU_MAX_RINGS 4
 #define MAX_H_TILES_PER_DISPLAY 2
 
-/**
- * enum msm_event_wait - type of HW events to wait for
- * @MSM_ENC_COMMIT_DONE - wait for the driver to flush the registers to HW
- * @MSM_ENC_TX_COMPLETE - wait for the HW to transfer the frame to panel
- */
-enum msm_event_wait {
-	MSM_ENC_COMMIT_DONE = 0,
-	MSM_ENC_TX_COMPLETE,
-};
-
 /**
  * struct msm_display_topology - defines a display topology pipeline
  * @num_lm:       number of layer mixers used

-- 
2.39.2


