Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FD7F6F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjKXJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjKXJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:20:56 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5AC10EA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:20:59 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507ad511315so2325656e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700817657; x=1701422457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DI2KlLELwTvapyMM7h7b4FNgZM+UKIo5mOqivYRKFcQ=;
        b=h/zwxNw9wZVEvax5+sr/cST8lUEImYDJX860fA2/p2xguOSxP9fDfV12/AwGwG0Iwy
         BIXEUGBSaHPQ/rNDSSwHSpzhfPKT5vP28Hmsad6qRTAtTVLLoPZTv1pFr/7MvWwjm82F
         79oftRNRl4egAHiaP8mbLg6zX8MUsG/HpnRtNbd3rrTIGf9ziEaPKQocO9PU2jUKmD6u
         8PKPrlW9jaToE4kQFJx4uGbBkJyTfp6Pqa65khJcwROmFp7zPzkTwN38ZVBGGMDf6dVx
         EpFTpbecg1jkdwUJJ8pWnNcoBaTsK6ce1nZ5AntqKgWpeZRa0VhMFFurUct85mEBVQ12
         AkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700817657; x=1701422457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DI2KlLELwTvapyMM7h7b4FNgZM+UKIo5mOqivYRKFcQ=;
        b=Bf4W0Tdh5ddOL8XuIdtZPot3dhWxgfNib3d1HlhHiUaFvLaxEsXH0zlzAuNZtyjakn
         ImAfC64gs5ZEDtc+1SGiaX83usW2gExQHZf9ZsJPkWtDKSw2rahEjVIG4W4Ux/REAuZa
         vJ0ziGnB7DDO/nijmsGpspJ7q5/xsgkplwnZm+XD4rAzPfFYdSaTRetS6b2XTnWr7j2S
         Q7SWb63vP/yBEVCJhHF7e3ffdHUSZW8b5HALxuT3pE5fFqmWNJytgeDm6ABnq9l+oYeb
         9IlaCsvSFq95Bm59pghyT6Gwd7fAMnJw51gGOpcHTnHbhFOsFhHbwIQQThP9ZLEkMaDv
         wIAw==
X-Gm-Message-State: AOJu0Yyk75iIoflw7iRyuSDwZ+1y5G0YHMfODrFAUGNPymWfdTmCo5w6
        6Tsm3DleffVf7Kz8hpzEwNq72g==
X-Google-Smtp-Source: AGHT+IEB7Eq4ep0Ab/R7JR6XS6dqeeDUqJ35AjhfdJsTkQmgV078tnEcrgwqlG8PCbQWRX55aM92+g==
X-Received: by 2002:a19:f816:0:b0:508:225e:e79f with SMTP id a22-20020a19f816000000b00508225ee79fmr1282199lff.22.1700817657699;
        Fri, 24 Nov 2023 01:20:57 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000025700b00332ce0d7300sm3805755wrz.92.2023.11.24.01.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:20:57 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 24 Nov 2023 10:20:45 +0100
Subject: [PATCH v4 8/8] arm64: dts: qcom: sm8650-qrd: add interconnect
 dependent device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231124-topic-sm8650-upstream-dt-v4-8-e402e73cc5f0@linaro.org>
References: <20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org>
In-Reply-To: <20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6655;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Hecb+8Fs+5yMZtc/b7d9bTbZ9Kd5SsXJP66AEs1g8SM=;
 b=owEBbAKT/ZANAwAKAXfc29rIyEnRAcsmYgBlYGrwHWIFDYtTBNQId9DsaDM1w++0MB5yypT6gqyZ
 ecYujO2JAjIEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWBq8AAKCRB33NvayMhJ0e8mD/
 Yswovctg5yW9pWSIh8nS+XEVW2pZoO3LT8/Ki+sT6qEhIlbOM04KjfmQyYAbIrcelHLCvR9sxwJvTR
 f8phEioyOd2HLnEiOdQ/mURg7q+u6Oojc1ZNaQnXMsiUjpQluK4HQP84uHazJI8zoLkg8q5QT1PFLR
 5h+REd8cyldeqtJr1WbTaPP9Ru7HbUSEkqDbGJDgf9dcPl6HzUFluroN+b3CGmcTvPL+vcWF6+d/ZS
 wUBjTBo21c2scsygZ4Gui+T2Sy5C7VoTTwpNyN3xRQ1Hf1j2jRllnTV6hHJLSkz081/40NuGIZeFS0
 unknGgGkhbiWJS8PGai9bSKylDjzrwKBmhaAqC3ecPUZ46E4xr1kMmqvVIvoO6Zwv1xn3BybzQFbpz
 onYr3RtauJfel+f21aiW9GQ5wFZCuTJjohr9l8QtQK53uSwFOdgK2ZwOZEnmbS7MnvnDePSTDpSSYG
 Hly2Vr2QRDA8bEMITEGiUAT5LVRaT9mI9javdD6zqKp7KIjGSLntm4uBAsfOZKHMLF65zyBBjPGAO1
 GhrHuCkUnbzcjQCTlnUnY0hrzTPYwWIbdcjy0Icdd4l2xnggNWcYMGW2X4cl7Oe2lGLGBqgr5CiHW+
 +w6T82lLR0xX/1qx2OZdCr0VwepPmbOTQIbq23NF55nk5A1qTM5JsWvv4T
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 4738112f7ad2..e69ae61b6111 100644
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
+		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync_active>;
+		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync_suspend>;
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
@@ -479,23 +593,173 @@ &pmk8550_rtc {
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
 	/* Reserved I/Os for NFC */
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
+	disp0_reset_n_active: disp0-reset-n-active-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp0_reset_n_suspend: disp0-reset-n-suspend-state {
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
@@ -507,7 +771,16 @@ &usb_1 {
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

