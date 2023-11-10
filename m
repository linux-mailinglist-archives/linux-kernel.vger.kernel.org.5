Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8567E7FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjKJR4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjKJRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:44 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EFC55AD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:15:12 -0800 (PST)
X-UUID: 03b1ea3b08bf4a16b3aaf728a042b3d3-20231110
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e2de9630-3f36-4b47-a4bd-bdb0ec1fda6f,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-5
X-CID-INFO: VERSION:1.1.32,REQID:e2de9630-3f36-4b47-a4bd-bdb0ec1fda6f,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:4ded3b95-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231110133836Q67P66PL,BulkQuantity:1,Recheck:0,SF:38|24|17|19|44|66|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 03b1ea3b08bf4a16b3aaf728a042b3d3-20231110
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <heminhong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1158269534; Fri, 10 Nov 2023 13:50:49 +0800
From:   heminhong <heminhong@kylinos.cn>
To:     airlied@redhat.com, kraxel@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        heminhong <heminhong@kylinos.cn>
Subject: [PATCH] drm/qxl: remove unused declaration
Date:   Fri, 10 Nov 2023 13:50:31 +0800
Message-Id: <20231110055031.57360-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions are never used by the driver,
removing the functions declaration, it can be reducing program size,
and improving code readability and maintainability.

Signed-off-by: heminhong <heminhong@kylinos.cn>
---
 drivers/gpu/drm/qxl/qxl_drv.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 307a890fde13..32069acd93f8 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -119,7 +119,6 @@ struct qxl_output {
 
 #define to_qxl_crtc(x) container_of(x, struct qxl_crtc, base)
 #define drm_connector_to_qxl_output(x) container_of(x, struct qxl_output, base)
-#define drm_encoder_to_qxl_output(x) container_of(x, struct qxl_output, enc)
 
 struct qxl_mman {
 	struct ttm_device		bdev;
@@ -256,8 +255,6 @@ struct qxl_device {
 
 #define to_qxl(dev) container_of(dev, struct qxl_device, ddev)
 
-int qxl_debugfs_fence_init(struct qxl_device *rdev);
-
 int qxl_device_init(struct qxl_device *qdev, struct pci_dev *pdev);
 void qxl_device_fini(struct qxl_device *qdev);
 
@@ -344,8 +341,6 @@ qxl_image_alloc_objects(struct qxl_device *qdev,
 			int height, int stride);
 void qxl_image_free_objects(struct qxl_device *qdev, struct qxl_drm_image *dimage);
 
-void qxl_update_screen(struct qxl_device *qxl);
-
 /* qxl io operations (qxl_cmd.c) */
 
 void qxl_io_create_primary(struct qxl_device *qdev,
@@ -445,8 +440,6 @@ int qxl_hw_surface_dealloc(struct qxl_device *qdev,
 
 int qxl_bo_check_id(struct qxl_device *qdev, struct qxl_bo *bo);
 
-struct qxl_drv_surface *
-qxl_surface_lookup(struct drm_device *dev, int surface_id);
 void qxl_surface_evict(struct qxl_device *qdev, struct qxl_bo *surf, bool freeing);
 
 /* qxl_ioctl.c */
-- 
2.25.1

