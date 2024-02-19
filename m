Return-Path: <linux-kernel+bounces-71416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDA85A4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1691F20FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDE638F98;
	Mon, 19 Feb 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBhQa7bn"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4629539840
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349781; cv=none; b=MXxRH6KJqarUvae8uy3NCKSJRc2waxyvVwN7I/gV3RIi8nOB/guncvNIZTt/ojZPsc8gLFEy8McBteZsUR96tG8rWhbG7QTAdl/Q4o40117VzUg2/xmrhDqtqICPfpYcha73nj+UrdSK76F5REM9VAQDfi4ABLp/Jx49fYQxqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349781; c=relaxed/simple;
	bh=/obkr4MMIdqspTXLmZcuivEDxO3xqayOzHksqJVGMAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBTdEeoAPwt5HwmrQiE2W2F3i4B6GmJXoIZ/eixLMbBPGDwX2BdhyKm7UEc9WiN+BgQdO9eRYymF4EnF1GVLejbLlGtLxGwbzO67JImyuotfh/FnQstR2+/aXh4m8/VXW6OciH+yVVazw1Ehe2JGaW+TeMCmWwTm1mmssXQYLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XBhQa7bn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5645efb2942so2053845a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708349777; x=1708954577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hQ3SpYizIIEdO8h/cb2gS2gZ6yJ1jbKnG/M424eunA=;
        b=XBhQa7bn4slRjZFakgSX6cAI43a6cUn96lQKW9EcXYjfJ7ivnuU8i7m9LkVtP6buyb
         ENWnSD/MGHFsLy1AFt1OreBcvfWVoGtGjx8kTTvaQHsF84EF6apeFCSZ/LG/Z+DRINEd
         JAAjSr5IFpLQyHrE6vTZCpZrYjjgSa2lHnjCWoGhrH7lNZmydtUOFNmG5qRYoA3L/SG8
         CXeQumcpQ16bCmusizZsaaKwOjd/uM7cr5gZUlTRST05yFSU4hlFTAVZlGjpwXlVs25m
         Y+zvkbe4iskzXX6/eDnHEulvLtsmfIiPA8Uv8IxN3VhQUDEowzlkQ8WqWYe38f8IFnl/
         /Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708349777; x=1708954577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hQ3SpYizIIEdO8h/cb2gS2gZ6yJ1jbKnG/M424eunA=;
        b=mvwOwP9QiHqDAXc+D6xod+5mzCnJUGMr5QwtNI5h8HWkL0QBc60sPouBkz1pYQYf1p
         CaOMwitP6d7mo3c3RuOPfiGYDPAfIHiajLFzUdmihUnW6C+YdfVrueL6yyk1sWDa2h5k
         trIAIWoIRq/95b/3jD79Obz+4BfCt/1mKhi0P90uX+mZieb3SeaRmWf8zbptMoYufaRn
         Zs2MvyrpdQGQ9S2AVC/RnHdVO8n5yZdwI5s1yW6M9zNwo2lgAmV2FWP7tdDAbeb1he4d
         BSUJIQF2VrDwTJItJ7Hb+Bp2RRA9fdR4KRPZ8n2hV1YJkh9gO6OTiXAGg9/fIaEYdpw8
         RNig==
X-Forwarded-Encrypted: i=1; AJvYcCX04OdWZupJNbKbGcqjAcDXf9n8BnVIWjISGJFy0y6mBOzXlpDQSaMmuUYgaNkgafKcJJuTEa+vY2Ei+qx8J0STR1tuJiEzvQRz1LYI
X-Gm-Message-State: AOJu0Yxpfo1/F7OCj4mlBSRplosAG29VHzWP0THhok6HvAbcaeIjXFHB
	ODVba5zi4iqJArbUn3t09Ao8bw2UnHRwHRrfxig8Z1FIfuWENJ+K1V4ML1M9pjA=
X-Google-Smtp-Source: AGHT+IFtyKubqbVkS2/EGKVIjmdl6/hb5Jk1awJ+nov4aN2l80WWwgt45nlgndmGKF7U2X5okMdPSA==
X-Received: by 2002:a05:6402:5207:b0:564:4211:faa3 with SMTP id s7-20020a056402520700b005644211faa3mr4558857edd.1.1708349777655;
        Mon, 19 Feb 2024 05:36:17 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm2900168edi.59.2024.02.19.05.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:36:17 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 19 Feb 2024 14:35:51 +0100
Subject: [PATCH 6/8] drm/msm/adreno: Add A702 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v1-6-d260fa854707@linaro.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708349759; l=11199;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/obkr4MMIdqspTXLmZcuivEDxO3xqayOzHksqJVGMAk=;
 b=pC9ZbozvhtAheTgTbHhODa3zv/ScgMjLbvVCtaCW+Bx9TyZuBh7ZvlmsMYXyybffQAMfdiBn+
 B1zLGn99G21DmgJjQlkyiv8TbzZ4oR4dXPhhJNaMpg/SIcTJh7PMjy3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The A702 is a weird mix of 600 and 700 series.. Perhaps even a
