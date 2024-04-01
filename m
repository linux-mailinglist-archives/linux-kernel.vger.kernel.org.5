Return-Path: <linux-kernel+bounces-127040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A0E89461E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5687CB22339
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014458235;
	Mon,  1 Apr 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtSy2GrE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB555C3E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003632; cv=none; b=qH9XOl/oFMPUG1Aa+mmfmIB6QCjnfxEu8YzdpjQP+9rmr5yb/NO5pTixvukzu1eaTizw6e9PUg7ou7MFecyFL/eTmCAmAaYQ83pBEXXzjoPIKUYpvzTemcmP00RH21lbS/TdFapfA/N9hnITx1WoPvyS9bNOfECn3GiA5qht4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003632; c=relaxed/simple;
	bh=sFKrGZBWRp2+EGuhj/chCtTzPZ3MU2TwU02NxW+14vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKPYM6CZgzXEktWje92K1Yvls80wr0YSh4j2PspXMrNgIl9DxJFfRLQqYdGdB75/CHoHW2kaeS/mBlMYVpPnisx4owZxoQlK3oF5QKLNuD2UoADEnFOCTr//8Tms8m2+gaIHQqC9hT8ztIIcjdq1KWsvkgriQrdw2JfMeuy0ZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OtSy2GrE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-515a81928faso5401564e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712003627; x=1712608427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piQT5IzRdBgW7kJqPQ+vFxpxuzB/TA4xCkBFfjKv6ho=;
        b=OtSy2GrEiAlOPvk9pfybyJkDnr9mkFpedRb6X3H/Db4vPBqHNA/P09txYOihQmPM1z
         xXYnLfVb7famTqtPKpa991vIGVaJG1uIk6Ea2ePUzNECzV7UiyK7LAnTGvex3rTJbDbd
         UCVt/5XGQZioPS5oQN/mr++j5wDT3uCe06Cr6w199iKoqjM2wPeDsL2/i3B6ZXIYAyzS
         hE1UYX3fJ2BnBbsyAw4sdfjZ/fkpbbHb/0QBhvp16sNrEw39d9Lhg/WqiCjWzYWkyCYR
         7z77vmbbjOIXGn11ACvKUeNwd+MUNzqp3c9TwcdsIIKcq7hU0jOhbuXIjlBsNFOWdVyb
         wVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003627; x=1712608427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piQT5IzRdBgW7kJqPQ+vFxpxuzB/TA4xCkBFfjKv6ho=;
        b=B5x51t19KGfbFVsxjvA02axPpZzu2zE9HjfajJ2ra4yBhfPoLtVW0F/7LS2V2sOEuE
         Q7HLKB4TY2JAniTqgq6OHlT9gFrjZHaxryg16ZuHM46hNviiCe4W40zQDbnmyb2hhnAl
         Q8LSEXl3vTVXBEr215ahE3RGfCArDL4FS/Jrd9VpwRWlu9G/BVG83ss/3cRhbgDsGGSN
         /81gxVflMGpLrve1BwIqxKWcCHQluuk2KX74skLqAw+93lEMDZg0CRWcW2bQs5fyZAXQ
         dWpOWP5gKUT80McbnttAqO1jI6KRjRf/GUmrdbe/pYN3ttbhU+i1bWPob2M4wzPxaQ1G
         5AAA==
X-Forwarded-Encrypted: i=1; AJvYcCWSaUg+YY36rzV1SiQT6FLgV2sSy1AGNSYBJN6OkfoAjudffVgAd/mPCbBcaONNYyZj017Ti1MDT+tvSYn88cMqcnwdSHVolFLh484h
X-Gm-Message-State: AOJu0YyvTRMTy5sKerROKc/USwVjAaG9T6IpfZwoHjjjpImKQXKyaGUK
	1aznqmHU++bvsDpfKqgSgZrrACFHqq6kV8IHFUBprZvwcqOrC4LIkxmB7rmeR1c=
X-Google-Smtp-Source: AGHT+IF19vlmtR6Kk3TgNSw+dAkNX3q/0k8KXFiqn+n8trvIATBoccche9gxDw3oh2qEDwyJGbYnAQ==
X-Received: by 2002:a05:6512:3f13:b0:515:9479:a997 with SMTP id y19-20020a0565123f1300b005159479a997mr7848117lfa.10.1712003627712;
        Mon, 01 Apr 2024 13:33:47 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b00515a6e4bdbdsm1478342lfk.250.2024.04.01.13.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:33:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 23:33:46 +0300
