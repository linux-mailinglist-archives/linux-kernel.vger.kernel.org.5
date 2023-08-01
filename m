Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2676AB30
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjHAIh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjHAIhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:37:23 -0400
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3C5DA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:37:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1057698|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0623579-0.000287539-0.937355;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5ob-Yq_1690879031;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5ob-Yq_1690879031)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 16:37:13 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in ppatomctrl.h
Date:   Tue,  1 Aug 2023 08:37:10 +0000
Message-Id: <20230801083710.6738-1-sunran001@208suo.com>
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
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
index b3103bd4be42..1f987e846628 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
@@ -278,16 +278,14 @@ struct pp_atom_ctrl__avfs_parameters {
 	uint8_t  ucReserved;
 };
 
-struct _AtomCtrl_HiLoLeakageOffsetTable
-{
+struct _AtomCtrl_HiLoLeakageOffsetTable {
     USHORT usHiLoLeakageThreshold;
     USHORT usEdcDidtLoDpm7TableOffset;
     USHORT usEdcDidtHiDpm7TableOffset;
 };
 typedef struct _AtomCtrl_HiLoLeakageOffsetTable AtomCtrl_HiLoLeakageOffsetTable;
 
-struct _AtomCtrl_EDCLeakgeTable
-{
+struct _AtomCtrl_EDCLeakgeTable {
     ULONG DIDT_REG[24];
 };
 typedef struct _AtomCtrl_EDCLeakgeTable AtomCtrl_EDCLeakgeTable;
-- 
2.17.1

