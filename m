Return-Path: <linux-kernel+bounces-123087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEDD8901F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB8C1C2D1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4279F12D745;
	Thu, 28 Mar 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSlks2we"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAD12A144;
	Thu, 28 Mar 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636525; cv=none; b=rIcjuLynRZ1aatHR0sxJn8yn3vwDMMYHpj1O5BZrChjTpA3yq/gsDMhLUw5ArsxfYR2nUQQRg2Z4lLs6c8di3KxobJQr3oDp805I2rTV/yuYqF1ACFWV/Q0IeX4kDeU5PPiMsLJDxWfaUDEwvYwj9T1iW+18c5tlnzH22MbZXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636525; c=relaxed/simple;
	bh=0cEYEHUgE6/Me+QvkgvBiu+s/9uNC8lK8X5oACHE56Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iy7cRmd48IDl8QVF7KWHpt3CQZgpQqksvGXsC+n3drRRjxPESIjC+0dF7cGmEBXCfCtAEDpBad1foBUW3tbd8EX409sadIf74L5W7lMUm6f3lkU0GUS38gzEC6aOzxoQstxRMJY5z+tPHSE/lkys5c7ciPVxCDdMpP2ECkhXojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSlks2we; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612A6C433C7;
	Thu, 28 Mar 2024 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636525;
	bh=0cEYEHUgE6/Me+QvkgvBiu+s/9uNC8lK8X5oACHE56Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mSlks2weB8+geHzROfWxaghEln+WgfGvaUetKP9WoypEcJEZ+k7+aKqLSHAye3zcw
	 y9fYgryQUHNbWXIr/YHYqXY0sOa5SaFFM6L1s2kj0mMKT+qWVeFaQjA8dLILthTvhF
	 yRJl/wdHgp9jDZOI8oeXezfcA0C0XE6sCBx7on30hFiUg3Umv3bjveYLasyL/CE5z7
	 fK6ifN2LkF8BYV5ESQveZIETKowSWsP0+RoVfVI+GL/YCXX1wgyCZPQH6bm2GXbRE+
	 YXSIDgWRzhLwOdurpNL0ehI15KRY1XaIB8cNHK4cZXpvHrDDy84BD7u7O/RZmaL6Nj
	 nfL5iuYQFFm+w==
From: Bjorn Andersson <andersson@kernel.org>
Date: Thu, 28 Mar 2024 07:40:01 -0700
Subject: [PATCH v2 2/6] drm/msm/dp: Removed fixed nvid "support"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-msm-dp-cleanup-v2-2-a5aed9798d32@quicinc.com>
References: <20240328-msm-dp-cleanup-v2-0-a5aed9798d32@quicinc.com>
In-Reply-To: <20240328-msm-dp-cleanup-v2-0-a5aed9798d32@quicinc.com>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3728;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=0vv6dHvH1Y3qLumDrHkbFNSd1KxWXUhkg/ici0zD3/E=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmBYFIJyG4Bpka/lZ36d0NIAxWzb8f7xxbF/EXz
 08TIi2IYn2JAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZgWBSBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXEDxAAo/y5Bl23YhYys1s5o53g3LGqPxdYpxxiVejD2cq
 uOP4bGLodGQDu3sHJdjVB53uh3HO+QG8TklN8/kkDU4nXeYR1xTOL49Z99ZkUD6d5hphC3MCD1M
 VlIVp5G+C3R5SraNeXOL+HzcI6HWmOhAiGVExLJjcJADY4eZl9aDqiTZLeFI/y6XBvOsswUWM4y
 LD4PnajWTV/1ER9qjNnW6RkQheku3zXJuge27L0I4LNeF18lRu9JvtORngt19479qjguBEez7Hm
 jl08G1aCbtddiTrh88zF1IbNWbZ1yGlfmU67b0jysSHjnvKuB7rHxaNyZ2UnZtxINYlxK9mRRTs
 5IuMd/EGPMrvgccMMt9rnRfL3QbLzz8d5M/WIPWjGO9Njq8lEEbjI3rfdpHxiQwQm0TCZHQFjLd
 eoqq9QpM4UoomEaXIkCNRrig3fFv2nqMmTA7DnXXBt3IClHBJGTLcK9ZImmNGFx8ODVAjQSE6ev
 el2wjsG9L1R0pp5GuPURS1bDKEMvF6h1GZMELAKxA+cQMXUQNpFmNekSRoPWfOy6hN4o3vKmjy0
 a1IRSD81AwjiEKvwPQrrbfQ9Km8yZQfDaX++zaJx+hOkrJHZC8fZ+J9tuZ2DFmfeBHnTIQ0fWiJ
 WMx2cXtV6ZRKlZiiJ4Hy5Ml8xKiOnMdWivDNzeoc7lNY=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

