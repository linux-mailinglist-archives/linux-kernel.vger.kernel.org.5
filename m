Return-Path: <linux-kernel+bounces-72110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4994985AF27
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC331C22297
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189656771;
	Mon, 19 Feb 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="ZS72suhl"
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75148535AA;
	Mon, 19 Feb 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382568; cv=none; b=qyn03tyuY1hJD51EJLd6iRViNYMX9RyCQnu1tG400NkqKyCoqPsbqRgmDCkFlqj8qdIAkoYGv8TLE4ZqaSOGEeB2NG90Lkaw10LBJjpMkC+Ax43r5SwmjsKEO+DClRyGPkQDZz9qwPQeHFDJSNN/UtWKYQBIip/CBfTCR9h6FdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382568; c=relaxed/simple;
	bh=oMQA44Y6F77Ip9mAVFhASMJopR8qMzTCKB8bdczGf3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llKAhP6hGNXDXUmo2oGQNmUb0aKTyxUxmyGz7YTU47e8S1FSl4c6Dg2rKNhT7RUcOwqMMCE64Zg+eJI2a2Nakv6uwF9V7lWKJhSM3Ckun3HHy5vHP5m586MduFjSlEhT1rOkJrpYXVVjuk3axC+jFFCfgwlZGyFq8K97pK9ECQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=ZS72suhl; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3285:0:640:fd1e:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id 8B2E260A71;
	Tue, 20 Feb 2024 01:35:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bYZIDNh7RSw0-4wsHJwlL;
	Tue, 20 Feb 2024 01:35:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1708382114; bh=Dg3NPhdWCbF/J6QGjt5jZEuBRyHuuRdGYC0aO9zVBSI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ZS72suhl3hi7aFvyMzx4PYGPr7oc678dPqa8EFaacR/t0cOF2CYOlTlUcisPxtejT
	 bDRkX6JIbVT6RHMx3VLzNmEw66AfZO+hYV30zm1lHqJrP6C7LcOWAoWr5VyQcyIRhx
	 BKW5KXIBEpZewTHKjS8gGf02uqyM0p6CakTEwNxc=
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
Subject: [PATCH 3/9] arm64: dts: rockchip: Add TF card to Khadas Edge 2
Date: Tue, 20 Feb 2024 01:34:19 +0300
Message-ID: <6e9062feb40bbad304f2e5bb300601034e805081.1708381247.git.efectn@protonmail.com>
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

Add TF card support to Khadas Edge 2.
The board exposes sdmmc pins via EXTIO. TF card can be used with IO
module.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index b99d2b82c787..856ce4f869a2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -12,6 +12,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
 	};
 
 	chosen {
@@ -36,6 +37,19 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		regulator-max-microvolt = <1100000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	vdd_3v3_sd: vdd-3v3-sd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v3_sd";
+		gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
+		regulator-boot-on;
+		enable-active-high;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_s3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_en>;
+	};
 };
 
 &cpu_b0 {
@@ -110,6 +124,14 @@ regulator-state-mem {
 	};
 };
 
+&pinctrl {
+	vdd_sd {
+		vdd_sd_en: vdd-sd-en {
+			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
 &sdhci {
 	bus-width = <8>;
 	no-sdio;
@@ -120,6 +142,18 @@ &sdhci {
 	status = "okay";
 };
 
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vdd_3v3_sd>;
+	vqmmc-supply = <&vccio_sd_s0>;
+	status = "okay";
+};
+
 &spi2 {
 	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;
-- 
2.43.1


