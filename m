Return-Path: <linux-kernel+bounces-152399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073318ABDD8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 02:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B562817C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 00:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13C1139D;
	Sun, 21 Apr 2024 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="IpnHOKUG"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187514C6C
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713659040; cv=none; b=ri3n2wKcOrIY4ZLZwQQp62XUKW8BagLe1Sgsyovbp0W7HSezZmITF/CRL79CqQ1V17sryDyfZzl7/KSwM/d/vX46NtfoeXXNnbVDdOFV6mnrWc0dNWPTmV/l5i2u0+flBsrN7vb4NWPn3SFtG0GwOGUkWQK0csfnTkfaEDOwj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713659040; c=relaxed/simple;
	bh=5WIHDz9j3J8qVLPTmDc6NzHreB/LUYrkwR7a5KRFH0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZAqrX+9JPOxYJYravzFx0g/QL62BFmM7DR/AzHC0hPyI2hxHcduifZo7sPas6ouskbu+J03s43bIhn1hVwzz4keM04DmZi3dDeJkxhpPX0tD+EdJjsLFEtzR1wrJpjFIicLdm6nndLXuyJKOFkvzdyn1fptKiJc5/xJxLpcpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=IpnHOKUG; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 913C48825A;
	Sun, 21 Apr 2024 02:23:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713659029;
	bh=CdPWfkaruhSSMkZ/UtsjxPabArNBr6LA6zfCTatS0Jc=;
	h=From:To:Cc:Subject:Date:From;
	b=IpnHOKUG7bulT3vvIpV8UDEa2LSDein+QidY7g1abrucwskWoPj4KuOEkMl+T7p/Z
	 yto+PwSnvURcAC1PBgKG4Oa0GFRWokJbHs20LhFVTp5+CQZTccnMpwm+/VwMr6+9TB
	 U2x5OmX5qvgd9bsbNbTH2o3+Avy9Bfzhv/hRsmf0AOfOgTsy5pE2WfWv0NgtwubmoC
	 zvRFpmvb5Z3++kJQAm8dnG0rIBC4bndXs5ktS59VDWG3A6BKpjT3+62hxrz/GFWT01
	 0msI++wh/2JBA8zBcmR9+T6KBWP65PntQSUiZlWFY4JcvsuAA47MYDK9k7XaHU1sIX
	 SwZmTjEJJ5oKQ==
From: Marek Vasut <marex@denx.de>
To: dri-devel@lists.freedesktop.org
Cc: Marek Vasut <marex@denx.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Ondrej Jirman <megi@xff.cz>,
	Rob Herring <robh@kernel.org>,
	Robert Foss <rfoss@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] drm: bridge: dw-mipi-dsi: Call modeset in modeset callback
Date: Sun, 21 Apr 2024 02:22:35 +0200
Message-ID: <20240421002330.172723-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Doing modeset in .atomic_pre_enable callback instead of dedicated .mode_set
callback does not seem right. Undo this change, which was added as part of
commit 05aa61334592 ("drm: bridge: dw-mipi-dsi: Fix enable/disable of DSI
controller") as it breaks STM32MP15xx LTDC scanout (DSI)->TC358762 DSI-to-DPI
bridge->PT800480 DPI panel pipeline. The original fix for HX8394 panel likely
requires HX8394 panel side fix instead.

Fixes: 05aa61334592 ("drm: bridge: dw-mipi-dsi: Fix enable/disable of DSI controller")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@gmail.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Liu Ying <victor.liu@nxp.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ondrej Jirman <megi@xff.cz>
Cc: Rob Herring <robh@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 824fb3c65742e..ca5894393dba4 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -268,7 +268,6 @@ struct dw_mipi_dsi {
 	struct dw_mipi_dsi *master; /* dual-dsi master ptr */
 	struct dw_mipi_dsi *slave; /* dual-dsi slave ptr */
 
-	struct drm_display_mode mode;
 	const struct dw_mipi_dsi_plat_data *plat_data;
 };
 
@@ -1016,25 +1015,15 @@ static void dw_mipi_dsi_mode_set(struct dw_mipi_dsi *dsi,
 		phy_ops->power_on(dsi->plat_data->priv_data);
 }
 
-static void dw_mipi_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
-						 struct drm_bridge_state *old_bridge_state)
-{
-	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
-
-	/* Power up the dsi ctl into a command mode */
-	dw_mipi_dsi_mode_set(dsi, &dsi->mode);
-	if (dsi->slave)
-		dw_mipi_dsi_mode_set(dsi->slave, &dsi->mode);
-}
-
 static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
 					const struct drm_display_mode *mode,
 					const struct drm_display_mode *adjusted_mode)
 {
 	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
 
-	/* Store the display mode for later use in pre_enable callback */
-	drm_mode_copy(&dsi->mode, adjusted_mode);
+	dw_mipi_dsi_mode_set(dsi, adjusted_mode);
+	if (dsi->slave)
+		dw_mipi_dsi_mode_set(dsi->slave, adjusted_mode);
 }
 
 static void dw_mipi_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
@@ -1090,7 +1079,6 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
 	.atomic_get_input_bus_fmts = dw_mipi_dsi_bridge_atomic_get_input_bus_fmts,
 	.atomic_check		= dw_mipi_dsi_bridge_atomic_check,
 	.atomic_reset		= drm_atomic_helper_bridge_reset,
-	.atomic_pre_enable	= dw_mipi_dsi_bridge_atomic_pre_enable,
 	.atomic_enable		= dw_mipi_dsi_bridge_atomic_enable,
 	.atomic_post_disable	= dw_mipi_dsi_bridge_post_atomic_disable,
 	.mode_set		= dw_mipi_dsi_bridge_mode_set,
-- 
2.43.0


