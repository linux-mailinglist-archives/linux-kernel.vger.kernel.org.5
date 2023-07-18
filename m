Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B06758314
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjGRQ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjGRQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:55:07 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50D51BF3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by andre.telenet-ops.be with bizsmtp
        id Ngur2A00l0ucMBo01gurGl; Tue, 18 Jul 2023 18:54:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nZI-JL;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gdR-KR;
        Tue, 18 Jul 2023 18:54:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 29/41] drm: renesas: shmobile: Rename shmob_drm_plane.plane
Date:   Tue, 18 Jul 2023 18:54:34 +0200
Message-Id: <ec258533561d8bf915610bca63d7ba396faf58f5.1689698048.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689698048.git.geert+renesas@glider.be>
References: <cover.1689698048.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the "plane" member of the shmob_drm_plane subclass structure to
"base", to improve readability.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 3518f8900c0d1f9e..d0a9299784d4a7cc 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -20,7 +20,7 @@
 #include "shmob_drm_regs.h"
 
 struct shmob_drm_plane {
-	struct drm_plane plane;
+	struct drm_plane base;
 	unsigned int index;
 	unsigned int alpha;
 
@@ -37,7 +37,7 @@ struct shmob_drm_plane {
 
 static inline struct shmob_drm_plane *to_shmob_plane(struct drm_plane *plane)
 {
-	return container_of(plane, struct shmob_drm_plane, plane);
+	return container_of(plane, struct shmob_drm_plane, base);
 }
 
 static void shmob_drm_plane_compute_base(struct shmob_drm_plane *splane,
@@ -64,7 +64,7 @@ static void shmob_drm_plane_compute_base(struct shmob_drm_plane *splane,
 static void __shmob_drm_plane_setup(struct shmob_drm_plane *splane,
 				    struct drm_framebuffer *fb)
 {
-	struct shmob_drm_device *sdev = to_shmob_device(splane->plane.dev);
+	struct shmob_drm_device *sdev = to_shmob_device(splane->base.dev);
 	u32 format;
 
 	/* TODO: Support ROP3 mode */
@@ -216,7 +216,7 @@ struct drm_plane *shmob_drm_plane_create(struct shmob_drm_device *sdev,
 		funcs = &shmob_drm_overlay_plane_funcs;
 
 	splane = drmm_universal_plane_alloc(&sdev->ddev,
-					    struct shmob_drm_plane, plane, 1,
+					    struct shmob_drm_plane, base, 1,
 					    funcs, formats,
 					    ARRAY_SIZE(formats),  NULL, type,
 					    NULL);
@@ -226,5 +226,5 @@ struct drm_plane *shmob_drm_plane_create(struct shmob_drm_device *sdev,
 	splane->index = index;
 	splane->alpha = 255;
 
-	return &splane->plane;
+	return &splane->base;
 }
-- 
2.34.1

