Return-Path: <linux-kernel+bounces-121054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4AF88E2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306D8B25E48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194DE13A89E;
	Wed, 27 Mar 2024 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaXzJmiB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A06812F5BE;
	Wed, 27 Mar 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541954; cv=none; b=hp24swrxX4NqKgBdeOyYg2JbtFEpQqH1Aj9HisPSikbM740eZqJIGKPdyUn7+QQ/rPH4xJpezdVKrY0RB1PYeuDcC5aiUcW2XjUu6eTKxiWf4mL/9uDJ9QAEYVS845XCvoKG6oUQnPy2FOgX1jbk7rFuQw9zuuQFFUfAkhCxoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541954; c=relaxed/simple;
	bh=nsceU3spMY3hnCmuqGJgvpiN6ewlHVXcz04JIFbKLKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9WldY6CUGfg7MwD5ho8rSMzqaSyF61H6qXpQWXQw0JHR4mwRfEma7BXPNK3cDUTPz4L20x4VHsuYjBsgMYdfR1wGcMiacSnI0ivq1Kxz5Y2kn4HerYf6GFSbQwzfnrDD8JOhzprVIJPDOxz77spm5ngoQ06dE/SvWStsMIfpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaXzJmiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66371C433C7;
	Wed, 27 Mar 2024 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541953;
	bh=nsceU3spMY3hnCmuqGJgvpiN6ewlHVXcz04JIFbKLKo=;
	h=From:To:Cc:Subject:Date:From;
	b=KaXzJmiBXtykRvgRpFmkfBXWOY5OpP/MGibO0Bar08Y+TOSyIEL0Cgy0W4NPMlpja
	 jvRO8PL3cwzrp8MqHiQA0Ng0ViqLc6tdJnbeK8SrS5i7tsTBaaPjxwZMVXJM3cMEWz
	 c5dhp9cOs4RnfEgVcTxdV0Da1f62sZIR8AlI/LMFgbTuk8NwTQpLOxe17/Ynj0JE1j
	 GYeZpGmKgwHuYF4xkDr9u9d7aaYF0KyN+PS5KhmSkXvyrWOXHqk7K/DPOlS4l8olw6
	 ujEhRKDbok8JDhRIErDiSIlfUPYxooW9FKjAQZcHJ+NuNdhaSQOP4kRZ8kjVb0Ulqa
	 58xsrn7Xamn0A==
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
Subject: FAILED: Patch "drm/amd/display: Fix late derefrence 'dsc' check in 'link_set_dsc_pps_packet()'" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:10 -0400
Message-ID: <20240327121911.2835004-1-sashal@kernel.org>
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





