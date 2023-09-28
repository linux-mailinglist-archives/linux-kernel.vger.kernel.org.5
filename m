Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F0B7B1BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjI1MQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjI1MQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:16:27 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33BD18F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:16:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:e207:8adb:af22:7f1e])
        by laurent.telenet-ops.be with bizsmtp
        id rQGH2A00N3w8i7m01QGHJm; Thu, 28 Sep 2023 14:16:22 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qlpvt-004mR7-5F;
        Thu, 28 Sep 2023 14:16:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qlpwH-001OAg-Kv;
        Thu, 28 Sep 2023 14:16:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] drm: Spelling s/hardward/hardware/g
Date:   Thu, 28 Sep 2023 14:16:11 +0200
Message-Id: <17b8682bb30f15001afac754d5844194428df5af.1695903065.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695903065.git.geert+renesas@glider.be>
References: <cover.1695903065.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspellings of "hardware".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/drm/drm_bridge.h                 | 2 +-
 include/drm/drm_modeset_helper_vtables.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index cfb7dcdb66c4b0b5..05b360a4357fed01 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -107,7 +107,7 @@ struct drm_bridge_funcs {
 	 * Since this function is both called from the check phase of an atomic
 	 * commit, and the mode validation in the probe paths it is not allowed
 	 * to look at anything else but the passed-in mode, and validate it
-	 * against configuration-invariant hardward constraints. Any further
+	 * against configuration-invariant hardware constraints. Any further
 	 * limits which depend upon the configuration can only be checked in
 	 * @mode_fixup.
 	 *
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index e3c3ac615909474b..bbc516f313913254 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -134,7 +134,7 @@ struct drm_crtc_helper_funcs {
 	 * Since this function is both called from the check phase of an atomic
 	 * commit, and the mode validation in the probe paths it is not allowed
 	 * to look at anything else but the passed-in mode, and validate it
-	 * against configuration-invariant hardward constraints. Any further
+	 * against configuration-invariant hardware constraints. Any further
 	 * limits which depend upon the configuration can only be checked in
 	 * @mode_fixup or @atomic_check.
 	 *
@@ -550,7 +550,7 @@ struct drm_encoder_helper_funcs {
 	 * Since this function is both called from the check phase of an atomic
 	 * commit, and the mode validation in the probe paths it is not allowed
 	 * to look at anything else but the passed-in mode, and validate it
-	 * against configuration-invariant hardward constraints. Any further
+	 * against configuration-invariant hardware constraints. Any further
 	 * limits which depend upon the configuration can only be checked in
 	 * @mode_fixup or @atomic_check.
 	 *
-- 
2.34.1

