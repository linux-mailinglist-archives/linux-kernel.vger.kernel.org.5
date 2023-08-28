Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2478B659
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjH1RYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjH1RYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:24:25 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E94FE115
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:24:22 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,208,1688396400"; 
   d="scan'208";a="174235355"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2023 02:24:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id AE6CC402D0C9;
        Tue, 29 Aug 2023 02:24:20 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] Match dtat improvements for pv880x0 regulator driver
Date:   Mon, 28 Aug 2023 18:24:15 +0100
Message-Id: <20230828172417.113631-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for pv880x0
regulator driver.

This patch is only compile tested.

v1->v2:
 * Moved OF/ID tables close to the user
 * Removed trailing comma in the terminator entry for OF/ID tables.
 * Created patc#2 for dropping CONFIG_OF ifdeffery.

Biju Das (2):
  regulator: pv880x0: Simplify probe()
  regulator: pv880x0: Drop ifdeffery

 drivers/regulator/pv88080-regulator.c | 58 ++++++++-------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

-- 
2.25.1

