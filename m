Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703577B22C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjI1QsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjI1QsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:48:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A16D1B5;
        Thu, 28 Sep 2023 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695919695; x=1727455695;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rqXFJQ3cmV4se0ZtA61R0LZgTz5dEDuPK5aPKg+fNgw=;
  b=ClRTaLX/LopAXahD9z1XcFK29uOextfloJHlpA+M7UeS4C5fcC1f7iEq
   1SHn3fyKBFN5EOwmRXGQrbIXntxrqAibBuxphZt8DCR/h+M+QPFH5w5nD
   y+W0Mp3xK0LnlEvG0iKVb9cGvU6utrtAWlI/bwqMZqeiQ7FwssyJTUCOW
   umqAPS38tap9I6pJMOb5JfUYHPBHJYED/ligbdve37+gip1KXFgF2/fcb
   oEzO2TdxRnyZtHzxHH7CXsOLoheRouBGsxFJnH9l0TxXbAukZsV4qV8k0
   GiVunAMAdqyCplI3c3SDHCVoKusxRcI0O6/RVozt8apeUm5OPRx4upc4t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="380995922"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="380995922"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 09:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="819926662"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="819926662"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.8.12])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 09:47:56 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, peter.colberg@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 2/3] fpga: m10bmc-sec: Change contact for secure update driver
Date:   Thu, 28 Sep 2023 09:47:53 -0700
Message-Id: <20230928164753.278684-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the maintainer for the Intel MAX10 BMC Secure Update driver from
Russ Weight to Peter Colberg. Update the ABI documentation contact
information as well.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
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
index b97ee6f50679..8006c35956bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10755,7 +10755,7 @@ F:	drivers/mfd/intel-m10-bmc*
 F:	include/linux/mfd/intel-m10-bmc.h
 
 INTEL MAX10 BMC SECURE UPDATES
-M:	Russ Weight <russell.h.weight@intel.com>
+M:	Peter Colberg <peter.colberg@intel.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
-- 
2.25.1

