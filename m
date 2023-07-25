Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5427617BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGYLyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjGYLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:52:30 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE381BE8;
        Tue, 25 Jul 2023 04:52:16 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6BC26423AB;
        Tue, 25 Jul 2023 16:52:11 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690285932; bh=fyMm2t4m6xIpnCBIcX5cuprXKyMw1CyD+gyElDFVFNM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LTzpz2P2YLCcDU1hjNn3fmbIDtcyX35Znp87IpvUYL8sY8qGrXAQIS5WrmEgv24R1
         8NI3cbBuR6BPNy8b89mGQe3gOpKoWK6lisNuhxwX7ffpgP2Cu8nhM4lWJtxi/d1OLN
         RN6JOrDmMeB2SptP0Zq7iM71eoQNNFGQ0JF7gowFhV0vOY2+Um3Oy1u1hl9xkvbWwL
         iVlK5hEagOjeBDJ76H0UXt+h/UVwPPQc43+gn4LOa2qc2RHQG64Xh2aeifZb9VO84N
         XsxQUZ6yyalylwsTGPklz39Ses/dqpoeutQqOBDj8iNXq2SsC+0Ltp80HquP9lwsmi
         NjSAGeOBYLM9g==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 25 Jul 2023 16:52:02 +0500
Subject: [PATCH 2/3] arm64: dts: qcom: msm8916-samsung-gt58: Add display
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-gt5-panel-v1-2-7c787e33a614@trvn.ru>
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
        Siddharth Manthan <siddharth.manthan@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2317; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=jDl6DAGTdFMiixmvxC2DHjeaMj2W4do/LqT2Lse+7AE=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkv7dmp+rv6fO6oYpKFLwcXQNj6XQgf43zg9RVN
 oxO+xLqWT2JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZL+3ZgAKCRBDHOzuKBm/
 dXhPEACDIp4Jsm43S2W0QVuE06nNbBD0nKlb94HIDG9tU1irnRLhqXhydFG5pq8xuXKKR5Gk7Fb
 Kf86jAHZqML6qxclQ2NcovMuFwCRt646PNTmlnUIfzkGnHdD9B93As2xkEefPQVSn9DrRkWwmq8
 1CWPaA4Ld6P4VE4FlIUMXqIHP879mtv3HL5T7GGe7Or/RJaDM85JMuTIrIfEip7aT3AtuuePj0V
 L1EQipmMfRBrXRUtzZbmHTB6EgDKsAQVywGNaWw2uiq8j9rWB2DpILhQAyEKG+h695dP0xjX9EF
 eA1ZFodV+QihCKJNd1sVbnYjkSt38qbgMy4dRFqNOCmMDPKfc466M/NGoOGvJHmWHttdUb8/zFB
 5+loBPMMTqeoEh5Ohgr9CuPGdJCR7cQZcjRZ3TWKqWwr6+G156amJ2LRQYuZAbf9+9bD4lbYkKs
 htTBHQqOmGCrp8qNW1PwXgN7+4Ls71cQRhbPgPlXEclH4RtbhWR384w7eqAU5aIpd7RlkX4toWT
 CVW3QnpbxPdVqI+i6u54SXYpW0PYFI3Xjhs3KAWuY5kPmTHpE/ip4nzYDQIkRUuGEgzYSboGFH+
 UwWur+KhWosPtxYW8aH4hOOO2I+NBLgmjgWwuRf9/m3NWqKvRh+qEKopWICUjrv4m0YKkyY7NCu
 /wBgkiJ7PXVTafg==
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

From: Siddharth Manthan <siddharth.manthan@gmail.com>

The device has a 8 inch lsl080al03 display. Add it to the device tree.

Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
Co-developed-by: Nikita Travkin <nikita@trvn.ru>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts | 64 +++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
index 98ceaad7fcea..11359bcc27b3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -9,6 +9,19 @@ / {
 	compatible = "samsung,gt58", "qcom,msm8916";
 	chassis-type = "tablet";
 
+	reg_5p4v: regulator-5p4v {
+		compatible = "regulator-fixed";
+		regulator-name = "vlcd_5p4v";
+		regulator-min-microvolt = <5400000>;
+		regulator-max-microvolt = <5400000>;
+
+		gpio = <&tlmm 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&buckbooster_en_default>;
+		pinctrl-names = "default";
+	};
+
 	reg_vdd_tsp: regulator-vdd-tsp {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_tsp";
@@ -51,7 +64,58 @@ touchscreen@20 {
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
+		compatible = "samsung,lsl080al03", "samsung,s6d7aa0";
+		reg = <0>;
+
+		power-supply = <&reg_5p4v>;
+		vmipi-supply = <&pm8916_l5>;
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
 	reg_tsp_en_default: reg-tsp-en-default-state {
 		pins = "gpio73";
 		function = "gpio";

-- 
2.41.0

