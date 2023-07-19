Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C4C759991
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGSPX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjGSPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:23:50 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0797EE4D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:23:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:51f7:4083:c317:cdf])
        by albert.telenet-ops.be with bizsmtp
        id P3Pg2A00D2xuRWb063Pg26; Wed, 19 Jul 2023 17:23:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qM91W-001tXx-4b;
        Wed, 19 Jul 2023 17:23:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qM91g-001Bjf-3x;
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
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/4] drm: Atomic modesetting doc and comment improvements
Date:   Wed, 19 Jul 2023 17:23:33 +0200
Message-Id: <cover.1689779916.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi all,

This patch series contains various improvements to the documentation and
comments related to atomic modesetting.  Hopefully, it will ease the job
of DRM novice who want to tackle the daunting task of converting a
legacy DRM driver to atomic modesetting.

Changes compared to v2[1]:
  - Make main text read correctly when ignoring the footnotes,
  - Add Reviewed-by.

Changes compared to v1[2]:
  - Add Reviewed-by,
  - Drop double space after full stop,
  - Use footnotes for references,
  - Remore reference to unconverted virtual HW drivers,
  - New patch [2/4],
  - Drop "first part" in drivers/gpu/drm/drm_plane_helper.c.

Thanks for applying!

[1] https://lore.kernel.org/r/cover.1686318012.git.geert+renesas@glider.be
[2] https://lore.kernel.org/r/cover.1685696114.git.geert+renesas@glider.be

Geert Uytterhoeven (4):
  drm/todo: Add atomic modesetting references
  drm/todo: Convert list of fbconv links to footnotes
  drm: Remove references to removed transitional helpers
  drm: Fix references to drm_plane_helper_check_state()

 Documentation/gpu/todo.rst                    | 22 +++++----
 drivers/gpu/drm/drm_plane_helper.c            | 12 +----
 .../gpu/drm/renesas/rcar-du/rcar_du_plane.c   |  3 +-
 drivers/gpu/drm/tidss/tidss_plane.c           |  3 +-
 include/drm/drm_crtc.h                        |  5 --
 include/drm/drm_modeset_helper_vtables.h      | 48 ++++++++-----------
 6 files changed, 40 insertions(+), 53 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
