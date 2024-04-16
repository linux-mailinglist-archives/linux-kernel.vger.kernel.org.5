Return-Path: <linux-kernel+bounces-147775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4DE8A7987
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EACA1C22295
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104D13C684;
	Tue, 16 Apr 2024 23:57:55 +0000 (UTC)
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB213C3E7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311874; cv=none; b=HZsZTfoJwWTlBBH7IEjsScXFUsgo2QB0rH6Y7zdotI2b8vIoW0rD1eEQpuiNXi7khYpG3FaEaTGX6dC4CtGeuP6HM+8mYXmfpsQJtdPn3DuHjdwy/NE1Dz/tHpMN+aDUQz/eKSc+hnvbE0PIcbugG5nYa9gqMt0zm7mTFw+lzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311874; c=relaxed/simple;
	bh=va9fPRtJ0SkXGycOhlB8Ezr85RrN/MriF/E14uxzkS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9i+DjFCw+kgR4gTgc7x+wbovs6QMdJUXFBOMsEqFnbvpGMSKluHrUUseeQxMay7wJ5lTQfBpwpkqSJaxf4u+w/tiynDuaddc2phGbSVBrW88bcYvbZqUwbb4sQhre8Eogz6fHW2m4e5LPYQVV1Ra7jCSOVU87GuLheLtreZbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id EB4833F0E3;
	Wed, 17 Apr 2024 01:57:50 +0200 (CEST)
From: Marijn Suijten <marijn.suijten@somainline.org>
Date: Wed, 17 Apr 2024 01:57:47 +0200
Subject: [PATCH 7/7] drm/msm/dpu: Rename `ctx` parameter to `intf` to match
 other functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-7-78ae3ee9a697@somainline.org>
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
In-Reply-To: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Archit Taneja <architt@codeaurora.org>, 
 Chandan Uddaraju <chandanu@codeaurora.org>, Vinod Koul <vkoul@kernel.org>, 
 Sravanthi Kollukuduru <skolluku@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jordan Crouse <jordan@cosmicpenguin.net>, 
 Rajesh Yadav <ryadav@codeaurora.org>, 
 Jeykumar Sankaran <jsanka@codeaurora.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.13.0

All other functions in dpu_hw_intf name the "self" parameter `intf`,
except dpu_hw_intf_setup_timing_engine() and the recently added
dpu_hw_intf_program_intf_cmd_cfg().  Clean that up for consistency.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 965692ef7892..34d0c4e04d27 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -96,11 +96,11 @@
 #define INTF_CFG2_DCE_DATA_COMPRESS     BIT(12)
 
 
-static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
+static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *intf,
 		const struct dpu_hw_intf_timing_params *p,
 		const struct dpu_format *fmt)
 {
-	struct dpu_hw_blk_reg_map *c = &ctx->hw;
+	struct dpu_hw_blk_reg_map *c = &intf->hw;
 	u32 hsync_period, vsync_period;
 	u32 display_v_start, display_v_end;
 	u32 hsync_start_x, hsync_end_x;
@@ -118,7 +118,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 	/* read interface_cfg */
 	intf_cfg = DPU_REG_READ(c, INTF_CONFIG);
 
-	if (ctx->cap->type == INTF_DP)
+	if (intf->cap->type == INTF_DP)
 		dp_intf = true;
 
 	hsync_period = p->hsync_pulse_width + p->h_back_porch + p->width +
@@ -223,7 +223,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 	DPU_REG_WRITE(c, INTF_FRAME_LINE_COUNT_EN, 0x3);
 	DPU_REG_WRITE(c, INTF_CONFIG, intf_cfg);
 	DPU_REG_WRITE(c, INTF_PANEL_FORMAT, panel_format);
-	if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {
+	if (intf->cap->features & BIT(DPU_DATA_HCTL_EN)) {
 		/*
 		 * DATA_HCTL_EN controls data timing which can be different from
 		 * video timing. It is recommended to enable it for all cases, except
@@ -518,10 +518,10 @@ static void dpu_hw_intf_disable_autorefresh(struct dpu_hw_intf *intf,
 
 }
 
-static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *ctx,
+static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *intf,
 					     struct dpu_hw_intf_cmd_mode_cfg *cmd_mode_cfg)
 {
-	u32 intf_cfg2 = DPU_REG_READ(&ctx->hw, INTF_CONFIG2);
+	u32 intf_cfg2 = DPU_REG_READ(&intf->hw, INTF_CONFIG2);
 
 	if (cmd_mode_cfg->data_compress)
 		intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
@@ -529,7 +529,7 @@ static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *ctx,
 	if (cmd_mode_cfg->wide_bus_en)
 		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
 
-	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
+	DPU_REG_WRITE(&intf->hw, INTF_CONFIG2, intf_cfg2);
 }
 
 struct dpu_hw_intf *dpu_hw_intf_init(struct drm_device *dev,

-- 
2.44.0


