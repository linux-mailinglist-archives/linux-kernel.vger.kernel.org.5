Return-Path: <linux-kernel+bounces-80411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A04886683A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DB02817F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD441BC4C;
	Mon, 26 Feb 2024 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMhWeRLm"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9361A5AC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914487; cv=none; b=j9NHaTeyCq5iQIDtXLkIrKKAjNvZ/9K24S1rxGH3j6Bpv9q9t0RhvSPZcKObQrMvXS9hng8r48AoHbeU8BpFNNd2Z920e2TfILy05RzB5dcapl/ix5qMNapXvYfJ0IrLnmZtOgpH+veDjYaKM2EWsyo3jJa9W1XCRgYoOvJCxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914487; c=relaxed/simple;
	bh=DcJkg8xY9yU1wn7LtAuvfIPSDQOSJ+nJ+ORj2FrKvhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NdxR6MsPfIidDPSfV8YowTvnKJjgrJFd0e6nrI+5Gj3C6Xzuo3Y1GlxnjKjOf3e9rJxNrcrmNGylVnJoOa0e8MflHcIPoSYIoZ00siXiaLcKt+chrh+FL2s3nw0P0UzWz0ZLVXQUAnJGzfIuzbQBs8B3x4vX6T7Fc09u9WnlQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EMhWeRLm; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d275e63590so29227601fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708914483; x=1709519283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zrSUS1oI8t8ANu34PzPLXDrLfaANT7YZx3X0xgYm0k=;
        b=EMhWeRLm0/qjVkQ6WDTRX3ga3b/2qroeBUli8Wpl+Yipu9ObMBb9ISi3/pxmYIW1hb
         asb91rSPGQ2To33MZLcizTwFocbg52x2KrtnX84KLeMifn2ZHNSzCkUHQK1kUiHlS0+W
         OUsuPdLjUTJYSrC9VKlcf20RykR/3bYH7bVw7pc4WjjHB5yf5a72w2JAGmNzayAaDD70
         CND8Qc3ZEGHBn6+GFg0UJL4psMKz1WQ5mU15wWyeXvhIW/xPNOt+yQ5ksxcTsSFnooYj
         KqvlRfcjUUy43AUKO/mn2YNestwWiCbhKY2TMh7uc/xFZRWuhSE+z28+qHdRTM5cVVoJ
         3ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708914483; x=1709519283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zrSUS1oI8t8ANu34PzPLXDrLfaANT7YZx3X0xgYm0k=;
        b=oCEV1jxwKcGUw8/K3Obdck1jjh3jGhooiEgZMzaEH5q+6yD5ktXfKxtmlenJqQLw3o
         I5W05URf62BmC10nHGQS59g2FMD4775SP/UugSqC6vrvDXK86uFMB7aMr3P/M1xh8fVr
         s7k++qcicZwTOu0l9A+Eglftgqw+eJ6wXzeBTKmAJLVfhu5Q/MPGiViM7gGvuy5z4UAt
         18Sd0lFzbWxcp02UWc8OB1CztbooGrzBcZPEKOZqdtqTa0dugf1hiP0qE3K65tiuN3UW
         BeJJY2mmvkDoufsQJ3WWaJECmhgoZ/YNKIlETiGB0RMOKSFEOrkjXSnxg0yCXSCaLuK7
         jAaA==
X-Forwarded-Encrypted: i=1; AJvYcCXmR71MUmAYN3WrzHFaDULX9ZO1k/NHrq83f2/E0iK2COX9Y/bQSv1EYOTh7eva0qG51V20qTsQ0O3VrxMAZO4kl0pzfCB3mwAnoqWx
X-Gm-Message-State: AOJu0YwYhd7FNw/EL4mOuMld6Gig1yY337F4aVU0AkDDK6PSClmelGCC
	Hj0/eLE882D5rea0VwtGu5VM+GiXZzkKspSXE+RKiCEVjJgaPqtVsYmmfh6nNc0=
