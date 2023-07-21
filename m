Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C275C1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjGUI2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjGUI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:28:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6298273A;
        Fri, 21 Jul 2023 01:28:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F1629660709A;
        Fri, 21 Jul 2023 09:28:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689928111;
        bh=BVidntw4WSumarLqrqu9nRPaS3zqlQubYugq7T2Z6Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWJ1uKGSJUvbCfz9wGn2aYA/MnFxOtz/6yrxod0OX7qfmXa1KeQJudjX0C14+uSlD
         wfeVk18PCtwKE95J2Oa/LTAljA0agxFbPp9wH+IJn18OhWHjN72hXSovvg0L4xIjlg
         mm3i39lcZVTQxhdVGJN1l+HjUacspRxxjhcSLfeildEly+PCHkAEp+hFO1LFLiaw0B
         y6R5kOqSHB4WJgUo821Ut9O/i5SHlDsD7+AZjZdaxx31t5XYT11kazbaGfMKLNji2A
         Q9ZB4bNIimCq0Gym+H07nZw+I/M2gqUQuqulL2DHZauWV415EpM5QbLCVzzDiicmEn
         HNrMQ6mQp2/tg==
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
Subject: [PATCH v2 2/3] arm64: dts: mediatek: mt6795-xperia-m5: Add display backlight support
Date:   Fri, 21 Jul 2023 10:28:21 +0200
Message-ID: <20230721082822.680010-3-angelogioacchino.delregno@collabora.com>
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

Add the relevant nodes for display backlight on Sony Xperia M5: this
needs both the SoC PWM IP and MT6332 PMIC LED strings.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index b5746e6d0b15..ecdf00707a44 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -22,6 +22,23 @@ aliases {
 		serial1 = &uart1;
 	};
 
+	backlight_lcd0: backlight {
+		compatible = "led-backlight";
+		leds = <&disp_led_pwm>, <&pmic_bl_led>;
+
+		default-brightness-level = <300>;
+	};
+
+	led-controller-display {
+		compatible = "pwm-leds";
+
+		disp_led_pwm: led-0 {
+			label = "backlight-pwm";
+			pwms = <&pwm0 0 500000>;
+			max-brightness = <1024>;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x1e800000>;
@@ -338,6 +355,21 @@ &pmic {
 	 * an interrupt on the companion, so we use the MT6332 IRQ GPIO.
 	 */
 	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+
+	mt6332-led {
+		compatible = "mediatek,mt6332-led";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmic_bl_led: led@0 {
+			reg = <0>;
+			label = "backlight-pmic";
+		};
+	};
+};
+
+&pwm0 {
+	status = "okay";
 };
 
 &uart0 {
-- 
2.41.0

