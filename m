Return-Path: <linux-kernel+bounces-120880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445EC88E021
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F54B26372
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9BF143C47;
	Wed, 27 Mar 2024 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm763ZLc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1617143899;
	Wed, 27 Mar 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541472; cv=none; b=o7iVyIYJWFln5Z73eWxueUE4ugxT5UmItWUs2ZkpieXWpa4M9bg/Lwp72RmWD21k7S/rxJnLoVnfnjg0RJITWTGmQQuUgQGC4NuQ9/wbVjSnaXrituojVYZd/YYJcOt9WeZ7LgC7Y+MAF4JvGDg6UGkpYMtPKFObHs8v+5O3OBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541472; c=relaxed/simple;
	bh=BUAOWqTZdE9aNt1mSirOW9MejxA5rxFMq9wdkBIWlaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4pw7S9e1gf9ESrODy4i7+fCD4KdTSrWGc8N2e4IxNWT+CT3XopfkoLsGLIOkPyLJ3+OQRuUAbpjINQ0HJAnS1oQgzD1DMH+c/h9lD36VLeTu2Ud6R1cuquECg/bBypoX1TPZqKXqMtRPOwoOy4crY6EZDd8y1+jZKuW9nCCIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm763ZLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A591C433F1;
	Wed, 27 Mar 2024 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541471;
	bh=BUAOWqTZdE9aNt1mSirOW9MejxA5rxFMq9wdkBIWlaw=;
	h=From:To:Cc:Subject:Date:From;
	b=Nm763ZLclv4kPzYAmITL9HJrR70RFQvuVPqMUF0uXGaD/U0JoYkWjPAKNKka8NuW+
	 gygrruk0ydkPxEy4VGbI7vO9ZkPXTnlCZlvbTlvSrVS2NC7pVPuWpuGHjiYSH/xjmR
	 wK+xKlIAzE43xH3LOg8Ml7BVyCKByr8yZZG6809QITLKPH+aBbuY6m7Wv0Hcd4aZjq
	 MQRdkUb/zrhii4ez7p0GElR912Bzf3L1ePlt5Z6YwpMRX+yU4ItxMH6HyNftDR/Ovk
	 GNYcAPBSz8Xf0jxJ/bCjlyFFaWywnvmkfIyI6Ai+HXZraVQZAa3K/NuvSruPP/kjNA
	 rjF/R7UDutclA==
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
Subject: FAILED: Patch "drm/amd/display: Fix idle check for shared firmware state" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:11:09 -0400
Message-ID: <20240327121109.2828554-1-sashal@kernel.org>
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





