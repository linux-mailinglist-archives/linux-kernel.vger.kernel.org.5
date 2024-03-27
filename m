Return-Path: <linux-kernel+bounces-120805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B8888DDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC7928FB25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3F1311A8;
	Wed, 27 Mar 2024 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvVLnc36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39113119A;
	Wed, 27 Mar 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541252; cv=none; b=HnZwN3knY+P+zi+OQiI7CsffdPWZx/ZzspLRnss4dWJXEZeQhnk5gludUVmFnhu0arHK1CBHvk3K6vUPIizsTc2z67ATFaxKpghfECAnUqm+7NOGQb4r5ORxcSEEA+BBOYBkDOm63+vVJFG+DYwO9/bOmX6sNIy7NaUx4XGFm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541252; c=relaxed/simple;
	bh=ElQjemkTy+4VYzAjeaa9PAkt1zZ5MmKXVbhrRMyOGr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKVcdc5ssQTDf8F4p/rvtKl+d3SSsI+olgSpD+WccGxvR5w4fg6TLbyNb7/AB/iw0A42gz5/3InSiM4YxWFYmd6oOG3gbeeHcMJWl4exHH7LZKIG0kqAZmSnNUPYqp6O7THTtLmLyqtUjEGm+/wL55f8B4k9lewg6Fe5E5r4kkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvVLnc36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F481C43330;
	Wed, 27 Mar 2024 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541252;
	bh=ElQjemkTy+4VYzAjeaa9PAkt1zZ5MmKXVbhrRMyOGr8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZvVLnc36m5OAUbarFrIwUmPmyjaMBtdv5WsetpgRJOzE2C8TNA8X/hl0FbOyg0Rgb
	 U+xBw8DfrE1KN26n0lVGO8XiIQN8WUh86ZQpezhpKr6hpykxhoA5UasiFtphfptZZn
	 Fw52kCgFsNQVG3CAp4QFLZwtt0qtZV4kKtVlhc2rQ7ayXh+CZ1JbaHskxQiqy89S5Z
	 mpCf4Rb0ZIlC0jdHWykKoeDKyFEg6bnn8BKYX1miLyijqLa30vrXjKnib7YRvZYTrS
	 4mLf/QvtH4YiRx1sk7+udeGg/5bWB7z10zEclpgVL9BIOBWC2GVWc/6S15+1SdyeOr
	 nCTMU8JyuwG0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sohaib.nadeem@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Josip Pavic <josip.pavic@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: fixed integer types and null check locations" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:07:30 -0400
Message-ID: <20240327120730.2825491-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 616b39467e816851335277d817ec98b7a9b92758 Mon Sep 17 00:00:00 2001
From: Sohaib Nadeem <sohaib.nadeem@amd.com>
Date: Wed, 31 Jan 2024 16:40:37 -0500
Subject: [PATCH] drm/amd/display: fixed integer types and null check locations

[why]:
issues fixed:
- comparison with wider integer type in loop condition which can cause
infinite loops
- pointer dereference before null check

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser2.c   | 16 ++++++++++------
 .../drm/amd/display/dc/link/link_validation.c    |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 960c4b4f6ddf3..05f392501c0ae 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1850,19 +1850,21 @@ static enum bp_result get_firmware_info_v3_2(
 		/* Vega12 */
 		smu_info_v3_2 = GET_IMAGE(struct atom_smu_info_v3_2,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
 		if (!smu_info_v3_2)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_2->bootup_dcefclk_10khz * 10;
 	} else if (revision.minor == 3) {
 		/* Vega20 */
 		smu_info_v3_3 = GET_IMAGE(struct atom_smu_info_v3_3,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
 		if (!smu_info_v3_3)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_3->bootup_dcefclk_10khz * 10;
 	}
 
@@ -2422,10 +2424,11 @@ static enum bp_result get_integrated_info_v11(
 	info_v11 = GET_IMAGE(struct atom_integrated_system_info_v1_11,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
 	if (info_v11 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v11->gpucapinfo);
 	/*
@@ -2637,11 +2640,12 @@ static enum bp_result get_integrated_info_v2_1(
 
 	info_v2_1 = GET_IMAGE(struct atom_integrated_system_info_v2_1,
 					DATA_TABLES(integratedsysteminfo));
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
 
 	if (info_v2_1 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_1->gpucapinfo);
 	/*
@@ -2799,11 +2803,11 @@ static enum bp_result get_integrated_info_v2_2(
 	info_v2_2 = GET_IMAGE(struct atom_integrated_system_info_v2_2,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
-
 	if (info_v2_2 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_2->gpucapinfo);
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index 1c038e2a527b3..1aed55b0ab6a0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -359,7 +359,7 @@ bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const un
 	struct dc_link *dpia_link[MAX_DPIA_NUM] = {0};
 	int num_dpias = 0;
 
-	for (uint8_t i = 0; i < num_streams; ++i) {
+	for (unsigned int i = 0; i < num_streams; ++i) {
 		if (stream[i].signal == SIGNAL_TYPE_DISPLAY_PORT) {
 			/* new dpia sst stream, check whether it exceeds max dpia */
 			if (num_dpias >= MAX_DPIA_NUM)
-- 
2.43.0





