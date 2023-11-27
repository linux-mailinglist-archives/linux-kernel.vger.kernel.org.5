Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4527FAC57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjK0VLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0VLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:11:38 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506ED5B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:11:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <auto@pengutronix.de>)
        id 1r7itI-0004lI-8Q; Mon, 27 Nov 2023 22:11:40 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <auto@pengutronix.de>)
        id 1r7itH-00C1q0-HB; Mon, 27 Nov 2023 22:11:39 +0100
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <auto@pengutronix.de>)
        id 1r7itH-00FAHm-1M;
        Mon, 27 Nov 2023 22:11:39 +0100
From:   Roland Hieber <rhi@pengutronix.de>
Date:   Mon, 27 Nov 2023 22:11:04 +0100
Subject: [PATCH 3/5] ARM: dts: imx7d-pinfunc: add mux for OSC32K_32K_OUT
 via GPIO1_IO03
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-b4-imx7-var-som-gome-v1-3-f26f88f2d0bc@pengutronix.de>
References: <20231127-b4-imx7-var-som-gome-v1-0-f26f88f2d0bc@pengutronix.de>
In-Reply-To: <20231127-b4-imx7-var-som-gome-v1-0-f26f88f2d0bc@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Roland Hieber <rhi@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: auto@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Add the missing pinmux setting for alternate function 4 on the
GPIO1_IO03 pin, which muxes the pin as 32 kHz oscillator output.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx7d-pinfunc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx7d-pinfunc.h
index 69f2c1ec8254..1530631b0d70 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-pinfunc.h
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-pinfunc.h
@@ -33,6 +33,7 @@
 #define MX7D_PAD_LPSR_GPIO1_IO03__PWM3_OUT                        0x000C 0x003C 0x0000 0x1 0x0
 #define MX7D_PAD_LPSR_GPIO1_IO03__CCM_ENET_REF_CLK2               0x000C 0x003C 0x0570 0x2 0x3
 #define MX7D_PAD_LPSR_GPIO1_IO03__SAI3_MCLK                       0x000C 0x003C 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO03__OSC32K_32K_OUT                  0x000C 0x003C 0x0000 0x4 0x0
 #define MX7D_PAD_LPSR_GPIO1_IO03__CCM_CLKO2                       0x000C 0x003C 0x0000 0x5 0x0
 #define MX7D_PAD_LPSR_GPIO1_IO03__OBSERVE2_OUT                    0x000C 0x003C 0x0000 0x6 0x0
 #define MX7D_PAD_LPSR_GPIO1_IO03__USB_OTG2_ID                     0x000C 0x003C 0x0730 0x7 0x3

-- 
2.39.2

