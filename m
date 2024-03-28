Return-Path: <linux-kernel+bounces-123090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C18901FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E91F274D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184A12F59C;
	Thu, 28 Mar 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJGFbr1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5212F36D;
	Thu, 28 Mar 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636528; cv=none; b=DmDwwm3hGYWfYnvQapXOnMrjGLipk5o7Q56KLBLv6s6gAMQ2YcUievymaNCXCm31dBFQ1NG9/X7972dhoUt8ubwgeowYPEBDqQcgSjiwhfXei4Fh72fWLQsLWDjwL8zfZtlXtdNtYsad9J1+HlK+ks2UjgkTLOcG7o8y5rVHVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636528; c=relaxed/simple;
	bh=Dqd+kXEvsLwgGeIQGSkViQKw4HO+Q93TaZM7h2qYbzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CeDsIIpr5Z3ESzpM6gjZJDU4Z9ZQ1/SE2Oho3wH+FVSbAgz/XAm5wG0j2CQ90a+NRdH+g723+SxRwLxt/lJ6XJv/LyNO+ius0bDkez6F13FB3lyQVW4WEyHT6ZUFZJ2gCvOCw626TPuIA2cJTY8doW6Apf26A1zgh0ubf49U5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJGFbr1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B46C433A6;
	Thu, 28 Mar 2024 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636528;
	bh=Dqd+kXEvsLwgGeIQGSkViQKw4HO+Q93TaZM7h2qYbzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lJGFbr1Smyq57XfdbLxau75pFzhb5Yw1TIDCKuR9EiGIFy6ciJ+uevKVncaj/nCor
	 PGK85Pb+0fEpRhfu1DQ8HtqgxQlbAqLrzjwdNf+aC+KmkfEPDeEL0H4L1zCLOyldyR
	 g7Gxf4sCBJrabDtDiLy40/sIq7/dYfy4RwfbXvzxpBfQoMfY+DjnMQ41ghCvi65O+s
	 K7R21TIGR6+EyaDX2i0pmJfbUdk1eVmKFsrK+95P4L9N1v6e6vSKFlEXNiR340VN3V
	 z0IT9L9A4E4lOm+meq7x1TAP9a66/H0EZ60AouOXxXmUBglEc0w5/6cdBUUFM8iEky
	 BomUQkvz9WgbA==
From: Bjorn Andersson <andersson@kernel.org>
Date: Thu, 28 Mar 2024 07:40:04 -0700
Subject: [PATCH v2 5/6] drm/msm/dp: Use function arguments for timing
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-msm-dp-cleanup-v2-5-a5aed9798d32@quicinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4629;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=p6zl39KBq28yg/YN5707OZTxRbZDEkda5d4ZGgyTaKA=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmBYFIiZW3sGxpGa3yGwbDxqhKCDH2SDbeZ/e5A
 Gsvw0H9Pp6JAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZgWBSBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcX+Ag//ewq4SKTTS7mL6qxsVF0flZEDbLJ1vcO84q/jIxO
 Hb9NbLJR1suRb+Lazia/lDPg1S4dNoSBWPMs+9kvxIhCwUj8tuVYL+WeVEbC2tI4IVgaGai/kKa
 9g+ixmpn8XEEUTtQCwvRMNl+St5fmeN+VNZyPnlKl7pINc2lf+qt7L0SLX1HRHAg+GpsGAZWlNW
 /tyAbPNXBWa5fPbw6O4lY0OAg0JXMQvc+/HmoedHkgZaKaks6Q837gr0PGccW9SOczJ1MQRLbw7
 wuGKUjXBy4PfgJ9usAzfnzGL/mK/3lvNeZEgmYnX+2odTgGrQhqJuBuITvpL4rnpLHOmFSRe6Hc
 1d+2GmYRNGTYM2mViz+1nHyLTbBgT82YT3EOi1mC8W0mHRxZcosoL/691AgEqDjmETgGuIIvv+G
 Zlva023YB/kZiIRHLwaJoWiZbU3z2uo+4mQOZrWW44jcQrlhdLRKKau7BbCeKaRuFz/uPMs/qW5
 bwSGhfpF63cydmex9g2uT8m8WwsksEL4D021GF/f32T7EzE+GhUYWxm/Kzkhryz3RvNdEWcK2Wl
 QyArioKHiHN82nlx4MbJglvn9l5RsAbh+jwUEOc0I4/9zzbGEATj3v+rEPk7erFJWj8+3NLVPsW
 2RTD4S/Qf7TJOucn1h0AtebMKkevFJm6qfNvl+UAmPGU=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

dp_catalog_panel_timing_cfg() takes 4 arguments, which are passed from
the calling function through members of struct dp_catalog.

