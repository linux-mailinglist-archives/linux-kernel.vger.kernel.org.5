Return-Path: <linux-kernel+bounces-121267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CDB88E5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03CAB2E91C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F11B6FAB;
	Wed, 27 Mar 2024 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJfBVRLI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34E142E75;
	Wed, 27 Mar 2024 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542507; cv=none; b=sZaAovkjj0oB/MmzzC5oAcmLh4sqWPSkc97ph7v5hNKa+IUoGea/7k/8PUh790JAfhxhuAblURLpfyZ38wz6GxyKd5CK9juqrPfUa+f04dpXXE2SO7jkjeNknL6c3xqS/twjA1BB+QXcP/glaZI08Xm2yXZDld6nXnDI+HSsodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542507; c=relaxed/simple;
	bh=RQg0/YW/nXpSI1D6z/QqnVynt4AkwYshSO1Rq6yiY6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTUQAcCsuZh34IHhx/uW+XWZjz3lJJpn8klPPjWiRCC9SK4KHdCpkf2/Xd+8A/nJ2LWRHsEQ4rFpgIjlS+J3LePMeG9d5ePNHU0k9HfXW2Q39BMD7R+pC77TqJrrcIZV/ZFjkQ1LxNCPVtcoR/uzY1QDWAnqD59dmsoNjE8eAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJfBVRLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D121C433C7;
	Wed, 27 Mar 2024 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542506;
	bh=RQg0/YW/nXpSI1D6z/QqnVynt4AkwYshSO1Rq6yiY6I=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJfBVRLIsDhYE7CbRTz8gySqigD7PgU3rzaRnjy2NW/bdux/2yq2zcpZD7BRWwu8v
	 xtC7E4Flv3o1UtbmT4rn4tmJP6mjJxVf93UhFSjLo8YyFjHWPbNoyt5PE+92lNl7ML
	 5bkX9bbrTP2fL8eWlfnyqzc6Hw+oE9GcPSs9HFPmcaPQMRb6EF0tjYTMukm1qL+PA9
	 91Vls3omO92W9lf5o/tnwXpruDudxJYgQv6FrnkfD7A2p0z8/2e7NVy72f4aq8vSN2
	 uSoNv1q8tGDB5lw1KWtPa3nItpFdWK0tAtyLIiua6GuYXfSblf1d1vMMZpAGcrwzpH
	 v+Ovn0rL8JXlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jani.nikula@intel.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/probe-helper: warn about negative .get_modes()" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:24 -0400
Message-ID: <20240327122825.2842720-1-sashal@kernel.org>
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

From 7af03e688792293ba33149fb8df619a8dff90e80 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 8 Mar 2024 18:03:39 +0200
Subject: [PATCH] drm/probe-helper: warn about negative .get_modes()

The .get_modes() callback is supposed to return the number of modes,
never a negative error code. If a negative value is returned, it'll just
be interpreted as a negative count, and added to previous calculations.

Document the rules, but handle the negative values gracefully with an
error message.

Cc: stable@vger.kernel.org
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/50208c866facc33226a3c77b82bb96aeef8ef310.1709913674.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_probe_helper.c       | 7 +++++++
 include/drm/drm_modeset_helper_vtables.h | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 19ecb749704be..75f84753f6ee3 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -422,6 +422,13 @@ static int drm_helper_probe_get_modes(struct drm_connector *connector)
 
 	count = connector_funcs->get_modes(connector);
 
+	/* The .get_modes() callback should not return negative values. */
+	if (count < 0) {
+		drm_err(connector->dev, ".get_modes() returned %pe\n",
+			ERR_PTR(count));
+		count = 0;
+	}
+
 	/*
 	 * Fallback for when DDC probe failed in drm_get_edid() and thus skipped
 	 * override/firmware EDID.
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 881b03e4dc288..9ed42469540eb 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -898,7 +898,8 @@ struct drm_connector_helper_funcs {
 	 *
 	 * RETURNS:
 	 *
-	 * The number of modes added by calling drm_mode_probed_add().
+	 * The number of modes added by calling drm_mode_probed_add(). Return 0
+	 * on failures (no modes) instead of negative error codes.
 	 */
 	int (*get_modes)(struct drm_connector *connector);
 
-- 
2.43.0





