Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4CC76C6BE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjHBH0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjHBH0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:26:31 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A532198B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:26:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2717956|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00605419-0.000108826-0.993837;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6c61oB_1690961182;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6c61oB_1690961182)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:26:24 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_trace.h
Date:   Wed,  2 Aug 2023 07:26:21 +0000
Message-Id: <20230802072621.13162-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: space required after that ',' (ctx:VxV)
ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 525dffbe046a..2fd1bfb35916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -432,7 +432,7 @@ TRACE_EVENT(amdgpu_vm_flush,
 			   ),
 	    TP_printk("ring=%s, id=%u, hub=%u, pd_addr=%010Lx",
 		      __get_str(ring), __entry->vmid,
-		      __entry->vm_hub,__entry->pd_addr)
+		      __entry->vm_hub, __entry->pd_addr)
 );
 
 DECLARE_EVENT_CLASS(amdgpu_pasid,
@@ -494,7 +494,7 @@ TRACE_EVENT(amdgpu_cs_bo_status,
 );
 
 TRACE_EVENT(amdgpu_bo_move,
-	    TP_PROTO(struct amdgpu_bo* bo, uint32_t new_placement, uint32_t old_placement),
+	    TP_PROTO(struct amdgpu_bo *bo, uint32_t new_placement, uint32_t old_placement),
 	    TP_ARGS(bo, new_placement, old_placement),
 	    TP_STRUCT__entry(
 			__field(struct amdgpu_bo *, bo)
-- 
2.17.1

