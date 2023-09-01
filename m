Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C337278F979
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348575AbjIAIEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjIAIEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9633910D7;
        Fri,  1 Sep 2023 01:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4C960BC8;
        Fri,  1 Sep 2023 08:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CD1C433C8;
        Fri,  1 Sep 2023 08:04:06 +0000 (UTC)
Date:   Fri, 1 Sep 2023 10:04:04 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v6.6-rc1
Message-ID: <ZPGa9CmtieKVUUVF@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some fbdev fixes & updates for kernel 6.6-rc1.

Remove the mx3fb driver and various smaller cleanups.

Thanks!
Helge

--------------

The following changes since commit 87dfd85c38923acd9517e8df4afc908565df0961:

  Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm (2023-08-31 12:49:10 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.6-rc1

for you to fetch changes up to 4a9762aa358ee0e3deb6e759959f092a3cea86be:

  fbdev: Update fbdev source file paths (2023-09-01 00:29:34 +0200)

----------------------------------------------------------------
fbdev fixes and cleanups for 6.6-rc1:

- Drop the mx3fb driver
- Use list_for_each_entry() helper in fbcore code
- Shorten neofb product names for fb-fix id field
- reduce memory usage in ssd1307fb

----------------------------------------------------------------
Fabio Estevam (1):
      fbdev: mx3fb: Remove the driver

Geert Uytterhoeven (1):
      fbdev: ssd1307fb: Use bool for ssd1307fb_deviceinfo flags

Helge Deller (1):
      fbdev: neofb: Shorten Neomagic product name in info struct

Jinjie Ruan (1):
      fbdev/core: Use list_for_each_entry() helper

Jonathan Neuschäfer (1):
      fbdev: Update fbdev source file paths

 drivers/video/fbdev/Kconfig               |   11 -
 drivers/video/fbdev/Makefile              |    1 -
 drivers/video/fbdev/core/fbsysfs.c        |    8 +-
 drivers/video/fbdev/core/modedb.c         |   22 +-
 drivers/video/fbdev/mx3fb.c               | 1695 -----------------------------
 drivers/video/fbdev/neofb.c               |   27 +-
 drivers/video/fbdev/ssd1307fb.c           |    4 +-
 include/linux/fb.h                        |   10 +-
 include/linux/platform_data/video-mx3fb.h |   50 -
 9 files changed, 23 insertions(+), 1805 deletions(-)
 delete mode 100644 drivers/video/fbdev/mx3fb.c
 delete mode 100644 include/linux/platform_data/video-mx3fb.h
