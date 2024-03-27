Return-Path: <linux-kernel+bounces-121017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708788E1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF81B2F08F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F5B13958C;
	Wed, 27 Mar 2024 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO2Sopbf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B0139D05;
	Wed, 27 Mar 2024 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541852; cv=none; b=m3elxN3iPB4spQOXOWpPdRwZPfp5BsEUiJ5F1A8UJXGGxZMLT47ewCpu0vzTZvn6Hp3PUj0i2AFJ2yZvYZXAAnYcvy4QXcYL2DQKLPg9WCsNyEE6kVNk6aiCnGYI59m1gAzes3ZS6udsyNxbAMHgrw9CpmJHfjVaAOutLxOk+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541852; c=relaxed/simple;
	bh=ak7Uh65Sq2scJrNXgyjVRicKsR3l0RoL+E04ZeXD43I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bw6KACFmNbwqPnAvUkjrVDOEslLmLRlwoyFZHqBeX46X+cNBJ5+4ClzQrJ44QlRj04dsV5HNebcO6MY1Vgu24xtwIVZIaq64m9PXUBXBJMQdhN6AntnK6TQh0ao6CN2+bvcFCzyrv5jr3mAxnf7i4rBD2oz35tIZRr11/ub/7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO2Sopbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF415C433C7;
	Wed, 27 Mar 2024 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541852;
	bh=ak7Uh65Sq2scJrNXgyjVRicKsR3l0RoL+E04ZeXD43I=;
	h=From:To:Cc:Subject:Date:From;
	b=QO2SopbfIVCYmYMcH8F1V9KpAjRVEjFRwAuNOSmtyYBYtZSK7ZfDW9ektMqKEn7/p
	 HJu27an8inAZ9yFqci4A8oLyQf942IjT/voDUajpZxkiEL3jkFyaNXtD5MsDHWBVqN
	 jDeh8/j1xU8OAymQ25y5CHNfkbOPXSdgVOICZkyR2qfcCgrFVTtTIW4bZgtTiu6/VH
	 6mHNjrnydcQ9BAjDS/ZLQJlR3SKOsiGeKWzmxnn7BYcQgZF46Jjl9FscHtzfDNpJyj
	 DBZUA/OZkqraXVvjHgepOLH5Q/+2R+tOl7vBSMyAbZE1IipoJ3vX1UM+bIkGgssxTu
	 XoQ/dbkp4mP6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nicholas.kazlauskas@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Duncan Ma <duncan.ma@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Fix idle check for shared firmware state" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:17:29 -0400
Message-ID: <20240327121729.2833581-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3d066f9547dd58329b526db44f42c487a7974703 Mon Sep 17 00:00:00 2001
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date: Wed, 21 Feb 2024 12:27:31 -0500
Subject: [PATCH] drm/amd/display: Fix idle check for shared firmware state

[WHY]
We still had an instance of get_idle_state checking the PMFW scratch
register instead of the actual idle allow signal.

[HOW]
Replace it with the SW state check for whether we had allowed idle
through notify_idle.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 613d09c42f3b9..958552a8605ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4847,22 +4847,16 @@ void dc_exit_ips_for_hw_access(struct dc *dc)
 
 bool dc_dmub_is_ips_idle_state(struct dc *dc)
 {
-	uint32_t idle_state = 0;
-
 	if (dc->debug.disable_idle_power_optimizations)
 		return false;
 
 	if (!dc->caps.ips_support || (dc->config.disable_ips == DMUB_IPS_DISABLE_ALL))
 		return false;
 
-	if (dc->hwss.get_idle_state)
-		idle_state = dc->hwss.get_idle_state(dc);
-
-	if (!(idle_state & DMUB_IPS1_ALLOW_MASK) ||
-		!(idle_state & DMUB_IPS2_ALLOW_MASK))
-		return true;
+	if (!dc->ctx->dmub_srv)
+		return false;
 
-	return false;
+	return dc->ctx->dmub_srv->idle_allowed;
 }
 
 /* set min and max memory clock to lowest and highest DPM level, respectively */
-- 
2.43.0





