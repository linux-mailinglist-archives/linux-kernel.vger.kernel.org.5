Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE5A7D69E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjJYLSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjJYLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:18:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26277186;
        Wed, 25 Oct 2023 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232717; x=1729768717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZnEsI21T+BVIgOU+yWrQFs6Jq1f1Hh4Po/SFx2T8n10=;
  b=YMPxpEXUr1TQoE1HGFxTmvRZ9oXwYLg6mbK1e6QuqrIeh+lXwAp2Heqk
   y0h/5V3oVwsZZQE8xmpT9z/y2sE8AirxcwApfc3Fyg/LipsdWh5x5Z6u6
   UUrAUr/WKYJJiS48msyHzWaXMdKJ296MntleByd8z6I23u/Etztc6gpwL
   HiiDf639iEOcS7X74Jb8QAY7oRvCtErkqCCTmy3xeTUxqm5PUd/k4OiFI
   sEbDTGf2xnOpBAtNUYzjUeMeMwhjYPQhaA0Jta12kBw0bJoGI8CG54FCY
   MpbpbZPIIKDTtDX1UxT2rcJTmtywXi2ekiSkk+QMhd1DurNGRfbO+re1w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154634"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154634"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425130"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425130"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:26 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 5/6] ACPI: acpi_video: Rename ACPI device instances from device to adev
Date:   Wed, 25 Oct 2023 14:18:05 +0300
Message-ID: <20231025111806.2416524-6-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025111806.2416524-1-michal.wilczynski@intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since transformation from ACPI driver to platform driver there are
two devices on which the driver operates - ACPI device and platform
device.  For the sake of reader this calls for the distinction in
their naming, to avoid confusion. Rename relevant ACPI devices to adev,
as corresponding platform devices are called pdev.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_video.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 5b9fb3374a2e..bfc7f51a527d 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1526,7 +1526,7 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_video_bus *video = data;
-	struct acpi_device *device = video->device;
+	struct acpi_device *adev = video->device;
 	struct input_dev *input;
 	int keycode = 0;
 
@@ -1559,12 +1559,12 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 		break;
 
 	default:
-		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
+		acpi_handle_debug(adev->handle, "Unsupported event [0x%x]\n",
 				  event);
 		break;
 	}
 
-	if (acpi_notifier_call_chain(device, event, 0))
+	if (acpi_notifier_call_chain(adev, event, 0))
 		/* Something vetoed the keypress. */
 		keycode = 0;
 
@@ -1971,16 +1971,16 @@ static int instance;
 
 static int acpi_video_bus_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct acpi_video_bus *video;
 	bool auto_detect;
 	int error;
 	acpi_status status;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
-				acpi_dev_parent(device)->handle, 1,
-				acpi_video_bus_match, NULL,
-				device, NULL);
+				     acpi_dev_parent(adev)->handle, 1,
+				     acpi_video_bus_match, NULL,
+				     adev, NULL);
 	if (status == AE_ALREADY_EXISTS) {
 		pr_info(FW_BUG
 			"Duplicate ACPI video bus devices for the"
@@ -1996,21 +1996,21 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* a hack to fix the duplicate name "VID" problem on T61 */
-	if (!strcmp(device->pnp.bus_id, "VID")) {
+	if (!strcmp(adev->pnp.bus_id, "VID")) {
 		if (instance)
-			device->pnp.bus_id[3] = '0' + instance;
+			adev->pnp.bus_id[3] = '0' + instance;
 		instance++;
 	}
 	/* a hack to fix the duplicate name "VGA" problem on Pa 3553 */
-	if (!strcmp(device->pnp.bus_id, "VGA")) {
+	if (!strcmp(adev->pnp.bus_id, "VGA")) {
 		if (instance)
-			device->pnp.bus_id[3] = '0' + instance;
+			adev->pnp.bus_id[3] = '0' + instance;
 		instance++;
 	}
 
-	video->device = device;
-	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
-	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	video->device = adev;
+	strcpy(acpi_device_name(adev), ACPI_VIDEO_BUS_NAME);
+	strcpy(acpi_device_class(adev), ACPI_VIDEO_CLASS);
 	platform_set_drvdata(pdev, video);
 
 	acpi_video_bus_find_cap(video);
@@ -2021,7 +2021,7 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
 	mutex_init(&video->device_list_lock);
 	INIT_LIST_HEAD(&video->video_device_list);
 
-	error = acpi_video_bus_get_devices(video, device);
+	error = acpi_video_bus_get_devices(video, adev);
 	if (error)
 		goto err_put_video;
 
@@ -2029,10 +2029,10 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
 	 * HP ZBook Fury 16 G10 requires ACPI video's child devices have _PS0
 	 * evaluated to have functional panel brightness control.
 	 */
-	acpi_device_fix_up_power_extended(device);
+	acpi_device_fix_up_power_extended(adev);
 
 	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
-	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
+	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(adev),
 	       str_yes_no(video->flags.multihead),
 	       str_yes_no(video->flags.rom),
 	       str_yes_no(video->flags.post));
@@ -2059,7 +2059,7 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
 	if (error)
 		goto err_del;
 
-	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+	error = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
 						acpi_video_bus_notify, video);
 	if (error)
 		goto err_remove;
-- 
2.41.0

