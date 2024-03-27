Return-Path: <linux-kernel+bounces-121153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E6188E49F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD57B30B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CC13DB9C;
	Wed, 27 Mar 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUY5K+/v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F8178884;
	Wed, 27 Mar 2024 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542218; cv=none; b=eRDwHRqYcZLUs6/yOV4deAesQLcp4hqaKmxXCBCRwDAGQLiPpo+iBk0w+PuFhPegUlSCjFETMAs5i7Bp8zE3oVCcOTM0qs1PrzwSrlCBShcFqol8MV8tMnEK08hirvBKSeyt3jUvs6yXkhvemkVf/9Etkme83P5OS+DPpcadfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542218; c=relaxed/simple;
	bh=WaqDM0k5E+6TqZ7VAo4xPDJa0mQQFOoAW/voY48wwiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQ5+F8vmxhJ4hKemUsI6CpazTwchluDcrNGkyC7TI2eaG31LCSfKBZdBkH9kCI4zNxBqEWsyIMCuLrOX316VFpa06sZcSp5Kog89ozO4pr23maLkX0YZmPxqsyXaCJTOTN4ss3PaWYDI7A2vTyUNG2BdXYVfupqLVW1T01FNGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUY5K+/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B8AC433C7;
	Wed, 27 Mar 2024 12:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542218;
	bh=WaqDM0k5E+6TqZ7VAo4xPDJa0mQQFOoAW/voY48wwiU=;
	h=From:To:Cc:Subject:Date:From;
	b=OUY5K+/vB7dFXq78FUGH3QFHh8PSNffmCsFWt8wxPIT6z57zajNfh74GCRtDL/Dhh
	 kdIEbSgH6BqoCRQCHBvpNIbppmPE+ixuWSECDeBbyzeNFsBk4qNq7eOmj1ARuP2V8+
	 mfsfocKGGXlvsntrHC0StBOOoUQwCz5HLCmcXxS7xXPp1JTFmpJ/XY5WDLz0x/l7/2
	 83EMlLCc1+qhrNybctpvHLXkqUQja5K6wr7Zz5LhPPsHFKX3mdD8yp8wgMD0XvVDOR
	 Y9vdv6liHV+Prg+LCjfjLKizJMAJLgVZE+PPW6wQt0MHbdyHG0GXNQ1MA2RmF6aOn8
	 f2+dRRiJ9gTfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jani.nikula@intel.com
Cc: Adrien Grassein <adrien.grassein@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/bridge: lt8912b: do not return negative values from .get_modes()" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:36 -0400
Message-ID: <20240327122336.2838688-1-sashal@kernel.org>
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

From 171b711b26cce208bb628526b1b368aeec7b6fa4 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 8 Mar 2024 18:03:42 +0200
Subject: [PATCH] drm/bridge: lt8912b: do not return negative values from
 .get_modes()

The .get_modes() hooks aren't supposed to return negative error
codes. Return 0 for no modes, whatever the reason.

Cc: Adrien Grassein <adrien.grassein@gmail.com>
Cc: stable@vger.kernel.org
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/dcdddcbcb64b6f6cdc55022ee50c10dee8ddbc3d.1709913674.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index e7c4bef74aa46..4b2ae27f0a57f 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -441,23 +441,21 @@ lt8912_connector_mode_valid(struct drm_connector *connector,
 static int lt8912_connector_get_modes(struct drm_connector *connector)
 {
 	const struct drm_edid *drm_edid;
-	int ret = -1;
-	int num = 0;
 	struct lt8912 *lt = connector_to_lt8912(connector);
 	u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	int ret, num;
 
 	drm_edid = drm_bridge_edid_read(lt->hdmi_port, connector);
 	drm_edid_connector_update(connector, drm_edid);
-	if (drm_edid) {
-		num = drm_edid_connector_add_modes(connector);
-	} else {
-		return ret;
-	}
+	if (!drm_edid)
+		return 0;
+
+	num = drm_edid_connector_add_modes(connector);
 
 	ret = drm_display_info_set_bus_formats(&connector->display_info,
 					       &bus_format, 1);
-	if (ret)
-		num = ret;
+	if (ret < 0)
+		num = 0;
 
 	drm_edid_free(drm_edid);
 	return num;
-- 
2.43.0





