Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B21676C560
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjHBGkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHBGkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:40:39 -0400
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124E01FF3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:40:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2407244|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00221003-7.23864e-05-0.997718;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6YguAj_1690958427;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6YguAj_1690958427)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:40:29 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_psp.h
Date:   Wed,  2 Aug 2023 06:40:24 +0000
Message-Id: <20230802064024.11806-1-sunran001@208suo.com>
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

ERROR: open brace '{' following struct go on the same line
ERROR: open brace '{' following enum go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c3203de4a007..feef988bf0c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -78,8 +78,7 @@ enum psp_bootloader_cmd {
 	PSP_BL__LOAD_TOS_SPL_TABLE	= 0x10000000,
 };
 
-enum psp_ring_type
-{
+enum psp_ring_type {
 	PSP_RING_TYPE__INVALID = 0,
 	/*
 	 * These values map to the way the PSP kernel identifies the
@@ -89,8 +88,7 @@ enum psp_ring_type
 	PSP_RING_TYPE__KM = 2  /* Kernel mode ring (formerly called GPCOM) */
 };
 
-struct psp_ring
-{
+struct psp_ring {
 	enum psp_ring_type		ring_type;
 	struct psp_gfx_rb_frame		*ring_mem;
 	uint64_t			ring_mem_mc_addr;
@@ -107,8 +105,7 @@ enum psp_reg_prog_id {
 	PSP_REG_LAST
 };
 
-struct psp_funcs
-{
+struct psp_funcs {
 	int (*init_microcode)(struct psp_context *psp);
 	int (*bootloader_load_kdb)(struct psp_context *psp);
 	int (*bootloader_load_spl)(struct psp_context *psp);
@@ -307,8 +304,7 @@ struct psp_runtime_scpm_entry {
 	enum psp_runtime_scpm_authentication scpm_status;
 };
 
-struct psp_context
-{
+struct psp_context {
 	struct amdgpu_device		*adev;
 	struct psp_ring			km_ring;
 	struct psp_gfx_cmd_resp		*cmd;
-- 
2.17.1

