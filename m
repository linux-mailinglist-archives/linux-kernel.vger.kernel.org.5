Return-Path: <linux-kernel+bounces-120812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF3B88DE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB292901CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F021327FF;
	Wed, 27 Mar 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8lVWU5B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15F12EBF5;
	Wed, 27 Mar 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541274; cv=none; b=aD8TznW86D3YlyysVxemLCXILNX48METy75WVL+tYAKGJ4HWCLbEMHRwDBTwWApaXruo2xGMFZQ4TELJYDPYdAhXMjVb32joUmsprwX8nJvKxvycGTgmqMD3Wk5vjwjWDo7iZQjsrnWSBMIYqdvs3tnm76XiCFfXPIyMLTUkoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541274; c=relaxed/simple;
	bh=+5/DuttNTxoe3XactbaorrPhEg+aJel18/gNJLsCm0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBc3mOaOsoqZoTSm0OxIoylppKoJoXNJzXhw+MFlPqtwSZWHO0Uf9tFk66IGoYQW3rIjxyGcK6xH6PUQ4W256/cuyMw3/8R0l1Syu8PhfyyxtfbG45nFyLkFcYQxyjCtHsWUeih7eVjL4b4TD4PhqjPZ7X7KXO+oHQ9A54UCTnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8lVWU5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA900C433C7;
	Wed, 27 Mar 2024 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541273;
	bh=+5/DuttNTxoe3XactbaorrPhEg+aJel18/gNJLsCm0E=;
	h=From:To:Cc:Subject:Date:From;
	b=L8lVWU5BoI8i/qWIITnOeasmZecb4Y3kFLlBeYgonewqIHQBuousc2CMG59h/gRZz
	 119PXIZzHYPse1ksSc7RjrmQ0q+SOGogZXsCUhkNxNqFRimvLyrTkah4DC+98UV2ts
	 mXNHCd1bJaLp1F4P2iSFFoDBP0Lc+3AitjE/pPxXLHbSP1VVKIka9S9LI/sE42n5o4
	 hOsomwlp3aWXS0Keowm6AJ+VtLnuBbZewf6k46BfvfT1M6wj/eW+zRQJVlHOUA52j7
	 E0+7q093gTOngbu1OqvXS/cpKeFxGuWXaEcbT6BXeHGBZUA16609NOoNkMywxP7G6G
	 JYHkcXInN4Uqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alvin.lee2@amd.com
Cc: Samson Tam <samson.tam@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Update phantom pipe enable / disable sequence" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:07:50 -0400
Message-ID: <20240327120751.2825767-1-sashal@kernel.org>
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

From 6a068e64fb25dbc81256fc03db0d4579d222bccd Mon Sep 17 00:00:00 2001
From: Alvin Lee <alvin.lee2@amd.com>
Date: Fri, 26 Jan 2024 16:47:20 -0500
Subject: [PATCH] drm/amd/display: Update phantom pipe enable / disable
 sequence

Previously we would call apply_ctx_to_hw to enable and disable
phantom pipes. However, apply_ctx_to_hw can potentially update
non-phantom pipes as well which is undesired. Instead of calling
apply_ctx_to_hw as a whole, call the relevant helpers for each
phantom pipe when enabling / disabling which will avoid us modifying
hardware state for non-phantom pipes unknowingly.

The use case is for an FRL display where FRL_Update is requested
by the display. In this case link_state_valid flag is cleared in
a passive callback thread and should be handled in the next stream /
link update. However, due to the call to apply_ctx_to_hw for the
phantom pipes during a flip, the main pipes were modified outside
of the desired sequence (driver does not handle link_state_valid = 0
on flips).

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |  4 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |  4 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 76 ++++++++++++++++---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  3 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 .../display/dc/hwss/hw_sequencer_private.h    |  7 ++
 10 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c81f8af5d3741..72512903f88f7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3851,7 +3851,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		 * programming has completed (we turn on phantom OTG in order
 		 * to complete the plane disable for phantom pipes).
 		 */
-		dc->hwss.apply_ctx_to_hw(dc, context);
+
+		if (dc->hwss.disable_phantom_streams)
+			dc->hwss.disable_phantom_streams(dc, context);
 	}
 
 	if (update_type != UPDATE_TYPE_FAST)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 3255034749e2c..9d5df4c0da597 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1529,7 +1529,7 @@ static enum dc_status dce110_enable_stream_timing(
 	return DC_OK;
 }
 
-static enum dc_status apply_single_controller_ctx_to_hw(
+enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context,
 		struct dc *dc)
@@ -2356,7 +2356,7 @@ enum dc_status dce110_apply_ctx_to_hw(
 		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe)
 			continue;
 
