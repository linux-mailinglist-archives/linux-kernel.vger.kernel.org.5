Return-Path: <linux-kernel+bounces-121012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA90788E1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5BAB2594B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE0158D9D;
	Wed, 27 Mar 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+5qNYYQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B6139CE5;
	Wed, 27 Mar 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541837; cv=none; b=DwRnCmp6qFrHrwEWZULuGxqvoXjok17sQBPC3rySM4eke17q2DKEVl+k3p3s6Nj83kK0PK4tYx7EIRFAo8DZkqnulf3NlUArANBtpU6YKpavjsvYMakbspe4Vi5mPTMSOstNgHmPAGYzmzPiq0RRtM22oudiPLID/1b7sgLd6MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541837; c=relaxed/simple;
	bh=6zVzj5OBYXkKDTcJNIOwo1u+s56nZB0tUZnWbm39TyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9SUTQC6XL5lRpNlrjVs1A4wSxYGeCfjjADACePqEAG9X6RSamhbD/8FjmcTyIaPLsG6wEs3PSSUdZoBF8SEYvIQRbrsHtRbmZrp31VvEzL/0mMwoxAp9+Awj2MNWojE8ZASJTjEMVvN652Na/Jl6pYmQfigenlRp1hUS6ZgYqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+5qNYYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BEBC433C7;
	Wed, 27 Mar 2024 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541837;
	bh=6zVzj5OBYXkKDTcJNIOwo1u+s56nZB0tUZnWbm39TyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=P+5qNYYQQZnYjYkHXUYFH7wtGlwMqCL/fBq79W4g1vpQ0Ec9ykNqfY+QE+8zToaYd
	 B6bbjMqBYHw9Pb6SOv0P4Mvs+D+x6jV+YTpHeqkdVvIK2HA4qHEzjSJODz+a2xzdRs
	 6xYdpbjybUsds1WG9VHgaZG7EjZkkVUD9OtvGnMC0yiHZrIwBCBdct62ehux63oFeY
	 fuV7XueFyD7cVvpwCVMjcSQue/bzxhr1aDcz2hnmI3yi757uvTvDOwq1z8HQTqMRX5
	 YhprlKll1BnD/xm2RCJKqzYWJfJ81WbRmEOtwhvJeRzwYFYL6DnFO6PaWcA/kPI20s
	 8M9AAbsKp9khw==
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
Subject: FAILED: Patch "drm/amd/display: Allow dirty rects to be sent to dmub when abm is active" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:17:15 -0400
Message-ID: <20240327121715.2833395-1-sashal@kernel.org>
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





