Return-Path: <linux-kernel+bounces-127038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C039894611
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBF81F23350
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43B57301;
	Mon,  1 Apr 2024 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAz2fuVy"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C654BD3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003630; cv=none; b=E+3bbGoDqZZPgJ3eUXENpEt8FrHAtEG9Zoo0EHpjl9CumPpcAdXjpS93Qff7B0W2dm0Cs3s6nnzrHmBEnUQ5/a+chokw+oA3N8SSOsibYNGf/zCfOGs8/P5Wr7o6Sf8IyTS63zByIbKyFeILd4bJbwxNk1/gMC+BpA8Kt6OneSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003630; c=relaxed/simple;
	bh=exKr9kS07I/FGyAADFSiELaPPmJbK9F+6r42IVjBzJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5TdaoDKbtqw/YpHRvyy1wkUosZp4PWYyH3Rhr/pqrNI7ZUXX1nYlJJQvkAqa8HyWlXeda/gTgYfboMyWb68XoN/Rqf52N1XwJ7cfKNs1s3fp6utt2fnKc1Cs2RrcylIINvO53UZaGCJ7SsD/n8x7oeRvIgsB01S94B0folPrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iAz2fuVy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516a01c8490so1570497e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712003626; x=1712608426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1vLUCvnUI7qq6Efpul0tmKxM3WduOPLKLF1etO7Qlw=;
        b=iAz2fuVyhnETPFPwScEW8AUmPU69JEba2CBKCmLHY9UwyQZLN1x0ZmIbBol+p6l6nu
         7E9C/v3F8/mbygKZU6X/bO0T/KhejbKTZj41NIKxu1qps9sbiAfsAmUZBOQgLFKWdC4S
         14t+321faqidMRpYRYmTW6cFKLPDtztxL/hE2nSYuHsPpnaa+d9HGKU4W9XjaT3XM2fl
         0quUjLoExRLt9bi+JqykF9Y/tL5ovMGSpXysHv+O032GZ9RVzBPBTq3hdeW3RY9ZdcR9
         2mYSdKrmMK3RjPy/j6AqTJPdnj13fFIcS8E3Kc/ZQEJ2vimoxmTUcbSavx/9FKr7VhSX
         QWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003626; x=1712608426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1vLUCvnUI7qq6Efpul0tmKxM3WduOPLKLF1etO7Qlw=;
        b=ckxaHIc3DQbbIwgbR9/qB9JZFQgxLcWovbh1UB2acWNHHYPwXI6wCz5dZGjr9WxEhA
         CSAEUD2Zgk9LnqF4vHfp12xzilvqGS7vjDvhkoqciZP2cGNHSI+NpV9onYQ2DH3w8stm
         IYThU5dc/oasFM27jWNVxDRGCbRwuIhD0Ks/GKXbYtknfXoz0kzx/pe0IvWWyjJUPc0t
         6RiIV6Q65w0bxxzu1M/+yCKGZBuVLcaRnKTdIwwxxbdRAT6Eky5ZpUdEuBfQvIYpGvVE
         C1ZS1Cs2V4pgb0Nto4pgMNZsv+wCaYSAp01n0mx6xYdOADZrIyrc1Vn13OBZCLwYmnCT
         KoBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSCcw5aiOPM9JJ3yc4rvaN/ljpXy7c/EZhnoYRzl1lfJkiXd3H77jN/h58u+7TA3o0QrfQSC0FQgi1c2grD9vtD1Q8v/c2vttWDktQ
X-Gm-Message-State: AOJu0YzSXeuBLKr/6PlvzHqYTVhrKNiA7Ws9Oxzu4UVghLfNGLr/IQxF
	vyoh1t3vQl8c0i2+V6oFAPnSt96AD0apjR8IRSwbDhKfcyp45jnVp9ETD4fLMQy8scAiUP2iiuU
	X
X-Google-Smtp-Source: AGHT+IEGF5veBPuRytMkQRyPXJ6ljqLph2jqkOSR1h8cQ8xZ9OK/m+uKvHh0lbkVjG46f4J5ib8ozw==
X-Received: by 2002:ac2:5a4b:0:b0:513:d234:e8c1 with SMTP id r11-20020ac25a4b000000b00513d234e8c1mr3617199lfn.28.1712003626292;
        Mon, 01 Apr 2024 13:33:46 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b00515a6e4bdbdsm1478342lfk.250.2024.04.01.13.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:33:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 23:33:44 +0300
Subject: [PATCH v3 5/9] arm64: dts: qcom: sc8180x: switch USB+DP QMP PHYs
 to new bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-typec-fix-sm8250-v3-5-604dce3ad103@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7378;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=exKr9kS07I/FGyAADFSiELaPPmJbK9F+6r42IVjBzJM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCxolGphI1WB/H9GWNAwgAM3bv54ypIjuwrZIx
 rff9GqX3k+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgsaJQAKCRCLPIo+Aiko
 1cL3B/wPtxVt7HYwPZRw4WrMKmaMf3/Tsdd6SznPNXvlPECCoZ675CbVLJZwEAMBFDWmAz0BjLt
 H07NJofa3dwNqQV8HxOaQGncLJ6aKdJqEdjMgqWOb6tXOieM2PKwr+ekp2wR2IA/FaMte13L5gg
 EMp5ztmi8KGBtCNNfvu/k/DvB/EP9iTvkNBkRHOJrEW3yRiWfMP9p69irxdk3M2U01WigG6+J5o
 Vva/iYYxuSTnQljPGSFfGD5qNcFsteKYBELGQKJQ6qEt0ty3VlTCHMQckOG8Ai1wZQPXBkbUJ5G
 0D2UGIXU8nMS3NIPfse2x8ARFfpDczPXJlnVwT679dQ8uLVl
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

To follow other Qualcomm platforms, update QMP USB+DP PHYs to use newer
bindings rather than old bindings which had PHYs as subdevices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 122 ++++++++++++----------------------
 1 file changed, 41 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index a086dbe0d910..bae89761dae1 100644
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
@@ -3271,12 +3231,12 @@ dispcc: clock-controller@af00000 {
 				 <&mdss_dsi0_phy 1>,
 				 <&mdss_dsi1_phy 0>,
 				 <&mdss_dsi1_phy 1>,
-				 <&usb_prim_dpphy 0>,
-				 <&usb_prim_dpphy 1>,
+				 <&usb_prim_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 				 <&edp_phy 0>,
 				 <&edp_phy 1>,
-				 <&usb_sec_dpphy 0>,
-				 <&usb_sec_dpphy 1>;
+				 <&usb_sec_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 			clock-names = "bi_tcxo",
 				      "dsi0_phy_pll_out_byteclk",
 				      "dsi0_phy_pll_out_dsiclk",

-- 
2.39.2


