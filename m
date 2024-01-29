Return-Path: <linux-kernel+bounces-42706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921D9840559
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2EB2B22069
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE9F64CC4;
	Mon, 29 Jan 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lf5UnPQ0"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693063130
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532370; cv=none; b=cK+VTdEamNBGTKaTfTMnTcqwtvS5qlCV2QCajbWS8hY14rfiQ1B5h9BCEqbP8485u1EI8gOhZ3VG3h2kLcFM7k31M8oB5lVzZFzHlfreypvaunBmHZeoJgVwg5BMuT6t3s8Sp8wUOz3NxiJWpPZQivGoMJMahI3QPBV4ZNjvT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532370; c=relaxed/simple;
	bh=Y0MYbEuAEOzJK32EJdjen8i12kPq6RWoKAuNHLC4ToA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=igOiJzGVmK8//dDnMxGUEERcBogiQy1w/CNzibq4iiJ2PGdmo7wkm6NDNYs/jP34RyrzbC3UkNJyXDvTzV3i4h5+QSATw2ZafmD0gqaVOACjOJUIFmQ2WzmnUWHRHOTHrm3ex/rKYYwxuWYyiH9GsdBa1aMePg4XaS030HD4tiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lf5UnPQ0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-510221ab3ebso3477956e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532366; x=1707137166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyqO3g54Zj920yDOJvyRd732VkkZ8E4HxEZRGLxGGY4=;
        b=lf5UnPQ0qzdV8IT0AXW2zVRHI14z3AsfnYIW0IQDaBUUbwHCOrI9ofInCEmnnwcONI
         NY3LiRGff3A9d/2/2AKQEATqyJaKClBGjEuX/scZWxUjvJwPKFqtJVqDCNILaUbDwx65
         8h1B9WCnCTooyMsL9IZcFtW7MP9uRI7PijM75DBxnPRrp01XwX6seu1IftyTTvZZi4V2
         7OoR5Avn7uz6nfxky/7qKCvZS+uI+3AIU1+MZEAfIxgVdhBkeRta89sSe+FvjtOL/3Rr
         02JBypW8NQFP44/T0csJ8PR9zCKPbXe0nhorfdPQ7B7qq+mhxt+l7HSXBDmplUBbQk0Z
         TJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532366; x=1707137166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyqO3g54Zj920yDOJvyRd732VkkZ8E4HxEZRGLxGGY4=;
        b=NNB3WpsNX89vW7I5rfiBvrHmbOnZN/Trws235OyWc8wF24lfioK+tKQq1yhy1KZcPb
         QFi3zeRe1FcEhu1ECxqr/Hl+Zo26nPADczXm+DeFEs911PhWZCxGplnx1KuNPyBE21qj
         hex1pBra68eFZ9CRD1uHHBnuPt6MowlBkSqdcOh9MkWfWLsX7M565/Nce+9yUBm0dRib
         iNVRAE7eKP8+QcsZLUMHHrWtI8/h2RF7Ou8CyhIz3jscHPnXX4O2LCrJ798Sgn9dyhZ2
         6Njw/B4ltl0XNFnvcsqkP4q+lum9SNTYtY21JgFTIPjAtGHMxf4fjgSmlyGHSY5DdGlJ
         VQiA==
X-Gm-Message-State: AOJu0Ywqm5U8BCI9yhZZSI/g+DOCMqY7FE0J0zKE3U+fjevz30OEWjMx
	CUMej6WZGS47Xds/ST6IRg94FWDFRrzQXulGedbdrAOgiR7GlSzbK51XeckY75AD/4bKsdQj5zL
	/
X-Google-Smtp-Source: AGHT+IFUe89E6n4HHdOljJPzao0sf4tb50Z03+gUWVi34nO8COzr+bCETWDwpytC7VFnVsw2YxRHOg==
X-Received: by 2002:ac2:4bc9:0:b0:510:893:f8c3 with SMTP id o9-20020ac24bc9000000b005100893f8c3mr4687064lfq.20.1706532365928;
        Mon, 29 Jan 2024 04:46:05 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906329400b00a3527dba974sm3041495ejw.35.2024.01.29.04.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:46:05 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 14:45:38 +0200
