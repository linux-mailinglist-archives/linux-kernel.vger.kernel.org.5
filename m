Return-Path: <linux-kernel+bounces-121266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059488E481
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC3A2A27C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8861B676A;
	Wed, 27 Mar 2024 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7RgJOL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25B1B675F;
	Wed, 27 Mar 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542504; cv=none; b=MUxl/bE8EAFEqC/MpPZTqpmMjqlbBup66Yhk0EGoPrZsLiufOYA625tcm60wcNVc4LA45cSuPwG4tg5zD8ZxcyAAMyIb6NKPzCQNiJZ2KPZuHQ+YT2CTOlNkxdj127fxZMDo0lBrjOlPsa5G+Y9c3zkzBIB+fh/dx3tMJN7NpNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542504; c=relaxed/simple;
	bh=dlv+4U/82HD5POs0oTuerZeRgxBvBjFi7OQO4yz6P04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSYF9lMdzvJ8qdGMNCJmgZXyWsAXW6gvVRZjiONsaXwcNghgKQYCmZuiMjHxRlTRQui5/LStNoV41k+RFCXZyDeiEANiIOFTo9sfIVNxdTB/p8E6eR9WzNyumpeYwM+hWoEIfA79/fQ0672BFPSxKfAPAk9zBrZdtefoxMiqpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7RgJOL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195E1C433C7;
	Wed, 27 Mar 2024 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542504;
	bh=dlv+4U/82HD5POs0oTuerZeRgxBvBjFi7OQO4yz6P04=;
	h=From:To:Cc:Subject:Date:From;
	b=i7RgJOL0awq+AtxGiLKCmxXkQnAS+FpQFLL1Vn72vETS5Xllwp6gNTeY8S3Uz/ryO
	 QGhto1AfEL4W5PLbzB2j7Wv519/gXOE6fpw7cf8yAI/504uPyLjh3DedBOeFRZJaPN
	 lGAQr6tTk1BWyaqy30M1JTO9fsE3Vc/KoQiOdv96RVT2K9DDzSldOaGRJe6I5UYAq9
	 EX4n/sfPIWIbEUzGpRySFy2LI5NVbZNOEPkcbhg6yh9nQcx1W2ntL4GOZT+1h6PuUf
	 cdjcE0rDCcH91rQgx5pH9YhJ44RSXR0pnc83bKLpDTs7Fp2pbQ4cvg9AKd/S4/0Bwt
	 q0ihq6+Mf+Y6g==
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
Subject: FAILED: Patch "drm/amd/display: Allow dirty rects to be sent to dmub when abm is active" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:21 -0400
Message-ID: <20240327122822.2842683-1-sashal@kernel.org>
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





