Return-Path: <linux-kernel+bounces-125943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A056892E7B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C9B2822EC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8F3946C;
	Sun, 31 Mar 2024 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XfXgtR57"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3115A5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711856940; cv=none; b=CoK0W6iJQNpgd8NdcChHE8xBI0P11af8hp1AQtB7u+g8Q49iLfPYV6DIWUQr7aspK8sYG6QaKBK73a/chtEvS0ZwLx7XEZI7tW8wY4oW714WhseJrweNG4YYKWXtxG5npZGTNFJ2qD0t4HRQPNCdujh3G04ZcQgS7Dcb7Yw/ltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711856940; c=relaxed/simple;
	bh=7EfGB7yMpXjvioQX1Rm4KbJ/AxGqyNRro4p3nMwNvYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFOLG8LnPykpGKeYYDAffw/JWd/jTrMf47suX86bzCjLMRG0rLhlMgqtw1xFzXsrhRHu1MdIIO+GHbdbtDp2KUfhYpm38OG0PPHY6udv6hNiSTqLU4OapHao6qN1lTGH1YJ//ImEHbxZWR+RzbFIiKK+GL/++a97wxGG/rT0r9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XfXgtR57; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513d717269fso3671515e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711856937; x=1712461737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Y3Kfoqzh4vQdnhmhi8JCYRXAxYg/BtE6kzbs+VhT7c=;
        b=XfXgtR57HfAHDsOvz2HpmgNPP1ssyUFpRgF3IXOy4RNBFEcsWPc9t/X8tdrPbxi/Ch
         L+iUCt7in6mcX6ZWUq6Ri4mmWZ1DKB8lZitsX6nIOQQjneAOx96owHKH6VlByjkSSKjQ
         1Xr9eU5FB3fp6k3rksARiOUhZpnKk9U37K/90UbDYliK9XrzW2FFEJiK6TmGgCFqACvl
         EuUmzzT5iGUHjRe/a2uLiIgQ01r8qbHr7rDHgHARFvN+iMR38fsvJiy2Htmwfz6/HpC0
         oZ0JdOcBHqvino/nQ5TXcQ1j60TU3Uwx15alGM+15YGIsl+76+y/m2fVn9JdU6UkvIbz
         YP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711856937; x=1712461737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y3Kfoqzh4vQdnhmhi8JCYRXAxYg/BtE6kzbs+VhT7c=;
        b=uohCLYKWW5KDIWDo7OnGbikp3Nrw2uzjIEb2/lJWloxaKwcQDLNS5JzKkq/Emm4NAF
         m7i8kCLu8HLI6WxBtLVthL1A2famPvCRmm9rl3ifvuXrXKHqnv1VKe0IBJUGvamqQ1Ow
         vPzIPKiz0MpHX0ZGwxRgRZW+QcUuPvqyDbP9dMJHAZhzGXlLVMcxL2F2xS9xI0KVrOd3
         xpjZ18iylOWApXrOeYfsIhAZI8I2iKa55AHE3gmBBY+J4MVz7kXnGTzT6GtscWZwxWVp
         s4a1BDVupUNgg+7llpFOoNfKf7wrpHntguJlnRSbCY5Lh+6NXZivQf+DX5+4fPHQdVJ/
         K8/g==
X-Forwarded-Encrypted: i=1; AJvYcCWZFX6f/GPu2kSUjQTCZ/wSp7ppCBA2a9Lao/uvQc5J3RO9ODTvgwcCZktCj7LpZ8GBZfuUklTqnbzw2NMaIlZyvL9YXa2ezuMJibeb
X-Gm-Message-State: AOJu0Yypay1VAhFkgYBxC+golKtycwkx2Rgtlsylm/AYRIy6uE2H1Pwe
	PyTVjdyqSotVWSAkXUt1HvD+aaOtgv6B1hn6w9LS3GlWUH41KZjhUmed66SKG+w=
X-Google-Smtp-Source: AGHT+IGjGZyuSXqa1dUNjuuUsixOj8hsFbiTi7Xa0rfvK8aIVB2Iz49ByhpTc7vHL+OEENUBVikqWQ==
X-Received: by 2002:ac2:5967:0:b0:515:8564:28c8 with SMTP id h7-20020ac25967000000b00515856428c8mr3869538lfp.67.1711856936838;
        Sat, 30 Mar 2024 20:48:56 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k9-20020ac257c9000000b00515ce9f4a2bsm762980lfo.35.2024.03.30.20.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 20:48:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Mar 2024 06:48:53 +0300
