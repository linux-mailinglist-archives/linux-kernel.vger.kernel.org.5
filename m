Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27B278F43F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347446AbjHaUru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjHaUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:47:47 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9212B1B0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:47:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="174635226"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 05:47:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E3E31402951B;
        Fri,  1 Sep 2023 05:47:36 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] Match data improvements for ak4642 driver
Date:   Thu, 31 Aug 2023 21:47:32 +0100
Message-Id: <20230831204734.104954-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for ak4642 driver.

This patch series is only compile tested.

v2->v3:
 * Patch#1 for cleanups and patch#2 for simplifying probe()
 * Replace local variable np with dev_fwnode()
 * Replace dev_err()->dev_err_probe().
 * Remove comma in the terminator entry for OF table.
 * Drop a space in the terminator entry for ID table.
v1->v2:
 * Removed forward declaration ak4642_of_match and ak4642_i2c_id.
 * Restored error EINVAL.
 * Used dev_fwnode() and replaced dev->of_node.
 * Removed comma in the terminator entry.

Biju Das (2):
  ASoC: ak4642: Minor cleanups in probe()
  ASoC: ak4642: Simplify probe()

 sound/soc/codecs/ak4642.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

-- 
2.25.1

