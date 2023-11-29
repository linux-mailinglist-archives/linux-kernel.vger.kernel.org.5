Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEB87FD24A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjK2JUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjK2JUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:20:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F45519BF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701249629; x=1732785629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a1rYQiHGZsIUcK5/vM/XlrHBMt2GUYE8SYbXj2P57e0=;
  b=RhRODFWG9O8NmK6ll1uHq/dnuTh4z1HjfJVOa8ghGtFoUn4zD+Xy+xAI
   iBvv0ojRms3U9LTDqi9EFgr4rLW1qFLLu4Xfgbet4G74BWNCW1qrZO511
   g+FfCKHAxeeCzNFFilbT0J047ZOt2TZMt5qiDKuEhC9mCkxtTiQjTfeHd
   w2tE76JCS0k4O2xZBoWbWQHRnP0UresgMT2rGC9IYA/3+I9R7fhb/yriQ
   5EkX6kTt2U18OfL0VvURDLewSj0HxDNcHk7p4ehhSqFassmizZfliGsFz
   v19TU/SRzyuomX2x87RffKyx5vgmE90nSJg4wOBBxRVtz29ddQbufox3y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="395949163"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="395949163"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 01:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797855086"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="797855086"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 01:18:07 -0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: fix variants path
Date:   Wed, 29 Nov 2023 17:13:37 +0800
Message-Id: <20231129091337.2084747-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The directory in the path should be "variants" instead of "variant".

Fixes: 420ae9518404 ("xtensa: simplify addition of new core variants")
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 arch/xtensa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7d792077e5fd..a9ed6ec3a75e 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -144,7 +144,7 @@ config XTENSA_VARIANT_CUSTOM_NAME
 	depends on XTENSA_VARIANT_CUSTOM
 	help
 	  Provide the name of a custom Xtensa processor variant.
-	  This CORENAME selects arch/xtensa/variant/CORENAME.
+	  This CORENAME selects arch/xtensa/variants/CORENAME.
 	  Don't forget you have to select MMU if you have one.
 
 config XTENSA_VARIANT_NAME
-- 
2.34.1

