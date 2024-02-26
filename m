Return-Path: <linux-kernel+bounces-81334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C16867460
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C11F2BF10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494985FF1B;
	Mon, 26 Feb 2024 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TknIRawu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0725FBB6;
	Mon, 26 Feb 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949266; cv=none; b=ZdE98Hg4/tl2vD0P06aqfcqRvCju4+Y2/gvA8DHtPwSkVNCCw0vnGLei4nT+MSAb6q/rIXtiwzsel1HugdJNJ5zQPOUvauOjaKCiZ46ZSg3bHqcsTkHrcXnaE1ttXWT++D9ny35Vsi1mZ6kD+GapAgTdD2PuwgUdIhX0kkGVFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949266; c=relaxed/simple;
	bh=kmBljFz+kSbZ8bIXJhT8zUM42gpha6tY3xxBO2xvQbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ie/2itGz1WC6u8kKpJyL23qAp0/3EUUe6yco5/6jyEBMfXOglfKq5p0hsvC7LACXyQInkNn1Y2ZLY2Vlq6LnkCWywpO/UhE+DsgxGncQEN/46cVKgQZiabx45iEX7SFqUVFKoxxWJl8DWriFo/EpkJyssoeCcECHJ0HeA+TVF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TknIRawu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAEFC43390;
	Mon, 26 Feb 2024 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708949265;
	bh=kmBljFz+kSbZ8bIXJhT8zUM42gpha6tY3xxBO2xvQbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TknIRawuVSJISg/MJSsMa65o/oNvqxAuYVqhjMLqeqsiiMIjM7N181nOKrhLYgtxH
	 q0p6Jc0ykb0b23y8kM9H07vMTOikTPldDdceOwX2REy0iXRKU9jQeVjBiLFpQXkCjc
	 tfWN0CMHz/CrhEb3LigwBqNetuRnwu/0omXopxMsz373MxvZKpEnYvg5JNh8LHnMtr
	 MA5BbmDB8dnMhadtuHo/yNdZAxeFGOVGLump81LYml/BsW5DaonEIqZ+L7s2yMoQs3
	 UXXisLPB6EDKcebpTIQMcf/pUmzxdDcSimshihMdwpKUaqIuH8I8k5VltlsCqbcKVh
	 VWrwlTfLthFgg==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 26 Feb 2024 14:03:08 +0200
Subject: [PATCH v6 2/4] arm64: dts: ti: k3-am62/a: use sub-node for
 USB_PHY_CTRL registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-2-acf77fff4344@kernel.org>
References: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
In-Reply-To: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=kmBljFz+kSbZ8bIXJhT8zUM42gpha6tY3xxBO2xvQbk=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3H8GHdPkWADpoSjT5bWH+wvsv4S4bt22BTc4r
 dh4jLg6hKKJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdx/BgAKCRDSWmvTvnYw
 k5DzEACmylWJajwFT3IEYR/mWbbBDQEerrel8ShpbpZhtlNymtdf9axOYSUoB6P3+a3jyZzDKYV
 15zP3jXsEH0sP5NpcZQjQnskP7+23428AnsCaYDmGTPqMqVBfpBHgK0gRwohb/bMMbFxM2+XcPG
 /iUQMKT99uS1q6qdSj0tudGNcTGu+C1p/RBsGXIHYe9eEKlCf5Nxe1tiXjF9Bnu08jZmC0nH70p
 CQAx45Eu7mI38chA1s9Ty02xuE8WEoiKr91IpZxEVDLrBWIduF1M+orAfywGn9Ofw4pZ7oWmrOa
 WPqiYcpaluom3OwAZrV5hhA1B7mEkzRtwGXHOsGzEz8J0KaQvverxy4iPYk2vR2LINJdWp0kXL7
 1ZjXv1WkUPMWQ9/kgYseU5F3hp1/u8Qqz31NTPCMWmRm5NEN0dnDlbnyh99kX/cnOy7AxQnUC6q
 d0SocukDw7DAKNBhEaXDk41BbrZ40pKVwMEjTdBuDA20YdSyRxVeYdqRnlqASHq0ilR2EtEc/Tr
 /b/jbX5YYW+6OQ53GC0F63uX6OwcfCM8eN8BIzBGuve4BCwPPMgtvJg9OZayZ9VgCMHnFZt6wsm
 xvxLWtqKtMjSsPhv4bgNDd7m/5h209RjmyR4qzPazDY3uu7cGtDaYYcIC+OgjK+jZC9g09Sv10n
 xMdsoFSFr8ZlLZw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Exposing the entire CTRL_MMR space to syscon is not a good idea.
Add sub-nodes for USB0_PHY_CTRL and USB1_PHY_CTRL and use them
in the USB0/USB1 nodes.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Andrew Davis <afd@ti.com>
---
Changelog:
v6 - Rebased on next-20240226
v5 - no change.
v4 - no change. Added Andrew's Reviewed-by
v3 - no change
v2:
- moved am62p changes to next patch
- use new compatible for USB PHY CTRL node
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi    |  4 ++--
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   |  4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 10 ++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index e9cffca073ef..23f1464b26ed 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -622,7 +622,7 @@ usbss0: dwc3-usb@f900000 {
 		reg = <0x00 0x0f900000 0x00 0x800>;
 		clocks = <&k3_clks 161 3>;
 		clock-names = "ref";
-		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
+		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
@@ -647,7 +647,7 @@ usbss1: dwc3-usb@f910000 {
 		reg = <0x00 0x0f910000 0x00 0x800>;
 		clocks = <&k3_clks 162 3>;
 		clock-names = "ref";
-		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
+		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 23ce1bfda8d6..66ddf2dc51af 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -21,6 +21,16 @@ chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
 		};
+
+		usb0_phy_ctrl: syscon@4008 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4008 0x4>;
+		};
+
+		usb1_phy_ctrl: syscon@4018 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4018 0x4>;
+		};
 	};
 
 	target-module@2b300050 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index aa1e057082f0..a158df0d0ba6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -606,7 +606,7 @@ usbss0: dwc3-usb@f900000 {
 		reg = <0x00 0x0f900000 0x00 0x800>;
 		clocks = <&k3_clks 161 3>;
 		clock-names = "ref";
-		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
+		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
@@ -629,7 +629,7 @@ usbss1: dwc3-usb@f910000 {
 		reg = <0x00 0x0f910000 0x00 0x800>;
 		clocks = <&k3_clks 162 3>;
 		clock-names = "ref";
-		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
+		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index f7bec484705a..98043e9aa316 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -17,6 +17,16 @@ chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
 		};
+
+		usb0_phy_ctrl: syscon@4008 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4008 0x4>;
+		};
+
+		usb1_phy_ctrl: syscon@4018 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4018 0x4>;
+		};
 	};
 
 	wkup_uart0: serial@2b300000 {

-- 
2.34.1


