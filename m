Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5180EC71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376301AbjLLMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376265AbjLLMtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:49:19 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C729B7;
        Tue, 12 Dec 2023 04:49:25 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id A5FFD41BE2;
        Tue, 12 Dec 2023 17:49:23 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1702385364; bh=DBs7WSTRsWsDILHndJynPWxZbqbs68OouyDKWJNsV3g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Dq2QeZStRsBgvXeNeOCBYrOodf6o3G4/jWun3ZOswapINve/6C0SyHFDbuNzpqEVM
         v4AQPR/+lua6VXyzOUwYxd1rVaq26KVzXVf+c+kwGTAo4zDrDAohG6mC53Gc2Rw2Ki
         63XD0vZSqCozO/1uOFFOSKkFPfzEhxwZCapeJKGABTqfWMjDXSae3LFDz8U8lhq35I
         B+saGvq1iokb7/MAeaVh2w9lXJ19fFGvfJaN5ikXQ5zgFDc0c1QqvO7f4YHvd/HhlK
         KzHIB6RIfYvJ6mKO8yjnxe/fy++Dz68oRfzdV0jccR5jhSs7MHxfKG6+nPUf9XnYKa
         FYl1A6UB+c1Lw==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 12 Dec 2023 17:49:11 +0500
Subject: [PATCH v2 3/3] arm64: dts: qcom: acer-aspire1: Add embedded
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-aspire1-ec-v2-3-ca495ea0a7ac@trvn.ru>
References: <20231212-aspire1-ec-v2-0-ca495ea0a7ac@trvn.ru>
In-Reply-To: <20231212-aspire1-ec-v2-0-ca495ea0a7ac@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=DBs7WSTRsWsDILHndJynPWxZbqbs68OouyDKWJNsV3g=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBleFbO4BMOxnuKYg8prK0BAmEHO7knOBgU1+LtD
 sxVx2hHg0CJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZXhWzgAKCRBDHOzuKBm/
 dYeOEACYbgi/Lw+ut86oYgWpI1M/DR7uk3HEOarerIFdTww9LgdSJudP/wlTc7DX4Ppq1THDSr7
 uXsY4W//1+MFSXb70CA0al9vI1UJb6g1ld9FJmvyg+GCNWnCSeDNbCLlobhcXRTUhqK6hFDAh+2
 z9DExuys0gsX4loOqeRU8SgpJidN28k1XHH+9N8uVi59HmbtB/0mf3Wdr4qSYKbRy9WzxIYzjF/
 97GhkqEbKT0NT9kWO5uj286rftE9ygxo1HwBTfjSdf3ljE++d6gZDN7jlUtXhrM7bdL12IbFse+
 nXrtMXjzfmscWLJgett7AcMykrIMTMaXDioz6d7o7TCFPF1scsQ8iSl/KiMEGHLw3hu4Ywgrozl
 F+Pkbwfl6Exv/xThaL2BRYr8iE8ZYarhfAyjMAj1LHJk3dZ5JkiNQgdhwp8UNKEYzxki9t8KtaA
 x5b7SFukBWjdw9uBNGkqLb7DE/YRyPWmq/uwhGdbk6PnywBsCIeyIGN6/HsL8DVl962G56GPBvS
 7wM83YLn29BTkIyfjeFsOaurID0ykyXNMDj2hoDbIj6AE3hQ0eHrIzfJz7ZWCXe4+9mJ3D1pffo
 wLLm4KhNN3kYHe6vheFQCbgJ+CfZMcE3M+QIPEQbbjm6DHfR62IFGZ2Pn9Oeg6KF9ztr4MFHT1h
 yJ/wacIWwonjODg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The laptop contains an embedded controller that provides a set of
features:

- Battery and charger monitoring
- USB Type-C DP alt mode HPD monitoring
- Lid status detection
- Small amount of keyboard configuration*

[*] The keyboard is handled by the same EC but it has a dedicated i2c
bus and is already enabled. This port only provides fn key behavior
configuration.

Add the EC to the device tree and describe the relationship between the
EC-managed type-c port and the SoC DisplayPort.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 40 +++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index dbb48934d499..a29f542fa612 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -147,7 +147,25 @@ &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	/* embedded-controller@76 */
+	embedded-controller@76 {
+		compatible = "acer,aspire1-ec";
+		reg = <0x76>;
+
+		interrupts-extended = <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ec_int_default>;
+		pinctrl-names = "default";
+
+		connector {
+			compatible = "usb-c-connector";
+
+			port {
+				ec_dp_in: endpoint {
+					remote-endpoint = <&mdss_dp_out>;
+				};
+			};
+		};
+	};
 };
 
 &i2c4 {
@@ -298,6 +316,19 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	data-lanes = <0 1>;
+
+	vdda-1p2-supply = <&vreg_l3c_1p2>;
+	vdda-0p9-supply = <&vreg_l4a_0p8>;
+
+	status = "okay";
+};
+
+&mdss_dp_out {
+	remote-endpoint = <&ec_dp_in>;
+};
+
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l3c_1p2>;
 	status = "okay";
@@ -687,6 +718,13 @@ codec_irq_default: codec-irq-deault-state {
 		bias-disable;
 	};
 
+	ec_int_default: ec-int-default-state {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	edp_bridge_irq_default: edp-bridge-irq-default-state {
 		pins = "gpio11";
 		function = "gpio";

-- 
2.43.0

