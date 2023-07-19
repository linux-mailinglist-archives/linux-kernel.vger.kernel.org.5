Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93A759999
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjGSPYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjGSPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:23:54 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC6412F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:23:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:51f7:4083:c317:cdf])
        by baptiste.telenet-ops.be with bizsmtp
        id P3Pg2A0062xuRWb013PgBF; Wed, 19 Jul 2023 17:23:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qM91W-001tXy-4l;
        Wed, 19 Jul 2023 17:23:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qM91g-001Bji-55;
        Wed, 19 Jul 2023 17:23:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 1/4] drm/todo: Add atomic modesetting references
Date:   Wed, 19 Jul 2023 17:23:34 +0200
Message-Id: <6809d0fda0716892cbccf0ee272481032251026d.1689779916.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689779916.git.geert+renesas@glider.be>
References: <cover.1689779916.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section about converting existing KMS drivers to atomic modesetting
mentions the existence of a conversion guide, but does not reference it.
While the guide is old and rusty, it still contains useful information,
so add a link to it.  Also link to the LWN.net articles that give an
overview about the atomic mode setting design.

While at it, remove the reference to unconverted virtual HW drivers, as
they've been converted.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Reviewed-by,
  - Drop double space after full stop,
  - Use footnotes for references,
  - Remore reference to unconverted virtual HW drivers.
---
 Documentation/gpu/todo.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index b05b32c12975559b..b93059e384128904 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -49,14 +49,18 @@ converted over. Modern compositors like Wayland or Surfaceflinger on Android
 really want an atomic modeset interface, so this is all about the bright
 future.
 
-There is a conversion guide for atomic and all you need is a GPU for a
-non-converted driver (again virtual HW drivers for KVM are still all
-suitable).
+There is a conversion guide for atomic [1]_ and all you need is a GPU for a
+non-converted driver.  The "Atomic mode setting design overview" series [2]_
+[3]_ at LWN.net can also be helpful.
 
 As part of this drivers also need to convert to universal plane (which means
 exposing primary & cursor as proper plane objects). But that's much easier to
 do by directly using the new atomic helper driver callbacks.
 
+  .. [1] https://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drivers.html
+  .. [2] https://lwn.net/Articles/653071/
+  .. [3] https://lwn.net/Articles/653466/
+
 Contact: Daniel Vetter, respective driver maintainers
 
 Level: Advanced
-- 
2.34.1

