Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFACF7D670C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjJYJik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJYJie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:38:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F359DC;
        Wed, 25 Oct 2023 02:38:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F02E9660733F;
        Wed, 25 Oct 2023 10:38:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698226710;
        bh=RX13zCeq0rAi6EIt1Pj3PIA5q2WQl2rhgl7T3G71//A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBeZa6JT1VekJ34tVjmGUivmWPsQEJKNpJI+ktANAPJG78sZ6hBOiS+rINC1+48wx
         tnxWEH749fl8lqtGmkLgO2hH1CgrW63MZc+5apqYkwxuhfqMIWtybNFD7Vbth8/lR7
         DgBgZvWVziIQv+77K9zDsxsk/5/S1d017NETFdDoNgnRgC+RNxx7eO3xnNeY7/Ovse
         9xD0XYdxKbIjgEtWYTQ/TlqWI+rNLRjBRqkGa1bf5x1FiOGksXqu9R5bwFBKPFc7/Y
         nlB2nBCteJ9iUsKilWxi86pOJEzMoM4/8iwQy8YktIMlnkACJeM7cHM6RZXD6oQEOW
         6MGiJ4tVkTtiw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     hsinyi@chromium.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, erin.lo@mediatek.com,
        eddie.huang@mediatek.com, pihsun@chromium.org,
        fparent@baylibre.com, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, michael.kao@mediatek.com,
        mka@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/8] arm64: dts: mediatek: mt8183: Use interrupts-extended where possible
Date:   Wed, 25 Oct 2023 11:38:09 +0200
Message-ID: <20231025093816.44327-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025093816.44327-1-angelogioacchino.delregno@collabora.com>
References: <20231025093816.44327-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change all instances of interrupt-parent + interrupts to one line
as interrupts-extended where possible across all MT8183 DTs to both
simplify and reduce code size.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi | 3 +--
 .../boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi      | 3 +--
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts  | 3 +--
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts  | 3 +--
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts  | 3 +--
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts  | 3 +--
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi       | 3 +--
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi       | 3 +--
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi        | 3 +--
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi              | 6 ++----
 10 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
index 2c69e7658dba..8b57706ac814 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
@@ -11,8 +11,7 @@ da7219: da7219@1a {
 		pinctrl-0 = <&da7219_pins>;
 		compatible = "dlg,da7219";
 		reg = <0x1a>;
-		interrupt-parent = <&pio>;
-		interrupts = <165 IRQ_TYPE_LEVEL_LOW 165 0>;
+		interrupts-extended = <&pio 165 IRQ_TYPE_LEVEL_LOW>;
 
 		dlg,micbias-lvl = <2600>;
 		dlg,mic-amp-in-sel = "diff";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi
index 0799c48ade19..548e22c194a2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi
@@ -11,8 +11,7 @@ ts3a227e: ts3a227e@3b {
 		pinctrl-0 = <&ts3a227e_pins>;
 		compatible = "ti,ts3a227e";
 		reg = <0x3b>;
-		interrupt-parent = <&pio>;
-		interrupts = <157 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&pio 157 IRQ_TYPE_LEVEL_LOW>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index 552bfc726999..0b45aee2e299 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -18,8 +18,7 @@ &touchscreen {
 
 	compatible = "hid-over-i2c";
 	reg = <0x10>;
-	interrupt-parent = <&pio>;
-	interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&touchscreen_pins>;
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
index 77b96ddf648e..b595622e7bee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
@@ -30,8 +30,7 @@ &touchscreen {
 
 	compatible = "hid-over-i2c";
 	reg = <0x10>;
-	interrupt-parent = <&pio>;
-	interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&touchscreen_pins>;
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
index 37e6e58f63b7..5a1c39318a6c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
@@ -17,8 +17,7 @@ &touchscreen {
 
 	compatible = "hid-over-i2c";
 	reg = <0x10>;
-	interrupt-parent = <&pio>;
-	interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&touchscreen_pins>;
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
index 0e09604004d5..3ea4fdb40118 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
@@ -17,8 +17,7 @@ &touchscreen {
 
 	compatible = "hid-over-i2c";
 	reg = <0x10>;
-	interrupt-parent = <&pio>;
-	interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&touchscreen_pins>;
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
index a11adeb29b1f..a23543d7a11e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
@@ -70,8 +70,7 @@ touchscreen: touchscreen@10 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&open_touch>;
 
-		interrupt-parent = <&pio>;
-		interrupts = <155 IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&pio 155 IRQ_TYPE_EDGE_FALLING>;
 
 		post-power-on-delay-ms = <10>;
 		hid-descr-addr = <0x0001>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
index 4864c39e53a4..306c95166f3f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
@@ -48,8 +48,7 @@ &i2c0 {
 	touchscreen: touchscreen@10 {
 		compatible = "hid-over-i2c";
 		reg = <0x10>;
-		interrupt-parent = <&pio>;
-		interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&touch_default>;
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
index d5f41c6c9881..382e4c6d7191 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
@@ -54,8 +54,7 @@ touchscreen4: touchscreen@5d {
 		pinctrl-names = "default";
 		pinctrl-0 = <&open_touch>;
 
-		interrupt-parent = <&pio>;
-		interrupts = <155 IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&pio 155 IRQ_TYPE_EDGE_FALLING>;
 
 		post-power-on-delay-ms = <10>;
 		hid-descr-addr = <0x0001>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index bf7de35ffcbc..adadfc653f39 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -890,8 +890,7 @@ cr50@0 {
 		spi-max-frequency = <1000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&h1_int_od_l>;
-		interrupt-parent = <&pio>;
-		interrupts = <153 IRQ_TYPE_EDGE_RISING>;
+		interrupts-extended = <&pio 153 IRQ_TYPE_EDGE_RISING>;
 	};
 };
 
@@ -918,8 +917,7 @@ cros_ec: cros-ec@0 {
 		compatible = "google,cros-ec-spi";
 		reg = <0>;
 		spi-max-frequency = <3000000>;
-		interrupt-parent = <&pio>;
-		interrupts = <151 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&pio 151 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ec_ap_int_odl>;
 
-- 
2.42.0

