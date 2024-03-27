Return-Path: <linux-kernel+bounces-121122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F216F88E296
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52822912B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111A1173357;
	Wed, 27 Mar 2024 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpOHT3CU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4547617334A;
	Wed, 27 Mar 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542135; cv=none; b=YHjivLcYq8Wiw9y+lNvw67mBz2YS9GBNTY2gHdcGwVA4+EUfpTqfydGtkuDdXisMkmO9Z14ixtYsP6dZmdP/8GHxUWR7TJQ8Erj3Vfhr+5oRX9aXhyassGGB2FNUgyD+hLVQV5JEz2SVKJ69LDkaW0wLomdad0ZOfll1hkZhzQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542135; c=relaxed/simple;
	bh=aDxsv+D/Va7J7spxn9v8usSvI+cYbXKI/Uuv+S5nK68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKDvtNAiQWXNlDM3lpcJNsfEWwnkFTF4ls2TdCSvlVf7+nZmATxk/4NHjz4m8uihJfX3I2Ib+Bu60fCYtYuZvhxer+6x4uUNhyXbSJUh2mrJLXl92sJSqywD1maWi0XvGFVQ8Kx+I9xyzrqCnmTvwPTtpWvBqLQCz3KPygo/fF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpOHT3CU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB2AC433F1;
	Wed, 27 Mar 2024 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542135;
	bh=aDxsv+D/Va7J7spxn9v8usSvI+cYbXKI/Uuv+S5nK68=;
	h=From:To:Cc:Subject:Date:From;
	b=UpOHT3CUyUbdQG7b/JqQ6n9VfpuaEHP1MUW4UIUURr756VoAy5D/j2Qf2CRjrInGX
	 coqlXRZ0opR8S+kGGNpNefPVH8cJ7ZY/dXFQOqcxQxb4GLQcoXY/dTxoIJTcTI5FhC
	 2Jf6VI4HLNdr6UfhOn8DiLPk+EkTD0epXJtEW2QXJKtu1E69BUb7C8QjND5M3MwTQ4
	 F30w4ABXmnkYLyfa5HoGqKZCanuRQ3fLjcrH/Xjw/N+g7nuFlmFqpO2g/DD2GaejTx
	 L13olGWvXmUxO/AEU/KQuC7M0Zkjpipi8muwJ85dbggtA3qsJD8DhCPQmuw9RszOjJ
	 hPUfD4ibKkavA==
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
Subject: FAILED: Patch "drm/amd/display: adjust few initialization order in dm" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:13 -0400
Message-ID: <20240327122213.2837525-1-sashal@kernel.org>
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





