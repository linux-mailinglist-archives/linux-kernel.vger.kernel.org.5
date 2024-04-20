Return-Path: <linux-kernel+bounces-152117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06B8AB96B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F33F1C20C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F357410A20;
	Sat, 20 Apr 2024 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcXA3EWj"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284DD524
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585679; cv=none; b=QECggXuvz7UpVzX38hKTLkZdeA+uEAmuRjQzB1gD0gITKtpGbYNhkSOifYm1/CBgZPMUd7MvJLzptDdbLXl0rqmqDGoHQfaKEYOn/kWCcFdKzYX3qT/nPkRiM/GnOl9LmEgAtefXnFfOSyC0V5RhrNxcUWDNBmry8dbjp257B1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585679; c=relaxed/simple;
	bh=bR+chZ8/vH2q7NiGJkzYGAuWCLJdrkjYEG1yJa8P7EI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fujEOnTZIHCoIlxF1idmXIbEjjcqG52XZx69CejEz6WcJr6rkYLjsnOiZRPYAL+WQiMCWumkSlpk65u5jV9rMB42fSV63VcXrdlGxYMCHSzRxNFFBwrrObgY6w6jbzb+jbKyieoH9uZXxAW2E+TKP0PKAusumPqK8AXKZ/KBBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qcXA3EWj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d2600569so3420527e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713585676; x=1714190476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JTNeAPoronT10uplr3S5OnPsS/MansP6FbUgxUU9NU=;
        b=qcXA3EWj3r5pF8DduDf+7l9NL2k+lJdBAKbSDxQN7wOdG0Q0W7V7pAgDVFG50EcFem
         CNEHxxMOhCdg+NmBdP5unrZGAy64Og8O8WvN0Fyepk0topAqp5v/T3mAzKw6aPKBeEqN
         do8fVjYWg8909oqSAQu7B62UBUdsxiq/2mQAy5o3dg4/SNSEkUjP3S6sbTJKAbHH/Nnj
         LBBdUYeYz1L4o99Qxk5onzt/ZMG2VPeuPVumn2tU6tWqfWJbEW624mJ3FHVImBxKUgXT
         LTfHSWYFJX16Ggj+urSRpYzbSXC+YBwUOE9zhD1wuAoeD18AToiLwc+3bugR4BntTAkL
         +kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713585676; x=1714190476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JTNeAPoronT10uplr3S5OnPsS/MansP6FbUgxUU9NU=;
        b=HTqR9tiiQ2nwmCln86vdVGKcV9GXcxXyQ5pvXU5g8CmuhNML3RDwe18bRfzoWmVdH2
         06USgcSp4RbQ3EV5mKYURZiIxKd6m65qKK4hktNVPs83JMQyygcf685mC6NMsE/xFmBL
         YhJNPw4RDrJz9MXxcg5GMedLDsh8CBilRSwOmGQvID6fNgbOXKuPzaEcMCnpu23yGa1E
         XJ/KR1/mzyY6xmgJNSSZGIFRs3uYNeFCMhwORz8hfyg/GlmtsV0AaeoMEvIoIU/6W0k8
         HERj3V9qFTHO6CBIw+FQnpDZiWoA8n5f09aNydB+JtwezIKX7tWB8RaGFei5CzNHreZR
         dmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd9U7n+/fR2u3+cqNYOsD8KWKAiagJjea+KhuNSzTZk0L9Fv1wSvX3QVWihrVOotpIQZXuUDAX6Ykqed0qlevIAO5NIQlOln2i6l7T
X-Gm-Message-State: AOJu0YyH095j+Mlar1L9fyHb8MJJ2yhuSFPQUmywBf7c1BM6mmkeDml0
	QQOtYpSonqftP4uV1jRAVG0Ky3h2XAIUt2PJ34QMRZmPa0GgxyrcL17VEfyINjU=
X-Google-Smtp-Source: AGHT+IH/yVDRhbNqCbP/K8C3C5w5IT5HRZsBlcAzaUljogQMcieFXUFDEyLabxtA8kOvOt1fdEmUQw==
X-Received: by 2002:a19:9157:0:b0:51a:b46c:6e67 with SMTP id y23-20020a199157000000b0051ab46c6e67mr2820504lfj.1.1713585676412;
        Fri, 19 Apr 2024 21:01:16 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id n2-20020a0565120ac200b00518c9ccef2esm1003993lfu.22.2024.04.19.21.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 21:01:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 07:01:00 +0300
