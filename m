Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68CE76C558
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjHBGfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHBGfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:35:40 -0400
Received: from out28-107.mail.aliyun.com (out28-107.mail.aliyun.com [115.124.28.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EC79B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:35:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6725605|-1;BR=01201311R631b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_alarm|0.0743208-0.00313566-0.922544;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6YI7xD_1690958130;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6YI7xD_1690958130)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:35:32 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in cik_ih.c
Date:   Wed,  2 Aug 2023 06:35:29 +0000
Message-Id: <20230802063529.11608-1-sunran001@208suo.com>
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
 drivers/gpu/drm/amd/amdgpu/cik_ih.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index df385ffc9768..6f7c031dd197 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -442,8 +442,7 @@ static void cik_ih_set_interrupt_funcs(struct amdgpu_device *adev)
 	adev->irq.ih_funcs = &cik_ih_funcs;
 }
 
-const struct amdgpu_ip_block_version cik_ih_ip_block =
-{
+const struct amdgpu_ip_block_version cik_ih_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_IH,
 	.major = 2,
 	.minor = 0,
-- 
2.17.1

