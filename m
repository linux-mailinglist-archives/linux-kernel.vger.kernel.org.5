Return-Path: <linux-kernel+bounces-35148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C6A838CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA19228AEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915815F86D;
	Tue, 23 Jan 2024 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMRjWBSE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B78E5D725
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007728; cv=none; b=ovcSNjnVLeW7ChBQ7J+D6doUcjJJzpOFz4IXJeni04lveApZ3YgHon4fNVdeJ9CWRmmmZ1ioXN+KJNsGgHf7m7yfQSUbwYnBXvxCSS7VIGLGgDBcHBSWt7GXOJ9rUICoKgsxF82CwQ8Z7ItpNYQaYMSvwqaslffRwewNX2DgX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007728; c=relaxed/simple;
	bh=b5me84CBLvNcqpO40KkAROvLnJP/DZ8uuhWcZAxxBlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBZ+blbQiUeFDXdLLqMmUZ28dEbJqTNcZoaQ5/AvY7J0XdIW98fUFYLfWv+qhC0vG4eoy4Sht92w6+Dwd/QApQ7JzbIrj8n9vsYmzgiN2WzTQCRkO8qgd02xEmlRIgp0w3AjCE6WIRFFiFFn4Bv928Hct5mXId8kpOu53PkAv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMRjWBSE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a90b2b554so2889884a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706007725; x=1706612525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHRWIZ6AIyJhvIjYmGETHUbdnTVzo35SA3ucS7gN62w=;
        b=WMRjWBSEacQO1gpONRseFhjtor7qzcI+XTkKiiOMwLkxMYaiTnEVCoPAw7L2kE+tu7
         Lhi0IGQ6KUVcxR5lzkLMgDcArkm2fMqEF73NvAN8paHCKpe++1Y06atCvwmmzDE6HdMz
         ZMxJSd1qzIBlt1+zppba+NKWv91FOAg/sVDwcT9IUmNobEmIllD8R2fLiIjoc6sPaqz+
         gVsxHyVv9mv9P8YEJLz28eiJRoFpnQ9h6S7A3Y3CNJGtPZ/Nj3eqRpVhpTcpc9sXg1QF
         mwl2iOs3LxBSp3dJO36tP7YERqkyw67ZkCxZ/vEC/FtqRyMZ9vpegTwrVKqkxRVAKvk1
         5LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007725; x=1706612525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHRWIZ6AIyJhvIjYmGETHUbdnTVzo35SA3ucS7gN62w=;
        b=hL39QBYinQsWnFjnjU3xOHqmepwqbFR5PeeE4t0nRjkbxmVunPc3TXj3QuG6iytwZf
         uHOsjL8VUoOJw161yKfDCgEBwcUM+DPynpWe/MOFPiGhjEtl84MdXEiPBoeAvzvCjaPZ
         w6kmW7JnBvVgIPm9tKCAObsXzvr42Wnq/8J7D0+T9QCw6QNDaT1o+1Ing6tuK7/Ptq78
         1Ex/jpPGSABNYaOLP7bgHzNN12ZlV96ifwB/mhykRUWhY7R4IRWxIjs52JnzHZoI60Kx
         ME7+eZOcj4p8yG+raVgbQ2xESrWup2Zwv+uwhsLQZcTnTXH6mUEPvfvD7I7j1qAcJF7+
         mSGw==
X-Gm-Message-State: AOJu0YyNlB8S5W53Gp/m579G1X2d395OukCxK/7S1uGaKvGC27rodFJG
	n4OpJXKJ1I23ACt+9lAZ5hC+Mjigbz9QGJJ1tpCwkSHSKCqE2JPt+gGzjbRvIa8=
X-Google-Smtp-Source: AGHT+IHx6BnAgrIq+V97FPVig6fSnPY9cJOwYtPtAs3CvOKZBXwPYx7UdqxYMAYFKwthTS/ZQvQi6A==
X-Received: by 2002:a05:6402:3097:b0:559:fcab:aadd with SMTP id de23-20020a056402309700b00559fcabaaddmr745901edb.17.1706007725218;
        Tue, 23 Jan 2024 03:02:05 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm11430074edb.45.2024.01.23.03.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:02:04 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 23 Jan 2024 13:01:24 +0200
Subject: [PATCH v4 10/11] arm64: dts: qcom: x1e80100-qcp: Enable more
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-x1e80100-dts-missing-nodes-v4-10-072dc2f5c153@linaro.org>
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
In-Reply-To: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3993; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=b5me84CBLvNcqpO40KkAROvLnJP/DZ8uuhWcZAxxBlk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlr5ycOhR/r1DS104yy+K0Qnm29DoDOz/G9ka2m
 jTgFjebyH2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZa+cnAAKCRAbX0TJAJUV
 VsQZD/sF9fk4c8QNOt3qppNsa8nTGaXsJfmcDmNVjfekHBy9QvAamyv6hyf6XkMnCfVTEGWduBT
 34134tObkGYzsm4kKEbW5dJqIOT2AQUpk5QT0ijx2zqv8FrWWuM6dMSz16rNy240lTmbinDfGzH
 42kCCrR+srhU69/HKoEsL/jK2pnnMvjQB8xMWyU1ltk7n40mE1bq/Uug1/zrGLI781AnSMmxNNG
 FAvT+whHs+hbWtDaddUkZ7pMJ38NTIvrqV0tXEllyxVmRO/E258bK38I80swMrsTUTTZMBp6UM4
 lOn2wj7XDpDB6BsJrd8vLwzhAZP0cB6F2VHnKAFU7FP8jgORBS5coJB8B+gkJaVj1R3vWs/PqVd
 BeU9AcJdYQI+EPXz0ILukSVLsy5Zq77rz7x1dk6JG8oDtVKs0VQmwmiKtVg5Wjic6jDDot6eLUD
 mHS+2dbts90l/xO1TlrxwHzUHa6YaqZhkuZ72dWikJKEdNA8z4YD48vDfdMd0AGUgtDXaPFJzU1
 vBWcgZB+LdHn4XGfefyklOXtGuU/dy0VnqKwEneO22bprST8YXimcnBKj7W1fT1AZMV6oYtp4M3
 5ZHxIGhTusQCA5K1xaRlunq4g8fLwm7BYaokU6bQOFGqdGNl8RX+KDkBvMZ3vPQ4t42fHvdvZNo
 dXgZNLUux+PF1iQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Enable display, pcie and usb support.

Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 171 ++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index a37ad9475c90..8dbf6d0eaac3 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "x1e80100.dtsi"
@@ -31,6 +32,23 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	vreg_edp_3p3: regulator-edp-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_EDP_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 70 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&edp_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &apps_rsc {
@@ -383,17 +401,170 @@ vreg_l3j_0p8: ldo3 {
 	};
 };
 
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
 	gpio-reserved-ranges = <33 3>, /* Unused */
 			       <44 4>, /* SPI (TPM) */
 			       <238 1>; /* UFS Reset */
+
+	edp_reg_en: edp-reg-en-state {
+		pins = "gpio70";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
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


