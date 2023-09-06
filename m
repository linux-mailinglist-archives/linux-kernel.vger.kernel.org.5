Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D145E7942C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbjIFSIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIFSIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:08:48 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAD8510F7;
        Wed,  6 Sep 2023 11:08:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,232,1688396400"; 
   d="scan'208";a="178945657"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Sep 2023 03:08:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.21])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9F0DB404A6D7;
        Thu,  7 Sep 2023 03:08:40 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 0/2] Enhancements for tmp513 driver
Date:   Wed,  6 Sep 2023 19:08:35 +0100
Message-Id: <20230906180837.284743-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add enhancements for tmp51x driver.
 * patch#1 Adds max_channels variable to struct tmp51x_data for HW
           differences.
 * Patch#2 Simplify tmp51x_read_properties()

This patch series is only compile tested.

v4->v5:
 * Updated the TMP51X_TEMP_CHANNEL_MASK macro.
 * Updated the indentation for TMP51X_TEMP_CONFIG_DEFAULT macro.
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

 drivers/hwmon/tmp513.c | 53 +++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

-- 
2.25.1

