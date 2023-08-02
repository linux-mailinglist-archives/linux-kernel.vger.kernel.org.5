Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5FA76C6B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjHBHXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHBHXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:23:40 -0400
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAEC359E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:23:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5205414|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.190381-0.000830124-0.808789;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6axboy_1690960997;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6axboy_1690960997)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:23:18 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_atombios.h
Date:   Wed,  2 Aug 2023 07:23:16 +0000
Message-Id: <20230802072316.12985-1-sunran001@208suo.com>
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

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index b639a80ee3fc..0811474e8fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -89,8 +89,7 @@ struct atom_memory_info {
 
 #define MAX_AC_TIMING_ENTRIES 16
 
-struct atom_memory_clock_range_table
-{
+struct atom_memory_clock_range_table {
 	u8 num_entries;
 	u8 rsv[3];
 	u32 mclk[MAX_AC_TIMING_ENTRIES];
@@ -118,14 +117,12 @@ struct atom_mc_reg_table {
 
 #define MAX_VOLTAGE_ENTRIES 32
 
-struct atom_voltage_table_entry
-{
+struct atom_voltage_table_entry {
 	u16 value;
 	u32 smio_low;
 };
 
-struct atom_voltage_table
-{
+struct atom_voltage_table {
 	u32 count;
 	u32 mask_low;
 	u32 phase_delay;
-- 
2.17.1

