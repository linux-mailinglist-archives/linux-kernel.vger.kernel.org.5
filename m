Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EEC7D2918
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjJWDax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjJWDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:30:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC4210CE;
        Sun, 22 Oct 2023 20:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698031814; x=1729567814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbeVU1+sXbzRi3Zrjrq4r+R4+mYuY+Z+kUuHc+fyWyE=;
  b=R/stuqen7WWUYDV8R8tHersQhVdScPwyp3IuWl3p4VKDb5vF9IQMXSAQ
   WWE/8dVze2RCDMJuc6YSxfRGuZ8mksOBv0/PCdYL5+Wa8Its1R8rEae+v
   V0Xul/zHfJQcqu869NiWcUPOeJoi8pv9eWF8Yv/EK90sK6Q/dVoAXdYGw
   vDCGwJbii/mIKIENcY3Z327lEfl21uHVU1Y7iRPl/5TnfmIFsngsDPAJa
   QkPhqoHKh019nqJhdLqockxaBHGXW7RgI32JDBRvMjffM+oLSwtAqVn5m
   a8cA8/6MS7dAmxmiEmtf6aHEe5yEVclZJD/7vsFjdFtLgHcLHiRg2w2D/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="5380107"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5380107"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 20:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="881617671"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="881617671"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2023 20:30:10 -0700
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     gregkh@linuxfoundation.org
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com
Subject: [RESEND PATCH 1/2] fpga: m10bmc-sec: Change contact for secure update driver
Date:   Mon, 23 Oct 2023 11:28:56 +0800
Message-Id: <20231023032857.902699-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023032857.902699-1-yilun.xu@linux.intel.com>
References: <20231023032857.902699-1-yilun.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Change the maintainer for the Intel MAX10 BMC Secure Update driver from
Russ Weight to Peter Colberg. Update the ABI documentation contact
information as well.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Acked-by: Peter Colberg <peter.colberg@intel.com>
Link: https://lore.kernel.org/r/20230928164753.278684-1-russell.h.weight@intel.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 .../testing/sysfs-driver-intel-m10-bmc-sec-update  | 14 +++++++-------
 MAINTAINERS                                        |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
index 0a41afe0ab4c..9051695d2211 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
@@ -1,7 +1,7 @@
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_root_entry_hash
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Peter Colberg <peter.colberg@intel.com>
 Description:	Read only. Returns the root entry hash for the static
 		region if one is programmed, else it returns the
 		string: "hash not programmed".  This file is only
@@ -11,7 +11,7 @@ Description:	Read only. Returns the root entry hash for the static
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_root_entry_hash
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Peter Colberg <peter.colberg@intel.com>
 Description:	Read only. Returns the root entry hash for the partial
 		reconfiguration region if one is programmed, else it
 		returns the string: "hash not programmed".  This file
@@ -21,7 +21,7 @@ Description:	Read only. Returns the root entry hash for the partial
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_root_entry_hash
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Peter Colberg <peter.colberg@intel.com>
 Description:	Read only. Returns the root entry hash for the BMC image
 		if one is programmed, else it returns the string:
 		"hash not programmed".  This file is only visible if the
@@ -31,7 +31,7 @@ Description:	Read only. Returns the root entry hash for the BMC image
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_canceled_csks
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Peter Colberg <peter.colberg@intel.com>
 Description:	Read only. Returns a list of indices for canceled code
 		signing keys for the static region. The standard bitmap
 		list format is used (e.g. "1,2-6,9").
@@ -39,7 +39,7 @@ Description:	Read only. Returns a list of indices for canceled code
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_canceled_csks
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Peter Colberg <peter.colberg@intel.com>
 Description:	Read only. Returns a list of indices for canceled code
 		signing keys for the partial reconfiguration region. The
 		standard bitmap list format is used (e.g. "1,2-6,9").
@@ -47,7 +47,7 @@ Description:	Read only. Returns a list of indices for canceled code
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_canceled_csks
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Peter Colberg <peter.colberg@intel.com>
 Description:	Read only. Returns a list of indices for canceled code
 		signing keys for the BMC.  The standard bitmap list format
 		is used (e.g. "1,2-6,9").
@@ -55,7 +55,7 @@ Description:	Read only. Returns a list of indices for canceled code
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Peter Colberg <peter.colberg@intel.com>
 Description:	Read only. Returns number of times the secure update
 		staging area has been flashed.
 		Format: "%u".
diff --git a/MAINTAINERS b/MAINTAINERS
index b19995690904..6f627a12ef9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10700,7 +10700,7 @@ F:	drivers/mfd/intel-m10-bmc*
 F:	include/linux/mfd/intel-m10-bmc.h
 
 INTEL MAX10 BMC SECURE UPDATES
-M:	Russ Weight <russell.h.weight@intel.com>
+M:	Peter Colberg <peter.colberg@intel.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
-- 
2.25.1

