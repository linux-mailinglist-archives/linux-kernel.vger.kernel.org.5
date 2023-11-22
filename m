Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7877F48AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjKVOPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbjKVOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:14:57 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379D101;
        Wed, 22 Nov 2023 06:14:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97F2DE000F;
        Wed, 22 Nov 2023 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700662492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJh0UJcLRZDsO0H3GP2TmEuizz0gtILPNblbJuaZueI=;
        b=aGAVlR1dvSb8R60JtZC4/1ZmFZCQmBdZtEBRDcN9p7PwJw47vH70p/M1SXIfQelMrh9qLs
        UJoLFtz0IUziaBa40lXw4X9wGepSb9oLxRmORW7AE1aNWNbLkEovE4TqeBMLtxzoXjwM+R
        wVL1y4oE8N+nqw32IqZVqOnJPDKhomCC8KJ1qTV+kFxPrw7Bo9wtbbpHgHH1SU+3ExfQsP
        u9Q9Db3A5SiJRAS3kL9A+8C4SzEhURpq4udRGSXfI0OvEzf/i0Dfdh8IBgjaomT4ClPzw6
        /uTv+d0f7NT9Eda1skSB+7d3jfKMKPeAETuHoBBIeGn0JEnm2ZjVXD2yfVpctA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v7 5/7] ARM: dts: sun8i: a83t: Add MIPI CSI-2 controller node
Date:   Wed, 22 Nov 2023 15:14:23 +0100
Message-ID: <20231122141426.329694-6-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122141426.329694-1-paul.kocialkowski@bootlin.com>
References: <20231122141426.329694-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPI CSI-2 is supported on the A83T with a dedicated controller that
covers both the protocol and D-PHY. It is connected to the only CSI
receiver with a fwnode graph link. Note that the CSI receiver supports
both this MIPI CSI-2 source and a parallel source.

An empty port with a label for the MIPI CSI-2 sensor input is also
defined for convenience.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi | 43 +++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi b/arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi
index 94eb3bfc989e..b74c3f9e6598 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi
@@ -1062,6 +1062,49 @@ csi: camera@1cb0000 {
 			clock-names = "bus", "mod", "ram";
 			resets = <&ccu RST_BUS_CSI>;
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+
+					csi_in_mipi_csi2: endpoint {
+						remote-endpoint = <&mipi_csi2_out_csi>;
+					};
+				};
+			};
+		};
+
+		mipi_csi2: csi@1cb1000 {
+			compatible = "allwinner,sun8i-a83t-mipi-csi2";
+			reg = <0x01cb1000 0x1000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI_SCLK>,
+				 <&ccu CLK_MIPI_CSI>,
+				 <&ccu CLK_CSI_MISC>;
+			clock-names = "bus", "mod", "mipi", "misc";
+			resets = <&ccu RST_BUS_CSI>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mipi_csi2_in: port@0 {
+					reg = <0>;
+				};
+
+				mipi_csi2_out: port@1 {
+					reg = <1>;
+
+					mipi_csi2_out_csi: endpoint {
+						remote-endpoint = <&csi_in_mipi_csi2>;
+					};
+				};
+			};
 		};
 
 		hdmi: hdmi@1ee0000 {
-- 
2.42.1

