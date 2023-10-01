Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049717B483F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjJAPB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjJAPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:01:24 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20FC6D9;
        Sun,  1 Oct 2023 08:01:21 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,191,1694703600"; 
   d="scan'208";a="181547657"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Oct 2023 00:01:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.25])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1A73E420633E;
        Mon,  2 Oct 2023 00:01:17 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/3] atch data improvements for mcp23s08 driver
Date:   Sun,  1 Oct 2023 16:01:10 +0100
Message-Id: <20231001150113.7752-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to add match data improvements for mcp23s08 driver.
This patch series is only compile tested.

v3->v4:
 * Added Rb tag from Andy for patch#3
 * Removed duplicate mcp23s08 in the name of variables for
   struct mcp23s08_info.
v2->v3:
 * Reordered patch#3->patch#2
 * Added Rb tag from Andy for patch#1 and #2.
 * Added struct mcp23s08_info in pinctrl-mcp23s08.h and both i2c and spi
   drivers using same match data structure.
v1->v2:
 * Arranged variable declaration in reverse xmas tree for patch#1.
 * Updated commit description for patch#2.
 * Dropped printing 'type' in error path for i2c_get_match_data().
 * Added similar simplification for SPI driver.

Biju Das (3):
  pinctrl: mcp23s08_i2c: Extend match support for OF tables
  pinctrl: mcp23s08_spi: Simplify probe()
  pinctrl: mcp23s08: Simplify probe()/mcp23s08_spi_regmap_init()

 drivers/pinctrl/pinctrl-mcp23s08.h     |  8 +++
 drivers/pinctrl/pinctrl-mcp23s08_i2c.c | 93 +++++++++++-------------
 drivers/pinctrl/pinctrl-mcp23s08_spi.c | 97 ++++++++++++--------------
 3 files changed, 95 insertions(+), 103 deletions(-)

-- 
2.25.1

