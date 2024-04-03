Return-Path: <linux-kernel+bounces-129624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FB0896D80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC91F291B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36581147C95;
	Wed,  3 Apr 2024 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4xftENI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D90136E1B;
	Wed,  3 Apr 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141815; cv=none; b=gFneVJubk5We0eKXKZLmes8x6scUEZn9uC9n4xPl+QpBIxgrtmJKYpO1n/YEodXQy/qhP/L+lBAaYO/F6bxfLHtOtAXdonxaejftoNsqANHguC9d/jFc3z2c8ZaW/Xu2psrdbX/EDT1Kv21zvRP5UAhfw4jZbr15sFB4ALdkUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141815; c=relaxed/simple;
	bh=SGsUNMWowNJVbrfZv6AOe09LHkFqvTweIgTUuBYCsJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/Cscflcw23D7GKJ8qj8okokexFbLH4wnJaLw0vmW5FnTZSLu1FF5MDXwktvmVIuoSMvzexIcLuQs+OlNO6PciQjNWp3K3F1jeg4p8cDzV8R+3vSimdVFx7TI5Lb/UemV2juAowgqJwpVkwUAoVoVO+gmDaJayFYtzLs1qSHEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4xftENI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCA7C43394;
	Wed,  3 Apr 2024 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712141815;
	bh=SGsUNMWowNJVbrfZv6AOe09LHkFqvTweIgTUuBYCsJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A4xftENIOoscnAgfTZoApvO8L2PFXxc8nSOoDeDb5sxsz5zwhH/YrbLh1YAClg3D6
	 HgNWTrQcY29V+MQvNlDotXunlXHrAt/H3ZTZolnURy7AWqbiPWBCzTlJNFwPkSeVUq
	 7SzffOcmwUT31ZtWdg4GGfQtT2lT/uLHIcdD7BaPPZC4dpNXDt7fDXE4u7RsvS87U+
	 ieWeDe4SDfn6/3PQXfdCWkNRxUkO4UwULfPvQBH7NYMPD8q/tUt6fwLvL22mld+mdN
	 3IbhhxHp7Kxn4DU6cXi3qNS2CvnAkgmwZDXuRVf7CV4pTMX3kWyppvPi+gvVR0bNZ0
	 HRv5TfCRIbzkQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 03 Apr 2024 12:56:25 +0200
Subject: [PATCH 7/7] mips: configs: ci20: Enable DRM_DW_HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-fix-dw-hdmi-kconfig-v1-7-afbc4a835c38@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SGsUNMWowNJVbrfZv6AOe09LHkFqvTweIgTUuBYCsJE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGm8ptePGe5esHmVmdK2uDnPvWsKRR09o/JWP50e0+ESY
 r9W6Pm/jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRvMWMDft8lfbn5+hf3v7k
 2TbXX7O/yXvdSjxaMHXe0h+hStuXPFsy//K9GyJfT7zYZXHfztjN5iBjfe6R40Yelxy/5k2dxfT
 8qc4cr+mXXojfOb37huvGKK43UwMD9dS/SzMaxG9fwfz9RSPvUgA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Commit 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper
module") turned the DRM_DW_HDMI dependency of DRM_INGENIC_DW_HDMI into a
depends on which ended up disabling the drivers in the defconfig. Make
sure it's still enabled.

Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 arch/mips/configs/ci20_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index cdf2a782dee1..0b1c17a650e4 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -120,10 +120,11 @@ CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=m
 CONFIG_IR_GPIO_TX=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_DRM=m
 CONFIG_DRM_DISPLAY_CONNECTOR=m
+CONFIG_DRM_DW_HDMI=m
 CONFIG_DRM_INGENIC=m
 CONFIG_DRM_INGENIC_DW_HDMI=m
 CONFIG_FB=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y

-- 
2.44.0


