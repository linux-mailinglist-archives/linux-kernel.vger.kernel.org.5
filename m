Return-Path: <linux-kernel+bounces-32014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6483554B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D138E1F214FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0836B1B;
	Sun, 21 Jan 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="lciop4r4"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374512E61;
	Sun, 21 Jan 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705833650; cv=none; b=j0Bljdp66ecAfpx/G4bDeDjOuJ5OnzK6SStoa+eawaN3NL76Z/HbDzxRplUIyNbzfg+1KblwMK2t/RDwZQpq5HfCTc+d6bVFSETqvHJiWtALRoLlKg37YOXXQG52h6wbBEoqIuZ/V2xVRH9yinI58jXWoRXwWfhErKFfx/ULexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705833650; c=relaxed/simple;
	bh=nBjQLwAVrLOtDklPZXhl6mSYmrwebasaPOxc4Nq5ooI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZrWej7gvRUJFX0PTH2fwqR+x08axqY9R5kwalkXZWF/YNqfKd/d13T0ZZ6ZxUryM0IPC5aLmCWfhd/7RCvVeFzzbObLguzhvYfdRLlJCMry3Jrqti4RqJxq5iVFueRz6N3ymYYitvic+dCJQIDwh74J6iKigSUV4F2rxel44B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=lciop4r4; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1705833647; bh=nBjQLwAVrLOtDklPZXhl6mSYmrwebasaPOxc4Nq5ooI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lciop4r4CZbZekaT96/hHLsEzLdGobUf1m+PECD0gZ7By06vI7E1q2hC7vau/zay4
	 kbHDk5tEGcd7poho8A1O817ifJypF4lQ07vBfANrLXZdJaz3hKjX09ZmuIyPY+R2Xx
	 CxR0sp/5lth1Zn+Om2LC9LZOwaK2fpXhgzxnGTP8=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 21 Jan 2024 11:40:39 +0100
Subject: [PATCH v2 2/2] drm/msm/adreno: Add A305B support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-msm8226-gpu-v2-2-77f4a6fbbca4@z3ntu.xyz>
References: <20240121-msm8226-gpu-v2-0-77f4a6fbbca4@z3ntu.xyz>
In-Reply-To: <20240121-msm8226-gpu-v2-0-77f4a6fbbca4@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4454; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=nBjQLwAVrLOtDklPZXhl6mSYmrwebasaPOxc4Nq5ooI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlrPSsW0f4/GUoP2msPZIz43/pVMSFAW/J8jCFF
 8uFM08X8siJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZaz0rAAKCRBy2EO4nU3X
 Vjf1D/wJoKFlkmrss4tM5q/zh3php1RI54HNSU1btmt0TeA2mU+c2CrozvlbX5FONA9ychoGRa3
 3Kpeid8w7gf+di16DsSUWjLSzdu9S55TNhINpBqAtxq31YVwlSrSWNlLI4YWxLUPHMtAztaMCEg
 tGvwHONkfBAkvao9N5q6/wvRVDuN/OYoRJuok3h1sGoJRHkZor8hEpthWGEk8ur6Qh82VBrKlja
 n1Eu35l1LizMbMZeNyx6YvwilEllnR/MJHmFCHiA0xdeGDMcd6FVwKzYVfoUpMcT1D0rA+rT338
 xhUNVjRv5wP10q6qEpRSmtrz4Chj47arr/YmrtKhEWX6p1xD8G16Q5oTsRoyvw7nUVjYNYehonG
 t4oMArs1NrruWMQz0Ayz61IrU4qc9+CLEUXD45Kkp44Z748h2p/8RjJi9WhKhQav0sykjvM5VGt
 ZDHd2p6VYFbjr2wYqnWMpjDNn81XSvhOw0GiWOlVA2EDzEKHqoTAZLrvmkGibWUvX5oVTqQjG+H
 HHihucKptvlQIc4Bmk6X3nGn8nS/RU9J+RrsE7uFwEzo0i87KvB5vN5cn1SmbWJ28jjrAJTmV2c
 ht+UwQE9zrZpBvjgC8f7IqSMzvMt5E3Jv60gdl/ZiORDwAbv/wiSIdQzDGJMrdVcMyGiV67vV8L
 juwKzKIIE4qxnAA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add support for the Adreno 305B GPU that is found in MSM8226(v2) SoC.
Previously this was mistakenly claimed to be supported but using wrong
a configuration.

