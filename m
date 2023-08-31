Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71F378E7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbjHaIKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242791AbjHaIKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:10:32 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E540E4E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:10:10 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,216,1688396400"; 
   d="scan'208";a="174580102"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Aug 2023 17:10:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6F5E24010DFF;
        Thu, 31 Aug 2023 17:10:06 +0900 (JST)
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 4/4] drm/bridge: panel: Drop CONFIG_OF conditional around  *_of_get_bridge()
Date:   Thu, 31 Aug 2023 09:09:38 +0100
Message-Id: <20230831080938.47454-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary CONFIG_OF conditional around devm_drm_of_get_bridge() and
drmm_of_get_bridge() as it is guarded with #if..#else blocks in
drm_bridge.h.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6:
 * New patch.
---
 drivers/gpu/drm/bridge/panel.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 7f41525f7a6e..9220a1c23697 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -482,7 +482,6 @@ struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_panel_bridge_connector);
 
-#ifdef CONFIG_OF
 /**
  * devm_drm_of_get_bridge - Return next bridge in the chain
  * @dev: device to tie the bridge lifetime to
@@ -550,5 +549,3 @@ struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 	return bridge;
 }
 EXPORT_SYMBOL(drmm_of_get_bridge);
-
-#endif
-- 
2.25.1

