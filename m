Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACBE7BBAF6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjJFO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjJFO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:57:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17266A6;
        Fri,  6 Oct 2023 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696604266; x=1728140266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pwbbbgcEIxTYBd2yOIqpmkQsPrsV9eQPsSf0L3T2NTk=;
  b=NTCz/cNVB31ceIYjJDZbdiayHxTba4rhA3Ai5BlWPLjtTLBV44Ob6Zid
   RW77iatlzfSWExIvJDYhpQfQF6FZmSjmNw4oRakTLgziJZO4Dj8sFzIgz
   5FilqeBM0wzTrRV+1bspSqryd5CFl8XCI5fGVRSHOZMWF0MBmMWUVgDz6
   Rz5pQPyELxBRuFxF0gXRpMkZnXPkUEAi88mV0WvWXO3CHBXl/ljNuW1dG
   yx7Zo3j+FKa6wwcu0oYHYLE5jcofiYepewXG7WprOINxTCowqDduWSunT
   OpaLQwHkvsIErCOaUjnYxjKMZd9wbhDUk93QAdNi5/iP8q5aiL48vEdhi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="368840637"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="368840637"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="755880712"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="755880712"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2023 07:57:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AB142430; Fri,  6 Oct 2023 17:57:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 2/2] amba: bus: Enable compile testing
Date:   Fri,  6 Oct 2023 17:57:32 +0300
Message-Id: <20231006145732.3419115-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
References: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
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

There is no architecture specific code in the implementation of
AMBA bus, let's enable compile testing for it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: fixed compilation error (LKP, Rob), amended summary (Rob)
v2: new patch to make it easier to compile test on non-ARM

 drivers/amba/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
index fb6c7e0b4cce..21fa17697b48 100644
--- a/drivers/amba/Kconfig
+++ b/drivers/amba/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config ARM_AMBA
-	bool
+	bool "Arm (AMBA) Primecell Device bus" if COMPILE_TEST
 
 if ARM_AMBA
 
-- 
2.40.0.1.gaa8946217a0b

