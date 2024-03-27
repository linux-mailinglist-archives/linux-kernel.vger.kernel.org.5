Return-Path: <linux-kernel+bounces-120911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944688E06C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048DB2A2CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6F4148FE7;
	Wed, 27 Mar 2024 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxIZa/Na"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739DE148FE0;
	Wed, 27 Mar 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541562; cv=none; b=VYKA3a6l/5mKivJGGvJQ4AJzFSFPjoO+si9fsUmekHTeNBBp+/6K+dt0SuVdbs4cllJeR1jOmhoU3yzePB9NrA4iaJzkUNPiev6Sk+Dt8Pc/1cj3zBxG1dUqlPcWEHHHSOCmVgG0ufgG00GSdXgCjaESnTHm98PQre2DpXdHWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541562; c=relaxed/simple;
	bh=3gOTcSfpvoPoURCbubBqohbjwh1DJnoyYzhkx4XqD3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzi6NZ7ta2/Flky7q6Gf6MDNaTcqqmJoTFYnoSnBdlKeGakwlFXaz8GxIfBWl0dLqFsRSMeIhQJyxu9jib/bDgacQuCLPLN2yyst1WyoClMMKhp8w7LVaZ2vD+s0XeXHYJRYNOGs7zRUHT3sWk8YnZNi1VIyldx4LolchfhYhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxIZa/Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2913C433C7;
	Wed, 27 Mar 2024 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541562;
	bh=3gOTcSfpvoPoURCbubBqohbjwh1DJnoyYzhkx4XqD3g=;
	h=From:To:Cc:Subject:Date:From;
	b=oxIZa/NaXbeq67l7M6kzzEguu4C/X4yxCgplAZtPJmuR2tGFVmLBdVbUKjbtHRL7L
	 fu1V42EFmlxODR9DgFriD5Tc3tPJOdkfT1dF+ilRQicpK5bSFFX7DhUqk0lnswEJst
	 GRsyA+/Na5uyk3yBL9myaYtQekDfYh6PT8o+3WpduiO/MoBT8t+0WplaRzQYmVdRde
	 4tuo9b+taJCzY6CQgOhJDSmGBZROtjaTr0IJ8j9ZZHTc+2i8PXAP2yKaf4AKuyqGHs
	 2IjdLxAqs5GgX06Hns6rhx8mAfZ+UyDBhhPSZXqG9HCG1fLsxjWXY9B1PPxqSzTbrA
	 WkJmnGtR7FlfA==
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
Subject: FAILED: Patch "drm/amd/display: Fix late derefrence 'dsc' check in 'link_set_dsc_pps_packet()'" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:12:39 -0400
Message-ID: <20240327121239.2829699-1-sashal@kernel.org>
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