Subject: [PATCH v2 3/9] drm/msm/dpu: in dpu_format replace bitmap with
 unsigned long field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dpu-format-v2-3-9e93226cbffd@linaro.org>
References: <20240420-dpu-format-v2-0-9e93226cbffd@linaro.org>
In-Reply-To: <20240420-dpu-format-v2-0-9e93226cbffd@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7917;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bR+chZ8/vH2q7NiGJkzYGAuWCLJdrkjYEG1yJa8P7EI=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5qyHYfpveLeJ96/s76KTSk2y215oPiYL+7+X6dzBuwV4
 Xytysc7GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRZ1vZf7NleBRpsuzaMKNC
 Sdr9N/+Spzrlt0KYD6/aMSV5mvMn5yPSmdGqkpuVG07bn5LsMTDINOY4WfVn0/sSrV1Bu7Qkym8
 aXVV+8N/W5r63S8zSZz/NLfRXGD/rnPaxRSC3r4GzP0z42s22m1+4+B+9Dvtplfyt4qT5Iy2tr5
 ZzMoVk0yVnuGQ47A3e7td3pVF/66UizjPip68G6cxw/8uYuShO0Opj0YI1d4rl/+dkK+tYy286+
 fN4bHXadF7txQ63HP+3Mv6d8I5tn1Kvw5qTmdrzKtf4XrWT1tvGXcl+hI/N5JzxMsH1l0957WLn
 O/q7ZlJaENdqnytrTDpeaAqmHrJytHoXXvtd96+J7Lf7AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Using bitmap for the flags results in a clumsy syntax on test_bit,
replace it with unsigned long type and simple binary ops.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 18 +++++++++---------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h | 16 +++++++---------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index 87fa14fc5dd0..caf536788ece 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -45,7 +45,7 @@ bp, flg, fm, np)                                                          \
 	.unpack_count = uc,                                               \
 	.bpp = bp,                                                        \
 	.fetch_mode = fm,                                                 \
-	.flag = {(flg)},                                                  \
+	.flags = flg,                                                     \
 	.num_planes = np,                                                 \
 	.tile_height = DPU_TILE_HEIGHT_DEFAULT                            \
 }
@@ -64,7 +64,7 @@ alpha, bp, flg, fm, np, th)                                               \
 	.unpack_count = uc,                                               \
 	.bpp = bp,                                                        \
 	.fetch_mode = fm,                                                 \
-	.flag = {(flg)},                                                  \
+	.flags = flg,                                                     \
 	.num_planes = np,                                                 \
 	.tile_height = th                                                 \
 }
@@ -84,7 +84,7 @@ alpha, chroma, count, bp, flg, fm, np)                                    \
 	.unpack_count = count,                                            \
 	.bpp = bp,                                                        \
 	.fetch_mode = fm,                                                 \
-	.flag = {(flg)},                                                  \
+	.flags = flg,                                                     \
 	.num_planes = np,                                                 \
 	.tile_height = DPU_TILE_HEIGHT_DEFAULT                            \
 }
@@ -102,7 +102,7 @@ alpha, chroma, count, bp, flg, fm, np)                                    \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
 	.fetch_mode = fm,                                                 \
-	.flag = {(flg)},                                                  \
+	.flags = flg,                                                     \
 	.num_planes = np,                                                 \
 	.tile_height = DPU_TILE_HEIGHT_DEFAULT                            \
 }
@@ -121,7 +121,7 @@ flg, fm, np, th)                                                          \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
 	.fetch_mode = fm,                                                 \
-	.flag = {(flg)},                                                  \
+	.flags = flg,                                                     \
 	.num_planes = np,                                                 \
 	.tile_height = th                                                 \
 }
@@ -139,7 +139,7 @@ flg, fm, np, th)                                                          \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
 	.fetch_mode = fm,                                                 \
-	.flag = {(flg)},                                                  \
+	.flags = flg,                                                     \
 	.num_planes = np,                                                 \
 	.tile_height = DPU_TILE_HEIGHT_DEFAULT                            \
 }
@@ -158,7 +158,7 @@ flg, fm, np, th)                                                          \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
 	.fetch_mode = fm,                                                 \
