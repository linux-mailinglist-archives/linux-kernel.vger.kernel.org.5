Return-Path: <linux-kernel+bounces-120999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6D788E1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CEC4B285B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2899157E70;
	Wed, 27 Mar 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMQu2/+t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67C157A7D;
	Wed, 27 Mar 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541801; cv=none; b=ieWX4lfJDgXrK/6F95TTS6hMJhG+4214p5a+Gx7WyyPYvhkm9pQ0NEB38T4IciWGPiGsu2H0/kVPzE2mJc/PHa7atokFu7WvO6PtkkPz/PUBsWawFsWx++i6YvuQpuvlZ4g+wmtf2SdOQxdsNVjAmQdlv6skt7ooLF7D1MskU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541801; c=relaxed/simple;
	bh=Y20evMptwoSu1w4hMKCSKGi18MXc2SMADujW67jie9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBMYEabUUg7gILC74PH3sB56A+MdRQB0TFBaj2gLuQ5qD91HglEkjlCERDlBnWO6v1F0JJzNl4+F30BTUJQPxfUEGogQtVs3EmdeWwEsCOrt2ZNVHVCFFSOjMXHll/nKP4ogB1qbzb3kBjYnhLiKHfH2noE4OQsoIvJ5Q3pTAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMQu2/+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91F5C433C7;
	Wed, 27 Mar 2024 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541800;
	bh=Y20evMptwoSu1w4hMKCSKGi18MXc2SMADujW67jie9M=;
	h=From:To:Cc:Subject:Date:From;
	b=AMQu2/+tBBD1lC3O9azTqY4UtC6Zkh/H5zg5PcdnOD1DOmKbTkhyDB1OE8qfF/PYd
	 yToHHhLGeMkkLgSiP7TUHsHKg94qpylzs+HCMOZGPFjh0F9uHee6WiVO+rwcMUCyb+
	 zKEcUzH60vS9e0n4fGGWR5SeotBOObfFzHSWcghef4mYq8BbU5Mp12oPGlXiw10Jzd
	 gNWMwX/e/LWK8eRpmafO6xZ9wLlCWOCofLtzbNzdnO5POiUq6Ber4h+wO8XHmymrm5
	 5ixFk8u1rnvvOAljUZC6hcmwUYDO/XE6NqGzf0uBRSjJfkwdHV9kbfoZwfMxaALfly
	 IUI2w3whYqbKg==
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
Subject: FAILED: Patch "drm/amd/display: Preserve original aspect ratio in create stream" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:38 -0400
Message-ID: <20240327121639.2832878-1-sashal@kernel.org>
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





