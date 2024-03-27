Return-Path: <linux-kernel+bounces-120939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512AD88E0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054BC1F2C7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A374135A56;
	Wed, 27 Mar 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGwdArEP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE75135A52;
	Wed, 27 Mar 2024 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541641; cv=none; b=g0YVn1aLKq28HePou2yE7cOjYvZLi7ZBPyGolCN4+pIsLLEiN5GQwDT2MDOmsAqWNgg9zuwmSEkPGOQkmYKD61RXg/d3/7RG0Yd/F5SI67ZxhqIkI1GnkbMf2c7elJjhndBMsE6ScHVW/fTXCxDWk2i6UClwQ0phZ05zYps3byQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541641; c=relaxed/simple;
	bh=jujCE1gXupT2IgeftMNcUDwF6aNlIJOhMDXsf80PFtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSbJX2onqKdGn5FBkPzaN1ogdq4lxr+FGaIBi6nXVpx71IHgXrA0NhpppeRORoLX6kJ+M+Gm0Vww/fLRL2x9pV1F7BUpjLR8w3LLYKPBao2KFVYNQ5UDYIQef4K0j6jVOO+SimMznBiOv2Ec38tNI+nnq7pwZHUchcq/gfCkOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGwdArEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167BCC433F1;
	Wed, 27 Mar 2024 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541641;
	bh=jujCE1gXupT2IgeftMNcUDwF6aNlIJOhMDXsf80PFtE=;
	h=From:To:Cc:Subject:Date:From;
	b=tGwdArEPjntO0ouOpWPHzG8cBgbi1i02Ih18M3oM0Kf3Ma3dM//v7eOJevTFfo+QK
	 DZ9qTrc5yww5svckAcriQ5jDzvoXK5bKHIGcFnejoFHVmC0qUT6m6LbFORRIA0mSQL
	 2p+33gq2juX5xnjkiq1nGFGzPyHmPmxjXZj+Qi6zXKZNMINakj4SfmsaPCpwZgMbO4
	 Fi1KC+dxE/qAkJivPf7OwZaNBWPGIBVybcC0IG9NWRfRF1aoHePXryH1Usj9gvNJbM
	 6GCZT6jJmJlx2FiWMd6clmH6F2PoCUOe+JKnUYgBchNMM6CrWb1T+e7Wu/VcGQFIp9
	 mKoVojqf/BDYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	josip.pavic@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Allow dirty rects to be sent to dmub when abm is active" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:58 -0400
Message-ID: <20240327121359.2830772-1-sashal@kernel.org>
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

From 7fb19d9510937121a1f285894cffd30bc96572e3 Mon Sep 17 00:00:00 2001
From: Josip Pavic <josip.pavic@amd.com>
Date: Fri, 9 Feb 2024 16:05:18 -0500
Subject: [PATCH] drm/amd/display: Allow dirty rects to be sent to dmub when
 abm is active

[WHY]
It's beneficial for ABM to know when new frame data are available.

[HOW]
Add new condition to allow dirty rects to be sent to DMUB when ABM is
active. ABM will use this as a signal that a new frame has arrived.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5211c1c0f3c0c..613d09c42f3b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3270,6 +3270,9 @@ static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_s
 	if (stream->link->replay_settings.config.replay_supported)
 		return true;
 
+	if (stream->ctx->dce_version >= DCN_VERSION_3_5 && stream->abm_level)
+		return true;
+
 	return false;
 }
 
-- 
2.43.0





