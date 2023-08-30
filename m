Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2DF78E010
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbjH3TPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbjH3RIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:08:32 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 966BC19A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:08:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,214,1688396400"; 
   d="scan'208";a="174495925"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Aug 2023 02:08:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3874B4005B33;
        Thu, 31 Aug 2023 02:08:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
Subject: [PATCH v5 0/3] Drop ID table and conditionals around of_node pointers for anx78xx driver
Date:   Wed, 30 Aug 2023 18:08:16 +0100
Message-Id: <20230830170819.309269-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to drop ID table and conditionals around of_node pointers for anx78xx driver.

While at it, drop conditionals from drm_bridge.h.

v4->v5:
 * Added Rb tag from Andy and Helen for patch#1.
 * Split patch#2 into two
 * Added struct device_node forward declaration for patch#2.
 * Updated commit description for patch#2
v3->v4:
 * Created patch#2 for dropping conditionals around of_node pointers.
 * Added Rb tag from Laurent and Douglas Anderson for patch#1.
v2->v3:
 * Updated commit header.
v1->v2:
 * Dropped ID table support.

Biju Das (3):
  drm/bridge/analogix/anx78xx: Drop ID table
  drm/bridge: Drop conditionals around of_node pointers
  drm/bridge/analogix/anx78xx: Drop conditionals around of_node pointers

 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 9 ---------
 include/drm/drm_bridge.h                           | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.25.1

