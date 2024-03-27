Return-Path: <linux-kernel+bounces-121179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD088E32E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24891F2B2D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7617EB68;
	Wed, 27 Mar 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inga/pvK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8D17E3DB;
	Wed, 27 Mar 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542287; cv=none; b=Zf2UqvuA8dYno/lozXOd8EmYmOKYOq5zZnsMzTufEJ0qtdCpYzCriYUY7Ue0bRgHGy5N5VUofQkXPp5NpjiDrul6FvHOI3gVWM/Fnv2IRC+cvIvsnL/XPA4AhD1NFVj5II5/twYFsWQ2brL0qUTbwhg5ArNE+/5OdhM/7OQRbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542287; c=relaxed/simple;
	bh=XM875+QDd4zTpNk0NKSsTFllf71onC13KL95irtBU2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGJb9FoWQ+GoCkPUN1AqJxU3pBDr9fKXoXUnIke+7HSNKRd4zjJ9hNBkb3iKVaS60VCSW8u8wCFH54oJzSzZgufUBPQkze8VwkKM7yg1UKvqT4d0LsbTqZNPcthCGJKLhoRD1jdfh6Vbmy2tSdDViyKoJN3QAiVnE67nhHVqpuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inga/pvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C623FC433C7;
	Wed, 27 Mar 2024 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542286;
	bh=XM875+QDd4zTpNk0NKSsTFllf71onC13KL95irtBU2c=;
	h=From:To:Cc:Subject:Date:From;
	b=inga/pvK4Z+1oAqGEDHjfzuTt6BPhHwUi7lB8L/BUcpS08f8NXjM0SR4trdRCdjwl
	 BrqRTDx/pF3a6XitSAza5IRtHNvxcHVqX4TxyQqDou59kzXofXhmt7cjYzP2pF64Ge
	 5vBucQoUVW0KGV+jr6Rv34AVfA6qThE03hCj781NFRsIlVgRZdcM1a69WR39xFNXfB
	 JaJ5hi8Vdw49ZmHsYvS1eKw3sMpWRhLaCRJFyEbeaxW3Ryp/HkwIYSmWlRMS0ek8t8
	 HJ8QB6py3BKw7FBd8p+aKD5kLXcjddPTcU7mmEtlpO10R/pSuiBg5gwX+Hcm+XEif4
	 +lYsO9sfnaJ6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jerry.zuo@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:24:44 -0400
Message-ID: <20240327122445.2839653-1-sashal@kernel.org>
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

From 4ba9ca63e696f7bdc91293aeb70c22203b7089be Mon Sep 17 00:00:00 2001
From: Fangzhi Zuo <jerry.zuo@amd.com>
Date: Thu, 11 Jan 2024 14:46:01 -0500
Subject: [PATCH] drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue

[why]
odm calculation is missing for pipe split policy determination
and cause Underflow/Corruption issue.

[how]
Add the odm calculation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c | 29 +++++++------------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 ++
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 8b0f930be5ae1..23a608274096f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -791,35 +791,28 @@ static void populate_dml_surface_cfg_from_plane_state(enum dml_project_id dml2_p
 	}
 }
 
-/*TODO no support for mpc combine, need rework - should calculate scaling params based on plane+stream*/
-static struct scaler_data get_scaler_data_for_plane(const struct dc_plane_state *in, const struct dc_state *context)
+static struct scaler_data get_scaler_data_for_plane(const struct dc_plane_state *in, struct dc_state *context)
 {
 	int i;
-	struct scaler_data data = { 0 };
+	struct pipe_ctx *temp_pipe = &context->res_ctx.temp_pipe;
+
+	memset(temp_pipe, 0, sizeof(struct pipe_ctx));
 
 	for (i = 0; i < MAX_PIPES; i++)	{
 		const struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->plane_state == in && !pipe->prev_odm_pipe) {
-			const struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
-
-			data = context->res_ctx.pipe_ctx[i].plane_res.scl_data;
-			while (next_pipe) {
-				data.h_active += next_pipe->plane_res.scl_data.h_active;
-				data.recout.width += next_pipe->plane_res.scl_data.recout.width;
-				if (in->rotation == ROTATION_ANGLE_0 || in->rotation == ROTATION_ANGLE_180) {
-					data.viewport.width += next_pipe->plane_res.scl_data.viewport.width;
-				} else {
-					data.viewport.height += next_pipe->plane_res.scl_data.viewport.height;
-				}
-				next_pipe = next_pipe->next_odm_pipe;
-			}
+			temp_pipe->stream = pipe->stream;
+			temp_pipe->plane_state = pipe->plane_state;
+			temp_pipe->plane_res.scl_data.taps = pipe->plane_res.scl_data.taps;
+
+			resource_build_scaling_params(temp_pipe);
 			break;
 		}
 	}
 
 	ASSERT(i < MAX_PIPES);
-	return data;
+	return temp_pipe->plane_res.scl_data;
 }
 
 static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_stream_state *in)
@@ -864,7 +857,7 @@ static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned
 	out->ScalerEnabled[location] = false;
 }
 
-static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_plane_state *in, const struct dc_state *context)
+static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_plane_state *in, struct dc_state *context)
 {
 	const struct scaler_data scaler_data = get_scaler_data_for_plane(in, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f74ae0d41d3c4..3a6bf77a68732 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -469,6 +469,8 @@ struct resource_context {
 	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
 	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
 	bool is_mpc_3dlut_acquired[MAX_PIPES];
+	/* solely used for build scalar data in dml2 */
+	struct pipe_ctx temp_pipe;
 };
 
 struct dce_bw_output {
-- 
2.43.0





