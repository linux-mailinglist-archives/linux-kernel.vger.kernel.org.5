Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E367FA5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjK0QNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjK0QN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:13:26 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77E1AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:13:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <auto@pengutronix.de>)
        id 1r7eEI-0001PM-89; Mon, 27 Nov 2023 17:13:02 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <auto@pengutronix.de>)
        id 1r7eEF-00Bz1F-Jx; Mon, 27 Nov 2023 17:12:59 +0100
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <auto@pengutronix.de>)
        id 1r7eEF-00D7aL-1j;
        Mon, 27 Nov 2023 17:12:59 +0100
From:   Roland Hieber <rhi@pengutronix.de>
Date:   Mon, 27 Nov 2023 17:12:29 +0100
Subject: [PATCH 2/2] ARM: dts: imx7: add MIPI-DSI support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-b4-imx7-mipi-dsi-v1-2-7d22eee70c67@pengutronix.de>
References: <20231127-b4-imx7-mipi-dsi-v1-0-7d22eee70c67@pengutronix.de>
In-Reply-To: <20231127-b4-imx7-mipi-dsi-v1-0-7d22eee70c67@pengutronix.de>
To:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Roland Hieber <rhi@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: auto@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

This adds the device tree support for the MIPI-DSI block. The block can
be used as encoder for the parallel signals coming from the lcdif block.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 29b8fd03567a..7adadf9c3694 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -818,6 +818,16 @@ lcdif: lcdif@30730000 {
 					<&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>;
 				clock-names = "pix", "axi";
 				status = "disabled";
+
+				port {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					lcdif_out_mipi_dsi: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&mipi_dsi_in_lcdif>;
+					};
+				};
 			};
 
 			mipi_csi: mipi-csi@30750000 {
@@ -850,6 +860,42 @@ mipi_vc0_to_csi_mux: endpoint {
 					};
 				};
 			};
+
+			mipi_dsi: dsi@30760000 {
+				compatible = "fsl,imx7d-mipi-dsim", "fsl,imx8mm-mipi-dsim";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x30760000 0x400>;
+				clocks = <&clks IMX7D_MIPI_DSI_ROOT_CLK>,
+					 <&clks IMX7D_MIPI_DPHY_ROOT_CLK>;
+				clock-names = "bus_clk", "sclk_mipi";
+				assigned-clocks = <&clks IMX7D_MIPI_DSI_ROOT_SRC>,
+						  <&clks IMX7D_PLL_SYS_PFD5_CLK>;
+				assigned-clock-parents = <&clks IMX7D_PLL_SYS_PFD5_CLK>;
+				assigned-clock-rates = <0>, <333000000>;
+				power-domains = <&pgc_mipi_phy>;
+				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+				samsung,burst-clock-frequency = <891000000>;
+				samsung,esc-clock-frequency = <20000000>;
+				samsung,pll-clock-frequency = <24000000>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						mipi_dsi_in_lcdif: endpoint@0 {
+							reg = <0>;
+							remote-endpoint = <&lcdif_out_mipi_dsi>;
+						};
+					};
+				};
+			};
 		};
 
 		aips3: bus@30800000 {

-- 
2.39.2

