Return-Path: <linux-kernel+bounces-120879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE5288E01D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C0D1C27F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C67130E2C;
	Wed, 27 Mar 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohdC9TO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E612EBC6;
	Wed, 27 Mar 2024 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541470; cv=none; b=MBn6Hzz3VaOMntLdRA3OXnuw8PohbygT/mPgzFYdq2QpOeqNudwFzKchHFBX5KZsbpJdfjSQseEI80wf60SwvvSq8vx5Oe84oCHfvaN7BriX72w1zu//aRsVoMUfohs+Tm93MJMUVHhcO1TY6mWq80/0vVN1UgQKKlPFOC7hmw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541470; c=relaxed/simple;
	bh=CGhFsHs4Pi/CcWPbRBCkFkx8jtpaZaPFxTg0bL1X4aY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fj+1UH83K7cbA0Rqr/yBMdpshzV4vsR7lAoZjBzzxvMmPr5FuAw4mvMZvEhByP/MSnVZ4OjWCm8bbpCPxv94TtVMHyIBNIVv1xZnbImACAHzART+v3pjxI3yBVtkiA0VOm+S/NBZJsnnQhXX6pK7VIts8OAs6bWMfFqKj9pwgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohdC9TO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCEAC433F1;
	Wed, 27 Mar 2024 12:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541468;
	bh=CGhFsHs4Pi/CcWPbRBCkFkx8jtpaZaPFxTg0bL1X4aY=;
	h=From:To:Cc:Subject:Date:From;
	b=ohdC9TO+pJ1BxIzzWFmaLBDW5r1adkrSmPcuT+tvFCP40HOzRPgGvFWst3VSAecOE
	 6B9XIMvfeKnqBgiDoIH2asMS8EjjZMr4u1qOoRjtcKzDE5PZb0437CR4NloXZzehVj
	 CAcmSOmBzQ9jgRIcvcopjKPUIQ2H4FPInzIu+n/vY+Le4m/33fvtKVqwyWZm2srCm7
	 DV035R014aVWXT0TwYVD5LrdusKFE5d6Q6LdkyfQ2gNtwpr2g0yk2jD+NMFmVLXnRZ
	 UvamEiqXmk2BbJyEJIXPviltDRFDvxkl8gtkbzLARqPnGtyKrSLNBdyCF7YfH8DAXn
	 /pZOqfDDvVv4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lewis.huang@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Only allow dig mapping to pwrseq in new asic" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:11:05 -0400
Message-ID: <20240327121106.2828517-1-sashal@kernel.org>
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

From 4af4d2c275aeb667bc2bca0d2135b825e931a55a Mon Sep 17 00:00:00 2001
From: Lewis Huang <lewis.huang@amd.com>
Date: Wed, 31 Jan 2024 17:20:17 +0800
Subject: [PATCH] drm/amd/display: Only allow dig mapping to pwrseq in new asic

[Why]
The old asic only have 1 pwrseq hw.
We don't need to map the diginst to pwrseq inst in old asic.

[How]
1. Only mapping dig to pwrseq for new asic.
2. Move mapping function into dcn specific panel control component

Cc: Stable <stable@vger.kernel.org> # v6.6+
Cc: Mario Limonciello <mario.limonciello@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3122
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Lewis Huang <lewis.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |  1 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c |  1 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   | 18 ++++++++++++-
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  2 +-
 .../drm/amd/display/dc/link/link_factory.c    | 26 +------------------
 5 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index e8570060d007b..5bca67407c5b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -290,4 +290,5 @@ void dce_panel_cntl_construct(
 	dce_panel_cntl->base.funcs = &dce_link_panel_cntl_funcs;
 	dce_panel_cntl->base.ctx = init_data->ctx;
 	dce_panel_cntl->base.inst = init_data->inst;
+	dce_panel_cntl->base.pwrseq_inst = 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
index ad0df1a72a90a..9e96a3ace2077 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
@@ -215,4 +215,5 @@ void dcn301_panel_cntl_construct(
 	dcn301_panel_cntl->base.funcs = &dcn301_link_panel_cntl_funcs;
 	dcn301_panel_cntl->base.ctx = init_data->ctx;
 	dcn301_panel_cntl->base.inst = init_data->inst;
+	dcn301_panel_cntl->base.pwrseq_inst = 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 03248422d6ffd..281be20b1a107 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -154,8 +154,24 @@ void dcn31_panel_cntl_construct(
 	struct dcn31_panel_cntl *dcn31_panel_cntl,
 	const struct panel_cntl_init_data *init_data)
 {
+	uint8_t pwrseq_inst = 0xF;
+
 	dcn31_panel_cntl->base.funcs = &dcn31_link_panel_cntl_funcs;
 	dcn31_panel_cntl->base.ctx = init_data->ctx;
 	dcn31_panel_cntl->base.inst = init_data->inst;
-	dcn31_panel_cntl->base.pwrseq_inst = init_data->pwrseq_inst;
+
+	switch (init_data->eng_id) {
+	case ENGINE_ID_DIGA:
+		pwrseq_inst = 0;
+		break;
+	case ENGINE_ID_DIGB:
+		pwrseq_inst = 1;
+		break;
+	default:
+		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", init_data->eng_id);
+		ASSERT(false);
+		break;
+	}
+
+	dcn31_panel_cntl->base.pwrseq_inst = pwrseq_inst;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 5dcbaa2db964a..e97d964a1791c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -57,7 +57,7 @@ struct panel_cntl_funcs {
 struct panel_cntl_init_data {
 	struct dc_context *ctx;
 	uint32_t inst;
-	uint32_t pwrseq_inst;
+	uint32_t eng_id;
 };
 
 struct panel_cntl {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 37d3027c32dcb..cf22b8f28ba6c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -370,30 +370,6 @@ static enum transmitter translate_encoder_to_transmitter(
 	}
 }
 
-static uint8_t translate_dig_inst_to_pwrseq_inst(struct dc_link *link)
-{
-	uint8_t pwrseq_inst = 0xF;
-	struct dc_context *dc_ctx = link->dc->ctx;
-
-	DC_LOGGER_INIT(dc_ctx->logger);
-
-	switch (link->eng_id) {
-	case ENGINE_ID_DIGA:
-		pwrseq_inst = 0;
-		break;
-	case ENGINE_ID_DIGB:
-		pwrseq_inst = 1;
-		break;
-	default:
-		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", link->eng_id);
-		ASSERT(false);
-		break;
-	}
-
-	return pwrseq_inst;
-}
-
-
 static void link_destruct(struct dc_link *link)
 {
 	int i;
@@ -657,7 +633,7 @@ static bool construct_phy(struct dc_link *link,
 			link->link_id.id == CONNECTOR_ID_LVDS)) {
 		panel_cntl_init_data.ctx = dc_ctx;
 		panel_cntl_init_data.inst = panel_cntl_init_data.ctx->dc_edp_id_count;
-		panel_cntl_init_data.pwrseq_inst = translate_dig_inst_to_pwrseq_inst(link);
+		panel_cntl_init_data.eng_id = link->eng_id;
 		link->panel_cntl =
 			link->dc->res_pool->funcs->panel_cntl_create(
 								&panel_cntl_init_data);
-- 
2.43.0





