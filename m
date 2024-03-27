Return-Path: <linux-kernel+bounces-120820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0615D88DE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980E1B25C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB874137917;
	Wed, 27 Mar 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HorGSGkg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF10137759;
	Wed, 27 Mar 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541296; cv=none; b=nrsXRhNnC9qFuAerbuBIuB8j0UlmeAciGbjHqN9QdJUKBOWiZ9Tq+bRJ+GEtcZ/KYBuSB4DnpJPStQj9+QkbOkTjj74CqCb1fS0gvDdocfvU+mOqZ91nETvdG9aIE3+QKVVyBH0BqqGWl5OJKFB9QlczXbxuZWovt0/dXG93U+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541296; c=relaxed/simple;
	bh=qPO9mbpce+BNGpnGhjrqZJHlmZ2LNJpqP9j1dM+AKJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWxWDnxzwjR0Qnq9m1iegAmkpYy9cbPpqIzkRDSLTHojZfLHfMz+66HvKXiy4bPipAzFxcOyNWmUnldPXh1otjpvlH9RGH32uPPWwEzLqDpsB9ekxiRJ6b82DNYjnMgXw6S4v3O1p2zsGD7f8jHZDtzm8QB7m/jR8n8gKVwxrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HorGSGkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C58AC433F1;
	Wed, 27 Mar 2024 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541295;
	bh=qPO9mbpce+BNGpnGhjrqZJHlmZ2LNJpqP9j1dM+AKJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=HorGSGkgsfvE/QcthLbXaCLXeNe+uGFWfRrEUPHSEFFRO+gO0/hOeDost5D14DDVy
	 iTNrgRa4JMHSKuVH/P5Ifb0AOXc6xUX6+Fl69lo8fMxcSs7PpjWvUkpnMllQTaFOZp
	 c1NyKt4Ajnqa+MukAduMRY38tZwW50mhpnvSMJ3yAtoSePRIEnJDuOTogTjoqLlti4
	 lKKYe01+XwGfZznY5O1lD/RBL8WP5oJ5sU/5hBjot/nFeSUSs4Uo4qyOfw24gagAEG
	 gIARag5h1iJEw7YwLpp0cPPloPzhP4U4eykYic8QHU1xNM6Lg+4z45SQ9l1KHydi82
	 blOERHciy9hOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	zhikai.zhai@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Add align done check" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:08:13 -0400
Message-ID: <20240327120813.2826028-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1b5078f01b953a43d6198180ca5b110017315672 Mon Sep 17 00:00:00 2001
From: Zhikai Zhai <zhikai.zhai@amd.com>
Date: Mon, 29 Jan 2024 17:02:18 +0800
Subject: [PATCH] drm/amd/display: Add align done check

[WHY]
We Double-check link status if training successful,
but miss the lane align status.

[HOW]
Add the lane align status check

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index e06d3c2d89102..e538c67d3ed91 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -517,6 +517,7 @@ enum link_training_result dp_check_link_loss_status(
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	union lane_status lane_status;
+	union lane_align_status_updated dpcd_lane_status_updated;
 	uint8_t dpcd_buf[6] = {0};
 	uint32_t lane;
 
@@ -532,10 +533,12 @@ enum link_training_result dp_check_link_loss_status(
 		 * check lanes status
 		 */
 		lane_status.raw = dp_get_nibble_at_index(&dpcd_buf[2], lane);
+		dpcd_lane_status_updated.raw = dpcd_buf[4];
 
 		if (!lane_status.bits.CHANNEL_EQ_DONE_0 ||
 			!lane_status.bits.CR_DONE_0 ||
-			!lane_status.bits.SYMBOL_LOCKED_0) {
+			!lane_status.bits.SYMBOL_LOCKED_0 ||
+			!dp_is_interlane_aligned(dpcd_lane_status_updated)) {
 			/* if one of the channel equalization, clock
 			 * recovery or symbol lock is dropped
 			 * consider it as (link has been
-- 
2.43.0





