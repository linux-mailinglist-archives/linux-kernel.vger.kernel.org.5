Return-Path: <linux-kernel+bounces-121214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6388E402
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7B71C22916
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E635188A95;
	Wed, 27 Mar 2024 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3X8ELlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7062C188A92;
	Wed, 27 Mar 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542365; cv=none; b=l/PBod8HGha1IfxC856R3/plsQ9FjjwqIczqwZT8LVvVnj74m6NIQQAiMZdbR1eEhNl+LUPrdsVY5QSGdTt1+fzrG7gOh6fIZG2Dhs1QkH98YG4OyXDTlu0A2Wdned41ilbLM3CW6p1FehdYj8H0hd9tELrdL9yCfCxZrfRqPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542365; c=relaxed/simple;
	bh=KHQiRhTRcJRpE1M5wDnDT3b7Li/dBrgfORbLdigvAkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+QRTKXnJlXyxIrMmOz9lij8w9yKNMXpDIrDd98/bJjYcxHp2Lp3fBW1IGvYy9+7Uz1sodKcH/Mov++kkDfyU7le9bUUNgiuX9xyoV7ZVDQ1rqlBCPSXACPxyKU6tr1/fTKCkN/o+ChfzkQwj433UR08d+SVU5vK8XydLxJrfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3X8ELlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A7FC433C7;
	Wed, 27 Mar 2024 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542365;
	bh=KHQiRhTRcJRpE1M5wDnDT3b7Li/dBrgfORbLdigvAkY=;
	h=From:To:Cc:Subject:Date:From;
	b=K3X8ELlAvwjUUpRMpEscTtOYrBgXr/n3/OUpSp4G+g7Pe2qwpznXBVDCX98jkeAUg
	 CcQGaERfspFaIBb+YWacCFDTISi/iB12qWgJU051T07ohx5ewMsw+TJY51JGRQg+GN
	 UPtq+LWLEEBsEn7oZhfdjxEYKJzKKk8furYRwjxOHU6tnxjOaux6CXuEvFd847KQ2S
	 YlIkIkzv5PFomKx9FmjFytZ9iEj5xjSKXAL/AIzfAcF3E99ZpwuLtJ8Fw00Po9oJNE
	 Y3mBdpXl70X0oONLDbZGJpQw8h67rvLtCX0Sjutn/wPOKm5FJDS78/PJTQN4S/xL5k
	 J6QlTC2NtdW2g==
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
Subject: FAILED: Patch "drm/amd/display: Init link enc resources in dc_state only if res_pool presents" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:02 -0400
Message-ID: <20240327122603.2840778-1-sashal@kernel.org>
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





