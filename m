Return-Path: <linux-kernel+bounces-120854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5AF88DF58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73793299733
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CAB13D61A;
	Wed, 27 Mar 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek0GpKT1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A513D52D;
	Wed, 27 Mar 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541396; cv=none; b=UMi1wTIoS9kPhNfusGD5vyy9VpcgSx1RFJ69wYhBmc+qoe3s6vmLH+gJPUMsdhsgSJpQadLuFTUGFguduTn3TBYG+vuAypcucdDpunFEs3C81s5YuiYNI0ooEL6b/s92uz35T7NKpyt8djyuZpyEWylBtze05D0m+RAsKEtbGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541396; c=relaxed/simple;
	bh=9K7MiFe2ksPYacfINwknGaeX0/gXn2q0DIwRZH4JIdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqIgUFT7lePUlAsT8V+/Vy6mvp62iZaxH26oAsWupolhd1wmXqMCzlNuzNtSZF3l8OtGxVFotSzQS3oEipZN2oh9hH8rmO+o6CRhvmJxg5oy/nhuaQp6gcz5sROorlZYBZNNjOfP+6ZAGC5mu1fA5Mij95OrhfU7ynQvHC/bWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek0GpKT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BCDC433F1;
	Wed, 27 Mar 2024 12:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541395;
	bh=9K7MiFe2ksPYacfINwknGaeX0/gXn2q0DIwRZH4JIdk=;
	h=From:To:Cc:Subject:Date:From;
	b=ek0GpKT1uvE0cN4MmGLrncstfhNKPm+gBld6JjfzAnLrupieSkW+7zCeNShLeKDgW
	 pqSa+cmBoigTcgK3V+T7Ve1XtpHx30Ckm9US9bI4LZFa6jHQz1xDz6t+rTRMH7t4Fs
	 7LXqyklCuZDCDMg7aRQpR2+KoffNOMM7EImuHXLZ/YjwhFawKHZrYA2vSmkzq+egFx
	 IixqI/euoQaWZeCTW69W6Vtwp9OIGvyMJoaX+3z5C8wZJk2bvANrgWMno9Bc3L6YZT
	 fTr5GBFV7Vyb1DHomcsaFKOGN93GmmzfTC8p5OjxIWaLuAZ2QricghKlomMy5E/SGe
	 wxJ4aXxyVCb5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nicholas.kazlauskas@amd.com
Cc: Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Add more checks for exiting idle in DC" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:09:53 -0400
Message-ID: <20240327120953.2827425-1-sashal@kernel.org>
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

From a9b1a4f684b32bcd33431b67acd6f4c275728380 Mon Sep 17 00:00:00 2001
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date: Tue, 16 Jan 2024 09:52:58 -0500
Subject: [PATCH] drm/amd/display: Add more checks for exiting idle in DC

[Why]
Any interface that touches registers needs to wake up the system.

[How]
Add a new interface dc_exit_ips_for_hw_access that wraps the check
for IPS support and insert it into the public DC interfaces that
touch registers.

We don't re-enter, since we expect that the enter/exit to have been done
on the DM side.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 42 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 18 ++++++++
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |  2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 4 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2db361aeaf259..eb803d4d34786 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -417,6 +417,8 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	if (!memcmp(&stream->adjust, adjust, sizeof(*adjust)))
 		return true;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
