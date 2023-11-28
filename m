Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0447FC170
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346219AbjK1Rua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbjK1Ru1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:50:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F008DC;
        Tue, 28 Nov 2023 09:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701193834; x=1732729834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FHQ7x5YlyO03fAtFmbz0hZlnhaEwXt8ecRdrQKklMuw=;
  b=EbnNwH/XsmAQUFrBIPW5kc8LTTxAJO3intXbKWOu5Qd6lXuqyE2IWJ4l
   zR+cLxFkKl7ClD1Ut1tMT0Xc1y0eeR2cpXWx2YmRHfLqeReJsqcU/r++S
   bo22+X9/dfqFL7I2xqbdsc6HNgbflxrCoWxZVU+ElH1dlHd44HTzwou5B
   y0XhUw5I/ARyTy+ERkisty1IR3+1P50B3iJAaq9iCTkAMu43cGeH/UIE9
   tAzhK/w4JnWtEsHUfV3Q9kePjK+UysgSk6uM6Oz0hiGKgeSHT/13nLY0P
   8OKlSpt/75BhwXqBbB34IO/MXznVb4SFyoD6J25oPWLimo/Z2phI559ej
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372352359"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372352359"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="744972833"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="744972833"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2023 09:50:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E33F723E; Tue, 28 Nov 2023 19:50:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] net: dsa: sja1105: Use units.h instead of the copy of a definition
Date:   Tue, 28 Nov 2023 19:50:27 +0200
Message-ID: <20231128175027.394754-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BYTES_PER_KBIT is defined in units.h, use that definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 74cee39d73df..6646f7fb0f90 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -21,6 +21,8 @@
 #include <linux/if_bridge.h>
 #include <linux/if_ether.h>
 #include <linux/dsa/8021q.h>
+#include <linux/units.h>
+
 #include "sja1105.h"
 #include "sja1105_tas.h"
 
@@ -2138,7 +2140,6 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
 	sja1105_bridge_member(ds, port, bridge, false);
 }
 
-#define BYTES_PER_KBIT (1000LL / 8)
 /* Port 0 (the uC port) does not have CBS shapers */
 #define SJA1110_FIXED_CBS(port, prio) ((((port) - 1) * SJA1105_NUM_TC) + (prio))
 
-- 
2.43.0.rc1.1.gbec44491f096

