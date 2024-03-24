Return-Path: <linux-kernel+bounces-113025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967068880DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519B3281BE4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7737A139567;
	Sun, 24 Mar 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWus3nS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C51386D5;
	Sun, 24 Mar 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319835; cv=none; b=M3DKeQaFmZmWPqwNOVDhx7zEl6tijatowGv247NDGM0/XUa6kSZliWpizVwHR+4P/ih4odpSa0npGH+N9Gw3sGJXyTwxYTXHlu1CMv5XfDBuBDR6qmCsVf/NGqMUqW3RT15hTSnOxM5kfgLdJkawMKezrLIAFf94woSP7bfbW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319835; c=relaxed/simple;
	bh=49DnlI4xLg7fy52362vWUJfff/Ui3fQ8OkDoSAzHm0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cayqfoaV5mJJktB6WAJgLCcmsoPreVe0P9mRd+bxVouQQ2dGx/5Y//PDCnfcFFv32a00AHbxFEurC4JLT4057uCX5v3tixGVLlzmyxAVrUolhYpDFSXwWx++dg7ATHwzU8apzLgPaQuZUhZ8G/6E4wzOa3wPuLAaDH+oYpUCyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWus3nS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC448C433F1;
	Sun, 24 Mar 2024 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319835;
	bh=49DnlI4xLg7fy52362vWUJfff/Ui3fQ8OkDoSAzHm0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWus3nS9BKw7fxkguM1u8m3ZoOBox672PXzYRjq+dnAQsYbzCbfOOUqOvI+pWFXBg
	 ZSTAnZ+3h9WTpdTEww1pZpcdR1gScdBXwYYzo1VBGQ/vBYlqKor/Fp9hCtqKBi1FMX
	 HRgHTGaMU4mqdRdyL+v7HAcFo/ZFZW1SZdRJF63QM4y5bTDp03Zg7fDzJzKU7cF5Az
	 FSdvz0id6udtMsrmdEqnK3enhztKWfTI13QQVaT2APbvfRHbxGSdd5Wchkq4WoN+lv
	 aXOZFzK9IScCAswaxjcakYtb8XVE3spj459xaRIixcgf3cV1i6OVx8/pD1lS+SYqO7
	 PenAOpKLUBwxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 138/715] arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
Date: Sun, 24 Mar 2024 18:25:17 -0400
Message-ID: <20240324223455.1342824-139-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 6425773f68e0a..bbbaf2165ea28 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
@@ -47,17 +47,6 @@ pps {
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
@@ -144,9 +133,10 @@ &uart3 {
 };
 
 &usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
 	dr_mode = "otg";
 	over-current-active-low;
-	vbus-supply = <&reg_usb_otg1_vbus>;
 	status = "okay";
 };
 
@@ -204,14 +194,6 @@ MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
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
@@ -234,4 +216,11 @@ MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
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


