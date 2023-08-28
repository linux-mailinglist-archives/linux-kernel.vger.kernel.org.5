Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8154C78B7E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjH1TKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjH1TK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:10:28 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA7A3102
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:10:21 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,208,1688396400"; 
   d="scan'208";a="174239889"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2023 04:10:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id BF1E94054C86;
        Tue, 29 Aug 2023 04:10:17 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] Match data improvements for tlv320aic32x4 driver
Date:   Mon, 28 Aug 2023 20:10:12 +0100
Message-Id: <20230828191014.138310-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for tlv320aic32x4
driver.

This patch series is only compile tested.

v1->v2:
 * Created patch#1 for adding enum aic32x4_type to aic32x4_probe() and
   drop using dev_set_drvdata() from tlv320aic32x4_{i2c,spi} drivers.
 * Return value of i2c_get_match_data() passed to type paramemter in
   aic32x4_probe().

Biju Das (2):
  ASoC: codec: tlv320aic32x4: Add enum aic32x4_type to aic32x4_probe()
  ASoC: tlv320aic32x4-i2c: Simplify probe()

 sound/soc/codecs/tlv320aic32x4-i2c.c | 19 +++----------------
 sound/soc/codecs/tlv320aic32x4-spi.c |  7 ++++---
 sound/soc/codecs/tlv320aic32x4.c     |  5 +++--
 sound/soc/codecs/tlv320aic32x4.h     |  3 ++-
 4 files changed, 12 insertions(+), 22 deletions(-)

-- 
2.25.1

