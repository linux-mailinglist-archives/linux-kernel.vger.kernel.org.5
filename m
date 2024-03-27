Return-Path: <linux-kernel+bounces-120952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7F688E0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070C029E10D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A71514E3;
	Wed, 27 Mar 2024 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITaUYSdI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B1136E1D;
	Wed, 27 Mar 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541679; cv=none; b=dfYdQieGjB/Mw/OvAalK8LydobgdSwxPfyF3QIZyKFODWQNB6NB1Q+UBczJ2E5DtsHMD+vy/atXM4M2n9mcb4Dj2lle1ZfulpYNPrBZHukoWiav8FIVjNxasbKGar614o0KhwyUhct47R2dy5p4e6RfgnWrw039mOZF/LK12Q4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541679; c=relaxed/simple;
	bh=Ey2B4sU5QU/1ZspHVByq9wATXpy0NR9WKhZvBMvm22o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m57ydIn9jFTp0s5NyBJbMouXyMxbccbqBItoym8KoYDoHs0pxNw+50hHgm7pKcqELgVZbdS4djVcTEelXVgKBJ6OxONlOftDKgcywqU1c1D3yClUW+8QoMr6yfmGEzQImz56Ct2x66GJdK+EjTmbltzY5OuaJVkBfx19OgNGq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITaUYSdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26CC433F1;
	Wed, 27 Mar 2024 12:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541678;
	bh=Ey2B4sU5QU/1ZspHVByq9wATXpy0NR9WKhZvBMvm22o=;
	h=From:To:Cc:Subject:Date:From;
	b=ITaUYSdIyfjPc81b33QmiOuQG0+u5vDgGWPb/fGdcT+nVB1MlTA+2t7DDhZzwJ4Jd
	 bSx7Q97jxXWVmlmDnb+cdrXhBkvc4wL2VONIgjipitZ6k89ro3qD0ZlKXp1WajYsiP
	 QUy/0ReBFKSrgs5oZyXw9NU1vcNGR4LA/UXyXLbo/Lh3e66vjBZSYeImW2Aj9mo750
	 SpzsSdlE1LWksZEj+eCe7Pm5hVZaLfA5i3M2dxKYRpFz96HmecK598TBAxdtrShKup
	 +RbQm2UlR32hG0/AhmpZlbbuywQrAP1WiuuFNeKwJBb0nYVWtVQ3LVXLUnTivl+E6L
	 K9GiaO28nCdwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hamza.mahfooz@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amdgpu: make damage clips support configurable" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:14:36 -0400
Message-ID: <20240327121436.2831227-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fc184dbe9fd99ad2dfb197b6fe18768bae1774b1 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Thu, 8 Feb 2024 16:23:29 -0500
Subject: [PATCH] drm/amdgpu: make damage clips support configurable

We have observed that there are quite a number of PSR-SU panels on the
market that are unable to keep up with what user space throws at them,
resulting in hangs and random black screens. So, make damage clips
support configurable and disable it by default for PSR-SU displays.

Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 13 +++++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 312dfaec7b4a7..1291b8eb9dffa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -198,6 +198,7 @@ extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dc_visual_confirm;
 extern uint amdgpu_dm_abm_level;
 extern int amdgpu_backlight;
+extern int amdgpu_damage_clips;
 extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 161ecf9b41747..6ef7f22c1152c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -211,6 +211,7 @@ int amdgpu_seamless = -1; /* auto */
 uint amdgpu_debug_mask;
 int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
+int amdgpu_damage_clips = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -859,6 +860,18 @@ int amdgpu_backlight = -1;
 MODULE_PARM_DESC(backlight, "Backlight control (0 = pwm, 1 = aux, -1 auto (default))");
 module_param_named(backlight, amdgpu_backlight, bint, 0444);
 
+/**
+ * DOC: damageclips (int)
+ * Enable or disable damage clips support. If damage clips support is disabled,
+ * we will force full frame updates, irrespective of what user space sends to
+ * us.
+ *
+ * Defaults to -1 (where it is enabled unless a PSR-SU display is detected).
+ */
+MODULE_PARM_DESC(damageclips,
+		 "Damage clips support (0 = disable, 1 = enable, -1 auto (default))");
+module_param_named(damageclips, amdgpu_damage_clips, int, 0444);
+
 /**
  * DOC: tmz (int)
  * Trusted Memory Zone (TMZ) is a method to protect data being written
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b7a717c3682f9..f9a7a16f1ec21 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5254,6 +5254,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 				struct drm_plane_state *new_plane_state,
 				struct drm_crtc_state *crtc_state,
 				struct dc_flip_addrs *flip_addrs,
+				bool is_psr_su,
 				bool *dirty_regions_changed)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
@@ -5278,6 +5279,10 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	clips = drm_plane_get_damage_clips(new_plane_state);
 
+	if (num_clips && (!amdgpu_damage_clips || (amdgpu_damage_clips < 0 &&
+						   is_psr_su)))
+		goto ffu;
+
 	if (!dm_crtc_state->mpo_requested) {
 		if (!num_clips || num_clips > DC_MAX_DIRTY_RECTS)
 			goto ffu;
@@ -8412,6 +8417,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			fill_dc_dirty_rects(plane, old_plane_state,
 					    new_plane_state, new_crtc_state,
 					    &bundle->flip_addrs[planes_count],
+					    acrtc_state->stream->link->psr_settings.psr_version ==
+					    DC_PSR_VERSION_SU_1,
 					    &dirty_rects_changed);
 
 			/*
-- 
2.43.0





