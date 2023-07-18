Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A527582EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjGRQzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjGRQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:55:00 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49BD1BF5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by baptiste.telenet-ops.be with bizsmtp
        id Ngur2A00Y0ucMBo01gurDX; Tue, 18 Jul 2023 18:54:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nZB-Hv;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gdH-Iw;
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
Subject: [PATCH v2 27/41] drm: renesas: shmobile: Rename shmob_drm_crtc.crtc
Date:   Tue, 18 Jul 2023 18:54:32 +0200
Message-Id: <eef9143655f66fbad7664e976157dcd989c02260.1689698048.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689698048.git.geert+renesas@glider.be>
References: <cover.1689698048.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the "crtc" member of the shmob_drm_crtc subclass structure to
"base", to improve readability.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
v2:
  - Add Reviewed-by.
---
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 26 +++++++++----------
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 564051b505ed4ac5..84a773a5363035e0 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -55,7 +55,7 @@ static const struct {
 
 static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
 {
-	struct drm_crtc *crtc = &scrtc->crtc;
+	struct drm_crtc *crtc = &scrtc->base;
 	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 	const struct drm_display_info *info = &sdev->connector->display_info;
 	const struct drm_display_mode *mode = &crtc->mode;
@@ -114,7 +114,7 @@ static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
 
 static void shmob_drm_crtc_start_stop(struct shmob_drm_crtc *scrtc, bool start)
 {
-	struct shmob_drm_device *sdev = to_shmob_device(scrtc->crtc.dev);
+	struct shmob_drm_device *sdev = to_shmob_device(scrtc->base.dev);
 	u32 value;
 
 	value = lcdc_read(sdev, LDCNT2R);
@@ -147,7 +147,7 @@ static void shmob_drm_crtc_start_stop(struct shmob_drm_crtc *scrtc, bool start)
  */
 static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 {
-	struct drm_crtc *crtc = &scrtc->crtc;
+	struct drm_crtc *crtc = &scrtc->base;
 	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 	const struct shmob_drm_interface_data *idata = &sdev->pdata->iface;
 	const struct shmob_drm_format_info *format;
@@ -227,7 +227,7 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 
 static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
 {
-	struct drm_crtc *crtc = &scrtc->crtc;
+	struct drm_crtc *crtc = &scrtc->base;
 	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 
 	if (!scrtc->started)
@@ -260,7 +260,7 @@ void shmob_drm_crtc_resume(struct shmob_drm_crtc *scrtc)
 static void shmob_drm_crtc_compute_base(struct shmob_drm_crtc *scrtc,
 					int x, int y)
 {
-	struct drm_crtc *crtc = &scrtc->crtc;
+	struct drm_crtc *crtc = &scrtc->base;
 	struct drm_framebuffer *fb = crtc->primary->fb;
 	struct drm_gem_dma_object *gem;
 	unsigned int bpp;
@@ -281,7 +281,7 @@ static void shmob_drm_crtc_compute_base(struct shmob_drm_crtc *scrtc,
 
 static void shmob_drm_crtc_update_base(struct shmob_drm_crtc *scrtc)
 {
-	struct drm_crtc *crtc = &scrtc->crtc;
+	struct drm_crtc *crtc = &scrtc->base;
 	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 
 	shmob_drm_crtc_compute_base(scrtc, crtc->x, crtc->y);
@@ -295,7 +295,7 @@ static void shmob_drm_crtc_update_base(struct shmob_drm_crtc *scrtc)
 
 static inline struct shmob_drm_crtc *to_shmob_crtc(struct drm_crtc *crtc)
 {
-	return container_of(crtc, struct shmob_drm_crtc, crtc);
+	return container_of(crtc, struct shmob_drm_crtc, base);
 }
 
 static void shmob_drm_crtc_dpms(struct drm_crtc *crtc, int mode)
@@ -367,15 +367,15 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 void shmob_drm_crtc_finish_page_flip(struct shmob_drm_crtc *scrtc)
 {
 	struct drm_pending_vblank_event *event;
-	struct drm_device *dev = scrtc->crtc.dev;
+	struct drm_device *dev = scrtc->base.dev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dev->event_lock, flags);
 	event = scrtc->event;
 	scrtc->event = NULL;
 	if (event) {
-		drm_crtc_send_vblank_event(&scrtc->crtc, event);
-		drm_crtc_vblank_put(&scrtc->crtc);
+		drm_crtc_send_vblank_event(&scrtc->base, event);
+		drm_crtc_vblank_put(&scrtc->base);
 	}
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
@@ -387,7 +387,7 @@ static int shmob_drm_crtc_page_flip(struct drm_crtc *crtc,
 				    struct drm_modeset_acquire_ctx *ctx)
 {
 	struct shmob_drm_crtc *scrtc = to_shmob_crtc(crtc);
-	struct drm_device *dev = scrtc->crtc.dev;
+	struct drm_device *dev = scrtc->base.dev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dev->event_lock, flags);
@@ -402,7 +402,7 @@ static int shmob_drm_crtc_page_flip(struct drm_crtc *crtc,
 
 	if (event) {
 		event->pipe = 0;
-		drm_crtc_vblank_get(&scrtc->crtc);
+		drm_crtc_vblank_get(&scrtc->base);
 		spin_lock_irqsave(&dev->event_lock, flags);
 		scrtc->event = event;
 		spin_unlock_irqrestore(&dev->event_lock, flags);
@@ -454,7 +454,7 @@ static const struct drm_crtc_funcs crtc_funcs = {
 
 int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
 {
-	struct drm_crtc *crtc = &sdev->crtc.crtc;
+	struct drm_crtc *crtc = &sdev->crtc.base;
 	struct drm_plane *primary, *plane;
 	unsigned int i;
 	int ret;
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
index f507eaf912e16a22..79cce0a0ada4cfce 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
@@ -21,7 +21,7 @@ struct shmob_drm_device;
 struct shmob_drm_format_info;
 
 struct shmob_drm_crtc {
-	struct drm_crtc crtc;
+	struct drm_crtc base;
 
 	struct drm_pending_vblank_event *event;
 	int dpms;
-- 
2.34.1

