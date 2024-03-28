Return-Path: <linux-kernel+bounces-115074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0FF888CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CBF1F29879
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC261C3A10;
	Mon, 25 Mar 2024 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj+FLEY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD72180A73;
	Sun, 24 Mar 2024 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324052; cv=none; b=tJb3IGVKixPb9zN1Mz8OCHZvC0glNlRHptDHeHULO55F/nN0Qwtc4smY8Krsbkkc5vo1XnpWrqXZv5N6voOxLRIC3F7ypB6U6S4fdf7b7g0A1+UDZIe3l5h5DIvQTOKgp/2jxizioON9H/GqoDl+KM4Lq+63LAr9ZA7p72k7OcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324052; c=relaxed/simple;
	bh=wvf3sIIuiuGAOXj+OmT4D5WiGqoZZJa8njw+E8Nec1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMhAMmsAkAyyfvZfzX6e+CtQY4O5FEou8YhYZRhJmMoYCtKePvFdOsdb7eON2ifXbOG8uKWEgdNszS+CmzccaRHpcPOgbL8NBvE3dJ+ZBjPwkerrkk9IBLmuV0d1rS7vMFiHkoT2wQgAmb6XDmsIAfhPEGJbT87ZlFqrSoZEBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vj+FLEY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114FDC433B2;
	Sun, 24 Mar 2024 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324051;
	bh=wvf3sIIuiuGAOXj+OmT4D5WiGqoZZJa8njw+E8Nec1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vj+FLEY2Uyms/+46TinJac8HJRBfKptai2E5enSpqzsJWnC0F3V0euXoN4Dza7t2B
	 RvXGWqqEibgDn8wL+9Kce3SUjXEWnmGLOojHWxtLnvEAogN8tppynD+i5e029B8naZ
	 DYVOBkZzeU4Z8V3iMpJJb0K4CBlu4I1Amo0ihTIBHLPFI+jrByc2WT93TsrsGKBGFK
	 2aL8AzJ4PpWS2r3mY/9huey7daA+VhcwIStahkZhFBFmnMoeYc4fYJ0safx3kV91z5
	 T3LfS2sNS9sfbjSfmprOBkihojppvU8haSq7TAn4aV+6/YUfYm/W4bZuWsjQKUg7I6
	 U0deVj/PdBpDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 052/183] arm64: dts: qcom: msm8996: Pad addresses
Date: Sun, 24 Mar 2024 19:44:25 -0400
Message-ID: <20240324234638.1355609-53-sashal@kernel.org>
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

[ Upstream commit 86f6d6225e5e546ffeaae6db597f4aabe50d26c1 ]

