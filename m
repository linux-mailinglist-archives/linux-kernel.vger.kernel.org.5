Return-Path: <linux-kernel+bounces-120986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A088E13D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E158F1C2A209
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0BB13848D;
	Wed, 27 Mar 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoM7Xf93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364F156669;
	Wed, 27 Mar 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541770; cv=none; b=B+qxy8BNJFtPFqY6J6C+pdU5fj5BaVolw6tgtJAr7rw1f9XLYCW745vCN7pEc9obtKKuwaHtRHF7PjBvWTHQwl7XrvGKWBoAdHID+JzjtaC+60mrmkpz2USNddgYKTmWPgwa0HghyDu8SOESVU3JT7w/6DZhYic/NOYDIyCEFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541770; c=relaxed/simple;
	bh=4eeXtnHEzLlp3KZRhr9CCl4o8WKNflKELunwkfEG/Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4Wx4OYSdfCh80cs0VYSjYoCatnv+Pc0Cz6EtDOPba7ccxhAbY7yhDo6Yofp3C1XwkZ/hzgPUVjMeZ7tEbgFQ7n4ilsiExHUeL3MLm3dz2YMpIAq6C1wcnwzKSfWWUra7SOi2IE0U/IMRI6K2mvfe5tnvwbhTcmnOsNkk/bMOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoM7Xf93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBA7C43390;
	Wed, 27 Mar 2024 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541770;
	bh=4eeXtnHEzLlp3KZRhr9CCl4o8WKNflKELunwkfEG/Bg=;
	h=From:To:Cc:Subject:Date:From;
	b=qoM7Xf93ZqCu/DGIFzdsXYcWmXZQj/zlN5gGQ+P1/uynu9Rs5YWrREHjKl9iA88jG
	 y6Ql14iy/qJ7XWTN3iKljVFvIS671eugQNrmBYv1O0+NFbxxhGoK9G2yKr8yYZYX92
	 GfSWhJKBzuwpriL1mdvSALHNwBygc2KUxnPz8Z3FUaLYxFzyEy3PDmMce4T48kJYUv
	 iCRxGnZl14zmELwg/aQK4GB7oOJbVG7AZSqQpwUT9mHX4vTMnqPtP9/0YO/aCVngzo
	 ZQTnXp+M9f/jTgoYua7s3zw+tFoG249d2Q3JQKHME+1wrV/TCRj6in2Be14/sL2lOO
	 tU6qp5Z4ApKMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ovidiu.bunea@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Fix DML2 watermark calculation" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:07 -0400
Message-ID: <20240327121607.2832462-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2254ab45dab22a18fdd29fe0e471706872c00093 Mon Sep 17 00:00:00 2001
From: Ovidiu Bunea <ovidiu.bunea@amd.com>
Date: Mon, 18 Dec 2023 21:40:45 -0500
Subject: [PATCH] drm/amd/display: Fix DML2 watermark calculation

[Why]
core_mode_programming in DML2 should output watermark calculations
to locals, but it incorrectly uses mode_lib

[How]
update code to match HW DML2

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dml2/display_mode_core.c    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index a6b938a12de13..9be5ebf3a8c0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -9446,13 +9446,13 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 		CalculateWatermarks_params->CompressedBufferSizeInkByte = locals->CompressedBufferSizeInkByte;
 
 		// Output
-		CalculateWatermarks_params->Watermark = &s->dummy_watermark; // Watermarks *Watermark
-		CalculateWatermarks_params->DRAMClockChangeSupport = &mode_lib->ms.support.DRAMClockChangeSupport[0];
-		CalculateWatermarks_params->MaxActiveDRAMClockChangeLatencySupported = &s->dummy_single_array[0][0]; // dml_float_t *MaxActiveDRAMClockChangeLatencySupported[]
-		CalculateWatermarks_params->SubViewportLinesNeededInMALL = &mode_lib->ms.SubViewportLinesNeededInMALL[j]; // dml_uint_t SubViewportLinesNeededInMALL[]
-		CalculateWatermarks_params->FCLKChangeSupport = &mode_lib->ms.support.FCLKChangeSupport[0];
-		CalculateWatermarks_params->MaxActiveFCLKChangeLatencySupported = &s->dummy_single[0]; // dml_float_t *MaxActiveFCLKChangeLatencySupported
-		CalculateWatermarks_params->USRRetrainingSupport = &mode_lib->ms.support.USRRetrainingSupport[0];
+		CalculateWatermarks_params->Watermark = &locals->Watermark; // Watermarks *Watermark
+		CalculateWatermarks_params->DRAMClockChangeSupport = &locals->DRAMClockChangeSupport;
+		CalculateWatermarks_params->MaxActiveDRAMClockChangeLatencySupported = locals->MaxActiveDRAMClockChangeLatencySupported; // dml_float_t *MaxActiveDRAMClockChangeLatencySupported[]
+		CalculateWatermarks_params->SubViewportLinesNeededInMALL = locals->SubViewportLinesNeededInMALL; // dml_uint_t SubViewportLinesNeededInMALL[]
+		CalculateWatermarks_params->FCLKChangeSupport = &locals->FCLKChangeSupport;
+		CalculateWatermarks_params->MaxActiveFCLKChangeLatencySupported = &locals->MaxActiveFCLKChangeLatencySupported; // dml_float_t *MaxActiveFCLKChangeLatencySupported
+		CalculateWatermarks_params->USRRetrainingSupport = &locals->USRRetrainingSupport;
 
 		CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 			&mode_lib->scratch,
-- 
2.43.0





