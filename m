Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994957BE833
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378143AbjJIRdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378057AbjJIRcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A43FA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:32:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C31C433B7;
        Mon,  9 Oct 2023 17:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872763;
        bh=VUVftVqUQRAPrRXE5GXtCJ+nNN13cHRo2rvt57YHjgc=;
        h=From:To:Cc:Subject:Date:From;
        b=JYsnawpGhovMxfMRYcfdbd6wxbvQ8ChNzNDsoiXhlpSd1bo9987is6kP93xTrTY07
         8yRI11kphrlvzEfFZmAoIxjawJVyaTU69p7pQ0tHihiSz88kIoPlISqLvaH/FnHoGs
         2WcE9QA9XQkj8/PaGNhPeIZiwVZLKifqy4Xpwqc6WksbE1eS/tghLfoSnnLiMZfyd/
         CZj2Jt8VJZWLB/Ic0JdPqnIE+GTcWlq0ZEqJo3NYq74ryoqQnokIHOqUeMiQS8LZCA
         KffdxXiEhS/zudMmTiM4FHrhcZkaGIUU191GC74UF/QaF7Av3tkLvyJOy/BNjQq1oi
         j3xv9s5ZnxvuQ==
Received: (nullmailer pid 2530447 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: rockchip-inno-usb2: Drop unnecessary DT includes
Date:   Mon,  9 Oct 2023 12:29:12 -0500
Message-ID: <20231009172923.2457844-17-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither of_address.h or of_platform.h are used in the driver, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index b982c3f0d4b5..a24d2af154df 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -17,9 +17,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
-- 
2.42.0

