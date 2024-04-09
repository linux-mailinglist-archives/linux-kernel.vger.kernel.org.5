Return-Path: <linux-kernel+bounces-136803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5447F89D852
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091621F25738
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761012E1E7;
	Tue,  9 Apr 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5WhdTDlk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172712C53D;
	Tue,  9 Apr 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662953; cv=none; b=f8979kyauVXADIrkzCSvwR9BYkq6w7ItSvmDNFT80oXqMj64RYFjGGNHqL4iI1x4vLSs4Urujn+vxNQVdFcbq5RPw6Qsh/DKXYk3drnI7tIwGcEq3xOMIxLOB0jRWpABu2/PFwdbGlra5d/s/IvzWhc6467UcfAVN2BH58Q9XMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662953; c=relaxed/simple;
	bh=lRpaqbeDxkCxJuVuV7wFw13Xw8Co2VG0r3GNWGlOryA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tivd7ovWBizi5A/i5affPsXhDG7Xs10wcgoVcy979mQZ4kR/ANtx2jwNJ5JJWIvtSIAILs9A3Q+cCB4uxoHfzrdR4gyM35hpKE0Pl1JYmw3tKxmJeZCLZWHuLueqUl7MmXYjHhi70t0fW1UHEozNq6G3j7iL8d0L0KwS8GTSAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5WhdTDlk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662949;
	bh=lRpaqbeDxkCxJuVuV7wFw13Xw8Co2VG0r3GNWGlOryA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=5WhdTDlkiKrSe2GfXSJrPNQond3nkwTpxc3x0pRZGKHszjxKRKNaLKFbBqv5BFXwj
	 mxmeb/aHZw+z9+II0rBbBVPf0j8UE0tpWCkAzwm7c7emzG9sxXRVF35QhON3xDcsJX
	 yig/p4HfQWJAnpgOOGwd0WHvuStK01CRWs9WMJLzPHpuBKeOX6zEazbD57ZOtQrZoc
	 0bBdD+82QH5P0aKthO5+wEI5aHOa646K8oItvS37R7sF2Tv68PrjOGJwEdIi78I8tr
	 lsSMWjuKw0THnAX8DH8Kk0NXXPfLmendQOe+Xj+gs4fGQCAcrFY7+NSKm1Dn8cBRg/
	 kerNjyJAT6qIg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8149C378212C;
	Tue,  9 Apr 2024 11:42:28 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 4/5] arm64: dts: mediatek: mt8395-nio-12l: Enable PHYs and USB role switch
Date: Tue,  9 Apr 2024 13:42:10 +0200
Message-ID: <20240409114211.310462-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
References: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the PCIe0 PHY to be able to set calibrations read from eFuses,
improving the stability and performance of the PCIe link.

While at it, also enable the T-PHYs for both PCIe1 and for USB, allowing
the USB ports to finally switch to gadget mode if needed, and configure
the VBUS/ID pins of both USB ports for the same.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index f699633659b6..5cbe969da425 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -685,6 +685,26 @@ pins-bus {
 		};
 	};
 
+	usb3_port0_pins: usb3p0-default-pins {
+		pins-vbus {
+			pinmux = <PINMUX_GPIO63__FUNC_VBUSVALID>;
+			input-enable;
+		};
+	};
+
+	usb2_port0_pins: usb2p0-default-pins {
+		pins-iddig {
+			pinmux = <PINMUX_GPIO130__FUNC_IDDIG_1P>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-vbus {
+			pinmux = <PINMUX_GPIO131__FUNC_USB_DRVVBUS_1P>;
+			output-low;
+		};
+	};
+
 	wifi_vreg_pins: wifi-vreg-pins {
 		pins-wifi-pmu-en {
 			pinmux = <PINMUX_GPIO65__FUNC_GPIO65>;
@@ -709,6 +729,10 @@ &pcie1 {
 	status = "okay";
 };
 
+&pciephy {
+	status = "okay";
+};
+
 &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
@@ -776,6 +800,18 @@ mt6315_7_vbuck1: vbuck1 {
 	};
 };
 
+&u3phy0 {
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+};
+
 &uart0 {
 	/* Exposed at 40 pin connector */
 	pinctrl-0 = <&uart0_pins>;
@@ -791,6 +827,8 @@ &uart1 {
 };
 
 &ssusb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb3_port0_pins>;
 	role-switch-default-mode = "host";
 	usb-role-switch;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
@@ -804,6 +842,8 @@ mtu3_hs0_role_sw: endpoint {
 };
 
 &ssusb2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_port0_pins>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	status = "okay";
 };
-- 
2.44.0


