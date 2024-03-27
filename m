Return-Path: <linux-kernel+bounces-120912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB688E06E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446841F36381
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D66149006;
	Wed, 27 Mar 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqoXwJUt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6746148FFB;
	Wed, 27 Mar 2024 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541565; cv=none; b=kujyGYF9e/+WqOlcSw1jjlbkMu7P3Y5RyEk2b78W9FTZZ9ycSwUTZLj9qxWSUqZKevLtY9C2RZLAmxyrBRW1EJnRdIdqJ98SRzOsjfokTDx+CvTETKJUkSvdjQL9u0MDpaMwVx3P4g1GCX1zkikFPaN1K9Sm4aIh8n7vEiJEr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541565; c=relaxed/simple;
	bh=9sb94Js3V8VTBdExsMdZhEhXDSOUKPKl2+NQoq2sf4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHxRBUaZq7+w+sAo/ORnrqqHCo8tN1nbHw4U4WIM1gcZhG4jGb3rNsG1eEGmfRJiJDEILWJT+gdoiifKDFM+y3C37ZRzk+VOAFe3clXK7TeQj2l9UhFYRVSeR9YzxqPXlNp96vLshyuMarQmR2xgJpwxU9N4rdvO2tPP9NmIiP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqoXwJUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15429C433F1;
	Wed, 27 Mar 2024 12:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541565;
	bh=9sb94Js3V8VTBdExsMdZhEhXDSOUKPKl2+NQoq2sf4I=;
	h=From:To:Cc:Subject:Date:From;
	b=JqoXwJUtsIiUCJg3O5uZzueSdnf9IILqbcj/OWpKHlByZQIf6l/Q55rskJqqX91wa
	 QvCFvb5wahgz9+JOp9eS25R9ZJhlj8uAhoTxiGhxWzZlDjF5fUEBvqDHbtnT3THH1F
	 3v5bWipRPa+eHiWiKXzpSz91BqxebvVN7Ei2M1lX3LKpapogJsKX77ZHTYQa8QTkds
	 UuEFz7/Om/ZnS2paw8cdsJwXcgQNNIXYq//TnxjjJZf0z5/0eRZm8B9z/iotPO9KIz
	 UHmYVjgYdipS8KEBbiYqobFoiz9VRoew83TYUyAWAYtpS7vrv0nZIqG9H59rL+7ntu
	 tVifnELe8LgnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wenjing.liu@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Lock all enabled otg pipes even with no planes" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:12:42 -0400
Message-ID: <20240327121243.2829736-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 94040c2cbb1a872ff779da06bf034ccfee0f9cba Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Fri, 23 Feb 2024 15:17:39 -0500
Subject: [PATCH] drm/amd/display: Lock all enabled otg pipes even with no
 planes

[WHY]
On DCN32 we support dynamic ODM even when OTG is blanked. When ODM
configuration is dynamically changed and the OTG is on blank pattern,
we will need to reprogram OPP's test pattern based on new ODM
configuration. Therefore we need to lock the OTG pipe to avoid temporary
corruption when we are reprogramming OPP blank patterns.

[HOW]
Add a new interdependent update lock implementation to lock all enabled
OTG pipes even when there is no plane on the OTG for DCN32.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 23 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  2 ++
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index b890db0bfc46b..c0b526cf17865 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1785,3 +1785,26 @@ void dcn32_prepare_bandwidth(struct dc *dc,
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
 	}
 }
+
+void dcn32_interdependent_update_lock(struct dc *dc,
+		struct dc_state *context, bool lock)
+{
+	unsigned int i;
+	struct pipe_ctx *pipe;
+	struct timing_generator *tg;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		tg = pipe->stream_res.tg;
+
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+				!tg->funcs->is_tg_enabled(tg) ||
+				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
+			continue;
+
+		if (lock)
+			dc->hwss.pipe_control_lock(dc, pipe, true);
+		else
+			dc->hwss.pipe_control_lock(dc, pipe, false);
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index 069e20bc87c0a..f55c11fc56ec7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -129,4 +129,6 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 void dcn32_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context);
 
+void dcn32_interdependent_update_lock(struct dc *dc,
+		struct dc_state *context, bool lock);
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 2b073123d3ede..67d661dbd5b7c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -58,7 +58,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
-	.interdependent_update_lock = dcn10_lock_all_pipes,
+	.interdependent_update_lock = dcn32_interdependent_update_lock,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn32_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
-- 
2.43.0





