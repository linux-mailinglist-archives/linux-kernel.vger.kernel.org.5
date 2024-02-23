Return-Path: <linux-kernel+bounces-78358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322C86125C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEA4283172
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43107F471;
	Fri, 23 Feb 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iygg0o1f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA57E781;
	Fri, 23 Feb 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693980; cv=none; b=uqID+H0MqTM4EDODXgUElIx4AAB4/WiGU9bWhCZY88aCEgGfYw/Xc6GBdGxX7RPRMW2CgZcQb6DrE5PJRB4x0FYcXCtZ26QUrV+FUVc5c1KqZZ5WDgswBr/PbDs7FYOaXG9Bw+fjrixuFfB1tJIoRtj9E7i5jgywyLIFFUkWKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693980; c=relaxed/simple;
	bh=9/umIRpdXlG5SfG097Yi8FxF5FUuSmeX78auq29VC6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SvPlwT54VvTgiBP8fP+VD/IbwwDI0Y49uaGeHAH/eEWF4+KFFlTdRmW6QWQrUKB5oEITipkpm6sFw2YPkpaL1yBIbeq5mRTXsskoqNhktrUumB2OiY6LrtwZcJuVaSjWUGu8c1nqOBL+7OzIuIpdd0w82QZEAcPuy42MXx8hvhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iygg0o1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DFCC433C7;
	Fri, 23 Feb 2024 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708693979;
	bh=9/umIRpdXlG5SfG097Yi8FxF5FUuSmeX78auq29VC6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Iygg0o1fKewwBsg9oMeP6m9MzDG4F+Gcw4yXck2AHLiQ8cEbVuuuYmJtE/pulu+uq
	 HZyh0+SqnLpLKw4fea1FnVT4ZPDyVDiARD+0n6m76oNwiNDgQIHeOmAAlHESeLRsmz
	 0ZMvs5sLvoPjvt6na2rChGyhIibxBKWt2WkDNxNeDEgjNzKVe86DD+hlc76K7O4E4O
	 F/5bdAAKxEfpB4IU8l9b9tNBLub7O71EWF/qnKnBJ1CgUZkRZlwwGdee2xQot35iCW
	 YVzL3TWGaw0JjuWNefOj5usNg5V1pW8tyRdsyl3HpGWyxmCVGsoWtbBFfefinBbh74
	 apnsf+dRBTrDg==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 23 Feb 2024 15:12:39 +0200
Subject: [PATCH v5 2/4] arm64: dts: ti: k3-am62/a: use sub-node for
 USB_PHY_CTRL registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-2-4b5854d17d18@kernel.org>
References: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
In-Reply-To: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4037; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=9/umIRpdXlG5SfG097Yi8FxF5FUuSmeX78auq29VC6s=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl2JnPgphjTmCrw2sNzlIfzskpDbFqcUs5ho35z
 YQEAHGenxWJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdiZzwAKCRDSWmvTvnYw
 k+2bD/9goNbVSPedqCc+1q/k1RwmivrxqlpCAtbDlBqu2UJzZai8aE9IgSDO0T0mfYr1pTVMtv2
 ziq/osow5gACwwDVJnnx1Rt/ei8KxTXvBRKS08a7JU7PtejW+YbMrX1gE5mcnjGPamJQO+Piv9q
 YrGGvooh1krVTGMBu0yNZrU7BeIyt8/QsbutPWOybOzXeWjyLrt7N4UHSbG8TmCrhSGy7NfrG1Q
 SYTxggebbF+wi7Aa/XuEgn9aAhhP9YUqcthU+2sqneudA+NT3CaXdzMig5IBFJ3r3SavKkxvutK
 pbc4xxc2yFedgyEflX0REF+yq1slH7zyOCXfGKmWlXGS7Z6x2iyzpCfYke1TGd3YbmJg3fi1HDS
 lKXjFb3pRhfPuQ6T1ZkBnNWa4A7cVPZEMhfF3/abNaKIngutBi7JT858pPfBGMxpmO6auN57IYe
 93ADhu31p9i9i7tJ3HuRWHS2+DmNxkkAmtMT0ITnEv5tWtSB6kYTKnEug7GTjqQCOMXH6lbe7cP
 T6OeDOB8A4o/voq9GUVFt4N1M23+lSKeinzsOqebyQV7If/dDhmYro3CvYQ4nNZ/zF432KSURF/
 fCytQzN9TWe8Hc4d92zT+1dlzP2fIwVAgL9kkCb787hooRCacnczJL4IB3m6pZ74X/rsMWPx2d4
 NJuffzuE/0p9rBw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Exposing the entire CTRL_MMR space to syscon is not a good idea.
Add sub-nodes for USB0_PHY_CTRL and USB1_PHY_CTRL and use them
in the USB0/USB1 nodes.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Andrew Davis <afd@ti.com>
---
Changelog:
v5 - no change.
v4 - no change. Added Andrew's Reviewed-by
     https://lore.kernel.org/all/20240205135908.54656-3-rogerq@kernel.org/
v3 - no change
     https://lore.kernel.org/all/20240201120332.4811-3-rogerq@kernel.org/
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


