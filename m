Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB637D6441
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjJYH6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjJYH6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:58:49 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF371FEB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:47:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so71603441fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698220075; x=1698824875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfZqFuxDFSAp2iUXDkNDeIV+nI7a+GcxbBKpCBppLPE=;
        b=bLy+hY6RqZt6KMwQcyJw0fFxMW9Sr4YVGkfQHboClEh8oeV/2+ye56jPMpezCU1nss
         lYhbnaknoPvRm2a0i9VXT8JBCqHczg9w8yuUl7t9vkyA2KfeyadmNrvN95i9Wggx9uhO
         I/Rt8KMCsPSAn1UciqmSNPGdyMcW5yYQbHwzBaXdojoWJsWVqJ5SeD2jVudzPzANSOnf
         AEZzdKyrKJ7qfSlMsSEWB6a1Pz6762e0VZauQlg1x0PGoxsHRFZ+gJAJ8e3D9L6dTwoH
         rcQCtbXmo+peSd4ZhWtImiUbnn5ndNYi2HhMCzDDxufoiyBZVQNpmfVdVjdSAVyq6g/v
         6fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220075; x=1698824875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfZqFuxDFSAp2iUXDkNDeIV+nI7a+GcxbBKpCBppLPE=;
        b=D1ltJOWf/n+LaiXdEmHABPRaNnsANij1HnCX0uN4vm7YqZ5rSYwPIUsJlNB1+UO7cJ
         yR9MVT1JSM3+NQ7uUKrYXG+ya7v4ytx/W1hxzc6xnP7aAQWSk25FUXMwnCF0mFQYcoGc
         bsZri/8URoO0rVcILGU8lH9P7o0db+0EfxaPnKYuKJHCfgAQLqu6QAl51Y1ECaXN+JgC
         IK7ckW/gIGaNhXnJVaCvXt0XZdhK98WKr19INPKwVHeZ7LMKb5DA/s2/w7ATLRtNwmqE
         qKlfemzMXDYYyRUl/T/GAC1jSfdlt93f+2gyem5xWA3DuLoyRzPC2RRL5YDqEp/FW5Bu
         ik2g==
X-Gm-Message-State: AOJu0YweEBWbXHfUMv/9QSEWFyhndJVXfuXJkK3a/e9rWdaXub4tEwDz
        /34+szR96vZAN1W2+YbCw/oSzQ==
X-Google-Smtp-Source: AGHT+IEjcmbD3KoXidqJ1WU1X1Pb8CYwWOMEFqMAYLvKNEq4U/i8mzhpyoMvh57Pl8++PogtQoanwQ==
X-Received: by 2002:a2e:b0c7:0:b0:2bf:ff17:8122 with SMTP id g7-20020a2eb0c7000000b002bfff178122mr9943607ljl.17.1698220075314;
        Wed, 25 Oct 2023 00:47:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b004053a6b8c41sm13900970wmq.12.2023.10.25.00.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:47:54 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:47:47 +0200
Subject: [PATCH RFC 7/8] arm64: dts: qcom: sm8650-mtp: add interconnect
 dependent device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-dt-v1-7-a821712af62f@linaro.org>
References: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5762;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uCsbX1UvTNtsmR6bjQQgwQD+F0WW7R3zmgwgdgLZhLg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMghmalTD7z7Wr9k9pbySEN7yW2kakzAaNeKhgwL
 AidptBmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjIIQAKCRB33NvayMhJ0QJBD/
 9FOAJMMq2fGgYj3re8N6yjz7QwrzLKDD67TA0nwTCyeCdDFa+LioF2Jjy1msVs6ykRqFl582YN8Hr8
 iT0IOFqsGwm16CEP8ow67Uv1e1J3RvAS+hVxDmEeu/UWRKHVaBTIaEf9+SdwzDYy8AeNSXggB/9Cet
 mD9xj4XTVilT3egyXU3Fw0bQcrGrNSYOsNlzdLN9Pv8ZidRtrRatKslovgiwDm8PKR5+sz9F41zWIS
 n+7Bu2hKWuDfWrfKOcWcRD/wq5nsnCpHbHbKRVLUyMR9bvpluTGfPRJFtZZYwL/tLbgpwSCsLQGwOF
 jEBKPMYvMWdAao5irVoZqvWYnBUXx1wzYStr5HmT23SDTlkqzoo2caYISIHVnRfcWpSArPYPQf1bE5
 siFdQVeKe3VmT9fLm7Bt8X5yD74zJUeljRJI9y5SEQY5YerKiL9WQkTKUnUW2jWj61ckSWrCl77yiT
 20E4RNNTyoz1t3b372h6JNYIuXN7wCIDC8x51yEe46Ker6OPRnbXQPlA2sGleW7FCzd2FyNZDP7ghC
 wzmwmj31uJb3U9jFCjJKLWKIzbgN9sciwWmS2JwUecrVUDq9bzKsZ0/ljyoYODiHShJbZFh0FnOu+x
 ji281GafgWEeCLxINfEwU6C684ImLtbo/ovn/dETZJrZ9lIg3KU+GAdelZCg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now interconnect dependent devices are added in sm8650 DTSI,
now enable more devices for the Qualcomm SM8650 MTP board:
- PCIe
- Display
- DSPs
- SDCard
- UFS
- USB role switch with PMIC Glink

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 232 +++++++++++++++++++++++++++++++-
 1 file changed, 231 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index a2f3d918e863..1b098237d557 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -28,6 +28,44 @@ chosen {
 		stdout-path = "serial0:115200n8";
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
 
@@ -329,6 +367,106 @@ vreg_l3i_1p2: ldo3 {
 	};
 };
 
+&dispcc {
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
+		pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
+		pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
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
+&pcie1 {
+	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l3e_0p9>;
+	vdda-pll-supply = <&vreg_l3i_1p2>;
+	vdda-qref-supply = <&vreg_l1i_0p88>;
+
+	status = "okay";
+};
+
+&pm8550_gpios {
+	sdc2_card_det_n: sdc2-card-det-state {
+		pins = "gpio12";
+		function = "normal";
+		bias-pull-up;
+		input-enable;
+		output-disable;
+		power-source = <1>; /* 1.8 V */
+	};
+};
+
 &pm8550b_eusb2_repeater {
 	vdd18-supply = <&vreg_l15b_1p8>;
 	vdd3-supply = <&vreg_l5b_3p1>;
@@ -338,18 +476,101 @@ &qupv3_id_1 {
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
+&sdhc_2 {
+	cd-gpios = <&pm8550_gpios 12 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>, <&sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep>, <&sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32000>;
 };
 
 &tlmm {
 	gpio-reserved-ranges = <32 8>;
+
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_suspend: sde-dsi-suspend-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_active: sde-te-active-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_suspend: sde-te-suspend-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
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
  * eUSB2 DP/DM -> PM85550HS -> eUSB2 DP/DM -> USB-C
@@ -361,7 +582,16 @@ &usb_1 {
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

