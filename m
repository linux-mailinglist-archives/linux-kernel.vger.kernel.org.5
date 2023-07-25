Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C13761DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGYPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGYPti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:49:38 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E82A1FE6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:49:37 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2d50:2ea4:d4e1:2af3])
        by michel.telenet-ops.be with bizsmtp
        id RTpZ2A00V2TBYXr06TpZAJ; Tue, 25 Jul 2023 17:49:35 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qOKHo-002ViA-Ho;
        Tue, 25 Jul 2023 17:49:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qOKI1-009cZD-Mo;
        Tue, 25 Jul 2023 17:49:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Roger Quadros <rogerq@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] phy: starfive: StarFive PHYs should depend on ARCH_STARFIVE
Date:   Tue, 25 Jul 2023 17:49:27 +0200
Message-Id: <12097f6107a18e2f7cfb80f47ac7b27808e062c4.1690300076.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various StarFive PHYs are only present on StarFive SoCs.  Hence add
a dependency on ARCH_STARFIVE, to prevent asking the user about these
drivers when configuring a kernel without StarFive SoC support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/phy/starfive/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
index a560533a674ee0a5..4457b3872aa146a4 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -3,6 +3,8 @@
 # Phy drivers for StarFive platforms
 #
 
+if ARCH_STARFIVE || COMPILE_TEST
+
 config PHY_STARFIVE_JH7110_DPHY_RX
 	tristate "StarFive JH7110 D-PHY RX support"
 	select GENERIC_PHY
@@ -31,3 +33,5 @@ config PHY_STARFIVE_JH7110_USB
 	  used with the Cadence USB controller.
 	  If M is selected, the module will be called
 	  phy-jh7110-usb.ko.
+
+endif # ARCH_STARFIVE || COMPILE_TEST
-- 
2.34.1

