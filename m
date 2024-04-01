Return-Path: <linux-kernel+bounces-127039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C111B89461B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7616A281C45
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6877E5822D;
	Mon,  1 Apr 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxmpSP0a"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A068054FA3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003631; cv=none; b=q3hbzLdovqKdpus8gcFURmT+Yono/a+xtjOIytPg6dSD11yJwAHFmK7vf3fSEpp+Kf+M5fusLzfw2YaL9e2AG0ZpGq4XdtZaCx0FxGBB8uJF+SKbHqVYglOV8hwaNC+dPrCAQAVBrKX5AGkVK5KMv6j7kRkFOrb7NMEaRptRpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003631; c=relaxed/simple;
	bh=5MzJP7yGgyhqTMiws3FKj7gHSNVgfpJstNXFEgFoExI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwToG+TH8tpHa2HV6MRpTVy2CJWn5x7IYv5kfF09Mu5LD4PEqHCG93KQ59PcoiuoqmAodxWmfQ011NwBV3cmJKpp8I9j0KXluMobjR183PEYWg7w6TGSYCFWJEiB91hce3gpjPdKPP/FG/Iy0SyC6amOsBeiWPgQKorirFuhs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lxmpSP0a; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513e134f73aso5671461e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712003627; x=1712608427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIaRo/y9zmiNXclN/bKzOhFbXPgnw3rJ7iP2Dv1/TfE=;
        b=lxmpSP0aCXNOpzEDi+uzxqNHX4biY6iYcw+DPWkWu2KCViKzmiOh5uLj0Ojg4is+Xz
         o7manS24z2/AOHFReqatrQl+tZmFk6Nt0FBrNyrS8gGhiY8EHiCl7CVwL/w/qLFGFbbL
         rhM2BnBIg3R3YWFbISMRv3HZdkWaFMznhtlLTxp5yJSKrEv49VEyuKTsgYwXik+m/7Tt
         FICEhnq4LXBYpONHu9FDbEDpuUB0QOBohi5aVVHxlxxdFdLNTq9WI6wxzHYLFiKRNBBa
         QIiyXrcl0tFOxQrPCQwFt/ZwUtpB4LH8LpuIP4kouciN5lICjUgQdUd//vR7GwayxEBO
         diRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003627; x=1712608427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIaRo/y9zmiNXclN/bKzOhFbXPgnw3rJ7iP2Dv1/TfE=;
        b=SIPMU1QGMzEJcuC0v0qvlHajOpvza/zLat5uB9K5WsXdR2dbXYPU/wrjqa8/iA/Snn
         oG3KAs+5EPYLlDSxPFJ9qMSjRFlYI1lHJVnGAUO34xSUy4ceW3nCv77rjPfGXKt/2hOs
         12eBRlRYa+EpfyFN+weuKHU9FoXvEdaVNzMRev8sbXxPcSxj8r81MixrmSlB5/KExdAL
         ZmPD/F1xuvzVkBkeIrQkIq4xALQvgTrACykm3LM59t+N/jRNphdRsbDvKjRjQMyMZ4at
         6x+0EyKVhur2/tl+44wmyHrzhgQx5EATAiNq/IfH8Yxi1zrUdbu9Yg58S0O1OQ+9ZVRD
         pX8g==
X-Forwarded-Encrypted: i=1; AJvYcCWEjEMoVwk/J9RgaS5o/2DCXT5WXZF4X3ovPIfRgNcndkrMlj9L8dj0WNPLXSG3aGD7+OV782aitIQUJNTi0LV8dUNJq5K+5Bpdyp9p
X-Gm-Message-State: AOJu0YwRQ+5GcUGHymXMQKqosL1OOzCvEiyONo1vgqpuhWyPzXQ/jJh6
	WC5tDCMuvQpdFOYQDC9xQtiuWnqTIAc+3HJaLUBXDvXEXDNSXXxPkUR9b8QnySk=
X-Google-Smtp-Source: AGHT+IGZ1zi11xZncvUZINUAjvdSD2eVE0Le8NOqMB2c+GSDqG/NQJQUC84qVshQo/S73FQhi9TlzQ==
X-Received: by 2002:a05:6512:68:b0:513:cf5e:f2ad with SMTP id i8-20020a056512006800b00513cf5ef2admr7351356lfo.60.1712003626873;
        Mon, 01 Apr 2024 13:33:46 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b00515a6e4bdbdsm1478342lfk.250.2024.04.01.13.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:33:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 23:33:45 +0300
