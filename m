Return-Path: <linux-kernel+bounces-120850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9BE88DF39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CA41C20885
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3112FF7E;
	Wed, 27 Mar 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJGdDyUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F013C67E;
	Wed, 27 Mar 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541384; cv=none; b=WFh0IN9bzho9AQhEarvIqsL04WeWwK7TKm7KEZA8VUmVm5IZWjmfugy2YE8cbZqMa52OpuZAPz1seD9TIhlZxL1dHf4IAwKXUrolLY47A3S7izQP7A1uDEd1pqhaU0wKo8I5pvGFGo0DtrU2Ud//hKlQLb4EgI7JazOJYICEDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541384; c=relaxed/simple;
	bh=PdO3QTWWXdtXH/faSHBeGBKz4oXryRW19An/VRbluwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKDETUDjW+GtXgQfH7igEoQfVOEULJ3VIckqNSD7CFRiv2/ff0bT9QmVJT9JG8J6GwB77rASIrKwPirxW84TEzEvs6wDmoRH7zs+fcDQ7ZsxVmcUP8t7Ftww9EBbz+97JCF1a1I3Kj8jMuARhEmOz1Rli8ZPvh9FWVvu/jnwRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJGdDyUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E5EC433F1;
	Wed, 27 Mar 2024 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541383;
	bh=PdO3QTWWXdtXH/faSHBeGBKz4oXryRW19An/VRbluwU=;
	h=From:To:Cc:Subject:Date:From;
	b=MJGdDyULZm4P7Ke0AyCO4eMSILW9OPiJU4jCMgBNpuZVXjziw6X0B/Wkl27dL11Zh
	 Kb+H1ADfhAJ0ioc/wtZzTtA4jSFGeggffP7UuJJXUoZ/N3mzhFp0Xyn7ntaCNpcFtz
	 LaeJ76dmDlmrz7WLbc2lhjtQxdCZ0aqLgGKMm3lxor9/XdlLpOVakJnjciIxvB1FTc
	 82ZepGQ1VukU1YvfoHbah39PA7vWtQiBg+uMm6p704fYRYNca2h9zIR7OcWGH78U50
	 oLppYtxRv8EqrBWMWZxSx7gWNEXoVE2Ii0aYnRrNmPik5d3dS5UEjuZyAVA79pjqkg
	 tGAAi+H0I7VEA==
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
Subject: FAILED: Patch "drm/amd/display: Init link enc resources in dc_state only if res_pool presents" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:09:41 -0400
Message-ID: <20240327120941.2827276-1-sashal@kernel.org>
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





