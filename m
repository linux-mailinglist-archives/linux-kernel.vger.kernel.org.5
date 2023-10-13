Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE77C8420
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjJMLLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMLLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:11:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956F8BE;
        Fri, 13 Oct 2023 04:11:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC10CC433C8;
        Fri, 13 Oct 2023 11:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697195506;
        bh=ruXYjp540Z0r/++wPoXvUFUNAkC/cVY8jpsPDnA0ZFg=;
        h=Date:From:To:Cc:Subject:From;
        b=TIWpu/v31kcsgv7qW2Brlm0U87z4Evi6QLLQ5SdkLRuF3Z+XEGOfUEOiDRNAqpXYD
         kxvkPkdgw9j4pPdCavKEshH/W8xHUFKbn/MINSaN85tzZcibEiDZvHPtoJkADk3lDP
         almS6BlvZvv40sOQ7/17IBXfQRVfxWI+ie8PCMObDk/gmJ5obfoT954cFZRTydzf0i
         PcKo+Qi/YVrtDkyZZx+vMR9MZvguPQME6z09cmHnA9Ol+SXzThp9+SPZxDeHRCcN+w
         2oBYGV3LRldJbgM3gHePc4vhmTsaRgwbGEPTXqL/x/HOGXAh3VAz2ub5O+HDbQQdsu
         fNymj4031CsOg==
Date:   Fri, 13 Oct 2023 13:11:41 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.6-rc6] media fixes
Message-ID: <20231013131141.669dc1c9@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-5

For:
 - a core fix: Don't report V4L2_SUBDEV_CAP_STREAMS when API is disabled;
 - ipu-bridge: Add a missing acpi_dev_put();
 - ov8858: fix driver for probe to work after 6.6-rc1;
 - xilinx-vipp: fix async notifier logic.

Regards,
Mauro

---

The following changes since commit 10a6e5feccb877c3c75ad11d27942ad52c24815f:

  Merge tag 'drm-fixes-2023-10-13' of git://anongit.freedesktop.org/drm/drm (2023-10-12 22:43:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-5

for you to fetch changes up to c46f16f156ac58afcf4addc850bb5dfbca77b9fc:

  media: i2c: ov8858: Don't set fwnode in the driver (2023-10-11 15:26:16 +0200)

----------------------------------------------------------------
media fixes for v6.6-rc6

----------------------------------------------------------------
Geert Uytterhoeven (1):
      media: ipu-bridge: Add missing acpi_dev_put() in ipu_bridge_get_ivsc_acpi_dev()

Hans de Goede (1):
      media: subdev: Don't report V4L2_SUBDEV_CAP_STREAMS when the streams API is disabled

Ondrej Jirman (1):
      media: i2c: ov8858: Don't set fwnode in the driver

Sakari Ailus (1):
      media: xilinx-vipp: Look for entities also in waiting_list

 drivers/media/i2c/ov8858.c                  | 10 ++--------
 drivers/media/pci/intel/ipu-bridge.c        |  4 +++-
 drivers/media/platform/xilinx/xilinx-vipp.c | 17 ++++++++++++-----
 drivers/media/v4l2-core/v4l2-subdev.c       |  7 +++++++
 4 files changed, 24 insertions(+), 14 deletions(-)

