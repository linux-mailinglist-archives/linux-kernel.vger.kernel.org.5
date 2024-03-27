Return-Path: <linux-kernel+bounces-121088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE088E237
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F47B1C28A02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E62716E886;
	Wed, 27 Mar 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsNfVlKf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850F16E875;
	Wed, 27 Mar 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542047; cv=none; b=iOduPGIhQUYp+TCshHbsZewnZa7oEWvsXqWtoqe9+qFGAu8APiRDxhVYJoiXOBQt3FEmcdkZkx0aZsTK8WYZw0lR2kTqrJICzveruUBd6M7No38dmDZHPDzZ4V6ksWTtCX7QAmEovsFr1B732KOwHrR3wTICQDD9twnEuE41x+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542047; c=relaxed/simple;
	bh=BXLvhNCgC/YLtiNUbjr30+il9Xkr2H1JhrdeFzhOhCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dq5qxmrxQJQ00PurEB9PGQ9PtdwAxHjCHNj7xawKGhHXZG2t0bzN/lT7jAZXlxJvRRM5x1py9GQkGUAnrkOMhTkNN8cBewygZcQzJX+XGPl1HmYEV1SEmkwJm6yMI2OVffHD6LiQrGAwduUMyNM2yUmhIJra6pT2kRmO2Ov9UUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsNfVlKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86297C433C7;
	Wed, 27 Mar 2024 12:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542047;
	bh=BXLvhNCgC/YLtiNUbjr30+il9Xkr2H1JhrdeFzhOhCw=;
	h=From:To:Cc:Subject:Date:From;
	b=EsNfVlKf/cbjveoaQaCuaZwv3HA7LQO3+H6QKJ2rjnEDbKHtHkqtKKpc0BVr48J3D
	 pM9+/oLX9Q0wrHYXn0vamikbHvQd6235CEyfyjhuimVbtNSwmKYeVqLO69d3PpJowG
	 /DxtLClMLCfl9Qwdc9z+evzbAGL/3LUdfxOWv/35/Fp705+xQOXHXC2zwdDWrgTEO+
	 2DVvk3rtOCmZarIAXaVTTZoVG/mAzH+X+uDdbPBH0J+I4Tg3cyUsYMRPPDPHl2N5i9
	 DTWzZw6eXq0sw/wTS13htDEbXcL73giPYKSe0+luxLz7iHcvDMI01H1Hj4bRFjbd+v
	 VNFr34wxC/99g==
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
Subject: FAILED: Patch "drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:20:45 -0400
Message-ID: <20240327122045.2836306-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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





