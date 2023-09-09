Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198387997E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345600AbjIIMTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjIIMTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:19:15 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB890CCA;
        Sat,  9 Sep 2023 05:19:10 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="179248591"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Sep 2023 21:19:09 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id F0EC241EBFFC;
        Sat,  9 Sep 2023 21:19:07 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/4] Match data improvements for mcp23s08 driver
Date:   Sat,  9 Sep 2023 13:18:59 +0100
Message-Id: <20230909121903.34062-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for mcp23s08 driver.
This patch series is only compile tested.

v1->v2:
 * Arranged variable declaration in reverse xmas tree for patch#1.
 * Updated commit description for patch#2.
 * Dropped printing 'type' in error path for i2c_get_match_data().
 * Added similar simplification for SPI driver.
Biju Das (4):
  pinctrl: mcp23s08_i2c: Extend match support for OF tables
  pinctrl: mcp23s08_i2c: Simplify probe()
  pinctrl: mcp23s08_spi: Simplify probe()
  pinctrl: mcp23s08_spi: Simplify mcp23s08_spi_regmap_init()

 drivers/pinctrl/pinctrl-mcp23s08_i2c.c | 101 ++++++++++++-------------
 drivers/pinctrl/pinctrl-mcp23s08_spi.c | 101 +++++++++++++------------
 2 files changed, 100 insertions(+), 102 deletions(-)

-- 
2.25.1

