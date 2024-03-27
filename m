Return-Path: <linux-kernel+bounces-120811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5988DE06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45EDB27876
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038EC1327E8;
	Wed, 27 Mar 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dERYOH6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486BB13248F;
	Wed, 27 Mar 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541270; cv=none; b=pDPsBZJ5bjp8YAznbXoYQVw30WjcRdGOwgpgcM0eAweVJKf759pXGqlSFoQS0WfbU5CRJ5k69aFPTDtr3yeWr0bvNtxRfEKcVBU0Z2C4PL5GWCkbJDI+Qn5RiCKIAehOVxLFzvkmD1vC80ZLnmbEhvhJ59moYRjQpH7ONCdDhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541270; c=relaxed/simple;
	bh=HKZEM4DBTLEjFO6kMU/BkvBXiseTiBTqWOL7pvVKwCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mx6kcOiPd4zh5BQ8Sb5XQ1CKJGp3HsBjRAIZybexm+Hc8IFR1Wun5v3dsGAJ/z6/7XelbAHM3nZo8MAmrclsaz/ARJN9wgHqD/VoOj360H/Hx82IVDfI51X0AlI8AhEerqBLvoCo2M8IXjjB3p/JR9zdxjWax23hMHb3eSwUSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dERYOH6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC885C433F1;
	Wed, 27 Mar 2024 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541270;
	bh=HKZEM4DBTLEjFO6kMU/BkvBXiseTiBTqWOL7pvVKwCk=;
	h=From:To:Cc:Subject:Date:From;
	b=dERYOH6EEt4Fs4PoXmh7h8xAeFiB3IfinURkXLGUH3k9rkRO318lf39pTXQBgBPA9
	 7qVdTy3pXnwuxh3XWiE5CQIy8KcphnDHEYxnr1BqjiZaxUorSHggncPTiVhJ0pXZOS
	 kvC9fMfHV8GWebBbOM0XPgWWSI6Vsy/zc+kU+bBpXwoFXsqhSzb4ax60LBAhHBgf4y
	 Adc/LrsgDSyKgHTBY2o985nTEvChH6OAy+kMYpRbBOD81/QNKyuUyPwR4N0wn94Ilm
	 PANvFCJaxpP9JyyroZQUU7Z+tbGyBz3LbbDpg/w5j3Li6z+JJii9XNw+/D7mMP0kNv
	 zTwtyeUrcbmRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nicholas.kazlauskas@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:07:47 -0400
Message-ID: <20240327120748.2825730-1-sashal@kernel.org>
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

From 6c605f44086af24d7ac1867245aa10bb3360c5bf Mon Sep 17 00:00:00 2001
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date: Fri, 15 Dec 2023 11:01:42 -0500
Subject: [PATCH] drm/amd/display: Port DENTIST hang and TDR fixes to OTG
 disable W/A

[Why]
We can experience DENTIST hangs during optimize_bandwidth or TDRs if
FIFO is toggled and hangs.

[How]
Port the DCN35 fixes to DCN314.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 878c0e7b78abd..a84f1e376dee4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -145,30 +145,27 @@ static int dcn314_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
+static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context,
+				  bool safe_to_lower, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = safe_to_lower
+			? &context->res_ctx.pipe_ctx[i]
+			: &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
-			struct stream_encoder *stream_enc = pipe->stream_res.stream_enc;
-
 			if (disable) {
-				if (stream_enc && stream_enc->funcs->disable_fifo)
-					pipe->stream_res.stream_enc->funcs->disable_fifo(stream_enc);
+				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
+					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 
-				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 				reset_sync_context_for_pipe(dc, context, i);
 			} else {
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
-
-				if (stream_enc && stream_enc->funcs->enable_fifo)
-					pipe->stream_res.stream_enc->funcs->enable_fifo(stream_enc);
 			}
 		}
 	}
@@ -297,11 +294,11 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn314_disable_otg_wa(clk_mgr_base, context, true);
+		dcn314_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn314_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn314_disable_otg_wa(clk_mgr_base, context, false);
+		dcn314_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
 	}
-- 
2.43.0





