Return-Path: <linux-kernel+bounces-114777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833B1889128
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238601F2CDF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70C1B6777;
	Mon, 25 Mar 2024 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G81sQT34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D72762A8;
	Sun, 24 Mar 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323387; cv=none; b=YFTtFUO13eaTYOCacLpzsIFsfPmhEOawNDqpoyfUPQvgqaPzgWpv8jOQnzRUBhqQV2soWqibGfF7PHrljRTzkCwqKYIo+yrgUeVoXbhEnFVoJfFBy9Uj7HyCoe5X7Jq759lyBjtvC5lnZrv1nL050tP2AQDDpvEHifqx8NeUY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323387; c=relaxed/simple;
	bh=pvqt9Rttb4MxC0PGUhHxuZJWsfcdR1kS0PvKT8WDe4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbysAYMkz3cbhw+7kD30MThDY4le0XRLHjxeZnvua9oY208vqlzc9y/EUwdhjdFGE3E8x36UZWLA5Ql1RYJr6dYi/aJuYfa6vQx5QAisbTPsDjGe30f0bwFFN+et0hh+crfmywbLCWx7YpfpkV6Oz8D0dKTGU2lgH9G3sjijXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G81sQT34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4CCC43141;
	Sun, 24 Mar 2024 23:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323386;
	bh=pvqt9Rttb4MxC0PGUhHxuZJWsfcdR1kS0PvKT8WDe4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G81sQT34SGKN15iu9rFG6ZdM9b0rak38vffH0msC5ythX5uUdDTCkoyoRyRr3y309
	 gvtxhKhZR0bWfIPT0kvtcC3WGBMsqBwO+otofZAqgw/gGngBivEi2pDyCjrsl29s1v
	 EMn9OqXw4A83TMfdgnHBD5xU78yXyRTZA21xSp2tiz2PN54+027gXTnONdpwAcFg1P
	 K8tT9yiXKppROcpUT0VR2Rt/KLWSDiv1THvJXoA8ldJrYVHTnWzyNZc6uy4dK5PeVO
	 bTz4M8mmpAtKnp7tcJbpaBTY3Qwig22TpZ0IKdz+0763pixC0eJg11LfRtDswhpYBh
	 j/s1lnKmgRn0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 086/317] arm64: dts: qcom: msm8996: Move '#clock-cells' to QMP PHY child node
Date: Sun, 24 Mar 2024 19:31:06 -0400
Message-ID: <20240324233458.1352854-87-sashal@kernel.org>
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

From: Shawn Guo <shawn.guo@linaro.org>

[ Upstream commit 82d61e19fccbf2fe7c018765b3799791916e7f31 ]

'#clock-cells' is a required property of QMP PHY child node, not itself.
Move it to fix the dtbs_check warnings.

There are only '#clock-cells' removal from SM8350 QMP PHY nodes, because
child nodes already have the property.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20210929034253.24570-4-shawn.guo@linaro.org
Stable-dep-of: fc835b2311d4 ("arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 3 ---
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 17eeff106bab7..0a4c5b847ddd5 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -91,7 +91,6 @@ soc: soc {
 		ssphy_1: phy@58000 {
 			compatible = "qcom,ipq8074-qmp-usb3-phy";
 			reg = <0x00058000 0x1c4>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -112,6 +111,7 @@ usb1_ssphy: phy@58200 {
 				      <0x00058800 0x1f8>,     /* PCS  */
 				      <0x00058600 0x044>;     /* PCS misc*/
 				#phy-cells = <0>;
+				#clock-cells = <1>;
 				clocks = <&gcc GCC_USB1_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "usb3phy_1_cc_pipe_clk";
@@ -134,7 +134,6 @@ qusb_phy_1: phy@59000 {
 		ssphy_0: phy@78000 {
 			compatible = "qcom,ipq8074-qmp-usb3-phy";
 			reg = <0x00078000 0x1c4>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -155,6 +154,7 @@ usb0_ssphy: phy@78200 {
 				      <0x00078800 0x1f8>,     /* PCS  */
 				      <0x00078600 0x044>;     /* PCS misc*/
 				#phy-cells = <0>;
+				#clock-cells = <1>;
 				clocks = <&gcc GCC_USB0_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "usb3phy_0_cc_pipe_clk";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index fd9ffe8448b04..e8fe02f484bf2 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -615,7 +615,6 @@ soc: soc {
 		pcie_phy: phy@34000 {
 			compatible = "qcom,msm8996-qmp-pcie-phy";
 			reg = <0x00034000 0x488>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -637,6 +636,7 @@ pciephy_0: phy@35000 {
 				      <0x00035400 0x1dc>;
 				#phy-cells = <0>;
 
+				#clock-cells = <1>;
 				clock-output-names = "pcie_0_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
 				clock-names = "pipe0";
@@ -2641,7 +2641,6 @@ usb3_dwc3: dwc3@6a00000 {
 		usb3phy: phy@7410000 {
 			compatible = "qcom,msm8996-qmp-usb3-phy";
 			reg = <0x07410000 0x1c4>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -2662,6 +2661,7 @@ ssusb_phy_0: phy@7410200 {
 				      <0x07410600 0x1a8>;
 				#phy-cells = <0>;
 
+				#clock-cells = <1>;
 				clock-output-names = "usb3_phy_pipe_clk_src";
 				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 7eadecba0175d..6dbed85fa53e5 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1993,7 +1993,6 @@ usb3phy: phy@c010000 {
 			compatible = "qcom,msm8998-qmp-usb3-phy";
 			reg = <0x0c010000 0x18c>;
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -2014,6 +2013,7 @@ usb1_ssphy: phy@c010200 {
 				      <0xc010600 0x128>,
 				      <0xc010800 0x200>;
 				#phy-cells = <0>;
+				#clock-cells = <1>;
 				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "usb3_phy_pipe_clk_src";
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index b0ba63b5869d2..8506dc841c869 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1119,7 +1119,6 @@ ufs_mem_phy: phy@1d87000 {
 			reg = <0 0x01d87000 0 0x1c4>;
 			#address-cells = <2>;
 			#size-cells = <2>;
-			#clock-cells = <1>;
 			ranges;
 			clock-names = "ref",
 				      "ref_aux";
@@ -1254,7 +1253,6 @@ usb_1_qmpphy: phy-wrapper@88e9000 {
 			      <0 0x088e8000 0 0x20>;
 			reg-names = "reg-base", "dp_com";
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -1287,7 +1285,6 @@ usb_2_qmpphy: phy-wrapper@88eb000 {
 			compatible = "qcom,sm8350-qmp-usb3-uni-phy";
 			reg = <0 0x088eb000 0 0x200>;
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
2.43.0


