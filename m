Return-Path: <linux-kernel+bounces-121256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B192B88E46A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB191C2BC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FA01B24F0;
	Wed, 27 Mar 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpoesEO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5F1422D9;
	Wed, 27 Mar 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542475; cv=none; b=vEE11FnntXOtvFO3KkP0ovEz/nxu9+wKkiKCtm3Yu/tb3mM6fXNiFzePiR0BIi1qPXEL+JD73h7XE4Vjv9BO4Ss/GYrgRIOu3ihNOOGmQs88iuEmho9of2RTKZFCr/QOigzeYCXffmdsv1DzHPjCFAIRooIHna9FKBJxzFBRJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542475; c=relaxed/simple;
	bh=rTBPWU1aiDp3tF/LT+tV3R1tLt7v/O3Bw1EJvWaFZWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQRup9ppZ7hlkplOeVQUdPLw7oYuAQCo2tsSveYhqdrGCF3qc4PB6d3yXyXsq1KtFqzmfPDVPS6kndsXg0DMDL82O0dH9nA5wLD6aT5iSBSkx8mQ56YC3loFu/SspXYjhBA2JYRKQy+SBXW8ePvQcLy4eWf5+jgAA4mdcxgV4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpoesEO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4B2C43390;
	Wed, 27 Mar 2024 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542474;
	bh=rTBPWU1aiDp3tF/LT+tV3R1tLt7v/O3Bw1EJvWaFZWc=;
	h=From:To:Cc:Subject:Date:From;
	b=OpoesEO2e9TUeKTAPeDBfVh/qD+pMPBWuofvBN5Q93fNfF+AqGhpRxMw7jNtHoa2V
	 p0OVS78ZjuKC6v6lKcKNnR8iEyeUY3vdrun0ZHUj4Zotl+Rd3OzQ0prHN6O+hHDLnj
	 QRNCPHY/LuRY8WgjxocIYx5OE2KhZz/ii1eickcip7U6oKanznW7NiTw6XLjAcNXgR
	 YVsf/+Tqqlhn3J5WmkS31aDl3CBgUHOkEd+VW6eQB9/67r3jR0gX9JqaKXyMzf0O58
	 1Ig9sjQ57Xlsv8R8lokVFyEmyl+Q0pKU73cONNfoefq66ox8zEUvmvXuvsrHx0fQgo
	 olVJsNixcQLLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ivlipski@amd.com
Cc: Daniel Wheeler <daniel.wheeler@amd.com>,
	Sun peng Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Add monitor patch for specific eDP" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:52 -0400
Message-ID: <20240327122752.2842291-1-sashal@kernel.org>
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

From 21afc872fbc29cd68cfde816d1df4d55848c3f61 Mon Sep 17 00:00:00 2001
From: Ivan Lipski <ivlipski@amd.com>
Date: Fri, 1 Dec 2023 06:25:16 -0700
Subject: [PATCH] drm/amd/display: Add monitor patch for specific eDP

[WHY]
Some eDP panels's ext caps don't write initial value cause the value of
dpcd_addr(0x317) is random.  It means that sometimes the eDP will
clarify it is OLED, miniLED...etc cause the backlight control interface
is incorrect.

[HOW]
Add a new panel patch to remove sink ext caps(HDR,OLED...etc)

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b4696ec621c45..eaf8d9f482446 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -64,6 +64,12 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_fams = true;
 		break;
+	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
+		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.remove_sink_ext_caps = true;
+		break;
 	default:
 		return;
 	}
-- 
2.43.0





