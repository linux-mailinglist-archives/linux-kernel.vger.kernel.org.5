Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3437876C308
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjHBCoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjHBCn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:43:58 -0400
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703661BFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:43:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9234841|0.09918608;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.230579-0.00226342-0.767157;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6NKq4h_1690944229;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6NKq4h_1690944229)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:43:51 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in ddc_regs.h
Date:   Wed,  2 Aug 2023 02:43:46 +0000
Message-Id: <20230802024346.10104-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/display/dc/gpio/ddc_regs.h    | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/ddc_regs.h b/drivers/gpu/drm/amd/display/dc/gpio/ddc_regs.h
index 59884ef651b3..4a2bf81286d8 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/ddc_regs.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/ddc_regs.h
@@ -31,21 +31,21 @@
 /****************************** new register headers */
 /*** following in header */
 
-#define DDC_GPIO_REG_LIST_ENTRY(type,cd,id) \
+#define DDC_GPIO_REG_LIST_ENTRY(type, cd, id) \
 	.type ## _reg =   REG(DC_GPIO_DDC ## id ## _ ## type),\
 	.type ## _mask =  DC_GPIO_DDC ## id ## _ ## type ## __DC_GPIO_DDC ## id ## cd ## _ ## type ## _MASK,\
 	.type ## _shift = DC_GPIO_DDC ## id ## _ ## type ## __DC_GPIO_DDC ## id ## cd ## _ ## type ## __SHIFT
 
-#define DDC_GPIO_REG_LIST(cd,id) \
+#define DDC_GPIO_REG_LIST(cd, id) \
 	{\
-	DDC_GPIO_REG_LIST_ENTRY(MASK,cd,id),\
-	DDC_GPIO_REG_LIST_ENTRY(A,cd,id),\
-	DDC_GPIO_REG_LIST_ENTRY(EN,cd,id),\
-	DDC_GPIO_REG_LIST_ENTRY(Y,cd,id)\
+	DDC_GPIO_REG_LIST_ENTRY(MASK, cd, id),\
+	DDC_GPIO_REG_LIST_ENTRY(A, cd, id),\
+	DDC_GPIO_REG_LIST_ENTRY(EN, cd, id),\
+	DDC_GPIO_REG_LIST_ENTRY(Y, cd, id)\
 	}
 
-#define DDC_REG_LIST(cd,id) \
-	DDC_GPIO_REG_LIST(cd,id),\
+#define DDC_REG_LIST(cd, id) \
+	DDC_GPIO_REG_LIST(cd, id),\
 	.ddc_setup = REG(DC_I2C_DDC ## id ## _SETUP)
 
 	#define DDC_REG_LIST_DCN2(cd, id) \
@@ -54,34 +54,34 @@
 	.phy_aux_cntl = REG(PHY_AUX_CNTL), \
 	.dc_gpio_aux_ctrl_5 = REG(DC_GPIO_AUX_CTRL_5)
 
-#define DDC_GPIO_VGA_REG_LIST_ENTRY(type,cd)\
+#define DDC_GPIO_VGA_REG_LIST_ENTRY(type, cd)\
 	.type ## _reg =   REG(DC_GPIO_DDCVGA_ ## type),\
 	.type ## _mask =  DC_GPIO_DDCVGA_ ## type ## __DC_GPIO_DDCVGA ## cd ## _ ## type ## _MASK,\
 	.type ## _shift = DC_GPIO_DDCVGA_ ## type ## __DC_GPIO_DDCVGA ## cd ## _ ## type ## __SHIFT
 
 #define DDC_GPIO_VGA_REG_LIST(cd) \
 	{\
-	DDC_GPIO_VGA_REG_LIST_ENTRY(MASK,cd),\
-	DDC_GPIO_VGA_REG_LIST_ENTRY(A,cd),\
-	DDC_GPIO_VGA_REG_LIST_ENTRY(EN,cd),\
-	DDC_GPIO_VGA_REG_LIST_ENTRY(Y,cd)\
+	DDC_GPIO_VGA_REG_LIST_ENTRY(MASK, cd),\
+	DDC_GPIO_VGA_REG_LIST_ENTRY(A, cd),\
+	DDC_GPIO_VGA_REG_LIST_ENTRY(EN, cd),\
+	DDC_GPIO_VGA_REG_LIST_ENTRY(Y, cd)\
 	}
 
 #define DDC_VGA_REG_LIST(cd) \
 	DDC_GPIO_VGA_REG_LIST(cd),\
 	.ddc_setup = mmDC_I2C_DDCVGA_SETUP
 
-#define DDC_GPIO_I2C_REG_LIST_ENTRY(type,cd) \
+#define DDC_GPIO_I2C_REG_LIST_ENTRY(type, cd) \
 	.type ## _reg =   REG(DC_GPIO_I2CPAD_ ## type),\
 	.type ## _mask =  DC_GPIO_I2CPAD_ ## type ## __DC_GPIO_ ## cd ## _ ## type ## _MASK,\
 	.type ## _shift = DC_GPIO_I2CPAD_ ## type ## __DC_GPIO_ ## cd ## _ ## type ## __SHIFT
 
 #define DDC_GPIO_I2C_REG_LIST(cd) \
 	{\
-	DDC_GPIO_I2C_REG_LIST_ENTRY(MASK,cd),\
-	DDC_GPIO_I2C_REG_LIST_ENTRY(A,cd),\
-	DDC_GPIO_I2C_REG_LIST_ENTRY(EN,cd),\
-	DDC_GPIO_I2C_REG_LIST_ENTRY(Y,cd)\
+	DDC_GPIO_I2C_REG_LIST_ENTRY(MASK, cd),\
+	DDC_GPIO_I2C_REG_LIST_ENTRY(A, cd),\
+	DDC_GPIO_I2C_REG_LIST_ENTRY(EN, cd),\
+	DDC_GPIO_I2C_REG_LIST_ENTRY(Y, cd)\
 	}
 
 #define DDC_I2C_REG_LIST(cd) \
@@ -150,12 +150,12 @@ struct ddc_sh_mask {
 
 #define ddc_data_regs(id) \
 {\
-	DDC_REG_LIST(DATA,id)\
+	DDC_REG_LIST(DATA, id)\
 }
 
 #define ddc_clk_regs(id) \
 {\
-	DDC_REG_LIST(CLK,id)\
+	DDC_REG_LIST(CLK, id)\
 }
 
 #define ddc_vga_data_regs \
-- 
2.17.1

