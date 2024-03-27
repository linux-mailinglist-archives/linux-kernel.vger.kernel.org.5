Return-Path: <linux-kernel+bounces-121188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0B88E343
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F240F1F2E0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232D12E1D2;
	Wed, 27 Mar 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbXVS1KW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E4180A7F;
	Wed, 27 Mar 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542307; cv=none; b=laBS760JEwcGLmNRrfF10SxqYTLz/uAUtZNBlQUZio6b02SVQPY59YUwjsCCzQd9cVU/YZpptvrZZl8TKkRr+Avbau463NvNKKd/BBR+UH/wG5bpEsCpdt0rDsGXL8GVwja5gI/G+/rCioKHnQRm8T6AbWVf5WCd+jD1RxSFnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542307; c=relaxed/simple;
	bh=A9hSUXYumHvurTtNw6wQWDuxt/cfo6KsUIvxYDfkRkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q09ygMSHXTR6g+59SAcE4FwRWSfpS7FIPRT0Lt3RMiO6GfdsFj44bs+3aSbm4Wsmf1T1vEASQRiEq8X7UFU8FxfiKpuEUkIstXA9Epbjk/Z+Z99jvxhTOQGz1QUCoaV0SlCGKi62RmBiRsupBh2u3hlWLsNXRVXCnO82rRoieUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbXVS1KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439FEC43390;
	Wed, 27 Mar 2024 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542307;
	bh=A9hSUXYumHvurTtNw6wQWDuxt/cfo6KsUIvxYDfkRkI=;
	h=From:To:Cc:Subject:Date:From;
	b=EbXVS1KWJ3Z98klUYGFCsFaIT0725o8eNT7ujSlB5tYlOIbpJAha56XoBoDAM0yT8
	 oa1DT0ZVuNpZXMOfFYRGzB2XIh9nNNa0cC3KN6a3URnHqZAHEzCZaNNTomHxKf++jg
	 SbvpfuIafpEI+FAJlJgVy4XVHlq1Eja/4rx28oW8fhjXPgn9Hi2MP0PQflmHiIwlua
	 RaHrRSBXueGohpCgEy9kabzU+Bsq6MOxgZCQLaEyZLeACBtEQM0SpyrPBDwQZ5F8Qt
	 AFASZNsxWXo9OdPn9/eAFJavgBaEuEHx9SWIsnA5IKE1BmynaDlidgzVqsLO4WVNSr
	 UUKGNwxwkTpUw==
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
Subject: FAILED: Patch "drm/amd/display: Add align done check" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:25:05 -0400
Message-ID: <20240327122505.2839914-1-sashal@kernel.org>
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





