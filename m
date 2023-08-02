Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6276C30F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHBCri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHBCrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:47:36 -0400
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911CC1FEE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:47:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.8370208|0.1542419;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.128715-0.00524152-0.866043;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6NjZXx_1690944447;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6NjZXx_1690944447)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:47:29 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/dc: Clean up errors in hpd_regs.h
Date:   Wed,  2 Aug 2023 02:47:25 +0000
Message-Id: <20230802024725.10192-1-sunran001@208suo.com>
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

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/hpd_regs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hpd_regs.h b/drivers/gpu/drm/amd/display/dc/gpio/hpd_regs.h
index dcfdd71b2304..debb363cfcf4 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hpd_regs.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hpd_regs.h
@@ -36,17 +36,17 @@
 #define ONE_MORE_5 6
 
 
-#define HPD_GPIO_REG_LIST_ENTRY(type,cd,id) \
+#define HPD_GPIO_REG_LIST_ENTRY(type, cd, id) \
 	.type ## _reg =  REG(DC_GPIO_HPD_## type),\
 	.type ## _mask =  DC_GPIO_HPD_ ## type ## __DC_GPIO_HPD ## id ## _ ## type ## _MASK,\
 	.type ## _shift = DC_GPIO_HPD_ ## type ## __DC_GPIO_HPD ## id ## _ ## type ## __SHIFT
 
 #define HPD_GPIO_REG_LIST(id) \
 	{\
-	HPD_GPIO_REG_LIST_ENTRY(MASK,cd,id),\
-	HPD_GPIO_REG_LIST_ENTRY(A,cd,id),\
-	HPD_GPIO_REG_LIST_ENTRY(EN,cd,id),\
-	HPD_GPIO_REG_LIST_ENTRY(Y,cd,id)\
+	HPD_GPIO_REG_LIST_ENTRY(MASK, cd, id),\
+	HPD_GPIO_REG_LIST_ENTRY(A, cd, id),\
+	HPD_GPIO_REG_LIST_ENTRY(EN, cd, id),\
+	HPD_GPIO_REG_LIST_ENTRY(Y, cd, id)\
 	}
 
 #define HPD_REG_LIST(id) \
-- 
2.17.1

