Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523E8770F9F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHEM04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHEM0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 08:26:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE344BD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 05:26:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe0c566788so4877249e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691238409; x=1691843209;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2M8seZm4mcc6ofT1Ofdd3q1hIoUcJq7DIb3vYvEj/Gw=;
        b=s84it7D1VBF8Vl9a0Uln27zK4MOQeBpvNCvZhfdEq4eCNFRbLVQ+29K0pummggDGE7
         lYr4wyjT1XnbfJu03CqTtOdaUKbYrhTrNLs0lPTLmBYGFCNeyU2ea+tocHQyk4KNAABu
         naWynlBX7lPP05CdogNUI+A4U7QCMVwnDbNbHqzgo0FFbaFgVYyJZZu9luSockhxZj3p
         sJI9/o8c0IxvKFEeI/vg2QXWlld6FfqNuNShAfyX18eLKwskN//hU4sgQQI6CUccm6+f
         TsfzRo4xVP4sccuGyFMLau7maBU0c88Z8qp+kMWqO0pgqOrb1iqx1pItTsAiUzkDv5fF
         lSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691238409; x=1691843209;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2M8seZm4mcc6ofT1Ofdd3q1hIoUcJq7DIb3vYvEj/Gw=;
        b=l13sqqRPhKzgMYBANl8FJHEDlYSuKRG3tyg0gLZLJ5BrLfZG1m5w9+vlhz9V2wV4wp
         3ZgwD6uqrP6/UKN8t3NbAjL9QwgZFYXebR3dLBVwsN/RyFkZObBZXQDBozBoL3fIBI8O
         wFdMbDxFbZcMOtsG6Lt7IXrcMGy9wfDG2Kv6ZE0UAqHtFnwFNi8vASealqTiex6OVTvU
         7YdmeBBINbWGE6wNgM3cAmXXTeT1kXFRSYEefvz8q3o5rVZmgEPVmJEtbPIdgQrXOv48
         YD933PIsCKR/H+jLbIbngX7/9ZSyaxu5bQvMFIH4JpoT0pqHloWVdVTJdPC8lQPZRODN
         Wqlw==
X-Gm-Message-State: AOJu0YyEKMFbrr0td9nv7C57u1+n2o6MLkrUYvaPtWFPxV2Gf1Z+dzGd
        4kmar30BStfehVI65VYc7npdEQ==
X-Google-Smtp-Source: AGHT+IErYh4c9rU71bIqngSuTGmK5ggEWsMFqsMRbp1hFFu+LISN9wIGxpD2qKWuu6b4MrClJDjoJA==
X-Received: by 2002:a05:6512:32d1:b0:4fe:c53:1824 with SMTP id f17-20020a05651232d100b004fe0c531824mr3172849lfg.40.1691238409211;
        Sat, 05 Aug 2023 05:26:49 -0700 (PDT)
Received: from [192.168.1.101] (abym15.neoplus.adsl.tpnet.pl. [83.9.32.15])
        by smtp.gmail.com with ESMTPSA id b17-20020a056512025100b004fdfd4c1fcesm743376lfo.36.2023.08.05.05.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 05:26:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 05 Aug 2023 14:26:44 +0200
Subject: [PATCH RESEND] arm64: dts: qcom: msm8998: Add DPU1 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230805-topic-8998_dpu-v1-1-9d402dc1ecc0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAANAzmQC/x2N0QqEIBAAfyX2uQWzAr1fOSJMt1oIE604iP79l
 h5nYJgbCmWmAp/qhkwXF96jQFNX4FcXF0IOwqCVbpVRPR57Yo/GWjOGdGIzB9MG3ZGzHiSaXCG
 csot+lSye2yYyZZr5916+w/P8ASNpk9Z1AAAA
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691238407; l=8128;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fsktV3MvV+Bh5PoQGpZzxl/FKdbfIollspT0iIYrZUw=;
 b=tTErCaKIhSTZvbClSevYkDescwOCCngYLnEbB7QINQFSdMDnw52BSIPYItZAOTz/vLxJWZ9lK
 sFhoVjQNSJvBb3HxVgqMCeXBTkgW1JO1uXKEjKL89UfpYH78+Vg8KXn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add the required nodes to support the display hardware on msm8998.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
[konrad: update the commit msg and AGdR's email, rebase]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
resending as I hit ctrl-c..

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 283 +++++++++++++++++++++++++++++++++-
 1 file changed, 279 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index a41a34dbcc3c..e28c5bbc99e5 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -316,6 +316,25 @@ scm {
 		};
 	};
 
