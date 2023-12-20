Return-Path: <linux-kernel+bounces-6874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5146F819EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA878B264D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5953A1B3;
	Wed, 20 Dec 2023 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ywssx7Sc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E939862
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703074330;
	bh=qpXtJHOu5jSPOW1f5fkCH+JXOiMtY3P5YzcKQ2FIVkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ywssx7ScKZjCM2E1EcQbkx1F9qHokqUu/A/4/4eRBCWi1Rg05UrivLLMwmzgqCTnW
	 ubFieah8nosM+C42rFcVICmu+qAKFt5b+ZRZVWk/SumefaiWsd+MCIyj3XUdIsERQz
	 YrZPFZdeqHwAqzR7hY1/pRjaYIZNWWD0Ho4ydN+3OdxQv0c7WohDWlJwWjgzSvXdoR
	 aEYd6UsuoHtnv50peP1+gZi81jNZ/x89IeEFrm0HuHkATG8t9m+LT2CQIZ1vQ/kOFO
	 hnV66AB+zBycKo+mCjIQ11LdQ7mOEnfJxsusMGDk0lDcyOx1fBr7AXXvHh9Eb6pEZM
	 KfRsK3ziOhXAg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 682393781FEF;
	Wed, 20 Dec 2023 12:12:05 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	daniels@collabora.com
Cc: david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	emma@anholt.net,
	robdclark@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/8] drm/ci: Rename xfails file
Date: Wed, 20 Dec 2023 17:41:09 +0530
Message-Id: <20231220121110.1441160-8-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220121110.1441160-1-vignesh.raman@collabora.com>
References: <20231220121110.1441160-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the names of xfail files for Mediatek (mt8173 and mt8183),
Rockchip (rk3288 and rk3399), and Meson (g12b) to include
information about the tested driver and whether it is related
to display or GPU testing.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 ...ediatek-mt8173-fails.txt => mediatek-mt8173-display-fails.txt} | 0
 .../xfails/{meson-g12b-fails.txt => panfrost-g12b-gpu-fails.txt}  | 0
 .../{mediatek-mt8183-fails.txt => panfrost-mt8183-gpu-fails.txt}  | 0
 .../{rockchip-rk3288-fails.txt => panfrost-rk3288-gpu-fails.txt}  | 0
 .../{rockchip-rk3288-skips.txt => panfrost-rk3288-gpu-skips.txt}  | 0
 .../{rockchip-rk3399-fails.txt => panfrost-rk3399-gpu-fails.txt}  | 0
 ...{rockchip-rk3399-flakes.txt => panfrost-rk3399-gpu-flakes.txt} | 0
 .../{rockchip-rk3399-skips.txt => panfrost-rk3399-gpu-skips.txt}  | 0
 8 files changed, 0 insertions(+), 0 deletions(-)
 rename drivers/gpu/drm/ci/xfails/{mediatek-mt8173-fails.txt => mediatek-mt8173-display-fails.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{meson-g12b-fails.txt => panfrost-g12b-gpu-fails.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{mediatek-mt8183-fails.txt => panfrost-mt8183-gpu-fails.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3288-fails.txt => panfrost-rk3288-gpu-fails.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3288-skips.txt => panfrost-rk3288-gpu-skips.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3399-fails.txt => panfrost-rk3399-gpu-fails.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3399-flakes.txt => panfrost-rk3399-gpu-flakes.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3399-skips.txt => panfrost-rk3399-gpu-skips.txt} (100%)

diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-display-fails.txt
similarity index 100%
rename from drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
rename to drivers/gpu/drm/ci/xfails/mediatek-mt8173-display-fails.txt
diff --git a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-g12b-gpu-fails.txt
similarity index 100%
rename from drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
rename to drivers/gpu/drm/ci/xfails/panfrost-g12b-gpu-fails.txt
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-mt8183-gpu-fails.txt
similarity index 100%
rename from drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
rename to drivers/gpu/drm/ci/xfails/panfrost-mt8183-gpu-fails.txt
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-gpu-fails.txt
similarity index 100%
rename from drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
rename to drivers/gpu/drm/ci/xfails/panfrost-rk3288-gpu-fails.txt
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-gpu-skips.txt
similarity index 100%
rename from drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt
rename to drivers/gpu/drm/ci/xfails/panfrost-rk3288-gpu-skips.txt
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-gpu-fails.txt
similarity index 100%
rename from drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
rename to drivers/gpu/drm/ci/xfails/panfrost-rk3399-gpu-fails.txt
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-gpu-flakes.txt
similarity index 100%
rename from drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
rename to drivers/gpu/drm/ci/xfails/panfrost-rk3399-gpu-flakes.txt
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-gpu-skips.txt
similarity index 100%
rename from drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt
rename to drivers/gpu/drm/ci/xfails/panfrost-rk3399-gpu-skips.txt
-- 
2.40.1