X-Google-Smtp-Source: AGHT+IFefIdbhKnjJWT9odB7e2g6A6Qc+KZ3uR9VQXjUuUyxkrMxksYwTJufk3CxDVrfoe1de/bzVQ==
X-Received: by 2002:a2e:8ec5:0:b0:2d2:3820:fb4f with SMTP id e5-20020a2e8ec5000000b002d23820fb4fmr2920818ljl.12.1708914483696;
        Sun, 25 Feb 2024 18:28:03 -0800 (PST)
Received: from umbar.lan (dzyjmhybhls-s--zn36gy-3.rev.dnainternet.fi. [2001:14ba:a00e:a300:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id u19-20020a2e8553000000b002d11ef66881sm713092ljj.91.2024.02.25.18.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 18:28:02 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 26 Feb 2024 04:28:01 +0200
Subject: [PATCH v4 3/3] drm/msm/dpu: capture snapshot on the first
 commit_done timeout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-fd-dpu-debug-timeout-v4-3-51eec83dde23@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=DcJkg8xY9yU1wn7LtAuvfIPSDQOSJ+nJ+ORj2FrKvhg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+rt7/oaDYu8RNoPts+ZddbZcfsC6eypMzb3mR1w/7Pvs
 Ilev7RRJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmskaV/X9y3YNSk7+/8w1W
 3k3ge/RaK+Z1dUKrak9sw5z6AGvZsu/veVIYS0tnyPGsbQn9zFe81oF9y6/pC7fZWCwTXvHs6rM
 zk5jm23h+cVgTUdrp31ac26J6r51n0/sJd02dqiT+Jrbxz7yRo7nPJHO/1dar+kt+C9VtOzi7Mj
 qfOXd9opRLvIurnZTjktlim/Vapp2+uidq7uZb1fH3L2vwbgrq0X5YNrO1faLI3c5yw3u73vF2B
 HS5C/pJvS8xvFB9tuY5a8fz+D/fnXy07AOWeIrcq0vltRLXNzvNHz3BstBPz8j1r+FLh4bU+jvl
 SeGT7P/sl/ZdLuj6anHp6fO3QhWrhXZE+sbvmRBv6GEGAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In order to debug commit_done timeouts, capture the devcoredump state
when the first timeout occurs after the encoder has been enabled.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index c99c7fd770f6..c45edcde7ebc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -126,6 +126,8 @@ enum dpu_enc_rc_states {
  * @base:		drm_encoder base class for registration with DRM
  * @enc_spinlock:	Virtual-Encoder-Wide Spin Lock for IRQ purposes
  * @enabled:		True if the encoder is active, protected by enc_lock
+ * @commit_done_timedout: True if there has been a timeout on commit after
+ *			enabling the encoder.
  * @num_phys_encs:	Actual number of physical encoders contained.
  * @phys_encs:		Container of physical encoders managed.
  * @cur_master:		Pointer to the current master in this mode. Optimization
@@ -172,6 +174,7 @@ struct dpu_encoder_virt {
 	spinlock_t enc_spinlock;
 
 	bool enabled;
+	bool commit_done_timedout;
 
 	unsigned int num_phys_encs;
 	struct dpu_encoder_phys *phys_encs[MAX_PHYS_ENCODERS_PER_VIRTUAL];
@@ -1226,6 +1229,8 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
 	else if (disp_info->intf_type == INTF_DSI)
 		dpu_enc->wide_bus_en = msm_dsi_wide_bus_enabled(priv->dsi[index]);
 
+	dpu_enc->commit_done_timedout = false;
+
 	mutex_lock(&dpu_enc->enc_lock);
 	cur_mode = &dpu_enc->base.crtc->state->adjusted_mode;
 
@@ -2431,6 +2436,10 @@ int dpu_encoder_wait_for_commit_done(struct drm_encoder *drm_enc)
 			DPU_ATRACE_BEGIN("wait_for_commit_done");
 			ret = phys->ops.wait_for_commit_done(phys);
 			DPU_ATRACE_END("wait_for_commit_done");
+			if (ret == -ETIMEDOUT && !dpu_enc->commit_done_timedout) {
+				dpu_enc->commit_done_timedout = true;
+				msm_disp_snapshot_state(drm_enc->dev);
+			}
 			if (ret)
 				return ret;
 		}

-- 
2.39.2


