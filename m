Return-Path: <linux-kernel+bounces-123091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737CB890201
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596501C2B4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220F12FF60;
	Thu, 28 Mar 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6mXgQ3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263912F59E;
	Thu, 28 Mar 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636529; cv=none; b=Rj6N+w7H9XDPWfKezDIzd8VpO/qDNEI6r1oKUYfh0NiNCiyWt5gahsTF//0xNcNh0xQdpkzEu6z6VKU0G6YRKOPwoqWhU7YG7Upez+N7gWSttEZprAutknacFoCseCdi7/i2skCrU5OSVE92UDY1DUsL6WxARB6+3MQa2GNVrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636529; c=relaxed/simple;
	bh=Kr9lQ3sO2i8J+JqxBgX/JkrQt58EHLLHgmBCd+Xz7iY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byoQSa28hLg/1JGj+JFehepYTy1wRlEZqRvLAXwDPjU/OCj96s2XwEdn1q5X63wJRStDRLwCwKmz68lZJsx4/fI95WpeJ7/6UCLms1+C0K1iZGQCvDK87fU8MMffIHVwDqmusdCbux3Q6RPS2V6y4x0WPAMj+3bOlruimrPR6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6mXgQ3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D270C4166B;
	Thu, 28 Mar 2024 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636529;
	bh=Kr9lQ3sO2i8J+JqxBgX/JkrQt58EHLLHgmBCd+Xz7iY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s6mXgQ3VfJMRXPIHeqp54ulRg1m7Q8tLnbwpIR1GiaLXoMvoJLtEybBSe8lHYHb0o
	 7k7rikFnytieQPO0JXQkRSY9HgsKoH5CMPfpdKFAQNSpqqVMm/QWOMK+/K9aOqZihD
	 SqYWJ6pg1s+pj0n1E9CVVwUrvFMJtFpr2IqfUnlyICq98oQ4xgMdjDWr6vsXnAVb6u
	 fGPsyPEgkcmM9Jb/jsivc9J3zpjumLKxVV9jWqgCJJO3zteRg03vrpZ2lT86qczji3
	 zERN52E2SKLqk9qh1wzr8XWlFFbpwrlhb32WHaREUcXx6ZKOeARQZggCLOmiZmEAAo
	 7jnieO1JfadhQ==
From: Bjorn Andersson <andersson@kernel.org>
Date: Thu, 28 Mar 2024 07:40:05 -0700
Subject: [PATCH v2 6/6] drm/msm/dp: Use function arguments for audio
 operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-msm-dp-cleanup-v2-6-a5aed9798d32@quicinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8343;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=LkCwztOrVV+hfqYB41Cl8YqF/cppd90OpyDB9gSFXnA=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmBYFIC0R8+CRkJwGR7ZPxfU8HQh/c3dF+taX28
 mTd0sRZ4DeJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZgWBSBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcWRuA/5AUu0jBvNPPxQCAtzZNSeEQwpKTLJlBBzNy9rpvf
 KB3kZwAQ/ZtMX7SsvbMdZxuWeKDkenrsQ7ay3kC+xGSzln86OsRJzNgJY3TWkP++flaw9xRErVX
 5LPykqHf1VEYahW+fiiURKOFhIbuZ/kMEZ/a072GSR1JA+D5AQaj83pyaiQMz5HAoSUsP3dVkzv
 8/4tLnISk/qyM30K54DSKwzxm+uY8dvShrp5gNQa5yLv1q9rm335NrzDKlRKCa7S52ZTerVI57C
 2Tnr3hjBIHpfECwOAvZmuLZ0ZLNxwOf8NtF34Rlsz84wsHfGZ3CFG4W+ENPQuY/vPima/UG6Mbw
 RUr4luJ9GJf+8g3HTdbH8sKtkb8MJSPcxwiYnCXSUqg1lh16dZf/u0TQ/WMd/YaqG76Tc2ikZWB
 XGjT7D03SabYVv/WHDYqNZ5FSzm1UzobPnVySd2/dgfwrDbfJs5vMGux/s1QuZgtaJ3kBYo09JH
 LC8BcfCMPVPq4diYYmGkbjJoYOPQrClEm0Cu5BdxwqX2w1vuNVm0+nh4NljeGQrzFlQME3EAmxW
 pA0fzyW9+gT0zI7iYozxGKiuO9lRmmgnaBtQZXhb9MyuRWO/4vYidLBjO+Yz7FEnL05Gr9K6f6s
 M+7JXR60U6nbN5/W4hEEe0j9GktxdRh2iirFjKyMmEjs=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

The dp_audio read and write operations uses members in struct dp_catalog
for passing arguments and return values. This adds unnecessary
complexity to the implementation, as it turns out after detangling the
logic that no state is actually held in these variables.

