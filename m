Return-Path: <linux-kernel+bounces-129622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDBA896D7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23231C215DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E15145B2A;
	Wed,  3 Apr 2024 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E48hk+Tv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FDA146A63;
	Wed,  3 Apr 2024 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141808; cv=none; b=AuqR1sVVKsCd7jJv0XXkrqF8sxYu4S/o23N6jdUFM/+OHV7ErzMas62yOgcKy/CFa1g2N9vYoaQSHsbQ0gpAirLA9v/K/XojbYY3OR7O3M3FEhqw8taIjBkSoGruP4VU4S+6gt9/PfzvDAZ6QTCdyVsEmfJk70aa44p/ZubQg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141808; c=relaxed/simple;
	bh=CEYSKxc9/fJz3vbEKYUzaOLMO0QzBI/jjAKIsOOWwD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4p1FuMJ0DJCHwrQYfQYjUgMe8ErlXuQjesM8QKBr6HXOPzCS7UaZW7bPn1I4egidMHMRb7jy2Cj6s+vAycFOcHVa9BYnomIrPszIcYfsIUOGrHr/npI+xLdwruPxRqH6KcoIFsTaI3vdjQzS6vh+H85u7QU/lCUZpImIr3/8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E48hk+Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D65C433F1;
	Wed,  3 Apr 2024 10:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712141808;
	bh=CEYSKxc9/fJz3vbEKYUzaOLMO0QzBI/jjAKIsOOWwD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E48hk+TvpvqNXZe8Xh8PrAMmcDTh9nTBdtHgsGUMJ8cR+2KnuHLPHwo1YZBmFui0F
	 99FsBScVmveKaM7Yr2mazzaS1/ReFrbl+uXuEd/r8TgKRvL+03bNwh4ahq88L+UkNs
	 BiuVvVGqx7yPbSYhGDQqC2iLQjzyLl5dEYnKqCnLRHmVkBi2k1bT9wttPHVgVRvXwl
	 Evte8ZTeXmqv9UzZ4eauaSPgYVQzmzKp22ELYgeyBhIfy5KFmKEoQHA5PrfoYlK1cf
	 V2YFTmqrrFdHbdJaHdlxlou4Vljuqgndnv7oBC6hRJNkY/rit0KUCP8drTy9E+pPc1
	 5W2IADd5h5Owg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 03 Apr 2024 12:56:23 +0200
Subject: [PATCH 5/7] ARM: configs: sunxi: Enable DRM_DW_HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-fix-dw-hdmi-kconfig-v1-5-afbc4a835c38@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=mripard@kernel.org;
 h=from:subject:message-id; bh=CEYSKxc9/fJz3vbEKYUzaOLMO0QzBI/jjAKIsOOWwD8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGm8ptf+1a+IWTy1bsnzvFtzD/lOUgmIMNVfkBrNfEV5+
 tw7pXP+dExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJhNgyNmzaM+tN5JnVJ6fE
 TzeZvSvg4MWj/6WixMQnHEtbuvTW/nh73Td3PS1PbOHhNq+drSv33J2xvuiR97lrukfLHtyInXT
 Y2uVmtKrGpn9bWI4dKnWev+L6xHNFd2NkFmnwz3a0sokofvhiCwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Commit 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper
module") turned the DRM_DW_HDMI dependency of DRM_SUN8I_DW_HDMI into a
depends on which ended up disabling the driver in the defconfig. Make
sure it's still enabled.

Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index bddc82f78942..a83d29fed175 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -108,10 +108,11 @@ CONFIG_DRM_SUN4I_HDMI_CEC=y
 CONFIG_DRM_SUN8I_DW_HDMI=y
 CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_SIMPLE_BRIDGE=y
+CONFIG_DRM_DW_HDMI=y
 CONFIG_DRM_LIMA=y
 CONFIG_FB_SIMPLE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_SOUND=y

-- 
2.44.0


