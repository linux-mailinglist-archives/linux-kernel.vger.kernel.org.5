Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB5D78E796
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjHaIJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHaIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:09:49 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4E85185
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:09:46 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,216,1688396400"; 
   d="scan'208";a="178287296"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 31 Aug 2023 17:09:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D6E124010DFE;
        Thu, 31 Aug 2023 17:09:40 +0900 (JST)
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
Subject: [PATCH v6 0/4] Drop ID table and conditionals around of_node pointers 
Date:   Thu, 31 Aug 2023 09:09:34 +0100
Message-Id: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to drop ID table and conditionals around of_node
pointers for anx78xx driver.

While at it, drop CONFIG_OF conditionals around of_node pointers from
drm_bridge.h and all the drm/bridge drivers.

v5->v6:
 * Dropped CONFIG_OF conditionals from all bridge drivers.
 * Added Rb tag from Douglas Anderson and for patch#2 and #3.
 * Added Rb tag from Laurent for patch#2.
 * Dropped unnecessary CONFIG_OF conditional around 
   devm_drm_of_get_bridge() and drmm_of_get_bridge().
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

Biju Das (4):
  drm/bridge/analogix/anx78xx: Drop ID table
  drm/bridge: Drop conditionals around of_node pointers
  drm/bridge: Drop CONFIG_OF conditionals around of_node pointers
  drm/bridge: panel: Drop CONFIG_OF conditional around 
    *_of_get_bridge()

 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 9 ---------
 drivers/gpu/drm/bridge/panel.c                     | 5 -----
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 2 --
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      | 2 --
 include/drm/drm_bridge.h                           | 4 ++--
 5 files changed, 2 insertions(+), 20 deletions(-)

-- 
2.25.1

