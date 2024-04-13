Return-Path: <linux-kernel+bounces-143821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B7B8A3DD8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9265282150
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C67C54645;
	Sat, 13 Apr 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk/s9oIx"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798B524C9;
	Sat, 13 Apr 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027813; cv=none; b=kuKhb4kwdrmG4iI5HN4Bic6SUgmX9GeUxGoKjl7LHQrNs4Kxmq1EZ+7q0wz8o+qzwUCOb7KKYUw5xpyEoSlGfqZbfcvptuBmZGslx2E6KkVowwrVp36qMdHOsng+si34JBmVMSHZ5yuWrJU5rmMpXC40cjOxznOUSv21qXzkkN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027813; c=relaxed/simple;
	bh=2tQ70+ZaUbqufNWVJyUilsZsVMQfboTc7YgIhE7YMns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/gKcS8TXta3zQEfxglvRVInyUFOs0CRSPIYcC50GnqYp1znWK+m1goPDqrJq3xYJ+kbw87N0TVpgJiINfA3DWVUP2JF51nfkmNVJJCz3TQB2B3s6d0RvebHuge8TA2Lz/lKLjOjw+OyBWsm2AreKP2nUcW5VAEdTSCIdowY3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk/s9oIx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51969e780eso248658566b.3;
        Sat, 13 Apr 2024 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713027809; x=1713632609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KU7i/NV0S2g66ctxcCrl5uuV8PILJDyWSR9ZEdyYzY=;
        b=Sk/s9oIxMSQVS2wPCXnZQWJsLZsv+aGZ7Y6ccRmnq9EGSabl/hIxKrDLXkUmDNn2+K
         utygbtCxiZnu54USdHGaOauisxe0fF5ikSDlRtwnyZoZx2e30Vel4Trk4Te4fAhWvu5k
         WbSuddD5uqYuQpEYcrcZ3/pOW4V0WgajaItVFTAq9NqLhUn2Eid2vU42CdYXpNI+KlOA
         0CvsQkHilM+YMFsW2NAWsSZGcR2qSqhIOKBkx5rhyxqJyTR0EVyDCzOYL41KZcNXdbLP
         LVS8FVvdK7FSS20//eXcm588uln4T/nugd2c20DhT8vRiV+x0ej8Ue9xRqh8Fp0XmurA
         pPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713027809; x=1713632609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KU7i/NV0S2g66ctxcCrl5uuV8PILJDyWSR9ZEdyYzY=;
        b=esaRyEnrcqEydqQr8sfs4ODWiowlGCv/1s6QpWowpxpJ7CBZWXClRi7qDjId0S5xHg
         Fv045wwjZ6Tj/qeTvI3q00PzWuv3LfKqrg9XRGdZJm/EdTWHZWVe+H1VBRpfkIwwQjbz
         JGUS7CU0kCPmEhNbm2tTIAt/VbrChOq1UORawoMQmXdMSrZ8ZANTEuxQHko3C+M3q7i9
         xiW7cKp1VP+go60Lb0efatanDITTk5WUHFufdiVQBdD3mdgnxR/UrSigX5eVP1FXq1A5
         IopLOjxevKVAJrX2n7N682SAPAB2M5xELUWJt+zHGilgZU6Q5EyunNdQehi3/qDXOEJu
         /mBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOCO7o0V2q9QINxxpaCnPU8HyKeCFREVjeGdDhDtBCCfgz3rgkXwUaXf5NaSTJM553ao3J4Zlu9aMwEQrtU+m7aFdSOs3yjQla0jdHKpJUeXxkv4K6GyS+3nEvlrNFiU16CKAt3jDJgzBxaqU+xB6hkBixj2vfI/RGXi66kn0zW72AqmfzpFA=
X-Gm-Message-State: AOJu0YwYkC6voPGws+he/Opt8IgoQhXtkqiWYAaYQP7ZTceuyaPc8CAj
	JEAf5ESRQki8yly/XiPy6260Tt+ROsqTpIynKXJdpfQBBmO+cnzpcfR9pQ==
