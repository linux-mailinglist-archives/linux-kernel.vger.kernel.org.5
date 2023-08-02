Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E040D76C5C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjHBGxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjHBGwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:52:36 -0400
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74D23598
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:52:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2889314|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00195208-5.61741e-05-0.997992;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6Zjv98_1690959088;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6Zjv98_1690959088)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:51:30 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: Clean up errors in amdgpu_atomfirmware.c
Date:   Wed,  2 Aug 2023 06:51:27 +0000
Message-Id: <20230802065127.12183-1-sunran001@208suo.com>
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

ERROR: spaces required around that '>=' (ctx:WxV)
ERROR: spaces required around that '!=' (ctx:WxV)
ERROR: code indent should use tabs where possible

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 0b7f4c4d58e5..835980e94b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -58,7 +58,7 @@ uint32_t amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device *ade
 	if (amdgpu_atom_parse_data_header(adev->mode_info.atom_context,
 				index, &size, &frev, &crev, &data_offset)) {
 		/* support firmware_info 3.1 + */
-		if ((frev == 3 && crev >=1) || (frev > 3)) {
+		if ((frev == 3 && crev >= 1) || (frev > 3)) {
 			firmware_info = (union firmware_info *)
 				(mode_info->atom_context->bios + data_offset);
 			fw_cap = le32_to_cpu(firmware_info->v31.firmware_capability);
@@ -597,7 +597,7 @@ bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_device *adev,
 					  index, &size, &frev, &crev,
 					  &data_offset)) {
 		/* support firmware_info 3.4 + */
-		if ((frev == 3 && crev >=4) || (frev > 3)) {
+		if ((frev == 3 && crev >= 4) || (frev > 3)) {
 			firmware_info = (union firmware_info *)
 				(mode_info->atom_context->bios + data_offset);
 			/* The ras_rom_i2c_slave_addr should ideally
@@ -850,7 +850,7 @@ int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
 
 	firmware_info = (union firmware_info *)(ctx->bios + data_offset);
 
-	if (frev !=3)
+	if (frev != 3)
 		return -EINVAL;
 
 	switch (crev) {
@@ -909,7 +909,7 @@ int amdgpu_atomfirmware_asic_init(struct amdgpu_device *adev, bool fb_reset)
 	}
 
 	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-                                            asic_init);
+					asic_init);
 	if (amdgpu_atom_parse_cmd_header(mode_info->atom_context, index, &frev, &crev)) {
 		if (frev == 2 && crev >= 1) {
 			memset(&asic_init_ps_v2_1, 0, sizeof(asic_init_ps_v2_1));
-- 
2.17.1

