Return-Path: <linux-kernel+bounces-121251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15D88E59A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E5BB2E6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5B1A434F;
	Wed, 27 Mar 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9o6h1tV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF7B1A4344;
	Wed, 27 Mar 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542461; cv=none; b=bDXcU3JehXuGP1qzH/rg88Eox/Zsd4/l8MTS3n5im0T3rR0VWVe/sgQFWeEOVmc+dBKz53d7e8t4oqQhYpBwaH03bTUMB3px3W+gbQYQAYsRHTNm0N2Erzbm2vradwKgQqgTg2eX1cjGq1bsAOP3pefgGFb7GWRKlCMrh5PmJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542461; c=relaxed/simple;
	bh=cTS98JDtdYWAwWJuHBqxfLgQO9ifxJ5kdKpRVvyrirg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hPm0OV1Sjl6sGHS4fVnROPuetmR1I061hp4j3602yj62giOGvYocu62n3LzQ124h9O6J0/NuemP449Gslxuse2ADGbjzHSmwhJNN6urKdw3imaPIA6/0j/o++6XHu5CZ78O8h/yjHOPueOPAg2kzDB1N6qQ8YonGVaQmVQtOJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9o6h1tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E482C43390;
	Wed, 27 Mar 2024 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542461;
	bh=cTS98JDtdYWAwWJuHBqxfLgQO9ifxJ5kdKpRVvyrirg=;
	h=From:To:Cc:Subject:Date:From;
	b=i9o6h1tVfSUKWmZrw/yvSm3fODGfMTwRMr1KwgZ0u5soliyM0hYhZlw0tzdxe58Ja
	 EewU3qaa48UvJnWwT83ky+PfqztQXWcoK0xJ5fA/do1fIZjaABr21V8fmOs4ujMkhB
	 pe2RsrC8tKidBctWP5Pae6fbzIezQc2MIBUuuuJm/EnJHw2qXFFqR9LA/ezzXN2rVl
	 W76YLzjZzm60dA2NPNEML0St1fMfrHt2lG7+h7/W5qbdlUx/xRVZ5nJDSXOmryhdiJ
	 HeDfeLYHAXWSN6GQR2odrGNnX1Ei1WJ0wtXUFArvk5NSmt0zg2ndfG7iwsdabuTYJH
	 ggF4NQ4eZMaOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hanghong.ma@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Fix noise issue on HDMI AV mute" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:39 -0400
Message-ID: <20240327122739.2842100-1-sashal@kernel.org>
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

From 69e3be6893a7e668660b05a966bead82bbddb01d Mon Sep 17 00:00:00 2001
From: Leo Ma <hanghong.ma@amd.com>
Date: Fri, 28 Jul 2023 08:35:07 -0400
Subject: [PATCH] drm/amd/display: Fix noise issue on HDMI AV mute

[Why]
When mode switching is triggered there is momentary noise visible on
some HDMI TV or displays.

[How]
Wait for 2 frames to make sure we have enough time to send out AV mute
and sink receives a full frame.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c  | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 7e6b7f2a6dc9e..8bc3d01537bbd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -812,10 +812,20 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 	if (pipe_ctx == NULL)
 		return;
 
-	if (dc_is_hdmi_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL)
+	if (dc_is_hdmi_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL) {
 		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(
 				pipe_ctx->stream_res.stream_enc,
 				enable);
+
+		/* Wait for two frame to make sure AV mute is sent out */
+		if (enable) {
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+		}
+	}
 }
 
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx)
-- 
2.43.0





