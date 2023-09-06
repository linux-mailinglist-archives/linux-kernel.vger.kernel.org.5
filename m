Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22B7936D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjIFIGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjIFIGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:06:31 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 811CCCF2;
        Wed,  6 Sep 2023 01:06:27 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,231,1688396400"; 
   d="scan'208";a="175191011"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Sep 2023 17:06:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.21])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C8F2541D148E;
        Wed,  6 Sep 2023 17:06:24 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/5] usb: typec: tcpci_rt1711h: Remove trailing comma in the terminator entry for OF table
Date:   Wed,  6 Sep 2023 09:06:15 +0100
Message-Id: <20230906080619.36930-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906080619.36930-1-biju.das.jz@bp.renesas.com>
References: <20230906080619.36930-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove trailing comma in the terminator entry for OF table.
While at it, drop a space in the terminator for ID table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2->v3:
 * Dropped updating I2C driver data in ID table as there is no user yet.
 * Updated commit header and description.
 * Added Rb tag from Andy.
 * Retained the Rb tag as it is trivial change.
v1->v2:
 * Drop space from ID table
 * Remove trailing comma in the terminator entry for OF table.
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 17ebc5fb684f..6146bca8e55f 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -394,7 +394,7 @@ static void rt1711h_remove(struct i2c_client *client)
 static const struct i2c_device_id rt1711h_id[] = {
 	{ "rt1711h", 0 },
 	{ "rt1715", 0 },
-	{ }
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, rt1711h_id);
 
@@ -402,7 +402,7 @@ MODULE_DEVICE_TABLE(i2c, rt1711h_id);
 static const struct of_device_id rt1711h_of_match[] = {
 	{ .compatible = "richtek,rt1711h", .data = (void *)RT1711H_DID },
 	{ .compatible = "richtek,rt1715", .data = (void *)RT1715_DID },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, rt1711h_of_match);
 #endif
-- 
2.25.1

