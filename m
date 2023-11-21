Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890F7F2B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjKULA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjKULA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:00:27 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E8F18A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:00:18 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c876f1e44dso34060531fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700564416; x=1701169216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suXVDrXbdcl3hiQV4w7h/YnoQgstL3MlxG7ceiqyqWQ=;
        b=KntxO/UmqoUUfAql8RWYqqOFJXgR3Ctgn5W1zM6X3kQb3psCgGSsv4jmGPwbQkdToD
         0VxzQ9Y7X8SkqRTzz7+m0I1l9fn1IxbydhKwE/u5XLVlYKXU3VkTjY4FD++4SJUt5q+K
         iUPPirAADcxY1RnY8ehfDUZhL6sR8dA3KFWYAYq2uhZM8KpcfQrv7+Rsi7aMw4Wzyllb
         LR5V4F7Nix5+gyWOMN6GvoDgfw1jCtzVpiezInmbC4Vl/jQGHkRJ7+NLtsAfSgNMrPfo
         Dgwa47Ip78ulePeq2xkK5+SyODEpJyFDy80e/h5/KE47Blv5JGt9e7wVqbUp0UIgcywe
         XwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564416; x=1701169216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suXVDrXbdcl3hiQV4w7h/YnoQgstL3MlxG7ceiqyqWQ=;
        b=vLY4V1XqJTT7tMbmReNuKf2e+lVWeKdq1sA8G/Ay7U0XU9LpAeK9sY1yUCZYnX1VQl
         WWWA+nSV5Ioossye+oYvD56WLRxMwT+rbWsrKSitDfHSIP7F4LU88LHrus/CP7B47b0i
         ntprCpx9Mv/F6nR3ays6rTvYHtQ0Z4/O+uTeyqgFNbZD35bD7A1WVTcWZW+DEE+w3PTI
         HPmJQesvwLnZVpRv8db2xR42XXkfUxUv/TPgpcG54L/eEyolDLntPDmfJVgherKLbMUF
         ZiqxV/taUOC0tSAmrGeegmT5PiegrInA5obL/XmbckYURgyKw64MPEl1f0+m33IfPixM
         q9jg==
X-Gm-Message-State: AOJu0YwQ0gzX0+Y1c7C2zU4xvmwZ1n4RCMG/QXvPO+wYuPQCLuRB3Dun
        eFhWPTJVIPCTQNJYIzwgVEt7EQ==
X-Google-Smtp-Source: AGHT+IHkE3aact1VajDnjh/3Cd2q/pYbV92o62XndvugmT7qPquOCtPtJ6lE2pF7XNGAWlGKRk/kAQ==
X-Received: by 2002:a05:651c:10c7:b0:2b9:f13b:6139 with SMTP id l7-20020a05651c10c700b002b9f13b6139mr7603030ljn.20.1700564416332;
        Tue, 21 Nov 2023 03:00:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f1-20020adff581000000b00332c0e934aasm9028500wro.44.2023.11.21.03.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:00:15 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 21 Nov 2023 12:00:07 +0100
Subject: [PATCH v3 8/8] arm64: dts: qcom: sm8650-qrd: add interconnect
 dependent device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-topic-sm8650-upstream-dt-v3-8-db9d0507ffd3@linaro.org>
References: <20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org>
In-Reply-To: <20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6618;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=s8Jug7UzjSJUjX2kmC+Rd7PGDEaDh2r9luvG/3xwuDc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlXI225/qNqRa1tRwBvsrBd156+1/PAKOh/xh3dSXG
 hj99OqeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVyNtgAKCRB33NvayMhJ0QP1EA
 CD6pxbPy3N48mjR3jozx39EyatDsoglotKsaAhtMYFHmTMdK+ivHH9+FBnJRDw3aQttHJhG7saPAZq
 KWbA27uolw8c6xv+GDZAlIP49zj30YY1NgGancLLgqE5b8Bbn5aWNk+fYAAMQ5UxKsv46ckQPcz4NT
 cWlhMXu4VIcaR8J4xFeqBnVOirzilbaekK+iwYMApCJRCoTtXkwi80NUPBkH5LJFL4+nqR9PyGoPSc
 Ry0pHZeA6z7cY736n5x4xp2KrDS1qHJ1qreDAYY8DD6fNqsoHy7eNKSvlH1fqMwmfi0TQ3aa9ffF4N
 bzxei7330NM678RWkcTvJEKqHd6KA2G4AZCwkrZ2XYz0rU2MM03eyDL7fddIAKvY18Vt5Vj7sysXHi
 21UUHJVNtr9SV1vMumbnHa0y1vGRxdyJYdqqXVIxGlHbe2vICsSWehY3serx0k6Hr3FEz9owFERsBK
 /NXB5EzFHnvmj+4Ngi58DktdQry1ctLJAQO+kyooqpJLU4y/XDvoTikrTAZ4/hkhacgq/jCGfCj+KE
 kqL5l1rBUIPVDr7k/p12uYPQzkp7mp7jcAFEudkSEM2VRra2PE2wgwOlRYrSQ4+Sfeb/RDMQQlDdwl
 1YVaZ+ZMjcWKo8ChOPmsHBpgDjo62AhXzn1Sb/hw2qzQEwei1nETcFAuAd0A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now interconnect dependent devices are added in sm8650 DTSI,
