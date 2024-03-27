Return-Path: <linux-kernel+bounces-121137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F64588E2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C784F1F29565
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D18172791;
	Wed, 27 Mar 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzaoudRk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376B175CBF;
	Wed, 27 Mar 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542176; cv=none; b=e6y3iE60bMIw2DmK45eiwS5p+cfL+ChNqT9F/yi+fcMX+fuN4Qj595B9NAHogUR9Z3WY4LS5L2wcT0ovg/GziHyWWUeWASubDP5JRma1T2G01g8udjVPuCezoxZeAm3NTy2ivMiDRKpuedW9XnYLjITgBjRlzmDAk3Q9vFnzqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542176; c=relaxed/simple;
	bh=lFqNCpB6ODLA/PQPCpqDEOQQxvCrrz7uETbkZ3si95w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZ/VmbeblyHqiQkVGaiiC9tlMyqfv2afjsypkQOrl4qqWF41W12EyiN+Yr6TybFrWDTExJMYTSZM1tRZaqUy5ffUWVxuoknicwIpvxmMg84VpbHaFFMJ2LS8uiOQgcHAMGWcx/nuvjvBrhgPB3DbW814oMgS+2ES9In0ywpVZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzaoudRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F09FC433F1;
	Wed, 27 Mar 2024 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542175;
	bh=lFqNCpB6ODLA/PQPCpqDEOQQxvCrrz7uETbkZ3si95w=;
	h=From:To:Cc:Subject:Date:From;
	b=QzaoudRkoljO8XJwrq+T//7SHbMvu1ZBr6tl9/hNHF4buyLjoEANjfKnHlgZ6a1oF
	 KZdWPiAqxQwyA6TR/2osrLx0U07G2hjiPXleiXymw+nDGSWPZ20v4cngraExssGgi+
	 QZrN4ilSjX8KdGopWPvJaSQApcyZH0CdxTijaw1jKTIMWOCMAyoWlkaxRfcy7blUsx
	 WWFAyDZBTc74X2ws7faHElyGe16YIzgr6Awx8La2nFAuxH6HLHE69IxC2l4aD6hopP
	 VjrLLTJfI+4Da10hPPRdu14rg/Edh086+vJnevQAU4n06se9IqPFfmG8OPPof8WeyK
	 K9DRrbkVtDorA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	srinivasan.shanmugam@amd.com
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Qingqing Zhuo <qingqing.zhuo@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Fix late derefrence 'dsc' check in 'link_set_dsc_pps_packet()'" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:53 -0400
Message-ID: <20240327122253.2838058-1-sashal@kernel.org>
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

From 166225e79ccc3d02c4c46e1b3c09d03eb91473ca Mon Sep 17 00:00:00 2001
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Date: Wed, 10 Jan 2024 20:58:35 +0530
Subject: [PATCH] drm/amd/display: Fix late derefrence 'dsc' check in
 'link_set_dsc_pps_packet()'

In link_set_dsc_pps_packet(), 'struct display_stream_compressor *dsc'
was dereferenced in a DC_LOGGER_INIT(dsc->ctx->logger); before the 'dsc'
NULL pointer check.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dpms.c:905 link_set_dsc_pps_packet() warn: variable dereferenced before check 'dsc' (see line 903)

Cc: stable@vger.kernel.org
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 3de148004c066..3cbfbf8d107e9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -900,11 +900,15 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx, bool enable, bool immedi
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	DC_LOGGER_INIT(dsc->ctx->logger);
 
-	if (!pipe_ctx->stream->timing.flags.DSC || !dsc)
+	if (!pipe_ctx->stream->timing.flags.DSC)
 		return false;
 
+	if (!dsc)
+		return false;
+
+	DC_LOGGER_INIT(dsc->ctx->logger);
+
 	if (enable) {
 		struct dsc_config dsc_cfg;
 		uint8_t dsc_packed_pps[128];
-- 
2.43.0





