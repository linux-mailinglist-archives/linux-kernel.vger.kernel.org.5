Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5579823D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbjIHGR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjIHGRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:17:22 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 23:17:15 PDT
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D77919A6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 23:17:15 -0700 (PDT)
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id DFY00105;
        Fri, 08 Sep 2023 14:16:05 +0800
Received: from localhost.localdomain (10.94.3.99) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 14:16:04 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <bskeggs@redhat.com>, <kherbst@redhat.com>, <lyude@redhat.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] drm/nouveau/acr/ga102: remove set but unused variable
Date:   Fri, 8 Sep 2023 02:16:01 -0400
Message-ID: <20230908061601.2510-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.94.3.99]
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201621.home.langchao.com (10.100.2.21)
tUid:   202390814160506aa29a415d9216ccfcf156a4c58824f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable loc in nvkm_acr_lsfw_load_sig_image_desc_v2()
is set but not used. Remove the variable and related code.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
index f36a359d4531..bd104a030243 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
@@ -218,7 +218,7 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subdev *subdev,
 		const struct firmware *hsbl;
 		const struct nvfw_ls_hsbl_bin_hdr *hdr;
 		const struct nvfw_ls_hsbl_hdr *hshdr;
-		u32 loc, sig, cnt, *meta;
+		u32 sig, cnt, *meta;
 
 		ret = nvkm_firmware_load_name(subdev, path, "hs_bl_sig", ver, &hsbl);
 		if (ret)
@@ -227,7 +227,6 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subdev *subdev,
 		hdr = nvfw_ls_hsbl_bin_hdr(subdev, hsbl->data);
 		hshdr = nvfw_ls_hsbl_hdr(subdev, hsbl->data + hdr->header_offset);
 		meta = (u32 *)(hsbl->data + hshdr->meta_data_offset);
-		loc = *(u32 *)(hsbl->data + hshdr->patch_loc);
 		sig = *(u32 *)(hsbl->data + hshdr->patch_sig);
 		cnt = *(u32 *)(hsbl->data + hshdr->num_sig);
 
-- 
2.27.0

