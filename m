Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44977E94A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbjHPTEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344345AbjHPTEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:04:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7212700;
        Wed, 16 Aug 2023 12:04:41 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E1DA566031F9;
        Wed, 16 Aug 2023 20:04:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692212679;
        bh=grEIxwyKWyaQ5DQD9LOQJqFA2qXty1UB693xBcBE02o=;
        h=From:To:Cc:Subject:Date:From;
        b=eFFZtCQKOPsXXlPcCnjRMP15CAFzGizQJgr5QYp+Mfj+/l+tbetzvVq3HpVTKjesY
         gOfMVulywRu6DLrb0cBBahI0u6kfLWArgTt1hMeKpu9GQWGhKvbG54C3MxD6DGn8pU
         S9ox2TscEfiS6pf8IlgA4ruK0ntjR99q44vRx4fA7ExLZM6KURcJ3Hwmc65f7/cl+z
         Dzml/H2zBnKKZT+oI2xqbTjmrjNvs3xbF+dKsJqdsUySbDqeR6NP8HE5KRR+y/RFfg
         OqXJ/PLHXhhUAz4tDqwW1+k0JIKjV8M9Kvuxj0l37Nznv109H8nmGaXW/A4ce+7XkF
         A7jqZiES2tYSw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3] arm64: dts: mediatek: cherry: Configure eDP and internal display
Date:   Wed, 16 Aug 2023 15:04:16 -0400
Message-ID: <20230816190427.2137768-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add the required nodes to enable the DisplayPort interface, connected
to the Embedded DisplayPort port, where we have an internal display.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
[nfraprado: removed always-on, added vin-supply and enable delay]
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
The MediaTek DRM changes needed for MT8195 have already been queued for
v6.6 [1], so this DT patch is the last missing piece needed to get
a working display on MT8195 Tomato.

[1] https://lore.kernel.org/all/20230813152726.14802-1-chunkuang.hu@kernel.org/

Changes in v3:
- Split from "MT8195 Acer Tomato - devicetrees Part 3" series
- Removed regulator-always-on as it's no longer needed
- Added missing vin-supply and regulator-enable-delay

 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 37a3e9de90ff..dd5b89b73190 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -47,6 +47,19 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0x80000000>;
 	};
 
+	pp3300_disp_x: regulator-pp3300-disp-x {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_disp_x";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-enable-ramp-delay = <2500>;
+		enable-active-high;
+		gpio = <&pio 55 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_fixed_pins>;
+		vin-supply = <&pp3300_z2>;
+	};
+
 	/* system wide LDO 3.3V power rail */
 	pp3300_z5: regulator-pp3300-ldo-z5 {
 		compatible = "regulator-fixed";
@@ -217,6 +230,20 @@ port@1 {
 			reg = <1>;
 			edp_out: endpoint {
 				data-lanes = <0 1 2 3>;
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			power-supply = <&pp3300_disp_x>;
+			backlight = <&backlight_lcd0>;
+			port {
+				panel_in: endpoint {
+					remote-endpoint = <&edp_out>;
+				};
 			};
 		};
 	};
@@ -881,6 +908,12 @@ pins-bus {
 		};
 	};
 
+	panel_fixed_pins: panel-pwr-default-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO55__FUNC_GPIO55>;
+		};
+	};
+
 	pio_default: pio-default-pins {
 		pins-wifi-enable {
 			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
-- 
2.41.0

