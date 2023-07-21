Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE40275C1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjGUI2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjGUI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:28:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7E4121;
        Fri, 21 Jul 2023 01:28:33 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3786660709C;
        Fri, 21 Jul 2023 09:28:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689928112;
        bh=Comjd7Rpd+yn3bmmyHbh/cSi5Jl1oVbdmFMbRN+++wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfQ+5tjv3f/+UFCapmORMaCBqgyuBz2TWAjeE2TyzmxjCHGJ5ZDK8OpIINN0zVDR/
         dyLVzXOAbz30wwWTFEaRytxlNd4mhfviyN+tPHuUQr1ftUSz7hbRLJ7ORnSQydF6yN
         YHYa+S30slPEWC92jPTfLlBxgn1K3il3fqPI3lt2xWAq7xn2mLcFjJqF4mBd4IxhRj
         LL2jcp6nVvQA4sN312wwE5fzpLQWTll2BjzBUnjQcJmziK5LwfdKgQVl6sa/sLXlK1
         df+zEBZdAY6t9Zcr8+MckM5oieH5GvYyRKk6U2HL5hbPwnaqnF4iQqFbDagPkCh9gg
         5Ew0FTfoehOOQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 3/3] arm64: dts: mediatek: mt6795-xperia-m5: Add DSI Display and its vregs
Date:   Fri, 21 Jul 2023 10:28:22 +0200
Message-ID: <20230721082822.680010-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721082822.680010-1-angelogioacchino.delregno@collabora.com>
References: <20230721082822.680010-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the DSI display found on the Sony Xperia M5, including
the necessary regulators configuration for it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index ecdf00707a44..7364c7278276 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -66,6 +66,65 @@ bootloader-region@46000000 {
 			no-map;
 		};
 	};
+
+	vreg_disp_avdd: regulator-disp-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "disp_avdd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 138 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vreg_disp_avee: regulator-disp-avee {
+		compatible = "regulator-fixed";
+		regulator-name = "disp_avee";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 139 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vreg_disp_vddh: regulator-disp-vddh {
+		compatible = "regulator-fixed";
+		regulator-name = "disp_vddh";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&dsi0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel: panel@0 {
+		compatible = "sharp,ls060t1sx01";
+		reg = <0>;
+		avdd-supply = <&vreg_disp_avdd>;
+		avee-supply = <&vreg_disp_avee>;
+		vddi-supply = <&mt6331_vgp3_reg>;
+		vddh-supply = <&vreg_disp_vddh>;
+		reset-gpios = <&pio 106 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight_lcd0>;
+
+		pinctrl-0 = <&disp_rst_pins>;
+		pinctrl-names = "default";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+
+	port {
+		dsi0_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
 };
 
 &fhctl {
@@ -180,7 +239,17 @@ &mmc2 {
 	status = "okay";
 };
 
+&mt6331_vgp3_reg {
+	regulator-min-microvolt = <1800000>;
+};
+
 &pio {
+	disp_rst_pins: lcm-pins {
+		pins-rst {
+			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
+		};
+	};
+
 	mmc0_pins_default: emmc-sdr-pins {
 		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO154__FUNC_MSDC0_DAT0>,
-- 
2.41.0

