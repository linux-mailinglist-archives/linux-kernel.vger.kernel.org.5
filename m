Return-Path: <linux-kernel+bounces-129621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A378B896D79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575F41F27C65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE6B146A6C;
	Wed,  3 Apr 2024 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWvey2PS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C31465BA;
	Wed,  3 Apr 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141804; cv=none; b=LyHlbHOoQ53HHlnxCEcTFrr/okfRmNKCyh/ovatC+Zq3em6WR+b+TZQe5erhZiu4PK2yPlK0UhUD9MZ+FyQU6+p/MVCgmlis+Q9aDYQtjAdyScfHgbbQCv0KLe1vtpyqZ5rKoaodHde//GjMBTpdyRRQ0+XRLRP/tQ88Ko+aA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141804; c=relaxed/simple;
	bh=hRxoDD7imaiqAmKZbABuwgl5WPO11LSbd7ASYZ2xG8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mF1oSHON9Q3qtohPvfli9Q8QCU6dtWn4JZI0ghkZ042UhISPVwPtCXhbUK2iVtnFpUdbLdFaRvDsvdvdS0ZSlkSDQ4sjaLcAORgyr+oLQygfls1dUo5UxVg5hyKy2StJaeJEC3DzMKIYRPR5l6jiygxZYuR97nw4AcUgftDbUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWvey2PS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0CBC433F1;
	Wed,  3 Apr 2024 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712141804;
	bh=hRxoDD7imaiqAmKZbABuwgl5WPO11LSbd7ASYZ2xG8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZWvey2PS5ardF8Uf6eJfXZSAUKEvMRHlEd63RgpHRSe9y/HTcUp8jOh5lFzG7yJ6g
	 3aJ/Uu8CTn5ku83kDi0TRujQV4J/QNaH93g7xLdO/mHIKhJMD5K+C+cgfIlQM9EK8L
	 G5cLLLINCIKNJ2x17X4++/UcXB6aXZwcZ82+c4JjJIjxupEQ7O2frpttqe0wC3wVWu
	 22E06IyYxe30ej+7WamD7X4v0z1bmAwGw8MnYDodtRPVMdI1JJEGD+hm+bVq1d4Rex
	 FQCdUWKkMnh27D8DgQYfCF3CyG2KdztOgFVpsDzxQAcuykOLW2ZAAeHj5vXJmF1L2y
	 7eeaZIeTLMwSw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 03 Apr 2024 12:56:22 +0200
Subject: [PATCH 4/7] ARM: configs: multi_v7: Enable DRM_DW_HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-fix-dw-hdmi-kconfig-v1-4-afbc4a835c38@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hRxoDD7imaiqAmKZbABuwgl5WPO11LSbd7ASYZ2xG8A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGm8plc/n5sqKlU0//Mhv5vebyzu6O1iZNLfyflv89SrP
 9rycr44d0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJnGJlrK/cqMFmtGflLu0b
 j/6cMru2584PQYuV62S/XAhQ1zl4lcnIPG/hTRtPNVV1pYk20T83LmKsT4h/fDi2/PELhzLBOtu
 7ZvEzyvXmMr5ivMyT+TLVYRtzgs4MFs76/s0um14VbZ+YnvELAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Commit 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper
module") turned the DRM_DW_HDMI dependency of DRM_IMX_HDMI,
and ROCKCHIP_DW_HDMI into a depends on which ended up disabling the
drivers in the defconfig. Make sure it's still enabled.

Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 86bf057ac366..9aac9610dd86 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -756,10 +756,11 @@ CONFIG_DRM_TOSHIBA_TC358764=m
 CONFIG_DRM_TOSHIBA_TC358768=m
 CONFIG_DRM_TI_TFP410=m
 CONFIG_DRM_TI_TPD12S015=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
+CONFIG_DRM_DW_HDMI=m
 CONFIG_DRM_STI=m
 CONFIG_DRM_IMX=m
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
 CONFIG_DRM_IMX_TVE=m
 CONFIG_DRM_IMX_LDB=m

-- 
2.44.0


