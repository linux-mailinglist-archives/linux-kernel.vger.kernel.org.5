Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E2A7A19B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjIOIzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjIOIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:54:37 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A73B2D5D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:54:19 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by michel.telenet-ops.be with bizsmtp
        id m8uF2A00L1C8whw068uFDe; Fri, 15 Sep 2023 10:54:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qh4aK-003lI9-5N;
        Fri, 15 Sep 2023 10:54:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qh4ad-00GddR-5s;
        Fri, 15 Sep 2023 10:54:15 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 35/41] drm: renesas: shmobile: Cleanup encoder
Date:   Fri, 15 Sep 2023 10:53:50 +0200
Message-Id: <04f186573e1df90ecc051272f3d1cbe564c3469b.1694767209.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694767208.git.geert+renesas@glider.be>
References: <cover.1694767208.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most unused callbacks can be NULL pointers these days.
Drop a bunch of empty encoder callbacks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v4:
  - No changes,

v3:
  - No changes,

v2:
  - Add Reviewed-by.
---
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 26 -------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index ab42a4999a55c475..365eb3e154130d41 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -534,11 +534,6 @@ int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
  * Encoder
  */
 
-static void shmob_drm_encoder_dpms(struct drm_encoder *encoder, int mode)
-{
-	/* No-op, everything is handled in the CRTC code. */
-}
-
 static bool shmob_drm_encoder_mode_fixup(struct drm_encoder *encoder,
 					 const struct drm_display_mode *mode,
 					 struct drm_display_mode *adjusted_mode)
@@ -561,29 +556,8 @@ static bool shmob_drm_encoder_mode_fixup(struct drm_encoder *encoder,
 	return true;
 }
 
-static void shmob_drm_encoder_mode_prepare(struct drm_encoder *encoder)
-{
-	/* No-op, everything is handled in the CRTC code. */
-}
-
-static void shmob_drm_encoder_mode_set(struct drm_encoder *encoder,
-				       struct drm_display_mode *mode,
-				       struct drm_display_mode *adjusted_mode)
-{
-	/* No-op, everything is handled in the CRTC code. */
-}
-
-static void shmob_drm_encoder_mode_commit(struct drm_encoder *encoder)
-{
-	/* No-op, everything is handled in the CRTC code. */
-}
-
 static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
-	.dpms = shmob_drm_encoder_dpms,
 	.mode_fixup = shmob_drm_encoder_mode_fixup,
-	.prepare = shmob_drm_encoder_mode_prepare,
-	.commit = shmob_drm_encoder_mode_commit,
-	.mode_set = shmob_drm_encoder_mode_set,
 };
 
 int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
-- 
2.34.1

