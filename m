Return-Path: <linux-kernel+bounces-121261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C7488E47A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392402A480B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1541B530F;
	Wed, 27 Mar 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qea+K034"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE22142902;
	Wed, 27 Mar 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542489; cv=none; b=SgmDjyzs1lyk8I3OBGyRTK3Jf1Dy/JHJjChMxfzteBCz5M80NiPVhvFqSt+KQYf/onRmCsGKU/v1vymKVj28N+AKrpX/r8wXjCGRo+AmqlCNVy+PNja7XOtAV7DAAoakTdyKk90SIzC2e198Xhcjc2tzRUnJGiqw2FqHNhJgJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542489; c=relaxed/simple;
	bh=8rHkXgsNXtISc0+6xFhktGiHJ0cO+8sY0nyEZ1IjZdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsTDS3rf+esnLVbtO+I+cEOQ1RP/ssI27VxkYZ+GEhLKvAZd9Wm6U6Cdidy9TFQII6PlR9b5C6ZN3IqNCs5PaLEEMkgZQSjSKwvLlcqWI9YSr6hjj10JpSKkNW2lzNllWCfJjrDGR2/EFthTTrAeoWuuMJSdzJDVBwkuMuVLic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qea+K034; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04F2C433C7;
	Wed, 27 Mar 2024 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542488;
	bh=8rHkXgsNXtISc0+6xFhktGiHJ0cO+8sY0nyEZ1IjZdQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qea+K034Ofey84Kuwbni/D+h6Q+wE5pDtxiI736++iHFxUAqLpQgPsrQun5hy642C
	 J5tEvFL0364z7lUXUvouYjSUOSuempDNk0p/w/ymAxuoKus3OGQ0fcMQjrrCOj6mDM
	 9IQqwHR22PBL5eTxYgY9C9Lh2a0o6U4IeNGyqw6LkNiw/JpkHuR4Bvr5doGgSsy3ZP
	 JQezNHomK/gTBu/FrVsdrErGAxPWh0Zf4uhZpgTJhoCU+ZsZe5I6OfVx0WDI5d77Va
	 0VNIfakXRX5aLN45oYBi0iUtlY71edqDv1jU4RHYqonOnYLSs0UY+aY4UTbVrtsK0C
	 kJpobKxdaGvxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jani.nikula@intel.com
Cc: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/exynos: do not return negative values from .get_modes()" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:06 -0400
Message-ID: <20240327122806.2842495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 13d5b040363c7ec0ac29c2de9cf661a24a8aa531 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 8 Mar 2024 18:03:41 +0200
Subject: [PATCH] drm/exynos: do not return negative values from .get_modes()

The .get_modes() hooks aren't supposed to return negative error
codes. Return 0 for no modes, whatever the reason.

Cc: Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: stable@vger.kernel.org
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/d8665f620d9c252aa7d5a4811ff6b16e773903a2.1709913674.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 4 ++--
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 00382f28748ac..f5bbba9ad2252 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -316,14 +316,14 @@ static int vidi_get_modes(struct drm_connector *connector)
 	 */
 	if (!ctx->raw_edid) {
 		DRM_DEV_DEBUG_KMS(ctx->dev, "raw_edid is null.\n");
-		return -EFAULT;
+		return 0;
 	}
 
 	edid_len = (1 + ctx->raw_edid->extensions) * EDID_LENGTH;
 	edid = kmemdup(ctx->raw_edid, edid_len, GFP_KERNEL);
 	if (!edid) {
 		DRM_DEV_DEBUG_KMS(ctx->dev, "failed to allocate edid\n");
-		return -ENOMEM;
+		return 0;
 	}
 
 	drm_connector_update_edid_property(connector, edid);
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 43bed6cbaaea0..b1d02dec3774d 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -887,11 +887,11 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	int ret;
 
 	if (!hdata->ddc_adpt)
-		return -ENODEV;
+		return 0;
 
 	edid = drm_get_edid(connector, hdata->ddc_adpt);
 	if (!edid)
-		return -ENODEV;
+		return 0;
 
 	hdata->dvi_mode = !connector->display_info.is_hdmi;
 	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
-- 
2.43.0





