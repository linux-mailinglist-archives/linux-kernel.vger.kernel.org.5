Return-Path: <linux-kernel+bounces-21093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FEC8289B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4AB1C248DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918C3B195;
	Tue,  9 Jan 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEqXDbQJ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73B3A8CA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e490c2115so11961705e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 08:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704816364; x=1705421164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsW6MKnne1Me7VXJhdish3gRaLmNKsmUZrfRAuyzFtw=;
        b=ZEqXDbQJWEX2fnUzOWDffjWE5v305PYXci2yyLx4joKzybNbFHh97eyXiKeCSnImnR
         VlczKalWGzzPZHazAFAy61N8OhQ4dSHzFK5jFPd5LVpOsYl/wEG21KzpbrBKx69AX/04
         XZG+jeQHurEDVTKlRYquz5Vt7o9BYhNbzHYbsdzMksIKZ4NkuALIC1C8i+OSwhLsfcgu
         2dg1mAn7jjQnIB54WcRXRKG61ayBCqeX6H7PfHH49VqTJ6fZOGPgT9INg1qhmcc4wifg
         uZF5i2X4/ejOFwgZNolxdlzGfKuu1FngL0M37Cy3rxLkA3JhErmQHtMuymoREf1pC+9I
         6ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704816364; x=1705421164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsW6MKnne1Me7VXJhdish3gRaLmNKsmUZrfRAuyzFtw=;
        b=rYmn1C1eoTZMoiwNP5nFwpKXjI85j+cW+UrWEd3YKvP8mhkFMTh56nS3GKo6pxgvHN
         ZmNOZegOszgtBpGz6qrth5uE5m/l2s6TJpeh3CNqsUa4/GuEloB5k2lEHZ9ZutyDnXc7
         JvKmlir5Of6vr2HZJCp1oC/9X55dodmSCXc+C08ki1UcKsNQxXcUWZdh4eKJ/c4eR2lq
         lDTW04a8a7Z6+InG+rkpGPHuQnOFwD1hlvPbjmDMOGV2jM3+ofPHvElEPewvsKrKvKrC
         4G8Wf0j2pBivwBSK9uOMhv3jnYQuCO+inN+kGL399Vl/b2Cgof/3CTDGILJKLT5xTN94
         oPyw==
X-Gm-Message-State: AOJu0YyN+uRjTU886HsJr0t8pzcEKw928yhlPX3Q88MmUA/d1Ehs5dto
	ccuTpuAenAA1db0tHZZOfoyEfWG8OLq8eQ==
X-Google-Smtp-Source: AGHT+IEHVtZAxsWbfd8gbQN7gu7Y92VPYQ5+mwVILG9udM7Md9Np/8eRdbpMAehUxpLAsPo6c/hCVg==
X-Received: by 2002:a05:600c:600e:b0:40e:52cf:e7af with SMTP id az14-20020a05600c600e00b0040e52cfe7afmr347328wmb.130.1704816364775;
        Tue, 09 Jan 2024 08:06:04 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b0033762d4ad5asm2726490wrn.81.2024.01.09.08.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 08:06:04 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 09 Jan 2024 16:06:05 +0000
Subject: [PATCH v3 4/4] arm64: dts: qcom: sc8280xp: camss: Add CAMSS block
 definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-4-b8e3a74a6e6a@linaro.org>
References: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org>
In-Reply-To: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-4e032

Add CAMSS block definition for sc8280xp.

This drop contains definitions for the following components on sc8280xp:

VFE * 4
VFE Lite * 4
CSID * 4
CSIPHY * 4

This dtsi definition has been developed and validated on a Lenovo X13s
laptop.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 239 +++++++++++++++++++++++++++++++++
 1 file changed, 239 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index f48dfa5e5f36..35bc31117b41 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3614,6 +3614,245 @@ cci3_i2c1: i2c-bus@1 {
 			};
 		};
 
