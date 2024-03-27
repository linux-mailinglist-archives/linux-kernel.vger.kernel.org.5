Return-Path: <linux-kernel+bounces-120899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDAB88E04D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08171C208C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F95146D46;
	Wed, 27 Mar 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK4pXMuu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1607146A9F;
	Wed, 27 Mar 2024 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541530; cv=none; b=AgvCZN3HAOMJdG0ewgd5nYPhWvVEcok0DuiPZMNAvJtpSsRE/BJVTiLB3ahHGkV75feQgILem4ywj4q7DCr8i2f6XyQzXWrLB6692NJYXLihXzrSSTIWIUpJIeBmpxmF33+9toM2Kcd02Yq90VS97SfCCsTYyKYGrvDWbNk77+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541530; c=relaxed/simple;
	bh=83YOMDbkkPBQAbQ8+fXA0SSs3bJHl9mseQE6IHwOxFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3JwsOiL8e4vEAcATDfWZHmWF40K2Kd7JF4JTQZ8/is8zqM+H83xBvjllZGHv18A5VhmKpJJDnelrQdGkI7q61Z+IOwaJ0iMYcocynCGjn30MVSK1YzZe/4Q2b+UgG7FMbFjOakbvRbosVJenq37S0x3/Mkrys7qu/bY209Sqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK4pXMuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5F5C433F1;
	Wed, 27 Mar 2024 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541529;
	bh=83YOMDbkkPBQAbQ8+fXA0SSs3bJHl9mseQE6IHwOxFI=;
	h=From:To:Cc:Subject:Date:From;
	b=TK4pXMuuomoUoM65F3w3OZL9fe32V0idJV90GCAs6oCt8N+cKWVB9pGdwg0m+6lbI
	 2Yq0ckBgQXDCPqTTBzck4NudEEzGb0IKRlGKND9dfnI/ZDCg3ArbNVSQk1xMqilOD4
	 IlGUDOfnpH3LvITomvibhSl/X2vg5LOdPRHLQlQBZT2VKTZZ54FZQqE6Fe7h7uthyq
	 nJANOfNH0T0HVUlBlstz9y6mXvkLGFF+k/oDzesq2ZQLo9oVrWttQQjW3hB6o7UD44
	 LxKdxpV7wI3El3x+irbrCtJZJM/2ZPt6aJNg3HAVcwTjeqDC52HqAZIRcFTt1KbqZI
	 7Yx3rQjjN64pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wayne.lin@amd.com
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: adjust few initialization order in dm" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:12:07 -0400
Message-ID: <20240327121207.2829277-1-sashal@kernel.org>
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

From c9aef4f6c6d7cdc92a64ffe761c6921ec85157ae Mon Sep 17 00:00:00 2001
From: Wayne Lin <wayne.lin@amd.com>
Date: Fri, 2 Feb 2024 17:34:11 +0800
Subject: [PATCH] drm/amd/display: adjust few initialization order in dm

[Why]
Observe error message "Can't retrieve aconnector in hpd_rx_irq_offload_work"
when boot up with a mst tbt4 dock connected. After analyzing, there are few
parts needed to be adjusted:

1. hpd_rx_offload_wq[].aconnector is not initialzed before the dmub outbox
hpd_irq handler get registered which causes the error message.

2. registeration of hpd and hpd_rx_irq event for usb4 dp tunneling is not
aligned with legacy interface sequence

[How]
Put DMUB_NOTIFICATION_HPD and DMUB_NOTIFICATION_HPD_IRQ handler
registration into register_hpd_handlers() to align other interfaces and
get hpd_rx_offload_wq[].aconnector initialized earlier than that.

Leave DMUB_NOTIFICATION_AUX_REPLY registered as it was since we need that
while calling dc_link_detect(). USB4 connection status will be proactively
detected by dc_link_detect_connection_type() in amdgpu_dm_initialize_drm_device()

Cc: Stable <stable@vger.kernel.org>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 37 +++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 985137b51372d..8b13cb334b366 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1844,21 +1844,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			DRM_ERROR("amdgpu: fail to register dmub aux callback");
 			goto error;
 		}
-		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD, dmub_hpd_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
-			goto error;
-		}
-		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ, dmub_hpd_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
-			goto error;
-		}
-	}
-
-	/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
-	 * It is expected that DMUB will resend any pending notifications at this point, for
-	 * example HPD from DPIA.
-	 */
-	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
+		/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
+		 * It is expected that DMUB will resend any pending notifications at this point. Note
+		 * that hpd and hpd_irq handler registration are deferred to register_hpd_handlers() to
+		 * align legacy interface initialization sequence. Connection status will be proactivly
+		 * detected once in the amdgpu_dm_initialize_drm_device.
+		 */
 		dc_enable_dmub_outbox(adev->dm.dc);
 
 		/* DPIA trace goes to dmesg logs only if outbox is enabled */
@@ -3547,6 +3538,14 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
 
+	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD, dmub_hpd_callback, true))
+			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ, dmub_hpd_callback, true))
+			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+	}
+
 	list_for_each_entry(connector,
 			&dev->mode_config.connector_list, head)	{
 
@@ -3575,10 +3574,6 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 					handle_hpd_rx_irq,
 					(void *) aconnector);
 		}
-
-		if (adev->dm.hpd_rx_offload_wq)
-			adev->dm.hpd_rx_offload_wq[connector->index].aconnector =
-				aconnector;
 	}
 }
 
@@ -4590,6 +4585,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 
+		if (dm->hpd_rx_offload_wq)
+			dm->hpd_rx_offload_wq[aconnector->base.index].aconnector =
+				aconnector;
+
 		if (!dc_link_detect_connection_type(link, &new_connection_type))
 			DRM_ERROR("KMS: Failed to detect connector\n");
 
-- 
2.43.0





