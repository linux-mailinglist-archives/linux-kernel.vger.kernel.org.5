Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18AD7CE769
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjJRTKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjJRTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:10:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF0011F;
        Wed, 18 Oct 2023 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697656215; x=1729192215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4UODrq8h3M2ue98vfE4pky6De+v+9Ny98Hg4mFpil8=;
  b=eu6gsYLPWNk0d+IYkdsAnVauBd2Tv+RZ5MNX/cwdyuSbMslAAMGpllHH
   TwjPekiAP9jo6B/GD1XJkNPjsQvZ5Cdpkse46t+doW1J7DLBFFkELL6se
   ndpsNRLmk/F073c+aq7SfT4V53xtwio+kDWq+kka1adQbh1jKP4LAeDhR
   dRhNIIQUJKIn7BIC40lW1xyOIhxKY2Zi/aOSWBP7jktoEnEjW0FobVeb0
   mqE2fhorv6HKCXZnEvtK0xxmcR1cJVBBhHj9IOo2OnXE3ew2M+zbxE+P0
   zY6//k2ARdVKJe4vIbEyi4lhZWNecJ4w4DbUmzZXyz4oN4rbOnf00amSp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472323324"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472323324"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733277300"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="733277300"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:12 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 3/3] ACPI: acpi_pad: Rename ACPI device from device to adev
Date:   Wed, 18 Oct 2023 22:09:45 +0300
Message-ID: <20231018190945.252428-4-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018190945.252428-1-michal.wilczynski@intel.com>
References: <20231018190945.252428-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since transformation from ACPI driver to platform driver there are two
devices on which the driver operates - ACPI device and platform device.
For the sake of reader this calls for the distinction in their naming,
to avoid confusion. Rename device to adev, as corresponding
platform device is called pdev.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_pad.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 3ede3019d898..32a2c006908b 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -398,13 +398,13 @@ static void acpi_pad_handle_notify(acpi_handle handle)
 static void acpi_pad_notify(acpi_handle handle, u32 event,
 	void *data)
 {
-	struct acpi_device *device = data;
+	struct acpi_device *adev = data;
 
 	switch (event) {
 	case ACPI_PROCESSOR_AGGREGATOR_NOTIFY:
 		acpi_pad_handle_notify(handle);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-			dev_name(&device->dev), event, 0);
+		acpi_bus_generate_netlink_event(adev->pnp.device_class,
+			dev_name(&adev->dev), event, 0);
 		break;
 	default:
 		pr_warn("Unsupported event [0x%x]\n", event);
@@ -414,14 +414,15 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 
 static int acpi_pad_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 
-	strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);
+	strcpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
+	strcpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
+
+	status = acpi_install_notify_handler(adev->handle,
+		ACPI_DEVICE_NOTIFY, acpi_pad_notify, adev);
 
-	status = acpi_install_notify_handler(device->handle,
-		ACPI_DEVICE_NOTIFY, acpi_pad_notify, device);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -430,13 +431,13 @@ static int acpi_pad_probe(struct platform_device *pdev)
 
 static void acpi_pad_remove(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 
 	mutex_lock(&isolated_cpus_lock);
 	acpi_pad_idle_cpus(0);
 	mutex_unlock(&isolated_cpus_lock);
 
-	acpi_remove_notify_handler(device->handle,
+	acpi_remove_notify_handler(adev->handle,
 		ACPI_DEVICE_NOTIFY, acpi_pad_notify);
 }
 
-- 
2.41.0

