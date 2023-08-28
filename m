Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6F78A863
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjH1I6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjH1I6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:58:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4AF3;
        Mon, 28 Aug 2023 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693213100; x=1724749100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LD+hCR4+svTbTb5graAPaOfi6+hwkpB7DJZjCWCAi9s=;
  b=aA4YUymZH1B+rnWYRCdBAeOxZl3/dcUDKGG1GFnc94t5UeQytZkP95rV
   1QUSpbEfK6v9fXIw70JXrDMJGa5xSCt/JEtU6+3Y3378OUxN8GdyOdcVY
   QZtJCZsI6bDnA22ab5f8ZIfVYNlRRnTL9mdqtPSYjyhz0nX+Fz1HNIMOk
   Fh9VWheDmGP83Pz7DkfF6dRrI10lXqvfdIMHe3h+GPWj2Gix2SQnOUS+j
   XBpEMtipY/1DUk+hpSVFwfWNIoTyqXGO7MjTpG1GWzVRlOraPF1RoUQrC
   k3JL6GN0n+dSY21+ax1IOo7d5QXUPmj4ZAZgRZpA6LPRsyL4uN+rWefUi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="461424401"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="461424401"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 01:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="741311029"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="741311029"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 01:58:18 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 0230311F871;
        Mon, 28 Aug 2023 11:58:15 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1qaY3s-00GPmN-0I;
        Mon, 28 Aug 2023 11:57:28 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-media@vger.kernel.org
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH 1/1] media: ivsc: Depend on VIDEO_DEV
Date:   Mon, 28 Aug 2023 11:57:18 +0300
Message-Id: <20230828085718.3912335-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_VIDEO_DEV is required by other selected symbols. Depend on it.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 29006e196a56 ("media: pci: intel: ivsc: Add CSI submodule")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/pci/intel/ivsc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ivsc/Kconfig b/drivers/media/pci/intel/ivsc/Kconfig
index e9ecd0bd99bd..0acea4678fc0 100644
--- a/drivers/media/pci/intel/ivsc/Kconfig
+++ b/drivers/media/pci/intel/ivsc/Kconfig
@@ -3,7 +3,7 @@
 
 config INTEL_VSC
 	tristate "Intel Visual Sensing Controller"
-	depends on INTEL_MEI && ACPI
+	depends on INTEL_MEI && ACPI && VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_ASYNC
-- 
2.39.2

