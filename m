Return-Path: <linux-kernel+bounces-116026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D8889509
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3C0296F94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853C24E3BA;
	Mon, 25 Mar 2024 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFSKgKOV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053817497A;
	Sun, 24 Mar 2024 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323380; cv=none; b=NenRB2kfkPHJe1B7B2tnjz8jcAs+t44HYO9MyCRGDh6oIiCyK2OHSiBybnmcZhz1DAMRGEYbqhAgnpMJ5+K7NclZTtqBcGDFD1JN0KMlO1LbocPTlxMcvlyHsQsx3tBrScUhBU84xgCULHR8I9srYmWdoS+8I1GpBp639e5nAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323380; c=relaxed/simple;
	bh=p3oAQAnj1GeDzvAmW03RGagMjnmZp0YNL59rgkbV4Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptsMFwkQghPQRgnZO+SFAbhWsR5OJu25GqbULojFC9YyJwruVfhEVE/50ufeX81+QuHU/xEIRvyzcAOhPosGvgaDd9cRNw9kdjrXFlHacaiKrsGKDjkC/qmqzjgCm5a1JJzapCch04OBzGXVDzqNCnPmVjQLjp7B6ekgkd4X+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFSKgKOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6FAC433C7;
	Sun, 24 Mar 2024 23:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323380;
	bh=p3oAQAnj1GeDzvAmW03RGagMjnmZp0YNL59rgkbV4Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFSKgKOVPb0wkPyJBc2qnfuHCBWRbCjYwNgwJP99eyE+slEQqoC0K2T4Lk5Mn8fJm
	 baIMqjEwcHeRnnJAwQ4TtL0PsikGJm6EJzmFItPb++Q4GK51uoI9KmCwhGSd+2liGh
	 knaxYblz322uNoQlmasDzk9PtEhkvqjRoGfHe7eNjN3nQWeXloXtiuzFQ5EMAw5XCG
	 wWbs1zqsGFdDY1dFIJ1t9/8GVhz2nKAAWh4s7QQNRq2I3J6eoxGmO9rQURbDIUxxJh
	 OgKJpaGCZtgeBZOWlcPui9BdQ7loVI47nVd6A7m164JfEaxCk/0cish88TYNVp76Mm
	 Z3KBgz+CDKKuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 080/317] arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
Date: Sun, 24 Mar 2024 19:31:00 -0400
Message-ID: <20240324233458.1352854-81-sashal@kernel.org>
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

From: Tim Harvey <tharvey@gateworks.com>

[ Upstream commit ec2cb52fcfef5d58574f2cfbc9a99ffc20ae5a9d ]

The GW71xx does not have a gpio controlled vbus regulator but it does
require some pinctrl. Remove the regulator and move the valid pinctrl
into the usbotg1 node.

Fixes: bd306fdb4e60 ("arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/freescale/imx8mm-venice-gw71xx.dtsi   | 29 ++++++-------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
index 7ea909a4c1d5e..6de00c9dcd349 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
@@ -40,17 +40,6 @@ pps {
 		gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
-
-	reg_usb_otg1_vbus: regulator-usb-otg1 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb1_en>;
-		compatible = "regulator-fixed";
-		regulator-name = "usb_otg1_vbus";
-		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
 };
 
 /* off-board header */
@@ -102,9 +91,10 @@ &uart3 {
 };
 
 &usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
 	dr_mode = "otg";
 	over-current-active-low;
-	vbus-supply = <&reg_usb_otg1_vbus>;
 	status = "okay";
 };
 
@@ -156,14 +146,6 @@ MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
 		>;
 	};
 
-	pinctrl_reg_usb1_en: regusb1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10	0x41
-			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x141
-			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
-		>;
-	};
-
 	pinctrl_spi2: spi2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
@@ -186,4 +168,11 @@ MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
 			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
 		>;
 	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x141
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
+		>;
+	};
 };
-- 
2.43.0


