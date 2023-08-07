Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60E771A21
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHGGVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHGGVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:21:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1E10F9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:21:08 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RK5jN1YGpz1Z1Y8;
        Mon,  7 Aug 2023 14:18:16 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 14:21:03 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <anitha.chrisanthus@intel.com>, <edmund.j.dea@intel.com>
CC:     <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] drm/kmb: Remove unused variable layer_irqs
Date:   Mon, 7 Aug 2023 14:20:36 +0800
Message-ID: <20230807062036.7006-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

layer_irqs does not seems to have any user. So remove it completely.

This resolves sparse warning:
  warning: symbol 'layer_irqs' was not declared. Should it be static?

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---

v2:
  V1 is titled "drm/kmb: Make layer_irqs static". This patch removes
layer_irqs completely as there does not seems to be a user for it.

---
 drivers/gpu/drm/kmb/kmb_plane.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index 9e0562aa2bcb..5a8c7cbf27b0 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -17,13 +17,6 @@
 #include "kmb_plane.h"
 #include "kmb_regs.h"
 
-const u32 layer_irqs[] = {
-	LCD_INT_VL0,
-	LCD_INT_VL1,
-	LCD_INT_GL0,
-	LCD_INT_GL1
-};
-
 /* Conversion (yuv->rgb) matrix from myriadx */
 static const u32 csc_coef_lcd[] = {
 	1024, 0, 1436,
-- 
2.17.1

