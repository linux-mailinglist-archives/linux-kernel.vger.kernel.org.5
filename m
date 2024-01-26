Return-Path: <linux-kernel+bounces-39973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0883D7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C519E29C09D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D57F5BAF9;
	Fri, 26 Jan 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W55Ko++Z"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D75B202
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263246; cv=none; b=DsN/Z2Z+/nzzB6IxuFqSeFZK4b5GHVlYSmhN9l2nS3zFN8EWGKfBIxAHLVKjcJBVNIN0franQpBkXQte5AtuareGg5Waup0fjIzjTfybVEEzDmwnD62KM7thJowb++yFbujUjEhqERb0aQ8DZbiiD+nTb90X7MJO3grsHGJpPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263246; c=relaxed/simple;
	bh=DshW4j3Ktyit77GTVVUiuEOOwTL+lBbJ5E5pv8ACsYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ri1j3qEdfwltvgVpMaYaEG/Jz2IkKMlmFFDtCLDUiVh47XG5kB3o2myBaknwqpsQK9JQc3KNPQoOmNQV8E//4HbQ42/9e6D51ECnw5bdMJm9pqfYYiQeqBHStjar+CGG0EI12r29TDc0yipiE3Hjo8zjr0LPl53Zq8cciQppsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W55Ko++Z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a34afe3bdf0so20756366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706263242; x=1706868042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zh7j3OqaaRH9Np+0YzNoUQKfCzodISxdPy07TfhXVjI=;
        b=W55Ko++ZOqgVtN+uAM8n5/b83X2ywUJUWVbf7PM5RkICdEfpt6uqM3m6QAPIFou3+2
         XRUxW9NJbmFxy/Rj2QXU2dsVqMYctaDYoxO/2/T+GxxwHiOkSzCp1AQbu0Zaqv60FdOW
         XkD6l0k0E7dSPvYPhH81HPWdZVabeCjw75euvNKwIVAvmIDF+sgVQdeVDahef+wPYY3h
         bQmPz7qhay0vi5Nqin1tIll/56Eno+ylStjD1MAtoXVxlgOGU+KALRzsQH0zbDlzBswD
         kPnHV98B2qSTL69b9XhSssySnMG0u1rMLG6/qt/lNbaixITX5QdP4oQhD8FH7KR21JpL
         0oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706263242; x=1706868042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh7j3OqaaRH9Np+0YzNoUQKfCzodISxdPy07TfhXVjI=;
        b=bTwVLIs9GB47Et+81c/IKjof2UTk5E4OIPwCj59CH8MyU1fq8WJ7n5PSCKPtJNEyTw
         R8Xf0BGwRGAIvZtYuy7ITQqdEDI4ahLVA8V3sFYkXSBgdiF1/M7C36aBuIYH0UV+fdyY
         4CajBRmTLR194kbJBXr7PKs2xObMZyVqeNgdLk1EWqgvJoOQpBKq7ndKO1r8bsJPpsEa
         XoQMAVZLTy4Twbty1iGvw+j5UvX1M4a1HxR59wwA5EcjSt4f4sJ+QWgilsWco5YfMXKV
         W5NqQ7hSzc5br9/S6Iko8HX9InZcPBURC2681+R+3ros/NmAd+3q7czdponSrwkUkP3k
         mYuQ==
X-Gm-Message-State: AOJu0Yzv+S+QDrCFfnD45yWbI4rTWuimKChMO2MJSKaBAXsuERWsGqNd
	rYP5caBdeu6NI4Fr7dl6DMoqUWAuBq7ReT6/JBwDem6XqLb/aLAGpMFyPCqto7A=
X-Google-Smtp-Source: AGHT+IEmfcqIpYafZ21tgrU9dn+5E9kir8ijdUpiL1X4GWihAFXlWLTj/kkEiBDWjReqsMa9p57afA==
X-Received: by 2002:a17:906:e090:b0:a35:103e:3619 with SMTP id gh16-20020a170906e09000b00a35103e3619mr32565ejb.32.1706263242205;
        Fri, 26 Jan 2024 02:00:42 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id ox27-20020a170907101b00b00a3221b95ce8sm448494ejb.77.2024.01.26.02.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 02:00:41 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 26 Jan 2024 12:00:17 +0200
Subject: [PATCH v5 06/11] arm64: dts: qcom: x1e80100: Add USB nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-x1e80100-dts-missing-nodes-v5-6-3bb716fb2af9@linaro.org>
References: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
In-Reply-To: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=14263; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=DshW4j3Ktyit77GTVVUiuEOOwTL+lBbJ5E5pv8ACsYI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBls4K7Giw68am0LdKiUExT5/eiMne5HRDE1HsNu
 C7WHvRgrnaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbOCuwAKCRAbX0TJAJUV
 Vo60D/49naVkteH9P4FU1d9dF0hnk7jdFl2jFDrMoM7EShWz3jE8nDV9bI/VJ6/ScXiV/RlSUFq
 mmgdv86jbyfoF5JOkxdHQ5qhnVvQY4RISqDdJYBRia9Vvf+h7Q5lJZ/2t64V9ECHoQK+zPPqTfr
 nDn0y2JiQhBV042K3CmnZqU9dDAtTBd1zoNjjinJ1vT7XYnOCBA/jnzKc85JhOeryCM12qj5mRC
 BgJIMaCTbyobwY9+f6KfDx5c/Zeo2gbTXOCwSHwyavRPe6kphiFkpLdk3OigIAJ73BFw66vozOM
 WGoGOHP/xYnu5M2xexLi0c9ETgNOxzshSiGcC8vWbb73iGeIqhArGSjmDTz/wTgos6hhQuk9FnE
 UsSnECHCKhsnvrgSGfdf7gW63i8SGwYmbG+aqDEZRRxwqhLPNBiBuUs8bhRwxgOIZpZ/nHZsFvb
 3bhlWSS9/R6Zt5U8wuTc2fX3/Vb3W9b8uC7bi+4Iwi7FsIOM11e7QjbzmcCb0XfxwZzbmUbCC9D
 KzJIEZcO4Y3qquRRDJdbcikKDWHJ1OyRF6F7kdVKFARiuwyGjyY39Udb6Ir0X2lnx4pH1G/EsWP
 0K5lCTL+tlmBAEZK1aFgXQ/VgQgIVnemnoa407vf5Mkhe1OOROPwLDBkCm/Je1yZJfXOgbM8XEK
 CW/CMYtE46G75QQ==
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
index 2b6c55a486b2..ddf2e6e44e7e 100644
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
+					      <&pdc 57 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 58 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 10 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq",
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
+					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 61 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq",
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
+					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 60 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 47 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq",
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


