Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9143790CF0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245584AbjICQsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjICQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 12:48:42 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B324494
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 09:48:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="178560455"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Sep 2023 01:48:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7ECB5402309A;
        Mon,  4 Sep 2023 01:48:35 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] Match data improvements for pv880x0 regulator driver
Date:   Sun,  3 Sep 2023 17:48:30 +0100
Message-Id: <20230903164832.83077-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for pv880x0
regulator driver.

This patch is only compile tested.

v2->v3:
 * Swapped the patch#1 and patch#2
 * Removed trailing comma in the terminator entry for OF/ID table.
 * Updated commit description of patch#1
 * Restored OF table position in patch#1 and moved OF tables close to the
   user in patch#2.
 * Dropped extra space from OF table entry.
v1->v2:
 * Moved OF/ID tables close to the user
 * Removed trailing comma in the terminator entry for OF/ID tables.
 * Created patch#2 for dropping CONFIG_OF ifdeffery.

Biju Das (2):
  regulator: pv880x0: Drop ifdeffery
  regulator: pv880x0: Simplify probe()

 drivers/regulator/pv88080-regulator.c | 58 ++++++++-------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

-- 
2.25.1

