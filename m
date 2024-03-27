Return-Path: <linux-kernel+bounces-121004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD888E164
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DE41F2835A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB50112F58B;
	Wed, 27 Mar 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoyFUNnw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7B1586CA;
	Wed, 27 Mar 2024 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541815; cv=none; b=jF+JNJg1QTnxmPEw3HBOzydQzwFQ/aUZmeCRuN3LehDNeCI4fKfmvJOoTqf04KlkM0geqCXKtIkgwDGhB2P+by8DIIh4aFfDvfnE79AFkKxniO7A2t3INQTXzpaxG409o1Cc/fd0XanT9slNbMjkgj4C1KhIEtMEkA1dbUNKUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541815; c=relaxed/simple;
	bh=4ylksoc4Zx0zxuEF501c8T2cTtIKDEsjRs5OsPkePxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G17A6DJHtRS/TPKpaVSgfu6bjtACRXjlWl5aRSVMmSodq6ediFw3v0hk1MQu3HhtyjZQ0cKJlE6P5Q90hufrkFLGaul0VV2OcvCAEaXnPJzl3ubhdT1OMN8JkE7YW/09In2HDJLPR8rAZnlAWJ4yA87FITBgSjh6YS8YWaZDqOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoyFUNnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95BDC43390;
	Wed, 27 Mar 2024 12:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541814;
	bh=4ylksoc4Zx0zxuEF501c8T2cTtIKDEsjRs5OsPkePxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QoyFUNnwMjIrw7Kgzx+We4NlCgqHMNo7JAHIlq4qRRqulneT8fcl/VQZtThZ67SGY
	 sHhRii417XMCezj8B5p0OhM8Z2BNzMcbgn5CqTn+w3jHAKmMo7igOSRAAVAd9iAmQn
	 aeFz9Ar/OpbIqOzwOClK34ugC1IZbd4n1p48/aAESQPPEow1Mo2C8SCak91RRoG7x0
	 ZY9FeDy9ynBDVHnfRpTqeyNdWFyBZpGOXUSZ/jv2lCllgOusNAXIcOo/nNPTkQZIvE
	 dHWPedkmEzYfq0wG8pxO00nyRPT5bWiVyUuGkI8px3lvAaNGmwaGhxASkjOf7ekpXF
	 Tn3R0DDtaPyRQ==
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
Subject: FAILED: Patch "drm/amd/display: Add monitor patch for specific eDP" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:52 -0400
Message-ID: <20240327121652.2833073-1-sashal@kernel.org>
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





