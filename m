Return-Path: <linux-kernel+bounces-116261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4C889DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB5728DE85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08840184312;
	Mon, 25 Mar 2024 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jePNKDMC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D4180A65;
	Sun, 24 Mar 2024 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324051; cv=none; b=b2GY8MY96WIyffaC7ZYfOkf6gP9h4hd+j1HvM0O3eaQdzIApWPC8NEfq+1v0K8RP7s5F9WyQhGI0mA4BlgP+9r5/kWxCqRxm3YcTZJedLSRUtNCVerwXFWrHxW5wQ3rzWcM7s69uigXpwM3TEECvNdtQK6V5y89NwuMYldLIKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324051; c=relaxed/simple;
	bh=KRSv81TwsExJ0F2eGrzklWLug+2TnfZgZsSX2hbjJL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlioxP781NOd2BAwpA3TqPOPoURytLRaVI6frWQzm9eSG8Q7C2ulzv0+ZYPr6oXGvUe5+tAw94SxBJ7Py9Weg0vkV/lDZ1uJpbn1malJVP/dWO6/EAt+TZCS23RJXSy82Lgkw+ZCBqkPa3Nd0Do1mLRhALCybqkCjHILZE9G0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jePNKDMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2930AC43399;
	Sun, 24 Mar 2024 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324050;
	bh=KRSv81TwsExJ0F2eGrzklWLug+2TnfZgZsSX2hbjJL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jePNKDMCD76bPHDbiVVgk7bnuaZvxsne5H6IR4Gsztmb69BKjjIKpYcSb7Yp/kGIA
	 Fs1Uxz4RWopD5L5U5QTCDvNqekN5SLQt5OOFRiCxgb7NKFwGx5xOc0SRAtci1leJXe
	 bcC6pBret2fb2acvZijWT75jUo/4Hc5cxw3LlwVZDKZZj+woBDTDgt5PixjxkjMfVr
	 ohtQN6lxT0/yhtaKQIq90h4zHpMqR2AIDOt3DpHD/XPI5REmJTlI2XL/+CNIaaOLCW
	 l1Px4hiPRZMma5ug9OD4zMOPsYFVUzj7l+vZ/OioGIO5B4U5kclx4nzf/rAdZfXF1I
	 +CX/xy0SCkKpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 051/183] arm64: dts: qcom: msm8996: Move regulator consumers to db820c
Date: Sun, 24 Mar 2024 19:44:24 -0400
Message-ID: <20240324234638.1355609-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 80884431430995254257848d1a05266a2b791c58 ]

Supplies for the various components in the SoC depends on board layout,
so move the supply definitions to db820c.dtsi instead of carrying them
in the platform dtsi.

Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Stable-dep-of: 68c4c20848d7 ("arm64: dts: qcom: msm8996: Define UFS UniPro clock limits")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 44 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 44 --------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 44ec3eb1c8e85..21e029afb27bb 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -142,6 +142,10 @@ &blsp2_spi5 {
 	status = "okay";
 };
 
