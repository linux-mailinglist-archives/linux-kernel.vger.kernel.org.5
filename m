Return-Path: <linux-kernel+bounces-35147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F9F838CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F3A28A28E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262125F85F;
	Tue, 23 Jan 2024 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSEvoXXI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6B5EE7C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007728; cv=none; b=fs13McTmFolk7UOJEksDgUQan53505+DG60/2OltawSlpE+pSiMWcN9geOCzUUrhjY5z7UxyYKkp4nEZ997FXcHy79HNnVli6j5Hd4VLCjqVCFgprrN8oGrmLn3eF0H7+HY3E5A99IVfKGB+ieZUHLT6n6HPgECxccfzaXAxeOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007728; c=relaxed/simple;
	bh=WlZvSg3g3+iUx/DPLfURhwayOBYwD3zvIJuIBzwYn0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixCWrA5XcsEb4bm7Q1d9ePMi3Opcn5ti5BXZhcfnZ+dxjJ3+RKxw3LYfbc4vgdXsu4zJATjMU/94vjA/BWf2HTdzQj00GAfma29YVSUtaxgl22adCGGLJj/8jF+2iTbBdJsc2q2niJ7h+e9CRu80CdOkfU9j3707+IA36N0Uw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RSEvoXXI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cdeb80fdfdso46410031fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706007721; x=1706612521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+9F6d8+D/FNREDWF9KdEDYyK4C36rn452C58aRuJso=;
        b=RSEvoXXIcx97rlDU9WfpNxTLSfWBJor24+fFD7zJlPTGsQ9a4XQOO3yqjNgBtkDRZM
         KN+Esha3rpVrYIGA5QL+C8KLJuxLWM4JJuncr0T1vxKPTAwfgqyntesCWcLU6jCxTN+J
         ZyugizOCDTOMc0ezp5I1mwCTjfA2W/2lviL8VMdm9b5kkIMia0YFVH5wkDaju8/i7CwD
         955qDfrmNVOH9TvanfNWkZB66RUMfSdIwJbyNdv7qKF2r90oH/HauAOhrTopbTSOXM7F
         BxAMfD2vahhQTt49GoZbH4OJYAhZgGviIYaPZ32YuE7YGUq7Idc0qbZ1sLnd0b5PtGEV
         r3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007721; x=1706612521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+9F6d8+D/FNREDWF9KdEDYyK4C36rn452C58aRuJso=;
        b=OJV9EasdIqymwFZPeCUh0E5uLDu9gbadcj0xsvvb+fc34jfNFKqr8CSG0ljsWwHC1w
         xC5nhw+87zLdPZXceEBIDtnavS4pMs9h+wriDXO4rEL0fBAiGuGJk7YuY0EXQCOLUgAl
         u8/fygkXxr6tJT/2g1+jU23vZU9GObhwxNThljnM/R1O9MvFLS20L0+l9layg36hsGye
         IHHu98gypH3dEhj57m8qYLEHYNr/8F4eRmBIt5bgCQsVnA10sTbM32OSJPPvBXFujNEF
         iH73YEqUc57/2DdzqV5c7rvNTGdv+sd3W0/uROm/9pUpFy7bE3IYNfYs5b/eD93G1jWl
         mMcA==
X-Gm-Message-State: AOJu0YxvQCNPOC/6ShDXyPATZ6bczME7uOrmsIuf7/qxZqbzzQkknRn6
	T/hJ3UT2fJXteoE5zypkGCHXXGQ8jclXBdhOFCzFve2XLFsAiG+xcH6bL9S9tVA=
X-Google-Smtp-Source: AGHT+IEGhj76EYbP4+YfgDx6nvq51t54qA+1iJqherEfwdpyzwBoDWz59sqP21kDew2Sn4KFLWv9dg==
X-Received: by 2002:a2e:930b:0:b0:2cd:463f:2c35 with SMTP id e11-20020a2e930b000000b002cd463f2c35mr1128267ljh.66.1706007721264;
        Tue, 23 Jan 2024 03:02:01 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm11430074edb.45.2024.01.23.03.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:02:00 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 23 Jan 2024 13:01:21 +0200
