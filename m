Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3371778F386
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345922AbjHaTqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjHaTqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:46:32 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D706E70
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:46:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="178339736"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2023 04:46:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id CE35B40062C9;
        Fri,  1 Sep 2023 04:46:24 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/3] Match data improvements for tlv320aic32x4 driver
Date:   Thu, 31 Aug 2023 20:46:19 +0100
Message-Id: <20230831194622.87653-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for tlv320aic32x4
driver.

This patch series is only compile tested.

v2->v3:
 * Added Rb tag from Andy for patch#1 and patch#2
 * Simplified aic32x4_spi_probe() in patch#3.
v1->v2:
 * Created patch#1 for adding enum aic32x4_type to aic32x4_probe() and
   drop using dev_set_drvdata() from tlv320aic32x4_{i2c,spi} drivers.
 * Return value of i2c_get_match_data() passed to type paramemter in
   aic32x4_probe().

Biju Das (3):
  ASoC: codec: tlv320aic32x4: Add enum aic32x4_type to aic32x4_probe()
  ASoC: tlv320aic32x4-i2c: Simplify probe()
  ASoC: tlv320aic32x4-spi: Simplify probe()

 sound/soc/codecs/tlv320aic32x4-i2c.c | 19 +++----------------
 sound/soc/codecs/tlv320aic32x4-spi.c | 18 +++---------------
 sound/soc/codecs/tlv320aic32x4.c     |  5 +++--
 sound/soc/codecs/tlv320aic32x4.h     |  3 ++-
 4 files changed, 11 insertions(+), 34 deletions(-)

-- 
2.25.1

