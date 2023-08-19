Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5889278192C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjHSK7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjHSK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F15A26081;
        Sat, 19 Aug 2023 03:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 391D561F8B;
        Sat, 19 Aug 2023 10:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63248C433C8;
        Sat, 19 Aug 2023 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692442633;
        bh=ixAqLwqxxQ/kYKmNM3dzPjwchZ1HQS2o1Lx8UILxBu0=;
        h=Date:From:To:Cc:Subject:From;
        b=uJSR9shfIS+3YjeVA8iIce7R7xbReFGJa+NrL9lSZZ98KkNQhyflBX6HXMkzsRpSo
         vOeI3bZKJ9IhG76ekKlLEoqVkDJWg7OCY4k2mTyCouaUtHAqdrOs2uQABP8zaDbmU3
         gzws7UkDQsdhfVHP2HuWqBIMWqYrD+sloT1Dzg7Ay7jo3xpK2tGvXsbHJ7bxrJekN4
         BK+DPz0PQnIustfFdpEZPooYl27ALsyQBihJrwiRjajzSWWB+SIm4kD4x7oax2hcWg
         pCRUuUe7d7Ay6iGB37xLtpGqKpL0s30LgQEojVh2Xs0uX6/9vv9o6cWm0WCEd87sxy
         aW7hGYfOSsIrg==
Date:   Sat, 19 Aug 2023 12:57:07 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.5-rc7] media fixes
Message-ID: <20230819125707.25397dd9@coco.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-3

for 3 driver fixes:

      mtk-jpeg: Set platform driver data earlier
      imx: imx7-media-csi: Fix applying format constraints
      uvcvideo: Fix menu count handling for userspace XU mappings

Thanks,
Mauro

---

The following changes since commit 0cb1d9c845110ce638a43a1417c7df5968d1daa3:

  media: verisilicon: change confusingly named relaxed register access (2023-07-14 09:14:10 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-3

for you to fetch changes up to 2908042a37b56d6a9a595eca946e187e9d2df39a:

  media: imx: imx7-media-csi: Fix applying format constraints (2023-08-09 13:31:37 +0200)

----------------------------------------------------------------
media fixes for v6.5-rc7

----------------------------------------------------------------
Chen-Yu Tsai (1):
      media: mtk-jpeg: Set platform driver data earlier

Fabio Estevam (1):
      media: imx: imx7-media-csi: Fix applying format constraints

Laurent Pinchart (1):
      media: uvcvideo: Fix menu count handling for userspace XU mappings

 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 ++--
 drivers/media/platform/nxp/imx7-media-csi.c          | 7 +++++--
 drivers/media/usb/uvc/uvc_v4l2.c                     | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

