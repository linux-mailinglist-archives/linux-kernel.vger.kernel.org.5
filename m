Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29D57BC579
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbjJGHTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343628AbjJGHS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:18:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94059B9;
        Sat,  7 Oct 2023 00:18:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB33CC433C7;
        Sat,  7 Oct 2023 07:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696663138;
        bh=PQXDbKce9VSGY1CXUPIsR5/ip4KZZ3+K2AGzoFdMKj8=;
        h=Date:From:To:Cc:Subject:From;
        b=LDwJSnwaM62KYDdgllpZ3m/0KFkhGPMdhVgrco786PwxgX/BrnyICjPO287ALWjTO
         /L6qia/Wv7PIb3J82FGm6cY3AVngLU4Ho2WQ1r83dFcbprfCzPcwqcJmTrBUW3X6CH
         5e2j2Pa7fo4vm9YTm5PXngF1XihjfwXOnFBjbRkL18kRWbp0sZnBgi0zgj0AshFf/O
         A3vB8C29HI2NWujE7l5yJI942ilva9X6PYuqx8AYaQGSLrJZ0Nb7wu3MWLiFNvPsYV
         Z4yNDZG2xnemba8ivyieC+cVPXmV7LmjO9wzAgeJCZV4YF6CZCvMc5P4kRHyJMDUNA
         IMX6zb76DVjzQ==
Date:   Sat, 7 Oct 2023 09:18:53 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.6-rc5] media fixes
Message-ID: <20231007091853.29a80d85@sal.lan>
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
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-3

For:

- two Kconfig build fixes under randconfig;
- pxa_camera: Fix an error handling path;
- mediatek: vcodec: Fix a NULL-access pointer;
- tegra-video: fix an infinite recursion regression.

Regards,
Mauro

---


The following changes since commit 263cb0cc5abac7c22a6c0dfa7e50e89d8e6c6900:

  media: imx-mipi-csis: Remove an incorrect fwnode_handle_put() call (2023-09-19 09:03:21 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-3

for you to fetch changes up to 1146bec0ca34375f963f79f5c4e6b49ed5386aaa:

  media: mediatek: vcodec: Fix encoder access NULL pointer (2023-10-05 11:34:29 +0200)

----------------------------------------------------------------
media fixes for v6.6-rc5

----------------------------------------------------------------
Arnd Bergmann (1):
      media: pci: intel: ivsc: select V4L2_FWNODE

Christophe JAILLET (1):
      media: pxa_camera: Fix an error handling path in pxa_camera_probe()

Irui Wang (1):
      media: mediatek: vcodec: Fix encoder access NULL pointer

Luca Ceresoli (1):
      staging: media: tegra-video: fix infinite recursion regression

Sakari Ailus (1):
      media: ipu-bridge: Fix Kconfig dependencies

 drivers/media/pci/intel/Kconfig                     | 20 ++++++++++++++------
 drivers/media/pci/intel/ipu3/Kconfig                | 21 +--------------------
 drivers/media/pci/intel/ivsc/Kconfig                |  2 +-
 drivers/media/platform/intel/pxa_camera.c           |  2 +-
 .../platform/mediatek/vcodec/encoder/venc_vpu_if.c  |  3 ++-
 drivers/staging/media/atomisp/Kconfig               |  2 +-
 drivers/staging/media/tegra-video/vi.c              | 16 ++++++++++------
 7 files changed, 30 insertions(+), 36 deletions(-)

