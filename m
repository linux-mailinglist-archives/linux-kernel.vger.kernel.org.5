Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DDC75699C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjGQQvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjGQQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:51:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809A9B3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:51:42 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.felsch@pengutronix.de>)
        id 1qLRRb-00067V-Iq; Mon, 17 Jul 2023 18:51:31 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] arm64: dts: imx8mp-debix: remove unused fec pinctrl node
Date:   Mon, 17 Jul 2023 18:51:24 +0200
Message-Id: <20230717165127.2882535-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoM A make use of the EQOS ethernet interface and not the FEC, so
drop the FEC pinctrl node from the devicetree.

Fixes: c86d350aae68 ("arm64: dts: Add device tree for the Debix Model A Board")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:

v2:
- new patch

 .../dts/freescale/imx8mp-debix-model-a.dts    | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
index b4409349eb3f6..1004ab0abb131 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
@@ -355,28 +355,6 @@ MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18				0x19
 		>;
 	};
 
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC				0x3
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO				0x3
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0				0x91
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1				0x91
-			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2				0x91
-			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3				0x91
-			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC				0x91
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL			0x91
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0				0x1f
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1				0x1f
-			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2				0x1f
-			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3				0x1f
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL			0x1f
-			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC				0x1f
-			MX8MP_IOMUXC_SAI1_RXD1__ENET1_1588_EVENT1_OUT			0x1f
-			MX8MP_IOMUXC_SAI1_RXD0__ENET1_1588_EVENT1_IN			0x1f
-			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19				0x19
-		>;
-	};
-
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16				0x19
-- 
2.39.2