Subject: [PATCH v6 06/11] arm64: dts: qcom: x1e80100: Add USB nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-dts-missing-nodes-v6-6-2c0e691cfa3b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14263; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Y0MYbEuAEOzJK32EJdjen8i12kPq6RWoKAuNHLC4ToA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt53+J2Mb9uldmONXiirE0IrFRPd+Zqd1UxH4B
 SEdmPKcRE2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbed/gAKCRAbX0TJAJUV
 VkPaD/9mR1HL5aWYMlgJRUxLjT000M2vh8e2DMKf+1Chi1AgxmBNbh7JDbe1cRZP6WnodVStBis
 ohyR+hnUznWIyTaATIm2zApryqtKZtEwk77LOxGOUykhEXN/oQKCfOEcZG69STOwKqN4X6WH+Xd
 prT1+sH0cfyTAKRLNmeCOTFGyfVTzFIMDAyu1bp2T/0RlniDvvrOgH/dh5ExdAOV/0XJXBFhLjy
 0JR/bx0+ZmX2pQbyDntf5Gfcu1E/V35vY5elL0iq2UCflKmYd+zhzyScrriO+E0MTaSk6RpKLIj
 VLZISMcYYqF/t84HFXQ+Tfmx3VGEeIrSJiD1n/zwDwv8iIlmCK6xFVULCvAaNwLpPDS8Xw0aiHb
 00w3UFuPmvcfkUdltiR+8jeGxDJA3iy2tcaCfOO83siia7zjMfqEedKBr1A9bBIo8qIvAWLrkrD
 8U+z91om9QWl/va9VBGPQHFsJGxRrGdwXK7F+N5qpBSFpSw5P7yLc+32ZmKhslJdIZ1H2PoHt2S
 Ey9snCVOIS+JZ9XD4wOPiAP5r5Fl95CuWn0G7txbWnh3ORFhnJFfe70fqkS+s3QsObqgpyPYm+B
 2ngFyVFmwLXi8mjK4fOWy2EjknC+iYGrRaGONRNQPNLBIes9v0hg4Ub1wHn+ezAuwAMdfTOgFTA
 qk9SQQ+MpmMvUxw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add nodes for all USB controllers and their PHYs for X1E80100 platform.

Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 453 ++++++++++++++++++++++++++++++++-
 1 file changed, 450 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 2b6c55a486b2..ee61e1cbc5af 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5,11 +5,13 @@
 
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
+#include <dt-bindings/clock/qcom,x1e80100-tcsr.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,x1e80100-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -734,9 +736,9 @@ gcc: clock-controller@100000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
-				 <0>,
-				 <0>;
+				 <&usb_1_ss0_qmpphy QMP_USB43DP_USB3_PIPE_CLK>,
+				 <&usb_1_ss1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>,
+				 <&usb_1_ss2_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 
 			power-domains = <&rpmhpd RPMHPD_CX>;
 			#clock-cells = <1>;
@@ -2492,6 +2494,126 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 			};
 		};
 
