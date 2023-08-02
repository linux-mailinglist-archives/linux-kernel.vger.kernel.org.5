Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0AD76C701
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjHBHgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjHBHgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:36:13 -0400
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA14213A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:35:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.6869546|0.7553379;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_alarm|0.0371214-0.00110484-0.961774;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6cNhFG_1690961743;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6cNhFG_1690961743)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:35:45 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in mxgpu_vi.c
Date:   Wed,  2 Aug 2023 07:35:42 +0000
Message-Id: <20230802073542.13515-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '-=' (ctx:WxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 288c414babdf..59f53c743362 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -334,7 +334,7 @@ static void xgpu_vi_mailbox_send_ack(struct amdgpu_device *adev)
 			break;
 		}
 		mdelay(1);
-		timeout -=1;
+		timeout -= 1;
 
 		reg = RREG32_NO_KIQ(mmMAILBOX_CONTROL);
 	}
-- 
2.17.1

