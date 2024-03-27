Return-Path: <linux-kernel+bounces-120930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FE88E09C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFCCB247AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EAC14BF9D;
	Wed, 27 Mar 2024 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THK58In0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628FE14BF93;
	Wed, 27 Mar 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541614; cv=none; b=kfyI2gfWbYrp7zMm0YR1cJPJBtwtID0T6hn2KvSvKSSI0OwvaHxLX/ZHkH0cA05uxjoD3QUg/qZ+XwfKQF45Za66/gouc64xYttQy5El4HRPGxHOlIejtm6AEaVNdHi6JPZ+KFrXp75PZcOL/+dK4xDJQBNkH9XQaWcadCXf14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541614; c=relaxed/simple;
	bh=V9qog6KUlzfiBxeCvRptMdmUej1nz776FQ8Z8eWNvVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RE9ySPRJpuQjIJiQzCIXun9mo5F7Y8TUZ8EDB+1EdniXEbaYXJgQUAzWKrwh2L7i9peuo3KPlJyCGD1ktD6bAtlVlvSz5p4Qm5rN4j2yqE0ht4dUyCN36EXCsUwYJe2wb/ZrhS9z8fqVZMkjanvJ3MkL0t5+fCOTtu5PLhcKu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THK58In0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B840C43390;
	Wed, 27 Mar 2024 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541614;
	bh=V9qog6KUlzfiBxeCvRptMdmUej1nz776FQ8Z8eWNvVc=;
	h=From:To:Cc:Subject:Date:From;
	b=THK58In07ZadoKDaIBhjL4daMH+3kbiD7vYDTuGRnCQzYZyLS3zCCpvx7QyaP0ko2
	 wW+DCfoqLXUC1PK6ebv+c1P9j1Axqgu56zhOBwbS8sJsHJVG7Uk0feYY/yHvqSWnU3
	 EIutDJsJ1IIiQ2D8kJ6bd2b4EZfi6AfbhvOmQKVp1FFBQSMJY3o820bwWDm9cJrCf8
	 9twSt/ytn7h+NNpW3J0bB1VlxC7OYI6hCVVK1nUiDOrsRH5VP4rxPZWhmntbou9+X5
	 2MKHsmPFADKLF3AlIhOv/xngJXwPmcOeSGF7qHqYtPR9C6JUr1zLdLJjvm1A2hVQlB
	 FUt5XGugkDQjg==
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
Subject: FAILED: Patch "drm/amd/display: Override min required DCFCLK in dml1_validate" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:31 -0400
Message-ID: <20240327121332.2830419-1-sashal@kernel.org>
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





