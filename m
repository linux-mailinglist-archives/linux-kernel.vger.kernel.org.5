Return-Path: <linux-kernel+bounces-120809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E01288DDFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD2A1C27831
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D06131BD2;
	Wed, 27 Mar 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROiNblBz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB27131BDD;
	Wed, 27 Mar 2024 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541264; cv=none; b=pOypJbSofKmVmCfhqNsE3D3RRmX2VVSy/3B/y+IeQ6d2AYWnIrufYmD9v5kWfnY2js4paT0uk8vahm+ZmIdtbM8v+mQhMllgsJs5r22y8b+jN2nMSvJeGqf3YfnvtT/FI9TN6X+x2HryNj50smD/6Yz0vE6CnwfGh+7Hfp0xSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541264; c=relaxed/simple;
	bh=8Rxds1D1OTn94ktiM9DXMPwgPPUzVVE0bMZmMVADTuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxmD2hT+m2A7X+rITzGpTOIDk8zYWbqMaUYF7AtitIPQNO9RanZEEnx3vBcSGhL8rul6Xj2q+V3OKpuIx2htGtTbnXQ6e8ilbjQ1wkZcey9oPub9altkVy+iU4OJCWjnJ5cgpnJC0p70RUrWQWJSsHo7wJBAxNymt+7FODsnzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROiNblBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE36C433C7;
	Wed, 27 Mar 2024 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541264;
	bh=8Rxds1D1OTn94ktiM9DXMPwgPPUzVVE0bMZmMVADTuw=;
	h=From:To:Cc:Subject:Date:From;
	b=ROiNblBzS7T6J5J+WEq78cJsDNMJF6v6J601J5g+8oROFbjO+g3nUzHOfFjczdEKM
	 Rwt9d7Wn//TmZXxUW7Fq1kffDOseWYUlx1Ad60bc4Aymaj6h76TRgNP/zGGv+U3mHo
	 PKbt4F80VOeLJOy/s3olcLu/NWfrTXvD5xzLZAAqwApTjL9T8A7C0lUKHHqJBvmLv0
	 gQXj0hv5XPhcpIfhulvEzJYJiBFotBEwrOmZTWLVgYJdtIUubY++OLUpQAP0/EpK/X
	 kMVOZBYNS93t0g7jc0FUXirgjoX1r0pPP+GxkdDr9NFutaYB6N7h3FlApCepDMsNMf
	 WLneS0Jemxulw==
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
Subject: FAILED: Patch "drm/amd/display: Preserve original aspect ratio in create stream" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:07:41 -0400
Message-ID: <20240327120742.2825656-1-sashal@kernel.org>
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





