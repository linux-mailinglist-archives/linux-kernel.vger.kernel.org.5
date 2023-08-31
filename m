Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F4C78F0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346684AbjHaQFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjHaQFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:05:14 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6786F1A3;
        Thu, 31 Aug 2023 09:05:11 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="174621086"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 01:05:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 514684018907;
        Fri,  1 Sep 2023 01:05:08 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/5] usb: typec: tcpci_rt1711h: Make similar OF and ID table
Date:   Thu, 31 Aug 2023 17:04:57 +0100
Message-Id: <20230831160501.55081-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
References: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make similar OF and ID table to extend support for ID match
using i2c_match_data() later. Currently it works only for OF match
tables as the driver_data is wrong for ID match.

While at it, drop a space from the terminator braces for ID table and
remove trailing comma in the terminator entry for OF table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Drop space from ID table
 * Remove trailing comma in the terminator entry for OF table.
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 17ebc5fb684f..5ed3d0864431 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -392,9 +392,9 @@ static void rt1711h_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id rt1711h_id[] = {
-	{ "rt1711h", 0 },
-	{ "rt1715", 0 },
-	{ }
+	{ "rt1711h", RT1711H_DID },
+	{ "rt1715", RT1715_DID },
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

