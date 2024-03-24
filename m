Return-Path: <linux-kernel+bounces-113678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A48885F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326071C25604
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078BD144302;
	Sun, 24 Mar 2024 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwQxMktD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C083CB2;
	Sun, 24 Mar 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320639; cv=none; b=IEiJM1lcbCn+3GYwkUa1K9LFAy2DskJfj/4CzKFhqBJusztlooRZm0rQFlVFhF3I+v0Uvqpt0+Lr6N4We/prSLerzwsprSJ3vMX0BS7uetdIvIP8CubwKnypKx11aMJaGv8EpGaF97q4nbpDRm4LFOIlSRVliTPa9+zzfNxcbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320639; c=relaxed/simple;
	bh=49DnlI4xLg7fy52362vWUJfff/Ui3fQ8OkDoSAzHm0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPyGyiCj600HQ6QvgxypPgWHdgstTIdSis/lHGzkUDaxwx1UpJf0/09k0rJWi82TXBcerWk49BQrepPblqg5ZEIhVYW2n54UF3nsQDIdjJ6yLCIckT48fA8a+g7nj2GGahtSXgfmPk+qwUV521P+7fl5/+PJpDqkis78+pUiHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwQxMktD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC1CC43399;
	Sun, 24 Mar 2024 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320637;
	bh=49DnlI4xLg7fy52362vWUJfff/Ui3fQ8OkDoSAzHm0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mwQxMktD6gvNq3Cfxc+nMmwGAkclGuOB5XSeYoRB/fsGyAQshejL87sVB8Cke+XlG
	 PxeD1tHRQHmdi83dlKNC8vHEz1d/F/x3L4CYUAqsi+zWyHZs1A6NUCFdYNYuFWz6mt
	 hySOR+4JoxC/AENcvmpZ392zhxhRajOfjkE7YJUArpQoS0RlLcH6iDOMXCbiKin2Mo
	 +Q5+YVzzgMtIR0Zxd7+q+qVfwoOFX39miwWuB6hCFmbo1JeAvaWJRvg7J5YQRbfHj+
	 HrFdm0/ksFKc5L7ISisJSj9+0CIhWUSgElYq/o0wxIIoQOwRCOd0xIPakGoCRSr8Bj
	 cCD189Wn9z2PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 199/713] arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
Date: Sun, 24 Mar 2024 18:38:45 -0400
Message-ID: <20240324224720.1345309-200-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


