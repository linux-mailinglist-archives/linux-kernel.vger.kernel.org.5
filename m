Return-Path: <linux-kernel+bounces-124720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04758891BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1E01C26ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FAA146A67;
	Fri, 29 Mar 2024 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da6CrC5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B51465AB;
	Fri, 29 Mar 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716008; cv=none; b=ok3yxt/rXamV1y0pKBjo1msUtQePLs/V8+GWTx7RM/eq8ctYBtLeViokxzmie1aprqaNAUHmvP78/vUo5GiW6gLt1k30DjaKY5oN6cv1v8tdSk6x6CuKYNGoRoNTRttJPxafgwPNPQdP23ZmqtNtT5UgLhaT+6ZiwJNNIbMCqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716008; c=relaxed/simple;
	bh=0Unq+1iE7ipc/KKZheYH+mrLHQ+V8/V5iM4qZIxwmTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ar1Y15oNXm2JTvmMRT8C3g6dUqlQDC4Cg4tz84R2TPfVObpN89sNeRWB5q/kB/0iZ9us8JZ69Xmbhysu1ybxr5LhNYJxKpXj86Zy+mLfGl3gy8WStx+CjlwiYgVtd4cmQ/xSxlUIKqaXmtfHKKcp7w6PPWsZ1TMHGaYnDecgqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da6CrC5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7F1C43394;
	Fri, 29 Mar 2024 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716008;
	bh=0Unq+1iE7ipc/KKZheYH+mrLHQ+V8/V5iM4qZIxwmTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=da6CrC5IhYcZH5873WJ7wgarKOm0Dq2E/V/8kROPyX3L9Jql0/naWY+iCO+0acDMP
	 xnabL3zA7YnbQOQlSbJta3EDDhZqB4ysfeuyQfuJ11UwqY7f0UwaLDlVHOXZawW4XG
	 E9mNY266Pa42xVBbvw2xe3nR2ljR3mxcDPEraF3ob9IIDcYIBUDJQ73X5jaiqUILOg
	 kS/K7+nguSrW8plOEpaaBIJsnOkeP5KcAjIFeKqL7cvRnmMIqDao8Cl8Um1tayHqXw
	 cquV2wkwhmfeZf3B3zHw9gSzCiHtemRDMYrazA4eQOuXqlH150I4CeIt5C3vTi7mRO
	 as8kzzlO9Oa5Q==
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
Subject: [PATCH AUTOSEL 6.8 11/98] arm64: dts: qcom: sdm630: add USB QMP PHY support
Date: Fri, 29 Mar 2024 08:36:42 -0400
Message-ID: <20240329123919.3087149-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 513fe5e76b688..28489fb58b200 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1286,7 +1286,6 @@ usb3: usb@a8f8800 {
 			interrupt-names = "hs_phy_irq", "ss_phy_irq";
 
 			power-domains = <&gcc USB_30_GDSC>;
-			qcom,select-utmi-as-pipe-clk;
 
 			resets = <&gcc GCC_USB_30_BCR>;
 
@@ -1297,17 +1296,38 @@ usb3_dwc3: usb@a800000 {
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


