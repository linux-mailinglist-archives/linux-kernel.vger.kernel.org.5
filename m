Return-Path: <linux-kernel+bounces-121249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A6B88E45C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6BD2A22F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930F1A0B08;
	Wed, 27 Mar 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alADXk+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BEA1A0AFA;
	Wed, 27 Mar 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542456; cv=none; b=ki2GjXaQuufWXYVncLYqTkR5D2OnE4xRs85olsyBUNMUrRjQjrvYhVZNVX2K5D5869jKjGex8Yy+Njm1ejU+OhugvdXImCT/oxBEHPmgn71mXSN5D/6qAUb3bqowpD6d6jpkEMieAMVubowysMguMBrO+WdPNPMLF7HpTqE8BXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542456; c=relaxed/simple;
	bh=UvaEZ5feqbKi2/n4pQkHivA0BBi/oBUDBe8PFSfJ2mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEGio3oGQFeKfuoswqM4hUVaySTTNTmG7wuW2KgV0XmzjpD3t386EwkTq4kO9X+aby2aHvdAcE2lrnISlI0xSv1xjXSpV7/Eeg9WikR1gJQEtUpArIXvYWEB4xucc4d/EzhizIpdB5VRXAW44LY10TQkPeZ0vE47IQJSj/MHT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alADXk+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B03C433F1;
	Wed, 27 Mar 2024 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542456;
	bh=UvaEZ5feqbKi2/n4pQkHivA0BBi/oBUDBe8PFSfJ2mk=;
	h=From:To:Cc:Subject:Date:From;
	b=alADXk+O4bRHHqw4a1SN6ls/W28gWz1WiXraCCDZbyV0aKHOlbc4WNRnCMsVfeDH4
	 Yvy75CLies2BzMRkT86HQU46KpBsjmmeeZc59DZnD4aTnfmyEkS//gdf3FQYj284wI
	 Gx4nzrjO+vIiTLvOeHBgz5gohw7FFXYZEdkEezJVI35I+uxt35Nszd+uKZ3oVtrYez
	 1c2LRyidFC9UTkmsASz4oKcJHv5kdI58BCNDF5F0SF5L3gSonIODoB8ZwUtNKVDf/v
	 RkDNDOfN2rBl75313RG99EZp1wHfAhXcCoOMk2EA1P0IF/c6c5bdmMIQHfVCd98QWA
	 8pX1t/iuU/N9A==
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
Subject: FAILED: Patch "drm/amd/display: Preserve original aspect ratio in create stream" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:34 -0400
Message-ID: <20240327122734.2842026-1-sashal@kernel.org>
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





