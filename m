Return-Path: <linux-kernel+bounces-72109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E5385AF28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E3E1C213A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FC556772;
	Mon, 19 Feb 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="I6yNfdsn"
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750FE2119;
	Mon, 19 Feb 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382568; cv=none; b=D0ILOnamOzjoniE7OCy4ttV2g2LowCcG76rR9sNo7bG36zjBkFtZdkStWwBVoJtFOmu1c1w6Owh+HTa9mZa+Y72AWHsx/KdCcg4Jmhr22vpNgEzMIpMkUGZCRvEfhymkHtpXBdPZUE50UwtUHjcbtLO9YGFynT5ReQ0gKMJf+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382568; c=relaxed/simple;
	bh=205kobiiq0OZ4vyrcPqGUylfgKbklJ6av7kqniVA3sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ5lSnl18mOFbOZb7K2/RHTiATXzsusPRVfYbMn4l3da4w9F43e8LXmDt/COo/21utIPVUOaXmu0kl+T1Kf80D3RUY+4TS+WKPRhxu5rwiwQjs5T48E/Ib6hpe7aPKUEt1KHyCqeaoNskRwtttqjwDrzFGa0hZjmABC0MBZzog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=I6yNfdsn; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3285:0:640:fd1e:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id 7F9E060F42;
	Tue, 20 Feb 2024 01:35:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bYZIDNh7RSw0-FB9u05gv;
	Tue, 20 Feb 2024 01:35:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1708382117; bh=fqzflXpM3r0MZxo6zkWwvorWkYWVAXDmWK9yDZQ1Bvo=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=I6yNfdsnH2TtlNDPrBD8hwigAJudfpl0wSu687KvBm6piazgsYhwy/b3l0RvDLhpJ
	 1bu4boWlLeVsuzaNRwRJRDvCq2rzStOyeFL7H8aD2Dv8x+5vPGM98D7D11syxEXuzw
	 61lHTRZhUpzuqOBHd9c4Q2kivEJKn+Q9/lFqqOKc=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From: efectn@6tel.net
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	Muhammed Efe Cetin <efectn@protonmail.com>
Subject: [PATCH 4/9] arm64: dts: rockchip: USB2, USB3 Host, PCIe2 to Khadas Edge 2
Date: Tue, 20 Feb 2024 01:34:20 +0300
Message-ID: <4d22afd70e5583458f405f5170f67690584e7efa.1708381247.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <5a7bd2cd8703e51382abfc11242de59d45286477.1708381247.git.efectn@protonmail.com>
References: <5a7bd2cd8703e51382abfc11242de59d45286477.1708381247.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Khadas Edge 2 has 1x USB2 with hub, 1x USB3 Host and 1x USB-C.
This commit adds support for PCIe2, USB3 Host and USB2.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 856ce4f869a2..ea7f1bb7c908 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -38,6 +38,33 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_host";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_host_en>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_pcie_wl: vcc3v3-pcie-wl-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie2_2_vcc3v3_en>;
+		regulator-name = "vcc3v3_pcie_wl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vdd_3v3_sd: vdd-3v3-sd-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3_sd";
@@ -84,6 +111,14 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&combphy0_ps {
+	status = "okay";
+};
+
+&combphy2_psu {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -130,6 +165,30 @@ vdd_sd_en: vdd-sd-en {
 			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	pcie2 {
+		pcie2_2_rst: pcie2-2-rst {
+			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2_2_vcc3v3_en: pcie2-2-vcc-en {
+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pcie2x1l2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_2_rst>;
+	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie_wl>;
+	status = "okay";
 };
 
 &sdhci {
@@ -483,3 +542,41 @@ &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
 };
+
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy3_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host2_xhci {
+	status = "okay";
+};
-- 
2.43.1