@@ -457,6 +459,8 @@ bool dc_stream_get_last_used_drr_vtotal(struct dc *dc,
 
 	int i = 0;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
@@ -487,6 +491,8 @@ bool dc_stream_get_crtc_position(struct dc *dc,
 	bool ret = false;
 	struct crtc_position position;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe =
 				&dc->current_state->res_ctx.pipe_ctx[i];
@@ -606,6 +612,8 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 	if (pipe == NULL)
 		return false;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	/* By default, capture the full frame */
 	param.windowa_x_start = 0;
 	param.windowa_y_start = 0;
@@ -665,6 +673,8 @@ bool dc_stream_get_crc(struct dc *dc, struct dc_stream_state *stream,
 	struct pipe_ctx *pipe;
 	struct timing_generator *tg;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe->stream == stream)
@@ -689,6 +699,8 @@ void dc_stream_set_dyn_expansion(struct dc *dc, struct dc_stream_state *stream,
 	int i;
 	struct pipe_ctx *pipe_ctx;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (dc->current_state->res_ctx.pipe_ctx[i].stream
 				== stream) {
@@ -724,6 +736,8 @@ void dc_stream_set_dither_option(struct dc_stream_state *stream,
 	if (option > DITHER_OPTION_MAX)
 		return;
 
+	dc_exit_ips_for_hw_access(stream->ctx->dc);
+
 	stream->dither_option = option;
 
 	memset(&params, 0, sizeof(params));
@@ -748,6 +762,8 @@ bool dc_stream_set_gamut_remap(struct dc *dc, const struct dc_stream_state *stre
 	bool ret = false;
 	struct pipe_ctx *pipes;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (dc->current_state->res_ctx.pipe_ctx[i].stream == stream) {
 			pipes = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -765,6 +781,8 @@ bool dc_stream_program_csc_matrix(struct dc *dc, struct dc_stream_state *stream)
 	bool ret = false;
 	struct pipe_ctx *pipes;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (dc->current_state->res_ctx.pipe_ctx[i].stream
 				== stream) {
@@ -791,6 +809,8 @@ void dc_stream_set_static_screen_params(struct dc *dc,
 	struct pipe_ctx *pipes_affected[MAX_PIPES];
 	int num_pipes_affected = 0;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < num_streams; i++) {
 		struct dc_stream_state *stream = streams[i];
 
@@ -1769,6 +1789,8 @@ void dc_enable_stereo(
 	int i, j;
 	struct pipe_ctx *pipe;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (context != NULL) {
 			pipe = &context->res_ctx.pipe_ctx[i];
@@ -1788,6 +1810,8 @@ void dc_enable_stereo(
 void dc_trigger_sync(struct dc *dc, struct dc_state *context)
 {
 	if (context->stream_count > 1 && !dc->debug.disable_timing_sync) {
+		dc_exit_ips_for_hw_access(dc);
+
 		enable_timing_multisync(dc, context);
 		program_timing_sync(dc, context);
 	}
@@ -2044,6 +2068,8 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	if (!streams_changed(dc, streams, stream_count))
 		return res;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	DC_LOG_DC("%s: %d streams\n", __func__, stream_count);
 
 	for (i = 0; i < stream_count; i++) {
@@ -3373,6 +3399,8 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	struct dc_stream_status *stream_status = NULL;
+	dc_exit_ips_for_hw_access(dc);
+
 	dc_z10_restore(dc);
 
 	top_pipe_to_program = resource_get_otg_master_for_stream(
@@ -3527,6 +3555,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	// dc->current_state anymore, so we have to cache it before we apply
 	// the new SubVP context
 	subvp_prev_use = false;
+	dc_exit_ips_for_hw_access(dc);
+
 	dc_z10_restore(dc);
 	if (update_type == UPDATE_TYPE_FULL)
 		wait_for_outstanding_hw_updates(dc, context);
@@ -4409,6 +4439,8 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	bool is_plane_addition = 0;
 	bool is_fast_update_only;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
 	is_fast_update_only = fast_update_only(dc, fast_update, srf_updates,
 			surface_count, stream_update, stream);
@@ -4529,6 +4561,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	int i, j;
 	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
+	dc_exit_ips_for_hw_access(dc);
+
 	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
 	stream_status = dc_stream_get_status(stream);
 	context = dc->current_state;
@@ -4713,6 +4747,8 @@ void dc_set_power_state(
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_state_construct(dc, dc->current_state);
 
+		dc_exit_ips_for_hw_access(dc);
+
 		dc_z10_restore(dc);
 
 		dc->hwss.init_hw(dc);
@@ -4854,6 +4890,12 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 		dc->idle_optimizations_allowed = allow;
 }
 
+void dc_exit_ips_for_hw_access(struct dc *dc)
+{
+	if (dc->caps.ips_support)
+		dc_allow_idle_optimizations(dc, false);
+}
+
 bool dc_dmub_is_ips_idle_state(struct dc *dc)
 {
 	uint32_t idle_state = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 54670e0b15189..51a970fcb5d05 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -423,6 +423,8 @@ bool dc_stream_add_writeback(struct dc *dc,
 		return false;
 	}
 
+	dc_exit_ips_for_hw_access(dc);
+
 	wb_info->dwb_params.out_transfer_func = stream->out_transfer_func;
 
 	dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
@@ -493,6 +495,8 @@ bool dc_stream_fc_disable_writeback(struct dc *dc,
 		return false;
 	}
 
+	dc_exit_ips_for_hw_access(dc);
+
 	if (dwb->funcs->set_fc_enable)
 		dwb->funcs->set_fc_enable(dwb, DWB_FRAME_CAPTURE_DISABLE);
 
@@ -542,6 +546,8 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		return false;
 	}
 
+	dc_exit_ips_for_hw_access(dc);
+
 	/* disable writeback */
 	if (dc->hwss.disable_writeback) {
 		struct dwbc *dwb = dc->res_pool->dwbc[dwb_pipe_inst];
@@ -557,6 +563,8 @@ bool dc_stream_warmup_writeback(struct dc *dc,
 		int num_dwb,
 		struct dc_writeback_info *wb_info)
 {
+	dc_exit_ips_for_hw_access(dc);
+
 	if (dc->hwss.mmhubbub_warmup)
 		return dc->hwss.mmhubbub_warmup(dc, num_dwb, wb_info);
 	else
@@ -569,6 +577,8 @@ uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 	struct resource_context *res_ctx =
 		&dc->current_state->res_ctx;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
@@ -597,6 +607,8 @@ bool dc_stream_send_dp_sdp(const struct dc_stream_state *stream,
 	dc = stream->ctx->dc;
 	res_ctx = &dc->current_state->res_ctx;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 
@@ -628,6 +640,8 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 	struct resource_context *res_ctx =
 		&dc->current_state->res_ctx;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
@@ -664,6 +678,8 @@ bool dc_stream_dmdata_status_done(struct dc *dc, struct dc_stream_state *stream)
 	if (i == MAX_PIPES)
 		return true;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	return dc->hwss.dmdata_status_done(pipe);
 }
 
@@ -698,6 +714,8 @@ bool dc_stream_set_dynamic_metadata(struct dc *dc,
 
 	pipe_ctx->stream->dmdata_address = attr->address;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	dc->hwss.program_dmdata_engine(pipe_ctx);
 
 	if (hubp->funcs->dmdata_set_attributes != NULL &&
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 19a2c7140ae84..19140fb65787c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -161,6 +161,8 @@ const struct dc_plane_status *dc_plane_get_status(
 		break;
 	}
 
+	dc_exit_ips_for_hw_access(dc);
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx =
 				&dc->current_state->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 74c871917eafc..53919c0eb1e3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2325,6 +2325,7 @@ bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_
 				struct dc_cursor_attributes *cursor_attr);
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow);
+void dc_exit_ips_for_hw_access(struct dc *dc);
 bool dc_dmub_is_ips_idle_state(struct dc *dc);
 
 /* set min and max memory clock to lowest and highest DPM level, respectively */
-- 
2.43.0





