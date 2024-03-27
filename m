Return-Path: <linux-kernel+bounces-121255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D294688E468
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12371C2BCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392B714264F;
	Wed, 27 Mar 2024 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJSuPMyI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EC130AD9;
	Wed, 27 Mar 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542472; cv=none; b=UynDWvNim4NSZVZcZkfNgGtdeZZw5uNgxneC8mhplWarFLgnlRJeIVCGMhAz/FWh5IH8UwpWhjdrAPOoJjJV4sJQxVJtX+uSnurzAbSU9dxF+CyAwMN/4Z9kWNNWwIrFWA1LBOsdkoAY2tn8bR9l0xKY1+9HWOP2LnmPEJYtnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542472; c=relaxed/simple;
	bh=4j7xOyFIOAoBexVjx0vKlpN7tyhmAHrYlqfIm6sy5n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSykLh0oxZwR+Huk07NMe+SC0LqxD4qU8fe4TLPUAV39fuNVXgnSfxywMUXEsFOWuLKuE8fCWqCKal+uym6wm5ZoMAzoPU44RsIR50x79nVE+rRMN2KIcYGJrLqmCMyPTRFLp6+FDhgcM/K4QySjSs/fpgmIiUeARpj1+0oXNNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJSuPMyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D92C43394;
	Wed, 27 Mar 2024 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542471;
	bh=4j7xOyFIOAoBexVjx0vKlpN7tyhmAHrYlqfIm6sy5n4=;
	h=From:To:Cc:Subject:Date:From;
	b=rJSuPMyIYFPgQr9pP1A8j/AIdR+/31uBKL0EGv+oc08IEvyh3+xJniaWxTMM6R15i
	 wp4YUOaQtMSDdQ1kkOd6vbjYUF2LkDk+bDXd5gbNz09aXhWJaS4iKBJX6B9uHldKBh
	 04/tgi1Fe9L/TuHBbsx/BgY3Zh98aE6RZjsCwB7QjauAivf3Moh91L8LlEJYNW1Gm+
	 8CUp0u6IVW2XG/Juxc/JEO18wJx5Q59lBcMlXDKCOO9nieKN+lCeNiUjmPMCJ0moqx
	 k2IVEEGXzbAvR6GzAxxtTLP/St5jOElmyfklCYlq1hKBsnzyU5OCy1e3wjXI5y/L63
	 VWeMRS1oegVZQ==
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
Subject: FAILED: Patch "drm/amd/display: Override min required DCFCLK in dml1_validate" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:49 -0400
Message-ID: <20240327122750.2842254-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