Clean this up by using function arguments and return values for passing
the data.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   | 20 +++++--------------
 drivers/gpu/drm/msm/dp/dp_catalog.c | 39 +++++++++++++------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h | 18 +++++++++--------
 3 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 7fd0c1793ba3..a599fc5d63c5 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -32,11 +32,7 @@ static u32 dp_audio_get_header(struct dp_catalog *catalog,
 		enum dp_catalog_audio_sdp_type sdp,
 		enum dp_catalog_audio_header_type header)
 {
-	catalog->sdp_type = sdp;
-	catalog->sdp_header = header;
-	dp_catalog_audio_get_header(catalog);
-
-	return catalog->audio_data;
+	return dp_catalog_audio_get_header(catalog, sdp, header);
 }
 
 static void dp_audio_set_header(struct dp_catalog *catalog,
@@ -44,10 +40,7 @@ static void dp_audio_set_header(struct dp_catalog *catalog,
 		enum dp_catalog_audio_sdp_type sdp,
 		enum dp_catalog_audio_header_type header)
 {
-	catalog->sdp_type = sdp;
-	catalog->sdp_header = header;
-	catalog->audio_data = data;
-	dp_catalog_audio_set_header(catalog);
+	dp_catalog_audio_set_header(catalog, sdp, header, data);
 }
 
 static void dp_audio_stream_sdp(struct dp_audio_private *audio)
@@ -317,8 +310,7 @@ static void dp_audio_setup_acr(struct dp_audio_private *audio)
 		break;
 	}
 
-	catalog->audio_data = select;
-	dp_catalog_audio_config_acr(catalog);
+	dp_catalog_audio_config_acr(catalog, select);
 }
 
 static void dp_audio_safe_to_exit_level(struct dp_audio_private *audio)
@@ -344,16 +336,14 @@ static void dp_audio_safe_to_exit_level(struct dp_audio_private *audio)
 		break;
 	}
 
-	catalog->audio_data = safe_to_exit_level;
-	dp_catalog_audio_sfe_level(catalog);
+	dp_catalog_audio_sfe_level(catalog, safe_to_exit_level);
 }
 
 static void dp_audio_enable(struct dp_audio_private *audio, bool enable)
 {
 	struct dp_catalog *catalog = audio->catalog;
 
-	catalog->audio_data = enable;
-	dp_catalog_audio_enable(catalog);
+	dp_catalog_audio_enable(catalog, enable);
 }
 
 static struct dp_audio_private *dp_audio_get_data(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 00ad3ebaa5a1..970d62e1610c 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -1159,34 +1159,28 @@ struct dp_catalog *dp_catalog_get(struct device *dev)
 	return &catalog->dp_catalog;
 }
 
-void dp_catalog_audio_get_header(struct dp_catalog *dp_catalog)
+u32 dp_catalog_audio_get_header(struct dp_catalog *dp_catalog,
+				enum dp_catalog_audio_sdp_type sdp,
+				enum dp_catalog_audio_header_type header)
 {
 	struct dp_catalog_private *catalog;
 	u32 (*sdp_map)[DP_AUDIO_SDP_HEADER_MAX];
-	enum dp_catalog_audio_sdp_type sdp;
-	enum dp_catalog_audio_header_type header;
-
-	if (!dp_catalog)
-		return;
 
 	catalog = container_of(dp_catalog,
 		struct dp_catalog_private, dp_catalog);
 
 	sdp_map = catalog->audio_map;
-	sdp     = dp_catalog->sdp_type;
-	header  = dp_catalog->sdp_header;
 
-	dp_catalog->audio_data = dp_read_link(catalog,
-			sdp_map[sdp][header]);
+	return dp_read_link(catalog, sdp_map[sdp][header]);
 }
 
-void dp_catalog_audio_set_header(struct dp_catalog *dp_catalog)
+void dp_catalog_audio_set_header(struct dp_catalog *dp_catalog,
+				 enum dp_catalog_audio_sdp_type sdp,
+				 enum dp_catalog_audio_header_type header,
+				 u32 data)
 {
 	struct dp_catalog_private *catalog;
 	u32 (*sdp_map)[DP_AUDIO_SDP_HEADER_MAX];
-	enum dp_catalog_audio_sdp_type sdp;
-	enum dp_catalog_audio_header_type header;
-	u32 data;
 
 	if (!dp_catalog)
 		return;
@@ -1195,17 +1189,14 @@ void dp_catalog_audio_set_header(struct dp_catalog *dp_catalog)
 		struct dp_catalog_private, dp_catalog);
 
 	sdp_map = catalog->audio_map;
-	sdp     = dp_catalog->sdp_type;
-	header  = dp_catalog->sdp_header;
-	data    = dp_catalog->audio_data;
 
 	dp_write_link(catalog, sdp_map[sdp][header], data);
 }
 
