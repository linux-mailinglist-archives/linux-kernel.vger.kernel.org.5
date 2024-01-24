Return-Path: <linux-kernel+bounces-37013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D083AA30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B91C22E60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A279277646;
	Wed, 24 Jan 2024 12:45:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0B76918
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100304; cv=none; b=huYAsFcdgBnWiTBtvHDPkHnZvtjZq0KOQQXRNxWm3CgoUL/f1LWehLIpWr1sUyvblHAs60XITkcFuQlEycdMpIy4P8NCjraFZyVjqbTjbFgf5u8H1baz+PupApN53Jg+mq3UZRc7syYWTbROx8iRuQRjI/bYuQrvUysdiWqetbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100304; c=relaxed/simple;
	bh=0lNY9JM6i1cyRanexkIXDsWXhY843ieXctUNb+I5i5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DshGBQfNvwvZ8pbKb5sVuiYvDPmhna9lBofPu00EAtVoIj1xuQzP1vBrE8BN1EW7UfEJ80UN/O/viZ6GtNQMC45147No2Xcv4DDYI+XNanJxxia85LcZPMgGwm0wFPZ3pSCeJS4goLvCJp1GtRtO85wcVx/F0ZpG01DuxbT7Fo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rSccj-0001gO-94; Wed, 24 Jan 2024 13:44:57 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rScci-002424-GQ; Wed, 24 Jan 2024 13:44:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rScci-00362d-1Q;
	Wed, 24 Jan 2024 13:44:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v1 1/1] ARM: dts: imx6: skov: add aliases for all ethernet nodes
Date: Wed, 24 Jan 2024 13:44:55 +0100
Message-Id: <20240124124455.738187-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add aliases for all ethernet nodes including the switch. It makes it
easier to find this nodes by the boot loader.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
index 2731faede1cb..d59d5d0e1d19 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
@@ -13,10 +13,14 @@ chosen {
 	aliases {
 		can0 = &can1;
 		can1 = &can2;
+		ethernet0 = &fec;
+		ethernet1 = &lan1;
+		ethernet2 = &lan2;
 		mdio-gpio0 = &mdio;
 		nand = &gpmi;
 		rtc0 = &i2c_rtc;
 		rtc1 = &snvs;
+		switch0 = &switch;
 		usb0 = &usbh1;
 		usb1 = &usbotg;
 	};
@@ -60,7 +64,7 @@ mdio: mdio {
 		gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>,
 			<&gpio1 22 GPIO_ACTIVE_HIGH>;
 
-		switch@0 {
+		switch: switch@0 {
 			compatible = "microchip,ksz8873";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_switch>;
@@ -73,13 +77,13 @@ ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				ports@0 {
+				lan1: ports@0 {
 					reg = <0>;
 					phy-mode = "internal";
 					label = "lan1";
 				};
 
-				ports@1 {
+				lan2: ports@1 {
 					reg = <1>;
 					phy-mode = "internal";
 					label = "lan2";
-- 
2.39.2


