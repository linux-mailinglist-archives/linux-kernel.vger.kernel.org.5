Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B20779069
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjHKNJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjHKNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:09:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8444A1;
        Fri, 11 Aug 2023 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759329; x=1723295329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jri9PQq8QGMkaA/nC2If/vjybGCLJgqagekcG6/jnMo=;
  b=n+D3DPnguTv6HSuLvxgl9oeIAmcGAKixG5JkjituLmsksg4rsrm4T1no
   WdhdByA0a6EexQEBWu8VJnq3sw9sjJDM58uJxz54H+1P1bn9OU8+hOvm6
   syf41PaxeuZ+zlo5i39FiBbFF1IvuVZkbRRHQPUffTUGl4QoMtCVC33Aw
   /QNLjq0uaDVH5OUui+wz4raHoAS4NghrkTPsATiAIR0RlxrDvN+hXFoRC
   VQrYHgDJNVKRlnKPbLIGE+YlV1XX16giXQfF3c5NLV4ThxdcWbG6Tiueq
   2xG6IEIr1d1P1CpbE1aj1gfmGe0JVytFbMFbKBczymJ9w4W9gbY83+aZq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356634825"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="356634825"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="762192242"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="762192242"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2023 06:08:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D0FE81D9; Fri, 11 Aug 2023 16:13:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86/amd/pmf: Use str_on_off() helper
Date:   Fri, 11 Aug 2023 16:13:30 +0300
Message-Id: <20230811131330.71263-1-andriy.shevchenko@linux.intel.com>
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

We have a common helper to represent a boolean value as "on"/"off"
string. Use it for the sake of the unified style.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/amd/pmf/cnqf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
index 539b186e9027..bc8899e15c91 100644
--- a/drivers/platform/x86/amd/pmf/cnqf.c
+++ b/drivers/platform/x86/amd/pmf/cnqf.c
@@ -8,6 +8,7 @@
  * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
  */
 
+#include <linux/string_choices.h>
 #include <linux/workqueue.h>
 #include "pmf.h"
 
@@ -399,7 +400,7 @@ static ssize_t cnqf_enable_store(struct device *dev,
 			amd_pmf_set_sps_power_limits(pdev);
 	}
 
-	dev_dbg(pdev->dev, "Received CnQF %s\n", input ? "on" : "off");
+	dev_dbg(pdev->dev, "Received CnQF %s\n", str_on_off(input));
 	return count;
 }
 
@@ -409,7 +410,7 @@ static ssize_t cnqf_enable_show(struct device *dev,
 {
 	struct amd_pmf_dev *pdev = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%s\n", pdev->cnqf_enabled ? "on" : "off");
+	return sysfs_emit(buf, "%s\n", str_on_off(pdev->cnqf_enabled));
 }
 
 static DEVICE_ATTR_RW(cnqf_enable);
-- 
2.40.0.1.gaa8946217a0b

