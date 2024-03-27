Return-Path: <linux-kernel+bounces-120941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4EA88E0C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14361F2E65C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410014E2DE;
	Wed, 27 Mar 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFjSLB/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE4F14E2C6;
	Wed, 27 Mar 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541647; cv=none; b=Cd4R1sUofQJkTLj9ucrw/Zw0xMNtoDDB+rL5ZNtw4XjVIikujsiJLuApheg6UYrpsIrnCBujO6xLgfujQFyoZKF2GP87vBFnT8+2u58kdmDA/+A6mSzTvbyofQ63PAi6X1E/hXOJBWR2Qk1OfKWTN4LEh/eJnX09jcDERcvRQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541647; c=relaxed/simple;
	bh=n2KXDGlwPFSyOKlHlu7yzrpEPwIlGByQlHFF9mdbVXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJOaDV5Krx3D3xjA8GlxvNH7LYnl8xGTY+LLt2J7mt9vjBXtJa/k5OivDqqhuzIeZtjv9ydWfh8Vew73yLwBlDxjB2mqTqa9QeG04Ojg0lwesJ0Xr2pfnFwvaL1x5qv6PnyDjI0ddd19kgOnB7UGmS7Wkl0cMgEoX8b51n9ED3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFjSLB/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1B9C433F1;
	Wed, 27 Mar 2024 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541647;
	bh=n2KXDGlwPFSyOKlHlu7yzrpEPwIlGByQlHFF9mdbVXc=;
	h=From:To:Cc:Subject:Date:From;
	b=WFjSLB/2XJQibIz/QgjrTRTITS2t0sWpC2tPtkwO6QH9TgOZMXBzQM2ww2EdFowxb
	 EtzesNGVzctsEEf0OM9QWTRoasc88pF8/bdTNdJ5PAoRE13R0Xutz8XhTuxMy13fkC
	 L7MipoYNEKJ3izRLwbQ31sRRjJsXovF15sp3y1nJkWU8D6gwaZ6hm7EqeNaWLdu6xP
	 Vyk3aznDKLpVALe7gNU7ZxDs/mDUYmK3EyUOccCPK2dhfKLGbyhEMpAlqj5jBk2r74
	 H0OxO3Jq8hYjg6Jkae0rqlSRSjOS9iBW+NR9U35QMqFLI7lRwLtZVoq5zb7iBfEdWl
	 UdHsNXiXAkgHg==
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
Subject: FAILED: Patch "drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:14:05 -0400
Message-ID: <20240327121405.2830847-1-sashal@kernel.org>
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





