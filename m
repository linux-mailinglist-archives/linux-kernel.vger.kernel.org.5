Return-Path: <linux-kernel+bounces-120833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42888DEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3464FB26DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851413A406;
	Wed, 27 Mar 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUifKztH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5112F5AE;
	Wed, 27 Mar 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541331; cv=none; b=pReiaQoSQm7FrMgyD/80q0I99F0z2tgFZYlV31q9zXq/Bul8/eRS6CQ//P7ElnUI1Ob2CuUX2aFAqCcAoGfuPgQOOkg/wYh81vBBQj225iWDJaEa1DBw4SxzvI6ymASpKF6a1wsV20dqeX6MkkQraaPcXfjjhl0Umy/iPS7dQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541331; c=relaxed/simple;
	bh=BP4g5gevDV+/xYAfznoYbnDVZvfHP9AeGOYPw4Hb6Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtOqWdm8f5mqbsXpZlqqSu0mDdAfQ3omiRv88LpPFXIVKsQUBjUIPvu7t2c2ul3lfdqNTszG0EJlrtPacYpbLaBi5EJ4ku1QRwBrRrNbqCszSGqcoXB8L74p9Honl45vzRlTEGwajhiNtEbz4QMCYK7bKiDbfwX1FM5lc++viKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUifKztH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5020C433F1;
	Wed, 27 Mar 2024 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541331;
	bh=BP4g5gevDV+/xYAfznoYbnDVZvfHP9AeGOYPw4Hb6Gc=;
	h=From:To:Cc:Subject:Date:From;
	b=JUifKztHRAC6/77/f8zp98Kklqz6ND/ieuDHOkJSG7s4y41efZFS8wgCDxsYpH6Zy
	 d9PlfLK3m0ua85N6aegFgFem+OKBixSwz2jsuLP48DOAz5DtSLiESHbImNn2iqIsPr
	 gLvm3PbrH5PYNQEXTOP4TtNTnDfS8DZ7T4XxiYQANyfl9b6+FLZSLqONnYoVzqDLGE
	 f/cI6lSy1gpC7Gz37QPjnHfoud96RvAsjnbMyBWnBYqGw+ssaR+AcVYvVUGpRq2tZP
	 UpR9NYTLH0Qqj3hBcsDlbBirQpT32Ujh99OHesqlHgVVTBLe5jpDWZl++T/OzG5QRc
	 PFQNcFBz6qh5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wenjing.liu@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Lock all enabled otg pipes even with no planes" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:08:48 -0400
Message-ID: <20240327120849.2826535-1-sashal@kernel.org>
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

The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 94040c2cbb1a872ff779da06bf034ccfee0f9cba Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Fri, 23 Feb 2024 15:17:39 -0500
Subject: [PATCH] drm/amd/display: Lock all enabled otg pipes even with no
 planes

[WHY]
On DCN32 we support dynamic ODM even when OTG is blanked. When ODM
configuration is dynamically changed and the OTG is on blank pattern,
we will need to reprogram OPP's test pattern based on new ODM
configuration. Therefore we need to lock the OTG pipe to avoid temporary
corruption when we are reprogramming OPP blank patterns.

[HOW]
Add a new interdependent update lock implementation to lock all enabled
OTG pipes even when there is no plane on the OTG for DCN32.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 23 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  2 ++
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index b890db0bfc46b..c0b526cf17865 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1785,3 +1785,26 @@ void dcn32_prepare_bandwidth(struct dc *dc,
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
 	}
 }
+
+void dcn32_interdependent_update_lock(struct dc *dc,
+		struct dc_state *context, bool lock)
+{
+	unsigned int i;
+	struct pipe_ctx *pipe;
+	struct timing_generator *tg;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		tg = pipe->stream_res.tg;
+
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+				!tg->funcs->is_tg_enabled(tg) ||
+				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
+			continue;
+
+		if (lock)
+			dc->hwss.pipe_control_lock(dc, pipe, true);
+		else
+			dc->hwss.pipe_control_lock(dc, pipe, false);
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index 069e20bc87c0a..f55c11fc56ec7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -129,4 +129,6 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 void dcn32_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context);
 
+void dcn32_interdependent_update_lock(struct dc *dc,
+		struct dc_state *context, bool lock);
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 2b073123d3ede..67d661dbd5b7c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -58,7 +58,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
-	.interdependent_update_lock = dcn10_lock_all_pipes,
+	.interdependent_update_lock = dcn32_interdependent_update_lock,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn32_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
-- 
2.43.0





