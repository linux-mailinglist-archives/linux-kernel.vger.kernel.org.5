Return-Path: <linux-kernel+bounces-129620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD0896D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAB7B29EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8F5146595;
	Wed,  3 Apr 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzzHbB+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1841420A2;
	Wed,  3 Apr 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141801; cv=none; b=YxQGFQM8a6PSmYCVq52rEIK/k5Qhg4J9J3YgAJlH5uiYBJuUwMeITNaWYf3M7zqylGLIMagWAWzoKnB8pzs38Muyt7mviNgWbq7wUMfNFd/HBL9r1G7LIxaomX3AApw6SrUlcUDXJRNmr7csCRUfpUiGg+FvrysPELq8NkZH1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141801; c=relaxed/simple;
	bh=9plj7YiU9auK+f7YjWOK8gl9mw2KJr5+ajBQVrjClN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZJXisy5TVHgT3rA87Swc7f+IxH6RTuhB5ya7q+ALyqorjw8AO0ThyBklSLws4pVSyFU5USEQLwon9caL3RqUpIsMAFZG48VEDaaznKvguT0qUwf+Zvb2kv5Y+IqxFWwPGoHjqWTbmcWz9EHBvitWGRSwSLSZNTfHaJ/Pr4CmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzzHbB+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F2DC433F1;
	Wed,  3 Apr 2024 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712141801;
	bh=9plj7YiU9auK+f7YjWOK8gl9mw2KJr5+ajBQVrjClN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SzzHbB+Elcy7Y9N22oiH7igCNRW5Q7aQHnuXxvy6mMhh4MXbEOIUa6lJmg51ONcev
	 n/2oT2gKtVnDylM+wf+wdTcSzuRq6gp1cptAaNpMci32Bp+g3UcFpuyzqtv2WBg6gU
	 lCcVmrdfPdaDozt3epPfOAwtuPUUGrYbpSjR2T4zYaf1AjtnQZYfzP5YMh4OVWMjP5
	 n9hjznxyLgLo09XTR/AGt+WwUOeNARdccGoVjAYJkK9t7OV1s2wJm96c1wdCAJlIMC
	 5v0sjKcpriuqgSxQ7/clA8WSKnRxjXcASfwQXK5r2S1Go+HgE8qmvf42/UgMiXwufI
	 wVIC7/6JvDWaQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 03 Apr 2024 12:56:21 +0200
Subject: [PATCH 3/7] ARM: configs: imx_v6_v7: Enable DRM_DW_HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-fix-dw-hdmi-kconfig-v1-3-afbc4a835c38@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9plj7YiU9auK+f7YjWOK8gl9mw2KJr5+ajBQVrjClN0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGm8plffP9u6RKTZt6VqZ4VJcOGOt1MK7h2NujgrXOh5a
 n8zQydbx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZgI13zGKuZNRbE3JitqHWG8
 8TL9iQLbCZU1PKVXaz/KsVnqfg89xr7pc8/hgoIdSeuvHroS21Nhy1hn/fC12Wv2zsoz7K1vTsu
 9D3lp0v1t7u5tv51OxO3o8PV1TZ4UZ9C4s9Zx1SJNE8e+8AMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Commit 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper
module") turned the DRM_DW_HDMI dependency of DRM_IMX_HDMI into a
depends on which ended up disabling the driver in the defconfig. Make
sure it's still enabled.

Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 7327fce87808..294c0c3df370 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -281,10 +281,11 @@ CONFIG_DRM_MSM=y
 CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
 CONFIG_DRM_TI_TFP410=y
+CONFIG_DRM_DW_HDMI=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y
 CONFIG_DRM_IMX=y
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_TVE=y

-- 
2.44.0