In MSM8226v1 there's also a A305B but with chipid 0x03000510 which
should work with the same configuration but due to lack of hardware for
testing this is not added.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c      | 13 ++++++++++---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 15 +++++++++++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 +++++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index c86b377f6f0d..5273dc849838 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -134,6 +134,13 @@ static int a3xx_hw_init(struct msm_gpu *gpu)
 		/* Set up AOOO: */
 		gpu_write(gpu, REG_A3XX_VBIF_OUT_AXI_AOOO_EN, 0x0000003c);
 		gpu_write(gpu, REG_A3XX_VBIF_OUT_AXI_AOOO, 0x003c003c);
+	} else if (adreno_is_a305b(adreno_gpu)) {
+		gpu_write(gpu, REG_A3XX_VBIF_IN_RD_LIM_CONF0, 0x00181818);
+		gpu_write(gpu, REG_A3XX_VBIF_IN_WR_LIM_CONF0, 0x00181818);
+		gpu_write(gpu, REG_A3XX_VBIF_OUT_RD_LIM_CONF0, 0x00000018);
+		gpu_write(gpu, REG_A3XX_VBIF_OUT_WR_LIM_CONF0, 0x00000018);
+		gpu_write(gpu, REG_A3XX_VBIF_DDR_OUT_MAX_BURST, 0x00000303);
+		gpu_write(gpu, REG_A3XX_VBIF_ROUND_ROBIN_QOS_ARB, 0x0003);
 	} else if (adreno_is_a306(adreno_gpu)) {
 		gpu_write(gpu, REG_A3XX_VBIF_ROUND_ROBIN_QOS_ARB, 0x0003);
 		gpu_write(gpu, REG_A3XX_VBIF_OUT_RD_LIM_CONF0, 0x0000000a);
@@ -230,7 +237,7 @@ static int a3xx_hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A3XX_UCHE_CACHE_MODE_CONTROL_REG, 0x00000001);
 
 	/* Enable Clock gating: */
-	if (adreno_is_a306(adreno_gpu))
+	if (adreno_is_a305b(adreno_gpu) || adreno_is_a306(adreno_gpu))
 		gpu_write(gpu, REG_A3XX_RBBM_CLOCK_CTL, 0xaaaaaaaa);
 	else if (adreno_is_a320(adreno_gpu))
 		gpu_write(gpu, REG_A3XX_RBBM_CLOCK_CTL, 0xbfffffff);
@@ -333,7 +340,7 @@ static int a3xx_hw_init(struct msm_gpu *gpu)
 				AXXX_CP_QUEUE_THRESHOLDS_CSQ_IB1_START(2) |
 				AXXX_CP_QUEUE_THRESHOLDS_CSQ_IB2_START(6) |
 				AXXX_CP_QUEUE_THRESHOLDS_CSQ_ST_START(14));
-	} else if (adreno_is_a330(adreno_gpu)) {
+	} else if (adreno_is_a330(adreno_gpu) || adreno_is_a305b(adreno_gpu)) {
 		/* NOTE: this (value take from downstream android driver)
 		 * includes some bits outside of the known bitfields.  But
 		 * A330 has this "MERCIU queue" thing too, which might
@@ -559,7 +566,7 @@ struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
 		goto fail;
 
 	/* if needed, allocate gmem: */
-	if (adreno_is_a330(adreno_gpu)) {
+	if (adreno_is_a330(adreno_gpu) || adreno_is_a305b(adreno_gpu)) {
 		ret = adreno_gpu_ocmem_init(&adreno_gpu->base.pdev->dev,
 					    adreno_gpu, &a3xx_gpu->ocmem);
 		if (ret)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 2ce7d7b1690d..f2768e52ed12 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -55,10 +55,17 @@ static const struct adreno_info gpulist[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init  = a2xx_gpu_init,
 	}, {
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x03000512,
-			0x03000520
-		),
+		.chip_ids = ADRENO_CHIP_IDS(0x03000512),
+		.family = ADRENO_3XX,
+		.fw = {
+			[ADRENO_FW_PM4] = "a330_pm4.fw",
+			[ADRENO_FW_PFP] = "a330_pfp.fw",
+		},
+		.gmem  = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x03000520),
 		.family = ADRENO_3XX,
 		.revn  = 305,
 		.fw = {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index bc14df96feb0..d3c41af706df 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -256,6 +256,11 @@ static inline bool adreno_is_a305(const struct adreno_gpu *gpu)
 	return adreno_is_revn(gpu, 305);
 }
 
+static inline bool adreno_is_a305b(const struct adreno_gpu *gpu)
+{
+	return gpu->info->chip_ids[0] == 0x03000512;
+}
+
 static inline bool adreno_is_a306(const struct adreno_gpu *gpu)
 {
 	/* yes, 307, because a305c is 306 */

-- 
2.43.0


