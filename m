Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E77F91B0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 07:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKZG6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 01:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZG6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 01:58:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185EFB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 22:58:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAD6C433C8;
        Sun, 26 Nov 2023 06:58:10 +0000 (UTC)
Date:   Sun, 26 Nov 2023 07:58:08 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v6.7-rc3
Message-ID: <ZWLsgGku7j_7_eVE@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some small fbdev fixes for 6.7-rc3.

A left margin fix and code cleanups in imxfb, and one 
sparse warning fix in fsl-diu-fb.

Thanks,
Helge

---

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.7-rc3

for you to fetch changes up to 64a1aed0aa07698d12deca9b7821ea77762ff328:

  fbdev: mmp: Fix typo and wording in code comment (2023-11-25 09:54:41 +0100)

----------------------------------------------------------------
fbdev fixes and cleanups for 6.7-rc3:

- fix left margin settings in imxfb
- sparse warning fix in fsl-diu-fb
- lots of code cleanups in imxfb

----------------------------------------------------------------
Dario Binacchi (11):
      fbdev: imxfb: fix left margin setting
      fbdev: imxfb: move PCR bitfields near their offset
      fbdev: imxfb: use BIT, FIELD_{GET,PREP} and GENMASK macros
      fbdev: imxfb: replace some magic numbers with constants
      fbdev: imxfb: add missing SPDX tag
      fbdev: imxfb: drop ftrace-like logging
      fbdev: imxfb: add missing spaces after ','
      fbdev: imxfb: Fix style warnings relating to printk()
      fbdev: imxfb: use __func__ for function name
      fbdev: imxfb: add '*/' on a separate line in block comment
      fbdev: mmp: Fix typo and wording in code comment

Stanislav Kinsburskii (1):
      fbdev: fsl-diu-fb: Fix sparse warning due to virt_to_phys() prototype change

 drivers/video/fbdev/fsl-diu-fb.c     |   2 +-
 drivers/video/fbdev/imxfb.c          | 179 ++++++++++++++++++++---------------
 drivers/video/fbdev/mmp/hw/mmp_spi.c |   2 +-
 3 files changed, 104 insertions(+), 79 deletions(-)
