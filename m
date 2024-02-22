Return-Path: <linux-kernel+bounces-76429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C88585F73F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3231C22763
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720024F8AB;
	Thu, 22 Feb 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VUjEkVSW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336965337B;
	Thu, 22 Feb 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601629; cv=none; b=c40+XlcR0v1DbdiTEJYpn/9dTgkdg/A5WWIdB34gjiJzdj1hduJT2RNZ2NW2cK+UYmgfcEM1OlBZk76vOCw4ld0hYKUOPfGCrcixPJKS/037arQFt3tcXzegamlrYjuZdXVYCOEYhd0oI9gSyCO3+8ajWE/rEAC1MYJJX9DqPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601629; c=relaxed/simple;
	bh=cPFONFYE2nb+IO9iZMg9BmI+2H7DAZ1L+pH8J7rFXGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=g1Qt2kBY/VdYkHCwq7nLOAQNsJZ1kozIHlwkzk1cUjWHzegg0ofKVYzcbk2MLHZOBkXK+35B9AeVlygcUqB7FOtiA4hxBtvzX7IJBCGCTLHCMxSLT4xfTT1BDbjZ7+jyERnoR9eCK8SLoLR1H61qUxsKQ1lTa6KR7KLhk7EyHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VUjEkVSW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXYdo059172;
	Thu, 22 Feb 2024 05:33:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601614;
	bh=Pq0KtB3Nang3grqsagiJ+0HbLgkmbO3CBWGVBQiMSsk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=VUjEkVSW8idOK0U/PDzd6E1PgKdXDLFXld81ny8S8GBS5nUR/7eAmohUmatjJbW8o
	 yIAidGljU0abdaAxr0pVtI1vpnGd+0Wjkt2OyiL+2x31zvN8Vgdo/bsuqYjvpng3cs
	 yfgn1RNbjQSv4fIIDbg+AWU9MRVvjsq2vR447LH4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXY5c057359
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:34 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:34 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXX4h091431;
	Thu, 22 Feb 2024 05:33:33 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:31 +0530
Subject: [PATCH RFC 15/21] SQUASH: media: cadence: csi2rx: Enable
 per-stream controls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-15-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=9384; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=cPFONFYE2nb+IO9iZMg9BmI+2H7DAZ1L+pH8J7rFXGc=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDoSJ1V++3bJA427yCkm9V3ixbMYp5EM+EOG
 gMG69Z5um2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw6AAKCRBD3pH5JJpx
 RaTiD/9FOUlfyXc4GnumP/7KaiM8X0qiI29XFYqQJYH0m2admGEGyn/yO0N4ar/BaANSseTdamx
 Y2TiZ4GCMVJHgeiXD+H7VSAJoPtgK4nmE9Eyj/wcV0OEvG3YxGJgqDxROQFOS9GWbAweWfIOAB8
 Dl7Z7AkR4AWfOn1ISHiWY09PWtgfS6zkTrI0WGrgVX7jxsej75wIiWPc9Jq8L+CX36NHzO1HSew
 iXTWg0K3EBQ+niyoODSbGGXQWLdnXiC6zMRH6IxGG+x6929RRknFLPu05mvQS6S/aDhSRQ0/+Mb
 i4Q+hEYIJVM90aLwFdA+s7lSn8zMrAkX895QCREE4wvi5mcqXO7xzaEXi8tfP+A06y10sZvaJrc
 H4ULNr2Lxgopr4GPl1EVsSEt/tS5YBf66PHxqutg7JNKdcH7SUp3plCk9/6QjRI67A74HLTG9zd
 boC9WqGXzW/+eEQeV1LcUL6jZhIQXLJ56MJjx1CwQa9LEmJm0ITM+/VKoPDWVjdkgfzDDh8dFMW
 /up5AY3ZfOmZ6F4NQuXly3LxW4BAjObU+P7yjgeLacSEXzD1VAEqoNMDrP2eFHPvLJwsEPo4GQl
 q2lNlAOyHaj2Il93kg0DERRcicYAr+bKYRxCUOxl5ZtiiogR/d5qmwqLky0uJUjMBlllDseDetv
 DKWx6rNtOlEXVrg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

With stream routing now supported in the driver, implement the
enable_stream and disable_stream hooks in place of the stream-unaware
s_stream hook.

This allows consumer devices like a DMA bridge or ISP, to enable
particular streams on a source pad, which in turn can be used to enable
only particular streams on the CSI-TX device connected on the sink pad.

