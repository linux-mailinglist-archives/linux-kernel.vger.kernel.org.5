Return-Path: <linux-kernel+bounces-120815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5359988DE22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88581F2AC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7072136998;
	Wed, 27 Mar 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/w80+RU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8531353E1;
	Wed, 27 Mar 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541284; cv=none; b=Ca7v3ijsgpKbFBRrbnpe8idH/v5tUQqk58PGnWRjFk8azbXp5uqjAHbZy00HAYw1+701SZ8VDu4QL6aWfQb5SmUy+7xaMc+aydxbvoEB5attqc4AwjCUKcWcA7xwFdH9CJNM5UqqOvY5cCWUnvTZL8fAgUQKnEHBhCHk1VPe0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541284; c=relaxed/simple;
	bh=LQJvW/5F5pb6y3BD3VeOnlXzajsSx47no9m9Wu8BeVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7CUKGAU4fo4E3nkvRr1SxrqRHmc1JOduGPDU7UI3jWA36avTHtKSjW3qdO4gIXMOLbFxPScAyZH6JkDx4WZXBEJjJ97wCQ/kOa8rwCAEr1Qqwin0NcT961qk2mkFXAJKVih/2KCL/mMv7kpuBonmGceiCOwguFuN4Lq/+k+764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/w80+RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ED2C433C7;
	Wed, 27 Mar 2024 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541283;
	bh=LQJvW/5F5pb6y3BD3VeOnlXzajsSx47no9m9Wu8BeVE=;
	h=From:To:Cc:Subject:Date:From;
	b=j/w80+RUeIjw1xFQWgMvXPruO13CrBfnrhsRETmDXQgH2K0hM3TLh7EVB5fjNgzZd
	 i48QDoCMhZ2hQnxpeVFfY7aN3piUMUElE/kNd4HToSmtPUA9Ly4QwCnmob0iiV5eRI
	 O+SRe8AEgdA30WTuS0LWcYan/WCJovKLxpgtxkSQz3LnIid+fCtOoTn53SkWpdzQH1
	 WBvHjST+XEffysP3PgvxI8ZxyDe21y2MhadPti4o7jBoh0NtJlt/UFeTZofSxp+EFD
	 e9eP0jVt6mQPzXKN9FEBwlQQhAmWafuxP4m23/JQMSZIpg4rHVl9bdh92HNGKtgNfl
	 mhRARjF7+QjVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tsung-hua.lin@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Chris Chi <moukong.chi@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Add monitor patch for specific eDP" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:08:01 -0400
Message-ID: <20240327120801.2825878-1-sashal@kernel.org>
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

From 04a59c54757567f19dff4571ff7338476ec0f604 Mon Sep 17 00:00:00 2001
From: Ryan Lin <tsung-hua.lin@amd.com>
Date: Wed, 21 Feb 2024 19:10:27 +0800
Subject: [PATCH] drm/amd/display: Add monitor patch for specific eDP

[WHY]
Some eDP panels' ext caps don't write initial values. The value of
dpcd_addr (0x317) can be random and the backlight control interface
will be incorrect.

[HOW]
Add new panel patches to remove sink ext caps.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.5.x
Cc: Tsung-hua Lin <tsung-hua.lin@amd.com>
Cc: Chris Chi <moukong.chi@amd.com>
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ryan Lin <tsung-hua.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 85b7f58a7f35a..c27063305a134 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -67,6 +67,8 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
 	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
 	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
+	case drm_edid_encode_panel_id('B', 'O', 'E', 0x092A):
+	case drm_edid_encode_panel_id('L', 'G', 'D', 0x06D1):
 		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.remove_sink_ext_caps = true;
 		break;
@@ -120,6 +122,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
+	apply_edid_quirks(edid_buf, edid_caps);
+
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
 		return result;
@@ -146,8 +150,6 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	else
 		edid_caps->speaker_flags = DEFAULT_SPEAKER_LOCATION;
 
-	apply_edid_quirks(edid_buf, edid_caps);
-
 	kfree(sads);
 	kfree(sadb);
 
-- 
2.43.0