Subject: [PATCH v2 3/7] arm64: dts: qcom: sc8180x: switch USB+DP QMP PHYs
 to new bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-typec-fix-sm8250-v2-3-857acb6bd88e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7314;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7EfGB7yMpXjvioQX1Rm4KbJ/AxGqyNRro4p3nMwNvYk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCN0kmRlru3z7W/EQJ1pjMDWDYzAqUFK28kj/B
 gnu4uEseqWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgjdJAAKCRCLPIo+Aiko
 1fvyB/0dRs9XxVkYHWdBpUSVhGvi6TQ45UtXZhwWGd5o+SK5HqekFeVhhaVxOhNqnWmWZfNbSpB
 dNTEZeE7ZFCMwJKpOa7LXcqx5olagaLjPboXKlI61+z4hfrzwq+erqQN9yrtxrimKF9jNV1O90j
 9RoiIKTtwF+crgNPURfnBpzwgylQgNmr3eRqGbJjiADvaTbWlUXSkUFvbrg9wNkLX4eIIHfMDSl
 q1d/UhkLiaUCNsbM6DPUOTrGTObZZ9uJf5MYlyZAiRuXPJzpZH1om3RBlPX1kAGTF8uLgKSOmEa
 6gG1O7E/NXdUiIg0C8Mbm4Caqclov50i10fqdHpwQhpRCpz2
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

To follow other Qualcomm platforms, update QMP USB+DP PHYs to use newer
bindings rather than old bindings which had PHYs as subdevices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 122 ++++++++++++----------------------
 1 file changed, 41 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 32afc78d5b76..a4931b5ee86c 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8180x.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -2472,28 +2473,25 @@ usb_sec_hsphy: phy@88e3000 {
 			status = "disabled";
 		};
 
-		usb_prim_qmpphy: phy@88e9000 {
+		usb_prim_qmpphy: phy@88e8000 {
 			compatible = "qcom,sc8180x-qmp-usb3-dp-phy";
-			reg = <0 0x088e9000 0 0x18c>,
-			      <0 0x088e8000 0 0x38>,
-			      <0 0x088ea000 0 0x40>;
-			reg-names = "reg-base", "dp_com";
+			reg = <0 0x088e8000 0 0x3000>;
+
 			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
-				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
 			clock-names = "aux",
-				      "ref_clk_src",
 				      "ref",
-				      "com_aux";
+				      "com_aux",
+				      "usb3_pipe";
+
 			resets = <&gcc GCC_USB3_DP_PHY_PRIM_SP0_BCR>,
 				 <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>;
 			reset-names = "phy", "common";
 
 			#clock-cells = <1>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#phy-cells = <1>;
 
 			status = "disabled";
 
@@ -2507,59 +2505,38 @@ port@0 {
 					usb_prim_qmpphy_out: endpoint {};
 				};
 
+				port@1 {
+					reg = <1>;
+
+					usb_prim_qmpphy_usb_ss_in: endpoint {};
+				};
+
 				port@2 {
 					reg = <2>;
 
 					usb_prim_qmpphy_dp_in: endpoint {};
 				};
 			};
-
-			usb_prim_ssphy: usb3-phy@88e9200 {
-				reg = <0 0x088e9200 0 0x200>,
-				      <0 0x088e9400 0 0x200>,
-				      <0 0x088e9c00 0 0x218>,
-				      <0 0x088e9600 0 0x200>,
-				      <0 0x088e9800 0 0x200>,
-				      <0 0x088e9a00 0 0x100>;
-				#phy-cells = <0>;
-				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb3_prim_phy_pipe_clk_src";
-			};
-
-			usb_prim_dpphy: dp-phy@88ea200 {
-				reg = <0 0x088ea200 0 0x200>,
-				      <0 0x088ea400 0 0x200>,
-				      <0 0x088eaa00 0 0x200>,
-				      <0 0x088ea600 0 0x200>,
-				      <0 0x088ea800 0 0x200>;
-				#clock-cells = <1>;
-				#phy-cells = <0>;
-			};
 		};
 
 		usb_sec_qmpphy: phy@88ee000 {
 			compatible = "qcom,sc8180x-qmp-usb3-dp-phy";
-			reg = <0 0x088ee000 0 0x18c>,
-			      <0 0x088ed000 0 0x10>,
-			      <0 0x088ef000 0 0x40>;
-			reg-names = "reg-base", "dp_com";
+			reg = <0 0x088ed000 0 0x3000>;
+
 			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
-				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
+				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 			clock-names = "aux",
-				      "ref_clk_src",
 				      "ref",
-				      "com_aux";
+				      "com_aux",
+				      "usb3_pipe";
 			resets = <&gcc GCC_USB3_DP_PHY_SEC_BCR>,
 				 <&gcc GCC_USB3_PHY_SEC_BCR>;
 			reset-names = "phy", "common";
 
 			#clock-cells = <1>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#phy-cells = <1>;
 
 			status = "disabled";
 
@@ -2573,37 +2550,18 @@ port@0 {
 					usb_sec_qmpphy_out: endpoint {};
 				};
 
+				port@1 {
+					reg = <1>;
+
+					usb_sec_qmpphy_usb_ss_in: endpoint {};
+				};
+
 				port@2 {
 					reg = <2>;
 
 					usb_sec_qmpphy_dp_in: endpoint {};
 				};
 			};
