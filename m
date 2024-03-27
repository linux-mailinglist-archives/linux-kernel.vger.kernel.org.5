Return-Path: <linux-kernel+bounces-120931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E188E09E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7419FB249C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B2132C04;
	Wed, 27 Mar 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/qGINWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8014BFA2;
	Wed, 27 Mar 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541617; cv=none; b=hYcJMiHET/vyCZe5Do4fB+Sd4lT2Igj/YAMCsaE9N9ow4MNWSz1MhUveME4UFwWroygAWSEniUNRoFKWAgfM1aNYvIBA7/+8pp++ewblA05OhcBDvxkKb/jWiVuxvHxIvwdJ08OlgE549ftXNX4j1LtIGumrBrgryPgY3spWc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541617; c=relaxed/simple;
	bh=JL1Ec2pyhihlH7jM2YIqtmu/xgXiNxrEUFxvYNMiYw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQZILJdwhHN7325vcm8RRzC4O+zPAHxCq9ef0n7BOM2rjUJDTMmaq3yxHTQZLDdmiCwij0WtRR4LDnOWvnfs1DluovtfscOKiJtuExE7H2YR8MmgpUdfCXgXqvpsMZzGKVC+M6uEoJFdn+MWnFg8eAIIUvwUrlSYJlTdvznyo/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/qGINWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DB6C433F1;
	Wed, 27 Mar 2024 12:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541617;
	bh=JL1Ec2pyhihlH7jM2YIqtmu/xgXiNxrEUFxvYNMiYw0=;
	h=From:To:Cc:Subject:Date:From;
	b=s/qGINWXxA+La/f8mAXU3BmGEK0EmlGqKQb3vrctTqG3p8BR6gxGGwvUtediLjMOe
	 wLDvnO5T8BGK4xrdSvam+8XTSC4ZtpEw9CdhBfObLQoGQWQi0P+Y997RSFOY37YQRl
	 jAlxKaqAyZYu/Y0j/KbnqEiKwl7/Irczc2YjB0QwKFq5SEjeo9BO3FSc6eyMiBc142
	 oitxmZv3y0U8TyJ5W+gXExL6dq7oW7myZ8U+VzYl2C+RJqoTZtoNEbSt9ol1mHlcy7
	 SZ5QMY2YWHNHhLNYGz+5nSJ2uGtyLtLTgbq2Mw5I4WBNxvjknQhLR5CM4hmhpWJuaF
	 0XX4VakXOJ+6A==
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
Subject: FAILED: Patch "drm/amd/display: Add monitor patch for specific eDP" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:34 -0400
Message-ID: <20240327121335.2830456-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





