Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2F7A8B30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjITSJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjITSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:09:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331FCA;
        Wed, 20 Sep 2023 11:09:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF49C433C7;
        Wed, 20 Sep 2023 18:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695233349;
        bh=UmhVEI2iiuBmbwFq5CKH1XX9QDgvxY7UODclx+RT9Ok=;
        h=Date:From:To:Cc:Subject:From;
        b=bbZE+dSAejFaxYSLDCRlbhxZzRCFcj87D66/Ci44ltlvKduaA/yzGLN2WlbXW6ZaT
         X8LeTuk2486/ZeLHKo2i0+TYbdLem6cR8La6xAUEyeuGXSOKSJ8m8M8fZDjG4Ce3hR
         wV55om5SyrvcyjKtlu8jzho5bZG+fk1tzbPBZawGd4D1F/Fb1tS+GYl7gasDB5StJU
         4CPvDJTiGt//TNvTnAr3vARNOldMZmZVBY0gg8uPjeaLoBrva2lNBfZUHhNQ9NisJ4
         JK3MCZ+znF2yYyhzlIzQf9ZXT6WKxQ3esE/rriLPbBjOoZs0hiB8D4i1s1ZMMzyjHy
         UJq32v9MNVgfA==
Date:   Wed, 20 Sep 2023 20:09:02 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.6-rc3] media fixes
Message-ID: <20230920200902.72ee092c@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-2

For:
  - driver fixes due to incorrect fwnode_handle_put() call
  - bt8xx: bttv_risc_packed(): remove field checks
  - vb2: frame_vector.c: replace WARN_ONCE with a comment
  - imx219: a couple typo fixes and perform a full mode set unconditionally
  - uvcvideo: Fix OOB read
  - some dependency fixes

Thanks!
Mauro

---

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-2

for you to fetch changes up to 263cb0cc5abac7c22a6c0dfa7e50e89d8e6c6900:

  media: imx-mipi-csis: Remove an incorrect fwnode_handle_put() call (2023-09-19 09:03:21 +0200)

----------------------------------------------------------------
Linux media updates for v6.6-rc3

----------------------------------------------------------------
Christophe JAILLET (3):
      media: i2c: max9286: Remove an incorrect fwnode_handle_put() call
      media: i2c: rdacm21: Remove an incorrect fwnode_handle_put() call
      media: imx-mipi-csis: Remove an incorrect fwnode_handle_put() call

Hans Verkuil (2):
      media: bt8xx: bttv_risc_packed(): remove field checks
      media: vb2: frame_vector.c: replace WARN_ONCE with a comment

Laurent Pinchart (3):
      media: i2c: imx219: Fix a typo referring to a wrong variable
      media: i2c: imx219: Fix crop rectangle setting when changing format
      media: i2c: imx219: Perform a full mode set unconditionally

Ricardo Ribalda (1):
      media: uvcvideo: Fix OOB read

Sakari Ailus (4):
      media: pci: ivsc: Select build dependencies
      media: v4l: Use correct dependency for camera sensor drivers
      media: via: Use correct dependency for camera sensor drivers
      media: ivsc: Depend on VIDEO_DEV

 drivers/media/common/videobuf2/frame_vector.c |  6 ++++--
 drivers/media/i2c/imx219.c                    | 13 +++++++------
 drivers/media/i2c/max9286.c                   |  1 -
 drivers/media/i2c/rdacm21.c                   |  1 -
 drivers/media/pci/bt8xx/bttv-risc.c           |  4 +---
 drivers/media/pci/intel/ivsc/Kconfig          |  5 ++++-
 drivers/media/platform/marvell/Kconfig        |  4 ++--
 drivers/media/platform/nxp/imx-mipi-csis.c    |  2 --
 drivers/media/platform/via/Kconfig            |  2 +-
 drivers/media/usb/em28xx/Kconfig              |  4 ++--
 drivers/media/usb/go7007/Kconfig              |  2 +-
 drivers/media/usb/uvc/uvc_ctrl.c              |  3 +++
 12 files changed, 25 insertions(+), 22 deletions(-)

