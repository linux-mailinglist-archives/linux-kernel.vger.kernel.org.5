Return-Path: <linux-kernel+bounces-114142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3068888AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE011C27656
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA819154430;
	Sun, 24 Mar 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmiUn02N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654D1E8909;
	Sun, 24 Mar 2024 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321462; cv=none; b=eTfdTvpghaMuDQBmCQMGoYmwq1QSywuAEFrrzrOo8lAATCtgum15wY5+KsU93uRyzd3daaVZN2ckP1KJeahTApQrXCLZcNsvkiZW1jZQM2JV4DmgG9At+avZFCKpF/yxtGS0umC6nHI7cwcZgoA1x8kSOoIUxV/teCWl9Nc7tgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321462; c=relaxed/simple;
	bh=mULZSRYw+k7Jgg7G8/Xsi+iCCabLU1/FQaJWvczIJrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtCZKKP1YoPZiZejWAMd5drecS/P7E222KffpHvEvZkthC5F00q/RiAVz6Ml2tqJpbd/U1AIV9S4kasCNcEM4BkEsz3t1huqjzFIlqx9a4ElruYIRh49VZc3hdYQt+SdyHzHzLT5QrysSm3OFQerD3HmoKJWFh23dlt66bsDna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmiUn02N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229EFC433F1;
	Sun, 24 Mar 2024 23:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321461;
	bh=mULZSRYw+k7Jgg7G8/Xsi+iCCabLU1/FQaJWvczIJrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmiUn02N4aj+6h7GdQwP6g6IyRRqWdOmECpoyQn3vsuGB6qur+pph4rF4o+mPQUq0
	 /R8C3ao0bsnfi6Pk0SnaGF6KtTVZrOmmAcTa7DfQpeClYw2kR7IAtdAa9ivg+yzd8u
	 Ams+HJYFve6lbNZAaw5m1CO2QQBqWxfHskCYHFrZOBPH/u4ZDswNmxWoKVUfITFenk
	 GX5XjHQdPuK/RBQnv+/vg4uICePkC9i8+G2b5RJxt+2Z6Yxml2ogygl09V29GHdpbx
	 2LJpV9sHUW/MIIbxAIs8VJElHu+KeX+M6f2WDAwZiJo0qDZc1UWyBJOJwcza8UAXav
	 QLwHrnY7nLDJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 186/638] arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings
Date: Sun, 24 Mar 2024 18:53:43 -0400
Message-ID: <20240324230116.1348576-187-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index f91c58c844afd..85fcbb24b4642 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2160,7 +2160,7 @@ usb3_dwc3: usb@a800000 {
 				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-				phys = <&qusb2phy>, <&usb1_ssphy>;
+				phys = <&qusb2phy>, <&usb3phy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
@@ -2169,33 +2169,26 @@ usb3_dwc3: usb@a800000 {
 
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


