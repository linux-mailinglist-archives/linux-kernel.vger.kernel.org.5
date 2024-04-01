Return-Path: <linux-kernel+bounces-126903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1D894434
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C843BB21A16
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C6D50271;
	Mon,  1 Apr 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKf8MqQW"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376184D59F;
	Mon,  1 Apr 2024 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992126; cv=none; b=daMCFfrAkCr/N0Bg1Kc4YlZaf5Y58o2N6h2lz2sHPN1fz6M4wFqhEbKZqVJelYlICpRk7mqSQpOlG8DTZt+hT5A95DEqfUVWr75vnfVZiJsThcKtNCxjw7fGA/1KXh/9gvW8v805NjjzDQmzTKLypTty/FQaHDlo7VD4lNc6nuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992126; c=relaxed/simple;
	bh=ZGuyczjhEAaFcL1aLiLuxg0XPqkkfM5zVph+1XjqoFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwZSM2HuPskTL7C7onVGBaaPSPDR0vOVxi88yWO3IhnNqzPGEOCFNdQ/lbthFbjYyy2Km2Z5BeSX1ZKkg/CEcVNR39826ubp+b57PlJeZx3vIm4XrcRRkxpJ9F5RlstgxOiYBtUkyYuIRsnqPkgTNnirFmrpTMGS5jJ8ZUfENGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKf8MqQW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44ad785a44so474855166b.3;
        Mon, 01 Apr 2024 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711992122; x=1712596922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl1YvK1CPJJI3lt4hFJM8stWerakJiAw8KgauLK1Qr0=;
        b=DKf8MqQWRdnEocpDsZo75gDvYAjdO1lDoBh0EAZtG44qvkVbLLPwlDWFScws3ZMDqW
         Z8TM4htutXLNzGvmIO4nPlps+kiZxNJEX3d5DHCkctyyMlPHtk5/53qFrWX5NpoF1pja
         MUmZyFB/1q3FaIzNuyOjyNNbWALfGm6VTCnRnzigJAY5ERQrqVpoDymYq+16R8aIwpWb
         bUbDkmaNDtVRUzUP2yqp27XAZCyUH7LuwC1d5llsekI36ZJhO9aHBmEW9TVddTgcWplW
         XUi5+j2vU74P7UNeELkX/JG1kMRPTozLcYXYv0eLjpQaQ+qPYqDqGEdwnp9ihnmOIaT3
         M5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992122; x=1712596922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xl1YvK1CPJJI3lt4hFJM8stWerakJiAw8KgauLK1Qr0=;
        b=JHqnJcyLuq1ZMv7J4+3FHv79I9pmdjuuOwvFLRmUTtxZqPcDIUY0J2Hd8jRF3W/Pcd
         89QxLeWTvmUa8yCQUgoYMzEDxHGVRakEIhJF7o0ilBnXq60QAPOWVk8fikTc3dWZzwPz
         TYtK2JiT1RVW8tlSgN6qZJNEUm5B0DvGj0WV2F2RtOvlTiYaJhBC/DIFAO1+QooxE8EU
         nIpuQ2aU8tysywU7+AHEOqSBtQ8yYBQxQzTqaBNUfscVyVbinrvCmBZP8hu3Iqgvpgwb
         3J33GIK4wn0+5XM9fiZNhOXNn/hbf/vWdqloRD0jY4/z3sEwibjyhi3nq344QkZJkTNQ
         W61A==
X-Forwarded-Encrypted: i=1; AJvYcCWXBcBi0aG6BhzKRVIUCr3ND2AENS54ZGV9Z0UMomPNNAerPzGzBSMztH7QksEpIS9zTP0mJSGn64/Qh7P+0YKTK5/7Sx4k0w+92k4IE4CYOrcgUZD9/BBzvk+1hXSaceSNZ3NbWkEYLBYs188J8y9sePXomIbnjmQcYmb9La0Q/Jsl3W7dLKw=
X-Gm-Message-State: AOJu0YxNRvr4/TG7cRoFMeuqI4GyfWjodiBWvP+/SuG5C5TYwvDplGwC
	MBkK1yAKwZTxxbxbLf27PK6HgW47kt/1GdUZG6T/A2PY2BTWwMKBeYEa9w/tjXs=
X-Google-Smtp-Source: AGHT+IEdMmX0GpUtGWuReUSISOs+DMtnMvskHgxIYrrpZoPbKLvGjrYalDybzDxsYZp8AVzQQKZT+w==
X-Received: by 2002:a17:906:8312:b0:a46:206d:369b with SMTP id j18-20020a170906831200b00a46206d369bmr5996492ejx.28.1711992121968;
        Mon, 01 Apr 2024 10:22:01 -0700 (PDT)
Received: from localhost.localdomain (ccu40.neoplus.adsl.tpnet.pl. [83.30.144.40])
        by smtp.gmail.com with ESMTPSA id xi7-20020a170906dac700b00a4e23486a5dsm5347949ejb.20.2024.04.01.10.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:22:01 -0700 (PDT)
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
Subject: [PATCH v2 2/4] arm64: dts: qcom: msm8976: Add MDSS nodes
Date: Mon,  1 Apr 2024 19:21:51 +0200
Message-Id: <20240401172153.9231-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401172153.9231-1-a39.skl@gmail.com>
References: <20240401172153.9231-1-a39.skl@gmail.com>
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
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 274 +++++++++++++++++++++++++-
 1 file changed, 270 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 8bdcc1438177..6be310079f5b 100644
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
@@ -808,6 +808,272 @@ tcsr: syscon@1937000 {
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
+				reg = <0x01a94000 0x25c>;
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
+				power-domains = <&gcc MDSS_GDSC>;
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


