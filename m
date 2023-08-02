Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125F376C57D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjHBGqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHBGqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:46:17 -0400
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E44DC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:46:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4706627|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0490271-0.00171531-0.949258;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6Z6Jsd_1690958768;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6Z6Jsd_1690958768)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:46:09 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in vega20_ih.c
Date:   Wed,  2 Aug 2023 06:46:06 +0000
Message-Id: <20230802064606.12005-1-sunran001@208suo.com>
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
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 544ee55a22da..dbc99536440f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -500,7 +500,8 @@ static int vega20_ih_self_irq(struct amdgpu_device *adev,
 	case 2:
 		schedule_work(&adev->irq.ih2_work);
 		break;
-	default: break;
+	default:
+		break;
 	}
 	return 0;
 }
@@ -710,8 +711,7 @@ static void vega20_ih_set_interrupt_funcs(struct amdgpu_device *adev)
 	adev->irq.ih_funcs = &vega20_ih_funcs;
 }
 
-const struct amdgpu_ip_block_version vega20_ih_ip_block =
-{
+const struct amdgpu_ip_block_version vega20_ih_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_IH,
 	.major = 4,
 	.minor = 2,
-- 
2.17.1

