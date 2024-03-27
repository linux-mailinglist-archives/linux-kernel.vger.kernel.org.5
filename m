Return-Path: <linux-kernel+bounces-121097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5988E24E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3041C2AAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57C916F824;
	Wed, 27 Mar 2024 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhB6cqEN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6D16F298;
	Wed, 27 Mar 2024 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542072; cv=none; b=d4I5eRNOD7hG8/Njh8cML+FKe7A0OLUYE+HxXs6wGFbrdywdXH+2/Vnk7WGPuB/HUn1VL6VDn3P4dh7oucjUd3Wc/W0XoTRIFqAvcC01yxizeM9swrT+kGVJZ18/xBg2GLo6lQrXv0TlToUtTkMLX8JymbqokZP6O3JT0XvrI9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542072; c=relaxed/simple;
	bh=8Mwde1mrbzG91laCVgAuww6UDP4EnHU+yuGk6aLo9Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3ybS9t8PcHwBJm+2JtcctSCnDUwkIX5Jbb1RIJfvZTOcaTMBxLQLh1wzm8FAM1TWnO7d9oLaNIPk1m3JCEz4TidLi1paNvxIVlwjCqNFTEEb0WQgmGxopc57bBhQK9dqT4L3Ee/m69eoxrb+Vt5jcUwwAJGcL6uORbndhri9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhB6cqEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD4AC433C7;
	Wed, 27 Mar 2024 12:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542071;
	bh=8Mwde1mrbzG91laCVgAuww6UDP4EnHU+yuGk6aLo9Us=;
	h=From:To:Cc:Subject:Date:From;
	b=WhB6cqENlzrYjumHuNpqUsWKE3aHGHqjzU/1Qt8Y3iFLFjs+xy3TMKK7wNDigg/IK
	 A1yfjcLj32KbUO/Ltbr792BFl2ZhQpbnRBCoIsOtsEsctryjItZ2EaM6cJAXI2zXj8
	 einNT5+tkTEjDd9DzSnsHdtwgYOlZ3VPVyN4OJ3we2i6SiDSU/cXplC6VlB9ncSbDS
	 4gCdjaVWqi7xe+NKCge0LSBwRkvgVIVYdjyOl+aXlcnexr5g0RY23bnd6kA0IP0AGT
	 wq0maiACbm0PQBhrrEK89NsvKVaidJaRQ+Cd3NIKsc/iPsoudNSsElCm66LFeZxNy+
	 ehxN0LYCtCoMg==
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
Subject: FAILED: Patch "drm/amd/display: Add align done check" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:21:09 -0400
Message-ID: <20240327122109.2836602-1-sashal@kernel.org>
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