+&camss {
+	vdda-supply = <&pm8994_l2>;
+};
+
 &sdhc2 {
 	/* External SD card */
 	pinctrl-names = "default", "sleep";
@@ -155,10 +159,28 @@ &sdhc2 {
 
 &ufsphy {
 	status = "okay";
+
+	vdda-phy-supply = <&pm8994_l28>;
+	vdda-pll-supply = <&pm8994_l12>;
+
+	vdda-phy-max-microamp = <18380>;
+	vdda-pll-max-microamp = <9440>;
+
+	vddp-ref-clk-supply = <&pm8994_l25>;
+	vddp-ref-clk-max-microamp = <100>;
+	vddp-ref-clk-always-on;
 };
 
 &ufshc {
 	status = "okay";
+
+	vcc-supply = <&pm8994_l20>;
+	vccq-supply = <&pm8994_l25>;
+	vccq2-supply = <&pm8994_s4>;
+
+	vcc-max-microamp = <600000>;
+	vccq-max-microamp = <450000>;
+	vccq2-max-microamp = <450000>;
 };
 
 &msmgpio {
@@ -369,18 +391,31 @@ &pmi8994_gpios {
 
 &pcie_phy {
 	status = "okay";
+
+	vdda-phy-supply = <&pm8994_l28>;
+	vdda-pll-supply = <&pm8994_l12>;
 };
 
 &usb3phy {
 	status = "okay";
+
+	vdda-phy-supply = <&pm8994_l28>;
+	vdda-pll-supply = <&pm8994_l12>;
+
 };
 
 &hsusb_phy1 {
 	status = "okay";
+
+	vdda-pll-supply = <&pm8994_l12>;
+	vdda-phy-dpdm-supply = <&pm8994_l24>;
 };
 
 &hsusb_phy2 {
 	status = "okay";
+
+	vdda-pll-supply = <&pm8994_l12>;
+	vdda-phy-dpdm-supply = <&pm8994_l24>;
 };
 
 &usb3 {
@@ -408,22 +443,31 @@ &pcie0 {
 	status = "okay";
 	perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
 	vddpe-3v3-supply = <&wlan_en>;
+	vdda-supply = <&pm8994_l28>;
 };
 
 &pcie1 {
 	status = "okay";
 	perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
+	vdda-supply = <&pm8994_l28>;
 };
 
 &pcie2 {
 	status = "okay";
 	perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
+	vdda-supply = <&pm8994_l28>;
 };
 
 &wcd9335 {
 	clock-names = "mclk", "slimbus";
 	clocks = <&div1_mclk>,
 		 <&rpmcc RPM_SMD_BB_CLK1>;
+
+	vdd-buck-supply = <&pm8994_s4>;
+	vdd-buck-sido-supply = <&pm8994_s4>;
+	vdd-tx-supply = <&pm8994_s4>;
+	vdd-rx-supply = <&pm8994_s4>;
+	vdd-io-supply = <&pm8994_s4>;
 };
 
 &mdss {
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index bbdb0fcd818e9..bcadbdf2690e3 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1343,16 +1343,6 @@ ufsphy: phy@627000 {
 			reg-names = "phy_mem";
 			#phy-cells = <0>;
 
-			vdda-phy-supply = <&pm8994_l28>;
-			vdda-pll-supply = <&pm8994_l12>;
-
-			vdda-phy-max-microamp = <18380>;
-			vdda-pll-max-microamp = <9440>;
-
-			vddp-ref-clk-supply = <&pm8994_l25>;
-			vddp-ref-clk-max-microamp = <100>;
-			vddp-ref-clk-always-on;
-
 			clock-names = "ref_clk_src", "ref_clk";
 			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
 				 <&gcc GCC_UFS_CLKREF_CLK>;
@@ -1368,14 +1358,6 @@ ufshc: ufshc@624000 {
 			phys = <&ufsphy>;
 			phy-names = "ufsphy";
 
-			vcc-supply = <&pm8994_l20>;
-			vccq-supply = <&pm8994_l25>;
-			vccq2-supply = <&pm8994_s4>;
-
-			vcc-max-microamp = <600000>;
-			vccq-max-microamp = <450000>;
-			vccq2-max-microamp = <450000>;
-
 			power-domains = <&gcc UFS_GDSC>;
 
 			clock-names =
@@ -1477,9 +1459,6 @@ pcie_phy: phy@34000 {
 				<&gcc GCC_PCIE_CLKREF_CLK>;
 			clock-names = "aux", "cfg_ahb", "ref";
 
-			vdda-phy-supply = <&pm8994_l28>;
-			vdda-pll-supply = <&pm8994_l12>;
-
 			resets = <&gcc GCC_PCIE_PHY_BCR>,
 				<&gcc GCC_PCIE_PHY_COM_BCR>,
 				<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
@@ -1539,9 +1518,6 @@ usb3phy: phy@7410000 {
 				<&gcc GCC_USB3_CLKREF_CLK>;
 			clock-names = "aux", "cfg_ahb", "ref";
 
-			vdda-phy-supply = <&pm8994_l28>;
-			vdda-pll-supply = <&pm8994_l12>;
-
 			resets = <&gcc GCC_USB3_PHY_BCR>,
 				<&gcc GCC_USB3PHY_PHY_BCR>;
 			reset-names = "phy", "common";
@@ -1568,9 +1544,6 @@ hsusb_phy1: phy@7411000 {
 				<&gcc GCC_RX1_USB2_CLKREF_CLK>;
 			clock-names = "cfg_ahb", "ref";
 
-			vdda-pll-supply = <&pm8994_l12>;
-			vdda-phy-dpdm-supply = <&pm8994_l24>;
-
 			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
 			nvmem-cells = <&qusb2p_hstx_trim>;
 			status = "disabled";
@@ -1585,9 +1558,6 @@ hsusb_phy2: phy@7412000 {
 				<&gcc GCC_RX2_USB2_CLKREF_CLK>;
 			clock-names = "cfg_ahb", "ref";
 
-			vdda-pll-supply = <&pm8994_l12>;
-			vdda-phy-dpdm-supply = <&pm8994_l24>;
-
 			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
 			nvmem-cells = <&qusb2s_hstx_trim>;
 			status = "disabled";
@@ -1795,7 +1765,6 @@ camss: camss@a00000 {
 				"vfe1_stream",
 				"vfe_ahb",
 				"vfe_axi";
-			vdda-supply = <&pm8994_l2>;
 			iommus = <&vfe_smmu 0>,
 				 <&vfe_smmu 1>,
 				 <&vfe_smmu 2>,
@@ -1907,9 +1876,6 @@ pcie0: pcie@600000 {
 				pinctrl-0 = <&pcie0_clkreq_default &pcie0_perst_default &pcie0_wake_default>;
 				pinctrl-1 = <&pcie0_clkreq_sleep &pcie0_perst_default &pcie0_wake_sleep>;
 
-
-				vdda-supply = <&pm8994_l28>;
-
 				linux,pci-domain = <0>;
 
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
@@ -1962,8 +1928,6 @@ pcie1: pcie@608000 {
 				pinctrl-0 = <&pcie1_clkreq_default &pcie1_perst_default &pcie1_wake_default>;
 				pinctrl-1 = <&pcie1_clkreq_sleep &pcie1_perst_default &pcie1_wake_sleep>;
 
-
-				vdda-supply = <&pm8994_l28>;
 				linux,pci-domain = <1>;
 
 				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
@@ -2015,8 +1979,6 @@ pcie2: pcie@610000 {
 				pinctrl-0 = <&pcie2_clkreq_default &pcie2_perst_default &pcie2_wake_default>;
 				pinctrl-1 = <&pcie2_clkreq_sleep &pcie2_perst_default &pcie2_wake_sleep >;
 
-				vdda-supply = <&pm8994_l28>;
-
 				linux,pci-domain = <2>;
 				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>,
 					<&gcc GCC_PCIE_2_AUX_CLK>,
@@ -2081,12 +2043,6 @@ wcd9335: codec@1{
 
 					slim-ifc-dev  = <&tasha_ifd>;
 
-					vdd-buck-supply = <&pm8994_s4>;
-					vdd-buck-sido-supply = <&pm8994_s4>;
-					vdd-tx-supply = <&pm8994_s4>;
-					vdd-rx-supply = <&pm8994_s4>;
-					vdd-io-supply = <&pm8994_s4>;
-
 					#sound-dai-cells = <1>;
 				};
 			};
-- 
2.43.0