-		status = apply_single_controller_ctx_to_hw(
+		status = dce110_apply_single_controller_ctx_to_hw(
 				pipe_ctx,
 				context,
 				dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
index 08028a1779ae8..ed3cc3648e8e2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
@@ -39,6 +39,10 @@ enum dc_status dce110_apply_ctx_to_hw(
 		struct dc *dc,
 		struct dc_state *context);
 
+enum dc_status dce110_apply_single_controller_ctx_to_hw(
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context,
+		struct dc *dc);
 
 void dce110_enable_stream(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 7557e58f58b24..bc0a21957e33f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2671,7 +2671,7 @@ void dcn20_setup_vupdate_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		tg->funcs->setup_vertical_interrupt2(tg, start_line);
 }
 
-static void dcn20_reset_back_end_for_pipe(
+void dcn20_reset_back_end_for_pipe(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
index 90316327e6fc5..5c874f7b0683e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
@@ -86,6 +86,10 @@ enum dc_status dcn20_enable_stream_timing(
 void dcn20_disable_stream_gating(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn20_enable_stream_gating(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn20_setup_vupdate_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx);
+void dcn20_reset_back_end_for_pipe(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context);
 void dcn20_init_blank(
 		struct dc *dc,
 		struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 6c9299c7683df..aa36d7a56ca8c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1474,9 +1474,44 @@ void dcn32_update_dsc_pg(struct dc *dc,
 	}
 }
 
+void dcn32_disable_phantom_streams(struct dc *dc, struct dc_state *context)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	int i;
+
+	for (i = dc->res_pool->pipe_count - 1; i >= 0 ; i--) {
+		struct pipe_ctx *pipe_ctx_old =
+			&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx_old->stream)
+			continue;
+
+		if (dc_state_get_pipe_subvp_type(dc->current_state, pipe_ctx_old) != SUBVP_PHANTOM)
+			continue;
+
+		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
+			continue;
+
+		if (!pipe_ctx->stream || pipe_need_reprogram(pipe_ctx_old, pipe_ctx) ||
+				(pipe_ctx->stream && dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM)) {
+			struct clock_source *old_clk = pipe_ctx_old->clock_source;
+
+			if (hws->funcs.reset_back_end_for_pipe)
+				hws->funcs.reset_back_end_for_pipe(dc, pipe_ctx_old, dc->current_state);
+			if (hws->funcs.enable_stream_gating)
+				hws->funcs.enable_stream_gating(dc, pipe_ctx_old);
+			if (old_clk)
+				old_clk->funcs->cs_power_down(old_clk);
+		}
+	}
+}
+
 void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context)
 {
 	unsigned int i;
+	enum dc_status status = DC_OK;
+	struct dce_hwseq *hws = dc->hwseq;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -1497,16 +1532,39 @@ void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context)
 		}
 	}
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (new_pipe->stream && dc_state_get_pipe_subvp_type(context, new_pipe) == SUBVP_PHANTOM) {
-			// If old context or new context has phantom pipes, apply
-			// the phantom timings now. We can't change the phantom
-			// pipe configuration safely without driver acquiring
-			// the DMCUB lock first.
-			dc->hwss.apply_ctx_to_hw(dc, context);
-			break;
+		struct pipe_ctx *pipe_ctx_old =
+					&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream == NULL)
+			continue;
+
+		if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM)
+			continue;
+
+		if (pipe_ctx->stream == pipe_ctx_old->stream &&
+			pipe_ctx->stream->link->link_state_valid) {
+			continue;
 		}
+
+		if (pipe_ctx_old->stream && !pipe_need_reprogram(pipe_ctx_old, pipe_ctx))
+			continue;
+
+		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe)
+			continue;
+
+		if (hws->funcs.apply_single_controller_ctx_to_hw)
+			status = hws->funcs.apply_single_controller_ctx_to_hw(
+					pipe_ctx,
+					context,
+					dc);
+
+		ASSERT(status == DC_OK);
+
+#ifdef CONFIG_DRM_AMD_DC_FP
+		if (hws->funcs.resync_fifo_dccg_dio)
+			hws->funcs.resync_fifo_dccg_dio(hws, dc, context);
+#endif
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index cecf7f0f56719..069e20bc87c0a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -111,6 +111,8 @@ void dcn32_update_dsc_pg(struct dc *dc,
 
 void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context);
 
+void dcn32_disable_phantom_streams(struct dc *dc, struct dc_state *context);
+
 void dcn32_init_blank(
 		struct dc *dc,
 		struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 0980df6c65ea4..2b073123d3ede 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -109,6 +109,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.commit_subvp_config = dcn32_commit_subvp_config,
 	.enable_phantom_streams = dcn32_enable_phantom_streams,
+	.disable_phantom_streams = dcn32_disable_phantom_streams,
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.subvp_pipe_control_lock_fast = dcn32_subvp_pipe_control_lock_fast,
@@ -159,6 +160,8 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn32_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
+	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
 };
 
 void dcn32_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 91b1b43a728fd..f89f205e42a1a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -381,6 +381,7 @@ struct hw_sequencer_funcs {
 			struct dc_cursor_attributes *cursor_attr);
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
+	void (*disable_phantom_streams)(struct dc *dc, struct dc_state *context);
 	void (*subvp_pipe_control_lock)(struct dc *dc,
 			struct dc_state *context,
 			bool lock,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 6137cf09aa54d..b3c62a82cb1cf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -165,8 +165,15 @@ struct hwseq_private_funcs {
 	void (*set_pixels_per_cycle)(struct pipe_ctx *pipe_ctx);
 	void (*resync_fifo_dccg_dio)(struct dce_hwseq *hws, struct dc *dc,
 			struct dc_state *context);
+	enum dc_status (*apply_single_controller_ctx_to_hw)(
+			struct pipe_ctx *pipe_ctx,
+			struct dc_state *context,
+			struct dc *dc);
 	bool (*is_dp_dig_pixel_rate_div_policy)(struct pipe_ctx *pipe_ctx);
 #endif
+	void (*reset_back_end_for_pipe)(struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			struct dc_state *context);
 };
 
 struct dce_hwseq {
-- 
2.43.0