now enable more devices for the Qualcomm SM8650 QRD board:
- PCIe
- Display
- DSPs
- SDCard
- UFS
- USB role switch with PMIC Glink
- Bluetooth

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 275 +++++++++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index f5ce4c889680..b41f90d817bb 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -23,6 +23,7 @@ / {
 
 	aliases {
 		serial0 = &uart15;
+		serial1 = &uart14;
 	};
 
 	chosen {
@@ -45,6 +46,44 @@ key-volume-up {
 		};
 	};
 
+	pmic-glink {
+		compatible = "qcom,sm8650-pmic-glink",
+			     "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 29 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss>;
+					};
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 
@@ -399,6 +438,81 @@ vreg_l3i_1p2: ldo3 {
 	};
 };
 
+&dispcc {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l3i_1p2>;
+
+	status = "okay";
+
+	panel@0 {
+		compatible = "visionox,vtdr6130";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&vreg_l12b_1p8>;
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&vreg_l11b_1p2>;
+
+		pinctrl-0 = <&disp0_resetn_active>, <&mdp_vsync_active>;
+		pinctrl-1 = <&disp0_resetn_suspend>, <&mdp_vsync_suspend>;
+		pinctrl-names = "default", "sleep";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l1i_0p88>;
+
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
+&pcie_1_phy_aux_clk {
+	clock-frequency = <1000>;
+};
+
+&pcie0 {
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l1i_0p88>;
+	vdda-pll-supply = <&vreg_l3i_1p2>;
+
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
@@ -479,22 +593,172 @@ &pmk8550_rtc {
 	status = "okay";
 };
 
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sm8650/adsp.mbn",
+			"qcom/sm8650/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8650/cdsp.mbn",
+			"qcom/sm8650/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm8650/modem.mbn",
+			"qcom/sm8650/modem_dtb.mbn";
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32000>;
 };
 
+&spi4 {
+	status = "okay";
+
+	touchscreen@0 {
+		compatible = "goodix,gt9916";
+		reg = <0>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <162 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 161 GPIO_ACTIVE_LOW>;
+
+		avdd-supply = <&vreg_l14b_3p2>;
+
+		spi-max-frequency = <1000000>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2400>;
+
+		pinctrl-0 = <&ts_irq>, <&ts_reset>;
+		pinctrl-names = "default";
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <32 8>;
+
+	bt_default: bt-default-state {
+		bt-en-pins {
+			pins = "gpio17";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		sw-ctrl-pins {
+			pins = "gpio18";
+			function = "gpio";
+			bias-pull-down;
+		};
+	};
+
+	disp0_resetn_active: disp0-resetn-active-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp0_resetn_suspend: disp0-resetn-suspend-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync_active: mdp-vsync-active-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync_suspend: mdp-vsync-suspend-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	ts_irq: ts-irq-state {
+		pins = "gpio161";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		output-disable;
+	};
+
+	ts_reset: ts-reset-state {
+		pins = "gpio162";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+};
+
+&uart14 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn7850-bt";
+
+		clocks = <&rpmhcc RPMH_RF_CLK1>;
+
+		vddio-supply = <&vreg_l3c_1p2>;
+		vddaon-supply = <&vreg_l15b_1p8>;
+		vdddig-supply = <&vreg_s3c_0p9>;
+		vddrfa0p8-supply = <&vreg_s3c_0p9>;
+		vddrfa1p2-supply = <&vreg_s1c_1p2>;
+		vddrfa1p9-supply = <&vreg_s6c_1p8>;
+
+		max-speed = <3200000>;
+
+		enable-gpios = <&tlmm 17 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&bt_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &uart15 {
 	status = "okay";
 };
 
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l17b_2p5>;
+	vcc-max-microamp = <1300000>;
+	vccq-supply = <&vreg_l1c_1p2>;
+	vccq-max-microamp = <1200000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l1d_0p88>;
+	vdda-pll-supply = <&vreg_l3i_1p2>;
+
+	status = "okay";
+};
+
 /*
  * DPAUX -> WCD9395 -> USB_SBU -> USB-C
  * eUSB2 DP/DM -> PM85550HS -> eUSB2 DP/DM -> WCD9395 -> USB-C
@@ -506,7 +770,16 @@ &usb_1 {
 };
 
 &usb_1_dwc3 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_dwc3_ss {
+	remote-endpoint = <&pmic_glink_ss_in>;
 };
 
 &usb_1_hsphy {

-- 
2.34.1