The "desc" member of struct dp_panel is zero-initialized during
allocation and never assigned, resulting in dp_ctrl_use_fixed_nvid()
never returning true. This returned boolean value is passed around but
never acted upon.

Perform constant propagation and remove the traces of "fixed nvid".

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c |  2 +-
 drivers/gpu/drm/msm/dp/dp_catalog.h |  2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 17 +----------------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  1 -
 4 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 3e7c84cdef47..8c72d532d96b 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -469,7 +469,7 @@ void dp_catalog_setup_peripheral_flush(struct dp_catalog *dp_catalog)
 
 void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog,
 					u32 rate, u32 stream_rate_khz,
-					bool fixed_nvid, bool is_ycbcr_420)
+					bool is_ycbcr_420)
 {
 	u32 pixel_m, pixel_n;
 	u32 mvid, nvid, pixel_div = 0, dispcc_input_rate;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 75ec290127c7..b85ad6bdb2e7 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -99,7 +99,7 @@ void dp_catalog_ctrl_psr_mainlink_enable(struct dp_catalog *dp_catalog, bool ena
 void dp_catalog_setup_peripheral_flush(struct dp_catalog *dp_catalog);
 void dp_catalog_ctrl_config_misc(struct dp_catalog *dp_catalog, u32 cc, u32 tb);
 void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog, u32 rate,
-				u32 stream_rate_khz, bool fixed_nvid, bool is_ycbcr_420);
+				u32 stream_rate_khz, bool is_ycbcr_420);
 int dp_catalog_ctrl_set_pattern_state_bit(struct dp_catalog *dp_catalog, u32 pattern);
 u32 dp_catalog_hw_revision(const struct dp_catalog *dp_catalog);
 void dp_catalog_ctrl_reset(struct dp_catalog *dp_catalog);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c4dda1faef67..e65a460fb52d 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1566,21 +1566,6 @@ void dp_ctrl_phy_exit(struct dp_ctrl *dp_ctrl)
 			phy, phy->init_count, phy->power_count);
 }
 
-static bool dp_ctrl_use_fixed_nvid(struct dp_ctrl_private *ctrl)
-{
-	const u8 *dpcd = ctrl->panel->dpcd;
-
-	/*
-	 * For better interop experience, used a fixed NVID=0x8000
-	 * whenever connected to a VGA dongle downstream.
-	 */
-	if (drm_dp_is_branch(dpcd))
-		return (drm_dp_has_quirk(&ctrl->panel->desc,
-					 DP_DPCD_QUIRK_CONSTANT_N));
-
-	return false;
-}
-
 static int dp_ctrl_reinitialize_mainlink(struct dp_ctrl_private *ctrl)
 {
 	struct phy *phy = ctrl->phy;
@@ -2022,7 +2007,7 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
 
 	dp_catalog_ctrl_config_msa(ctrl->catalog,
 		ctrl->link->link_params.rate,
-		pixel_rate_orig, dp_ctrl_use_fixed_nvid(ctrl),
+		pixel_rate_orig,
 		ctrl->panel->dp_mode.out_fmt_is_yuv_420);
 
 	dp_ctrl_setup_tr_unit(ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index e843f5062d1f..9afd99e00b0c 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -40,7 +40,6 @@ struct dp_panel {
 	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
 
 	struct dp_link_info link_info;
-	struct drm_dp_desc desc;
 	struct edid *edid;
 	struct drm_connector *connector;
 	struct dp_display_mode dp_mode;

-- 
2.43.0


