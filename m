Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34FC7FD8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjK2OHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjK2OHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:07:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9CCB5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701266838; x=1732802838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ryc//f0Tr8NZrn+ndoBq8HJgd/JE509ZE3xh0cOmymI=;
  b=n/WOHGmfEIyQXZu+q0hyIYXz3qqFDfOnqV/WFpii3FJz7BwHmAWrj0Im
   0IUYhhGMRSKUa/pdsSaDvlSJ9fnO1NTT6RU+1EHQOBVwB0uvrpkMNrlFd
   Ja6LDvX7FNfgP7wSL0zjsZM9YWXJ/fb583uVqStoLbNKPrbKCj+UGm60x
   qMJZIPGibyrZyen42PCLrT7q/ZDlfPvorrQKyqJ1Rk19aIRAHYY0AdMQx
   5iRBKkXTLmo/qzoWvKZB+7HqOXzKQKEsnCEy7L8JdwH8n1McRpiP0veM4
   XOOgrQ7xlJ7/9WRufBbY+9LEi17gGh4mP37vahSqSZ730HN/Hh42Rb5Px
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="152632"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="152632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:07:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="912865021"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="912865021"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2023 06:07:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 607DF4D4; Wed, 29 Nov 2023 16:01:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/i915/display: Don't use "proxy" headers
Date:   Wed, 29 Nov 2023 16:01:28 +0200
Message-ID: <20231129140129.699767-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses math.h and not util_macros.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_snps_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_snps_phy.c b/drivers/gpu/drm/i915/display/intel_snps_phy.c
index ce5a73a4cc89..bc61e736f9b3 100644
--- a/drivers/gpu/drm/i915/display/intel_snps_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_snps_phy.c
@@ -3,7 +3,7 @@
  * Copyright © 2019 Intel Corporation
  */
 
-#include <linux/util_macros.h>
+#include <linux/math.h>
 
 #include "i915_reg.h"
 #include "intel_ddi.h"
-- 
2.43.0.rc1.1.gbec44491f096

