Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E8476C71E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjHBHi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjHBHh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:37:57 -0400
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AFC3C32
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:37:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.6682332|0.5811412;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_alarm|0.05409-0.00146338-0.944447;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6cMZwp_1690961835;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6cMZwp_1690961835)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:37:17 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in uvd_v3_1.c
Date:   Wed,  2 Aug 2023 07:37:15 +0000
Message-Id: <20230802073715.13598-1-sunran001@208suo.com>
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
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 0fef925b6602..5534c769b655 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -815,8 +815,7 @@ static const struct amd_ip_funcs uvd_v3_1_ip_funcs = {
 	.set_powergating_state = uvd_v3_1_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version uvd_v3_1_ip_block =
-{
+const struct amdgpu_ip_block_version uvd_v3_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_UVD,
 	.major = 3,
 	.minor = 1,
-- 
2.17.1

