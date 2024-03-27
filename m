Return-Path: <linux-kernel+bounces-120942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D888E0C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED50629B0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBBB14E2FC;
	Wed, 27 Mar 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RscrJ9xR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA514E2E2;
	Wed, 27 Mar 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541650; cv=none; b=FUW38oQ85x3ksoJo3AkDFBBa5VODM1x4zoPOYRvYCtAicIhuhDQhmRPUU6bMQbVpJzG7y90occkrHI6sukk6IAuDHq2Sec7qkHix9nacm+L5f4xlKP7ce/yKgy5FD8EKZO7PmUzws/xoC6Ko7cm9zybRP7B7eNzodAKOVS9+TRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541650; c=relaxed/simple;
	bh=X7l99WhoB2MTgcPR++Lj4wqVxklSCBuzWJMFmG/1UXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=etr7qD7oMXskgP0JuqhA/y4cr1YYhcXvW2jjQi5HeDU4cIHsmRGvpytGSaQcTuh+JwJguNxBWOrzSmHU1v8LD8gOiKtrKUp8+JtiUPO/09vCAoiY7+YGY2S2T/WxAtvgEIpcFUuzzj4lLUfuS1LsZzDkaghuWuUWfLSFAL0wqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RscrJ9xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755CBC433F1;
	Wed, 27 Mar 2024 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541650;
	bh=X7l99WhoB2MTgcPR++Lj4wqVxklSCBuzWJMFmG/1UXs=;
	h=From:To:Cc:Subject:Date:From;
	b=RscrJ9xR90Tk1daZJoJ06CLy7j4o7caNmhBa/uQURC1ihtZPMFnB6aG1IgXLBpHJy
	 HcGdE3e8ei4tBfVZgvxmLX+o97qoIgYriAro7wRks3aV30LPVgSMkOzeEYCQGDyyju
	 kaA0rAr1/epW8C3xhplUuSf1Wy+KpHi5DWKaTKKAFMXRaNxjvUWy4irTlYeB0zbX30
	 MHiEtn2bKSJ65sfAGn61tSZcK7R9UJaRbEHQsVQvJ3thfCw5yaI0dOjZu4T0rPcWfn
	 xd4jaJJ9H1qymzXo5GyUUGz5X3xQEWuZCG1cV1LYVkpeEV/NUR1oOwa1KAA9clKC3m
	 VrWaMXZXjS+Mg==
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
Subject: FAILED: Patch "drm/amd/display: Fix idle check for shared firmware state" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:14:08 -0400
Message-ID: <20240327121408.2830884-1-sashal@kernel.org>
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





