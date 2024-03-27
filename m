Return-Path: <linux-kernel+bounces-121040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3088E305
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12F6B28270
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764715CD68;
	Wed, 27 Mar 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peRfj/hK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9D15D5AD;
	Wed, 27 Mar 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541915; cv=none; b=h0gtC85cKG7gsLGOmzm67LNHneQVcyMe3HNMoH2mX8R6/DNn2Fq8YfUgrTkc8U1eh1uzq2xr+eBgTKNW8i5sow+srcGCsAXM5OE3lwMQa08crsvb/YqovhicskzPuilcyB2y84UCUkto+8JuN2kij2AEhRiZZBTaSqE4VfrDHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541915; c=relaxed/simple;
	bh=94PepYASHTuw0AbcUSCI00ueygO1XwOUo7qVmNVSBgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9MBVI/HBpV4tfos8aoq4a/glYj2kKSTRyHSbtcVFGjH0h4C176713VXuctgomflnAJjZS9ZJsF3sZJaiDfkZjRi2tAgE1QD/G2ayeaT6vdB9WQ1G2a7j2xwFJD+lVNnUc0To9LTuyPsF+qqWoforNlYa+victpWhJtij9dMqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peRfj/hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C2EC433C7;
	Wed, 27 Mar 2024 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541915;
	bh=94PepYASHTuw0AbcUSCI00ueygO1XwOUo7qVmNVSBgM=;
	h=From:To:Cc:Subject:Date:From;
	b=peRfj/hKC418B9bk+9pscTyxLI9e7saGE/uWtp22ZEei5WbqTHwxM9/2m/lFjE5pd
	 EluKmrwTR+TZtjiBIVi1GboH8pQRp5OiFm4/7nPe9z/XycUzKr1Es+4XChSf4YC/Gg
	 +Si/41WaF5B6q1myN9meb6T+hQsMTKbtNXTsUplGQEG+AhRgy2mkJURZn+CX+0Na+u
	 t5RDvCOO+SXAtFuOLWJcbMhc2GqFTxiKZo5ZqgXw1DTdiyFRPqFEyYAN0o45xTpnmW
	 URHhf3jIAHDB6QpGDKmFlkPyHc6dfhZ8PPKRgZeo0AMV9XH26DGPFp37ETHIPD71T5
	 xfisdSN4GxCZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dillon.varone@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Martin Leung <martin.leung@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Init link enc resources in dc_state only if res_pool presents" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:33 -0400
Message-ID: <20240327121833.2834478-1-sashal@kernel.org>
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

From ca25a2b5f841f991e472e2dde7f5e2d337dbea08 Mon Sep 17 00:00:00 2001
From: Dillon Varone <dillon.varone@amd.com>
Date: Thu, 28 Dec 2023 21:36:39 -0500
Subject: [PATCH] drm/amd/display: Init link enc resources in dc_state only if
 res_pool presents

[Why & How]
res_pool is not initialized in all situations such as virtual
environments, and therefore link encoder resources should not be
initialized if res_pool is NULL.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 460a8010c79fe..56feee0ff01b1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -267,7 +267,8 @@ void dc_state_construct(struct dc *dc, struct dc_state *state)
 	state->clk_mgr = dc->clk_mgr;
 
 	/* Initialise DIG link encoder resource tracking variables. */
-	link_enc_cfg_init(dc, state);
+	if (dc->res_pool)
+		link_enc_cfg_init(dc, state);
 }
 
 void dc_state_destruct(struct dc_state *state)
-- 
2.43.0