Implement a fallback s_stream hook that internally calls enable_stream
on each source pad, for consumer drivers that don't use multi-stream
APIs to still work.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 211 ++++++++++++++++++---------
 1 file changed, 142 insertions(+), 69 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 1b76610ff617..f08d3b845dc9 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -183,27 +183,43 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 
 static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
 {
+	struct v4l2_ctrl_handler *handler = csi2rx->source_subdev->ctrl_handler;
 	union phy_configure_opts opts = { };
 	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
-	struct v4l2_subdev_format sd_fmt = {
-		.which	= V4L2_SUBDEV_FORMAT_ACTIVE,
-		.pad	= CSI2RX_PAD_SINK,
-	};
+	struct v4l2_mbus_framefmt *framefmt;
+	struct v4l2_subdev_state *state;
 	const struct csi2rx_fmt *fmt;
 	s64 link_freq;
 	int ret;
 
-	ret = v4l2_subdev_call_state_active(&csi2rx->subdev, pad, get_fmt,
-					    &sd_fmt);
-	if (ret < 0)
-		return ret;
+	if (v4l2_ctrl_find(handler, V4L2_CID_LINK_FREQ)) {
+		link_freq = v4l2_get_link_freq(handler, 0, 0);
+	} else {
+		state = v4l2_subdev_get_locked_active_state(&csi2rx->subdev);
+		framefmt = v4l2_subdev_state_get_format(state, CSI2RX_PAD_SINK,
+							0);
 
-	fmt = csi2rx_get_fmt_by_code(sd_fmt.format.code);
+		if (framefmt) {
+			fmt = csi2rx_get_fmt_by_code(framefmt->code);
+		} else {
+			dev_err(csi2rx->dev,
+				"Did not find active sink format\n");
+			return -EINVAL;
+		}
 
-	link_freq = v4l2_get_link_freq(csi2rx->source_subdev->ctrl_handler,
-				       fmt->bpp, 2 * csi2rx->num_lanes);
-	if (link_freq < 0)
+		link_freq = v4l2_get_link_freq(handler, fmt->bpp,
+					       2 * csi2rx->num_lanes);
+
+		dev_warn(csi2rx->dev,
+			 "Guessing link frequency using bitdepth of stream 0.\n");
+		dev_warn(csi2rx->dev,
+			 "V4L2_CID_LINK_FREQ control is required for multi format sources.\n");
+	}
+
+	if (link_freq < 0) {
+		dev_err(csi2rx->dev, "Unable to calculate link frequency\n");
 		return link_freq;
+	}
 
 	ret = phy_mipi_dphy_get_default_config_for_hsclk(link_freq,
 							 csi2rx->num_lanes, cfg);
@@ -226,18 +242,10 @@ static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
 static int csi2rx_start(struct csi2rx_priv *csi2rx)
 {
 	unsigned int i;
-	struct media_pad *remote_pad;
 	unsigned long lanes_used = 0;
 	u32 reg;
 	int ret;
 
-	remote_pad = media_pad_remote_pad_first(&csi2rx->pads[CSI2RX_PAD_SINK]);
-	if (!remote_pad) {
-		dev_err(csi2rx->dev,
-			"Failed to find connected source\n");
-		return -ENODEV;
-	}
-
 	ret = clk_prepare_enable(csi2rx->p_clk);
 	if (ret)
 		return ret;
@@ -321,17 +329,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	reset_control_deassert(csi2rx->sys_rst);
 
-	ret = v4l2_subdev_enable_streams(csi2rx->source_subdev,
-					 remote_pad->index, BIT(0));
-	if (ret)
-		goto err_disable_sysclk;
-
 	clk_disable_unprepare(csi2rx->p_clk);
 
 	return 0;
 
-err_disable_sysclk:
-	clk_disable_unprepare(csi2rx->sys_clk);
 err_disable_pixclk:
 	for (; i > 0; i--) {
 		reset_control_assert(csi2rx->pixel_rst[i - 1]);
@@ -350,7 +351,6 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 {
-	struct media_pad *remote_pad;
 	unsigned int i;
 	u32 val;
 	int ret;
@@ -379,13 +379,6 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 	reset_control_assert(csi2rx->p_rst);
 	clk_disable_unprepare(csi2rx->p_clk);
 
-	remote_pad = media_pad_remote_pad_first(&csi2rx->pads[CSI2RX_PAD_SINK]);
-	if (!remote_pad ||
-	    v4l2_subdev_disable_streams(csi2rx->source_subdev,
-					remote_pad->index, BIT(0))) {
-		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
-	}
-
 	if (csi2rx->dphy) {
 		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
 
@@ -394,47 +387,125 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 	}
 }
 
-static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
+static int csi2rx_enable_streams(struct v4l2_subdev *subdev,
+				 struct v4l2_subdev_state *state, u32 pad,
+				 u64 streams_mask)
 {
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
-	int ret = 0;
+	struct media_pad *remote_pad;
+	u64 sink_streams;
+	int ret;
 
-	if (enable) {
-		ret = pm_runtime_resume_and_get(csi2rx->dev);
-		if (ret < 0)
-			return ret;
+	remote_pad = media_pad_remote_pad_first(&csi2rx->pads[CSI2RX_PAD_SINK]);
+	if (!remote_pad) {
+		dev_err(csi2rx->dev,
+			"Failed to find connected source\n");
+		return -ENODEV;
 	}
 
+	ret = pm_runtime_resume_and_get(csi2rx->dev);
+	if (ret < 0)
+		return ret;
+
+	sink_streams = v4l2_subdev_state_xlate_streams(state, pad,
+						       CSI2RX_PAD_SINK,
+						       &streams_mask);
+
 	mutex_lock(&csi2rx->lock);
+	/*
+	 * If we're not the first users, there's no need to
+	 * enable the whole controller.
+	 */
+	if (!csi2rx->count) {
+		ret = csi2rx_start(csi2rx);
+		if (ret)
+			goto err_stream_start;
+	}
 
-	if (enable) {
-		/*
-		 * If we're not the first users, there's no need to
-		 * enable the whole controller.
-		 */
-		if (!csi2rx->count) {
-			ret = csi2rx_start(csi2rx);
-			if (ret) {
-				pm_runtime_put(csi2rx->dev);
-				goto out;
-			}
-		}
+	/* Start streaming on the source */
+	ret = v4l2_subdev_enable_streams(csi2rx->source_subdev, remote_pad->index,
+					 sink_streams);
+	if (ret) {
+		dev_err(csi2rx->dev,
+			"Failed to start streams %#llx on subdev\n",
+			sink_streams);
+		goto err_subdev_enable;
+	}
 
-		csi2rx->count++;
-	} else {
-		csi2rx->count--;
+	csi2rx->count++;
+	mutex_unlock(&csi2rx->lock);
 
-		/*
-		 * Let the last user turn off the lights.
-		 */
-		if (!csi2rx->count)
-			csi2rx_stop(csi2rx);
+	return 0;
+
+err_subdev_enable:
+	if (!csi2rx->count)
+		csi2rx_stop(csi2rx);
+err_stream_start:
+	mutex_unlock(&csi2rx->lock);
+	pm_runtime_put(csi2rx->dev);
+	return ret;
+}
+
+static int csi2rx_disable_streams(struct v4l2_subdev *subdev,
+				  struct v4l2_subdev_state *state, u32 pad,
+				  u64 streams_mask)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	struct media_pad *remote_pad;
+	u64 sink_streams;
 
-		pm_runtime_put(csi2rx->dev);
+	sink_streams = v4l2_subdev_state_xlate_streams(state, pad,
+						       CSI2RX_PAD_SINK,
+						       &streams_mask);
+
+	remote_pad = media_pad_remote_pad_first(&csi2rx->pads[CSI2RX_PAD_SINK]);
+	if (!remote_pad ||
+	    v4l2_subdev_disable_streams(csi2rx->source_subdev,
+					remote_pad->index, sink_streams)) {
+		dev_err(csi2rx->dev, "Couldn't disable our subdev\n");
 	}
 
-out:
+	mutex_lock(&csi2rx->lock);
+	csi2rx->count--;
+	/*
+	 * Let the last user turn off the lights.
+	 */
+	if (!csi2rx->count)
+		csi2rx_stop(csi2rx);
 	mutex_unlock(&csi2rx->lock);
+
+	pm_runtime_put(csi2rx->dev);
+
+	return 0;
+}
+
+static int csi2rx_s_stream_fallback(struct v4l2_subdev *sd, int enable)
+{
+	struct v4l2_subdev_state *state;
+	struct v4l2_subdev_route *route;
+	u64 mask[CSI2RX_PAD_MAX] = {0};
+	int i, ret;
+
+	/* Find the stream mask on all source pads */
+	state = v4l2_subdev_lock_and_get_active_state(sd);
+	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
+		for_each_active_route(&state->routing, route) {
+			if (route->source_pad == i)
+				mask[i] |= BIT_ULL(route->source_stream);
+		}
+	}
+	v4l2_subdev_unlock_state(state);
+
+	/* Start streaming on each pad */
+	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
+		if (enable)
+			ret = v4l2_subdev_enable_streams(sd, i, mask[i]);
+		else
+			ret = v4l2_subdev_disable_streams(sd, i, mask[i]);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -557,15 +628,17 @@ static int csi2rx_get_frame_desc(struct v4l2_subdev *subdev, unsigned int pad,
 }
 
 static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
-	.enum_mbus_code	= csi2rx_enum_mbus_code,
-	.get_fmt	= v4l2_subdev_get_fmt,
-	.set_fmt	= csi2rx_set_fmt,
-	.get_frame_desc = csi2rx_get_frame_desc,
-	.set_routing	= csi2rx_set_routing,
+	.enum_mbus_code		= csi2rx_enum_mbus_code,
+	.get_fmt		= v4l2_subdev_get_fmt,
+	.set_fmt		= csi2rx_set_fmt,
+	.get_frame_desc		= csi2rx_get_frame_desc,
+	.set_routing		= csi2rx_set_routing,
+	.enable_streams		= csi2rx_enable_streams,
+	.disable_streams	= csi2rx_disable_streams,
 };
 
 static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
-	.s_stream	= csi2rx_s_stream,
+	.s_stream	= csi2rx_s_stream_fallback,
 };
 
 static const struct v4l2_subdev_ops csi2rx_subdev_ops = {

-- 
2.43.0


