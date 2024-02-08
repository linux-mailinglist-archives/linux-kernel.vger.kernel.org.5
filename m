Return-Path: <linux-kernel+bounces-58263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAC184E3A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9485F28472D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C297E568;
	Thu,  8 Feb 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCUhgAXG"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCECC7B3F1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404478; cv=none; b=NEcExzCRHp49Mbc/T6SkYuBjM3q3NPIaXDPftUTVA/josqk29rFZ1JTNJt9/0zp+ZpYNscWjpJStupeBMv7vtJ6Pw6q5RNvuLlXI0QWTuK2z3vRQ8EJ9iBt9E/J9IfiwHSoW2TDPkmS0cnEPeF8E6VdO7cUQoJLJsbaQXk2e3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404478; c=relaxed/simple;
	bh=R70M+fFc3/2ZE9PGHXFTTMAClUHyGds0A2aBWG1FPcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRBiWKrn2oCVqpOeUHIJqfuf74+ADfIPSa9G3xsJGUWzPIqf555PreDcYN3cF1lo5GrCV85MTg2Knus7aOrFw36lKEMv6oXfrysmkFHg9e5E3Wk46QQrkdQnI7r9mUyX2OWtO3IsG9evMF6czZI8kJQCn0VqRaQPzGJ7DCOAbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCUhgAXG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51168addef1so2742461e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707404474; x=1708009274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIZmbIRcvUvz99rxf0RPQhPA5Ky/J7Xzvjbj9Vj02i0=;
        b=jCUhgAXG72rQsN/ktVTdJCU4IkIo0NqaOcORxjjgF38wL3WqiCEFX9pkyZLwmWsmJC
         g6+AWmvBLHSltjWKYeoiwYG7cVmPQl1ljckHsFPMVVget6Jw2m6C+3xw2RMil4xtOyNK
         F6hyvbHv54clV5Bwwsv/Wxm30ahd9EyxlNtDwqwBsPPQ4UOabwM3at0fdXYrQifKkdo2
         FJhsEq7a9Y1kInA2zNCZ/MFWIXVRvleYEuj0Pp8dOS/D7UOOn2z/iSpI3dK3hjooWKio
         5doLGXBeTGmvPdIXrKCJ37IMennNtJcavwljb1TF6ihMztmdWxkgqdAoBoruKSUOupRg
         /FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404474; x=1708009274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIZmbIRcvUvz99rxf0RPQhPA5Ky/J7Xzvjbj9Vj02i0=;
        b=QtBEBGBomyiD2QcfAZEMwHQEShpgeHhCfATr9YyWhJ2dn5yAcnmEqfGaTxgwxX/v9W
         /4E/sPjunTXE+7mA2liwCYQIxcF+cq1Rg9msM7XX0NKdvn9M4y41hYDbPYhCV3+raz4L
         vpzLsxqdo5IiR5zEgmgPZSLeRhtnZI4Mc7T+0Nh6Yu8J4akBxgt9aV1hQF5XyuIKo4WM
         jLl554OG1YpWJRCZLhOY9nm97Hi/liZRG4f3DSb9WiwiAEbNjrF7+Gal3b4I0y6pkceD
         v6o+kwTpCEH1UlvtakRtXRIv/ZDw+oFoKEBUHZ3SjZqLxnY/qsVFIjYEfdQGA43A8oKv
         Zf1A==
X-Gm-Message-State: AOJu0YzzFjQ9mOQzNAodIym8EfrEb4k6AG0kma9owtxmI5LFQ+Yv8evr
	louEHuzhf2CbLNMDjrLFzqLJobBQSbouWjFYT1tPsA92WtAjyQWiMJ0gi5lK9iI=
