Return-Path: <linux-kernel+bounces-125946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D3892E83
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9427DB2161B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7A10A11;
	Sun, 31 Mar 2024 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vztLru8H"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FE4C69
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711856943; cv=none; b=Wn+PA+VzxkZg8sL/IbIi5WN4o8fl2OlYrGVkeUdCIrVBO7AEJtEmge0QN/JOWnCl8zEhwAUHROOyAfkloyKohzuzPjCM3ckOOO6s1X1sxb8reCf5uUIOGPktsLTXXR3db38+XucvEuiyrRbxtb4E33XSfecBXht6pfik+UERWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711856943; c=relaxed/simple;
	bh=RGkOQsCllQ1jYfPhrj6TQaocgy7wfyKr0BnEC9y7evA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKZy8tRqnfNcA2x2gPP8FxgtQJXuxGHFvJdpbcyF2GlFmF9drQ+dY9+kAAFsoltZrBWydVX5BJWU5oRcLRbLZThsPK3QLDrbkV/IinuzSqf9RGZdokcd4a7DSt12OlNmg3thMgX2Q3TxQWp12xX/H52WhcydTKjAFBuXY+uSxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vztLru8H; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-515c3eeea5dso3429444e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711856937; x=1712461737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vf293Z1jWjZ4tIcNIs1kYj2icD3MR7alx33L+RV9QBA=;
        b=vztLru8H/ia4Ul992GGg651Sc/GrkEhulF5dcVRU2SBdIfAlukhA0rEYCIMc5CObPv
         icUcZxDg5DDh/wTz+X+kqw5NT0EgVlPaQRvnWFmveURtpJmdiaK51aDaIoND/qROJAXU
         IWIr5tkgOJYNAMhY3CGUzqqNODWEcwoifHHNsWMXlhL++YzalybqiPr+QAEIi5k/nRcW
         bvz4Lrgwlojt36seD6wJwiE/YM9aeFRh0732brj2v6SoS53Etv/inJmf4S8/e1k0jehN
         xd0kJdPThB/P8a+Hq9NO343xRj5xn++HbnOt2GuPEHVv1XiRWu+zEvHvoWn9zLZlHDJS
         73rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711856937; x=1712461737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf293Z1jWjZ4tIcNIs1kYj2icD3MR7alx33L+RV9QBA=;
        b=cARYIzkKbddSvfqeMu9186p1iOp4o6ms1TLWJ475yhHJj5PoX0Th62siIKeESOg8dT
         /w4R1+Ihduf7Gx9M3qSVToc7ndNPfedwPP605h54fvB24y6of5ieZtTCWxnZ16vGVypz
         0Lehid4mJbn036VJbLkcgDtoEr3EXZ9Q+Zzlqlo8KHfMfru+z28r8S9rfd7NzYsZhaBl
         GRM52lhNivsOYKXLjzGpyD3T6u+um5hnDAEMZdkUlXwXGPhz0Z0gy9BzFbPyu4ZTt+Px
         W6f+6BRozH8LvtMoAVlXHrCLJT2gXiWbkdZxTaw4VyKrOZuQ5b2Kqz0M9uONJ/St4p9x
         OU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHXmmDBRTev6/n/tzbL5pyKBJq7UuetgqC1L3UU8fj0wbIJ/iBZDkjaUkocWUdEIRCkE1r00jv+7EHhAJwskU7OvvPmf7bCJvcxksy
X-Gm-Message-State: AOJu0Yw1GPdvkpbQ0dy38v0CXdfLdyw7OJB8a1uWMYatRhjPUJZyRouu
	cm9S0+9l/7DNTQrF1qN7U+6J8CFWv72Oow9J5ce3IRga+ocmEa4BtNiZcuWKk0A=
X-Google-Smtp-Source: AGHT+IG+QlAYyeq5q7IAE1VUglDS5ZGVj7bZFm7QWz87R3EDOqqkLqa1EzsJtjYyiFp7Ngp7M/ObCg==
X-Received: by 2002:a05:6512:3d90:b0:515:c195:d6b8 with SMTP id k16-20020a0565123d9000b00515c195d6b8mr5132608lfv.60.1711856937471;
        Sat, 30 Mar 2024 20:48:57 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k9-20020ac257c9000000b00515ce9f4a2bsm762980lfo.35.2024.03.30.20.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 20:48:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Mar 2024 06:48:54 +0300
Subject: [PATCH v2 4/7] arm64: dts: qcom: sc8180x: describe USB signals
 properly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-typec-fix-sm8250-v2-4-857acb6bd88e@linaro.org>
References: <20240331-typec-fix-sm8250-v2-0-857acb6bd88e@linaro.org>
In-Reply-To: <20240331-typec-fix-sm8250-v2-0-857acb6bd88e@linaro.org>
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
 bh=RGkOQsCllQ1jYfPhrj6TQaocgy7wfyKr0BnEC9y7evA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCN0kox7dM4i18BAYWHmXL7xoWVpD/PB9I6Akm
 WuS4MUpn7eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgjdJAAKCRCLPIo+Aiko
 1UrMCACJ5ETJYWdNrzXrmnCkKdo9786SEIeX2mmS8ENaPriggO5nHuiaHHvSo/VBIuaE9V7+uZx
 S4w7sOr8T532woE/5YPf4lGc1SjccjPUh5cS0sNBoNeUGgIFacMB8RvGzv8PpspASX6NNLam9Gu
 uc133JbQ7IqsR5b4UpaTuI/bcqAKI9FlrANkfekSWWznGluOzGEIq3A1jgyQ0aM9Is4FyYHLq5U
 vhOvvF228hsnJY8QAG5ZR4esrbUxOLam3YbCZ1/q5vzaXYqoPxlxfoMu/JaD1hJ6i1hjRCfIHQS
 KuhRltpDYXZqfFvJPGobHgJHrK16sWtTGWFN6QRUp82SjAwJ
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
index a4931b5ee86c..59bb844ed432 100644
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


