Return-Path: <linux-kernel+bounces-121200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFFA88E5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E5B24E15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB5E184122;
	Wed, 27 Mar 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8DVpRZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DA184104;
	Wed, 27 Mar 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542328; cv=none; b=jsE3JTzx7ZEd96KPtndIkc9x6nIXjKqkfkRfQTZEh7jzPnc31fTLKwIeZCqd4eOnk2WsXj90oM20uLYoXjCNY03xSF14kF6epezfDn+SAPnfzZixq1A8WVPdrEIwcidPV1ux7a65vE0bbm9iZfjNPGjEBQFYH1fjo7L811TVx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542328; c=relaxed/simple;
	bh=sXAT55ClQ+rmbiNGoo1FyvG2gjva8ZGT9LI3+Yyp6TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBLBqsC1nPJ1zPuM5YGRRMy6p9F8Gufqgr2pFAfuLwTzqtUDVXI0E+V7UmGntCjvU+0FVtljSZ3tu8uGwKmoD3gi7rkqxrDsLvOyKOhQNhRpFHaXcwe/WuZBb56AaxaU6riqmvBTYcV+1XkNAAqy/O0dWca1EMw9NjuTttzrNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8DVpRZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D7FC43390;
	Wed, 27 Mar 2024 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542328;
	bh=sXAT55ClQ+rmbiNGoo1FyvG2gjva8ZGT9LI3+Yyp6TU=;
	h=From:To:Cc:Subject:Date:From;
	b=o8DVpRZS0AksIHMZxklUpAEBj9uu4hPsR6vASEw3DpkGagdJxzeeCGE6VoK4G6vZ9
	 C9aLtJUxUU8IMf5gwxp4uhpSm4LV0+i7uQ8pIf6eP1V6yI0JJtRipnh6pVWwxDxh60
	 60FiohmWWseo7KQ1HV5vImMoORUN8l5Q9E+WJvxppOCL70RMy9uYtZdHy6GhoDVJBw
	 BBvBrKqVcWzHqs5utcLsax1HIkb6CRSxFnUxVA3F+dggIsUWKzz8NIXrDG+4ARmL8u
	 D3B9k3K4jSjEIBY+WW/JQzcF2jKcrY9mqTrSM/8r9L85qB5w+MJmuE1PY9BQKFVb/W
	 WWfH9xkqNcg7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Rodrigo.Siqueira@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Return the correct HDCP error code" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:25:25 -0400
Message-ID: <20240327122526.2840230-1-sashal@kernel.org>
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

From e64b3f55e458ce7e2087a0051f47edabf74545e7 Mon Sep 17 00:00:00 2001
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Date: Wed, 14 Feb 2024 13:29:51 -0700
Subject: [PATCH] drm/amd/display: Return the correct HDCP error code

[WHY & HOW]
If the display is null when creating an HDCP session, return a proper
error code.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 8c137d7c032e1..7c9805705fd38 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -513,6 +513,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	hdcp_cmd->in_msg.hdcp2_create_session_v2.display_handle = display->index;
 
 	if (hdcp->connection.link.adjust.hdcp2.force_type == MOD_HDCP_FORCE_TYPE_0)
-- 
2.43.0