X-Google-Smtp-Source: AGHT+IHzy+MHmcUY+uEFUVyTJcGgozOs6gqCBMyl3Ru8f0h7C+qqNI9aJXZv+Okb1Kc/OqJXUd8TkA==
X-Received: by 2002:a05:6512:3d0f:b0:511:1038:dcde with SMTP id d15-20020a0565123d0f00b005111038dcdemr7764982lfv.52.1707404473756;
        Thu, 08 Feb 2024 07:01:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxtjDzuEah1k9wdRxLwNpsow4OaOPmIh2HlP6RXyb1KSLxbhw+hOiW0ekQpemBoKcSHLzfSxXfvYlq9UJEQRn6QMJsKsGFUgleR8mYDDOxhX1v38LU9ids+2oWHCY9T6INhajXKfP4QW7529kq+94pbeVzO13jaFUM67zaxuxyobthfwHg3HZ4ZOpcaO8VqUR78PRa3KDaTVtcNeYKEbPrqOx7nYuJELxTk+7YLziqHjhjXfCUNdJbKgRNB3grstHkjluoH33l0jwx1d2Lizn7vDak1EXMX2k6K+vzOfnomnGNN2b+ZmBLgp8KSewJT9S9ERJ7S6UstPA7eoHtYSb+XVD29SBxhE0uoz9fI3fKC6ciV9qMsEvw4FTD
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x18-20020a19f612000000b00511498107b8sm22444lfe.65.2024.02.08.07.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:01:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 08 Feb 2024 17:01:11 +0200
Subject: [PATCH v4 4/4] drm/msm/dpu: add support for SDM660 and SDM630
 platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-fd-migrate-mdp5-v4-4-945d08ef3fa8@linaro.org>
References: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
In-Reply-To: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=19136;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=R70M+fFc3/2ZE9PGHXFTTMAClUHyGds0A2aBWG1FPcg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlxOy1QwfOio2Qn1qV42f/HOI+8kc3/g51WTbHi
 LF5SPlFFqWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZcTstQAKCRCLPIo+Aiko
 1Xn8B/9rIqxryIpnD65oerL3nL6L/F0S91j/UVdlQ4RWj62/I5Ba5F5NQgL0mFjOB6h40e9KI5e
 35i+DF5JpHz/FouOxfBGs6rrVpe0ywisHrJUv4ND7y2dctjLfwl9kpnq6TkLnZTdjdS9znLOrRU
 IybcVgRFz68vs/KvpGrO5xCzX7cuI4spper7ce2/d62MXPQpjDAU13PnlM0LGG4I5ifEM72OAq7
 v+j3nhZMexAhcInBeutH2zuKeP3lGediWtsg76+YRc9HNdJVp+Ou9jVbZ/vjdaN6gXrl6BkNDnM
 ZsdSJgcO57ykq8g9uA0Qbu9J1+wd9seF+oP+oJzDdDIg1tdd
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Bring in hardware support for the SDM660 and SDM630 platforms, which
belong to the same DPU generation as MSM8998.

