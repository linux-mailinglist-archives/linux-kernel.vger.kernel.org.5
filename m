Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A680E903
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbjLLKY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346129AbjLLKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:24:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B226B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:24:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so727598166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702376668; x=1702981468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kn8T4geUNDrQxq4SAkCj27jvGjfSNhMK9r+in1Y7ErI=;
        b=Emua/BKyA4l87879pn59UXf+rQBucTRD4NZ7ISyWtRUY6MaOWq3llXm7zpQAUMOhVq
         102KHKez0l5MxnullkVxAckUElq+eetzpGNNOnV+P7hVItIN0zqe3Mx3FAncBtFOKKCE
         XX2mCWsUMltIzvrtP88J3unrsmXIA4Ts9nbFnitFmEZcSH6bi+CWIMzhLa+4Nz5OGqtB
         eQ4er2+hkn1Gk3g1epLXbWCDzBQGAV6YHie2ulaCqqIVnHRwro2D27CmpUxW1TACbbBR
         FkkrP8PX4OhqAKjJnErJz3+laulDZLDMLb+CRvO2zYo3syjjSeryKhPMJTLgYJSGsn6/
         VURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376668; x=1702981468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn8T4geUNDrQxq4SAkCj27jvGjfSNhMK9r+in1Y7ErI=;
        b=LlkW7FWOwSc7zkQhk8DCNEBIH8Dee8OoiiES1a6qmObx/Zo/bJ95P8r8rdQ+z2AYdU
         Yrk3GE5ea0eLfmnmfvfBBnKUhOjWLbDhDmHHirPywTxqOZXMIMMtiU3HrN9DjQAC6LND
         bkNfuG4LtX6cCEkLbtnJcWpUTYSa7ZumFMysgPhLkBd8wnxrrLqRxm6C/TO0VxGT7sEH
         wFRkck81xNH0ZAJL6WZTOBuWviNj3N9lolR6cM4ERhHqnT2Mi5O9U2o1tEds0bGwyexV
         u9/PLqFydsp9F+kxcBGY756nZhYnE9anraJ9xPf08Ab1EVWscmwV5/BNDfzwEBgB2Oyq
         VORw==
X-Gm-Message-State: AOJu0YysnJhNb3Sp+rfJAkLKhiam3QW2KSIzzZ9zh/JJV5jQ5hCfQXvw
        pvcYIUuHa6FWQc4I5NpoHsmXKQ==
X-Google-Smtp-Source: AGHT+IGON85hoGNwaEu4lxAmS+AbUhitSDbzT+qME7DDfU5Uaxyh5ORVctoMutfowP6DZ9PITW4y3g==
X-Received: by 2002:a17:907:7e98:b0:a1c:cd3b:4c2a with SMTP id qb24-20020a1709077e9800b00a1ccd3b4c2amr3824131ejc.72.1702376667950;
        Tue, 12 Dec 2023 02:24:27 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id ga16-20020a1709070c1000b00a1c7f8fe581sm6052801ejc.221.2023.12.12.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:24:27 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Tue, 12 Dec 2023 12:24:11 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: x1e80100: Add missing nodes for CRD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-x1e80100-dts-missing-nodes-v1-2-1472efec2b08@linaro.org>
References: <20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org>
In-Reply-To: <20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6276; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=XR8LxnOXnvA8HSaw+rQ/XKUf1pREKrP/blFUFB5Df3w=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBleDTXs3AOsZgIEnjk7D0JoQyxmT0g6eGz8p6u9
 dS3psRliiWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXg01wAKCRAbX0TJAJUV
 VvBBD/9ZFlMm1un+fFyID/DlOisueviMby2gyRgwRWzek7cRDSdwT7iHDQBKc1U4nCVTeIo52Q6
 Zz+zb0asAuuyLrqJy7/Ve8tYMWla9dj26nY88hm4iHhPBAfGWtUM1B8a0w/IIPOq7FTQnHSDGUr
 2PViml2aSE83EQBnGhiBCLuziMhQzKA7ZaCOeP0O+NIpbkompo35fKzirQ08k3ZNECwqq4S61JD
 RPdN1dfGMz8SEhY68Spz1CTKgaXMyGxyFrb0FyTy8+yY56guJg50Gnc6VNG+zDblVQvlnj6MYLu
 Hu9pfcdajYTqymCRLCRkufj5XfIZujjWYlJgC7/c1fw86mdbeGVlGyHavYVSB/CW8QvMNafWzTh
 uPXMOgdw9cqvhhErKWn/RzP+BTFlykhfzlg/J5gqaXC1Gx1Mv75Zm7P27LI/uUrfTUfLCUHHh6w
 27M2obeE7F958VyF7DkyvzzbTnCP5YDW2RTFcaqTACe8k5FyuQUcgULRvIWybmiVQXJUzxy6I36
 A5/KniJEs5LJpeT6tqHSzWpekbnnPGafz0zb6vNbZ2a6g3N1KOZ32V23ZstxrQ7H7JBcDenQKE7
 EHTSd5uWbi1o4hUpAbNZX36/yvvcQJyIRC0PIRckwCHx7K/EDiZOV9tIcuo9cIbUxrTnU5lwZaf
 GwIFZiJsD7/UwNQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all missing nodes for the X1E80100 CRD reference device.

Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 303 ++++++++++++++++++++++++++++++
 1 file changed, 303 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index c209ae59c6b5..4f7f83d49847 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -22,6 +22,72 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	pmic-glink {
+		compatible = "qcom,x1e80100-pmic-glink", "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss0_in: endpoint {
+						remote-endpoint = <&usb_1_ss0_role_switch>;
+					};
+				};
+			};
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss1_in: endpoint {
+						remote-endpoint = <&usb_1_ss1_role_switch>;
+					};
+				};
+			};
+		};
+
+		connector@2 {
+			compatible = "usb-c-connector";
+			reg = <2>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss2_in: endpoint {
+						remote-endpoint = <&usb_1_ss2_role_switch>;
+					};
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 
@@ -403,10 +469,144 @@ vreg_l3j_0p8: ldo3 {
 	};
 };
 
