Return-Path: <linux-kernel+bounces-48170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C161845836
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5746A28E664
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F267F5336E;
	Thu,  1 Feb 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GdFp4wvJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B24D9E9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791996; cv=none; b=V/YMTcvT6YT6CTMVrkmj/yyZCvDcFW3o1bhCHhC9rHcsiJfFyQPPMOjtqVrI0xCMId20uKpXytswGwErmbfpfpeNsrFlCt3uER20EqzohtKHNkn/Ec9JA8K00f91XbhopGVgRODAgxSerL3dEPu1pwcE50cgAzdyPczydCxn5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791996; c=relaxed/simple;
	bh=NNwf1FU4iKYIcxafPzqdiApb/zXktJGn2dDrtHe6Qpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PS+ff1YETKDYcZXU+/kH++jx/9RUF6CdtG+6Znx5UxnqYXnwrXE1Tpj1AqUloDn6+g9nQ7jjb8hGrKhO5VtCpXN/GKIyLFwIhpZdlzjnYo0lRjY8++exrQsDyQE7po00zb8VwM26JD4mpso3Iu/OQbNfpWH+KOvjkEuWKLAUMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GdFp4wvJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706791992;
	bh=NNwf1FU4iKYIcxafPzqdiApb/zXktJGn2dDrtHe6Qpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdFp4wvJjncBQA1ogeJl0aGoGyBzQAiBITHtesgYh+D8i99YIOKoDHBN9JMOXYWrd
	 XieFPVy9ILHGZxJKGMtBBNgbGvuZW5zNf2mSxyzXIWIfXh1o4ZjXFjM8k40qjAy7xU
	 zhi8QdKx1Q8pZvl2pnB+gj45HUcDmWxD5Hj/zckFnXLc02XQFHxc4NpLOjSNetFXXg
	 TBJa+uGUQlwZ8/XX3X741vIbuK2cqrpf9qpJXLbAkUyMgOqvQNnvxGrO4/1/KURz3g
	 mHPQGHjrcCrmIkZUjN/ofAuiOMlpNqAbmPfMTs5d8xZbWCzmzYU7BlVu6qwkGJ7o3G
	 FpO0XvB3xEBhQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC492378208C;
	Thu,  1 Feb 2024 12:53:11 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	nancy.lin@mediatek.com,
	nathan.lu@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org
Subject: [PATCH 1/3] drm/mediatek: drm_ddp_comp: Fix and cleanup DDP component CRTC search
Date: Thu,  1 Feb 2024 13:53:02 +0100
Message-ID: <20240201125304.218467-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
References: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finding a possible CRTC by DDP component is done by first checking
static routes in three paths (main, external, third/extra path) and
then, if not found, we check for dynamic connection on a per-route
basis because, for example, on some SoCs the main route may output
to either a DSI display or DisplayPort and this is finally done by
assigning a CRTC mask to `possible_crtcs`, found with function
mtk_drm_find_comp_in_ddp_conn_path(): being that a mask the possible
values are BIT(x) and, if no CRTC is possible, zero.

Problem is, both mtk_drm_find_possible_crtc_by_comp() and the
aforementioned function are trying to return a negative error value
(but it's unsigned int!) if no CRTC was found, which is wrong for
multiple obvious reasons.

Cleanup both functions, so that:
 - mtk_drm_find_comp_in_ddp_conn_path() returns a signed integer
   with a negative number for error, or a bit/bitmask of the found
   possible CRTC; and
 - mtk_drm_find_possible_crtc_by_comp() always returns either a
   bitmask of the possible CRTC, or zero if none available.

Fixes: 01389b324c97 ("drm/mediatek: Add connector dynamic selection capability")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 44 ++++++++++-----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index a9b5a21cde2d..c13359eeb3cd 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -513,29 +513,25 @@ static bool mtk_drm_find_comp_in_ddp(struct device *dev,
 	return false;
 }
 
-static unsigned int mtk_drm_find_comp_in_ddp_conn_path(struct device *dev,
-						       const struct mtk_drm_route *routes,
-						       unsigned int num_routes,
-						       struct mtk_ddp_comp *ddp_comp)
+static int mtk_drm_find_comp_in_ddp_conn_path(struct device *dev,
+					      const struct mtk_drm_route *routes,
+					      unsigned int num_routes,
+					      struct mtk_ddp_comp *ddp_comp)
 {
-	int ret;
-	unsigned int i;
+	int i;
 
-	if (!routes) {
-		ret = -EINVAL;
-		goto err;
+	if (!routes || !num_routes) {
+		DRM_ERROR("No connection routes specified!\n");
+		return -EINVAL;
 	}
 
 	for (i = 0; i < num_routes; i++)
 		if (dev == ddp_comp[routes[i].route_ddp].dev)
 			return BIT(routes[i].crtc_id);
 
-	ret = -ENODEV;
-err:
-
-	DRM_INFO("Failed to find comp in ddp table, ret = %d\n", ret);
+	DRM_ERROR("Failed to find component in ddp table\n");
 
-	return 0;
+	return -ENODEV;
 }
 
 int mtk_ddp_comp_get_id(struct device_node *node,
@@ -557,22 +553,24 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
 						struct device *dev)
 {
 	struct mtk_drm_private *private = drm->dev_private;
-	unsigned int ret = 0;
+	int ret;
 
 	if (mtk_drm_find_comp_in_ddp(dev, private->data->main_path, private->data->main_len,
 				     private->ddp_comp))
-		ret = BIT(0);
+		return BIT(0);
 	else if (mtk_drm_find_comp_in_ddp(dev, private->data->ext_path,
 					  private->data->ext_len, private->ddp_comp))
-		ret = BIT(1);
+		return BIT(1);
 	else if (mtk_drm_find_comp_in_ddp(dev, private->data->third_path,
 					  private->data->third_len, private->ddp_comp))
-		ret = BIT(2);
-	else
-		ret = mtk_drm_find_comp_in_ddp_conn_path(dev,
-							 private->data->conn_routes,
-							 private->data->num_conn_routes,
-							 private->ddp_comp);
+		return BIT(2);
+
+	ret = mtk_drm_find_comp_in_ddp_conn_path(dev, private->data->conn_routes,
+						 private->data->num_conn_routes,
+						 private->ddp_comp);
+	/* No CRTC is available: return a zero mask */
+	if (ret < 0)
+		return 0;
 
 	return ret;
 }
-- 
2.43.0


