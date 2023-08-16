Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D359E77DF85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244304AbjHPKqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244134AbjHPKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:45:18 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A49B2729
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:45:07 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by laurent.telenet-ops.be with bizsmtp
        id aAkh2A00t45ualL01AkiVU; Wed, 16 Aug 2023 12:44:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWE0x-000osw-G8;
        Wed, 16 Aug 2023 12:44:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWDAw-00674o-HG;
        Wed, 16 Aug 2023 11:50:50 +0200
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
Subject: [PATCH v3 09/41] drm: renesas: shmobile: Use %p4cc to print fourcc code
Date:   Wed, 16 Aug 2023 11:50:16 +0200
Message-Id: <d27a3a0b383145d70f7ae49e3806affc509c1244.1692178020.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692178020.git.geert+renesas@glider.be>
References: <cover.1692178020.git.geert+renesas@glider.be>
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

Replace the last printing of an hexadecimal fourcc format code by a
pretty-printed format name, using the "%p4cc" format specifier.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 7e49e2873da1bb6f..36fedb2b74c8b7a2 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -184,8 +184,8 @@ shmob_drm_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
 
 	format = shmob_drm_format_info(fb->format->format);
 	if (format == NULL) {
-		dev_dbg(sdev->dev, "update_plane: unsupported format %08x\n",
-			fb->format->format);
+		dev_dbg(sdev->dev, "update_plane: unsupported format %p4cc\n",
+			&fb->format->format);
 		return -EINVAL;
 	}
 
-- 
2.34.1

