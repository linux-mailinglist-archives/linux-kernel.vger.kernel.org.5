Return-Path: <linux-kernel+bounces-120873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F8888DFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6761F2E6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25406142659;
	Wed, 27 Mar 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no2bx2iW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836F130AD5;
	Wed, 27 Mar 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541450; cv=none; b=IeTQG4ZfSR73nldm46dAye5Tnl1sH5EKYIm9xWbt9wJwag0MJaaeg64wACKuclQ1cHEUjdGx0XXLtqCKyajtd55E8VFvlJeJPCURLYiFUbebUwi+jgTiyPzEY32za0g3E1ak7T6XBMTFs8SHBhvj7ryzd0v2bAZEvtREHAspNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541450; c=relaxed/simple;
	bh=rJG0iqJ7iFb7G6zZ1t08oDmG2M7+1Tf1mVdsWNAcrDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZw0Km6uW+VUiR4Or5KV7S9a1SiWy3z+pauwkMJFD+/EokhcdAqaoi4DKnXIUgcrHwpaIgXAGgQ3rmjCJ7qFhMA5iwVbKTMLn35d0Iq7McuP3hUBFdViqDXZf1zuK6GvDBoB2Ak5VsHTso0egnX2lE4zA7Uwc11tuO+1flGaO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no2bx2iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87422C433F1;
	Wed, 27 Mar 2024 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541449;
	bh=rJG0iqJ7iFb7G6zZ1t08oDmG2M7+1Tf1mVdsWNAcrDI=;
	h=From:To:Cc:Subject:Date:From;
	b=no2bx2iWoIIfpEw9BGTxcfYX6TW/wjztMONRzEh6z6pBvlugVa8xAe6jNXE4kC+nn
	 cT0n9g2vfx5044ZSaWo8J+lUwcpk2UCIg4DfOHjuCaIM2dFf9D30phjoHSkj3cqc83
	 shEeUqm05Za/wRMlCKKZzsDQNB/YK9o/yu9Wu8vyeCScr56LLsN346vUCZI3AXWP6f
	 kV8ElIoTh2cw2qLGMTVmTNHmh+gSO8+suKftrIF5jdf2iI/9N1f9gMlwKwCUFuKuDC
	 dmI/0otnfSywqkehaNgadEToWEUBauy9w0jG8nRYpbQwhbvqyd7DROjKYe1tnqape+
	 QP3uTTkA1XPYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chuntao.tso@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Amend coasting vtotal for replay low hz" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:46 -0400
Message-ID: <20240327121047.2828245-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8e054b0f1e71531762b8ded7f66c1b4af734671b Mon Sep 17 00:00:00 2001
From: ChunTao Tso <chuntao.tso@amd.com>
Date: Tue, 20 Feb 2024 17:08:39 +0800
Subject: [PATCH] drm/amd/display: Amend coasting vtotal for replay low hz

[WHY]
The original coasting vtotal is 2 bytes, and it need to
be amended to 4 bytes because low hz case.

[HOW]
Amend coasting vtotal from 2 bytes to 4 bytes.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 4 ++--
 drivers/gpu/drm/amd/display/dc/inc/link.h                 | 4 ++--
 .../display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
 .../display/dc/link/protocols/link_edp_panel_control.h    | 4 ++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h           | 8 ++++++++
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 +-
 drivers/gpu/drm/amd/display/modules/power/power_helpers.h | 2 +-
 7 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 9900dda2eef5c..be2ac5c442a48 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1085,9 +1085,9 @@ struct replay_settings {
 	/* SMU optimization is enabled */
 	bool replay_smu_opt_enable;
 	/* Current Coasting vtotal */
-	uint16_t coasting_vtotal;
+	uint32_t coasting_vtotal;
 	/* Coasting vtotal table */
-	uint16_t coasting_vtotal_table[PR_COASTING_TYPE_NUM];
+	uint32_t coasting_vtotal_table[PR_COASTING_TYPE_NUM];
 	/* Maximum link off frame count */
 	enum replay_link_off_frame_count_level link_off_frame_count_level;
 	/* Replay pseudo vtotal for abm + ips on full screen video which can improve ips residency */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 26fe81f213da5..bf29fc58ea6a6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -285,12 +285,12 @@ struct link_service {
 			enum replay_FW_Message_type msg,
 			union dmub_replay_cmd_set *cmd_data);
 	bool (*edp_set_coasting_vtotal)(
-			struct dc_link *link, uint16_t coasting_vtotal);
+			struct dc_link *link, uint32_t coasting_vtotal);
 	bool (*edp_replay_residency)(const struct dc_link *link,
 			unsigned int *residency, const bool is_start,
 			const bool is_alpm);
 	bool (*edp_set_replay_power_opt_and_coasting_vtotal)(struct dc_link *link,
-			const unsigned int *power_opts, uint16_t coasting_vtotal);
+			const unsigned int *power_opts, uint32_t coasting_vtotal);
 
 	bool (*edp_wait_for_t12)(struct dc_link *link);
 	bool (*edp_is_ilr_optimization_required)(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index acfbbc638cc64..3baa2bdd6dd65 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1034,7 +1034,7 @@ bool edp_send_replay_cmd(struct dc_link *link,
 	return true;
 }
 
-bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal)
+bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal)
 {
 	struct dc *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
@@ -1073,7 +1073,7 @@ bool edp_replay_residency(const struct dc_link *link,
 }
 
 bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
-	const unsigned int *power_opts, uint16_t coasting_vtotal)
+	const unsigned int *power_opts, uint32_t coasting_vtotal)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 34e521af7bb48..a158c6234d422 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -59,12 +59,12 @@ bool edp_setup_replay(struct dc_link *link,
 bool edp_send_replay_cmd(struct dc_link *link,
 			enum replay_FW_Message_type msg,
 			union dmub_replay_cmd_set *cmd_data);
-bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal);
+bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal);
 bool edp_replay_residency(const struct dc_link *link,
 	unsigned int *residency, const bool is_start, const bool is_alpm);
 bool edp_get_replay_state(const struct dc_link *link, uint64_t *state);
 bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
-	const unsigned int *power_opts, uint16_t coasting_vtotal);
+	const unsigned int *power_opts, uint32_t coasting_vtotal);
 bool edp_wait_for_t12(struct dc_link *link);
 bool edp_is_ilr_optimization_required(struct dc_link *link,
        struct dc_crtc_timing *crtc_timing);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a529e369b2ace..af3fe8bb0728b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3238,6 +3238,14 @@ struct dmub_cmd_replay_set_coasting_vtotal_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
+	/**
+	 * 16-bit value dicated by driver that indicates the coasting vtotal high byte part.
+	 */
+	uint16_t coasting_vtotal_high;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index e304e8435fb8f..2a3698fd2dc24 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -975,7 +975,7 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 
 void set_replay_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
-	uint16_t vtotal)
+	uint32_t vtotal)
 {
 	link->replay_settings.coasting_vtotal_table[type] = vtotal;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index bef4815e1703d..ff7e6f3cd6be2 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -56,7 +56,7 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 void init_replay_config(struct dc_link *link, struct replay_config *pr_config);
 void set_replay_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
-	uint16_t vtotal);
+	uint32_t vtotal);
 void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
 void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint16_t vtotal, uint16_t htotal);
-- 
2.43.0





