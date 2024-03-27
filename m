Return-Path: <linux-kernel+bounces-121177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DBF88E329
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273FA1C2874D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DF413E6DF;
	Wed, 27 Mar 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtPx5/xo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38213E6DA;
	Wed, 27 Mar 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542282; cv=none; b=Xd5tcvdB4pwwuImuXGmrjPwbr2M1B8jJAz+MwHdM/EjotgCHD2Y23k4dvc4aSUH+Rq1YspkSc5C0PkE/0DLENWbjrzEoWNb7RvNMfm+c9YzRxqUWX7Pd3NfWuT78qX/7zBCQfjysM0FYGXTh31yrIJsk9qfOjdbz+OEjHqXAqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542282; c=relaxed/simple;
	bh=C2d6GD0TWS1CsTBKcGIMBMZTIFDag7H2/LZ3G281QpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN6K2+sXbxpae77ZSPvQvOI8/+rOCtn0iMIrLEonjRSRyPfDTtt21eNrZaY8CiwDgQd50KfyS2snJnaHo9b+6u3I5k5UV0ai/Q22Rit9inZDdoiJQ16tVE+gZ9LznM0j+qVLbhkVPMHoijukBN1tKcfLTCl+hNC0GfSATJsK6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtPx5/xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B713CC433C7;
	Wed, 27 Mar 2024 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542280;
	bh=C2d6GD0TWS1CsTBKcGIMBMZTIFDag7H2/LZ3G281QpY=;
	h=From:To:Cc:Subject:Date:From;
	b=CtPx5/xo4fSbQdeMb6EE2cM0Z5kMHVJ0ubJNTwBAx25ljHhiemIkbAZiAMckXq6zX
	 saLPbHYBeyzs1JF/wESKTTf+3gin3SFEUJAGQw4RbVOpJ6hc18UcDiJrGEspy6ftaz
	 wqGN87T7H039movQGw7YmJvbY0D4CgHLq+rvCTWBt2WzQgP5NxYGEAqdB+bLcyK6r8
	 1Vz/0FpiDBrlIyzpUFa4DbLpaD9hvjkP8BWqxSSff/+nie9HNnoBs9LB/0obWIn1hg
	 Nn8HzdbdKM+PxTlVQLDF7EPtIC/6SmcdAsHXK+cUVVAxcqUPnR31vWBV3wXlrH93lj
	 MQHHFB789NSMg==
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
Subject: FAILED: Patch "drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:24:38 -0400
Message-ID: <20240327122438.2839579-1-sashal@kernel.org>
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





