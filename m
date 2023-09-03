Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B22B790BBF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjICLz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjICLz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:55:58 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2077E11D;
        Sun,  3 Sep 2023 04:55:55 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="174842999"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2023 20:55:54 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id AFB1D41C2D8A;
        Sun,  3 Sep 2023 20:55:51 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/4] Match data improvements for mcp4725 driver
Date:   Sun,  3 Sep 2023 12:55:44 +0100
Message-Id: <20230903115548.59306-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for mcp4725 driver.

This patch series is only compile tested.

v2->v3:
 * Added struct mcp4725_chip_info with chan_spec and chip_id variable and
   used that as OF/ID table match data.
 * Added variables use_ext_ref_voltage and dac_reg_offset to struct
   mcp4725_chip_info to handle hw differences between mcp4725 and
   mcp4726.
v1->v2:
 * Update commit description with reason for change.

Biju Das (4):
  iio: dac: mcp4725: Replace variable 'id' from struct mcp4725_data
  iio: dac: mcp4725: Use i2c_get_match_data()
  iio: dac: mcp4725: Add use_ext_ref_voltage to struct mcp4725_chip_info
  iio: dac: mcp4725: Add dac_reg_offset to struct mcp4725_chip_info

 drivers/iio/dac/mcp4725.c | 42 ++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 14 deletions(-)

-- 
2.25.1

