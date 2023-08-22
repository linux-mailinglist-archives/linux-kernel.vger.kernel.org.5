Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B04784401
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjHVOZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjHVOZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:25:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A10CE2;
        Tue, 22 Aug 2023 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692714321; x=1724250321;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yu74ytHANZt6e25HkizTMBfLvxrlpIvD6YSjq1JsaNk=;
  b=Zmmt+36VOrgED+r8naiNUW0U88fSFarcuMUJduZPJ+tyZQiZXBxhZgbM
   y5QP6C33+ycwH2ss49CNqzTro+ctDYmnwQWMTaGCA7okVnj3OMKii284d
   Si+W9juRZkkIi/Qd5FVFtIIz30tiopwFylqaruDAH/pzSgYfWxyiK8sHR
   IHUyp0x0Lk5yyj01RN4jDBLMDVROoJudx1D7u3CY4WZbsZz+qzM2iwQbB
   roglW4F2tsS8FPmbpjzIo92lzNbtQ0VCz3sZv/+55R1EqqVsD+XnkrRX/
   /efGtCGEob5T6uRoaBdqksJKcwtMEDRWgOXhDVkIj7jHGHywq3giJ5MiA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358881185"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="358881185"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 07:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879973303"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2023 07:25:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB8292FF; Tue, 22 Aug 2023 17:25:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: p2sb: Make the Kconfig symbol hidden
Date:   Tue, 22 Aug 2023 17:25:14 +0300
Message-Id: <20230822142514.2140897-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The P2SB is used purely as a library and all users must select it with

	depends on PCI
	select P2SB if X86

statement. Without this the combination of different configuration
options may lead to build failures.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 228fadb1c037..06b9a5ae5a63 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1102,7 +1102,7 @@ config SEL3350_PLATFORM
 endif # X86_PLATFORM_DEVICES
 
 config P2SB
-	bool "Primary to Sideband (P2SB) bridge access support"
+	bool
 	depends on PCI && X86
 	help
 	  The Primary to Sideband (P2SB) bridge is an interface to some
-- 
2.40.0.1.gaa8946217a0b