X-Google-Smtp-Source: AGHT+IGigZ2D0QZzzvHVJX8G/oHC1KgpJHnlk49d9LdYjCHNO5NeRgTyUMwlv6C4gMrE5ao5ZPB0hw==
X-Received: by 2002:a17:906:3416:b0:a52:5486:283a with SMTP id c22-20020a170906341600b00a525486283amr682258ejb.31.1713027809329;
        Sat, 13 Apr 2024 10:03:29 -0700 (PDT)
Received: from localhost.localdomain (ccu225.neoplus.adsl.tpnet.pl. [83.30.144.225])
        by smtp.gmail.com with ESMTPSA id kj15-20020a170907764f00b00a51a60bf400sm3195967ejc.76.2024.04.13.10.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 10:03:28 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] arm64: dts: qcom: msm8976: Add MDSS nodes
Date: Sat, 13 Apr 2024 19:03:15 +0200
Message-Id: <20240413170317.34553-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240413170317.34553-1-a39.skl@gmail.com>
References: <20240413170317.34553-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MDSS nodes to support displays on MSM8976 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 280 +++++++++++++++++++++++++-
 1 file changed, 276 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 8bdcc1438177..ce15c6ec9f4e 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -785,10 +785,10 @@ gcc: clock-controller@1800000 {
 
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&rpmcc RPM_SMD_XO_A_CLK_SRC>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>;
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi0_phy 0>,
+				 <&mdss_dsi1_phy 1>,
+				 <&mdss_dsi1_phy 0>;
 			clock-names = "xo",
 				      "xo_a",
 				      "dsi0pll",
@@ -808,6 +808,278 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x30000>;
 		};
 
