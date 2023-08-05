Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2D0770CFC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjHEBVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHEBVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:21:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2958611B;
        Fri,  4 Aug 2023 18:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B365360AEE;
        Sat,  5 Aug 2023 01:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041D4C433C7;
        Sat,  5 Aug 2023 01:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691198490;
        bh=5fV5ZuLIa4CvtbhPGd7l5Og6cHAhuYGsq6RLgVOLzlE=;
        h=From:To:Cc:Subject:Date:From;
        b=nwzxuZyS4OZHf8K2cqFZ8meU6DUhAjVkvPZxgBdjEZmsg4H0nJc7fbIZyu0Ckqkah
         84aQKkFayLfZVJLCepXBIrcdbqryk2IdZicrAQMAn5SFvk+rqiGW6FEnPAo1lLzzMN
         1HE/jfnMATQDyeTz3hzpBjWvyNRi512pZrkug/az+WB6YtO7V730cZYiJSvfmCzYwj
         4Jj4Bg7sLAgpIL/R3a7NvBptsQHVGTUO8D/9eGJSU9RVLPebzdTU+yMG3+J5lRZ9uw
         bUhEcG3QzMHW1A2X6wqT73/yE+bXhXYeG6CqkWf4EXR2RcUFjwgnN05fmTQEME5lL/
         5pltWh4Dew5aA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.5-rc4
Date:   Fri,  4 Aug 2023 18:21:28 -0700
Message-ID: <20230805012129.2619470-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to ae9b14582ad03abb3db66ba3f8dc5ca443ff54a1:

  Merge tag 'clk-meson-fixes-v6.5-1' of https://github.com/BayLibre/clk-meson into clk-fixes (2023-07-26 11:47:57 -0700)

----------------------------------------------------------------
A few clk driver fixes for some SoC clk drivers:

 - Change a usleep() to udelay() to avoid scheduling while atomic
   in the Amlogic PLL code
 - Revert a patch to the Mediatek MT8183 driver that caused an
   out-of-bounds write
 - Return the right error value when devm_of_iomap() fails in
   imx93_clocks_probe()
 - Constrain the Kconfig for the fixed mmio clk so that it depends on
   HAS_IOMEM and can't be compiled on architectures such as s390

----------------------------------------------------------------
Baoquan He (1):
      clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM

Chen-Yu Tsai (1):
      clk: mediatek: mt8183: Add back SSPM related clocks

Dmitry Rokosov (1):
      clk: meson: change usleep_range() to udelay() for atomic context

Geert Uytterhoeven (1):
      clk: imx93: Propagate correct error in imx93_clocks_probe()

Stephen Boyd (1):
      Merge tag 'clk-meson-fixes-v6.5-1' of https://github.com/BayLibre/clk-meson into clk-fixes

 drivers/clk/Kconfig               |  1 +
 drivers/clk/imx/clk-imx93.c       |  2 +-
 drivers/clk/mediatek/clk-mt8183.c | 27 +++++++++++++++++++++++++++
 drivers/clk/meson/clk-pll.c       |  4 ++--
 4 files changed, 31 insertions(+), 3 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
