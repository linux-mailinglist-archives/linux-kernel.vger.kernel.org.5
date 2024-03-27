Return-Path: <linux-kernel+bounces-120998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F229588E158
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298621C2A220
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38511157A6B;
	Wed, 27 Mar 2024 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDSYFsFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C3157A5B;
	Wed, 27 Mar 2024 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541798; cv=none; b=gIWAAuxtbJVz583dJYnAURL/aSC4rXdqvvOD+k1Mpemh6zt/pvVYTnwDBE1HuO584vwfVseCNdykvcAfTahx0tkNfmUvpUrx+6MzJOeBFjDcGbC37m329j+RSGHNsWD68IIMPcP3Krfo3FjqM44xtSSM92smfIhaFGJvMppk4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541798; c=relaxed/simple;
	bh=aiGXH2e1YS9Zema6IJvAJl8vZLUmaCR0p0cDa9MUKD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEYrNTpe2aI5VAkE7Lym9fDGe1Y3P6+Ea52jJlwGgGJwaV4mw6NB79kSxqxnWl43p3k9q9e2nAkD5fhlkkfkJgSDi6T+nXTacMVYYCUpohbka+nCwFhLAaGU1Oycc/w1jDjty8s7MPGArKfxZNYaDV8zSjvaUfq4WX8ZuvGIVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDSYFsFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1207AC433F1;
	Wed, 27 Mar 2024 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541798;
	bh=aiGXH2e1YS9Zema6IJvAJl8vZLUmaCR0p0cDa9MUKD4=;
	h=From:To:Cc:Subject:Date:From;
	b=pDSYFsFx4wLd/x45fBjhWEe8Jz3IHWUOFgqPAiCIiRpwn6wbwe2w2C2UGaGLO98T4
	 x7cnZeYtYDDcvHL1K1JPETdG7QBe87f/x3WnZfmRxh8KH9o3jNp/EibOXc/KqgHw4Q
	 /zwXjiz1T1sScEHNrYPiOIEQ9Lp1kaMbozRyrFWktMPklzE95N3PKetI51ZI+dlAGU
	 hFNJq2FzoyUQTa/AxazGxEGz7gURkvogUql7wryY7kwMyuXVBCvVpf3m2vIvOz6Hu7
	 Apfvhcfh2zvIWV4CPm392qnIRQ007hNi3T6y5UHqmnN+pwuNHyZUAymR8Y50SiSrJQ
	 DW4QOG9wwnysQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wenjing.liu@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Update odm when ODM combine is changed on an otg master pipe with no plane" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:35 -0400
Message-ID: <20240327121636.2832841-1-sashal@kernel.org>
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

From 86e9523fb0efce27095d3086473c739cce720d01 Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Wed, 21 Feb 2024 16:55:04 -0500
Subject: [PATCH] drm/amd/display: Update odm when ODM combine is changed on an
 otg master pipe with no plane

[WHY]
When committing an update with ODM combine change when the plane is
removing or already removed, we fail to detect odm change in pipe
update flags. This has caused mismatch between new dc state and the
actual hardware state, because we missed odm programming.

[HOW]
- Detect odm change even for otg master pipe without a plane.
- Update odm config before calling program pipes for pipe with planes.

The commit also updates blank pattern programming when odm is changed
without plane. This is because number of OPP is changed when ODM
combine is changed. Blank pattern is per OPP so we will need to
reprogram OPP based on the new pipe topology.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 41 ++++++++++---------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  7 ++++
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c55d5155ecb9c..40098d9f70cbc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1498,6 +1498,11 @@ static void dcn20_detect_pipe_changes(struct dc_state *old_state,
 		return;
 	}
 
+	if (resource_is_pipe_type(new_pipe, OTG_MASTER) &&
+			resource_is_odm_topology_changed(new_pipe, old_pipe))
+		/* Detect odm changes */
+		new_pipe->update_flags.bits.odm = 1;
+
 	/* Exit on unchanged, unused pipe */
 	if (!old_pipe->plane_state && !new_pipe->plane_state)
 		return;
@@ -1551,10 +1556,6 @@ static void dcn20_detect_pipe_changes(struct dc_state *old_state,
 
 	/* Detect top pipe only changes */
 	if (resource_is_pipe_type(new_pipe, OTG_MASTER)) {
-		/* Detect odm changes */
-		if (resource_is_odm_topology_changed(new_pipe, old_pipe))
-			new_pipe->update_flags.bits.odm = 1;
-
 		/* Detect global sync changes */
 		if (old_pipe->pipe_dlg_param.vready_offset != new_pipe->pipe_dlg_param.vready_offset
 				|| old_pipe->pipe_dlg_param.vstartup_start != new_pipe->pipe_dlg_param.vstartup_start
@@ -1999,19 +2000,20 @@ void dcn20_program_front_end_for_ctx(
 	DC_LOGGER_INIT(dc->ctx->logger);
 	unsigned int prev_hubp_count = 0;
 	unsigned int hubp_count = 0;
+	struct pipe_ctx *pipe;
 
 	if (resource_is_pipe_topology_changed(dc->current_state, context))
 		resource_log_pipe_topology_update(dc, context);
 
 	if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			pipe = &context->res_ctx.pipe_ctx[i];
 
-			if (!pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe && pipe_ctx->plane_state) {
-				ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
+			if (!pipe->top_pipe && !pipe->prev_odm_pipe && pipe->plane_state) {
+				ASSERT(!pipe->plane_state->triplebuffer_flips);
 				/*turn off triple buffer for full update*/
 				dc->hwss.program_triplebuffer(
-						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
+						dc, pipe, pipe->plane_state->triplebuffer_flips);
 			}
 		}
 	}
@@ -2085,12 +2087,22 @@ void dcn20_program_front_end_for_ctx(
 			DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
 		}
 
+	/* update ODM for blanked OTG master pipes */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		if (resource_is_pipe_type(pipe, OTG_MASTER) &&
+				!resource_is_pipe_type(pipe, DPP_PIPE) &&
+				pipe->update_flags.bits.odm &&
+				hws->funcs.update_odm)
+			hws->funcs.update_odm(dc, context, pipe);
+	}
+
 	/*
 	 * Program all updated pipes, order matters for mpcc setup. Start with
 	 * top pipe and program all pipes that follow in order
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->plane_state && !pipe->top_pipe) {
 			while (pipe) {
@@ -2129,17 +2141,6 @@ void dcn20_program_front_end_for_ctx(
 			context->stream_status[0].plane_count > 1) {
 			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start(pipe->plane_res.hubp);
 		}
-
-		/* when dynamic ODM is active, pipes must be reconfigured when all planes are
-		 * disabled, as some transitions will leave software and hardware state
-		 * mismatched.
-		 */
-		if (dc->debug.enable_single_display_2to1_odm_policy &&
-			pipe->stream &&
-			pipe->update_flags.bits.disable &&
-			!pipe->prev_odm_pipe &&
-			hws->funcs.update_odm)
-			hws->funcs.update_odm(dc, context, pipe);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index aa36d7a56ca8c..b890db0bfc46b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1156,6 +1156,13 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 			dsc->funcs->dsc_disconnect(dsc);
 		}
 	}
+
+	if (!resource_is_pipe_type(pipe_ctx, DPP_PIPE))
+		/*
+		 * blank pattern is generated by OPP, reprogram blank pattern
+		 * due to OPP count change
+		 */
+		dc->hwseq->funcs.blank_pixel_data(dc, pipe_ctx, true);
 }
 
 unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
-- 
2.43.0





