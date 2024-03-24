Return-Path: <linux-kernel+bounces-114783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 942CC88912E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477D81F2CE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A51B5303;
	Mon, 25 Mar 2024 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7Jd84PE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF65175C81;
	Sun, 24 Mar 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323389; cv=none; b=K199zAPDhWIrnJdoKbWH2gJe/HxccOdnHADSOKemQcahaKapCEGf95AmKdTskSzafSb3EsQIJm1lnTNNWNO3zrnUI57S+NW/CmM3Dh66Nyou92l3Gz4wvMkLniu2oWIx9V2sw/UdYzsWcFyY5Jj50t/+GxNsPFwmgZhE6Bx8sIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323389; c=relaxed/simple;
	bh=Fy2IfXuEmyWDKc8aoG+7VxfO1DUFtWc51famz17+kRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbUd1SsajblpbiUnFClMZW6tDwFuDbp77vdzTOp9K7byfrKH5WHjRynCh5p8949qu1pOdirj+Kexk3FTKUxrdqVTX4VD7tRqicg4aUzrywjcNmwkBQUfm1w1saMxMmtoXOi/+qk7bnjr/xJEVZ30XPWnM6ug2alCcr1+v+t0ZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7Jd84PE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B627C43399;
	Sun, 24 Mar 2024 23:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323388;
	bh=Fy2IfXuEmyWDKc8aoG+7VxfO1DUFtWc51famz17+kRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7Jd84PEVkgel6U9uOrq2NpJ8IPrV6C7xtb4gJ3JCfhSIY1gKjXvnMPop7VZzwrDb
	 aVZbz1BxQsw4E4ObJ6PHtNTYsCMQIgl5IHjsPEK67bnMWJMFNlLY3L5ECSjn/s/h6J
	 SLFUKeXqmOXBFU832/ysEQVEtYudu7HtZCWxM/s2n+CIYEd3yzsLebyLLw/SlqX45C
	 +axmeKa3jbx7D+oVRZLwakt+lIChZd5ecSvDXQzyOp5zz25Xy8SDbgry13ssnj/05e
	 Em25YA/pyVIM4hunbfjJfoKDx8IsvVtzLSTSTRQIkcoV2h5nTQMnhZH/MhfngRa27f
	 SU1MwFwWq1mjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 088/317] arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings
Date: Sun, 24 Mar 2024 19:31:08 -0400
Message-ID: <20240324233458.1352854-89-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit b7efebfeb2e8ad8187cdabba5f0212ba2e6c1069 ]

Change the USB QMP PHY to use newer style of QMP PHY bindings (single
resource region, no per-PHY subnodes).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230824211952.1397699-11-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: fc835b2311d4 ("arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 35 +++++++++++----------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index e1b744d76251d..b3b1258f2d6f8 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1982,7 +1982,7 @@ usb3_dwc3: dwc3@a800000 {
 				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-				phys = <&qusb2phy>, <&usb1_ssphy>;
+				phys = <&qusb2phy>, <&usb3phy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
@@ -1991,33 +1991,26 @@ usb3_dwc3: dwc3@a800000 {
 
 		usb3phy: phy@c010000 {
 			compatible = "qcom,msm8998-qmp-usb3-phy";
-			reg = <0x0c010000 0x18c>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+			reg = <0x0c010000 0x1000>;
 
 			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				 <&gcc GCC_USB3_CLKREF_CLK>,
 				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
-				 <&gcc GCC_USB3_CLKREF_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref";
+				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "cfg_ahb",
+				      "pipe";
+			clock-output-names = "usb3_phy_pipe_clk_src";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
 
 			resets = <&gcc GCC_USB3_PHY_BCR>,
 				 <&gcc GCC_USB3PHY_PHY_BCR>;
-			reset-names = "phy", "common";
+			reset-names = "phy",
+				      "phy_phy";
 
-			usb1_ssphy: phy@c010200 {
-				reg = <0xc010200 0x128>,
-				      <0xc010400 0x200>,
-				      <0xc010c00 0x20c>,
-				      <0xc010600 0x128>,
-				      <0xc010800 0x200>;
-				#phy-cells = <0>;
-				#clock-cells = <0>;
-				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb3_phy_pipe_clk_src";
-			};
+			status = "disabled";
 		};
 
 		qusb2phy: phy@c012000 {
-- 
2.43.0


