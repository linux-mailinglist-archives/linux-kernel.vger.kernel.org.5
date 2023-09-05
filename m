Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309AE792E02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjIES4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjIES4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:56:41 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E48441BB;
        Tue,  5 Sep 2023 11:56:10 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,229,1688396400"; 
   d="scan'208";a="175109479"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Sep 2023 03:42:57 +0900
Received: from localhost.localdomain (unknown [10.226.92.194])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D7C57400A65B;
        Wed,  6 Sep 2023 03:42:54 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/2] Enhancements for tmp51x driver
Date:   Tue,  5 Sep 2023 19:42:50 +0100
Message-Id: <20230905184252.222742-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to add enhancements for tmp51x driver.
 * patch#1 Adds max_channels variable to struct tmp51x_data for HW
           differences.
 * Patch#2 Simplify tmp51x_read_properties()

This patch series is only compile tested.

v3->v4:
 * Updated commit description for patch#1
 * Updated macros TMP51X_TEMP_CONFIG_DEFAULT and TMP51X_TEMP_CHANNEL_MASK.
 * Removed trailing comma in the terminator entry for OF table.
 * Added Rb tag from Geert and Andy for patch#2.
v2->v3:
 * Dropped patch#1 and patch#2 as it is accepted
 * Split patch#3 into 3.
 * Avoided Yoda style logic in tmp51x_is_visible().
 * Replaced OF/ID data from tmp51x_ids->max_channels
 * Updated the macro TMP51X_TEMP_CONFIG_DEFAULT by adding bit definitions
   for Configuration register 2.
 * Dropped unused macros TMP51{2,3}_TEMP_CONFIG_DEFAULT.
v1->v2:
 * Created 2 new patches. Patch#1 for fixing channel number in
   tmp51x_is_visible() and patch#3 avoids using enum chip id for HW
   differences and improves the code by avoiding checks.

Biju Das (2):
  hwmon: tmp513: Add max_channels variable to struct tmp51x_data
  hwmon: tmp513: Simplify tmp51x_read_properties()

 drivers/hwmon/tmp513.c | 54 +++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

-- 
2.25.1

