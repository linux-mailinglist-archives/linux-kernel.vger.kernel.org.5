Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4876C6CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjHBH2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHBH2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:28:22 -0400
Received: from out28-135.mail.aliyun.com (out28-135.mail.aliyun.com [115.124.28.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EE0EA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:28:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6037459|-1;BR=01201311R621b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_alarm|0.161814-0.00328592-0.8349;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6biHA-_1690961293;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6biHA-_1690961293)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:28:15 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_ring.h
Date:   Wed,  2 Aug 2023 07:28:13 +0000
Message-Id: <20230802072813.13252-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: spaces required around that ':' (ctx:VxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 028ff075db51..e2ab303ad270 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -389,7 +389,7 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	occupied = ring->wptr & ring->buf_mask;
 	dst = (void *)&ring->ring[occupied];
 	chunk1 = ring->buf_mask + 1 - occupied;
-	chunk1 = (chunk1 >= count_dw) ? count_dw: chunk1;
+	chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
 	chunk2 = count_dw - chunk1;
 	chunk1 <<= 2;
 	chunk2 <<= 2;
-- 
2.17.1

