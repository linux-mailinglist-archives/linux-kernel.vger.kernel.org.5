Return-Path: <linux-kernel+bounces-124888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D72891D79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599AD1F25B89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC421EB98;
	Fri, 29 Mar 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxfXy1++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302721EB81;
	Fri, 29 Mar 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716372; cv=none; b=HTOfn8iHzITUBgti/OedLaMdFDAj7tFRu8WfCky4k64yu3EzzcbEbg6438OFMv3HiP+9BpKXSXr8PJc6jSm5PcOd+nabSUia15i1RplldrUgIU9tHRlNBvlXXeTz9G9SrofF5p7aUcxvIwW0uAlg7VgkgPUyR2jWWIoQgO51im8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716372; c=relaxed/simple;
	bh=A75RSHCw4CqssR5CcTQUp5pbGcsNVHagnw3nvde01W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqone/jBlNw6PAzIFLlm9ZDU2BUVOc97l1go5PM9Olwn55cyCsBkQBSQ65Jhqc7hN6A/0TrOwl9NWgsSNRL88t9mUsP1zz5E1nuYByGC9T220XH3PWalUYME4MmISuRNZPNFnT4u1hrg01hVZWoOK0CokhQV/pDFA0G0HH0qbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxfXy1++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A64C433F1;
	Fri, 29 Mar 2024 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716372;
	bh=A75RSHCw4CqssR5CcTQUp5pbGcsNVHagnw3nvde01W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxfXy1++5cWWoFbhsIuiz3KEV2d9S2SWyoEq8p2DAFUi8riu7DbofXk7/TTnNj5Cv
	 WGywUGkch/aVDz32qFDZ5MYUKu2epWFckiRsVl1XlobmOP7Ycs8lARpc7bEpyFGlqH
	 Gi2E8i6D3WWWyWSf074cd1OGtXN/SpyG/5aAQDi4VVxfa+LqEXlPMcPMdUCmWRQXMe
	 t6TUfDsERFsvi2wkNDNLWdcKckdi8TvH9Exh7kU1+hCyzlfiGeaY0+vu8IkjKk84Lj
	 scdTZtB5YpLeJb/on6DUjoWprz5kky7OLrRNIalP9nwU8LSMANvuraxx0wQ5usrpeP
	 yitRnGynJZuHg==
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
Subject: [PATCH AUTOSEL 6.1 04/52] arm64: dts: qcom: sdm630: add USB QMP PHY support
Date: Fri, 29 Mar 2024 08:44:58 -0400
Message-ID: <20240329124605.3091273-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 28050bc5f0813..f824036871cc1 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -452,10 +452,16 @@ &usb2_dwc3 {
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
index 09c07800793a0..dd1d7e738c8da 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -650,10 +650,16 @@ cam_vdig_default: cam-vdig-default {
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
index 2430549265d3f..1d18c85c5c5b0 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1233,7 +1233,6 @@ usb3: usb@a8f8800 {
 			interrupt-names = "hs_phy_irq", "ss_phy_irq";
 
 			power-domains = <&gcc USB_30_GDSC>;
-			qcom,select-utmi-as-pipe-clk;
 
 			resets = <&gcc GCC_USB_30_BCR>;
 
@@ -1244,17 +1243,38 @@ usb3_dwc3: usb@a800000 {
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
index a3559f6e34a5e..308f9786a648e 100644
--- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
+++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
@@ -411,10 +411,16 @@ &tlmm {
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


