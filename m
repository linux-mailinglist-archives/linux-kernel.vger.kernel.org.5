Return-Path: <linux-kernel+bounces-121175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C80088E325
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD2A1F2CF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFBB17D248;
	Wed, 27 Mar 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUAe1R5W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490917D221;
	Wed, 27 Mar 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542275; cv=none; b=XJwCjLiNhWTr57X5kmJRaz53x/886V7+i4ViBm/6upB+916/N03+vnRg0SQejel51Wkdk/7CfmG1rknDzGxMl+Y6ebgMsMFvJid0/QIWlrlToPgfwwxMj6e0judXA3hLIqhPdf3ZutWFoER2/gnX3UdmMV55MopgRqOULJVINdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542275; c=relaxed/simple;
	bh=tTbI+n51ClUIpACMLIM6sqH+Uk8gmneJZvGFy8l37VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lV6Q1jqObsHWUlfggCJH/O+uoO/Qr6h9HUQLlmCZrem5n/3bGiVSKR+fmSMmhjd8AySzWL6Cf9oRgvvUcThc2Boz1p/6MmteeahSxhoxjamV38y6uCVyFAIDJ/Pwc0FQiGObosXIpnG9JakiX7aY9bauI+0knDal5ZLYDrYP5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUAe1R5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDBCC433C7;
	Wed, 27 Mar 2024 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542275;
	bh=tTbI+n51ClUIpACMLIM6sqH+Uk8gmneJZvGFy8l37VI=;
	h=From:To:Cc:Subject:Date:From;
	b=PUAe1R5W1QDJ9NnwcBsDpPglvwn16eeX+j207eGBuIhdINKN8BowWow20kfYVx0gD
	 mdYEqx68jD/gkeJcDeGspWANN03uLarfm0/OSq/IbdU1ZnY0+tm7mkxx0X2O4PNXS3
	 hm93g+P/9AzFESMNn8efqoU2WcYvdfHQIASjKN01NLkTb/rN2NqDkE9OBNfMg+iRC2
	 /wyjlJFGIQnlN3cK9kXjE+ZiSTUC/wHdYxJYeqpQ07S0UUBxkH2t/YVxWeQtB0TwWr
	 ze5199fZF9PLv/icI/WP4lCvw4T9zl693q3nS+L6g3w942d3/Cl7gRHYRqzR7xXRuJ
	 Aj+IwZOh9PWug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jani.nikula@intel.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/probe-helper: warn about negative .get_modes()" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:24:33 -0400
Message-ID: <20240327122433.2839503-1-sashal@kernel.org>
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

The patch below does not apply to the 5.4-stable tree.
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