Note, by default these platforms are still handled by the MDP5 driver
unless the `msm.prefer_mdp5=false' parameter is provided.

Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h | 291 +++++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h | 225 ++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +
 drivers/gpu/drm/msm/msm_drv.c                      |   2 +
 6 files changed, 524 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
new file mode 100644
index 000000000000..424815e7fb7d
--- /dev/null
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023. Linaro Inc. All rights reserved.
+ */
+
+#ifndef _DPU_3_2_SDM660_H
+#define _DPU_3_2_SDM660_H
+
+static const struct dpu_caps sdm660_dpu_caps = {
+	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
+	.max_mixer_blendstages = 0x7,
+	.has_src_split = true,
+	.has_dim_layer = true,
+	.has_idle_pc = true,
+	.has_3d_merge = true,
+	.max_linewidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
+	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
+	.max_hdeci_exp = MAX_HORZ_DECIMATION,
+	.max_vdeci_exp = MAX_VERT_DECIMATION,
+};
+
+static const struct dpu_mdp_cfg sdm660_mdp = {
+	.name = "top_0",
+	.base = 0x0, .len = 0x458,
+	.features = BIT(DPU_MDP_VSYNC_SEL),
+	.clk_ctrls = {
+		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
+		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
+		[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8 },
+		[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
+		[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2c4, .bit_off = 8 },
+		[DPU_CLK_CTRL_CURSOR0] = { .reg_off = 0x3a8, .bit_off = 16 },
+	},
+};
+
+static const struct dpu_ctl_cfg sdm660_ctl[] = {
+	{
+		.name = "ctl_0", .id = CTL_0,
+		.base = 0x1000, .len = 0x94,
+		.features = BIT(DPU_CTL_SPLIT_DISPLAY),
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
+	}, {
+		.name = "ctl_1", .id = CTL_1,
+		.base = 0x1200, .len = 0x94,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
+	}, {
+		.name = "ctl_2", .id = CTL_2,
+		.base = 0x1400, .len = 0x94,
+		.features = BIT(DPU_CTL_SPLIT_DISPLAY),
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
+	}, {
+		.name = "ctl_3", .id = CTL_3,
+		.base = 0x1600, .len = 0x94,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
+	}, {
+		.name = "ctl_4", .id = CTL_4,
+		.base = 0x1800, .len = 0x94,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 13),
+	},
+};
+
+static const struct dpu_sspp_cfg sdm660_sspp[] = {
+	{
+		.name = "sspp_0", .id = SSPP_VIG0,
+		.base = 0x4000, .len = 0x1ac,
+		.features = VIG_MSM8998_MASK,
+		.sblk = &dpu_vig_sblk_qseed3_1_2,
+		.xin_id = 0,
+		.type = SSPP_TYPE_VIG,
+		.clk_ctrl = DPU_CLK_CTRL_VIG0,
+	}, {
+		.name = "sspp_1", .id = SSPP_VIG1,
+		.base = 0x6000, .len = 0x1ac,
+		.features = VIG_MSM8998_MASK,
+		.sblk = &dpu_vig_sblk_qseed3_1_2,
+		.xin_id = 4,
+		.type = SSPP_TYPE_VIG,
+		.clk_ctrl = DPU_CLK_CTRL_VIG1,
+	}, {
+		.name = "sspp_8", .id = SSPP_DMA0,
+		.base = 0x24000, .len = 0x1ac,
+		.features = DMA_MSM8998_MASK,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 1,
+		.type = SSPP_TYPE_DMA,
+		.clk_ctrl = DPU_CLK_CTRL_DMA0,
+	}, {
+		.name = "sspp_9", .id = SSPP_DMA1,
+		.base = 0x26000, .len = 0x1ac,
+		.features = DMA_MSM8998_MASK,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 5,
+		.type = SSPP_TYPE_DMA,
+		.clk_ctrl = DPU_CLK_CTRL_DMA1,
+	}, {
+		.name = "sspp_10", .id = SSPP_DMA2,
+		.base = 0x28000, .len = 0x1ac,
+		.features = DMA_CURSOR_MSM8998_MASK,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 9,
+		.type = SSPP_TYPE_DMA,
+		.clk_ctrl = DPU_CLK_CTRL_DMA2,
+	},
+};
+
+static const struct dpu_lm_cfg sdm660_lm[] = {
+	{
+		.name = "lm_0", .id = LM_0,
+		.base = 0x44000, .len = 0x320,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &msm8998_lm_sblk,
+		.lm_pair = LM_1,
+		.pingpong = PINGPONG_0,
+		.dspp = DSPP_0,
+	}, {
+		.name = "lm_1", .id = LM_1,
+		.base = 0x45000, .len = 0x320,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &msm8998_lm_sblk,
+		.lm_pair = LM_0,
+		.pingpong = PINGPONG_1,
+		.dspp = DSPP_1,
+	}, {
+		.name = "lm_2", .id = LM_2,
+		.base = 0x46000, .len = 0x320,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &msm8998_lm_sblk,
+		.lm_pair = LM_5,
+		.pingpong = PINGPONG_2,
+	}, {
+		.name = "lm_5", .id = LM_5,
+		.base = 0x49000, .len = 0x320,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &msm8998_lm_sblk,
+		.lm_pair = LM_2,
+		.pingpong = PINGPONG_3,
+	},
+};
+
+static const struct dpu_pingpong_cfg sdm660_pp[] = {
+	{
+		.name = "pingpong_0", .id = PINGPONG_0,
+		.base = 0x70000, .len = 0xd4,
+		.features = PINGPONG_SDM845_TE2_MASK,
+		.sblk = &sdm845_pp_sblk_te,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
+		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
+	}, {
+		.name = "pingpong_1", .id = PINGPONG_1,
+		.base = 0x70800, .len = 0xd4,
+		.features = PINGPONG_SDM845_TE2_MASK,
+		.sblk = &sdm845_pp_sblk_te,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
+		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),
+	}, {
+		.name = "pingpong_2", .id = PINGPONG_2,
+		.base = 0x71000, .len = 0xd4,
+		.features = PINGPONG_SDM845_MASK,
+		.sblk = &sdm845_pp_sblk,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
+		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14),
+	}, {
+		.name = "pingpong_3", .id = PINGPONG_3,
+		.base = 0x71800, .len = 0xd4,
+		.features = PINGPONG_SDM845_MASK,
+		.sblk = &sdm845_pp_sblk,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
+		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15),
+	},
+};
+
+static const struct dpu_dsc_cfg sdm660_dsc[] = {
+	{
+		.name = "dsc_0", .id = DSC_0,
+		.base = 0x80000, .len = 0x140,
+	}, {
+		.name = "dsc_1", .id = DSC_1,
+		.base = 0x80400, .len = 0x140,
+	},
+};
+
+static const struct dpu_dspp_cfg sdm660_dspp[] = {
+	{
+		.name = "dspp_0", .id = DSPP_0,
+		.base = 0x54000, .len = 0x1800,
+		.features = DSPP_SC7180_MASK,
+		.sblk = &msm8998_dspp_sblk,
+	}, {
+		.name = "dspp_1", .id = DSPP_1,
+		.base = 0x56000, .len = 0x1800,
+		.features = DSPP_SC7180_MASK,
+		.sblk = &msm8998_dspp_sblk,
+	},
+};
+
+static const struct dpu_intf_cfg sdm660_intf[] = {
+	{
+		.name = "intf_0", .id = INTF_0,
+		.base = 0x6a000, .len = 0x280,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 21,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
+		.intr_tear_rd_ptr = -1,
+	}, {
+		.name = "intf_1", .id = INTF_1,
+		.base = 0x6a800, .len = 0x280,
+		.type = INTF_DSI,
+		.controller_id = MSM_DSI_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 21,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 26),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 27),
+		.intr_tear_rd_ptr = -1,
+	}, {
+		.name = "intf_2", .id = INTF_2,
+		.base = 0x6b000, .len = 0x280,
+		.type = INTF_DSI,
+		.controller_id = MSM_DSI_CONTROLLER_1,
+		.prog_fetch_lines_worst_case = 21,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 28),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 29),
+		.intr_tear_rd_ptr = -1,
+	},
+};
+
+static const struct dpu_perf_cfg sdm660_perf_data = {
+	.max_bw_low = 6600000,
+	.max_bw_high = 6600000,
+	.min_core_ib = 3100000,
+	.min_llcc_ib = 800000,
+	.min_dram_ib = 800000,
+	.undersized_prefill_lines = 2,
+	.xtra_prefill_lines = 2,
+	.dest_scale_prefill_lines = 3,
+	.macrotile_prefill_lines = 4,
+	.yuv_nv12_prefill_lines = 8,
+	.linear_prefill_lines = 1,
+	.downscaling_prefill_lines = 1,
+	.amortizable_threshold = 25,
+	.min_prefill_lines = 25,
+	.danger_lut_tbl = {0xf, 0xffff, 0x0},
+	.safe_lut_tbl = {0xfffc, 0xff00, 0xffff},
+	.qos_lut_tbl = {
+		{.nentry = ARRAY_SIZE(msm8998_qos_linear),
+		.entries = msm8998_qos_linear
+		},
+		{.nentry = ARRAY_SIZE(msm8998_qos_macrotile),
+		.entries = msm8998_qos_macrotile
+		},
+		{.nentry = ARRAY_SIZE(msm8998_qos_nrt),
+		.entries = msm8998_qos_nrt
+		},
+	},
+	.cdp_cfg = {
+		{.rd_enable = 1, .wr_enable = 1},
+		{.rd_enable = 1, .wr_enable = 0}
+	},
+	.clk_inefficiency_factor = 200,
+	.bw_inefficiency_factor = 120,
+};
+
+static const struct dpu_mdss_version sdm660_mdss_ver = {
+	.core_major_ver = 3,
+	.core_minor_ver = 2,
+};
+
+const struct dpu_mdss_cfg dpu_sdm660_cfg = {
+	.mdss_ver = &sdm660_mdss_ver,
+	.caps = &sdm660_dpu_caps,
+	.mdp = &sdm660_mdp,
+	.ctl_count = ARRAY_SIZE(sdm660_ctl),
+	.ctl = sdm660_ctl,
+	.sspp_count = ARRAY_SIZE(sdm660_sspp),
+	.sspp = sdm660_sspp,
+	.mixer_count = ARRAY_SIZE(sdm660_lm),
+	.mixer = sdm660_lm,
+	.dspp_count = ARRAY_SIZE(sdm660_dspp),
+	.dspp = sdm660_dspp,
+	.pingpong_count = ARRAY_SIZE(sdm660_pp),
+	.pingpong = sdm660_pp,
+	.dsc_count = ARRAY_SIZE(sdm660_dsc),
+	.dsc = sdm660_dsc,
+	.intf_count = ARRAY_SIZE(sdm660_intf),
+	.intf = sdm660_intf,
+	.vbif_count = ARRAY_SIZE(msm8998_vbif),
+	.vbif = msm8998_vbif,
+	.perf = &sdm660_perf_data,
+};
+
+#endif
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
new file mode 100644
index 000000000000..df01227fc364
--- /dev/null
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
@@ -0,0 +1,225 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023. Linaro Inc. All rights reserved.
+ */
+
+#ifndef _DPU_3_3_SDM630_H
+#define _DPU_3_3_SDM630_H
+
+static const struct dpu_caps sdm630_dpu_caps = {
+	.max_mixer_width = DEFAULT_DPU_LINE_WIDTH,
+	.max_mixer_blendstages = 0x7,
+	.has_src_split = true,
+	.has_dim_layer = true,
+	.has_idle_pc = true,
+	.has_3d_merge = true,
+	.max_linewidth = DEFAULT_DPU_LINE_WIDTH,
+	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
+	.max_hdeci_exp = MAX_HORZ_DECIMATION,
+	.max_vdeci_exp = MAX_VERT_DECIMATION,
+};
+
+static const struct dpu_mdp_cfg sdm630_mdp = {
+	.name = "top_0",
+	.base = 0x0, .len = 0x458,
+	.features = BIT(DPU_MDP_VSYNC_SEL),
+	.clk_ctrls = {
+		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
+		[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8 },
+		[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
+		[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2c4, .bit_off = 8 },
+		[DPU_CLK_CTRL_CURSOR0] = { .reg_off = 0x3a8, .bit_off = 16 },
+	},
+};
+
+static const struct dpu_ctl_cfg sdm630_ctl[] = {
+	{
+		.name = "ctl_0", .id = CTL_0,
+		.base = 0x1000, .len = 0x94,
+		.features = BIT(DPU_CTL_SPLIT_DISPLAY),
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
+	}, {
+		.name = "ctl_1", .id = CTL_1,
+		.base = 0x1200, .len = 0x94,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
+	}, {
+		.name = "ctl_2", .id = CTL_2,
+		.base = 0x1400, .len = 0x94,
+		.features = BIT(DPU_CTL_SPLIT_DISPLAY),
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
+	}, {
+		.name = "ctl_3", .id = CTL_3,
+		.base = 0x1600, .len = 0x94,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
+	}, {
+		.name = "ctl_4", .id = CTL_4,
+		.base = 0x1800, .len = 0x94,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 13),
+	},
+};
+
+static const struct dpu_sspp_cfg sdm630_sspp[] = {
+	{
+		.name = "sspp_0", .id = SSPP_VIG0,
+		.base = 0x4000, .len = 0x1ac,
+		.features = VIG_MSM8998_MASK,
+		.sblk = &dpu_vig_sblk_qseed3_1_2,
+		.xin_id = 0,
+		.type = SSPP_TYPE_VIG,
+		.clk_ctrl = DPU_CLK_CTRL_VIG0,
+	}, {
+		.name = "sspp_8", .id = SSPP_DMA0,
+		.base = 0x24000, .len = 0x1ac,
+		.features = DMA_MSM8998_MASK,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 1,
+		.type = SSPP_TYPE_DMA,
+		.clk_ctrl = DPU_CLK_CTRL_DMA0,
+	}, {
+		.name = "sspp_9", .id = SSPP_DMA1,
+		.base = 0x26000, .len = 0x1ac,
+		.features = DMA_MSM8998_MASK,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 5,
+		.type = SSPP_TYPE_DMA,
+		.clk_ctrl = DPU_CLK_CTRL_DMA1,
+	}, {
+		.name = "sspp_10", .id = SSPP_DMA2,
+		.base = 0x28000, .len = 0x1ac,
+		.features = DMA_CURSOR_MSM8998_MASK,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 9,
+		.type = SSPP_TYPE_DMA,
+		.clk_ctrl = DPU_CLK_CTRL_DMA2,
+	},
+};
+
+static const struct dpu_lm_cfg sdm630_lm[] = {
+	{
+		.name = "lm_0", .id = LM_0,
+		.base = 0x44000, .len = 0x320,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &msm8998_lm_sblk,
+		.pingpong = PINGPONG_0,
+		.dspp = DSPP_0,
+	}, {
+		.name = "lm_2", .id = LM_2,
+		.base = 0x46000, .len = 0x320,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &msm8998_lm_sblk,
+		.pingpong = PINGPONG_2,
+	},
+};
+
+static const struct dpu_pingpong_cfg sdm630_pp[] = {
+	{
+		.name = "pingpong_0", .id = PINGPONG_0,
+		.base = 0x70000, .len = 0xd4,
+		.features = PINGPONG_SDM845_TE2_MASK,
+		.sblk = &sdm845_pp_sblk_te,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
+		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
+	}, {
+		.name = "pingpong_2", .id = PINGPONG_2,
+		.base = 0x71000, .len = 0xd4,
+		.features = PINGPONG_SDM845_MASK,
+		.sblk = &sdm845_pp_sblk,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
+		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14),
+	},
+};
+
+static const struct dpu_dspp_cfg sdm630_dspp[] = {
+	{
+		.name = "dspp_0", .id = DSPP_0,
+		.base = 0x54000, .len = 0x1800,
+		.features = DSPP_SC7180_MASK,
+		.sblk = &msm8998_dspp_sblk,
+	},
+};
+
+static const struct dpu_intf_cfg sdm630_intf[] = {
+	{
+		.name = "intf_0", .id = INTF_0,
+		.base = 0x6a000, .len = 0x280,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 21,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
+		.intr_tear_rd_ptr = -1,
+	}, {
+		.name = "intf_1", .id = INTF_1,
+		.base = 0x6a800, .len = 0x280,
+		.type = INTF_DSI,
+		.controller_id = MSM_DSI_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 21,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 26),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 27),
+		.intr_tear_rd_ptr = -1,
+	},
+};
+
+static const struct dpu_perf_cfg sdm630_perf_data = {
+	.max_bw_low = 4100000,
+	.max_bw_high = 4100000,
+	.min_core_ib = 3200000,
+	.min_llcc_ib = 800000,
+	.min_dram_ib = 800000,
+	.undersized_prefill_lines = 2,
+	.xtra_prefill_lines = 2,
+	.dest_scale_prefill_lines = 3,
+	.macrotile_prefill_lines = 4,
+	.yuv_nv12_prefill_lines = 8,
+	.linear_prefill_lines = 1,
+	.downscaling_prefill_lines = 1,
+	.amortizable_threshold = 25,
+	.min_prefill_lines = 25,
+	.danger_lut_tbl = {0xf, 0xffff, 0x0},
+	.safe_lut_tbl = {0xfffc, 0xff00, 0xffff},
+	.qos_lut_tbl = {
+		{.nentry = ARRAY_SIZE(msm8998_qos_linear),
+		.entries = msm8998_qos_linear
+		},
+		{.nentry = ARRAY_SIZE(msm8998_qos_macrotile),
+		.entries = msm8998_qos_macrotile
+		},
+		{.nentry = ARRAY_SIZE(msm8998_qos_nrt),
+		.entries = msm8998_qos_nrt
+		},
+	},
+	.cdp_cfg = {
+		{.rd_enable = 1, .wr_enable = 1},
+		{.rd_enable = 1, .wr_enable = 0}
+	},
+	.clk_inefficiency_factor = 200,
+	.bw_inefficiency_factor = 120,
+};
+
+static const struct dpu_mdss_version sdm630_mdss_ver = {
+	.core_major_ver = 3,
+	.core_minor_ver = 3,
+};
+
+const struct dpu_mdss_cfg dpu_sdm630_cfg = {
+	.mdss_ver = &sdm630_mdss_ver,
+	.caps = &sdm630_dpu_caps,
+	.mdp = &sdm630_mdp,
+	.ctl_count = ARRAY_SIZE(sdm630_ctl),
+	.ctl = sdm630_ctl,
+	.sspp_count = ARRAY_SIZE(sdm630_sspp),
+	.sspp = sdm630_sspp,
+	.mixer_count = ARRAY_SIZE(sdm630_lm),
+	.mixer = sdm630_lm,
+	.dspp_count = ARRAY_SIZE(sdm630_dspp),
+	.dspp = sdm630_dspp,
+	.pingpong_count = ARRAY_SIZE(sdm630_pp),
+	.pingpong = sdm630_pp,
+	.intf_count = ARRAY_SIZE(sdm630_intf),
+	.intf = sdm630_intf,
+	.vbif_count = ARRAY_SIZE(msm8998_vbif),
+	.vbif = msm8998_vbif,
+	.perf = &sdm630_perf_data,
+};
+
+#endif
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 54e8717403a0..ccbee0f40ad7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -680,6 +680,8 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
  *************************************************************/
 
 #include "catalog/dpu_3_0_msm8998.h"
+#include "catalog/dpu_3_2_sdm660.h"
+#include "catalog/dpu_3_3_sdm630.h"
 
 #include "catalog/dpu_4_0_sdm845.h"
 #include "catalog/dpu_4_1_sdm670.h"
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index ba82ef4560a6..a54c135e3147 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -832,6 +832,8 @@ struct dpu_mdss_cfg {
 };
 
 extern const struct dpu_mdss_cfg dpu_msm8998_cfg;
+extern const struct dpu_mdss_cfg dpu_sdm630_cfg;
+extern const struct dpu_mdss_cfg dpu_sdm660_cfg;
 extern const struct dpu_mdss_cfg dpu_sdm845_cfg;
 extern const struct dpu_mdss_cfg dpu_sdm670_cfg;
 extern const struct dpu_mdss_cfg dpu_sm8150_cfg;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 4fab3544e4f1..c27b624fdde5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1377,6 +1377,8 @@ static const struct dev_pm_ops dpu_pm_ops = {
 static const struct of_device_id dpu_dt_match[] = {
 	{ .compatible = "qcom,msm8998-dpu", .data = &dpu_msm8998_cfg, },
 	{ .compatible = "qcom,qcm2290-dpu", .data = &dpu_qcm2290_cfg, },
+	{ .compatible = "qcom,sdm630-mdp5", .data = &dpu_sdm630_cfg, },
+	{ .compatible = "qcom,sdm660-mdp5", .data = &dpu_sdm660_cfg, },
 	{ .compatible = "qcom,sdm670-dpu", .data = &dpu_sdm670_cfg, },
 	{ .compatible = "qcom,sdm845-dpu", .data = &dpu_sdm845_cfg, },
 	{ .compatible = "qcom,sc7180-dpu", .data = &dpu_sc7180_cfg, },
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index f79134fc6cc0..97790faffd23 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -983,6 +983,8 @@ module_param(prefer_mdp5, bool, 0444);
 
 /* list all platforms supported by both mdp5 and dpu drivers */
 static const char *const msm_mdp5_dpu_migration[] = {
+	"qcom,sdm630-mdp5",
+	"qcom,sdm660-mdp5",
 	NULL,
 };
 

-- 
2.39.2