+&i2c0 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpad_default>;
+
+		wakeup-source;
+	};
+
+	keyboard@3a {
+		compatible = "hid-over-i2c";
+		reg = <0x3a>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 67 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&kybd_default>;
+		wakeup-source;
+	};
+};
+
+&i2c8 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 51 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts0_default>;
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dp3 {
+	compatible = "qcom,x1e80100-dp";
+	/delete-property/ #sound-dai-cells;
+
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			power-supply = <&vreg_edp_3p3>;
+
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&mdss_dp3_out>;
+				};
+			};
+		};
+	};
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss_dp3_out: endpoint {
+				remote-endpoint = <&edp_panel_in>;
+			};
+		};
+	};
+};
+
+&mdss_dp3_phy {
+	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-pll-supply = <&vreg_l2j_1p2>;
+
+	status = "okay";
+};
+
+&pcie4 {
+	status = "okay";
+};
+
+&pcie4_phy {
+	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&pcie6a {
+	status = "okay";
+};
+
+&pcie6a_phy {
+	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-pll-supply = <&vreg_l2j_1p2>;
+
+	status = "okay";
+};
+
+&qupv3_0 {
+	status = "okay";
+};
+
+&qupv3_1 {
+	status = "okay";
+};
+
 &qupv3_2 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/x1e80100/adsp.mbn",
+			"qcom/x1e80100/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/x1e80100/cdsp.mbn",
+			"qcom/x1e80100/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <34 2>, /* Unused */
 			       <44 4>, /* SPI (TPM) */
@@ -418,9 +618,112 @@ edp_reg_en: edp-reg-en-state {
 		drive-strength = <16>;
 		bias-disable;
 	};
+
+	kybd_default: kybd-default-state {
+		int-n-pins {
+			pins = "gpio67";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+
+	tpad_default: tpad-default-state {
+		int-n-pins {
+			pins = "gpio3";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+
+	ts0_default: ts0-default-state {
+		int-n-pins {
+			pins = "gpio51";
+			function = "gpio";
+			bias-disable;
+		};
+
+		reset-n-pins {
+			pins = "gpio48";
+			function = "gpio";
+			output-high;
+			drive-strength = <16>;
+		};
+	};
 };
 
 &uart21 {
 	compatible = "qcom,geni-debug-uart";
 	status = "okay";
 };
+
+&usb_1_ss0_hsphy {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&usb_1_ss0_qmpphy {
+	status = "okay";
+};
+
+&usb_1_ss0 {
+	status = "okay";
+};
+
+&usb_1_ss0_dwc3 {
+	dr_mode = "host";
+	usb-role-switch;
+};
+
+&usb_1_ss0_role_switch {
+	remote-endpoint = <&pmic_glink_ss0_in>;
+};
+
+&usb_1_ss1_hsphy {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&usb_1_ss1_qmpphy {
+	status = "okay";
+};
+
+&usb_1_ss1 {
+	status = "okay";
+};
+
+&usb_1_ss1_dwc3 {
+	dr_mode = "host";
+	usb-role-switch;
+};
+
+&usb_1_ss1_role_switch {
+	remote-endpoint = <&pmic_glink_ss1_in>;
+};
+
+&usb_1_ss2_hsphy {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&usb_1_ss2_qmpphy {
+	status = "okay";
+};
+
+&usb_1_ss2 {
+	status = "okay";
+};
+
+&usb_1_ss2_dwc3 {
+	dr_mode = "host";
+	usb-role-switch;
+};
+
+&usb_1_ss2_role_switch {
+	remote-endpoint = <&pmic_glink_ss2_in>;
+};

-- 
2.34.1

