Return-Path: <linux-kernel+bounces-121263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7588E47C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806601F2F0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2672914290D;
	Wed, 27 Mar 2024 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYkWHZOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668151B5DB5;
	Wed, 27 Mar 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542495; cv=none; b=QgEETScCYZDdKYDIHsGD+PZbTy9AqKvRuM728kbDGXvdj6v069Aw+TL1cq6QjKwzbDMwD3fXz4HTUUSehSD9B/wcbzfbD0IfVoHKawGIUwumjem0q1KQ9KTYaHKEl8Yxc0hZ54CZBGdS3NapuW62q2GQvwJQQGqKTL2vZIOwAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542495; c=relaxed/simple;
	bh=Y+QBUjahuz3TSxmqa0VhX2VhvUl0eMvKTW/gwYDOHJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQjP73nZSYS8zgvpBep3SwuETe+gsTa6FQ8uODY3cYrMdoWTIw1vTNVhJc2MbMChRzMPcG/QEWL4/P355orNxmKl0DYDj5evbUO4iTbmDcXPL5InM4zJhdra4W91WP2RhInhkcl8Mt/DxYt1484lyh6o2NKUYxboPSzjpqyhAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYkWHZOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF5BC433C7;
	Wed, 27 Mar 2024 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542495;
	bh=Y+QBUjahuz3TSxmqa0VhX2VhvUl0eMvKTW/gwYDOHJA=;
	h=From:To:Cc:Subject:Date:From;
	b=EYkWHZOP19kJ50Dm2jDFQ9fRkHoCthZfX9DTEnEHDZcR4gAaLlgfk5/VRNTjW4W2v
	 ka6GhZmRqfNxP6O/ryeIYE3iNR6RRpLUNm6QFG5fUaWoFOyvXcpSpykmGnUk3oLJUH
	 23Gf7f0f582v2jlhmTbzUSmGIb31oq3/7RHc+tyPLyNeOezhRr2SnR0g3Q430r4QdO
	 QoYQ8wZzOjXwNBYrF4WrhMyHChwnOysIitolpY/LyM0P4xExbHg3FGv+v66aoqEeCq
	 Lk2Hip0pD1b/voSnhSyWkGMiJ00Shdyno+Kxb4VtdfQ9t6W3dLGItKYHuZVW/Uqr6u
	 iBVcqHTmElkWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	charlene.liu@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sung joon Kim <sungjoon.kim@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Add logging resource checks" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:12 -0400
Message-ID: <20240327122812.2842572-1-sashal@kernel.org>
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

From 012fe0674af0753e71424b638960adbfb7f3db5a Mon Sep 17 00:00:00 2001
From: Charlene Liu <charlene.liu@amd.com>
Date: Thu, 28 Dec 2023 13:19:33 -0500
Subject: [PATCH] drm/amd/display: Add logging resource checks

[Why]
When mapping resources, resources could be unavailable.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 4 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_state.c    | 5 +++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 69e726630241d..aa7c02ba948e9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3522,7 +3522,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	top_pipe_to_program = resource_get_otg_master_for_stream(
 				&context->res_ctx,
 				stream);
-
+	ASSERT(top_pipe_to_program != NULL);
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
@@ -4345,6 +4345,8 @@ static bool should_commit_minimal_transition_for_windowed_mpo_odm(struct dc *dc,
 
 	cur_pipe = resource_get_otg_master_for_stream(&dc->current_state->res_ctx, stream);
 	new_pipe = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+	if (!cur_pipe || !new_pipe)
+		return false;
 	cur_is_odm_in_use = resource_get_odm_slice_count(cur_pipe) > 1;
 	new_is_odm_in_use = resource_get_odm_slice_count(new_pipe) > 1;
 	if (cur_is_odm_in_use == new_is_odm_in_use)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f2abc1096ffb6..9fbdb09697fd5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2194,6 +2194,10 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 	for (stream_idx = 0; stream_idx < state->stream_count; stream_idx++) {
 		otg_master = resource_get_otg_master_for_stream(
 				&state->res_ctx, state->streams[stream_idx]);
+		if (!otg_master	|| otg_master->stream_res.tg == NULL) {
+			DC_LOG_DC("topology update: otg_master NULL stream_idx %d!\n", stream_idx);
+			return;
+		}
 		slice_count = resource_get_opp_heads_for_otg_master(otg_master,
 				&state->res_ctx, opp_heads);
 		for (slice_idx = 0; slice_idx < slice_count; slice_idx++) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 56feee0ff01b1..88c6436b28b69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -434,8 +434,9 @@ bool dc_state_add_plane(
 
 	otg_master_pipe = resource_get_otg_master_for_stream(
 			&state->res_ctx, stream);
-	added = resource_append_dpp_pipes_for_plane_composition(state,
-			dc->current_state, pool, otg_master_pipe, plane_state);
+	if (otg_master_pipe)
+		added = resource_append_dpp_pipes_for_plane_composition(state,
+				dc->current_state, pool, otg_master_pipe, plane_state);
 
 	if (added) {
 		stream_status->plane_states[stream_status->plane_count] =
-- 
2.43.0





