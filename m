Return-Path: <linux-kernel+bounces-42707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DB84055A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121BB286950
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D3D612F6;
	Mon, 29 Jan 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTgkIWJW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6A62A0F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532371; cv=none; b=OoMmYwzqUmZZcxlATU6Se3FyjZF9mmI9iHJ7YSJz+1MXT1b1cj9DtBfLO7u20W15l4MlLajYGvrH6muHMkdCH6V8pgzjnmnUw8eQw3JAkaNlhxWzVCY/AMpQIdkR5xiPaksny+z5Sep2qqsKO7l9KMSD3Hq7g5Bxm0/6FISqm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532371; c=relaxed/simple;
	bh=bQ9nY6y+749h7uc3TVc/XBh7v5agWPCE6eWTcKwDRAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/oZfFTBRQc5cHoKe32Spw3XqAK00dBR9gwhkrb9yhcF5KFVg5EP+dowmY6FfgYemx1JHoD2cn1N8x0O8hvDLT1q/uUtSWNrd0w5GWSSfxgurnKI3iFfF3mrj9fMYnHXnWRq/T2viy1P/C7GxPk8su27vHYYZsN2Ypkx7G8OjPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bTgkIWJW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so250170266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532367; x=1707137167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+yz9soX2acVnF/GYpskrWdSX3G41ibVCKEQCQUQg4c=;
        b=bTgkIWJWeM0B8cR8lO6mLRuN3Kfbsh0UCDYz9vxC5vMIuHtD3dMoejo1fDNVZ1aDvR
         0UEhiQ+/9kBT1yoO95+mjp6y/82qrNPp9dMyFSmxYb8tawIn26wRV+zJprwRyA6E5mkW
         MRN5Xfajn7RaYbyUwmSUBMyO3S8xmLeRXvPtywE5APm97N7IactpJxtN893sUX4cxGR5
         eWSI13HvQQu/UaIbNZiI3/JVhHRJws/1yqQiZFgkcg/QWIELqntFu46yfPwnEr1svz0v
         6wyvbuJoiIQ40F24Zk3nVJ6G3ULzJkXINVFCgm9Q5Q5Z0OkEfwaGbafbVFPcJo/UTrPB
         OV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532367; x=1707137167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+yz9soX2acVnF/GYpskrWdSX3G41ibVCKEQCQUQg4c=;
        b=ZibB8CDdgyJXzg02KUnI1SA6osuI/RyotjJ8tvxZUntkvwItt4sGwhKzbefpseklcd
         EY9xBMmvraBbj3UV74Ng1b1usWOrUiO+UI7WFBOjCMR73zIXzgZAT6Jh/h9R/k1dzpwG
         1PwIQxzV9QFKhdZtf6qjqSf8tOfCSeE/gbCXNZmgeG54ZcZeEz9cnW2JFp9PETBLydgm
         Y1wjBOH6LzfLw00A2HjtNUtcsPl9vwOSuFBzuELOx/RLOI14wVzU6O3684z5ZhFCMxZb
         b5eoHr7JACyaKQgvdFyUQpWNtXndufosYQjrzsFwdiL4Z9VBmZBtBA6g5O1vo86SUnZr
         Oykw==
X-Gm-Message-State: AOJu0YxRXaVF5mlf17YyYsjClUdNEVZm+Y4Xg3L3O3n2URsCkBQGOi1y
	iYYKBlAibRYxz3Vnbufo5xrIwAxRzovN+lNhxEWY0Y28kW5P6KgxZbvAV3/EzX8=
X-Google-Smtp-Source: AGHT+IH3ahiGKOcF/+rvx2NKTGbUJYWpIJpcLvQR89KzTal2kzysNyaWZpWTMXB1kX0HKyiG5hRPoA==
X-Received: by 2002:a17:906:7f90:b0:a35:1e25:5a2b with SMTP id f16-20020a1709067f9000b00a351e255a2bmr4454562ejr.38.1706532367098;
        Mon, 29 Jan 2024 04:46:07 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906329400b00a3527dba974sm3041495ejw.35.2024.01.29.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:46:06 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 14:45:39 +0200
Subject: [PATCH v6 07/11] arm64: dts: qcom: x1e80100: Add PCIe nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-dts-missing-nodes-v6-7-2c0e691cfa3b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8187; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=bQ9nY6y+749h7uc3TVc/XBh7v5agWPCE6eWTcKwDRAQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt53/25RMIlBhd+3toZf03E+jnzNDKrQTm1hGz
 9RiYeos9LqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbed/wAKCRAbX0TJAJUV
 Vs4nD/9qhNwN2J8WHXyh1dLPb5z1ZvU1IdGTZ6ahNbTFClx5asN7wnTctsprd7F8c/RYkRQ2PhU
 li16yAJo6gfQ+cOOcB+9BSGMQeNNf/9xp673y7IdDMdafjPFGGkNb2N38eQP228n8XMEisgYzB4
 pNazfkGf5ls9tOJy1RyJ111pg3yWncQ4NAP23vDZFTTEEoxchXMYa2Ef8Va6A6d5e/QZQxjKdSk
 D3xdO8ECfAaM972J5/GIWCCbWNEnE6fhenKW6e794kHpiyvmivpyCp5rcmxTb3uYYqKUfXs0Pv2
 YHN2CxqiYH+0fLG5bp3gYh89CTbrfWRY2gf7b+YdZSTFC2WKsuJ9Cz4oPbLGuGGVvLOy0W9Qc3c
 brU/S2PvIPEMKrpjhxgtHfo7u5pdyZHNRJPUOwzZYOwtrS0De+9zpnPnQfc3UwwtmiqowRcv4pS
 KLyuRbyYGdgLfPKnzcjrFEl1Qdfvc6nLRY7ejff6/wfz8zh1q9vAQ7N0khWkM3wZyZuLl0uaMNm
 jj1lCBgNd/JEXMXyBheY8ks1qMAuob8d9cnC71ds8CWeZrfXP886RIBfddlYUF4P+nMutOIlEku
 0WvtaQRnnIW0PMrT1oDVK8lmuvsSqeIun1rjprp2k1Px1omRd3QgufPXDWdTIkMgr7sTCGg6dKh
 SD42ovgKuqUmUCg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add nodes for PCIe 4 and 6 controllers and their PHYs for X1E80100 platform.

Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 242 ++++++++++++++++++++++++++++++++-
 1 file changed, 240 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index ee61e1cbc5af..20aa04aa80f7 100644
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
@@ -2722,6 +2722,244 @@ mmss_noc: interconnect@1780000 {
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
+			interrupts = <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 774 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 837 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 838 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 839 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 842 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
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
+				 <&gcc GCC_CFG_NOC_PCIE_ANOC_SOUTH_AHB_CLK>,
+				 <&gcc GCC_CNOC_PCIE_SOUTH_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "noc_aggr",
+				      "cnoc_sf_axi";
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
+				 <&gcc GCC_PCIE_6A_LINK_DOWN_BCR>;
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
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
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
+				 <&gcc GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK>,
+				 <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "noc_aggr",
+				      "cnoc_sf_axi";
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
+			resets = <&gcc GCC_PCIE_4_BCR>,
+				 <&gcc GCC_PCIE_4_LINK_DOWN_BCR>;
+			reset-names = "pci",
+				      "link_down";
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


