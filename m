Return-Path: <linux-kernel+bounces-120782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3788DD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7871F259D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F812D1F1;
	Wed, 27 Mar 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBhU6GQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB24E541;
	Wed, 27 Mar 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541090; cv=none; b=FtAN2crNxQBWuG5iCWFVjVbQ7pIdIu2iZeDOrMRxV1YlZ9MsRkBK3ag/j3IbICA1OoAkVw9TOgZji3lO+sUi6l9vPA4A80oKFhqRI8CetcLZmrwzK8rnk8gNfdAYAypvJpdIcdxbSTn8RElUhuiWSZ8OWSjZDK1wO5q4Yha7UQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541090; c=relaxed/simple;
	bh=qu6pAAksjCh286Qmk8VmwuY5VshP4H7poEcP+eIgXQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCGJUyqAMbEjrnayQ1SVePxFOcDyej1ehq3a8AB1XnbPGVyc0NRlvc2ukdnS30gwQcXQXDG0YrcUdEhQgUoRs/ZWg+jFx0t4ry5Xx+KOGgT4DbdsEn3xvAA9xJBHNkgsvV3BxQHc1Dy1E0S9yedmIQ02GPgsFAgvs4wt9gY4ZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBhU6GQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18610C433F1;
	Wed, 27 Mar 2024 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541089;
	bh=qu6pAAksjCh286Qmk8VmwuY5VshP4H7poEcP+eIgXQs=;
	h=From:To:Cc:Subject:Date:From;
	b=cBhU6GQuWwvz1uQjwygbTuDioBtolPfMAY5pJag0z0e3cH7XnESQBxvpoal1QjXJB
	 2OUT0xUjGdIkP9Sr1owe5W7sJw0I0LRbVavIz4pCCayMzpfnS8M2D2gWjCkCUHFOiS
	 q+Dk9NzqIPFH1OtsiOeJhWd1gPqOX3aJuSTyP3cFaABK32guMPYto8lkuMbx+tBfo5
	 hKAmiusgk5VAkom+g4hHttqCx20LTjkFtcPfeZqiAF6lLUPXEQqYamZTE3qhpl4Nx4
	 +9UA3xAOlFN5Vp6RBWMz0Jj5XAn6gqpp7FqKE6vI/LOSJNXF7E/EXinmUmJDeyrw03
	 +N/v8uC1HYT/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hamza.mahfooz@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amdgpu: make damage clips support configurable" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:04:47 -0400
Message-ID: <20240327120448.2824384-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
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





