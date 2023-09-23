Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40B7AC42E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjIWRtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjIWRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:49:40 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68D12127
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:49:34 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,171,1694703600"; 
   d="scan'208";a="176997667"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Sep 2023 02:49:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.12])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E807D40061B8;
        Sun, 24 Sep 2023 02:49:30 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/4] Simplify obtaining I2C match data
Date:   Sat, 23 Sep 2023 18:49:24 +0100
Message-Id: <20230923174928.56824-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to simplify obtaining I2C match data.

This patch series is only compile tested.

v4:
 * Added as a series
 * Updated commit header for all patches
 * Updated commit description for patch#1.


Biju Das (4):
  mfd: arizona-i2c: Simplify obtaining I2C match data
  mfd: madera-i2c: Simplify obtaining I2C match data
  mfd: max77541: Simplify obtaining I2C match data
  mfd: max8998: Simplify obtaining I2C match data and drop
    max8998_i2c_get_driver_data()

 drivers/mfd/arizona-i2c.c | 11 ++---------
 drivers/mfd/madera-i2c.c  |  9 +--------
 drivers/mfd/max77541.c    |  6 +-----
 drivers/mfd/max8998.c     | 12 +-----------
 4 files changed, 5 insertions(+), 33 deletions(-)

-- 
2.25.1

