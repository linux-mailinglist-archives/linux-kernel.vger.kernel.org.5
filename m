Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630437A8229
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjITM6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjITM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:58:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1BF2;
        Wed, 20 Sep 2023 05:57:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F344DC433C8;
        Wed, 20 Sep 2023 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695214670;
        bh=4p5SQAL1LP6H+eXb90nX905DDE9cHrNP+UjAWJaND3I=;
        h=From:To:Cc:Subject:Date:From;
        b=Mgs7/jNaPRjinPacz28dnAfbIhK/3aRU4sH6890PjcXFI0tyeItmhmKqwYWQYjngg
         eKYsdY5VCbOjlgWFkdplQ31MXAv+Zwd1PNP/dvehvD0C9Kt7llTgtKBTegnxWvs8c0
         ui6dOAanSr00S4iKaRAgVTpgXBtxmHNhPvWN9MD0abeBLXQ+/W8e/hzak87Pf1m4Yf
         w42ND+He5DqJ59EzF9WAP2haOGTaw/EFbFyEkOJ+T0nR0SzmCpOa2GCWa+WDCVcpTb
         nLTHikbWrMyjj2Hi2/TejsyohH8IDMncAKAuLCPiwgwlZJzMbjzhZ/GUtLzGJDkrg7
         +nwv3Ermq9epg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.6-rc2
Date:   Wed, 20 Sep 2023 13:57:40 +0100
Message-Id: <20230920125749.F344DC433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.6-rc2

for you to fetch changes up to 4221a2bec2189275f3f49492a73221498ae6d131:

  spi: Merge up old fix (2023-09-19 13:17:52 +0100)

----------------------------------------------------------------
spi: Fixes for v6.6

A small collection of fixes, plus a new device ID for Intel Granite
Rapids systems.  The fix for the i.MX driver is fairly urgent, it's
fixing a data corruption issue when bits per word isn't 8.  There's also
one fix which was queued but not sent for v6.4 due to being minor and
arriving at the end of the release.

----------------------------------------------------------------
Han Xu (1):
      spi: nxp-fspi: reset the FLSHxCR1 registers

Johan Hovold (1):
      spi: zynqmp-gqspi: fix clock imbalance on probe failure

Mark Brown (1):
      spi: Merge up old fix

Mika Westerberg (1):
      spi: intel-pci: Add support for Granite Rapids SPI serial flash

Stefan Moring (1):
      spi: imx: Take in account bits per word instead of assuming 8-bits

Valentin Caron (1):
      spi: stm32: add a delay before SPI disable

 drivers/spi/spi-imx.c          |  2 +-
 drivers/spi/spi-intel-pci.c    |  1 +
 drivers/spi/spi-nxp-fspi.c     |  7 +++++++
 drivers/spi/spi-stm32.c        |  8 ++++++++
 drivers/spi/spi-zynqmp-gqspi.c | 12 ++++++++----
 5 files changed, 25 insertions(+), 5 deletions(-)
