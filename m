Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078B47761E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHIN71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjHIN70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:59:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7998
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:59:25 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLWq767GJz15NVd;
        Wed,  9 Aug 2023 21:58:11 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 21:59:22 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <christian.koenig@amd.com>, <ray.huang@amd.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/ttm: Remove two unused function declarations
Date:   Wed, 9 Aug 2023 21:58:39 +0800
Message-ID: <20230809135839.13216-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cd3a8a596214 ("drm/ttm: remove ttm_bo_(un)lock_delayed_workqueue")
removed the implementations but not the declarations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/drm/ttm/ttm_bo.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 8b113c384236..0223a41a64b2 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -355,8 +355,6 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
 void ttm_bo_put(struct ttm_buffer_object *bo);
 void ttm_bo_set_bulk_move(struct ttm_buffer_object *bo,
 			  struct ttm_lru_bulk_move *bulk);
-int ttm_bo_lock_delayed_workqueue(struct ttm_device *bdev);
-void ttm_bo_unlock_delayed_workqueue(struct ttm_device *bdev, int resched);
 bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 			      const struct ttm_place *place);
 int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_object *bo,
-- 
2.34.1

