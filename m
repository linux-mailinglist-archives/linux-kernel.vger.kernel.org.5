Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D778576C61A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjHBHGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHBHGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:06:43 -0400
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E91B4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:06:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4053487|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00345508-0.000378098-0.996167;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6aqPgd_1690959995;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6aqPgd_1690959995)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:06:36 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in mxgpu_nv.c
Date:   Wed,  2 Aug 2023 07:06:32 +0000
Message-Id: <20230802070632.12626-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: else should follow close brace '}'
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index cae1aaa4ddb6..6a68ee946f1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -183,12 +183,10 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 			if (req != IDH_REQ_GPU_INIT_DATA) {
 				pr_err("Doesn't get msg:%d from pf, error=%d\n", event, r);
 				return r;
-			}
-			else /* host doesn't support REQ_GPU_INIT_DATA handshake */
+			} else /* host doesn't support REQ_GPU_INIT_DATA handshake */
 				adev->virt.req_init_data_ver = 0;
 		} else {
-			if (req == IDH_REQ_GPU_INIT_DATA)
-			{
+			if (req == IDH_REQ_GPU_INIT_DATA) {
 				adev->virt.req_init_data_ver =
 					RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1);
 
-- 
2.17.1

