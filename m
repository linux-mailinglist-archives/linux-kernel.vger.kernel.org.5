Return-Path: <linux-kernel+bounces-121090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE288E23E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B421C2156E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8C416EC01;
	Wed, 27 Mar 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbPLby8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54316EBEC;
	Wed, 27 Mar 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542051; cv=none; b=BPGDK+e0tIPvbp522TT9AmJZWqlPrO9xFNqrvY3MjhWo/n4ORE4UATssy4nHASksvMsR0nveJQSWIvBSxAgBmys1M1ilT7T35mL4dW9pAe+E+yC3XwDM7rhkc2WYt10vznQEu71eZKVF4nVHLO2Cmd9DgvnCUDRink/ni6SBNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542051; c=relaxed/simple;
	bh=MY6Msd5ZZwC9n8085OfFa1is44/bOUeMRgmyWKGvnMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzRxTnYyIHcKnMX2YAKLGWb2pWVHUs9egaKGzpGQVSTYj+0v6CEAlwkqZoUckBKGo7QjQyvVdDp6WrNW6MJr0Hm523Xr+T0bg/JR/MXXxjrGw+geN3WdyOhTStJWjb87/u2B/vZY7uSKGECFPLeZfkcNHQfSEfhTsBfXoG5N/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbPLby8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0771C433A6;
	Wed, 27 Mar 2024 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542050;
	bh=MY6Msd5ZZwC9n8085OfFa1is44/bOUeMRgmyWKGvnMw=;
	h=From:To:Cc:Subject:Date:From;
	b=jbPLby8bncUJG3SQ7WQc+tGs3ms5+A0r6TMHQxpgoueYOk9KTsVq+Ep0h5EUxd6nQ
	 Ec0TQRAzA5q0A5z80SWGYdTVo9Uw5aPo1zDiloezE7ndyxm7hNQvGnNLTEtxciejcy
	 RDkanMFngrGLvu8zIUx1adujiCbksCLyHvj5dkH6RjqNjC/+1J7bIzwbxKmmrHYPpB
	 zdPMUjd+jxXfSJ9dJrTfYK5lSmo/8mlpvY0tIz3ArorPUJqbW9SAVErGEwq3FLYMBj
	 r9EQ/qcfUwZW+JVVMadTOTjlpXeVnaj0mCbubuTuIrdnbbgg9NXU7MgErw0eLgAeKK
	 q2FRCWnN2mCIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dillon.varone@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Init DPPCLK from SMU on dcn32" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:20:48 -0400
Message-ID: <20240327122048.2836343-1-sashal@kernel.org>
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

From 4f5b8d78ca43fcc695ba16c83ebfabbfe09506d6 Mon Sep 17 00:00:00 2001
From: Dillon Varone <dillon.varone@amd.com>
Date: Wed, 21 Feb 2024 13:21:20 -0500
Subject: [PATCH] drm/amd/display: Init DPPCLK from SMU on dcn32

[WHY & HOW]
DPPCLK ranges should be obtained from the SMU when available.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 14 ++++++++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 28 +++++++++++++------
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  3 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  2 ++
 .../dc/resource/dcn321/dcn321_resource.c      |  2 ++
 5 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 668f05c8654ef..bec252e1dd27a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -216,6 +216,16 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	if (clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz > 1950)
 		clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = 1950;
 
+	/* DPPCLK */
+	dcn32_init_single_clock(clk_mgr, PPCLK_DPPCLK,
+			&clk_mgr_base->bw_params->clk_table.entries[0].dppclk_mhz,
+			&num_entries_per_clk->num_dppclk_levels);
+	num_levels = num_entries_per_clk->num_dppclk_levels;
+	clk_mgr_base->bw_params->dc_mode_limit.dppclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DPPCLK);
+	//HW recommends limit of 1950 MHz in display clock for all DCN3.2.x
+	if (clk_mgr_base->bw_params->dc_mode_limit.dppclk_mhz > 1950)
+		clk_mgr_base->bw_params->dc_mode_limit.dppclk_mhz = 1950;
+
 	if (num_entries_per_clk->num_dcfclk_levels &&
 			num_entries_per_clk->num_dtbclk_levels &&
 			num_entries_per_clk->num_dispclk_levels)
@@ -240,6 +250,10 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz);
 	}
 
+	for (i = 0; i < num_levels; i++)
+		if (clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz > 1950)
+			clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz = 1950;
+
 	/* Get UCLK, update bounding box */
 	clk_mgr_base->funcs->get_memclk_states_from_smu(clk_mgr_base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 2a58a7687bdb5..72cca367062e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -703,13 +703,8 @@ static inline struct dml2_context *dml2_allocate_memory(void)
 	return (struct dml2_context *) kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
 }
 
-bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
+static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
 {
-	// Allocate Mode Lib Ctx
-	*dml2 = dml2_allocate_memory();
-
-	if (!(*dml2))
-		return false;
 
 	// Store config options
 	(*dml2)->config = *config;
@@ -737,9 +732,18 @@ bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options
 	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
 
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
+}
+
+bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
+{
+	// Allocate Mode Lib Ctx
+	*dml2 = dml2_allocate_memory();
+
+	if (!(*dml2))
+		return false;
+
+	dml2_init(in_dc, config, dml2);
 
-	/*Initialize DML20 instance which calls dml2_core_create, and core_dcn3_populate_informative*/
-	//dml2_initialize_instance(&(*dml_ctx)->v20.dml_init);
 	return true;
 }
 
@@ -779,3 +783,11 @@ bool dml2_create_copy(struct dml2_context **dst_dml2,
 
 	return true;
 }
+
+void dml2_reinit(const struct dc *in_dc,
+				 const struct dml2_configuration_options *config,
+				 struct dml2_context **dml2)
+{
+
+	dml2_init(in_dc, config, dml2);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index ee0eb184eb6d7..cc662d682fd4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -214,6 +214,9 @@ void dml2_copy(struct dml2_context *dst_dml2,
 	struct dml2_context *src_dml2);
 bool dml2_create_copy(struct dml2_context **dst_dml2,
 	struct dml2_context *src_dml2);
+void dml2_reinit(const struct dc *in_dc,
+				 const struct dml2_configuration_options *config,
+				 struct dml2_context **dml2);
 
 /*
  * dml2_validate - Determines if a display configuration is supported or not.
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index f844f57ecc49b..ce1754cc1f463 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1931,6 +1931,8 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 {
 	DC_FP_START();
 	dcn32_update_bw_bounding_box_fpu(dc, bw_params);
+	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 	DC_FP_END();
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index b356fed1726d9..296a0a8e71459 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1581,6 +1581,8 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 {
 	DC_FP_START();
 	dcn321_update_bw_bounding_box_fpu(dc, bw_params);
+	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 	DC_FP_END();
 }
 
-- 
2.43.0





