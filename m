Return-Path: <linux-kernel+bounces-120790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A752388DD5E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D14D1F27EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7EA12F37B;
	Wed, 27 Mar 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sywAYK5S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704BD12F385;
	Wed, 27 Mar 2024 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541210; cv=none; b=QFRAP7fi4yOqjGjDEihPY4eygLlCUE7cA8dtYIY9Apcji5NX4p/At3DV8AA1m0ARIo4dVj9JaLxcLAoy1On+mMJtH85GsjNIZeMyB1aprNCCuv0OH9Xm0slbFTcIE+wkYVAs/UNL7po1kuCvcb/9UGJD2MFMDwZ2sAuyJeYKyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541210; c=relaxed/simple;
	bh=nQARrklugCKpFHxZuMeLwdB5VabpdlME1of8SexhGGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCulXq5/VKReEasQtWKZXDr6MGg6LtLncdouoYhr7AltCuJa8nbff2YMLiMNOrCHTstX/sm/4oH3f6HO88hQoTCS32Hoghx2lX2VOl8r7B0DokVe05fFcQwsKYJl5JsVOjQqgWoEWHkIMJk0URaNXwcoE0LQHdEch6kiSC6JO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sywAYK5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E47C43390;
	Wed, 27 Mar 2024 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541210;
	bh=nQARrklugCKpFHxZuMeLwdB5VabpdlME1of8SexhGGI=;
	h=From:To:Cc:Subject:Date:From;
	b=sywAYK5S1EGyd6XN7SVrwzbzPBgTIllZwiNRw9NtkDlB8LOX9nxK1I8jMeYgnZ+f6
	 o/P0Jpzj2ZaO04aObS1VF+0BYbNDH8XL2DUEaCikHXxuEdo+/nQrNhRb6ECKawhSA6
	 TRXq0EguD6mkuSq8C6mzFVqbCgcbKo5WNoRpEINcNJwqQ0o8k+cFEgIO1WJOYPLj8/
	 tCPXC195UqQ7JBeCyRjLHcFdFpgqrVovNSp/9Wfm/jXP3xsSPyKHuEg754rrYnjnvG
	 2wVs4qZ8hTmZKF0KpzfHW7Mz4QwdLgUoGbuSNUTbTqYQFgMeER457hEVGwoP/+U9hf
	 1JxPzH7ZEnJ3w==
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
Subject: FAILED: Patch "drm/amd/display: Init link enc resources in dc_state only if res_pool presents" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:06:47 -0400
Message-ID: <20240327120648.2824787-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
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





