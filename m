Return-Path: <linux-kernel+bounces-120861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ADD88DF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A1729B376
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7275C13F011;
	Wed, 27 Mar 2024 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3hKxehw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB013E89A;
	Wed, 27 Mar 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541416; cv=none; b=mITxKvVuUv8hc4ndYM9hrSnfAokr5b6Amr+whwS+EYRykUZbSOuVDlAi1ksKR0CCUZr29gSu/djBDA+5r2ViXQXh/MjVncyrYLyFZHSJTXylj1mKETIssEm85tDfCKYz3VMYxzP6eb28BoQcjbtdbzp0oU8RJNXdnIzMN+lijuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541416; c=relaxed/simple;
	bh=c8SN4/lCpKMitjXB3iBSLw28bk/PHz7DCX4goeT/MJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9Qrzpq0Vkfb4UPk0yDGWWQwVNPdpRhQHUvZ1tuHxgPc0HlRSAJ3/77ihbYd6LPnarQjjATdcx3Pabxk5CMiNQAdoncO03FZFbhlViRA4otdSf3maPs6v0GPMjrR3Qzaa15o6fbQx8GoiwypB78QVDegYuS/hPvwWCJx15Xx7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3hKxehw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C04C43390;
	Wed, 27 Mar 2024 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541416;
	bh=c8SN4/lCpKMitjXB3iBSLw28bk/PHz7DCX4goeT/MJo=;
	h=From:To:Cc:Subject:Date:From;
	b=Q3hKxehw6tgv4dOtH80hkV2Kj2+SHpxF9XIulZ9+nJw/Ncj7XYrhrcgBzMVcK8N/h
	 7VdS+OHgAPJ9WfVjG5SGFxaGQf7Oxia6v/DbDLRO+H7IMvuUfB0C8i9qZEWns7nD3m
	 ko9mpba2wLGPi3hPVeaR9V+E+NZizav+QQzj/Hmjj+TWVm+gOEgTrbQgSjFIAcBmhp
	 5uYUYL8DHmBYLchAnW1SLO6Xwim7ILDy35u/lsnAaram7XuFX1pJUM/OA6VIvD/4wJ
	 VJZrsJFA0j9oSm2R1+EeIpMuvgogn2DIYyOMNU/r5EoegbOEFeXmbixde4lUkBzBaB
	 C2eqP6JaKczxA==
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
Subject: FAILED: Patch "drm/amd/display: Fix DML2 watermark calculation" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:13 -0400
Message-ID: <20240327121014.2827700-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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





