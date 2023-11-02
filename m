Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CAE7DEAB1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjKBCaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBCaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:30:08 -0400
Received: from s01.bc.larksuite.com (s01.bc.larksuite.com [209.127.230.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9A119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dingdao-com.20200927.dkim.feishu.cn; t=1698892195;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=VcJzb/Hqi5REb/G4gr1LCv0xAGOo0i/tk2uVi1fPSUg=;
 b=cdLGaa+EAD9IcMUC+1blLk7FgqlUAwavLtbG/g1g3hZISxK5Y9LiSL5bNISD0w8PBh1bZn
 Usn0z9gCVFPS2yWA6RDSM4/1dPefbSpxb++/4j1+FDzAVQT10suDSPoeEb8tSpCr6ByK/A
 OU6Dnc08Rsav9oU0izHvHOnH59N3grpxTPB3mhqvR2gW4zkySUObMciFL+G5XKKN8eZs9W
 185zWxK70ROt6RNYL4LbnPLBQzKwb3Cbm3s6PqUJIzhZkKEvsfO9klSwd9bYZTI18nF9ZR
 3+21bhZhjM+cvLjXnJV+LChox7DsRyFcT5YxkY+ei8UxPDHEBMSuvlP+68D1MA==
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.37.1
Date:   Thu,  2 Nov 2023 10:29:46 +0800
Subject: [PATCH] gpu/drm/drm_framebuffer.c: Use Macro instead of actual number.
Mime-Version: 1.0
X-Original-From: Peng Hao <penghao@dingdao.com>
Cc:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <penghao@dingdao.com>
Message-Id: <20231102022946.115603-1-penghao@dingdao.com>
X-Lms-Return-Path: <lba+2654309a2+dbe844+vger.kernel.org+penghao@dingdao.com>
Content-Type: text/plain; charset=UTF-8
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>
From:   "Peng Hao" <penghao@dingdao.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Macro DRM_FORMAT_MAX_PLANES instead of 4, to improve modifiability.

Signed-off-by: Peng Hao <penghao@dingdao.com>
---
 drivers/gpu/drm/drm_framebuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 2dd97473ca10..bf283dae9090 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -254,7 +254,7 @@ static int framebuffer_check(struct drm_device *dev,
 		}
 	}
 
-	for (i = info->num_planes; i < 4; i++) {
+	for (i = info->num_planes; i < DRM_FORMAT_MAX_PLANES; i++) {
 		if (r->modifier[i]) {
 			drm_dbg_kms(dev, "non-zero modifier for unused plane %d\n", i);
 			return -EINVAL;
-- 
2.37.1
