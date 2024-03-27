Return-Path: <linux-kernel+bounces-121076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73388E21B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAED1F298C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE22416A992;
	Wed, 27 Mar 2024 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgEQfiG0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78616A1FA;
	Wed, 27 Mar 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542015; cv=none; b=dNx4csVb41z4kXYjb+LUnwyWhhZSfHUw0RU3Fl7uLhgBI/LiI0lM55Jbh64SJt+zRpNfxCveveHmtIKZIHxVEAJsmMX4Saz4p6SMuK4nhkEA8x9s3TUF+X4ntZaYVzhYc11QflUm7LwC/T0o4e3PE/xWt0rl10ZI2uGYoNsyAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542015; c=relaxed/simple;
	bh=YXy/tf3aHvUqjRRUhHyVb1RYNw+R7DCxhMDOO613Od0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKLx62HXq9653joQ4l//IbdZjsLaAxT4dffIMkF+GgPLelTSCPUBm7T8OtUB+0llEcZ7i+mnneMpM6f+Belsqy56DrPiHq4xXY/Urvt05DrFzIZ6ezlQbs8cKu6+1DPKqyJPaCnoo8REspW0ufiFsFhuEUXeflQ7vEbGlqW/Z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgEQfiG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997C1C433F1;
	Wed, 27 Mar 2024 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542014;
	bh=YXy/tf3aHvUqjRRUhHyVb1RYNw+R7DCxhMDOO613Od0=;
	h=From:To:Cc:Subject:Date:From;
	b=dgEQfiG0kwy92C+W87Uv1UHuRkhlC0kF5eNQD6oLiUYOayOO6rItYwogEIAuSwoaN
	 3n2KkCga/7WltU1DEUFDriz8qVAjZY5SWrubkDYBvNAgONx2uFxvNnkPqwvL2/gfHV
	 7p4MeTLe5lvtynnUdRDYSotuya1eNJT5jeqVqRa+8TX8e0ZXKRJn/ffUpaeyeDwrZS
	 D+jDSZTynuSR1sDfgJh4Gs6vhX2jlPvrVKW9IZi4sAqX20ZJ9Rgq20pBvoAWeDgQPu
	 te531pYtLC+UzLcbEg3eFZWvBdysFgMm8agvs+I2/FlEWHNVqTWd7tg8BeoparBqhs
	 /K8eaKfjqFeKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sohaib.nadeem@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Override min required DCFCLK in dml1_validate" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:20:12 -0400
Message-ID: <20240327122012.2835839-1-sashal@kernel.org>
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

From 26fbcb3da77efc77bd7327b7916338d773cca484 Mon Sep 17 00:00:00 2001
From: Sohaib Nadeem <sohaib.nadeem@amd.com>
Date: Wed, 14 Feb 2024 13:51:16 -0500
Subject: [PATCH] drm/amd/display: Override min required DCFCLK in
 dml1_validate

[WHY]:
Increasing min DCFCLK addresses underflow issues that occur when phantom
pipe is turned on for some Sub-Viewport configs

[HOW]:
dcn32_override_min_req_dcfclk is added to override DCFCLK value in
dml1_validate when subviewport is being used.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c   | 6 ++++++
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h  | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 87760600e154d..f98def6c8c2d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -782,3 +782,9 @@ void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc
 		pipe_cnt++;
 	}
 }
+
+void dcn32_override_min_req_dcfclk(struct dc *dc, struct dc_state *context)
+{
+	if (dcn32_subvp_in_use(dc, context) && context->bw_ctx.bw.dcn.clk.dcfclk_khz <= MIN_SUBVP_DCFCLK_KHZ)
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = MIN_SUBVP_DCFCLK_KHZ;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 3f3951f3ba983..f844f57ecc49b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1771,6 +1771,7 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, bool fast_val
 	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
 	dcn32_override_min_req_memclk(dc, context);
+	dcn32_override_min_req_dcfclk(dc, context);
 
 	BW_VAL_TRACE_END_WATERMARKS();
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 0c87b0fabba7d..2258c5c7212d8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -42,6 +42,7 @@
 #define SUBVP_ACTIVE_MARGIN_LIST_LEN 2
 #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
 #define DCN3_2_VMIN_DISPCLK_HZ 717000000
+#define MIN_SUBVP_DCFCLK_KHZ 400000
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
@@ -181,6 +182,8 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 
 void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes);
 
+void dcn32_override_min_req_dcfclk(struct dc *dc, struct dc_state *context);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
-- 
2.43.0





