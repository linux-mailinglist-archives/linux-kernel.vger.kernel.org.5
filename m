Return-Path: <linux-kernel+bounces-142619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05588A2DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C026281E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9896056B62;
	Fri, 12 Apr 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgeo3mP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538756750;
	Fri, 12 Apr 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923329; cv=none; b=biaQgGmuBlXkcFYJKAw155Zz4jjs3efsO/QgXySmHbSMcQMgOGlHktcW15ZQv3HJsTdGgCXLyTUc0dhvCIL+nDF461RlMLnw3WoG/Fj58etRW4orqDup0C9HvBkahNgIgvBSsL9xOVbTUpyYkO0FEz5xGoNxRKochIm+JzsTzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923329; c=relaxed/simple;
	bh=XT08XF8MuQA87EqyAeoT70AUc6HJXFssKGXXnObeqOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGsBGJpvIqwNhYctkzUazL/4/4f8nPgIQMWiBf4l7EqXdljS1tVAgzHxMCf1DlJCteZieg8QB6x8YpOYq1pYg1bVm0YdooWO7soTGX3X9+ZF4REroEl8H+qtYOUt9O63I72hiA3mftceKBGbAtatbzRCwGUIrO8szm2vSj/F4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgeo3mP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66224C2BD11;
	Fri, 12 Apr 2024 12:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712923329;
	bh=XT08XF8MuQA87EqyAeoT70AUc6HJXFssKGXXnObeqOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wgeo3mP/4gdzlTiSfK7v6/QVYcZBk7j3SIKOIJMTz6FRx7jJzXGY/dafuwSaY8X2H
	 KyqaXHxiW1e/ad1sQxGU7pZ7MeFFRnBnHREx9LKKy4CNzPtYFkEpNVzHjRll01L5Y5
	 iCR10+BEyLZ6VaylkPZXhB7DlC1H6aNE6HIod/Eu1A3zFc6qDZvxx6YIFW9V5Fr8nX
	 bLU7kGmQZBG8iQzJozt4M2QamdrMqAaJdsyUdo34opjk4RSYWAIjUZPDwD6y4rkGfE
	 4kCMag6qAo+37FHK8zWkib3T3TqLHhINUd9UboS2E5Pr8j6dFImKOC9aKrSci5FGnC
	 BPBS2I0xH+65w==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 12 Apr 2024 15:01:58 +0300
Subject: [PATCH v7 1/3] arm64: dts: ti: k3-am62/a: use sub-node for
 USB_PHY_CTRL registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-for-v6-10-am62-usb-typec-dt-v7-1-93b827adf97e@kernel.org>
References: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
In-Reply-To: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3943; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=XT08XF8MuQA87EqyAeoT70AUc6HJXFssKGXXnObeqOc=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmGSK6I8Q7u7c7JQSk12Dy+Ryt69J7vjRPFtN+4
 fzctXWkzYWJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZhkiugAKCRDSWmvTvnYw
 kwIED/9wBE43QVVPYiMid8E/rZtuDgcFIPNLGZbMD2im02pOS8uTHm2MWu+/M+Al5VEU7BndiUH
 YSnv/yTdlqTM/9vx4YLqdDA7FpJ8GSYNaNM6cPau9Bz/NQtrUTOHm5VCBRSiW4dOJLb26qVxXtH
 lKr7T1sIsZxDf6sdc8xyWtlnTTam717X+AjNVwnB8uI1woe91/1fcnbZAswigbVKTCFzkila1Fz
 E8HNmozaLMTyAfcBlVczFXqoqcBN4QiskTrX7N31rXBqRm/IonNeAsEta9ymNiQAwpW9F9k9uF3
 liKmnnkL1vq4Jd+cQo3GkjMMZiHVEmPMSYHx52+/kLxod4nykN0O+gB5dp4kUUTWZlsElDTO/nd
 TrN4vYpZhioDnJtvSoQSxJxvy+9GtC9+L8vCDLqgsu7KR6tI0hmKwGCHlN7utPLftAr5IHl62aU
 3eTgIKuhXbVUX2ptU8BNxoRMjRj6Jet9Qw7fJbbMIM0jsw0ZpdfydQMxrVn2wjmDqvpoDOQgZXm
 u6Rdt86yr35sAG73x3PcOFrA74cxZaFKUoZCM50auwuX8KN2UmFE8zaobKMGXR6qrVdHvZJg26u
 aIO9iGOT3nN9Up5J9OcpHfDQdes/lVQAa/uV2VpA+ClGgNVxPv5PS5Oj33CrJY62nVt78oXxCeP
 XykPV1bbL9TnMzA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Exposing the entire CTRL_MMR space to syscon is not a good idea.
Add sub-nodes for USB0_PHY_CTRL and USB1_PHY_CTRL and use them
in the USB0/USB1 nodes.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Andrew Davis <afd@ti.com>
---
Changelog:
v7 - Rebased to v6.9-rc1
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