+		mdss: display-subsystem@1a00000 {
+			compatible = "qcom,mdss";
+
+			reg = <0x01a00000 0x1000>,
+			      <0x01ab0000 0x3000>;
+			reg-names = "mdss_phys", "vbif_phys";
+
+			power-domains = <&gcc MDSS_GDSC>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clocks = <&gcc GCC_MDSS_AHB_CLK>,
+				 <&gcc GCC_MDSS_AXI_CLK>,
+				 <&gcc GCC_MDSS_VSYNC_CLK>,
+				 <&gcc GCC_MDSS_MDP_CLK>;
+			clock-names = "iface",
+				      "bus",
+				      "vsync",
+				      "core";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			status = "disabled";
+
+			mdss_mdp: display-controller@1a01000 {
+				compatible = "qcom,msm8976-mdp5", "qcom,mdp5";
+				reg = <0x01a01000 0x89000>;
+				reg-names = "mdp_phys";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				clocks = <&gcc GCC_MDSS_AHB_CLK>,
+					 <&gcc GCC_MDSS_AXI_CLK>,
+					 <&gcc GCC_MDSS_MDP_CLK>,
+					 <&gcc GCC_MDSS_VSYNC_CLK>,
+					 <&gcc GCC_MDP_TBU_CLK>,
+					 <&gcc GCC_MDP_RT_TBU_CLK>;
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "vsync",
+					      "tbu",
+					      "tbu_rt";
+
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&gcc MDSS_GDSC>;
+
+				iommus = <&apps_iommu 22>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mdss_mdp5_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_mdp5_intf2_out: endpoint {
+							remote-endpoint = <&mdss_dsi1_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-177780000 {
+						opp-hz = /bits/ 64 <177780000>;
+						required-opps = <&rpmpd_opp_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmpd_opp_svs_plus>;
+					};
+
+					opp-320000000 {
+						opp-hz = /bits/ 64 <320000000>;
+						required-opps = <&rpmpd_opp_nom>;
+					};
+					opp-360000000 {
+						opp-hz = /bits/ 64 <360000000>;
+						required-opps = <&rpmpd_opp_turbo>;
+					};
+				};
+			};
+
+			mdss_dsi0: dsi@1a94000 {
+				compatible = "qcom,msm8976-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+				reg = <0x01a94000 0x300>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				clocks = <&gcc GCC_MDSS_MDP_CLK>,
+					 <&gcc GCC_MDSS_AHB_CLK>,
+					 <&gcc GCC_MDSS_AXI_CLK>,
+					 <&gcc GCC_MDSS_BYTE0_CLK>,
+					 <&gcc GCC_MDSS_PCLK0_CLK>,
+					 <&gcc GCC_MDSS_ESC0_CLK>;
+				clock-names = "mdp_core",
+					      "iface",
+					      "bus",
+					      "byte",
+					      "pixel",
+					      "core";
+
+				assigned-clocks = <&gcc GCC_MDSS_BYTE0_CLK_SRC>,
+						  <&gcc GCC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>,
+							 <&mdss_dsi0_phy 1>;
+
+				phys = <&mdss_dsi0_phy>;
+
+				operating-points-v2 = <&dsi0_opp_table>;
+				power-domains = <&gcc MDSS_GDSC>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mdss_dsi0_in: endpoint {
+							remote-endpoint = <&mdss_mdp5_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_dsi0_out: endpoint {
+						};
+					};
+				};
+
+				dsi0_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-125000000 {
+						opp-hz = /bits/ 64 <125000000>;
+						required-opps = <&rpmpd_opp_svs>;
+
+					};
+
+					opp-161250000 {
+						opp-hz = /bits/ 64 <161250000>;
+						required-opps = <&rpmpd_opp_svs_plus>;
+					};
+
+					opp-187500000 {
+						opp-hz = /bits/ 64 <187500000>;
+						required-opps = <&rpmpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss_dsi1: dsi@1a96000 {
+				compatible = "qcom,msm8976-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+				reg = <0x01a96000 0x300>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <5>;
+
+				clocks = <&gcc GCC_MDSS_MDP_CLK>,
+					 <&gcc GCC_MDSS_AHB_CLK>,
+					 <&gcc GCC_MDSS_AXI_CLK>,
+					 <&gcc GCC_MDSS_BYTE1_CLK>,
+					 <&gcc GCC_MDSS_PCLK1_CLK>,
+					 <&gcc GCC_MDSS_ESC1_CLK>;
+				clock-names = "mdp_core",
+					      "iface",
+					      "bus",
+					      "byte",
+					      "pixel",
+					      "core";
+
+				assigned-clocks = <&gcc GCC_MDSS_BYTE1_CLK_SRC>,
+						  <&gcc GCC_MDSS_PCLK1_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi1_phy 0>,
+							 <&mdss_dsi1_phy 1>;
+
+				phys = <&mdss_dsi1_phy>;
+
+				operating-points-v2 = <&dsi0_opp_table>;
+				power-domains = <&gcc MDSS_GDSC>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mdss_dsi1_in: endpoint {
+							remote-endpoint = <&mdss_mdp5_intf2_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_dsi1_out: endpoint {
+						};
+					};
+				};
+			};
+
+			mdss_dsi0_phy: phy@1a94a00 {
+				compatible = "qcom,dsi-phy-28nm-hpm-fam-b";
+				reg = <0x01a94a00 0xd4>,
+				      <0x01a94400 0x280>,
+				      <0x01a94b80 0x30>;
+				reg-names = "dsi_pll",
+					    "dsi_phy",
+					    "dsi_phy_regulator";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_MDSS_AHB_CLK>,
+					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface", "ref";
+
+				status = "disabled";
+			};
+
+			mdss_dsi1_phy: phy@1a96a00 {
+				compatible = "qcom,dsi-phy-28nm-hpm-fam-b";
+				reg = <0x01a96a00 0xd4>,
+				      <0x01a96400 0x280>,
+				      <0x01a96b80 0x30>;
+				reg-names = "dsi_pll",
+					    "dsi_phy",
+					    "dsi_phy_regulator";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_MDSS_AHB_CLK>,
+					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface", "ref";
+
+				status = "disabled";
+			};
+		};
+
 		apps_iommu: iommu@1ee0000 {
 			compatible = "qcom,msm8976-iommu", "qcom,msm-iommu-v2";
 			reg = <0x01ee0000 0x3000>;
-- 
2.44.0


