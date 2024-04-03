Return-Path: <linux-kernel+bounces-129619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9F9896D75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE34229180E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B756F1420C4;
	Wed,  3 Apr 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4saU+gB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19181420A2;
	Wed,  3 Apr 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141798; cv=none; b=OMZuYCIzNlKWq7i4tLcgwqyKz9FPrgkOy86yZSi9WCt7x5pk7l1lOo1jSnuYu6ufN6VhAY2Npk0sguheBgJVXgU+m0lk4p4L/NjlijtSo4gi2KpQmrPnqtN/YuEM5bGgwudhdS7FgNy/iV1Z5XW0FNwbax3DKni02RCdn+nLL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141798; c=relaxed/simple;
	bh=essT2gmVUrOc7Cw4K2ZibtfRzgva+f93K2koeKBfwls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIosNP152vGbztwFsUN9qWZsO+A2TDowVVbKQmqzA421nUN1Wl6XAb879QoP1MFt1c2GuoyVhVZJfSY4UlAZOw1odE2IyJ3T4t01MntHdrrg5ei1O0SLZZwpXKuIokZpV4WkQFbri4CfXkdD0r1xprc10dLIYkCB1eaACsom0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4saU+gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E58C43390;
	Wed,  3 Apr 2024 10:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712141797;
	bh=essT2gmVUrOc7Cw4K2ZibtfRzgva+f93K2koeKBfwls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K4saU+gBr0XDielGIRTDOuCWLb4Lz5W4qOPKI8/Jr9/mikGo30K2KIewnD0EHafjo
	 sKa25SwOEmjFkssnQ7Ou0WUIvHfpo2/9Lu17oYGSHWRP/8SnVe5IjheG5NH3MGfrpE
	 TV2CrZGJfly8AZ/W2ZTIYP0jQupNaFOcxyyJ0Gu57O0LQ48M5Xv313Sw97Th6u3Kcm
	 DyFUFy4mWta2RX77e2i2AzHbBdKOzwtRgYzA0hbeW3uY2mV0i/wHq3qSgV2b4hQL9u
	 +wmPJ5Nhmf1VTIVnszXnxjSQf6Bp5tT5mxuOcaW3M9TInwOGxZz8eVMtKAhtgsY0lA
	 O1jJG0zZZahyw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 03 Apr 2024 12:56:20 +0200
Subject: [PATCH 2/7] drm/bridge: dw-hdmi: Make DRM_DW_HDMI selectable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-fix-dw-hdmi-kconfig-v1-2-afbc4a835c38@kernel.org>
References: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
In-Reply-To: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Mark Brown <broonie@kernel.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-mips@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=mripard@kernel.org;
 h=from:subject:message-id; bh=essT2gmVUrOc7Cw4K2ZibtfRzgva+f93K2koeKBfwls=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGm8pldCHq+bu7bodLBizkWJVSsm//95Zrnl2v62dYzPX
 kwXzGE62TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmYhLD2LDs0OXKe0f6jN4v
 cE+bE7ksRsKqSTVnHsPk1ZNvpttd6zBZPHdf5pRKj2WLJkj+15m76AJjfS3/i59d0gmHWEWeW/L
 mK9anJykfswxqXRY3JUpklU2HwLadIQ25R67nv7m5aYu8vf1zAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Commit c0e0f139354c ("drm: Make drivers depends on DRM_DW_HDMI") turned
select dependencies into depends on ones. However, DRM_DW_HDMI was not
manually selectable which resulted in no way to enable the drivers that
were now depending on it.

Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
index 387f5bd86089..1252fd30d4a4 100644
--- a/drivers/gpu/drm/bridge/synopsys/Kconfig
+++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_DW_HDMI
-	tristate
+	tristate "Synopsys Designware HDMI TX Controller"
 	depends on DRM_DISPLAY_HDMI_HELPER
 	depends on DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
 	select REGMAP_MMIO
 	select CEC_CORE if CEC_NOTIFIER

-- 
2.44.0


