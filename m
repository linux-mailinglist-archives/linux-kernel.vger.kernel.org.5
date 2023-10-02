Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E717B5401
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbjJBNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbjJBNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:32:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367B91;
        Mon,  2 Oct 2023 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696253550; x=1727789550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lDAqfAvJkp0xhbjXWLoPesIG5pkXB+BnJ5EhDi7GpC0=;
  b=D3/3IJgKV6Xb9p62TCYIQoq/m/4N2FS94/KuTkm2VDhN6S7wlu7tFBxk
   nVAnAqZpWM/bTMU+ADlgyBELw2esObPDDl1GnuwdodZemfIciGsLp2rsx
   Dwrw952k/iDApSLvKgrPdgEbmnfl43rKfUklUrNJObAfix9vp/hhdJmyv
   ekK+NAMtnT0sp2FgiVajAcd8bQfEVQCpXW5ZSVQF5C4dqkcDMyjWAm0Ws
   tN2+GbfwGmjlgre3Ci/s6RygUlt2vD+I+1s+D4gwQEiqv5FRiCKxeMAVJ
   Cq/5Qg+ryh+d9Ux6jOvSHQBfA3wkmBB35vaDVgJtKU/Z6I0nPCfBmzYAC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="379923408"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="379923408"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754048986"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754048986"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Oct 2023 06:26:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2F42B1A7; Mon,  2 Oct 2023 16:26:41 +0300 (EEST)
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
Subject: [PATCH v2 2/2] amba: bus: Enable compile testing
Date:   Mon,  2 Oct 2023 16:26:35 +0300
Message-Id: <20231002132635.2595382-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231002132635.2595382-1-andriy.shevchenko@linux.intel.com>
References: <20231002132635.2595382-1-andriy.shevchenko@linux.intel.com>
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

v2: new patch to make it easier to compile test on non-ARM

 drivers/amba/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
index fb6c7e0b4cce..9ff4638550c8 100644
--- a/drivers/amba/Kconfig
+++ b/drivers/amba/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config ARM_AMBA
-	bool
+	bool "AMBA bus support" || if COMPILE_TEST
 
 if ARM_AMBA
 
-- 
2.40.0.1.gaa8946217a0b

