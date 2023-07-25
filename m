Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D267617BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjGYLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGYLw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:52:28 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F101BD3;
        Tue, 25 Jul 2023 04:52:15 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C81F341880;
        Tue, 25 Jul 2023 16:52:10 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690285931; bh=RUps6PopX2ku8ErEBIrgx3LvDP36tqffz3C5r1M0VFs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OxiIL/3jl1aX5rvzmlFJCA/9r9giekZ57Vpjk0BtgsL0pvtQHnKpVlfDkXezGggGf
         o6qxDZlzVuGFuPTFGCmqW3I8oWFHTr05omGBM1frAGlS1MeW3hXi2SFExEAO40Tdss
         J2hApsvUrn813UInyg3yTv2wY2nrcWZXZUtwKKuLo6Hk04wZPOEX+WxqISJmRWUzI/
         Lsx7nqgSg27ibDtH9SYvygtQkNbAZLHXoPFOStPx8tvYH3eXotXMwNOfTgatrUTX2R
         VTiotNvfNb4OVL/pKPU5pMMvDg5xWLUy9VQnw/X2fHPVdve9iu8Wj6yhlpJp6BYpfP
         YTqVwEAMrIiHQ==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 25 Jul 2023 16:52:01 +0500
Subject: [PATCH 1/3] arm64: dts: qcom: msm8916-samsung-gt510: Add display
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-gt5-panel-v1-1-7c787e33a614@trvn.ru>
References: <20230725-gt5-panel-v1-0-7c787e33a614@trvn.ru>
In-Reply-To: <20230725-gt5-panel-v1-0-7c787e33a614@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Jasper Korten <jja2000@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3112; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=0/d3sA1E5JApHXP6QSInsn1IxG7BJaIv3XlGtvhE8MY=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkv7dmK4jarlcrSCdJTR26kPJdBtOZjH4dE8SnD
 JKgl0voQZaJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZL+3ZgAKCRBDHOzuKBm/
 dcWmD/9oMJr/DTfjPDNj+MqZFLgQjefgzc99ck0IT6GD2g7PsUgc4BxWxnAOb/zDKCmMt+ZHLIf
 fOaMuSLIKyKncIKAgSBBKUajyGNIH6xzct5NCPx0SaR9NP1cKc+z1bHae6i7C5z3Q27RHurLfkA
 BXPXWYK+TrYMPJwIw3mSd5eJXxedA55THuOvsyb4K0Gn+GWvmpB+Vsg9gvoUHtoTTTaBsfzYoZz
 1hBT3bi97Ty1gzfJBiyt5N6WomW3gMXAuP/PfV/PvqkQkj1U682nJ/BhHbnG0Vh6aRx6nQRCxND
 3O8N5RG9N/Fk3vhG6tD5MpqefDC1m9PSPTc4M90qgXK72dwBZKqvQutjUQzyK9KghOdnegxhn0/
 c/gMUKuk07SvaT1csuvRfrN0mDJ5co8bAlii/FCQ5foR5Kq1bpvYQntGlbmchxRNiJ0tGqeWKPU
 ATVt7Y75G+2C2zXlYpUorfvcR1HL/KSUDS23wGo9zAcgci++WOUO0XaZAXlcy5YjB/NJDZgKXA6
 p57y0/X7OkSg7LaXDe+qnwdaw2h1ji5rl94LE0X1SZXLdeRhNXVsmCZWL7trBpzfnO+GkEpLFca
 OJdlsS2LgqzlXC62otEaG6En2EUoNL7PUFVx2ONBQUWsXIVh9WGrOBqgJHKc6MBIvPB4GSsjTjC
 yc+hUZhSi50xFaA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasper Korten <jja2000@gmail.com>

The device has a 9.7 inch ltl101at01 display. Add it to the device tree.

Signed-off-by: Jasper Korten <jja2000@gmail.com>
Co-developed-by: Nikita Travkin <nikita@trvn.ru>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index 48111c6a2c78..a73cc7565bfb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -19,6 +19,19 @@ clk_pwm: pwm {
 		pinctrl-names = "default";
 	};
 
+	reg_lcd_vmipi: regulator-lcd-vmipi {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_vmipi";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&lcd_en_default>;
+		pinctrl-names = "default";
+	};
+
 	reg_motor_vdd: regulator-motor-vdd {
 		compatible = "regulator-fixed";
 		regulator-name = "motor_vdd";
@@ -55,6 +68,19 @@ reg_tsp_3p3v: regulator-tsp-3p3v {
 		enable-active-high;
 	};
 
+	reg_vlcd_5p4v: regulator-vlcd-5p4v {
+		compatible = "regulator-fixed";
+		regulator-name = "vlcd_5p4v";
+		regulator-min-microvolt = <5400000>;
+		regulator-max-microvolt = <5400000>;
+
+		gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&buckbooster_en_default>;
+		pinctrl-names = "default";
+	};
+
 	vibrator {
 		compatible = "pwm-vibrator";
 
@@ -84,7 +110,44 @@ touchscreen@4a {
 	};
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	pinctrl-0 = <&mdss_default>;
+	pinctrl-1 = <&mdss_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	panel@0 {
+		compatible = "samsung,ltl101at01", "samsung,s6d7aa0";
+		reg = <0>;
+
+		power-supply = <&reg_vlcd_5p4v>;
+		vmipi-supply = <&reg_lcd_vmipi>;
+		reset-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in>;
+};
+
 &tlmm {
+	buckbooster_en_default: buckbooster-en-default-state {
+		pins = "gpio51";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	motor_en_default: motor-en-default-state {
 		pins = "gpio76";
 		function = "gpio";
@@ -97,6 +160,27 @@ motor_pwm_default: motor-pwm-default-state {
 		function = "gcc_gp2_clk_a";
 	};
 
+	lcd_en_default: lcd-en-default-state {
+		pins = "gpio8";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	mdss_default: mdss-default-state {
+		pins = "gpio97";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	mdss_sleep: mdss-sleep-state {
+		pins = "gpio97";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
 	tsp_en_default: tsp-en-default-state {
 		pins = "gpio73";
 		function = "gpio";

-- 
2.41.0