+		usb_1_ss0_hsphy: phy@fd3000 {
+			compatible = "qcom,x1e80100-snps-eusb2-phy",
+				     "qcom,sm8550-snps-eusb2-phy";
+			reg = <0 0x00fd3000 0 0x154>;
+			#phy-cells = <0>;
+
+			clocks = <&tcsr TCSR_USB2_1_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss0_qmpphy: phy@fd5000 {
+			compatible = "qcom,x1e80100-qmp-usb3-dp-phy";
+			reg = <0 0x00fd5000 0 0x4000>;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "com_aux",
+				      "usb3_pipe";
+
+			power-domains = <&gcc GCC_USB_0_PHY_GDSC>;
+
+			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB4_0_DP0_PHY_PRIM_BCR>;
+			reset-names = "phy",
+				      "common";
+
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss1_hsphy: phy@fd9000 {
+			compatible = "qcom,x1e80100-snps-eusb2-phy",
+				     "qcom,sm8550-snps-eusb2-phy";
+			reg = <0 0x00fd9000 0 0x154>;
+			#phy-cells = <0>;
+
+			clocks = <&tcsr TCSR_USB2_1_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss1_qmpphy: phy@fda000 {
+			compatible = "qcom,x1e80100-qmp-usb3-dp-phy";
+			reg = <0 0x00fda000 0 0x4000>;
+
+			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "com_aux",
+				      "usb3_pipe";
+
+			power-domains = <&gcc GCC_USB_1_PHY_GDSC>;
+
+			resets = <&gcc GCC_USB3_PHY_SEC_BCR>,
+				 <&gcc GCC_USB4_1_DP0_PHY_SEC_BCR>;
+			reset-names = "phy",
+				      "common";
+
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss2_hsphy: phy@fde000 {
+			compatible = "qcom,x1e80100-snps-eusb2-phy",
+				     "qcom,sm8550-snps-eusb2-phy";
+			reg = <0 0x00fde000 0 0x154>;
+			#phy-cells = <0>;
+
+			clocks = <&tcsr TCSR_USB2_1_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_TERT_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss2_qmpphy: phy@fdf000 {
+			compatible = "qcom,x1e80100-qmp-usb3-dp-phy";
+			reg = <0 0x00fdf000 0 0x4000>;
+
+			clocks = <&gcc GCC_USB3_TERT_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_TERT_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_TERT_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "com_aux",
+				      "usb3_pipe";
+
+			power-domains = <&gcc GCC_USB_2_PHY_GDSC>;
+
+			resets = <&gcc GCC_USB3_PHY_TERT_BCR>,
+				 <&gcc GCC_USB4_2_DP0_PHY_TERT_BCR>;
+			reset-names = "phy",
+				      "common";
+
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+
+			status = "disabled";
+		};
+
 		cnoc_main: interconnect@1500000 {
 			compatible = "qcom,x1e80100-cnoc-main";
 			reg = <0 0x1500000 0 0x14400>;
@@ -2659,6 +2781,331 @@ lpass_lpicx_noc: interconnect@7430000 {
 			#interconnect-cells = <2>;
 		};
 
+		usb_2_hsphy: phy@88e0000 {
+			compatible = "qcom,x1e80100-snps-eusb2-phy",
+				     "qcom,sm8550-snps-eusb2-phy";
+			reg = <0 0x088e0000 0 0x154>;
+			#phy-cells = <0>;
+
+			clocks = <&tcsr TCSR_USB2_2_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_USB20_HS_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss2: usb@a0f8800 {
+			compatible = "qcom,x1e80100-dwc3", "qcom,dwc3";
+			reg = <0 0x0a0f8800 0 0x400>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_TERT_AXI_CLK>,
+				 <&gcc GCC_USB30_TERT_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_TERT_AXI_CLK>,
+				 <&gcc GCC_USB30_TERT_SLEEP_CLK>,
+				 <&gcc GCC_USB30_TERT_MOCK_UTMI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_USB_NORTH_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_USB_SOUTH_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "noc_aggr",
+				      "noc_aggr_north",
+				      "noc_aggr_south",
+				      "noc_sys";
+
+			assigned-clocks = <&gcc GCC_USB30_TERT_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_TERT_MASTER_CLK>;
+			assigned-clock-rates = <19200000>,
+					       <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 58 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 57 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 10 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq",
+					  "ss_phy_irq";
+
+			power-domains = <&gcc GCC_USB30_TERT_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_TERT_BCR>;
+
+			interconnects = <&usb_south_anoc MASTER_USB3_2 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_USB3_2 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "usb-ddr",
+					     "apps-usb";
+
+			wakeup-source;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			usb_1_ss2_dwc3: usb@a000000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a000000 0 0xcd00>;
+
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+
+				iommus = <&apps_smmu 0x14a0 0x0>;
+
+				phys = <&usb_1_ss2_hsphy>,
+				       <&usb_1_ss2_qmpphy QMP_USB43DP_USB3_PHY>;
+				phy-names = "usb2-phy",
+				            "usb3-phy";
+
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,usb3_lpm_capable;
+
+				dma-coherent;
+
+				port {
+					usb_1_ss2_role_switch: endpoint {
+					};
+				};
+			};
+		};
+
+		usb_2: usb@a2f8800 {
+			compatible = "qcom,x1e80100-dwc3", "qcom,dwc3";
+			reg = <0 0x0a2f8800 0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB2_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB20_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB20_SLEEP_CLK>,
+				 <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_USB_NORTH_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_USB_SOUTH_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "noc_aggr",
+				      "noc_aggr_north",
+				      "noc_aggr_south",
+				      "noc_sys";
+
+			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB20_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 50 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 49 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "pwr_event",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq";
+
+			power-domains = <&gcc GCC_USB20_PRIM_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB20_PRIM_BCR>;
+
+			interconnects = <&usb_north_anoc MASTER_USB2 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_USB2 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "usb-ddr",
+					     "apps-usb";
+
+			wakeup-source;
+
+			status = "disabled";
+
+			usb_2_dwc3: usb@a200000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a200000 0 0xcd00>;
+				interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x14e0 0x0>;
+				phys = <&usb_2_hsphy>;
+				phy-names = "usb2-phy";
+				maximum-speed = "high-speed";
+
+				port {
+					usb_2_role_switch: endpoint {
+					};
+				};
+			};
+		};
+
+		usb_1_ss0: usb@a6f8800 {
+			compatible = "qcom,x1e80100-dwc3", "qcom,dwc3";
+			reg = <0 0x0a6f8800 0 0x400>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_NORTH_AHB_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_SOUTH_AHB_CLK>,
+				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "noc_aggr",
+				      "noc_aggr_north",
+				      "noc_aggr_south",
+				      "noc_sys";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>,
+					       <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 61 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq",
+					  "ss_phy_irq";
+
+			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			wakeup-source;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			usb_1_ss0_dwc3: usb@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a600000 0 0xcd00>;
+
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+
+				iommus = <&apps_smmu 0x1420 0x0>;
+
+				phys = <&usb_1_ss0_hsphy>,
+				       <&usb_1_ss0_qmpphy QMP_USB43DP_USB3_PHY>;
+				phy-names = "usb2-phy",
+					    "usb3-phy";
+
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,usb3_lpm_capable;
+
+				dma-coherent;
+
+				port {
+					usb_1_ss0_role_switch: endpoint {
+					};
+				};
+			};
+		};
+
+		usb_1_ss1: usb@a8f8800 {
+			compatible = "qcom,x1e80100-dwc3", "qcom,dwc3";
+			reg = <0 0x0a8f8800 0 0x400>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_USB_NORTH_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_USB_SOUTH_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "noc_aggr",
+				      "noc_aggr_north",
+				      "noc_aggr_south",
+				      "noc_sys";
+
+			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
+			assigned-clock-rates = <19200000>,
+					       <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 60 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 47 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq",
+					  "ss_phy_irq";
+
+			power-domains = <&gcc GCC_USB30_SEC_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_SEC_BCR>;
+
+			interconnects = <&usb_south_anoc MASTER_USB3_1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_USB3_1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "usb-ddr",
+					     "apps-usb";
+
+			wakeup-source;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			usb_1_ss1_dwc3: usb@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a800000 0 0xcd00>;
+
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+
+				iommus = <&apps_smmu 0x1460 0x0>;
+
+				phys = <&usb_1_ss1_hsphy>,
+				       <&usb_1_ss1_qmpphy QMP_USB43DP_USB3_PHY>;
+				phy-names = "usb2-phy",
+					    "usb3-phy";
+
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,usb3_lpm_capable;
+
+				dma-coherent;
+
+				port {
+					usb_1_ss1_role_switch: endpoint {
+					};
+				};
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,x1e80100-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;

-- 
2.34.1


