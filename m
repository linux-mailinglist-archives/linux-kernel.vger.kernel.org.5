Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F0A7D670F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjJYJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjJYJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:38:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6758EA6;
        Wed, 25 Oct 2023 02:38:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 487A96607349;
        Wed, 25 Oct 2023 10:38:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698226713;
        bh=kLtT+q9T1ffNmCgLw5PyOqriOe6qk0elUlRHKVB6dJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fu1V73mEIpMdvzkMSD4g0um0+cC+D1UoT+v9rfMiC9Z9lj/GaTStsI0RC43oZGUrE
         YxspPWCajQGMacpwygaYHJeuvJiVup1Wn4j0+3BuvUm3/KZiUO3Qn6+6Y9UkbmRD/p
         ummNrMiQVEs7J2ImCBpYLstTFhEA6Idlh7OhCjfQWaY6JyIewKVAQ3asb1LK5pnvGy
         LgzNCM+tEUKmYMLwyREe1uR1YyD0HSIfMxMd/ZTFEmqkuplwaCnwRN/RkTM9x99U7R
         WaS8FIaAODKoP08OeiJt/K+7UXna9Dv3CycuhZb+Lt8ti1Us027jte3fKQlyXZFCT1
         Vk0NTa3vjywwg==
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
Subject: [PATCH 3/8] arm64: dts: mediatek: Use interrupts-extended where possible
Date:   Wed, 25 Oct 2023 11:38:11 +0200
Message-ID: <20231025093816.44327-4-angelogioacchino.delregno@collabora.com>
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

As already done for MT8173 and MT8183 devicetrees, change all instances
of interrupt-parent + interrupts to one line as interrupts-extended
where possible across all remaining device trees to both simplify and
reduce code size.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi                 | 3 +--
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 3 +--
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 3 +--
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts   | 6 ++----
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index b605313bed99..6f01ddf1acc7 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -8,8 +8,7 @@ &pwrap {
 	pmic: pmic {
 		compatible = "mediatek,mt6358";
 		interrupt-controller;
-		interrupt-parent = <&pio>;
-		interrupts = <182 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts-extended = <&pio 182 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 
 		mt6358codec: mt6358codec {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 3b7a176b7904..2e5b326b0c6f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -153,8 +153,7 @@ switch@0 {
 			reg = <0>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
-			interrupt-parent = <&pio>;
-			interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&pio 53 IRQ_TYPE_LEVEL_HIGH>;
 			reset-gpios = <&pio 54 0>;
 
 			ports {
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index af4a4309bda4..a44df2e33552 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -203,8 +203,7 @@ switch: switch@31 {
 		reg = <31>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-parent = <&pio>;
-		interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts-extended = <&pio 66 IRQ_TYPE_LEVEL_HIGH>;
 		reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
 	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 70b465f7c6a7..f54f90a907e7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -210,8 +210,7 @@ &i2c1 {
 	touchscreen@5d {
 		compatible = "goodix,gt9271";
 		reg = <0x5d>;
-		interrupt-parent = <&pio>;
-		interrupts = <132 IRQ_TYPE_EDGE_RISING>;
+		interrupts-extended = <&pio 132 IRQ_TYPE_EDGE_RISING>;
 		irq-gpios = <&pio 132 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&pio 133 GPIO_ACTIVE_HIGH>;
 		AVDD28-supply = <&mt6360_ldo1>;
@@ -773,8 +772,7 @@ pins {
 };
 
 &pmic {
-	interrupt-parent = <&pio>;
-	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &scp {
-- 
2.42.0

