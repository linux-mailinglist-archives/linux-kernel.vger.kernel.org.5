Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A72790B4B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjICJBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjICJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 05:01:02 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36A3B125;
        Sun,  3 Sep 2023 02:00:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="174837511"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2023 18:00:57 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 75E364189A8B;
        Sun,  3 Sep 2023 18:00:54 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] Match data improvements for adxl345 driver
Date:   Sun,  3 Sep 2023 10:00:49 +0100
Message-Id: <20230903090051.39274-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for adxl345 driver.

This patch series is only compile tested.

v2->v3:
 * Replaced struct adxl3x5_chip_info->struct adxl345_chip_info
 * Simplified adxl345_read_raw()
 * Dropped enum adxl345_device_type as there is no user
v1->v2:
 * Replaced EINVAL->ENODEV for invalid chip type.
 * Kept leading commas for adxl345_*_info and adxl375_*_info.
 * Restored switch statement in adxl345_core_probe()

Biju Das (2):
  iio: accel: adxl345: Convert enum->pointer for data in match data
    table
  iio: accel: adxl345: Simplify adxl345_read_raw()

 drivers/iio/accel/adxl345.h      | 21 ++++++++++++--
 drivers/iio/accel/adxl345_core.c | 47 ++++----------------------------
 drivers/iio/accel/adxl345_i2c.c  | 20 ++++++++++----
 drivers/iio/accel/adxl345_spi.c  | 20 ++++++++++----
 4 files changed, 54 insertions(+), 54 deletions(-)

-- 
2.25.1