+	dsi_opp_table: opp-table-dsi {
+		compatible = "operating-points-v2";
+
+		opp-131250000 {
+			opp-hz = /bits/ 64 <131250000>;
+			required-opps = <&rpmpd_opp_low_svs>;
+		};
+
+		opp-210000000 {
+			opp-hz = /bits/ 64 <210000000>;
+			required-opps = <&rpmpd_opp_svs>;
+		};
+
+		opp-312500000 {
+			opp-hz = /bits/ 64 <312500000>;
+			required-opps = <&rpmpd_opp_nom>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -2727,15 +2746,271 @@ mmcc: clock-controller@c8c0000 {
 				      "dpvco";
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&gcc GCC_MMSS_GPLL0_CLK>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi0_phy 0>,
+				 <&mdss_dsi1_phy 1>,
+				 <&mdss_dsi1_phy 0>,
 				 <0>,
 				 <0>,
 				 <0>;
 		};
 
+		mdss: display-subsystem@c900000 {
+			compatible = "qcom,msm8998-mdss";
+			reg = <0x0c900000 0x1000>;
+			reg-names = "mdss";
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clocks = <&mmcc MDSS_AHB_CLK>,
+				 <&mmcc MDSS_AXI_CLK>,
+				 <&mmcc MDSS_MDP_CLK>;
+			clock-names = "iface",
+				      "bus",
+				      "core";
+
+			power-domains = <&mmcc MDSS_GDSC>;
+			iommus = <&mmss_smmu 0>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			status = "disabled";
+
+			mdss_mdp: display-controller@c901000 {
+				compatible = "qcom,msm8998-dpu";
+				reg = <0x0c901000 0x8f000>,
+				      <0x0c9a8e00 0xf0>,
+				      <0x0c9b0000 0x2008>,
+				      <0x0c9b8000 0x1040>;
+				reg-names = "mdp",
+					    "regdma",
+					    "vbif",
+					    "vbif_nrt";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MNOC_AHB_CLK>,
+					 <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				clock-names = "iface",
+					      "bus",
+					      "mnoc",
+					      "core",
+					      "vsync";
+
+				assigned-clocks = <&mmcc MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
+
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmpd MSM8998_VDDMX>;
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-171430000 {
+						opp-hz = /bits/ 64 <171430000>;
+						required-opps = <&rpmpd_opp_low_svs>;
+					};
+
+					opp-275000000 {
+						opp-hz = /bits/ 64 <275000000>;
+						required-opps = <&rpmpd_opp_svs>;
+					};
+
+					opp-330000000 {
+						opp-hz = /bits/ 64 <330000000>;
+						required-opps = <&rpmpd_opp_nom>;
+					};
+
+					opp-412500000 {
+						opp-hz = /bits/ 64 <412500000>;
+						required-opps = <&rpmpd_opp_turbo>;
+					};
+				};
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						dpu_intf2_out: endpoint {
+							remote-endpoint = <&mdss_dsi1_in>;
+						};
+					};
+				};
+			};
+
+			mdss_dsi0: dsi@c994000 {
+				compatible = "qcom,msm8998-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+				reg = <0x0c994000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				clocks = <&mmcc MDSS_BYTE0_CLK>,
+					 <&mmcc MDSS_BYTE0_INTF_CLK>,
+					 <&mmcc MDSS_PCLK0_CLK>,
+					 <&mmcc MDSS_ESC0_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+				assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
+						  <&mmcc PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>,
+							 <&mdss_dsi0_phy 1>;
+
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmpd MSM8998_VDDCX>;
+
+				phys = <&mdss_dsi0_phy>;
+				phy-names = "dsi";
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
+							remote-endpoint = <&dpu_intf1_out>;
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
+			};
+
+			mdss_dsi0_phy: phy@c994400 {
+				compatible = "qcom,dsi-phy-10nm-8998";
+				reg = <0x0c994400 0x200>,
+				      <0x0c994600 0x280>,
+				      <0x0c994a00 0x1e0>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface", "ref";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				status = "disabled";
+			};
+
+			mdss_dsi1: dsi@c996000 {
+				compatible = "qcom,msm8998-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+				reg = <0x0c996000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <5>;
+
+				clocks = <&mmcc MDSS_BYTE1_CLK>,
+					 <&mmcc MDSS_BYTE1_INTF_CLK>,
+					 <&mmcc MDSS_PCLK1_CLK>,
+					 <&mmcc MDSS_ESC1_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+				assigned-clocks = <&mmcc BYTE1_CLK_SRC>,
+						  <&mmcc PCLK1_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi1_phy 0>,
+							 <&mdss_dsi1_phy 1>;
+
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmpd MSM8998_VDDCX>;
+
+				phys = <&mdss_dsi1_phy>;
+				phy-names = "dsi";
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
+							remote-endpoint = <&dpu_intf2_out>;
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
+			mdss_dsi1_phy: phy@c996400 {
+				compatible = "qcom,dsi-phy-10nm-8998";
+				reg = <0x0c996400 0x200>,
+				      <0x0c996600 0x280>,
+				      <0x0c996a00 0x10e>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface",
+					      "ref";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+
 		mmss_smmu: iommu@cd00000 {
 			compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
 			reg = <0x0cd00000 0x40000>;

---
base-commit: bdffb18b5dd8071cd25685b966f380a30b1fadaa
change-id: 20230805-topic-8998_dpu-1fd83d24ea9c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

