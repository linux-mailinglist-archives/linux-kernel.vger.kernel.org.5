Return-Path: <linux-kernel+bounces-121164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD90088E303
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6F71C2B122
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCFA13E412;
	Wed, 27 Mar 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut55yG+D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F67179962;
	Wed, 27 Mar 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542247; cv=none; b=WN8j1vhSMXQVZVAwYmIXsg8J12bzD2n6TVVMmZFVRz226udwJaKn0SKzOgLG2GzbmwMnW0a2BiSN++6KTfhcw1o5dDq7IsP0sxnq7AmvzghBGefS/loF/xm9JPXlgefoyLTmcdGu7vuKZ2ZKLPVOcWZctAri0+4VxRI7vvvKRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542247; c=relaxed/simple;
	bh=KgA1WFhnJIUHCVfRQyIfO8XDVvOxQtNa6YUEtVnt09Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttKxLrBBP+RgGy/Sg874CVYuA5jw9Vj/95vaRRM/tCvCK2cSq3bd0C0UmNrD6SklwUf2Z4kPh8+zs4fG/R8V8BrdFLvHLPtDNMk0GLFM9iqOYeVKSSKmQZ/cOgM3bxnDbSbCrfisNZjDD/9Sh/GG5RpYj6ygkVhCbreoe9hGxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut55yG+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5E9C433C7;
	Wed, 27 Mar 2024 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542247;
	bh=KgA1WFhnJIUHCVfRQyIfO8XDVvOxQtNa6YUEtVnt09Q=;
	h=From:To:Cc:Subject:Date:From;
	b=Ut55yG+D9Ond13evlXfGKoWAt88cQMwIzUHgdWtJGj1EHwatz4likyN290tT3rbjt
	 mQ8/97yE3YSzmx1P1+SE1WHZ5W71uJIMFQCOacbY9jaRGKI723FVq8SDlzGTQo7+fc
	 GdfNiwcnUcLwL9xxJVLaF6bsSKqPV/n6m24I/64yrGDvKYFAqpA7gUS6nDakaqiDEL
	 M57v9moN0EI9rfeqICJ1qlcx2+zk+D9KYjxF8ccGSIltxzvaUBtkYd0kVAtmie+MO0
	 UmM/yiXpyRcQwClEvsPLJqjEy24I9djlGVQcXuQN3XCM+o3PSSIt2sH+76exCuXsjS
	 h93OfvmbEzmdQ==
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
Subject: FAILED: Patch "drm/amd/display: Add monitor patch for specific eDP" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:24:05 -0400
Message-ID: <20240327122405.2839110-1-sashal@kernel.org>
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





