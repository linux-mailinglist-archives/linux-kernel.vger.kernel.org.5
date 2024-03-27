Return-Path: <linux-kernel+bounces-121150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B288E2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDA21F296DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74235178212;
	Wed, 27 Mar 2024 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucysmjxn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA517820B;
	Wed, 27 Mar 2024 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542210; cv=none; b=ZWXMtEvxNWyTdIHpdy/bjcUR8HsPDTA2bc5H6GLfIw1c+TCyyucRmVZ90sdGaj46/71Cu3thBMt2XGaxDVjXf3NRtlW+vGw3gyc9mjnwOPA6ifPGdQZ6wQE6QKfawtgOwKZzR3CnSql5XVOiRwuL1+R6BqxRQdzAM0E+3lMMaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542210; c=relaxed/simple;
	bh=Jezw/xRBgYI8qHbWXaCispCdEv9Afz9Zy136j69XMzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baFesgfUOSQCd5xMN6lmKbT0ct79Vc76no4fcBHZLtHbGlgiNpeZeO3MpPYA/9XkC4YygJN9AggsLrSAjdsFABFg+EULnzpgHyhpJD/4xLRMYkaqww2s4SsFou4pP086pQTEJP/aCso9MBv7BWnzJJbe4rAx+I1TFdFW2Gm12dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucysmjxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8618BC433F1;
	Wed, 27 Mar 2024 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542210;
	bh=Jezw/xRBgYI8qHbWXaCispCdEv9Afz9Zy136j69XMzI=;
	h=From:To:Cc:Subject:Date:From;
	b=ucysmjxn69NCxRP5fufdNjW+vFFQQM0XEndvk2RLy+OgZZ8jLrH5TekuiJc9WR3fK
	 y7Lc4GuWXxzfrelhAQyygyDBB7zH0NrfkYQ6oTuhPLwbMlyF7t6yfSedGu4QMewP6v
	 LVEOaPXDhgP59ldYsqR0o0imklSaqAHRJV4Q6BlQ/nefMw0CPtgUrYK+gAfZy3FxrL
	 CuokdZBXgNSi/jsVYx3DylT4s69SuTzs+kP+jdPieCD9/2MM5xSPb3RPt0im/4sVdk
	 7E4179ToAhQtRzT1MbqryZAhtyw1IQCcxSld56uQX3LdOLD9hfdsjM+RMBHxKeckTj
	 XiG4uxl/PhHsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	allen.pan@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Add a dc_state NULL check in dc_state_release" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:28 -0400
Message-ID: <20240327122328.2838554-1-sashal@kernel.org>
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

From 334b56cea5d9df5989be6cf1a5898114fa70ad98 Mon Sep 17 00:00:00 2001
From: Allen Pan <allen.pan@amd.com>
Date: Fri, 23 Feb 2024 18:20:16 -0500
Subject: [PATCH] drm/amd/display: Add a dc_state NULL check in
 dc_state_release

[How]
Check wheather state is NULL before releasing it.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 180ac47868c22..5cc7f8da209c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -334,7 +334,8 @@ static void dc_state_free(struct kref *kref)
 
 void dc_state_release(struct dc_state *state)
 {
-	kref_put(&state->refcount, dc_state_free);
+	if (state != NULL)
+		kref_put(&state->refcount, dc_state_free);
 }
 /*
  * dc_state_add_stream() - Add a new dc_stream_state to a dc_state.
-- 
2.43.0





