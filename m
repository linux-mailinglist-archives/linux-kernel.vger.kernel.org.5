Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF378F0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjHaQFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjHaQFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:05:12 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B81B1A3;
        Thu, 31 Aug 2023 09:05:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="178328413"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2023 01:05:07 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 82EE74018907;
        Fri,  1 Sep 2023 01:05:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] Match data improvements for rt1711h driver
Date:   Thu, 31 Aug 2023 17:04:56 +0100
Message-Id: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
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

The first patch fixes the driver_data for ID table and second patch
convert enum->pointer for constification of data and extending match data
support for ID table. The third and fourth patches replaces comparison of
did against hardware differences with data and feature variable. The last
patch drop CONFIG_OF ifdeffery.

This patch series is only compile tested.

v1->v2:
 * Drop space from ID table
 * Remove trailing comma in the terminator entry for OF table.
 * Updated commit description for patch#2.
 * Swapped the rxdz_sel variable in struct rt1711h_chip_info to avoid
   holes.
 * Changed enable_pd30_extended_message variable type to bool.
 * Added patch for dropping CONFIG_OF ifdeffery for OF table.

Biju Das (5):
  usb: typec: tcpci_rt1711h: Make similar OF and ID table
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

