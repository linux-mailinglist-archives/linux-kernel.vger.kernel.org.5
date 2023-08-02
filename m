Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16FE76C772
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjHBHwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjHBHvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:51:25 -0400
Received: from out28-106.mail.aliyun.com (out28-106.mail.aliyun.com [115.124.28.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5171FEF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:48:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07469802|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.324824-0.00276745-0.672408;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6ccNrv_1690962528;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6ccNrv_1690962528)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:48:49 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in gfx_v7_0.c
Date:   Wed,  2 Aug 2023 07:48:44 +0000
Message-Id: <20230802074844.13773-1-sunran001@208suo.com>
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

ERROR: that open brace { should be on the previous line
ERROR: trailing statements should be on next line
ERROR: open brace '{' following struct go on the same line
ERROR: space prohibited before that '++' (ctx:WxB)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 28 +++++++++++----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 8c174c11eaee..90b034b173c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -90,8 +90,7 @@ MODULE_FIRMWARE("amdgpu/mullins_ce.bin");
 MODULE_FIRMWARE("amdgpu/mullins_rlc.bin");
 MODULE_FIRMWARE("amdgpu/mullins_mec.bin");
 
-static const struct amdgpu_gds_reg_offset amdgpu_gds_reg_offset[] =
-{
+static const struct amdgpu_gds_reg_offset amdgpu_gds_reg_offset[] = {
 	{mmGDS_VMID0_BASE, mmGDS_VMID0_SIZE, mmGDS_GWS_VMID0, mmGDS_OA_VMID0},
 	{mmGDS_VMID1_BASE, mmGDS_VMID1_SIZE, mmGDS_GWS_VMID1, mmGDS_OA_VMID1},
 	{mmGDS_VMID2_BASE, mmGDS_VMID2_SIZE, mmGDS_GWS_VMID2, mmGDS_OA_VMID2},
@@ -110,8 +109,7 @@ static const struct amdgpu_gds_reg_offset amdgpu_gds_reg_offset[] =
 	{mmGDS_VMID15_BASE, mmGDS_VMID15_SIZE, mmGDS_GWS_VMID15, mmGDS_OA_VMID15}
 };
 
-static const u32 spectre_rlc_save_restore_register_list[] =
-{
+static const u32 spectre_rlc_save_restore_register_list[] = {
 	(0x0e00 << 16) | (0xc12c >> 2),
 	0x00000000,
 	(0x0e00 << 16) | (0xc140 >> 2),
@@ -557,8 +555,7 @@ static const u32 spectre_rlc_save_restore_register_list[] =
 	(0x0e00 << 16) | (0x9600 >> 2),
 };
 
-static const u32 kalindi_rlc_save_restore_register_list[] =
-{
+static const u32 kalindi_rlc_save_restore_register_list[] = {
 	(0x0e00 << 16) | (0xc12c >> 2),
 	0x00000000,
 	(0x0e00 << 16) | (0xc140 >> 2),
@@ -933,7 +930,8 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_MULLINS:
 		chip_name = "mullins";
 		break;
-	default: BUG();
+	default:
+		BUG();
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
@@ -2759,8 +2757,7 @@ static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-struct hqd_registers
-{
+struct hqd_registers {
 	u32 cp_mqd_base_addr;
 	u32 cp_mqd_base_addr_hi;
 	u32 cp_hqd_active;
@@ -5124,11 +5121,11 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 			bitmap = gfx_v7_0_get_cu_active_bitmap(adev);
 			cu_info->bitmap[i][j] = bitmap;
 
-			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k ++) {
+			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k++) {
 				if (bitmap & mask) {
 					if (counter < ao_cu_num)
 						ao_bitmap |= mask;
-					counter ++;
+					counter++;
 				}
 				mask <<= 1;
 			}
@@ -5150,8 +5147,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 	cu_info->lds_size = 64;
 }
 
-const struct amdgpu_ip_block_version gfx_v7_1_ip_block =
-{
+const struct amdgpu_ip_block_version gfx_v7_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GFX,
 	.major = 7,
 	.minor = 1,
@@ -5159,8 +5155,7 @@ const struct amdgpu_ip_block_version gfx_v7_1_ip_block =
 	.funcs = &gfx_v7_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version gfx_v7_2_ip_block =
-{
+const struct amdgpu_ip_block_version gfx_v7_2_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GFX,
 	.major = 7,
 	.minor = 2,
@@ -5168,8 +5163,7 @@ const struct amdgpu_ip_block_version gfx_v7_2_ip_block =
 	.funcs = &gfx_v7_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version gfx_v7_3_ip_block =
-{
+const struct amdgpu_ip_block_version gfx_v7_3_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GFX,
 	.major = 7,
 	.minor = 3,
-- 
2.17.1

