Return-Path: <linux-kernel+bounces-121105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8054388E265
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222861F2E8B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027B12FF80;
	Wed, 27 Mar 2024 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjYMh4SX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01761703D9;
	Wed, 27 Mar 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542092; cv=none; b=i6fd1a+eZ2hGzi6HCmiqS6BPF5gOdke58XxT1yRxmtdlo4GUU5FsuvhLlK6D1/mfzDwfmub6f8DZSVfsFWmdAVG+4Fr45VwDrSUpkXPAvxQ/iSPiPevrowLZQBLbs7xntoFFq15KXiDNbgqwIWF2MJ1on4ulfAZEQ3l8+UMRUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542092; c=relaxed/simple;
	bh=WzAts3itri9Y1SLbajroPBQOpKguEKCub9D1jDLTxAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHo7msYCV9LLwDT+uXKPaRHI3//bGJPC8Darq2x3fZvnKHH+xdUcrsFqQMt0gZVfImKMIIR4FRy/QqHfPb3wAdtYhXQHuoGm+21fp26Mt9hYd5lSCXi3eLi4UZKvCqcY+E9VE1ZOx1ZtfHwnoY4FzlZbj/NHIt0Syiarj+IS080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjYMh4SX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F13C433C7;
	Wed, 27 Mar 2024 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542092;
	bh=WzAts3itri9Y1SLbajroPBQOpKguEKCub9D1jDLTxAs=;
	h=From:To:Cc:Subject:Date:From;
	b=bjYMh4SXd1o68I9slhavTa9OsBX3obzVJM4M6/4R/7EVPHx1sGs/WXXny4yrnfunL
	 iiJEyzTNZy1rfuuiDVcfXsYZRVW4FcXGseViTVT3xG3f2BSbQUsxDDeM7Fde4olxY1
	 YMLUqJhR2t0lQM/dKgm1YqzhbbNPaJX4gKQ9urywCMRq95PtOcl448k2/uyu2XatTx
	 JNT2eGxoEvocetYoNBX3HPxEXWhubf6POOR823SICBxpcfgiJZjq7Qn4GQGEQRv+OE
	 GyLFMOMwK2m+LaGI8JWaFZBqRQCqvWOhp7pMP/gMWYjFtYirAZhzGHQFoeJFDcuMnp
	 CJeakzAZzcfAg==
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
Subject: FAILED: Patch "drm/amd/display: Return the correct HDCP error code" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:21:30 -0400
Message-ID: <20240327122130.2836906-1-sashal@kernel.org>
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





