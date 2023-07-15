Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4375487A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGOLx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 07:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjGOLx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 07:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AFC35BC;
        Sat, 15 Jul 2023 04:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52D1A60B86;
        Sat, 15 Jul 2023 11:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333B8C433C8;
        Sat, 15 Jul 2023 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689422006;
        bh=qghMVI8NRcAKDY8XdDTEQeqW3TKWyCTYNcDkttkSEUw=;
        h=From:To:Cc:Subject:Date:From;
        b=u1Yj7HhTIXwfJHuANWCE/ziiKXk9T00CTWrDdnh6kEKy9xuW5rR3QCA8dkhUlD+h7
         gTpa3ZXeWtQV/oHnsWahbm4PMs9CBduwgAoogZUyRC1ZfOFunmmegLaJ0+wFl04sQc
         ftRnnEklVYMmCOz/Ch+gQhbVr3BF1CcQC+GQrmWz6m/Fn3kWo4+uJADL0lVzT1+dx2
         bvk1mQARKH61jd00RCe148iszNK31bgMla3Qbhpl7QdZK/PGvqnwja0064ayL08R9i
         WUImXHqk5fI3rxadrlwhI/RDQN9XE1k+FFv3eRsVg+83fqUaeqRFlzSOYP4Flm+k4l
         oYKvDXVRAITOw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.5-rc1
Date:   Sat, 15 Jul 2023 12:53:19 +0100
Message-Id: <20230715115326.333B8C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 879a879c216a41f5403d8d3dbc204a48501912bf:

  spi: bcm{63xx,bca}-hsspi: update my email address (2023-07-04 13:54:19 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc1

for you to fetch changes up to 54ccc8758ef4d29de9e8fdb711c852abbdd4103a:

  mailmap: add entry for Jonas Gorski (2023-07-12 13:11:08 +0100)

----------------------------------------------------------------
spi: Fixes for v6.5

A couple of fairly minor driver specific fixes here, plus a bunch of
maintainership and admin updates.  Nothing too remarkable.

----------------------------------------------------------------
Jaewon Kim (1):
      spi: s3c64xx: clear loopback bit after loopback test

Jonas Gorski (3):
      spi: bcm63xx: fix max prepend length
      MAINTAINERS: add myself for spi-bcm63xx
      mailmap: add entry for Jonas Gorski

Ryan Wanner (1):
      MAINTAINERS: Add myself as a maintainer for Microchip SPI

 .mailmap                  | 1 +
 MAINTAINERS               | 9 ++++++++-
 drivers/spi/spi-bcm63xx.c | 2 +-
 drivers/spi/spi-s3c64xx.c | 2 ++
 4 files changed, 12 insertions(+), 2 deletions(-)
