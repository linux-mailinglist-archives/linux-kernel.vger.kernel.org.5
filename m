Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C276C240
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjHBBb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBBb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:31:27 -0400
Received: from out28-105.mail.aliyun.com (out28-105.mail.aliyun.com [115.124.28.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927202102
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:31:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1514801|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.00456796-0.000204693-0.995227;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6Iyu6P_1690939879;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6Iyu6P_1690939879)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:31:21 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu7.h
Date:   Wed,  2 Aug 2023 01:31:18 +0000
Message-Id: <20230802013118.8677-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
index e14072d45918..bfce9087a47f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
@@ -101,8 +101,7 @@
 #define VR_SMIO_PATTERN_2        4
 #define VR_STATIC_VOLTAGE        5
 
-struct SMU7_PIDController
-{
+struct SMU7_PIDController {
     uint32_t Ki;
     int32_t LFWindupUL;
     int32_t LFWindupLL;
@@ -136,8 +135,7 @@ typedef struct SMU7_PIDController SMU7_PIDController;
 #define SMU7_VCE_MCLK_HANDSHAKE_DISABLE                  0x00010000
 #define SMU7_VCE_SCLK_HANDSHAKE_DISABLE                  0x00020000
 
-struct SMU7_Firmware_Header
-{
+struct SMU7_Firmware_Header {
     uint32_t Digest[5];
     uint32_t Version;
     uint32_t HeaderSize;
-- 
2.17.1