testing ground for some A7xx features with good ol' A6xx silicon.
It's basically A610 that's been beefed up with some new registers
and hw features (like APRIV!), that was then cut back in size,
memory bus and some other ways.

Add support for it, tested with QCM2290 / RB1.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 92 +++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 18 ++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 16 +++++-
 3 files changed, 117 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c9c55e2ea584..2a491a486ca1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -837,6 +837,65 @@ const struct adreno_reglist a690_hwcg[] = {
 	{}
 };
 
+const struct adreno_reglist a702_hwcg[] = {
+	{ REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000081 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_SP0, 0x0000f3cf },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00022222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_TP0, 0x11111111 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY2_TP0, 0x11111111 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY3_TP0, 0x11111111 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY4_TP0, 0x00011111 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x77777777 },
+	{ REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x77777777 },
+	{ REG_A6XX_RBBM_CLOCK_HYST3_TP0, 0x77777777 },
+	{ REG_A6XX_RBBM_CLOCK_HYST4_TP0, 0x00077777 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_RB0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL2_RB0, 0x01202222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_CCU0, 0x00002220 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_RB_CCU0, 0x00040f00 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_RAC, 0x05522022 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL2_RAC, 0x00005555 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_RAC, 0x00000011 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_RAC, 0x00445044 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_TSE_RAS_RBBM, 0x04222222 },
+	{ REG_A6XX_RBBM_CLOCK_MODE_VFD, 0x00002222 },
+	{ REG_A6XX_RBBM_CLOCK_MODE_GPC, 0x02222222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_HLSQ_2, 0x00000002 },
+	{ REG_A6XX_RBBM_CLOCK_MODE_HLSQ, 0x00002222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_TSE_RAS_RBBM, 0x00004000 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_VFD, 0x00002222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_GPC, 0x00000200 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_HLSQ, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_TSE_RAS_RBBM, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_VFD, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_GPC, 0x04104004 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_HLSQ, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_UCHE, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_UCHE, 0x00000004 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_UCHE, 0x00000002 },
+	{ REG_A6XX_RBBM_ISDB_CNT, 0x00000182 },
+	{ REG_A6XX_RBBM_RAC_THRESHOLD_CNT, 0x00000000 },
+	{ REG_A6XX_RBBM_SP_HYST_CNT, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_FCHE, 0x00000222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_FCHE, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_FCHE, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_GLC, 0x00222222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_GLC, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_GLC, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_MHUB, 0x00000002 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_MHUB, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_MHUB, 0x00000000 },
+	{}
+};
+
 const struct adreno_reglist a730_hwcg[] = {
 	{ REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x02222222 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02022222 },
@@ -968,6 +1027,8 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 		clock_cntl_on = 0x8aa8aa02;
 	else if (adreno_is_a610(adreno_gpu))
 		clock_cntl_on = 0xaaa8aa82;
+	else if (adreno_is_a702(adreno_gpu))
+		clock_cntl_on = 0xaaaaaa82;
 	else
 		clock_cntl_on = 0x8aa8aa82;
 
@@ -989,14 +1050,14 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 		return;
 
 	/* Disable SP clock before programming HWCG registers */
-	if (!adreno_is_a610(adreno_gpu) && !adreno_is_a7xx(adreno_gpu))
+	if (!adreno_is_a610_family(adreno_gpu) && !adreno_is_a7xx(adreno_gpu))
 		gmu_rmw(gmu, REG_A6XX_GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL, 1, 0);
 
 	for (i = 0; (reg = &adreno_gpu->info->hwcg[i], reg->offset); i++)
 		gpu_write(gpu, reg->offset, state ? reg->value : 0);
 
 	/* Enable SP clock */
-	if (!adreno_is_a610(adreno_gpu) && !adreno_is_a7xx(adreno_gpu))
+	if (!adreno_is_a610_family(adreno_gpu) && !adreno_is_a7xx(adreno_gpu))
 		gmu_rmw(gmu, REG_A6XX_GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL, 0, 1);
 
 	gpu_write(gpu, REG_A6XX_RBBM_CLOCK_CNTL, state ? clock_cntl_on : 0);
@@ -1224,7 +1285,7 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 	const u32 *regs = a6xx_protect;
 	unsigned i, count, count_max;
 
-	if (adreno_is_a650(adreno_gpu)) {
+	if (adreno_is_a650(adreno_gpu) || adreno_is_a702(adreno_gpu)) {
 		regs = a650_protect;
 		count = ARRAY_SIZE(a650_protect);
 		count_max = 48;
@@ -1320,6 +1381,12 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 		gpu->ubwc_config.rgb565_predicator = 1;
 		gpu->ubwc_config.uavflagprd_inv = 2;
 	}
+
+	if (adreno_is_a702(gpu)) {
+		gpu->ubwc_config.highest_bank_bit = 14;
+		gpu->ubwc_config.min_acc_len = 1;
+		gpu->ubwc_config.ubwc_mode = 2;
+	}
 }
 
 static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
@@ -1453,7 +1520,7 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
 		return false;
 
 	/* A7xx is safe! */
-	if (adreno_is_a7xx(adreno_gpu))
+	if (adreno_is_a7xx(adreno_gpu) || adreno_is_a702(adreno_gpu))
 		return true;
 
 	/*
@@ -1671,7 +1738,7 @@ static int hw_init(struct msm_gpu *gpu)
 	a6xx_set_hwcg(gpu, true);
 
 	/* VBIF/GBIF start*/
-	if (adreno_is_a610(adreno_gpu) ||
+	if (adreno_is_a610_family(adreno_gpu) ||
 	    adreno_is_a640_family(adreno_gpu) ||
 	    adreno_is_a650_family(adreno_gpu) ||
 	    adreno_is_a7xx(adreno_gpu)) {
@@ -1705,6 +1772,7 @@ static int hw_init(struct msm_gpu *gpu)
 	}
 
 	if (!(adreno_is_a650_family(adreno_gpu) ||
+	      adreno_is_a702(adreno_gpu) ||
 	      adreno_is_a730(adreno_gpu))) {
 		gmem_range_min = adreno_is_a740_family(adreno_gpu) ? SZ_16M : SZ_1M;
 
@@ -1725,7 +1793,7 @@ static int hw_init(struct msm_gpu *gpu)
 	if (adreno_is_a640_family(adreno_gpu) || adreno_is_a650_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x02000140);
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
-	} else if (adreno_is_a610(adreno_gpu)) {
+	} else if (adreno_is_a610_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x00800060);
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x40201b16);
 	} else if (!adreno_is_a7xx(adreno_gpu)) {
@@ -1740,13 +1808,18 @@ static int hw_init(struct msm_gpu *gpu)
 	if (adreno_is_a610(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 48);
 		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_DBG_ADDR, 47);
+	} else if (adreno_is_a702(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 64);
+		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_DBG_ADDR, 63);
 	} else if (!adreno_is_a7xx(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 128);
 
 	/* Setting the primFifo thresholds default values,
 	 * and vccCacheSkipDis=1 bit (0x200) for A640 and newer
 	*/
-	if (adreno_is_a690(adreno_gpu))
+	if (adreno_is_a702(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x0000c000);
+	else if (adreno_is_a690(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00800200);
 	else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
@@ -1786,7 +1859,7 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x4fffff);
 	else if (adreno_is_a619(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3fffff);
-	else if (adreno_is_a610(adreno_gpu))
+	else if (adreno_is_a610(adreno_gpu) || adreno_is_a702(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3ffff);
 	else
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x1fffff);
@@ -1822,6 +1895,9 @@ static int hw_init(struct msm_gpu *gpu)
 		else
 			gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, 0x1);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x0);
+	} else if (adreno_is_a702(adreno_gpu)) {
+		/* Something to do with the HLSQ cluster */
+		gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, BIT(24));
 	}
 
 	if (adreno_is_a690(adreno_gpu))
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 2ce7d7b1690d..b121abc71338 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -492,6 +492,24 @@ static const struct adreno_info gpulist[] = {
 		.zapfw = "a690_zap.mdt",
 		.hwcg = a690_hwcg,
 		.address_space_size = SZ_16G,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
+		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
+		.fw = {
+			[ADRENO_FW_SQE] = "a702_sqe.fw",
+		},
+		.gmem = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a702_zap.mbn",
+		.hwcg = a702_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 236, 1 },
+			{ 178, 2 },
+			{ 142, 3 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x07030001),
 		.family = ADRENO_7XX_GEN1,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index bc14df96feb0..f451881a6ddf 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -77,7 +77,7 @@ struct adreno_reglist {
 };
 
 extern const struct adreno_reglist a612_hwcg[], a615_hwcg[], a630_hwcg[], a640_hwcg[], a650_hwcg[];
-extern const struct adreno_reglist a660_hwcg[], a690_hwcg[], a730_hwcg[], a740_hwcg[];
+extern const struct adreno_reglist a660_hwcg[], a690_hwcg[], a702_hwcg[], a730_hwcg[], a740_hwcg[];
 
 struct adreno_speedbin {
 	uint16_t fuse;
@@ -382,6 +382,20 @@ static inline int adreno_is_a690(const struct adreno_gpu *gpu)
 	return gpu->info->chip_ids[0] == 0x06090000;
 }
 
+static inline int adreno_is_a702(const struct adreno_gpu *gpu)
+{
+	return gpu->info->chip_ids[0] == 0x07000200;
+}
+
+static inline int adreno_is_a610_family(const struct adreno_gpu *gpu)
+{
+	if (WARN_ON_ONCE(!gpu->info))
+		return false;
+
+	/* TODO: A612 */
+	return adreno_is_a610(gpu) || adreno_is_a702(gpu);
+}
+
 /* check for a615, a616, a618, a619 or any a630 derivatives */
 static inline int adreno_is_a630_family(const struct adreno_gpu *gpu)
 {

-- 
2.43.2


