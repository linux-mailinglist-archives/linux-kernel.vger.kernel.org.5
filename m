Return-Path: <linux-kernel+bounces-129623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7322896D7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5791F290C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EDD1474DA;
	Wed,  3 Apr 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6ypBYwb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF01474C0;
	Wed,  3 Apr 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141811; cv=none; b=aEaGnOQTHPjc/ENPPS8ydRrlzi88bk4QbLOZYUk1qYEEfSXI49eK+IUoOY7ROaeOAyqBfvh+oEiVeMNY+ipNi8BmLEcsJcF00YDXcS2PAXi8tmFU16WC5T2NLm266xpyK2LpG4IhxJAf6TGGdX9EpwU2Qq2LUkU2GysTFbObqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141811; c=relaxed/simple;
	bh=3mo61FFJAiMGTqfs0FY55xf1PPs2Mh8I95J46M8Htgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zvk9MJCE+XJ+rl/av5xSOq+VTnBEfLm0GZphvyYVRpXIgtxb/CdIeocflvenaegKD+S0NSTB9JFfWlqtdFBJ/BwC0ph3C6MPUowFcIG4H503LDqWx1KL1NuWumB6MyKw43tAFQuET47Qu9zpZl7qULQjpe1T2C2+HgDTXfE6BrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6ypBYwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADA7C433F1;
	Wed,  3 Apr 2024 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712141811;
	bh=3mo61FFJAiMGTqfs0FY55xf1PPs2Mh8I95J46M8Htgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i6ypBYwbcpKnT87n7vrxGHvkY93+z1IoYb6Mq8ACXtOYTxUfBfwsFiHBR2nCFvJz6
	 ZNFwgTBpU1pUWv3la0hWnQSLImiL5hxG7op0HmI1zbpUXhPWqJf8mbblnCDBikBgLY
	 VWPGYHAC1TvbUCTcR44KsRvD8y0aI87mtZVsdyBGbiIRFtJtovIw8Z/atCB5NFgcBe
	 8eNWk9X8saUnQIQ845mFR2lv4Es9g5RpM2zQK/xRVhBlfxDGWFZgX09BXlM1cFbLjh
	 dmUZV7mgTnKCqjmfhsvRHvGws55G934q6NVC+oM1nKMrrj8ZYqhwuQYyMncRCuoenY
	 DjtkJUvHWwxpQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 03 Apr 2024 12:56:24 +0200
Subject: [PATCH 6/7] arm64: defconfig: Enable DRM_DW_HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-fix-dw-hdmi-kconfig-v1-6-afbc4a835c38@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3mo61FFJAiMGTqfs0FY55xf1PPs2Mh8I95J46M8Htgg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGm8ptcm9HDybe1bfuD1gceyIXVvYtdYfGBUNjzNLOR1s
 C069u6bjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR3bmMDfNnOvSn7d3O8bRd
 5lldR+a0C56Pzzh1pC5KNVgapKPpIaRhm30g+V50csOehaazMr5tYqwv91V7Yfewb0OlircQ36y
 9t875387rSZRVs9+ZfP5U43fZ1xX2u5ZnxJa4+kabrJRvygUA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Commit 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper
module") turned the DRM_DW_HDMI dependency of ROCKCHIP_DW_HDMI,
DRM_RCAR_DW_HDMI and DRM_IMX8MP_DW_HDMI_BRIDGE into a depends on which
ended up disabling the drivers in the defconfig. Make sure it's still
enabled.

Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 94e677800899..6c223541e4f0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -894,10 +894,11 @@ CONFIG_DRM_TI_SN65DSI86=m
 CONFIG_DRM_ANALOGIX_ANX7625=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_CDNS_MHDP8546=m
 CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE=m
+CONFIG_DRM_DW_HDMI=m
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
 CONFIG_DRM_IMX_DCSS=m
 CONFIG_DRM_V3D=m
 CONFIG_DRM_VC4=m

-- 
2.44.0


