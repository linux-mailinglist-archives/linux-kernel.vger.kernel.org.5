Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E07CCC68
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbjJQTjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjJQTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:39:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D20C4;
        Tue, 17 Oct 2023 12:39:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35ECC433C7;
        Tue, 17 Oct 2023 19:39:13 +0000 (UTC)
Date:   Tue, 17 Oct 2023 21:39:11 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v6.6-rc7
Message-ID: <ZS7i38pKFD0/Msus@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few unexiting small fbdev fixes & cleanups for 6.6-rc7.

Thanks,
Helge

-----------

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.6-rc7

for you to fetch changes up to e8e4a470b677511f9d1ad4f3cef32adc1d9a60ca:

  fbdev: core: syscopyarea: fix sloppy typing (2023-10-16 23:22:53 +0200)

----------------------------------------------------------------
fbdev fixes and cleanups for 6.6-rc7:

various minor fixes, cleanups and annotations for atyfb, sa1100fb,
omapfb, uvesafb and mmp.

----------------------------------------------------------------
Arnd Bergmann (2):
      fbdev: atyfb: only use ioremap_uc() on i386 and ia64
      fbdev: sa1100fb: mark sa1100fb_init() static

Dan Carpenter (1):
      fbdev: omapfb: fix some error codes

Jorge Maidana (2):
      fbdev: uvesafb: Remove uvesafb_exec() prototype from include/video/uvesafb.h
      fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()

Kees Cook (2):
      fbdev: mmp: Annotate struct mmphw_ctrl with __counted_by
      fbdev: mmp: Annotate struct mmp_path with __counted_by

Sergey Shtylyov (2):
      fbdev: core: cfbcopyarea: fix sloppy typing
      fbdev: core: syscopyarea: fix sloppy typing

 drivers/video/fbdev/aty/atyfb_base.c   | 4 ++++
 drivers/video/fbdev/core/cfbcopyarea.c | 2 +-
 drivers/video/fbdev/core/syscopyarea.c | 2 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.h  | 2 +-
 drivers/video/fbdev/omap/omapfb_main.c | 4 ++--
 drivers/video/fbdev/sa1100fb.c         | 2 +-
 drivers/video/fbdev/uvesafb.c          | 2 +-
 include/video/mmp_disp.h               | 2 +-
 include/video/uvesafb.h                | 2 --
 9 files changed, 12 insertions(+), 10 deletions(-)
