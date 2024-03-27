Return-Path: <linux-kernel+bounces-121163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD688E48D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53AFB33ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CAE179954;
	Wed, 27 Mar 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mydiB3jJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B217994A;
	Wed, 27 Mar 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542245; cv=none; b=Z6np3iWUGtl0o0rBdh67qyyYyCNm3G69aiyKP9ZvJchUOyBTqB/mx/ve2LgOZSsVjdqbT1lcznnSGG2vp9v8ECEOG0OK8P/5UiX6sMSgzbXHz3pcsz9Dw8Bmr2BPxRVE6n2WhNvNk54qZWL8CcBbSAssi85mWe45AJC8aexL/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542245; c=relaxed/simple;
	bh=2e4nznqGmSolUy7QF6LZLCJjpsdmnPv9Jqyh4dqsR/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8VG7oZvWkmQPk4/xxV1BYiE4t+hZEV+Agu5/EgQjebhtWl8VhXKuiWoiPhpy6GZA4NBg8Mq6lSOsIiKBPHL3hS6EjmOK52W4OYkgGXIF69c8E3hAriXKiQRtIiDBmRFWj0R3Kt0ZOZTfglOnEiu5zCAsZlYyKxAFz2zfjX7UNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mydiB3jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50F0C433F1;
	Wed, 27 Mar 2024 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542245;
	bh=2e4nznqGmSolUy7QF6LZLCJjpsdmnPv9Jqyh4dqsR/E=;
	h=From:To:Cc:Subject:Date:From;
	b=mydiB3jJp0HH7dBc9G//YDpSvufjEMo0AXI7nBb8AMdokI7IPDB26f1nb0X+aJjS1
	 FkB7LLtshyAulo0j/dGJEZf69efr1Ajddmp9lrW9ScZnVieK47guiNKIW6m0NxqMzF
	 ue2X83xn3ov5WP1qYFF8UXwSdKqe3S+95HHMeJ5k8pVZEvTjqdXl21NMLAvzWutrWJ
	 bHE6+ggeBJW7hk849Rf+ImyV30C0yT3avMfufnolKuqrZlQOr8ExyF1mYbV0tex6Jg
	 mVK0ytgNXYxDF6vITOKpGaY2qQsnOG5z90YhJXm2bY8dnHLu+cq3ZmC9i5+RgclB8y
	 FQNTmT4WQu2Gg==
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
Subject: FAILED: Patch "drm/amd/display: Override min required DCFCLK in dml1_validate" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:24:02 -0400
Message-ID: <20240327122403.2839073-1-sashal@kernel.org>
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





