Return-Path: <linux-kernel+bounces-121156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654DE88E2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9597D1C22B46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C2178CDA;
	Wed, 27 Mar 2024 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvRse8tl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F83178CC8;
	Wed, 27 Mar 2024 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542226; cv=none; b=aq54VmiDNb3dTSpjAqiBeH2P6oXwiiTFE3zPXe+/gLO0CwZZoFJIMop0JT52eQbAodyLwLqv0pTbJPB+Xblw8JN73j0H3hROoGmmsRQuj11tfhktEx2tscarWZIR6ePV/ksNJnn2g4/yYmPzewzFk4+Hz1GgxC5fEVeGj6MYlaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542226; c=relaxed/simple;
	bh=N1naFqu7Az7Uu63smb5fThfFRczfWaEjRQGc2lb0Q1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BC1zLLvnUJ4uW3t51TjEjuXq3Xbxk7dmt1o2RqTkLtbsFpRTD27zOFcErgicD+moo2cOGE1/sCLrfLOime13zd8Y/El/+h1RYaGwVaPGUmWFl1GjuCNdvnsXApbY07ZpQZbwvLJS3HWJ1mwrTOBs5WglFEsP4zXxKSyR+NR9SLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvRse8tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE97C43390;
	Wed, 27 Mar 2024 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542226;
	bh=N1naFqu7Az7Uu63smb5fThfFRczfWaEjRQGc2lb0Q1c=;
	h=From:To:Cc:Subject:Date:From;
	b=UvRse8tlZRP8VMaW01IAuZ90FfNW20vuVJ5Q9KON1HQYcZzdKuD/FDufQh74oCCV2
	 wE1MF/r6VfegvHU9nQV0VDpgijiDxnbGFi/D294GhUHSyxToPPYbUJJNPViMePmZMw
	 4sifQnIhGVgDtN7uHteP+mFWJEt7LGex3vgQI/FVlrw65JALhAJtyrvR8UQr5Ez0Fe
	 cnzJO5flEFjRTstIF4YP/zOXHJSOjLZkYaKfJw4eDMO2SYFnrYw4A1LJmMojtkICSV
	 RcizLOuX3UwHBD3wJYvS3zyQfAgvFxxeKazbChBJgwr6gNcRILB/FuifLxzyjWprN4
	 mf1ZboKI9+VwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chiahsuan.chung@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Preserve original aspect ratio in create stream" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:44 -0400
Message-ID: <20240327122344.2838804-1-sashal@kernel.org>
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

From 79f3e38f60e5b2416ba99804d83d22e69ae592a3 Mon Sep 17 00:00:00 2001
From: Tom Chung <chiahsuan.chung@amd.com>
Date: Tue, 30 Jan 2024 15:34:08 +0800
Subject: [PATCH] drm/amd/display: Preserve original aspect ratio in create
 stream

[Why]
The original picture aspect ratio in mode struct may have chance be
overwritten with wrong aspect ratio data in create_stream_for_sink().
It will create a different VIC output and cause HDMI compliance test
failed.

[How]
Preserve the original picture aspect ratio data during create the
stream.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a2220d4787fb3..4fd07c60a2ad7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6232,7 +6232,9 @@ create_stream_for_sink(struct drm_connector *connector,
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
 			drm_mode_copy(&saved_mode, &mode);
+			saved_mode.picture_aspect_ratio = mode.picture_aspect_ratio;
 			drm_mode_copy(&mode, freesync_mode);
+			mode.picture_aspect_ratio = saved_mode.picture_aspect_ratio;
 		} else {
 			decide_crtc_timing_for_drm_display_mode(
 					&mode, preferred_mode, scale);
-- 
2.43.0





