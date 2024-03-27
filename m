Return-Path: <linux-kernel+bounces-120948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A79F88E0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4365294B63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6B14F9D3;
	Wed, 27 Mar 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVDDZyzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93914F9C1;
	Wed, 27 Mar 2024 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541671; cv=none; b=tLAJA561DMaNuTDEFrvtcrA0wrgeX0wp9l4QAWSR6IP1JjAEAfNRCWMrl4uumuEHOINkVjMNzmnG6FiIuiUOHEr1s5UkSd+zMI6jgHrw9POpujFCeoEKTBSDAcQSr77/8/DKTLnL4gL9VecKa8+ddRR55k/T6V7Kc8r2wULxZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541671; c=relaxed/simple;
	bh=cNl+FhBonmBjdEeXcHLS8TGKqeFx763AomKEfDUvJ4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmfloH8thnj1PKrUsDK6TiKvY3V49+Mgo8Vd74kVCIqY3tjRXHvqwn6H/ySp7ZZF4Ap/AX4auCUve0FqEdezRGLofLdYHF6GIWfl4d4i3xlc9E8td+mZJU1oOQRQGnhlusROsb41uu+UqYLfryZ/tYvtW0y5Z4eLjUjfbqcn6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVDDZyzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185E4C433F1;
	Wed, 27 Mar 2024 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541670;
	bh=cNl+FhBonmBjdEeXcHLS8TGKqeFx763AomKEfDUvJ4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=SVDDZyzFjRSgoeqxX+CeoZOP6p8gsXpCE3Tw9cGKreE5ilvDZLTI89If6XWcaSOsR
	 j9YLBp0xjw3nbcel4+mCPzaBGC1aYidcCp2hrun7FuRnH481MLvh2FjwrNkZYn+vtG
	 GmftPAVi+KjlQLHtGe+s2W415njGMO7xb2i8Cu3wO26ADIT6v6rbBoaQYnpp5aqquS
	 ymKEWbE/uk8ejK1QUaBs59/6yY2boOvJNpTtuoLQ56mAKhBDCIZW3ZkPDUytSn1uRW
	 DO2lgcKzOc14UXAmBxvdyqUuNBmbvaUiCOCpRIIhbwNYbvwBVEQ7+MZt5BjQJRwOQ7
	 emGCjhP9pY+gw==
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
Subject: FAILED: Patch "drm/amd/display: Add align done check" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:14:27 -0400
Message-ID: <20240327121428.2831112-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





