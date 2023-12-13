Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEB6810B17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjLMHLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjLMHLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:11:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6B0D0;
        Tue, 12 Dec 2023 23:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702451508; x=1733987508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6PgbnsP5OlwWC7MeRXRAc2NRStgzMWs90zB3eGbJZU=;
  b=JdGd8sy9RCXz7ZIm/vdr6cdjQvL9HZWm3fp7I31iJUWaBo2mVnZ/gFcK
   zstQVgPcCaReiDlnRzsyCuvH3N4rgb2+EbYho4rQBM1bs7NLHq+meXl7Q
   oyCwSeRVpqXUAfWqicAlOWLuEtrerJfF5Gdp4SmWPmSn2VahpintuST/x
   ep6FGguYld998iQXqN3/mrP0Keg5JPrgy7nsXhAM9OlLwEiRrdjuhmybG
   FpWsiZOAzjmtocuy3/aGkBQm1F4PlAffZ06UZi/6DHLpzpkPq8HawJa3Q
   /symCT0c/KyGSk1QqxsTN5+AAs/ctzsMowbwXw3WYWFgDJrmBJcCvke6f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481126159"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="481126159"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="767109308"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="767109308"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2023 23:11:43 -0800
From:   <deepakx.nagaraju@intel.com>
To:     joyce.ooi@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Nagaraju DeepakX <deepakx.nagaraju@intel.com>,
        Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: [PATCH 4/5] net: ethernet: altera: sorting headers in alphabetical order
Date:   Wed, 13 Dec 2023 15:11:11 +0800
Message-Id: <20231213071112.18242-5-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>

Re-arrange the headers in alphabetical order and add empty lines
in between of groups of headers for easier maintenance.

Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>
---
 drivers/net/ethernet/altera/altera_msgdma.c   | 7 ++++---
 drivers/net/ethernet/altera/altera_sgdma.c    | 7 ++++---
 drivers/net/ethernet/altera/altera_tse_main.c | 7 ++++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_msgdma.c b/drivers/net/ethernet/altera/altera_msgdma.c
index ac1efd08267a..9581c05a5449 100644
--- a/drivers/net/ethernet/altera/altera_msgdma.c
+++ b/drivers/net/ethernet/altera/altera_msgdma.c
@@ -4,10 +4,11 @@
  */

 #include <linux/netdevice.h>
-#include "altera_utils.h"
-#include "altera_tse.h"
-#include "altera_msgdmahw.h"
+
 #include "altera_msgdma.h"
+#include "altera_msgdmahw.h"
+#include "altera_tse.h"
+#include "altera_utils.h"

 /* No initialization work to do for MSGDMA */
 int msgdma_initialize(struct altera_tse_private *priv)
diff --git a/drivers/net/ethernet/altera/altera_sgdma.c b/drivers/net/ethernet/altera/altera_sgdma.c
index d4edfb3e09e8..f6c9904c88d0 100644
--- a/drivers/net/ethernet/altera/altera_sgdma.c
+++ b/drivers/net/ethernet/altera/altera_sgdma.c
@@ -4,10 +4,11 @@
  */

 #include <linux/list.h>
-#include "altera_utils.h"
-#include "altera_tse.h"
-#include "altera_sgdmahw.h"
+
 #include "altera_sgdma.h"
+#include "altera_sgdmahw.h"
+#include "altera_tse.h"
+#include "altera_utils.h"

 static void sgdma_setup_descrip(struct sgdma_descrip __iomem *desc,
 				struct sgdma_descrip __iomem *ndesc,
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 6a1a004ea693..f98810eac44f 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -38,12 +38,13 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/skbuff.h>
+
 #include <asm/cacheflush.h>

-#include "altera_utils.h"
-#include "altera_tse.h"
-#include "altera_sgdma.h"
 #include "altera_msgdma.h"
+#include "altera_sgdma.h"
+#include "altera_tse.h"
+#include "altera_utils.h"

 static atomic_t instance_count = ATOMIC_INIT(~0);
 /* Module parameters */
--
2.26.2

