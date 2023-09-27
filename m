Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729B07AF9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjI0EpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjI0EoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:44:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA928FAF;
        Tue, 26 Sep 2023 21:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0sZh/1s4l1Ej7E2RoqMSJQhDf2+cTCJZ1+N95YJfSho=; b=Hx+UgjtAV11KKFXDxGhATPwGNT
        b0OUgyX7gCCNuifMBEGniABLHrnyeyrZQuDVFIne1FSfftgNZkYs0k2iXGgpWmfeM+LNpXAt5hBgY
        WW802GGb6L0zRnmyaJnMSMdqI709gS2f+nrZTXO+YHMyu56drt8osVQMaFevCJFjg9sRBCTL9hybF
        LYfzw5akqpyr2+SPcNqrsXw7/seDeusDz9WFxGWGqa0Zy0JyurdEbgWBmL2WOIrY7qjeVspMsjY9O
        CCtr8hesAX38GGMEcMvMMsMiyy/CTDlAPdiIHPLufg55Rn2+IN3B9dEIdJli+mp+eY1c6Pc5fvJF8
        CyKy9GyA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qlLmw-00HUyf-2k;
        Wed, 27 Sep 2023 04:04:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] media: sunxi: a83-mips-csi2: also select GENERIC_PHY
Date:   Tue, 26 Sep 2023 21:04:38 -0700
Message-ID: <20230927040438.5589-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When selecting GENERIC_PHY_MIPI_DPHY, also select GENERIC_PHY to
prevent kconfig warnings:

WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
  Depends on [n]: GENERIC_PHY [=n]
  Selected by [y]:
  - VIDEO_SUN8I_A83T_MIPI_CSI2 [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && VIDEO_DEV [=y] && (ARCH_SUNXI || COMPILE_TEST [=y]) && PM [=y] && COMMON_CLK [=y] && RESET_CONTROLLER [=y]

Fixes: 94d7fd9692b5 ("media: sunxi: Depend on GENERIC_PHY_MIPI_DPHY")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/ZQ/WS8HC1A3F0Qn8@rli9-mobl
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
---
 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
@@ -8,6 +8,7 @@ config VIDEO_SUN8I_A83T_MIPI_CSI2
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
 	select REGMAP_MMIO
+	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	help
 	   Support for the Allwinner A83T MIPI CSI-2 controller and D-PHY.
