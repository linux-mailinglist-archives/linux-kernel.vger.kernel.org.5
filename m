Return-Path: <linux-kernel+bounces-121159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A088E2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA801C2858A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA317920C;
	Wed, 27 Mar 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+mjR2ny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6321791EF;
	Wed, 27 Mar 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542234; cv=none; b=A6CsxChEUJnALjJ/nKiZq455fuU+GB98+He7bkIWuR68wY1Y9Agda44M047vZnyvE9cGPqj3CyDlMPEHLtV58GojIVKDBzV7+T0J8BtfO9VkPjQu65fMkIhW+BYJYFshrS99eE3/oht62E/rzBKbgFwC2YfCtg61o2CmgGx22ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542234; c=relaxed/simple;
	bh=kqYpGQ7hgdiK6AlbrcfQv3HYzNkpuWt8kVKuJMBnGH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSfPUlmDROjaeh5s1I45p7gJVne3zLSKTQQbI/G7aJAtk8tx0S/taXG3owJa0OrR52M+58ZLOo1YQaA45z7PFCGEtLb1O6zbCzfXclM+/ic90ee55g4P5kYz4dJhgVll7Bx9QqUxXfKUn/kPZyzHTXF4toMZ6SK/F4Ce+VHPrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+mjR2ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DD5C433C7;
	Wed, 27 Mar 2024 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542234;
	bh=kqYpGQ7hgdiK6AlbrcfQv3HYzNkpuWt8kVKuJMBnGH8=;
	h=From:To:Cc:Subject:Date:From;
	b=h+mjR2ny3XmHiTzu5m8JIJ3meNw1RGQTysp5+yctTGonjYEdyfdJfEMrqEiroNDK1
	 OaVyM9SXHFhndMEl6IOJJ+RTWeqTepvuFHD3guNRN4JKJF8IZtOMpVp1RnI1/gXTXl
	 IC1h0bNlLAVHmvpQNuLML0xmQkQmUT35nd8SW6BdwBqxbbg2CXQpiP5C9wnuxytA02
	 Lq4dEl+foh6N+/zvatiPW1UAo63AdPKdSHdqhAFotntBXzreXlGC/mPxQtPUYUVi5R
	 jAc90+n6pOpHlxKbCjOYCJo+Q0qDlCxNhfEkk30jBkv27TILpPkqotr6x1a3hsKB1p
	 zX2bPpDl8b/yw==
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
Subject: FAILED: Patch "drm/amd/display: Fix noise issue on HDMI AV mute" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:52 -0400
Message-ID: <20240327122352.2838921-1-sashal@kernel.org>
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





