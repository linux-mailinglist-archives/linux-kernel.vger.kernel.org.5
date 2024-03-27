Return-Path: <linux-kernel+bounces-121071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA488E20F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8099D1C2A62F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B86161B53;
	Wed, 27 Mar 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD5o7IBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478D161929;
	Wed, 27 Mar 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542001; cv=none; b=LL3AdlYAOsqFMndMXE/cPqNrmiD7VRY8lm0/Ja0DTcl1NQM8MeRMHUSo2BcSSCVsz+5FBEgcBS70wGS4i1d09ZqmPRTMGthh31aeoSq5wrH3ILLA+sngD0tn/cN6qwYob7KX2xdBP3BvQFZpzAXW5J0MkC+dzZJRszCwPlzC9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542001; c=relaxed/simple;
	bh=6gZT4HgYtFq+V6iRSGqnCI8CZr+cZt3dyxLpxUOKvIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laofG8qiDRXheikhBAKDDFji10HNxJM37sQ6sJ8CcJmkcXjeO+Wj8ItrQ6vv9WLQVjXd8ies9pmhmR2Ih9UI1kdihzeZGQNeLB0DZNe+cEy9gfVg+tSRCcrAcmtod4oiJJaIIvBtcw4VbWQxMuRVVjxzl71f3GZWKZtWP5AmfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD5o7IBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A28EC433F1;
	Wed, 27 Mar 2024 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542001;
	bh=6gZT4HgYtFq+V6iRSGqnCI8CZr+cZt3dyxLpxUOKvIM=;
	h=From:To:Cc:Subject:Date:From;
	b=mD5o7IBRU6l3kQ28WPDTRzcLSNmhXen0FcJvo2Wp8cwT9aeKOEgkd9imR0lwPkIj1
	 b/z3cCEJVc64ZfBl0os7DKqSawLgtd2KKHD+IKe+zDglkivVjTCNEk7JCI4jmoBClg
	 6a/HtNCRfYPUPHPD5PKO8ijzFLEE73tOqMF1mUHr9wQ1GR3Z94NWYMOd2rll/vgu/9
	 IhOxLl0t+W0du7LeJ4/04Zx1Q9Ujy6lRvYgKYyp8/dQrTLSfyOQIirvH5cpolArpsn
	 rUWdXhvXhGueEJsY4Yt1JcELqvdIJwEIfEsAhAbgIDpNHL6bn84rz4Q0sVG3erjZIQ
	 62kV7vAyLu2ZA==
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
Subject: FAILED: Patch "drm/amd/display: Preserve original aspect ratio in create stream" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:59 -0400
Message-ID: <20240327121959.2835648-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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





