Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F208A7FA7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjK0RK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjK0RKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:10:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4B26A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:10:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66DAC433C7;
        Mon, 27 Nov 2023 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701105019;
        bh=4pNVkXsiUaBtYFLdxjUUYPf4B8uYbv15Pz+1txLQMn4=;
        h=Date:From:To:Cc:Subject:From;
        b=EbLnZsQE2pr2I9TdOPXxdV/+Tzcz4G3Y8yrmEiUyuSMyM3OH2HnOETakq8wXyxR2K
         mt32ZuiJWhHqnqhNpwFPEju9ePfsHb8Gbf+COIyK9vzRkw60ZVorsf8L7Jtn307weO
         G6oDahmMQidYS0UL3CJHWdfvIW3lJqDE6ajDVejyYNBXiKcLd2rBCD99bzmPPSOkKD
         Vos2bk/3BpJVARfWj/ftsE8lm8DvsAI74xYlu3geIugdRPSEd7PS4dr/hMDatITxoW
         3oC3smZZExjhnmRknEJx+xA3MG1Vy78F6GT1iHxp5BBE26P42v3MO3yPOc7UaC/Ob2
         31EB9Xz7TUWaA==
Date:   Mon, 27 Nov 2023 18:10:13 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.7-rc3] media fixes
Message-ID: <20231127181013.7fdc3484@coco.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.7-2

for you to fetch changes up to 32138be394e5d32c095a413949e6ab4875b2aec0:

  Merge tag 'media-renesas-fixes-20231113' of git://git.kernel.org/pub/scm/=
linux/kernel/git/pinchartl/linux.git (2023-11-16 14:28:44 +0100)

----------------------------------------------------------------
media fixes for v6.7-rc3

----------------------------------------------------------------
Arnd Bergmann (1):
      media: pci: mgb4: add COMMON_CLK dependency

Dan Carpenter (1):
      media: v4l2-subdev: Fix a 64bit bug

Hans Verkuil (1):
      Merge tag 'media-renesas-fixes-20231113' of git://git.kernel.org/pub/=
scm/linux/kernel/git/pinchartl/linux.git

Laurent Pinchart (1):
      media: vsp1: Remove unbalanced .s_stream(0) calls

Martin T=C5=AFma (1):
      media: mgb4: Added support for T200 card variant

 drivers/media/pci/mgb4/Kconfig                  |  1 +
 drivers/media/pci/mgb4/mgb4_core.c              | 20 ++++++++++++-----
 drivers/media/platform/renesas/vsp1/vsp1_pipe.c |  2 +-
 drivers/media/platform/renesas/vsp1/vsp1_rpf.c  | 10 +--------
 drivers/media/platform/renesas/vsp1/vsp1_rwpf.c |  8 +++++--
 drivers/media/platform/renesas/vsp1/vsp1_rwpf.h |  4 +++-
 drivers/media/platform/renesas/vsp1/vsp1_wpf.c  | 29 +++------------------=
----
 include/uapi/linux/v4l2-subdev.h                |  2 +-
 8 files changed, 31 insertions(+), 45 deletions(-)

