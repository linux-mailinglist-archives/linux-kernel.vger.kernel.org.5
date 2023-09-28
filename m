Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6A7B1E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjI1NZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjI1NZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:25:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B7180;
        Thu, 28 Sep 2023 06:25:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCDDC433C8;
        Thu, 28 Sep 2023 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907538;
        bh=wxQRHNLGhumqDazMRCvmQJ6shznHq3312W4lUsKa1xw=;
        h=From:To:Cc:Subject:Date:From;
        b=XbOLqBmc3RLPa8hgZ6KFTJ3vbdcs7n2cCkgP/Zq9Lyb6ztw3f4l9tOg4j2lcqscnG
         1IYJxBpSsHwDvM4URSVLeWWeWMpaqnMDu72vOBeNde3gLOpRfoqFmknEtZbxACUwyI
         ULcWh7YE+650OhKmKU7KQLMSpA0I6ll/tLssGW2O1Ao7Kyc+6wLqBK4fdf2BHEg7qS
         Sy9JCQOScgWOQq0rLaizKKLVsBF9S0kgp5opw/zj3ex7JpZdv6t61Kjx7YIL0ILIyk
         L1LpEBlpowlbvzQncYcLMEyueXT1h0pzW/Wz0wsuoF3ixdZ5OSGln7jFxLgrs7kokP
         YvYxrvwUgf6aQ==
Message-ID: <eec4dc5364587e55e6564d1cb3b3c40e.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.6-rc3
Date:   Thu, 28 Sep 2023 15:25:29 +0200
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4221a2bec2189275f3f49492a73221498ae6d131:

  spi: Merge up old fix (2023-09-19 13:17:52 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.6-rc3

for you to fetch changes up to 1a8196a93e493c0a50b800cb09cef60b124eee15:

  spi: spi-gxp: BUG: Correct spi write return value (2023-09-27 17:06:36 +0200)

----------------------------------------------------------------
spi: Fixes for v6.6

A small set of device specific fixes, the most major one is for the GXP
driver which would probably have been confusing some callers with
returning the length rather than 0 on successful writes.

----------------------------------------------------------------
Charles Kearney (1):
      spi: spi-gxp: BUG: Correct spi write return value

Charles Keepax (1):
      spi: cs42l43: Remove spurious pm_runtime_disable

Fabio Estevam (1):
      dt-bindings: spi: fsl-imx-cspi: Document missing entries

 Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml | 7 +++++++
 drivers/spi/spi-cs42l43.c                               | 1 -
 drivers/spi/spi-gxp.c                                   | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)
