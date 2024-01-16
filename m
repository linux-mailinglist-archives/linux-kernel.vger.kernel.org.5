Return-Path: <linux-kernel+bounces-27828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6882F676
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB9EB23D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324EB35F1F;
	Tue, 16 Jan 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxErz6Mg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5A35F0A;
	Tue, 16 Jan 2024 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434297; cv=none; b=CXw2nE4qzbGWXKm5DzCtLDziadc50CK1kPNC8zV54W0fFBBNQCpdRUTz7WIPumGPNJMKhhHOfQuxMZOQx71IWJesYZokxpwJDYCJ9MHB02z+G0FfVXZa5oCeTfY6u4kCx1ikohDg2nOUnczIN7vXAXIKNZiSFNFg7RQS7BwVaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434297; c=relaxed/simple;
	bh=HMuzq7/MKC+tbVwsSt+kwR1+VTgjXhjplotGw9FWldQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=OClPBkI1EQ44tWkAm1mKI0gfV0ZBMWGdhD/3eJYigwqF2jIAjpLk1btC4wtyJ2k4iuIhejtp0IEk2xSOwPdHN22q35RMGZLeEZ1ePdnlpLvx2BEficm49C8RuAxjwByJs7hbCKy1ooQPSCTJHyJx5ddD+0IHBaQQJbUSPL9gOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxErz6Mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C976C433C7;
	Tue, 16 Jan 2024 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434297;
	bh=HMuzq7/MKC+tbVwsSt+kwR1+VTgjXhjplotGw9FWldQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxErz6Mg4MPL2brBqSksayfodw0h+0w6QxOR2fxYFQDTgxLyVdzS6PuddmyImAlpv
	 0LM5c8xlEBcA8RARtkfn9GO7MByIgdteBLPJKijz7P6vlVq9W/ZVcm51g4tKqsD1me
	 9ACDSNhqIauhRfLZpUs4evZHL/Bz4PCRfskVEmgp17+XKyHGV/bZSnHGgqKZcsTP6C
	 /NprX9iMxpzmCNVCMDXB1BTiJ8Foxs65Vz4En+HzXn7vmDBeqdu3EFFuUhheriYn8B
	 pquh8Hd7fU1aAe7wyT7rCKLiFc86kwu7hmfGuqBgaYORnNr9shrQzEkeN6iSvLt8A/
	 3XA54Qkay5AWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 057/108] ARM: dts: imx: Use flash@0,0 pattern
Date: Tue, 16 Jan 2024 14:39:23 -0500
Message-ID: <20240116194225.250921-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 1e1d7cc478fb16816de09740e3c323c0c188d58f ]

Per mtd-physmap.yaml, 'nor@0,0' is not a valid node pattern.

Change it to 'flash@0,0' to fix the following dt-schema warning:

imx1-ads.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx1-ads.dts                  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts              | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx1-ads.dts b/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
index 5833fb6f15d8..2c817c4a4c68 100644
--- a/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
@@ -65,7 +65,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <4>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts b/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
index 1f11e9542a72..e66eef87a7a4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
@@ -45,7 +45,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
index 4b83e2918b55..c7e923584878 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
@@ -90,7 +90,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
index 7b2ea4cdae58..8d428c844666 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
@@ -314,7 +314,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
-- 
2.43.0


