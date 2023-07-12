Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F37513DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjGLXAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjGLW74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:59:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E552111D;
        Wed, 12 Jul 2023 15:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202795; x=1720738795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=By/NKtYUTetCnrDaC71POzdKcsg/WaUlUKV68ELPiqo=;
  b=DOJx+ZogSztR8Slkj5DCGddUEYMKvPLxV24JnNrON3YTqjriQMOQauEu
   2GcWaPe35DwdR9tW66OqewNoVRPiL2thsl+azn901nzEQOCVtERyMvaTJ
   38o2rBapNarvfKP9yLqoLeeCx+a3W5KxIkdXXhlsxYywxDx5xgCSctkHN
   KSHZxclgZ6eISgKWbgcfks4q4wv0bRb7kkVjsderA3Vc6dF+w74+SKTfA
   N7YMnSsg/vwEjncKFtC61ZAoaDaE39FV2cuOi5VDpJrDhFb7yt1mnDPHg
   PPas6Et1EHU+f1mkENpYpLQ9h+HsCSeV+8BAPqFNsAxNZsCvXOHSEZcOt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431172825"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431172825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 15:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866316698"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="866316698"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2023 15:59:53 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 3/3] doc: TPMI: Add debugfs documentation
Date:   Wed, 12 Jul 2023 15:59:50 -0700
Message-Id: <20230712225950.171326-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
References: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe fields in the TPMI debugfs folder.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3
changed date to November 23

v2
New.

 Documentation/ABI/testing/debugfs-tpmi | 31 ++++++++++++++++++++++++++
 MAINTAINERS                            |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-tpmi

diff --git a/Documentation/ABI/testing/debugfs-tpmi b/Documentation/ABI/testing/debugfs-tpmi
new file mode 100644
index 000000000000..597f0475fe6e
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-tpmi
@@ -0,0 +1,31 @@
+What:		/sys/kernel/debug/tpmi-<n>/pfs_dump
+Date:		November 2023
+KernelVersion:	6.6
+Contact:	srinivas.pandruvada@linux.intel.com
+Description:
+The PFS (PM Feature Structure) table, shows details of each power
+management feature. This includes:
+tpmi_id, number of entries, entry size, offset, vsec offset, lock status
+and disabled status.
+Users:		Debugging, any user space test suite
+
+What:		/sys/kernel/debug/tpmi-<n>/tpmi-id-<n>/mem_dump
+Date:		November 2023
+KernelVersion:	6.6
+Contact:	srinivas.pandruvada@linux.intel.com
+Description:
+Shows the memory dump of the MMIO region for a TPMI ID.
+Users:		Debugging, any user space test suite
+
+What:		/sys/kernel/debug/tpmi-<n>/tpmi-id-<n>/mem_write
+Date:		November 2023
+KernelVersion:	6.6
+Contact:	srinivas.pandruvada@linux.intel.com
+Description:
+Allows to write at any offset. It doesn't check for Read/Write access
+as hardware will not allow to write at read-only memory. This write is
+at offset multiples of 4. The format is instance,offset,contents.
+Example:
+echo 0,0x20,0xff > mem_write
+echo 1,64,64 > mem_write
+Users:		Debugging, any user space test suite
diff --git a/MAINTAINERS b/MAINTAINERS
index 5761b02183a7..4d439121fb36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10720,6 +10720,7 @@ INTEL TPMI DRIVER
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/debugfs-tpmi
 F:	drivers/platform/x86/intel/tpmi.c
 F:	include/linux/intel_tpmi.h
 
-- 
2.40.1

