Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8368F7E8585
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjKJWX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKJWX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:23:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A5448C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:23:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF0CC433C7;
        Fri, 10 Nov 2023 22:23:51 +0000 (UTC)
Date:   Fri, 10 Nov 2023 23:23:48 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v6.7-rc1
Message-ID: <ZU6tdJPgt4tin/TU@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit be3ca57cfb777ad820c6659d52e60bbdd36bf5ff:

  Merge tag 'media/v6.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2023-11-06 15:06:06 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.7-rc1

for you to fetch changes up to a5035c81847430dfa3482807b07325f29e9e8c09:

  fbdev: fsl-diu-fb: mark wr_reg_wa() static (2023-11-10 09:16:02 +0100)

----------------------------------------------------------------
fbdev fixes and cleanups for 6.7-rc1:

- fix double free and resource leaks in imsttfb
- lots of remove callback cleanups and section mismatch fixes in omapfb,
  amifb and atmel_lcdfb
- error code fix and memparse simplification in omapfb

----------------------------------------------------------------
Andy Shevchenko (2):
      fbdev: omapfb: Do not shadow error code from platform_get_irq()
      fbdev: omapfb: Replace custom memparse() implementation

Arnd Bergmann (2):
      fbdev: hyperv_fb: fix uninitialized local variable use
      fbdev: fsl-diu-fb: mark wr_reg_wa() static

Christophe JAILLET (1):
      fbdev: offb: Simplify offb_init_fb()

Dan Carpenter (2):
      fbdev: imsttfb: fix double free in probe()
      fbdev: imsttfb: fix a resource leak in probe

Philipp Stanner (1):
      fbdev: viafb: use new array-copying-wrapper

Uwe Kleine-König (23):
      fbdev: omapfb: Drop unused remove function
      fbdev: atmel_lcdfb: Stop using platform_driver_probe()
      fbdev: omapfb/analog-tv: Don't put .remove() in .exit.text and drop suppress_bind_attrs
      fbdev: omapfb/dpi: Don't put .remove() in .exit.text and drop suppress_bind_attrs
      fbdev: omapfb/dsi-cm: Don't put .remove() in .exit.text and drop suppress_bind_attrs
      fbdev: omapfb/dvi: Don't put .remove() in .exit.text and drop suppress_bind_attrs
      fbdev: omapfb/hdmi: Don't put .remove() in .exit.text and drop suppress_bind_attrs
      fbdev: omapfb/opa362: Don't put .remove() in .exit.text and drop suppress_bind_attrs
      fbdev: omapfb/sharp-ls037v7dw01: Don't put .remove() in .exit.text and drop suppress_bind_attrs
      fbdev: omapfb/tfp410: Don't put .remove() in .exit.text and drop suppress_bind_attrs
      fbdev: omapfb/tpd12s015: Don't put .remove() in .exit.text and drop suppress_bind_attrs
      fbdev: atmel_lcdfb: Convert to platform remove callback returning void
      fbdev: omapfb/analog-tv: Convert to platform remove callback returning void
      fbdev: omapfb/dpi: Convert to platform remove callback returning void
      fbdev: omapfb/dsi-cm: Convert to platform remove callback returning void
      fbdev: omapfb/dvi: Convert to platform remove callback returning void
      fbdev: omapfb/hdmi: Convert to platform remove callback returning void
      fbdev: omapfb/opa362: Convert to platform remove callback returning void
      fbdev: omapfb/sharp-ls037v7dw01: Convert to platform remove callback returning void
      fbdev: omapfb/tfp410: Convert to platform remove callback returning void
      fbdev: omapfb/tpd12s015: Convert to platform remove callback returning void
      fbdev: amifb: Mark driver struct with __refdata to prevent section mismatch warning
      fbdev: amifb: Convert to platform remove callback returning void

 drivers/video/fbdev/amifb.c                        | 13 +++++---
 drivers/video/fbdev/atmel_lcdfb.c                  | 18 +++++------
 drivers/video/fbdev/fsl-diu-fb.c                   |  2 +-
 drivers/video/fbdev/hyperv_fb.c                    |  2 ++
 drivers/video/fbdev/imsttfb.c                      | 35 +++++++++++-----------
 drivers/video/fbdev/offb.c                         |  8 ++---
 drivers/video/fbdev/omap/omapfb_main.c             | 28 +++++++----------
 .../omap2/omapfb/displays/connector-analog-tv.c    |  7 ++---
 .../fbdev/omap2/omapfb/displays/connector-dvi.c    |  7 ++---
 .../fbdev/omap2/omapfb/displays/connector-hdmi.c   |  7 ++---
 .../fbdev/omap2/omapfb/displays/encoder-opa362.c   |  7 ++---
 .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   |  7 ++---
 .../omap2/omapfb/displays/encoder-tpd12s015.c      |  7 ++---
 .../video/fbdev/omap2/omapfb/displays/panel-dpi.c  |  7 ++---
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |  7 ++---
 .../omapfb/displays/panel-sharp-ls037v7dw01.c      |  7 ++---
 drivers/video/fbdev/omap2/omapfb/vrfb.c            |  9 +-----
 drivers/video/fbdev/via/viafbdev.c                 |  2 +-
 18 files changed, 70 insertions(+), 110 deletions(-)