+		camss: camss@ac5a000 {
+			compatible = "qcom,sc8280xp-camss";
+
+			reg = <0 0x0ac5a000 0 0x2000>,
+			      <0 0x0ac5c000 0 0x2000>,
+			      <0 0x0ac65000 0 0x2000>,
+			      <0 0x0ac67000 0 0x2000>,
+			      <0 0x0acaf000 0 0x4000>,
+			      <0 0x0acb3000 0 0x1000>,
+			      <0 0x0acb6000 0 0x4000>,
+			      <0 0x0acba000 0 0x1000>,
+			      <0 0x0acbd000 0 0x4000>,
+			      <0 0x0acc1000 0 0x1000>,
+			      <0 0x0acc4000 0 0x4000>,
+			      <0 0x0acc8000 0 0x1000>,
+			      <0 0x0accb000 0 0x4000>,
+			      <0 0x0accf000 0 0x1000>,
+			      <0 0x0acd2000 0 0x4000>,
+			      <0 0x0acd6000 0 0x1000>,
+			      <0 0x0acd9000 0 0x4000>,
+			      <0 0x0acdd000 0 0x1000>,
+			      <0 0x0ace0000 0 0x4000>,
+			      <0 0x0ace4000 0 0x1000>;
+
+			reg-names = "csiphy2",
+				    "csiphy3",
+				    "csiphy0",
+				    "csiphy1",
+				    "vfe0",
+				    "csid0",
+				    "vfe1",
+				    "csid1",
+				    "vfe2",
+				    "csid2",
+				    "vfe_lite0",
+				    "csid0_lite",
+				    "vfe_lite1",
+				    "csid1_lite",
+				    "vfe_lite2",
+				    "csid2_lite",
+				    "vfe_lite3",
+				    "csid3_lite",
+				    "vfe3",
+				    "csid3";
+
+			interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 759 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 760 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 761 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 762 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 764 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "csid1_lite",
+					  "vfe_lite1",
+					  "csiphy3",
+					  "csid0",
+					  "vfe0",
+					  "csid1",
+					  "vfe1",
+					  "csid0_lite",
+					  "vfe_lite0",
+					  "csiphy0",
+					  "csiphy1",
+					  "csiphy2",
+					  "csid2",
+					  "vfe2",
+					  "csid3_lite",
+					  "csid2_lite",
+					  "vfe_lite3",
+					  "vfe_lite2",
+					  "csid3",
+					  "vfe3";
+
+			power-domains = <&camcc IFE_0_GDSC>,
+					<&camcc IFE_1_GDSC>,
+					<&camcc IFE_2_GDSC>,
+					<&camcc IFE_3_GDSC>,
+					<&camcc TITAN_TOP_GDSC>;
+
+			power-domain-names = "ife0",
+					     "ife1",
+					     "ife2",
+					     "ife3",
+					     "top";
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CSIPHY0_CLK>,
+				 <&camcc CAMCC_CSI0PHYTIMER_CLK>,
+				 <&camcc CAMCC_CSIPHY1_CLK>,
+				 <&camcc CAMCC_CSI1PHYTIMER_CLK>,
+				 <&camcc CAMCC_CSIPHY2_CLK>,
+				 <&camcc CAMCC_CSI2PHYTIMER_CLK>,
+				 <&camcc CAMCC_CSIPHY3_CLK>,
+				 <&camcc CAMCC_CSI3PHYTIMER_CLK>,
+				 <&camcc CAMCC_IFE_0_AXI_CLK>,
+				 <&camcc CAMCC_IFE_0_CLK>,
+				 <&camcc CAMCC_IFE_0_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_0_CSID_CLK>,
+				 <&camcc CAMCC_IFE_1_AXI_CLK>,
+				 <&camcc CAMCC_IFE_1_CLK>,
+				 <&camcc CAMCC_IFE_1_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_1_CSID_CLK>,
+				 <&camcc CAMCC_IFE_2_AXI_CLK>,
+				 <&camcc CAMCC_IFE_2_CLK>,
+				 <&camcc CAMCC_IFE_2_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_2_CSID_CLK>,
+				 <&camcc CAMCC_IFE_3_AXI_CLK>,
+				 <&camcc CAMCC_IFE_3_CLK>,
+				 <&camcc CAMCC_IFE_3_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_3_CSID_CLK>,
+				 <&camcc CAMCC_IFE_LITE_0_CLK>,
+				 <&camcc CAMCC_IFE_LITE_0_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_LITE_0_CSID_CLK>,
+				 <&camcc CAMCC_IFE_LITE_1_CLK>,
+				 <&camcc CAMCC_IFE_LITE_1_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_LITE_1_CSID_CLK>,
+				 <&camcc CAMCC_IFE_LITE_2_CLK>,
+				 <&camcc CAMCC_IFE_LITE_2_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_LITE_2_CSID_CLK>,
+				 <&camcc CAMCC_IFE_LITE_3_CLK>,
+				 <&camcc CAMCC_IFE_LITE_3_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_LITE_3_CSID_CLK>,
+				 <&gcc GCC_CAMERA_HF_AXI_CLK>,
+				 <&gcc GCC_CAMERA_SF_AXI_CLK>;
+
+			clock-names = "camnoc_axi",
+				      "cpas_ahb",
+				      "csiphy0",
+				      "csiphy0_timer",
+				      "csiphy1",
+				      "csiphy1_timer",
+				      "csiphy2",
+				      "csiphy2_timer",
+				      "csiphy3",
+				      "csiphy3_timer",
+				      "vfe0_axi",
+				      "vfe0",
+				      "vfe0_cphy_rx",
+				      "vfe0_csid",
+				      "vfe1_axi",
+				      "vfe1",
+				      "vfe1_cphy_rx",
+				      "vfe1_csid",
+				      "vfe2_axi",
+				      "vfe2",
+				      "vfe2_cphy_rx",
+				      "vfe2_csid",
+				      "vfe3_axi",
+				      "vfe3",
+				      "vfe3_cphy_rx",
+				      "vfe3_csid",
+				      "vfe_lite0",
+				      "vfe_lite0_cphy_rx",
+				      "vfe_lite0_csid",
+				      "vfe_lite1",
+				      "vfe_lite1_cphy_rx",
+				      "vfe_lite1_csid",
+				      "vfe_lite2",
+				      "vfe_lite2_cphy_rx",
+				      "vfe_lite2_csid",
+				      "vfe_lite3",
+				      "vfe_lite3_cphy_rx",
+				      "vfe_lite3_csid",
+				      "gcc_axi_hf",
+				      "gcc_axi_sf";
+
+			iommus = <&apps_smmu 0x2000 0x4e0>,
+				 <&apps_smmu 0x2020 0x4e0>,
+				 <&apps_smmu 0x2040 0x4e0>,
+				 <&apps_smmu 0x2060 0x4e0>,
+				 <&apps_smmu 0x2080 0x4e0>,
+				 <&apps_smmu 0x20e0 0x4e0>,
+				 <&apps_smmu 0x20c0 0x4e0>,
+				 <&apps_smmu 0x20a0 0x4e0>,
+				 <&apps_smmu 0x2400 0x4e0>,
+				 <&apps_smmu 0x2420 0x4e0>,
+				 <&apps_smmu 0x2440 0x4e0>,
+				 <&apps_smmu 0x2460 0x4e0>,
+				 <&apps_smmu 0x2480 0x4e0>,
+				 <&apps_smmu 0x24e0 0x4e0>,
+				 <&apps_smmu 0x24c0 0x4e0>,
+				 <&apps_smmu 0x24a0 0x4e0>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_CAMERA_CFG 0>,
+					<&mmss_noc MASTER_CAMNOC_HF 0 &mc_virt SLAVE_EBI1 0>,
+					<&mmss_noc MASTER_CAMNOC_SF 0 &mc_virt SLAVE_EBI1 0>,
+					<&mmss_noc MASTER_CAMNOC_ICP 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "cam_ahb",
+					     "cam_hf_mnoc",
+					     "cam_sf_mnoc",
+					     "cam_sf_icp_mnoc";
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				port@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				port@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+
 		camcc: clock-controller@ad00000 {
 			compatible = "qcom,sc8280xp-camcc";
 			reg = <0 0x0ad00000 0 0x20000>;

-- 
2.42.0