Subject: [PATCH v3 7/9] arm64: dts: qcom: sc8280xp: describe USB signals
 properly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-typec-fix-sm8250-v3-7-604dce3ad103@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5467;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=sFKrGZBWRp2+EGuhj/chCtTzPZ3MU2TwU02NxW+14vw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCxolxtxaZXhCOHJPRhcmX9YOVLcP6QeuhI9Ws
 sopd+vgsMiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgsaJQAKCRCLPIo+Aiko
 1U8LCACXof0kswIFSPY6YQWfjJlsPl9dDXWT/ZgmC8b59xNFsx2RGq5ksUHNdlqgPcYz5FZrYpg
 i6rKB1mf5tYtt+xOzL4JiFkW3fBorkIy9PmggGHLh+pbmwUVMUZTYLspZvh6D3zrIaa+aPGeoDy
 lOJV94srFwaWBSt2ZGFAd+6bdnRXTWiKMZ3bkF7RWOY1j3yB6zQDu/1MIi/CRVLg3jyRkYcHzdC
 uiBjssHNH+9nTRHqUUZ7oa4a+6AZupmWzyudgkqfQvY0eWyH+mpjz2fF8Ld6ubswKpjPsh25Snk
 MkjMbRFKT3kKcnf40soP+KFJtJLRjsYbINMafFIaxyH9Sewp
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow example of other platforms. Rename HS graph nodes to contain
'dwc3_hs' and link SS lanes from DWC3 controllers to QMP PHYs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          | 20 ++++----
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 20 ++++----
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 54 ++++++++++++++++++++--
 3 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 41215567b3ae..a2627ab4db9a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -56,7 +56,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con0_hs: endpoint {
-						remote-endpoint = <&usb_0_role_switch>;
+						remote-endpoint = <&usb_0_dwc3_hs>;
 					};
 				};
 
@@ -91,7 +91,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con1_hs: endpoint {
-						remote-endpoint = <&usb_1_role_switch>;
+						remote-endpoint = <&usb_1_dwc3_hs>;
 					};
 				};
 
@@ -675,6 +675,10 @@ &usb_0_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_0_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con0_hs>;
+};
+
 &usb_0_hsphy {
 	vdda-pll-supply = <&vreg_l9d>;
 	vdda18-supply = <&vreg_l1c>;
@@ -700,10 +704,6 @@ &usb_0_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con0_ss>;
 };
 
-&usb_0_role_switch {
-	remote-endpoint = <&pmic_glink_con0_hs>;
-};
-
 &usb_1 {
 	status = "okay";
 };
@@ -712,6 +712,10 @@ &usb_1_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con1_hs>;
+};
+
 &usb_1_hsphy {
 	vdda-pll-supply = <&vreg_l4b>;
 	vdda18-supply = <&vreg_l1c>;
@@ -737,10 +741,6 @@ &usb_1_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con1_ss>;
 };
 
-&usb_1_role_switch {
-	remote-endpoint = <&pmic_glink_con1_hs>;
-};
-
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 15ae94c1602d..53252bb93d9e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -115,7 +115,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con0_hs: endpoint {
-						remote-endpoint = <&usb_0_role_switch>;
+						remote-endpoint = <&usb_0_dwc3_hs>;
 					};
 				};
 
@@ -150,7 +150,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con1_hs: endpoint {
-						remote-endpoint = <&usb_1_role_switch>;
+						remote-endpoint = <&usb_1_dwc3_hs>;
 					};
 				};
 
@@ -1102,6 +1102,10 @@ &usb_0_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_0_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con0_hs>;
+};
+
 &usb_0_hsphy {
 	vdda-pll-supply = <&vreg_l9d>;
 	vdda18-supply = <&vreg_l1c>;
@@ -1127,10 +1131,6 @@ &usb_0_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con0_ss>;
 };
 
-&usb_0_role_switch {
-	remote-endpoint = <&pmic_glink_con0_hs>;
-};
-
 &usb_1 {
 	status = "okay";
 };
@@ -1139,6 +1139,10 @@ &usb_1_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con1_hs>;
+};
+
 &usb_1_hsphy {
 	vdda-pll-supply = <&vreg_l4b>;
 	vdda18-supply = <&vreg_l1c>;
@@ -1164,10 +1168,6 @@ &usb_1_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con1_ss>;
 };
 
-&usb_1_role_switch {
-	remote-endpoint = <&pmic_glink_con1_hs>;
-};
-
 &vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 9f6d98fbc28e..41caa8713cfd 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3164,6 +3164,14 @@ port@0 {
 					usb_0_qmpphy_out: endpoint {};
 				};
 
+				port@1 {
+					reg = <1>;
+
+					usb_0_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_0_dwc3_ss>;
+					};
+				};
+
 				port@2 {
 					reg = <2>;
 
@@ -3217,6 +3225,14 @@ port@0 {
 					usb_1_qmpphy_out: endpoint {};
 				};
 
+				port@1 {
+					reg = <1>;
+
+					usb_1_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss>;
+					};
+				};
+
 				port@2 {
 					reg = <2>;
 
@@ -3420,8 +3436,23 @@ usb_0_dwc3: usb@a600000 {
 				phys = <&usb_0_hsphy>, <&usb_0_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
-				port {
-					usb_0_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_0_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_0_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_0_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};
@@ -3482,8 +3513,23 @@ usb_1_dwc3: usb@a800000 {
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
-				port {
-					usb_1_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};

-- 
2.39.2


