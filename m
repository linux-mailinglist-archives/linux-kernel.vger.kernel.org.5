Return-Path: <linux-kernel+bounces-121120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AF88E28E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F46299B33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B71172BD5;
	Wed, 27 Mar 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQxibpZM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08E172BBD;
	Wed, 27 Mar 2024 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542131; cv=none; b=o96cAXheQLV8jWozDdsYjKlDMCQ0mbClbKPo8iNVBDxkHgVarByzG7tJZBqzqAM44mpvApTWhPoKTvzs5C8WngICBSUBE6eCN4E0tubuY6+NRhYLzRO4S6B+r5g2jVUq/SYpWIgJu34fo2DrUvHYpy/gWaokdKLGjJXHHIKDVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542131; c=relaxed/simple;
	bh=ykjY/LEF5AdESRFdRyYNtcueT9YyqaLCT+q2FCQRXvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJ0UtcJHa4tyaYsZxn8ejo/smi2aokGzBFLH3fgqPeLMiW1GBT/p/feDtsbYdMRiCn221J7bZ6AC9xHM5LTaVm7tsDtDyjLztMfThzKuP5/ERBGS3qC+8gLOv4VPg2PJJKaqfZ+hNgEvBYwQJaH5/c94P+Kh9MPipFkeAsK2QCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQxibpZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839C6C433C7;
	Wed, 27 Mar 2024 12:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542129;
	bh=ykjY/LEF5AdESRFdRyYNtcueT9YyqaLCT+q2FCQRXvM=;
	h=From:To:Cc:Subject:Date:From;
	b=tQxibpZMh2r0EfGID32QX22FPWhIYwvgGvtxEtg04m7kgL5OhsRb1/6WkKmGfrHBD
	 Im7RYaXm3zBKct+3VGCvhvNLBpbmh7ho8dDCXQKLUCwKKjD3ck8U9SZ32c9ONC/f0C
	 +5BDvkwEfqD/DelaQaixaE3F+gHfGQzzyvnJ5HrbdeHoxeLT+4rj8y0J71l+pGEI0j
	 5qhO0yHh427cZcInLuJ5sJlyXT6ZLtB0EPzfpdILcCoThDb+nu3ovMhwZYRLSyWwVT
	 3wxiv6rvgy4awJkJnKkcsO3odPS7UTKSLUPo5IFFVBCPPwe4MICcpP1tv6BbBFLGTU
	 SXDDpWpBqhiPg==
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
Subject: FAILED: Patch "drm/amd/display: Init link enc resources in dc_state only if res_pool presents" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:07 -0400
Message-ID: <20240327122207.2837449-1-sashal@kernel.org>
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