-
-			usb_sec_ssphy: usb3-phy@88e9200 {
-				reg = <0 0x088ee200 0 0x200>,
-				      <0 0x088ee400 0 0x200>,
-				      <0 0x088eec00 0 0x218>,
-				      <0 0x088ee600 0 0x200>,
-				      <0 0x088ee800 0 0x200>,
-				      <0 0x088eea00 0 0x100>;
-				#phy-cells = <0>;
-				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb3_sec_phy_pipe_clk_src";
-			};
-
-			usb_sec_dpphy: dp-phy@88ef200 {
-				reg = <0 0x088ef200 0 0x200>,
-				      <0 0x088ef400 0 0x200>,
-				      <0 0x088efa00 0 0x200>,
-				      <0 0x088ef600 0 0x200>,
-				      <0 0x088ef800 0 0x200>;
-				#clock-cells = <1>;
-				#phy-cells = <0>;
-				clock-output-names = "qmp_dptx1_phy_pll_link_clk",
-						     "qmp_dptx1_phy_pll_vco_div_clk";
-			};
 		};
 
 		system-cache-controller@9200000 {
@@ -2672,7 +2630,7 @@ usb_prim_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0x140 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-				phys = <&usb_prim_hsphy>, <&usb_prim_ssphy>;
+				phys = <&usb_prim_hsphy>, <&usb_prim_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
 				port {
@@ -2729,7 +2687,7 @@ usb_sec_dwc3: usb@a800000 {
 				iommus = <&apps_smmu 0x160 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-				phys = <&usb_sec_hsphy>, <&usb_sec_ssphy>;
+				phys = <&usb_sec_hsphy>, <&usb_sec_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
 				port {
@@ -3046,9 +3004,10 @@ mdss_dp0: displayport-controller@ae90000 {
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
 						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
-				assigned-clock-parents = <&usb_prim_dpphy 0>, <&usb_prim_dpphy 1>;
+				assigned-clock-parents = <&usb_prim_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				phys = <&usb_prim_dpphy>;
+				phys = <&usb_prim_qmpphy QMP_USB43DP_DP_PHY>;
 				phy-names = "dp";
 
 				#sound-dai-cells = <0>;
@@ -3122,9 +3081,10 @@ mdss_dp1: displayport-controller@ae98000 {
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK1_CLK_SRC>,
 						  <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK_SRC>;
-				assigned-clock-parents = <&usb_sec_dpphy 0>, <&usb_sec_dpphy 1>;
+				assigned-clock-parents = <&usb_sec_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				phys = <&usb_sec_dpphy>;
+				phys = <&usb_sec_qmpphy QMP_USB43DP_DP_PHY>;
 				phy-names = "dp";
 
 				#sound-dai-cells = <0>;
@@ -3268,10 +3228,10 @@ dispcc: clock-controller@af00000 {
 			reg = <0 0x0af00000 0 0x20000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&sleep_clk>,
-				 <&usb_prim_dpphy 0>,
-				 <&usb_prim_dpphy 1>,
-				 <&usb_sec_dpphy 0>,
-				 <&usb_sec_dpphy 1>,
+				 <&usb_prim_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
+				 <&usb_sec_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 				 <&edp_phy 0>,
 				 <&edp_phy 1>;
 			clock-names = "bi_tcxo",

-- 
2.39.2


