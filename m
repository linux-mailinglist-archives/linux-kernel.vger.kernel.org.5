Return-Path: <linux-kernel+bounces-121280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527A88E759
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514E8B32EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC241BD5C6;
	Wed, 27 Mar 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZflNDu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8F1BB75A;
	Wed, 27 Mar 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542547; cv=none; b=niiI1xv6ugMo35HgFy42XG3KRf6J7XsjIPkHFsrv2ocTxJd7g+jpzIWUNWEo7S0xGDK3Bl0zWn4y2x9Q5Y5ySRoi8YRm9pS0R/gyoxpBWyKO7G36YWPNZpIteHi0Xcl/V+UFHucQSZZxkYFLE4yMQ7EGw3QanmR4oICFCKm4PCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542547; c=relaxed/simple;
	bh=pGVzRa1ZGMETCkcovCzCkjxfKDMXw0svvmf7vXm+2uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qd/CuYFtimzg1dv7o9mEHgBvhN6c02fAWTt1PBZqvLNhWZJ3UMabcNPNOgDyugAnib2+kycIB9Efd1HDfTk8eeA1ZVdgSZohzqd3GRA+i6B8krPVZxhchlPwe9p7pN8uZ3UmYwUduthEquy4lXBuhZJJp5AeWmVcz//B7WgK6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZflNDu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A77C433C7;
	Wed, 27 Mar 2024 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542546;
	bh=pGVzRa1ZGMETCkcovCzCkjxfKDMXw0svvmf7vXm+2uw=;
	h=From:To:Cc:Subject:Date:From;
	b=EZflNDu3uIqdtCmNLn1simRE8uVtFRbNiLGsXI/wiuhrWVj2qLCeSjLqoLJ2T4Wrs
	 Nf79yzzdY7Iszzl1/tbds4zBYFHaTPKopdGu72xNLTWcKHnO4RNuZZ5I9A8CYLb2fd
	 SUh5BsQONJ0DtjOQHSCnDznt6atj1sdDYa2K/hVGvFH+KWA44Y+wxJ0jMoHBB4Jymr
	 l6V2x5EtOFo8QbITmqKpUk9Qx8VY9hJJwdzaJqD5RB5QAyFGvqMR/XFC0m/lrXRYL1
	 UePiNbXgHQJnrMUknfioZ2cJYBwud74NOQYIy2aXBERcn9x7zMZRErYnoAnUuk4ASv
	 K28KprEYqlqBA==
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
Subject: FAILED: Patch "drm/amd/display: Add align done check" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:29:04 -0400
Message-ID: <20240327122904.2843238-1-sashal@kernel.org>
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





