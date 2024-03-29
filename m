Return-Path: <linux-kernel+bounces-124815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3212891D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B5CB27B91
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862AA19F501;
	Fri, 29 Mar 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXPyNA5H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52819DF6A;
	Fri, 29 Mar 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716222; cv=none; b=Kwro8UbJuCECeS6WsCGXrICcQwX+BHRZ4XQWhJxOIUEUoSilCHNBV3pwGCiVytwXtx/PHK5VcGYDNTbx/lJ1pycDCMmxX3afp6CdpHI3LSuG8w30QGTtQVFVy+d0GwesXWaBLa/0ZF39/QfvkYquhyQ3eHlYY5xiMuhjUrONsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716222; c=relaxed/simple;
	bh=1mbAl77OfueiFeqrpfN43bT508XneDfCZU/RszhZJyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+G0zCCjgZ6Zeauert16B8C2hNelHHEopRuD0HfIJjVfX2Q5OiN84LIueDvgqQpZdcoZbRoVc6LQ23E0Thzld3O/D9NiLjNUse3uytjoY4uJ7sPfrNCv9ehpt0AdMj3u4+JBQ507ltPW68qYQmshvc7Vy2OSbdTFfO34/F8YnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXPyNA5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C40C433A6;
	Fri, 29 Mar 2024 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716222;
	bh=1mbAl77OfueiFeqrpfN43bT508XneDfCZU/RszhZJyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXPyNA5HFTerKG/JFzMg/fkJDqH2GMypqFaV8IEX7T8cbPwQRn9nJfNTWJbVezL23
	 wTAvVpMgVf4FxGiXli/2Kzhh8Mu/zUOTwQirnAKNSRxNPNqRu8/JfgfhjB5ISkXLWa
	 ZKwTsEtuo4CXIHbXs/zLRW2dawyhKz50sDYWY3XVzMhvIvD+XmDJXkFUo5w/K0kiS0
	 HDid19AhFGQcuBAvt44Ohebv8iLdBMHZCZa4KMW/aiEs9Fh2zGgXc2W2jITgcVEKN2
	 T8+5pFOULe3Xvv/tS75UTmCBXymJbjhxCvprHgDsTPBJSr5FT9cp6CIPNhFu6pnPvh
	 NBm6b0kJwF/2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/75] arm64: dts: qcom: sdm630: add USB QMP PHY support
Date: Fri, 29 Mar 2024 08:41:47 -0400
Message-ID: <20240329124330.3089520-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit bb5009a24ec3f2f2ec1e2ed7b8a5dcde9a9e28d9 ]

Define USB3 QMP PHY presend on the SDM630 / SDM660 platforms. Enable it by
default in the USB3 host, but (for compatibility), force USB 2.0 mode
for all defined boards. The boards should opt-in to enable USB 3.0
support.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240116-sdm660-usb3-support-v1-3-2fbd683aea77@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/qcom/sda660-inforce-ifc6560.dts  |  6 ++++
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     |  6 ++++
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 36 ++++++++++++++-----
 .../boot/dts/qcom/sdm660-xiaomi-lavender.dts  |  6 ++++
 4 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 2ed39d402d3f6..21fae799c816a 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -454,10 +454,16 @@ &usb2_dwc3 {
 };
 
 &usb3 {
+	qcom,select-utmi-as-pipe-clk;
+
 	status = "okay";
 };
 
 &usb3_dwc3 {
+	maximum-speed = "high-speed";
+	phys = <&qusb2phy0>;
+	phy-names = "usb2-phy";
+
 	dr_mode = "peripheral";
 	extcon = <&extcon_usb>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 87d0293c728d8..f06a9f0cf97c1 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -658,10 +658,16 @@ cam_vdig_default: cam-vdig-default-state {
 };
 
 &usb3 {
+	qcom,select-utmi-as-pipe-clk;
+
 	status = "okay";
 };
 
 &usb3_dwc3 {
+	maximum-speed = "high-speed";
+	phys = <&qusb2phy0>;
+	phy-names = "usb2-phy";
+
 	dr_mode = "peripheral";
 	extcon = <&extcon_usb>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index ec6003212c4d5..9ea759742eccf 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1248,7 +1248,6 @@ usb3: usb@a8f8800 {
 			interrupt-names = "hs_phy_irq", "ss_phy_irq";
 
 			power-domains = <&gcc USB_30_GDSC>;
-			qcom,select-utmi-as-pipe-clk;
 
 			resets = <&gcc GCC_USB_30_BCR>;
 
@@ -1259,17 +1258,38 @@ usb3_dwc3: usb@a800000 {
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 
-				/*
-				 * SDM630 technically supports USB3 but I
-				 * haven't seen any devices making use of it.
-				 */
-				maximum-speed = "high-speed";
-				phys = <&qusb2phy0>;
-				phy-names = "usb2-phy";
+				phys = <&qusb2phy0>, <&usb3_qmpphy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				snps,hird-threshold = /bits/ 8 <0>;
 			};
 		};
 
+		usb3_qmpphy: phy@c010000 {
+			compatible = "qcom,sdm660-qmp-usb3-phy";
+			reg = <0x0c010000 0x1000>;
+
+			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				 <&gcc GCC_USB3_CLKREF_CLK>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "cfg_ahb",
+				      "pipe";
+			clock-output-names = "usb3_phy_pipe_clk_src";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "phy_phy";
+
+			qcom,tcsr-reg = <&tcsr_regs_1 0x6b244>;
+
+			status = "disabled";
+		};
+
 		qusb2phy0: phy@c012000 {
 			compatible = "qcom,sdm660-qusb2-phy";
 			reg = <0x0c012000 0x180>;
diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
index 3c47410ba94c0..7167f75bced3f 100644
--- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
+++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
@@ -413,10 +413,16 @@ &tlmm {
 };
 
 &usb3 {
+	qcom,select-utmi-as-pipe-clk;
+
 	status = "okay";
 };
 
 &usb3_dwc3 {
+	maximum-speed = "high-speed";
+	phys = <&qusb2phy0>;
+	phy-names = "usb2-phy";
+
 	dr_mode = "peripheral";
 	extcon = <&extcon_usb>;
 };
-- 
2.43.0


