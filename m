Return-Path: <linux-kernel+bounces-115801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60018897FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B6F1F38BED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0823736C7;
	Mon, 25 Mar 2024 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2rxi9c4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63BF145FE9;
	Sun, 24 Mar 2024 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322048; cv=none; b=NxJYhyM7jO3wwx4Sn6uF8BJZ7pwPWHAV0m9drYqLnFvjY73rWW/VzLLinZxIxeU5iVYriS6B9+Q/Ywa+23jG124xV4zSdQXvBORg0c0TpMsyKtPLQGsv+uL8RTcqtauhSTNUV614J052D3ekNSKnQ2yQoi2PEPiE5uoBLWg17Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322048; c=relaxed/simple;
	bh=R/IatUZ1AMwOdQhzRAN+1ix9xjDHHA/aOlINXqZbzSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXmA8TMAW25roe5kklje8OgcVNqH0zWLIOPyhQITEt7VX1/uOaR9xIS0ahGkPifejctUnj72/mWjNPbHWvvMmKIeDiC7hCSgioWZDzvfAQF/QDb6fpJ1GlQ2GeYRAoMbjwVFvtHoceiaBq/zrdy7PPuGg0whxskxsPVFYt6EsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2rxi9c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305A6C433C7;
	Sun, 24 Mar 2024 23:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322047;
	bh=R/IatUZ1AMwOdQhzRAN+1ix9xjDHHA/aOlINXqZbzSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2rxi9c4auHSAByJPHzd4Blm6h3YQK+0CXZq1ry93LHsqvBrNIkX8jeE1+SHZgsSl
	 jMBuYj4nb5ORVgu2XwPzGFt469WVK421HYkElKWLo9plGc7BgNEwIVaslCCbGxHTer
	 G4dvhVQOgHVagUmWRufyWSi76VxRJxD3/kNCZK4U98ua6h6WwGH4lRqrL82EuaFAEP
	 0u5qdDvH9uwEoMkF54QMNK5q+VdeUSZAodofgfNOEPxUhN8aRlkF94Zb8s7TinMT0l
	 79hW+sR5M9aMWo88HvpO5wU3kj2a6mQYm+goLB5gQlsGzohNG6GKoU4zUXAPDZQpUm
	 wy7sm8GzZo28g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 120/451] arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
Date: Sun, 24 Mar 2024 19:06:36 -0400
Message-ID: <20240324231207.1351418-121-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index c557dbf4dcd60..2e90466db89a0 100644
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
@@ -146,9 +135,10 @@ &uart3 {
 };
 
 &usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
 	dr_mode = "otg";
 	over-current-active-low;
-	vbus-supply = <&reg_usb_otg1_vbus>;
 	status = "okay";
 };
 
@@ -206,14 +196,6 @@ MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
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
@@ -236,4 +218,11 @@ MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
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


