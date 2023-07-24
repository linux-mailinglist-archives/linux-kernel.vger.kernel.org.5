Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681CD75F2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjGXKTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjGXKTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE6FE6C;
        Mon, 24 Jul 2023 03:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCC3161008;
        Mon, 24 Jul 2023 10:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C70AC433C8;
        Mon, 24 Jul 2023 10:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690193515;
        bh=ntB6+9A6gXeuibXWAnS7vkACPJ1ho6l9uuEMI8YE2HU=;
        h=Date:From:To:Cc:Subject:From;
        b=Vtt9r1G6X6hnEYkW12w4IR0VVSDENXdX0yiIL9z03CjrOBvzNMI2k5giFMf+YauBp
         UjMR7IiYXLOA9XPyUaFtjycUiB88qFQh54S+lcaFQhSEUQjI501pPOxWgl+9J58cmk
         6DBa3z4G8pKHDYovWuZIKiJgLZgjpj4707XK1IG6gl/KVSRm/3fTFuoBLnorBvNrhQ
         xSkrB3EuketJcZa2rSAjdrCjaQBXCdIW4sv6FjPFy4wIJFekrJek8A6W3QBxZssQ6j
         Bh0XlJ11WImVa3DK6pKEvwq4tw5JTFzoyCfF4Gl2iYM8HMV0RYAGYV6cQYiywwqX+s
         5RycXOtDE+nVg==
Date:   Mon, 24 Jul 2023 12:11:50 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.5-rc4] media fixes
Message-ID: <20230724121150.1d55ce6b@coco.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-2

For a couple of fixes:
  - some warning fixes;
  - verisilicon: an excessive usage of stack fix and changes at reg access;
  - amphion: use dev_err_probe;
  - pulse8-cec: handle possible ping error
  - imx-jpeg: Support to assign slot for encoder/decoder
  - amphion: Fix firmware path to match linux-firmware
  - pci: cx23885: fix error handling for cx23885 ATSC boards
  - staging: atomisp: select V4L2_FWNODE
  - mediatek: vcodec: fix cancel_work_sync fail with fluster test

Regards,
Mauro


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-2

for you to fetch changes up to 0cb1d9c845110ce638a43a1417c7df5968d1daa3:

  media: verisilicon: change confusingly named relaxed register access (2023-07-14 09:14:10 +0200)

----------------------------------------------------------------
media fixes for v6.5-rc4

----------------------------------------------------------------
Alexander Stein (1):
      media: amphion: use dev_err_probe

Arnd Bergmann (3):
      media: mtk_jpeg_core: avoid unused-variable warning
      media: verisilicon: fix excessive stack usage
      media: verisilicon: change confusingly named relaxed register access

Dmitry Antipov (1):
      media: pulse8-cec: handle possible ping error

Ming Qian (1):
      media: imx-jpeg: Support to assign slot for encoder/decoder

Nicolas Dufresne (1):
      media: amphion: Fix firmware path to match linux-firmware

Nikolay Burykin (1):
      media: pci: cx23885: fix error handling for cx23885 ATSC boards

Sakari Ailus (2):
      media: tc358746: Address compiler warnings
      media: staging: atomisp: select V4L2_FWNODE

Yunfei Dong (1):
      media: mediatek: vcodec: fix cancel_work_sync fail with fluster test

 drivers/media/cec/usb/pulse8/pulse8-cec.c          |   7 +-
 drivers/media/i2c/tc358746.c                       |   4 +-
 drivers/media/pci/cx23885/cx23885-dvb.c            |  12 --
 drivers/media/platform/amphion/vpu_core.c          |   4 +-
 drivers/media/platform/amphion/vpu_mbox.c          |   9 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |   6 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c |   4 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |   4 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c      |   3 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h  |   1 -
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     | 135 ++++++++++-----------
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h     |   5 +-
 drivers/media/platform/verisilicon/hantro.h        |  46 +++----
 .../media/platform/verisilicon/hantro_postproc.c   |  12 +-
 drivers/staging/media/atomisp/Kconfig              |   1 +
 15 files changed, 116 insertions(+), 137 deletions(-)

