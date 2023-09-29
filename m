Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3077B7B2EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjI2JBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2JBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:01:45 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C5180
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:01:41 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:e207:8adb:af22:7f1e])
        by laurent.telenet-ops.be with bizsmtp
        id rl1e2A00Q3w8i7m01l1ezx; Fri, 29 Sep 2023 11:01:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qm9N3-004qFu-Le;
        Fri, 29 Sep 2023 11:01:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qm9NS-001b52-Jy;
        Fri, 29 Sep 2023 11:01:38 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update virt_defconfig for v6.6-rc3
Date:   Fri, 29 Sep 2023 11:01:34 +0200
Message-Id: <6f30b86b83b972e9902b62295f397a20512d5507.1695977960.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Enable CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE (no longer
    auto-enabled since commit bb6c4507fe825f1b ("drm: fix up fbdev
    Kconfig defaults")),
  - Drop CONFIG_FRAMEBUFFER_CONSOLE=y (auto-enabled since commit
    bb6c4507fe825f1b ("drm: fix up fbdev Kconfig defaults")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Perhaps CONFIG_FB_DEVICE should not be enabled?

To be queued in the m68k for-v6.7 branch.
---
 arch/m68k/configs/virt_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/configs/virt_defconfig b/arch/m68k/configs/virt_defconfig
index 3afc6762b0946aa6..ec021a1d48ee7d86 100644
--- a/arch/m68k/configs/virt_defconfig
+++ b/arch/m68k/configs/virt_defconfig
@@ -47,8 +47,9 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_DRM=y
+CONFIG_DRM_FBDEV_EMULATION=y
 CONFIG_DRM_VIRTIO_GPU=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FB_DEVICE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_VIRTIO=y
-- 
2.34.1

