Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15EF76ACCC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjHAJV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjHAJVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:21:41 -0400
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AA22D62
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:20:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1145429|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0510493-0.00536844-0.943582;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5r7xrd_1690881546;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5r7xrd_1690881546)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:19:08 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd: Clean up errors in vega10_processpptables.c
Date:   Tue,  1 Aug 2023 09:19:06 +0000
Message-Id: <20230801091906.7270-1-sunran001@208suo.com>
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

ERROR: "foo* bar" should be "foo *bar"
ERROR: space required before the open brace '{'
ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index bb90d8abf79b..3be616af327e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -372,9 +372,9 @@ static int get_mm_clock_voltage_table(
 	return 0;
 }
 
-static void get_scl_sda_value(uint8_t line, uint8_t *scl, uint8_t* sda)
+static void get_scl_sda_value(uint8_t line, uint8_t *scl, uint8_t *sda)
 {
-	switch(line){
+	switch (line) {
 	case Vega10_I2CLineID_DDC1:
 		*scl = Vega10_I2C_DDC1CLK;
 		*sda = Vega10_I2C_DDC1DATA;
@@ -954,7 +954,7 @@ static int init_powerplay_extended_tables(
 	if (!result && powerplay_table->usPixclkDependencyTableOffset)
 		result = get_pix_clk_voltage_dependency_table(hwmgr,
 				&pp_table_info->vdd_dep_on_pixclk,
-				(const ATOM_Vega10_PIXCLK_Dependency_Table*)
+				(const ATOM_Vega10_PIXCLK_Dependency_Table *)
 				pixclk_dep_table);
 
 	if (!result && powerplay_table->usPhyClkDependencyTableOffset)
-- 
2.17.1

