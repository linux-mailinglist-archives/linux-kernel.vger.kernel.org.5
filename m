Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF5076C576
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjHBGn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjHBGnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:43:49 -0400
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D830C4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:43:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5251083|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0292899-0.00261234-0.968098;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6YPSJs_1690958616;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6YPSJs_1690958616)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:43:38 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in ih_v6_0.c
Date:   Wed,  2 Aug 2023 06:43:33 +0000
Message-Id: <20230802064333.11895-1-sunran001@208suo.com>
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

ERROR: trailing statements should be on next line
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 980b24120080..ec0c8f8b465a 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -494,7 +494,8 @@ static int ih_v6_0_self_irq(struct amdgpu_device *adev,
 		*adev->irq.ih1.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih1_work);
 		break;
-	default: break;
+	default:
+		break;
 	}
 	return 0;
 }
@@ -759,8 +760,7 @@ static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)
 	adev->irq.ih_funcs = &ih_v6_0_funcs;
 }
 
-const struct amdgpu_ip_block_version ih_v6_0_ip_block =
-{
+const struct amdgpu_ip_block_version ih_v6_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_IH,
 	.major = 6,
 	.minor = 0,
-- 
2.17.1

