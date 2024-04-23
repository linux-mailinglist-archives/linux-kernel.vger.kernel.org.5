Return-Path: <linux-kernel+bounces-154792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6398AE112
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8171C2186A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571C5914C;
	Tue, 23 Apr 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="opyJs9d6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="opqgTN07"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3E21345;
	Tue, 23 Apr 2024 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864841; cv=none; b=fKJUINe3/06ma2ivgHKcudjgAqdukgvbqJeFRaTa/XFdLiyxts8PnBrPCEzcpRI+/S302ZbcPAKeznRYU3J/LP0MF6R2zF+evWySDO/XJs6akxG3GExBIhFy0ixpzbHaJKgZs8HbL93CHyInFEZS9h+gKuHZdJ+omwbbizgDyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864841; c=relaxed/simple;
	bh=3r9XkwDAQk9zJ/0X2bslkFBrf1M1gikgu5xwvSdm/nI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p/XnUCSKXW1KbTyJbWwH1/FBQILF1aZNjbQHxecAvoOkPTHRgWwFOxMgXadIwN+3jBlCO+eK2sCrMaq13WdBFBA/cYIn6zMpo5UJRcgW7b+VKlFgS+NuKtaWNXtVLbdM/uc2yDz5h6qUVCPiMGwgVBbYGPMNGVomDtyOqMDhgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=opyJs9d6; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=opqgTN07 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713864838; x=1745400838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1k42/CWadvw0r+CYtNZdyyObiEgdUN60PPaTnqNvua4=;
  b=opyJs9d64MnDD9KkJkYNvnSJsEz9vdKYScUmyaRuWG4MGHu6WrsdzkT2
   lqUMW5k/jV2pcMiXjC4adDugRgagb0FLpfOc0atkUq5ZUjIUT92zGB251
   IwGNMjJqKrNYJcQ76e+fTS4b37g/C8pODm7Xli9oPVNuwaOJka17H1kDY
   vCebMgAw2CGUW43mhpxhRx6QVZV38d+hH4luG9UnCzjeNXOUhTU9jvUQy
   CMks+aBFGq7dvLH9MKQVqhypMmWWqXVJ7O/xQaxbUik91vtcsC159BXT8
   gyZAeF1KKeAvYREhysOb7+6EKc8nJjhbpNib0ARyiEu2uNjc6W2gu01oP
   A==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36562127"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 11:33:53 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E46B173F7F;
	Tue, 23 Apr 2024 11:33:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713864829; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=1k42/CWadvw0r+CYtNZdyyObiEgdUN60PPaTnqNvua4=;
	b=opqgTN07Hlk8ImEG4B6XUDOCMXhsTRMAoLn06g3eEqsHanScDULX+CtT0rOeP/T4IgxwfW
	9h+KXprD/nhMOAn3hB9DuQ0pxpPP0rFq/DA2hSM3yan9KlPtwXz7ek7AgN3jF+0lOoaEDs
	R82Ak43LU2NfzUfd9/VjeOII+0UiRBdMCm/4D0aKVNCYTzNhS/Xmunywb2AFr1mEhIiJRO
	y/kyKnDcGIx+gve8tCaxnHFe9UwiSZhy/KrET+uKq2v80hhrNOEwyUGOETQ0d37VrgV3MS
	Bbq/Kz+vC/aclFoY3NA+unIQVV/GbcMX3LxLXlfGSS3zQyAWGUrFvxS0EOCQgg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: mba93xxla: Add USB support
Date: Tue, 23 Apr 2024 11:33:40 +0200
Message-Id: <20240423093341.1927592-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds support for both USB host and USB Type-C ports. This includes
the on-board USB hub.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index eb3f4cfb69863..da8f19a646a98 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -252,6 +252,32 @@ temperature-sensor@1c {
 		reg = <0x1c>;
 	};
 
+	ptn5110: usb-typec@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "X17";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			typec-power-opmode = "default";
+			pd-disable;
+			self-powered;
+
+			port {
+				typec_con_hs: endpoint {
+					remote-endpoint = <&typec_hs>;
+				};
+			};
+		};
+	};
+
 	eeprom2: eeprom@54 {
 		compatible = "nxp,se97b", "atmel,24c02";
 		reg = <0x54>;
@@ -433,6 +459,41 @@ &tpm5 {
 	pinctrl-0 = <&pinctrl_tpm5>;
 };
 
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		typec_hs: endpoint {
+			remote-endpoint = <&typec_con_hs>;
+		};
+	};
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb424,2517";
+		reg = <1>;
+		reset-gpios = <&expander1 2 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&reg_3v3>;
+	};
+};
+
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2_hs>, <&pinctrl_usdhc2_gpio>;
-- 
2.34.1