-	.flag = {(flg)},                                                  \
+	.flags = flg,                                                     \
 	.num_planes = np,                                                 \
 	.tile_height = th                                                 \
 }
@@ -178,7 +178,7 @@ flg, fm, np)                                                      \
 	.unpack_count = 1,                                                \
 	.bpp = bp,                                                        \
 	.fetch_mode = fm,                                                 \
-	.flag = {(flg)},                                                  \
+	.flags = flg,                                                     \
 	.num_planes = np,                                                 \
 	.tile_height = DPU_TILE_HEIGHT_DEFAULT                            \
 }
@@ -1047,7 +1047,7 @@ const struct dpu_format *dpu_get_dpu_format_ext(
 		DPU_ERROR("unsupported fmt: %4.4s modifier 0x%llX\n",
 			(char *)&format, modifier);
 	else
-		DRM_DEBUG_ATOMIC("fmt %4.4s mod 0x%llX ubwc %d yuv %d\n",
+		DRM_DEBUG_ATOMIC("fmt %4.4s mod 0x%llX ubwc %d yuv %ld\n",
 				(char *)&format, modifier,
 				DPU_FORMAT_IS_UBWC(fmt),
 				DPU_FORMAT_IS_YUV(fmt));
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 31f97f535ce9..ed5206652413 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -40,23 +40,21 @@ enum dpu_format_flags {
 	DPU_FORMAT_FLAG_YUV_BIT,
 	DPU_FORMAT_FLAG_DX_BIT,
 	DPU_FORMAT_FLAG_COMPRESSED_BIT,
-	DPU_FORMAT_FLAG_BIT_MAX,
 };
 
 #define DPU_FORMAT_FLAG_YUV		BIT(DPU_FORMAT_FLAG_YUV_BIT)
 #define DPU_FORMAT_FLAG_DX		BIT(DPU_FORMAT_FLAG_DX_BIT)
 #define DPU_FORMAT_FLAG_COMPRESSED	BIT(DPU_FORMAT_FLAG_COMPRESSED_BIT)
-#define DPU_FORMAT_IS_YUV(X)		\
-	(test_bit(DPU_FORMAT_FLAG_YUV_BIT, (X)->flag))
-#define DPU_FORMAT_IS_DX(X)		\
-	(test_bit(DPU_FORMAT_FLAG_DX_BIT, (X)->flag))
+
+#define DPU_FORMAT_IS_YUV(X)		((X)->flags & DPU_FORMAT_FLAG_YUV)
+#define DPU_FORMAT_IS_DX(X)		((X)->flags & DPU_FORMAT_FLAG_DX)
 #define DPU_FORMAT_IS_LINEAR(X)		((X)->fetch_mode == MDP_FETCH_LINEAR)
 #define DPU_FORMAT_IS_TILE(X) \
 	(((X)->fetch_mode == MDP_FETCH_UBWC) && \
-			!test_bit(DPU_FORMAT_FLAG_COMPRESSED_BIT, (X)->flag))
+	 !((X)->flags & DPU_FORMAT_FLAG_COMPRESSED))
 #define DPU_FORMAT_IS_UBWC(X) \
 	(((X)->fetch_mode == MDP_FETCH_UBWC) && \
-			test_bit(DPU_FORMAT_FLAG_COMPRESSED_BIT, (X)->flag))
+	 ((X)->flags & DPU_FORMAT_FLAG_COMPRESSED))
 
 #define DPU_BLEND_FG_ALPHA_FG_CONST	(0 << 0)
 #define DPU_BLEND_FG_ALPHA_BG_CONST	(1 << 0)
@@ -334,7 +332,7 @@ enum dpu_3d_blend_mode {
  * @alpha_enable: whether the format has an alpha channel
  * @num_planes: number of planes (including meta data planes)
  * @fetch_mode: linear, tiled, or ubwc hw fetch behavior
- * @flag: usage bit flags
+ * @flags: usage bit flags
  * @tile_width: format tile width
  * @tile_height: format tile height
  */
@@ -351,7 +349,7 @@ struct dpu_format {
 	u8 alpha_enable;
 	u8 num_planes;
 	enum mdp_fetch_mode fetch_mode;
-	DECLARE_BITMAP(flag, DPU_FORMAT_FLAG_BIT_MAX);
+	unsigned long flags;
 	u16 tile_width;
 	u16 tile_height;
 };

-- 
2.39.2


