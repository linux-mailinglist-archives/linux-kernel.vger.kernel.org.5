Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29F376C600
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjHBHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjHBHAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:00:13 -0400
Received: from out28-92.mail.aliyun.com (out28-92.mail.aliyun.com [115.124.28.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9BDFB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:00:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6415508|-1;BR=01201311R811b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_alarm|0.0463943-0.0031398-0.950466;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6aC1Jc_1690959599;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6aC1Jc_1690959599)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:00:02 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/jpeg: Clean up errors in jpeg_v2_0.c
Date:   Wed,  2 Aug 2023 06:59:58 +0000
Message-Id: <20230802065958.12449-1-sunran001@208suo.com>
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

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index c25d4a07350b..1c8116d75f63 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -807,8 +807,7 @@ static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->jpeg.inst->irq.funcs = &jpeg_v2_0_irq_funcs;
 }
 
-const struct amdgpu_ip_block_version jpeg_v2_0_ip_block =
-{
+const struct amdgpu_ip_block_version jpeg_v2_0_ip_block = {
 		.type = AMD_IP_BLOCK_TYPE_JPEG,
 		.major = 2,
 		.minor = 0,
-- 
2.17.1

