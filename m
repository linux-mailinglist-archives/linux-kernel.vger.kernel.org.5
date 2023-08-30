Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DED78DF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbjH3UBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbjH3UAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:00:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88564793D8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693424101; x=1724960101;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1QNSa8PfJ6fHxxDbOfg/mWMGFnDXUsLlbGCHGWdkA9Q=;
  b=n/PU5MODV8YzgbFE2fcXQdhAZsukUVPQk9Z4l/IGmpQKZw5LiycAGLUH
   EQDwHCubB8s7a87MeZ0POS8p7TNQHFS+aaC3enQMbXJDs3I8CBiEhR7qT
   aOzrlhTwolk3lmxRbUZiXpwwpwxAomRyFeG8x786YgkSZPfpStUeHqtbe
   35YQJ4W2bgmtf+PQz3Is0Cg0/OtrWe6QRcrLAgl4of9oj6wxPN3pyrd4c
   Nd9vKSg4hFwiIIdm9wgS6fDpPfl9jxzXN2+b7FXivm9bEzuIhgSUm8bcL
   ZpqE9QpC90luaGPf0kFHJolmGQZvGrZOK6Dg1FpMCP3qDxN+qyzRmx/FL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360723612"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="360723612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 12:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="853844784"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="853844784"
Received: from nivakuma-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.238.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 12:33:19 -0700
Subject: [PATCH v3 1/5] virt: coco: Add a coco/Makefile and coco/Kconfig
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Date:   Wed, 30 Aug 2023 12:33:18 -0700
Message-ID: <169342399880.3934343.12969478676791150366.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding another coco build target, relieve
drivers/virt/Makefile of the responsibility to track new compilation
unit additions to drivers/virt/coco/, and do the same for
drivers/virt/Kconfig.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/Kconfig       |    6 +-----
 drivers/virt/Makefile      |    4 +---
 drivers/virt/coco/Kconfig  |    9 +++++++++
 drivers/virt/coco/Makefile |    7 +++++++
 4 files changed, 18 insertions(+), 8 deletions(-)
 create mode 100644 drivers/virt/coco/Kconfig
 create mode 100644 drivers/virt/coco/Makefile

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index f79ab13a5c28..40129b6f0eca 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -48,10 +48,6 @@ source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
 
-source "drivers/virt/coco/efi_secret/Kconfig"
-
-source "drivers/virt/coco/sev-guest/Kconfig"
-
-source "drivers/virt/coco/tdx-guest/Kconfig"
+source "drivers/virt/coco/Kconfig"
 
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index e9aa6fc96fab..f29901bd7820 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -9,6 +9,4 @@ obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
-obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
-obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
-obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
+obj-y				+= coco/
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
new file mode 100644
index 000000000000..fc5c64f04c4a
--- /dev/null
+++ b/drivers/virt/coco/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Confidential computing related collateral
+#
+source "drivers/virt/coco/efi_secret/Kconfig"
+
+source "drivers/virt/coco/sev-guest/Kconfig"
+
+source "drivers/virt/coco/tdx-guest/Kconfig"
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
new file mode 100644
index 000000000000..55302ef719ad
--- /dev/null
+++ b/drivers/virt/coco/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Confidential computing related collateral
+#
+obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
+obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/