No state is maintained other than across this call, so switch to
function arguments to clean up the code.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 14 ++++++--------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  7 ++-----
 drivers/gpu/drm/msm/dp/dp_panel.c   | 14 +++++++++-----
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 295bd4cb72cc..00ad3ebaa5a1 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -880,19 +880,17 @@ u32 dp_catalog_ctrl_read_phy_pattern(struct dp_catalog *dp_catalog)
 }
 
 /* panel related catalog functions */
-int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog)
+int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog, u32 total,
+				u32 sync_start, u32 width_blanking, u32 dp_active)
 {
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
 	u32 reg;
 
-	dp_write_link(catalog, REG_DP_TOTAL_HOR_VER,
-				dp_catalog->total);
-	dp_write_link(catalog, REG_DP_START_HOR_VER_FROM_SYNC,
-				dp_catalog->sync_start);
-	dp_write_link(catalog, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY,
-				dp_catalog->width_blanking);
-	dp_write_link(catalog, REG_DP_ACTIVE_HOR_VER, dp_catalog->dp_active);
+	dp_write_link(catalog, REG_DP_TOTAL_HOR_VER, total);
+	dp_write_link(catalog, REG_DP_START_HOR_VER_FROM_SYNC, sync_start);
+	dp_write_link(catalog, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY, width_blanking);
+	dp_write_link(catalog, REG_DP_ACTIVE_HOR_VER, dp_active);
 
 	reg = dp_read_p0(catalog, MMSS_DP_INTF_CONFIG);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 290ef8180c12..a82ab4856b50 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -48,10 +48,6 @@ enum dp_catalog_audio_header_type {
 };
 
 struct dp_catalog {
-	u32 total;
-	u32 sync_start;
-	u32 width_blanking;
-	u32 dp_active;
 	enum dp_catalog_audio_sdp_type sdp_type;
 	enum dp_catalog_audio_header_type sdp_header;
 	u32 audio_data;
@@ -106,7 +102,8 @@ void dp_catalog_ctrl_send_phy_pattern(struct dp_catalog *dp_catalog,
 u32 dp_catalog_ctrl_read_phy_pattern(struct dp_catalog *dp_catalog);
 
 /* DP Panel APIs */
-int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog);
+int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog, u32 total,
+				u32 sync_start, u32 width_blanking, u32 dp_active);
 void dp_catalog_panel_enable_vsc_sdp(struct dp_catalog *dp_catalog, struct dp_sdp *vsc_sdp);
 void dp_catalog_panel_disable_vsc_sdp(struct dp_catalog *dp_catalog);
 void dp_catalog_dump_regs(struct dp_catalog *dp_catalog);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 8e7069453952..07db8f37cd06 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -353,6 +353,10 @@ int dp_panel_timing_cfg(struct dp_panel *dp_panel)
 	struct dp_catalog *catalog;
 	struct dp_panel_private *panel;
 	struct drm_display_mode *drm_mode;
+	u32 width_blanking;
+	u32 sync_start;
+	u32 dp_active;
+	u32 total;
 
 	panel = container_of(dp_panel, struct dp_panel_private, dp_panel);
 	catalog = panel->catalog;
@@ -376,13 +380,13 @@ int dp_panel_timing_cfg(struct dp_panel *dp_panel)
 	data <<= 16;
 	data |= total_hor;
 
-	catalog->total = data;
+	total = data;
 
 	data = (drm_mode->vtotal - drm_mode->vsync_start);
 	data <<= 16;
 	data |= (drm_mode->htotal - drm_mode->hsync_start);
 
-	catalog->sync_start = data;
+	sync_start = data;
 
 	data = drm_mode->vsync_end - drm_mode->vsync_start;
 	data <<= 16;
@@ -390,15 +394,15 @@ int dp_panel_timing_cfg(struct dp_panel *dp_panel)
 	data |= drm_mode->hsync_end - drm_mode->hsync_start;
 	data |= (panel->dp_panel.dp_mode.h_active_low << 15);
 
-	catalog->width_blanking = data;
+	width_blanking = data;
 
 	data = drm_mode->vdisplay;
 	data <<= 16;
 	data |= drm_mode->hdisplay;
 
-	catalog->dp_active = data;
+	dp_active = data;
 
-	dp_catalog_panel_timing_cfg(catalog);
+	dp_catalog_panel_timing_cfg(catalog, total, sync_start, width_blanking, dp_active);
 
 	if (dp_panel->dp_mode.out_fmt_is_yuv_420)
 		dp_panel_setup_vsc_sdp_yuv_420(dp_panel);

-- 
2.43.0


