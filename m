Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAAC7AC3E8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjIWRTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIWRTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:19:34 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B06EAF;
        Sat, 23 Sep 2023 10:19:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,171,1694703600"; 
   d="scan'208";a="180729404"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Sep 2023 02:19:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.12])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 681A64005641;
        Sun, 24 Sep 2023 02:19:25 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] Match data improvements for pca955x driver
Date:   Sat, 23 Sep 2023 18:19:19 +0100
Message-Id: <20230923171921.53503-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for pca955x driver.

This patch series is only compile tested.

v1->v2:
 * Added Rb tag from Lee Jones for patch#1.
 * Adeed patch#2 for cleanup of OF/ID table terminators.

Biju Das (2):
  leds: pca955x: Convert enum->pointer for data in the match tables
  leds: pca955x: Cleanup OF/ID table terminators

 drivers/leds/leds-pca955x.c | 69 +++++++++++++++----------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

-- 
2.25.1