Subject: [PATCH v4 07/11] arm64: dts: qcom: x1e80100: Add PCIe nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-x1e80100-dts-missing-nodes-v4-7-072dc2f5c153@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7289; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=WlZvSg3g3+iUx/DPLfURhwayOBYwD3zvIJuIBzwYn0s=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlr5yYwX0bnfrJ15hIMuAZV2TBtEj7Az0OkixHz
 613D0ffCYuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZa+cmAAKCRAbX0TJAJUV
 Vms5D/4mYJ9EzAERiOvRBboaobNyCisSdGEVk5+r2nQsatIuIHOV52Fm11SCf+FJpyL3BMi0/gv
 52It5uv+uq4KyhK3BGJ+gxIzL3W2Ol7KPRWAVfW7Mc7OV+Kyu3F+cFAeIrhBEIhsZ51coNe7iR0
 XNPMVKm1pYKafa41Z1bXtHmeIRd/nFsTKmJcpR3UMyalgSCD7BWVYxCD1xggZyYWm20ORaEDaaP
 XHzZ3yKcoOX7ynDwiWjvbZ+Vx4uK62TYO1GsmuxqPIWkDdAu0rclsImgCCI6GX+RUDZ5phGeENu
 tT3SMcFHNefsyADOtxnhvYgqsmsT+mOJPR7IpMlk293Dq7ES7LFsRmz+G7JIjKcgtmhU74UQ4JJ
 kx4XAeqJByvePSSwwON70XgwB87G1e8XWTu1w5DnoZnDQgz47vxbVFJt8oxKgAWQPvqIHa8TBh5
 m8oO67Q3FgCGfnGo2gjQ2pYons93vWcOdk7sL40fOdUMXBNs7PA/p4+zZDIis/jDvHWNfyUytA4
 4SghnWm1PL1MSgs0Or/uiA74agb45Up+U61fsBcdfg5uDz7h0cOnWjVPGX9gbA+MYZ9UUcbXQAc
 KDiaPYPwCVSuCvBvprhV3qi+1BpYSShS9IIRZkTDHWBOxeeylg3tcCCEy7S452r7S50DG7v93i4
 K6+vvg0N98+OIqA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add nodes for PCIe 4 and 6 controllers and their PHYs for X1E80100 platform.

Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 214 ++++++++++++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 593ead89706c..e8d2ea2b26ed 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -732,9 +732,9 @@ gcc: clock-controller@100000 {
 			clocks = <&bi_tcxo_div2>,
 				 <&sleep_clk>,
 				 <0>,
+				 <&pcie4_phy>,
 				 <0>,
-				 <0>,
-				 <0>,
+				 <&pcie6a_phy>,
 				 <0>,
 				 <&usb_1_ss0_qmpphy QMP_USB43DP_USB3_PIPE_CLK>,
 				 <&usb_1_ss1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>,
@@ -2722,6 +2722,216 @@ mmss_noc: interconnect@1780000 {
 			#interconnect-cells = <2>;
 		};
 
+		pcie6a: pci@1bf8000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-x1e80100";
+			reg = <0 0x01bf8000 0 0x3000>,
+			      <0 0x70000000 0 0xf1d>,
+			      <0 0x70000f20 0 0xa8>,
+			      <0 0x70001000 0 0x1000>,
+			      <0 0x70100000 0 0x100000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0 0x00000000 0 0x70200000 0 0x100000>,
+				 <0x02000000 0 0x70300000 0 0x70300000 0 0x3d00000>;
+			bus-range = <0 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <7>;
+			num-lanes = <2>;
+
+			interrupts = <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 843 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 844 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 845 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 772 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_6A_AUX_CLK>,
+				 <&gcc GCC_PCIE_6A_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_6A_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_6A_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_6A_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_CNOC_PCIE_SOUTH_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "noc_aggr_south_sf";
+
+			assigned-clocks = <&gcc GCC_PCIE_6A_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&pcie_south_anoc MASTER_PCIE_6A QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &cnoc_main SLAVE_PCIE_6A QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			resets = <&gcc GCC_PCIE_6A_BCR>,
+				<&gcc GCC_PCIE_6A_LINK_DOWN_BCR>;
+			reset-names = "pci",
+				      "link_down";
+
+			power-domains = <&gcc GCC_PCIE_6A_GDSC>;
+
+			phys = <&pcie6a_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie6a_phy: phy@1bfc000 {
+			compatible = "qcom,x1e80100-qmp-gen4x2-pcie-phy";
+			reg = <0 0x01bfc000 0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_6A_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_6A_CFG_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_PCIE_6A_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_6A_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "rchng",
+				      "pipe";
+
+			resets = <&gcc GCC_PCIE_6A_PHY_BCR>,
+				 <&gcc GCC_PCIE_6A_NOCSR_COM_PHY_BCR>;
+			reset-names = "phy",
+				      "phy_nocsr";
+
+			assigned-clocks = <&gcc GCC_PCIE_6A_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc GCC_PCIE_6_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie6a_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		pcie4: pci@1c08000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-x1e80100";
+			reg = <0 0x01c08000 0 0x3000>,
+			      <0 0x7c000000 0 0xf1d>,
+			      <0 0x7c000f40 0 0xa8>,
+			      <0 0x7c001000 0 0x1000>,
+			      <0 0x7c100000 0 0x100000>,
+			      <0 0x01c0b000 0 0x1000>;
+			reg-names = "parf",
+			            "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0 0x00000000 0 0x7c200000 0 0x100000>,
+				 <0x02000000 0 0x7c300000 0 0x7c300000 0 0x3d00000>;
+			bus-range = <0x00 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <5>;
+			num-lanes = <2>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
+				 <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_4_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_4_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_4_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "noc_aggr_south_sf";
+
+			assigned-clocks = <&gcc GCC_PCIE_4_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&pcie_south_anoc MASTER_PCIE_4 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &cnoc_main SLAVE_PCIE_4 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			resets = <&gcc GCC_PCIE_4_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc GCC_PCIE_4_GDSC>;
+
+			phys = <&pcie4_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie4_phy: phy@1c0e000 {
+			compatible = "qcom,x1e80100-qmp-gen3x2-pcie-phy";
+			reg = <0 0x01c0e000 0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
+				 <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_PCIE_4_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_4_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "rchng",
+				      "pipe";
+
+			resets = <&gcc GCC_PCIE_4_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_4_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc GCC_PCIE_4_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie4_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;

-- 
2.34.1