Pad all addresses in msm8996.dtsi to 8 digits, in order to make it
easier to ensure ordering when adding new nodes.

Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Stable-dep-of: 68c4c20848d7 ("arm64: dts: qcom: msm8996: Define UFS UniPro clock limits")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 144 +++++++++++++-------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index bcadbdf2690e3..8bfb897b0e81b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -584,7 +584,7 @@ soc: soc {
 
 		rpm_msg_ram: memory@68000 {
 			compatible = "qcom,rpm-msg-ram";
-			reg = <0x68000 0x6000>;
+			reg = <0x00068000 0x6000>;
 		};
 
 		rng: rng@83000 {
@@ -596,28 +596,28 @@ rng: rng@83000 {
 
 		tcsr_mutex_regs: syscon@740000 {
 			compatible = "syscon";
-			reg = <0x740000 0x20000>;
+			reg = <0x00740000 0x20000>;
 		};
 
 		tsens0: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8996-tsens";
-			reg = <0x4a9000 0x1000>, /* TM */
-			      <0x4a8000 0x1000>; /* SROT */
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
 			#thermal-sensor-cells = <1>;
 		};
 
 		tsens1: thermal-sensor@4ad000 {
 			compatible = "qcom,msm8996-tsens";
-			reg = <0x4ad000 0x1000>, /* TM */
-			      <0x4ac000 0x1000>; /* SROT */
+			reg = <0x004ad000 0x1000>, /* TM */
+			      <0x004ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
 
 		tcsr: syscon@7a0000 {
 			compatible = "qcom,tcsr-msm8996", "syscon";
-			reg = <0x7a0000 0x18000>;
+			reg = <0x007a0000 0x18000>;
 		};
 
 		intc: interrupt-controller@9bc0000 {
@@ -633,7 +633,7 @@ intc: interrupt-controller@9bc0000 {
 
 		apcs_glb: mailbox@9820000 {
 			compatible = "qcom,msm8996-apcs-hmss-global";
-			reg = <0x9820000 0x1000>;
+			reg = <0x09820000 0x1000>;
 
 			#mbox-cells = <1>;
 		};
@@ -643,7 +643,7 @@ gcc: clock-controller@300000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			reg = <0x300000 0x90000>;
+			reg = <0x00300000 0x90000>;
 		};
 
 		stm@3002000 {
@@ -1124,7 +1124,7 @@ apss_merge_funnel_out: endpoint {
 
 		kryocc: clock-controller@6400000 {
 			compatible = "qcom,apcc-msm8996";
-			reg = <0x6400000 0x90000>;
+			reg = <0x06400000 0x90000>;
 			#clock-cells = <1>;
 		};
 
@@ -1170,7 +1170,7 @@ blsp2_i2c0: i2c@75b5000 {
 
 		blsp2_uart1: serial@75b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-			reg = <0x75b0000 0x1000>;
+			reg = <0x075b0000 0x1000>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
 				 <&gcc GCC_BLSP2_AHB_CLK>;
@@ -1236,7 +1236,7 @@ blsp2_spi5: spi@75ba000{
 		sdhc2: sdhci@74a4900 {
 			 status = "disabled";
 			 compatible = "qcom,sdhci-msm-v4";
-			 reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
+			 reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
 			 reg-names = "hc_mem", "core_mem";
 
 			 interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>,
@@ -1321,11 +1321,11 @@ frame@98c0000 {
 
 		spmi_bus: qcom,spmi@400f000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x400f000 0x1000>,
-			      <0x4400000 0x800000>,
-			      <0x4c00000 0x800000>,
-			      <0x5800000 0x200000>,
-			      <0x400a000 0x002100>;
+			reg = <0x0400f000 0x1000>,
+			      <0x04400000 0x800000>,
+			      <0x04c00000 0x800000>,
+			      <0x05800000 0x200000>,
+			      <0x0400a000 0x002100>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
@@ -1339,7 +1339,7 @@ spmi_bus: qcom,spmi@400f000 {
 
 		ufsphy: phy@627000 {
 			compatible = "qcom,msm8996-ufs-phy-qmp-14nm";
-			reg = <0x627000 0xda8>;
+			reg = <0x00627000 0xda8>;
 			reg-names = "phy_mem";
 			#phy-cells = <0>;
 
@@ -1352,7 +1352,7 @@ ufsphy: phy@627000 {
 
 		ufshc: ufshc@624000 {
 			compatible = "qcom,ufshc";
-			reg = <0x624000 0x2500>;
+			reg = <0x00624000 0x2500>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 
 			phys = <&ufsphy>;
@@ -1411,7 +1411,7 @@ mmcc: clock-controller@8c0000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			reg = <0x8c0000 0x40000>;
+			reg = <0x008c0000 0x40000>;
 			assigned-clocks = <&mmcc MMPLL9_PLL>,
 					  <&mmcc MMPLL1_PLL>,
 					  <&mmcc MMPLL3_PLL>,
@@ -1426,7 +1426,7 @@ mmcc: clock-controller@8c0000 {
 
 		qfprom@74000 {
 			compatible = "qcom,qfprom";
-			reg = <0x74000 0x8ff>;
+			reg = <0x00074000 0x8ff>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
@@ -1448,7 +1448,7 @@ gpu_speed_bin: gpu_speed_bin@133 {
 
 		pcie_phy: phy@34000 {
 			compatible = "qcom,msm8996-qmp-pcie-phy";
-			reg = <0x34000 0x488>;
+			reg = <0x00034000 0x488>;
 			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1466,9 +1466,9 @@ pcie_phy: phy@34000 {
 			status = "disabled";
 
 			pciephy_0: lane@35000 {
-				reg = <0x035000 0x130>,
-					<0x035200 0x200>,
-					<0x035400 0x1dc>;
+				reg = <0x00035000 0x130>,
+				      <0x00035200 0x200>,
+				      <0x00035400 0x1dc>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_0_pipe_clk_src";
@@ -1479,9 +1479,9 @@ pciephy_0: lane@35000 {
 			};
 
 			pciephy_1: lane@36000 {
-				reg = <0x036000 0x130>,
-					<0x036200 0x200>,
-					<0x036400 0x1dc>;
+				reg = <0x00036000 0x130>,
+				      <0x00036200 0x200>,
+				      <0x00036400 0x1dc>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_1_pipe_clk_src";
@@ -1492,9 +1492,9 @@ pciephy_1: lane@36000 {
 			};
 
 			pciephy_2: lane@37000 {
-				reg = <0x037000 0x130>,
-					<0x037200 0x200>,
-					<0x037400 0x1dc>;
+				reg = <0x00037000 0x130>,
+				      <0x00037200 0x200>,
+				      <0x00037400 0x1dc>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_2_pipe_clk_src";
@@ -1507,7 +1507,7 @@ pciephy_2: lane@37000 {
 
 		usb3phy: phy@7410000 {
 			compatible = "qcom,msm8996-qmp-usb3-phy";
-			reg = <0x7410000 0x1c4>;
+			reg = <0x07410000 0x1c4>;
 			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1524,9 +1524,9 @@ usb3phy: phy@7410000 {
 			status = "disabled";
 
 			ssusb_phy_0: lane@7410200 {
-				reg = <0x7410200 0x200>,
-					<0x7410400 0x130>,
-					<0x7410600 0x1a8>;
+				reg = <0x07410200 0x200>,
+				      <0x07410400 0x130>,
+				      <0x07410600 0x1a8>;
 				#phy-cells = <0>;
 
 				clock-output-names = "usb3_phy_pipe_clk_src";
@@ -1537,7 +1537,7 @@ ssusb_phy_0: lane@7410200 {
 
 		hsusb_phy1: phy@7411000 {
 			compatible = "qcom,msm8996-qusb2-phy";
-			reg = <0x7411000 0x180>;
+			reg = <0x07411000 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
@@ -1551,7 +1551,7 @@ hsusb_phy1: phy@7411000 {
 
 		hsusb_phy2: phy@7412000 {
 			compatible = "qcom,msm8996-qusb2-phy";
-			reg = <0x7412000 0x180>;
+			reg = <0x07412000 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
@@ -1565,7 +1565,7 @@ hsusb_phy2: phy@7412000 {
 
 		usb2: usb@76f8800 {
 			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
-			reg = <0x76f8800 0x400>;
+			reg = <0x076f8800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1585,7 +1585,7 @@ usb2: usb@76f8800 {
 
 			dwc3@7600000 {
 				compatible = "snps,dwc3";
-				reg = <0x7600000 0xcc00>;
+				reg = <0x07600000 0xcc00>;
 				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&hsusb_phy2>;
 				phy-names = "usb2-phy";
@@ -1596,7 +1596,7 @@ dwc3@7600000 {
 
 		usb3: usb@6af8800 {
 			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
-			reg = <0x6af8800 0x400>;
+			reg = <0x06af8800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1617,7 +1617,7 @@ usb3: usb@6af8800 {
 
 			dwc3@6a00000 {
 				compatible = "snps,dwc3";
-				reg = <0x6a00000 0xcc00>;
+				reg = <0x06a00000 0xcc00>;
 				interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
 				phy-names = "usb2-phy", "usb3-phy";
@@ -1628,7 +1628,7 @@ dwc3@6a00000 {
 
 		vfe_smmu: iommu@da0000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0xda0000 0x10000>;
+			reg = <0x00da0000 0x10000>;
 
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
@@ -1644,20 +1644,20 @@ vfe_smmu: iommu@da0000 {
 
 		camss: camss@a00000 {
 			compatible = "qcom,msm8996-camss";
-			reg = <0xa34000 0x1000>,
-				<0xa00030 0x4>,
-				<0xa35000 0x1000>,
-				<0xa00038 0x4>,
-				<0xa36000 0x1000>,
-				<0xa00040 0x4>,
-				<0xa30000 0x100>,
-				<0xa30400 0x100>,
-				<0xa30800 0x100>,
-				<0xa30c00 0x100>,
-				<0xa31000 0x500>,
-				<0xa00020 0x10>,
-				<0xa10000 0x1000>,
-				<0xa14000 0x1000>;
+			reg = <0x00a34000 0x1000>,
+			      <0x00a00030 0x4>,
+			      <0x00a35000 0x1000>,
+			      <0x00a00038 0x4>,
+			      <0x00a36000 0x1000>,
+			      <0x00a00040 0x4>,
+			      <0x00a30000 0x100>,
+			      <0x00a30400 0x100>,
+			      <0x00a30800 0x100>,
+			      <0x00a30c00 0x100>,
+			      <0x00a31000 0x500>,
+			      <0x00a00020 0x10>,
+			      <0x00a10000 0x1000>,
+			      <0x00a14000 0x1000>;
 			reg-names = "csiphy0",
 				"csiphy0_clk_mux",
 				"csiphy1",
@@ -1778,7 +1778,7 @@ ports {
 
 		adreno_smmu: iommu@b40000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0xb40000 0x10000>;
+			reg = <0x00b40000 0x10000>;
 
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
@@ -1795,7 +1795,7 @@ adreno_smmu: iommu@b40000 {
 
 		mdp_smmu: iommu@d00000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0xd00000 0x10000>;
+			reg = <0x00d00000 0x10000>;
 
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
@@ -1811,7 +1811,7 @@ mdp_smmu: iommu@d00000 {
 
 		lpass_q6_smmu: iommu@1600000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0x1600000 0x20000>;
+			reg = <0x01600000 0x20000>;
 			#iommu-cells = <1>;
 			power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
 
@@ -1998,7 +1998,7 @@ slimbam:dma@9184000
 		{
 			compatible = "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
-			reg = <0x9184000 0x32000>;
+			reg = <0x09184000 0x32000>;
 			num-channels  = <31>;
 			interrupts = <0 164 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
@@ -2008,7 +2008,7 @@ slimbam:dma@9184000
 
 		slim_msm: slim@91c0000 {
 			compatible = "qcom,slim-ngd-v1.5.0";
-			reg = <0x91c0000 0x2C000>;
+			reg = <0x091c0000 0x2C000>;
 			reg-names = "ctrl";
 			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
 			dmas =	<&slimbam 3>, <&slimbam 4>,
@@ -2052,7 +2052,7 @@ gpu@b00000 {
 			compatible = "qcom,adreno-530.2", "qcom,adreno";
 			#stream-id-cells = <16>;
 
-			reg = <0xb00000 0x3f000>;
+			reg = <0x00b00000 0x3f000>;
 			reg-names = "kgsl_3d0_reg_memory";
 
 			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
@@ -2123,9 +2123,9 @@ zap-shader {
 		mdss: mdss@900000 {
 			compatible = "qcom,mdss";
 
-			reg = <0x900000 0x1000>,
-			      <0x9b0000 0x1040>,
-			      <0x9b8000 0x1040>;
+			reg = <0x00900000 0x1000>,
+			      <0x009b0000 0x1040>,
+			      <0x009b8000 0x1040>;
 			reg-names = "mdss_phys",
 				    "vbif_phys",
 				    "vbif_nrt_phys";
@@ -2145,7 +2145,7 @@ mdss: mdss@900000 {
 
 			mdp: mdp@901000 {
 				compatible = "qcom,mdp5";
-				reg = <0x901000 0x90000>;
+				reg = <0x00901000 0x90000>;
 				reg-names = "mdp_phys";
 
 				interrupt-parent = <&mdss>;
@@ -2221,12 +2221,12 @@ hdmi_in: endpoint {
 			hdmi_phy: hdmi-phy@9a0600 {
 				#phy-cells = <0>;
 				compatible = "qcom,hdmi-phy-8996";
-				reg = <0x9a0600 0x1c4>,
-				      <0x9a0a00 0x124>,
-				      <0x9a0c00 0x124>,
-				      <0x9a0e00 0x124>,
-				      <0x9a1000 0x124>,
-				      <0x9a1200 0x0c8>;
+				reg = <0x009a0600 0x1c4>,
+				      <0x009a0a00 0x124>,
+				      <0x009a0c00 0x124>,
+				      <0x009a0e00 0x124>,
+				      <0x009a1000 0x124>,
+				      <0x009a1200 0x0c8>;
 				reg-names = "hdmi_pll",
 					    "hdmi_tx_l0",
 					    "hdmi_tx_l1",
-- 
2.43.0


