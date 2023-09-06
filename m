Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07BB7936D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjIFIGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjIFIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:06:29 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E226CE41;
        Wed,  6 Sep 2023 01:06:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,231,1688396400"; 
   d="scan'208";a="175190998"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Sep 2023 17:06:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.21])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B2B0B41D147A;
        Wed,  6 Sep 2023 17:06:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/5] Match data improvements for rt1711h driver
Date:   Wed,  6 Sep 2023 09:06:14 +0100
Message-Id: <20230906080619.36930-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extend support for retrieving match data for ID lookup
by using i2c_get_match_data().

The first patch is cleanups for OF/ID table and second patch
convert enum->pointer for constification of data and extending match data
support for ID table. The third and fourth patches replaces comparison of
did against hardware differences with data and feature variable. The last
patch drop CONFIG_OF ifdeffery.

This patch series is only compile tested.

v2->v3:
 * Added Rb tag from Andy.
 * Dropped updating I2C driver data in ID table as there is no user yet.
 * Updated commit header and description for patch#1
 * Updated commit description for ACPI with PRP0001 magic for patch#5.
v1->v2:
 * Drop space from ID table
 * Remove trailing comma in the terminator entry for OF table.
 * Updated commit description for patch#2.
 * Swapped the rxdz_sel variable in struct rt1711h_chip_info to avoid
   holes.
 * Changed enable_pd30_extended_message variable type to bool.
 * Added patch for dropping CONFIG_OF ifdeffery for OF table.

Biju Das (5):
  usb: typec: tcpci_rt1711h: Remove trailing comma in the terminator
    entry for OF table
  usb: typec: tcpci_rt1711h: Convert enum->pointer for data in the match
    tables
  usb: typec: tcpci_rt1711h: Add rxdz_sel variable to struct
    rt1711h_chip_info
  usb: typec: tcpci_rt1711h: Add enable_pd30_extended_message variable
    to struct rt1711h_chip_info
  usb: typec: tcpci_rt1711h: Drop CONFIG_OF ifdeffery

 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 46 ++++++++++++++++----------
 1 file changed, 29 insertions(+), 17 deletions(-)

-- 
2.25.1