-void dp_catalog_audio_config_acr(struct dp_catalog *dp_catalog)
+void dp_catalog_audio_config_acr(struct dp_catalog *dp_catalog, u32 select)
 {
 	struct dp_catalog_private *catalog;
-	u32 acr_ctrl, select;
+	u32 acr_ctrl;
 
 	if (!dp_catalog)
 		return;
@@ -1213,7 +1204,6 @@ void dp_catalog_audio_config_acr(struct dp_catalog *dp_catalog)
 	catalog = container_of(dp_catalog,
 		struct dp_catalog_private, dp_catalog);
 
-	select = dp_catalog->audio_data;
 	acr_ctrl = select << 4 | BIT(31) | BIT(8) | BIT(14);
 
 	drm_dbg_dp(catalog->drm_dev, "select: %#x, acr_ctrl: %#x\n",
@@ -1222,10 +1212,9 @@ void dp_catalog_audio_config_acr(struct dp_catalog *dp_catalog)
 	dp_write_link(catalog, MMSS_DP_AUDIO_ACR_CTRL, acr_ctrl);
 }
 
-void dp_catalog_audio_enable(struct dp_catalog *dp_catalog)
+void dp_catalog_audio_enable(struct dp_catalog *dp_catalog, bool enable)
 {
 	struct dp_catalog_private *catalog;
-	bool enable;
 	u32 audio_ctrl;
 
 	if (!dp_catalog)
@@ -1234,7 +1223,6 @@ void dp_catalog_audio_enable(struct dp_catalog *dp_catalog)
 	catalog = container_of(dp_catalog,
 		struct dp_catalog_private, dp_catalog);
 
-	enable = !!dp_catalog->audio_data;
 	audio_ctrl = dp_read_link(catalog, MMSS_DP_AUDIO_CFG);
 
 	if (enable)
@@ -1329,10 +1317,10 @@ void dp_catalog_audio_init(struct dp_catalog *dp_catalog)
 	catalog->audio_map = sdp_map;
 }
 
-void dp_catalog_audio_sfe_level(struct dp_catalog *dp_catalog)
+void dp_catalog_audio_sfe_level(struct dp_catalog *dp_catalog, u32 safe_to_exit_level)
 {
 	struct dp_catalog_private *catalog;
-	u32 mainlink_levels, safe_to_exit_level;
+	u32 mainlink_levels;
 
 	if (!dp_catalog)
 		return;
@@ -1340,7 +1328,6 @@ void dp_catalog_audio_sfe_level(struct dp_catalog *dp_catalog)
 	catalog = container_of(dp_catalog,
 		struct dp_catalog_private, dp_catalog);
 
-	safe_to_exit_level = dp_catalog->audio_data;
 	mainlink_levels = dp_read_link(catalog, REG_DP_MAINLINK_LEVELS);
 	mainlink_levels &= 0xFE0;
 	mainlink_levels |= safe_to_exit_level;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index a82ab4856b50..cd1ad046a953 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -48,9 +48,6 @@ enum dp_catalog_audio_header_type {
 };
 
 struct dp_catalog {
-	enum dp_catalog_audio_sdp_type sdp_type;
-	enum dp_catalog_audio_header_type sdp_header;
-	u32 audio_data;
 	bool wide_bus_en;
 };
 
@@ -114,12 +111,17 @@ void dp_catalog_panel_tpg_disable(struct dp_catalog *dp_catalog);
 struct dp_catalog *dp_catalog_get(struct device *dev);
 
 /* DP Audio APIs */
-void dp_catalog_audio_get_header(struct dp_catalog *catalog);
-void dp_catalog_audio_set_header(struct dp_catalog *catalog);
-void dp_catalog_audio_config_acr(struct dp_catalog *catalog);
-void dp_catalog_audio_enable(struct dp_catalog *catalog);
+u32 dp_catalog_audio_get_header(struct dp_catalog *dp_catalog,
+				enum dp_catalog_audio_sdp_type sdp,
+				enum dp_catalog_audio_header_type header);
+void dp_catalog_audio_set_header(struct dp_catalog *dp_catalog,
+				 enum dp_catalog_audio_sdp_type sdp,
+				 enum dp_catalog_audio_header_type header,
+				 u32 data);
+void dp_catalog_audio_config_acr(struct dp_catalog *catalog, u32 select);
+void dp_catalog_audio_enable(struct dp_catalog *catalog, bool enable);
 void dp_catalog_audio_config_sdp(struct dp_catalog *catalog);
 void dp_catalog_audio_init(struct dp_catalog *catalog);
-void dp_catalog_audio_sfe_level(struct dp_catalog *catalog);
+void dp_catalog_audio_sfe_level(struct dp_catalog *catalog, u32 safe_to_exit_level);
 
 #endif /* _DP_CATALOG_H_ */

-- 
2.43.0


