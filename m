Return-Path: <linux-kernel+bounces-120964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0261788E105
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCC61F2F0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E888137906;
	Wed, 27 Mar 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFCt8Nw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C415358E;
	Wed, 27 Mar 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541712; cv=none; b=BsGSiyACtN5ZFjw7i9pSjOli4Lo39ZKy/BS2Xh+rOkx6XQVo5pbaL6DBEuVeAuyzlolyKuDKU4hGx+8LdHt1d194+K8dmMDnM65dL14gZXHccxLp1Z+1QEgbvtzE3juWrptfsvAN4+4NiIvDfUFs4wycCS0StnJxIn06VqJ2CIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541712; c=relaxed/simple;
	bh=Hfp089yn9i2MdiSv3nIbonNUEeAoAI4FMH2N2rlxcDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAgetQe+qyaBS+y5vyChRO1GoT5dZFLBjCeQK9fZsXDzNOpLUBqCdHv5KI0RmK/V9tZuGsEx5Tgue1uxfjwCrp7UkRoRWwqPkhNzpaoi+O7RcW/kE+2lQYSq0hDPPiwgV/9YZUI/js1tr8gebyryoNRqiWSUlg8houolwNjY4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFCt8Nw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CE6C43390;
	Wed, 27 Mar 2024 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541712;
	bh=Hfp089yn9i2MdiSv3nIbonNUEeAoAI4FMH2N2rlxcDs=;
	h=From:To:Cc:Subject:Date:From;
	b=pFCt8Nw2hvvhtW9WnRdA+bsvG7HlO27PWHxke857oxmcW83olIYFeV8UBOmhywTx0
	 o9kgIHdAOaJNMsNAmXm2DZRkNWgwqLUeUhVk94b2LMLY27229rzPoquWpN1sLG2rls
	 0JousyHLjhINLKkjQt/aT3sC77sYWRfhU7NT29uWk2PrrJAWHVN1HiVD01MW53iDVG
	 IjWZfcPLp4IBsrAjQgy3Kv5zCnflvNE+Q412TuLwQYiQUNQTmMfUH5Zfr6//N4o+EM
	 5UX5P9+b9VReFX/D83V53zcP00mT5VtvJoxmNht4dlRVOTePo9VI68+tayDf34YwI1
	 Dy4h5U698ozgQ==
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
Subject: FAILED: Patch "drm/amd/display: Init link enc resources in dc_state only if res_pool presents" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:15:10 -0400
Message-ID: <20240327121510.2831696-1-sashal@kernel.org>
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





