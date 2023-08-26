Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8573378991D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjHZUpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHZUpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:45:01 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B178DBA;
        Sat, 26 Aug 2023 13:44:58 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qa09K-0004GO-0C;
        Sat, 26 Aug 2023 20:44:50 +0000
Date:   Sat, 26 Aug 2023 21:44:31 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pinctrl: mediatek: mt7981: add additional uart groups
Message-ID: <11db447f257231e08065989100311df57b7f1f1c.1693082594.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uart2_0_tx_rx (pin 4, 5) and uart1_2 (pins 9, 10) groups to the
pinctrl driver for the MediaTek MT7981 SoC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 0fd2c0c451f95..7e59a44078590 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -611,6 +611,9 @@ static int mt7981_wo0_jtag_1_funcs[] = { 5, 5, 5, 5, 5, };
 static int mt7981_uart2_0_pins[] = { 4, 5, 6, 7, };
 static int mt7981_uart2_0_funcs[] = { 3, 3, 3, 3, };
 
+static int mt7981_uart2_0_tx_rx_pins[] = { 4, 5, };
+static int mt7981_uart2_0_tx_rx_funcs[] = { 3, 3, };
+
 /* GBE_LED0 */
 static int mt7981_gbe_led0_pins[] = { 8, };
 static int mt7981_gbe_led0_funcs[] = { 3, };
@@ -731,6 +734,9 @@ static int mt7981_uart1_0_funcs[] = { 4, 4, 4, 4, };
 static int mt7981_uart1_1_pins[] = { 26, 27, 28, 29, };
 static int mt7981_uart1_1_funcs[] = { 2, 2, 2, 2, };
 
+static int mt7981_uart1_2_pins[] = { 9, 10, };
+static int mt7981_uart1_2_funcs[] = { 2, 2, };
+
 /* UART2 */
 static int mt7981_uart2_1_pins[] = { 22, 23, 24, 25, };
 static int mt7981_uart2_1_funcs[] = { 3, 3, 3, 3, };
@@ -805,6 +811,8 @@ static const struct group_desc mt7981_groups[] = {
 	PINCTRL_PIN_GROUP("wo0_jtag_0", mt7981_wo0_jtag_0),
 	/* @GPIO(4,7) WM_JTAG(3) */
 	PINCTRL_PIN_GROUP("uart2_0", mt7981_uart2_0),
+	/* @GPIO(4,5) WM_JTAG(4) */
+	PINCTRL_PIN_GROUP("uart2_0_tx_rx", mt7981_uart2_0_tx_rx),
 	/* @GPIO(8) GBE_LED0(3) */
 	PINCTRL_PIN_GROUP("gbe_led0", mt7981_gbe_led0),
 	/* @GPIO(4,6) PTA_EXT(4) */
@@ -861,6 +869,8 @@ static const struct group_desc mt7981_groups[] = {
 	PINCTRL_PIN_GROUP("uart1_0", mt7981_uart1_0),
 	/* @GPIO(26,29): UART1(2) */
 	PINCTRL_PIN_GROUP("uart1_1", mt7981_uart1_1),
+	/* @GPIO(9,10): UART1(2) */
+	PINCTRL_PIN_GROUP("uart1_2", mt7981_uart1_2),
 	/* @GPIO(22,25): UART1(3) */
 	PINCTRL_PIN_GROUP("uart2_1", mt7981_uart2_1),
 	/* @GPIO(22,24) PTA_EXT(4) */
@@ -922,9 +932,9 @@ static const struct group_desc mt7981_groups[] = {
  */
 static const char *mt7981_wa_aice_groups[] = { "wa_aice1", "wa_aice2", "wm_aice1_1",
 	"wa_aice3", "wm_aice1_2", };
-static const char *mt7981_uart_groups[] = { "wm_uart_0", "uart2_0",
-	"net_wo0_uart_txd_0", "net_wo0_uart_txd_1", "net_wo0_uart_txd_2",
-	"uart1_0", "uart1_1", "uart2_1", "wm_aurt_1", "wm_aurt_2", "uart0", };
+static const char *mt7981_uart_groups[] = { "net_wo0_uart_txd_0", "net_wo0_uart_txd_1",
+	"net_wo0_uart_txd_2", "uart0", "uart1_0", "uart1_1", "uart1_2", "uart2_0",
+	"uart2_0_tx_rx", "uart2_1", "wm_uart_0", "wm_aurt_1", "wm_aurt_2", };
 static const char *mt7981_dfd_groups[] = { "dfd", "dfd_ntrst", };
 static const char *mt7981_wdt_groups[] = { "watchdog", "watchdog1", };
 static const char *mt7981_pcie_groups[] = { "pcie_pereset", "pcie_clk", "pcie_wake", };
-- 
2.41.0