Subject: [PATCH v3 6/9] arm64: dts: qcom: sc8180x: describe USB signals
 properly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-typec-fix-sm8250-v3-6-604dce3ad103@linaro.org>
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
In-Reply-To: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5234;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5MzJP7yGgyhqTMiws3FKj7gHSNVgfpJstNXFEgFoExI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCxolkhtbOMQke4/ENrpblUBm/4ajAFFswypDU
 Em/aNURG+OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgsaJQAKCRCLPIo+Aiko
 1XUUB/4gU8NdN3WvNUgxWo9LHN+RNgvls6zSZGCPcYh8RPkhV/i1SRkNZweSxKvnTfhGzzA5uDK
 9yXN/epauSwvdSA0RbU0wyR2bO3/r2xQkwOsUcNJ4g7Rb7HnbyP8eJvVbBjUO4ernY/LRKhqttb
 Lonmyvrrog2bZ4oOr9q0TxSgig+BIjT69zOHbtLJVTGG/lIPKrurBJU0MjCNoAWHpvYrHNyeApA
 hL9d/RnM4JZ/tSLAwl1i+L0CPeU6TFzG7nKXEfiN+SU+U5qhndG/TWux347/nTsdTHq1QI5Yq8J
 9qL1MqPxOAUEJhP6lXJO/icJAdWSDV4NDcCMau4orPxtRTM9
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow example of other platforms. Rename HS graph nodes to contain
'dwc3_hs' and link SS lanes from DWC3 controllers to QMP PHYs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 16 ++++----
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts        | 20 +++++-----
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 46 +++++++++++++++++++---
 3 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 6f2e1c732ed3..93846ff42606 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -66,7 +66,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con0_hs: endpoint {
-						remote-endpoint = <&usb_prim_role_switch>;
+						remote-endpoint = <&usb_prim_dwc3_hs>;
 					};
 				};
 
@@ -101,7 +101,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con1_hs: endpoint {
-						remote-endpoint = <&usb_sec_role_switch>;
+						remote-endpoint = <&usb_sec_dwc3_hs>;
 					};
 				};
 
@@ -580,6 +580,10 @@ &usb_prim_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_prim_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con0_hs>;
+};
+
 &usb_prim_qmpphy_dp_in {
 	remote-endpoint = <&mdss_dp0_out>;
 };
@@ -588,8 +592,8 @@ &usb_prim_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con0_ss>;
 };
 
-&usb_prim_role_switch {
-	remote-endpoint = <&pmic_glink_con0_hs>;
+&usb_sec_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con1_hs>;
 };
 
 &usb_sec_hsphy {
@@ -617,10 +621,6 @@ &usb_sec_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con1_ss>;
 };
 
-&usb_sec_role_switch {
-	remote-endpoint = <&pmic_glink_con1_hs>;
-};
-
 &usb_sec {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index bfee60c93ccc..65d923497a05 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -71,7 +71,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con0_hs: endpoint {
-						remote-endpoint = <&usb_prim_role_switch>;
+						remote-endpoint = <&usb_prim_dwc3_hs>;
 					};
 				};
 
@@ -106,7 +106,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con1_hs: endpoint {
-						remote-endpoint = <&usb_sec_role_switch>;
+						remote-endpoint = <&usb_sec_dwc3_hs>;
 					};
 				};
 
@@ -648,6 +648,10 @@ &usb_prim_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_prim_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con0_hs>;
+};
+
 &usb_prim_qmpphy_dp_in {
 	remote-endpoint = <&mdss_dp0_out>;
 };
@@ -656,10 +660,6 @@ &usb_prim_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con0_ss>;
 };
 
-&usb_prim_role_switch {
-	remote-endpoint = <&pmic_glink_con0_hs>;
-};
-
 &usb_sec_hsphy {
 	vdda-pll-supply = <&vreg_l5e_0p88>;
 	vdda18-supply = <&vreg_l12a_1p8>;
@@ -685,10 +685,6 @@ &usb_sec_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con1_ss>;
 };
 
-&usb_sec_role_switch {
-	remote-endpoint = <&pmic_glink_con1_hs>;
-};
-
 &usb_sec {
 	status = "okay";
 };
@@ -697,6 +693,10 @@ &usb_sec_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_sec_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con1_hs>;
+};
+
 &wifi {
 	memory-region = <&wlan_mem>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index bae89761dae1..6346d6b6c196 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2508,7 +2508,9 @@ port@0 {
 				port@1 {
 					reg = <1>;
 
-					usb_prim_qmpphy_usb_ss_in: endpoint {};
+					usb_prim_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_prim_dwc3_ss>;
+					};
 				};
 
 				port@2 {
@@ -2553,7 +2555,9 @@ port@0 {
 				port@1 {
 					reg = <1>;
 
-					usb_sec_qmpphy_usb_ss_in: endpoint {};
+					usb_sec_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_sec_dwc3_ss>;
+					};
 				};
 
 				port@2 {
@@ -2633,8 +2637,23 @@ usb_prim_dwc3: usb@a600000 {
 				phys = <&usb_prim_hsphy>, <&usb_prim_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
-				port {
-					usb_prim_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_prim_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_prim_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_prim_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};
@@ -2690,8 +2709,23 @@ usb_sec_dwc3: usb@a800000 {
 				phys = <&usb_sec_hsphy>, <&usb_sec_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
-				port {
-					usb_sec_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_sec_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_sec_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_sec_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};

-- 
2.39.2


