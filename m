Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22178DBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbjH3Skg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbjH3RIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:08:47 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E7A219A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:08:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,214,1688396400"; 
   d="scan'208";a="174495934"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Aug 2023 02:08:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id EF12C4000925;
        Thu, 31 Aug 2023 02:08:38 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Zhu Wang <wangzhu9@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 3/3] drm/bridge/analogix/anx78xx: Drop conditionals around of_node pointers
Date:   Wed, 30 Aug 2023 18:08:19 +0100
Message-Id: <20230830170819.309269-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830170819.309269-1-biju.das.jz@bp.renesas.com>
References: <20230830170819.309269-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having conditional around the of_node pointers turns out to make driver
code use ugly #ifdef and #if blocks. So drop the conditionals.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5:
 * Split from patch#2
---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index 6169db73d2fe..ad8241758896 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -1231,9 +1231,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client)
 
 	mutex_init(&anx78xx->lock);
 
-#if IS_ENABLED(CONFIG_OF)
 	anx78xx->bridge.of_node = client->dev.of_node;
-#endif
 
 	anx78xx->client = client;
 	i2c_set_clientdata(client, anx78xx);
-- 
2.25.1

