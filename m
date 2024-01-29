Return-Path: <linux-kernel+bounces-42709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF884055F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0DA1C225E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B04651A1;
	Mon, 29 Jan 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PThqnOsz"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09263416
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532373; cv=none; b=QIEUoX23XAWNx5Oao2xkQQmGpvoPZDcxGUDj8PZ5DNICmrchV8/I+FYeOxcZUFR4d3OsylM6KECiQ1QIvge/a2fl91OwMRxzZastk1tImMH3BSbO1M9/pp2bU6G2IdAxg8QWUCHKhP39aVZ9dDgADTqw7eTKHoahI4orvZClWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532373; c=relaxed/simple;
	bh=ps2ITLtb+wnuPxzAvuaCM3IjDOmZRmy6w8oxvg6tWw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpTPZ7730EKS+ZyrLQOsvMGeB7xJ7EnC0tM2wBe4we6Z6Oue8DDDhl0DjL0wX7hBJ3ixb26c1EXv5HzlXp3/3ZSx7g0sKu712XMxwyNqkrNAy4zUj3h+dqK1ut4DGhKIT0P/n78rbn6QGtMy4paRk25UJm9C7pvWAJNCcihoCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PThqnOsz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a271a28aeb4so307008666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532369; x=1707137169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ro+Hb2iobKdmEbVL0if24hsgyW86TfrhpfzGCL1Ai3A=;
        b=PThqnOsza70sapUg78nVWOjS1qYo0GysUB1dpMxDqKIYiMa+NRrFBk+M3OlA8WeRGM
         tvmh97RalTxsJuM9zuy4Rx4RtLOSeS/MGj64xDQ2GAuk2DXDBTphM5Ncr5usD21v6H0Q
         Aplp4Nw/EIovp6BqmNwaHpPtcKjt6pSTF+sHiIGEemnscLw7iyIXAhTxOfyuMPaj1hU0
         Bna9hEe7pChQwngD4wJIDoWzx7qd7CEkOf2mg+qrGwybGsbxcPJpc1Tchm6T1YZQ4X7p
         EnuIVzfJzgiXSjVDtij5EPud/f4av+h7gDK0JsiXUgHY1rCvD3cVE+bM0GMFHUyxo/fE
         Jrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532369; x=1707137169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ro+Hb2iobKdmEbVL0if24hsgyW86TfrhpfzGCL1Ai3A=;
        b=g7LyRFE8hPI7j4t8UwZAU5s8vECR5T8rs7SOFLyVQMIJnwXZcrSGK93Iym4YS9Ss5R
         NcK+mFkDZBeDejKxY/o4AdI/p2DfDKHnLfMMiHuSYYcJHuZocMAcwv/FrHg8p1DXkSpW
         cyB9PcZhULRk8SVll9PMlykpAVuAI4TkAn8Nk57Z6m7hA2fYamuxhKv4/ZYEvpGdmyNm
         fYf3W0o+dR89I2FlWXRfJyZJzx2CP1HKcvjOSTNGNbzdD0K5mwVnCXWSG5FsxzLeMnhN
         L6fRIGTKUikrEszng8UskrNdyDu8KLuj2kWGhtU+SvKaObR+RTro9gNIQr6sVlDH64gI
         /eIQ==
X-Gm-Message-State: AOJu0Yx10dRweIwZV350sWS34G4vAnaftvS/DXvXAdN8+Y1wt++jceDE
	otYX9RzYUrI6ql9i677thpZJ1arih90qN/kevF4sw7cVK8mUt5NPco1/aSnVkAc=
X-Google-Smtp-Source: AGHT+IHAZ9w16TCIpPtxLuEGNNo9TEYGlR4nLJwR1XDEizv/lkSC/8FtiYGbQ0rA+ItjrIPJjEdwmA==
X-Received: by 2002:a17:906:7185:b0:a35:ec2a:2974 with SMTP id h5-20020a170906718500b00a35ec2a2974mr717479ejk.37.1706532369446;
        Mon, 29 Jan 2024 04:46:09 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906329400b00a3527dba974sm3041495ejw.35.2024.01.29.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:46:09 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 14:45:41 +0200
Subject: [PATCH v6 09/11] arm64: dts: qcom: x1e80100-crd: Enable more
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-dts-missing-nodes-v6-9-2c0e691cfa3b@linaro.org>
References: <20240129-x1e80100-dts-missing-nodes-v6-0-2c0e691cfa3b@linaro.org>
In-Reply-To: <20240129-x1e80100-dts-missing-nodes-v6-0-2c0e691cfa3b@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4648; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ps2ITLtb+wnuPxzAvuaCM3IjDOmZRmy6w8oxvg6tWw0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt54Bm/Zrq/t46ip8TNBXID2gW/x65RlJqDzoF
 4IvRhAWkMGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbeeAQAKCRAbX0TJAJUV
 VoihD/4/HXcbYu3P/llByOnQLBZ2W/WXRv/V+W+S9oPmvQszjvjs0yI+z4xdh401t3MEXr5+nio
 sxWwnNz3BQPMRG64Uk9DN9XD03WJVzS5qWb9feT/WFcRpfg3w79sFwCiUls1yB9KxeUl8TZgocO
 MqlNDo97e4hlvUIqSbCaMe79s4LCn9MCUMbrG8v6sGX9tEsJlCHlHQ7DF6Mef2U+iQWKgdWeGSj
 GIErdITrVO2YHEhcvyxwlHpfjisF38u67AgpXI5l1x0tZZNYH8O4+nZXMAk91T8mhl6YILNuhp9
 VKQlMYVLnkbaNPwMMkLO6CkLeg8ufWSRKDt0eyAw4+YGRlC4fM5s+PwSljD2ViKUczCkTIDLe+A
 vjQFRqs9oK+DIBmG1I33p7W0TWvbdMRHiU6yK1GFxFDsv6W2KfI4F7DwrKUfatDT3NaMzi0wgRY
 jD5o0ZOxiXu1Nq1JQUis6cA+w2btSeku/OFnirQhrbCZe4IymS7kwBj/kdVYBTQWmBus5CtSlAV
 qG8eI8Iojud+u6zrtlFmcN+KIY7foBytGj/0RsJMmvETsC1/M/uPtj6q6dzMCN9dW2dYqwlU0/2
 aKXwxkjdp8JXy8r/KMnHe6AqxA03hqPDfAWalFe695pziLH2m4bC4Ido7JP/bQyOxKwRoo6c2FW
 6i/MQ/25sJqCkUQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Enable touchscreen, touchpad, keyboard, display, pcie and usb
support.

Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 222 ++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 7532d8eca2de..7e7cc8e43f87 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -401,10 +401,145 @@ vreg_l3j_0p8: ldo3 {
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
+		pinctrl-0 = <&tpad_default>;
+		pinctrl-names = "default";
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
+		pinctrl-0 = <&kybd_default>;
+		pinctrl-names = "default";
+
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
+		pinctrl-0 = <&ts0_default>;
+		pinctrl-names = "default";
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
@@ -416,9 +551,96 @@ edp_reg_en: edp-reg-en-state {
 		drive-strength = <16>;
 		bias-disable;
 	};
+
+	kybd_default: kybd-default-state {
+		pins = "gpio67";
+		function = "gpio";
+		bias-disable;
+	};
+
+	tpad_default: tpad-default-state {
+		pins = "gpio3";
+		function = "gpio";
+		bias-disable;
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

-- 
2.34.1


