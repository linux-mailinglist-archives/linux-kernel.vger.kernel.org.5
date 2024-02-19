Return-Path: <linux-kernel+bounces-72071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694B85AE97
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DF91C218D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46556776;
	Mon, 19 Feb 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="XO02EO3Z"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91654F88;
	Mon, 19 Feb 2024 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382124; cv=none; b=Ec8oD3Ib0GXTGKariNZIoFbKJyO5RIkAc9L55jiT1Wg+/l5hP9ljAE8lpBoRXyH+t6VtsaAzqYgvu84L0RFKF0V9BOcBbSWwwMOSUkwZWS6DfRRW3cQOu62K6FPJwxsZvYo6CdIx9kiTKdE8UKBTQNrs1hKUer2X2QKSXi1NXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382124; c=relaxed/simple;
	bh=syOmdfRytxiX/HKVSxNzcoLs0gcEIlM3vpEM9T4e5BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC0qgenXxUgsZpwNMs03ssryNLYxthIj6cGE9/86dq+Tt5T5GiakK6jabNcmEB6907yrik8Y4ksGCAxnbz8SE8cba1Iw5bFV1mtX8aRtbEldyE3b+m09hBlJpjSze+aSQNb2reodVP/tm83mtjJLvcnH2p9nveqwcQsIDVncG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=XO02EO3Z; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3285:0:640:fd1e:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id E7FB260FA0;
	Tue, 20 Feb 2024 01:35:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bYZIDNh7RSw0-9nfYeG6M;
	Tue, 20 Feb 2024 01:35:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1708382119; bh=4esHHPB8QRrp0Iemcf6FHGQ6BZdQ9YtoicpK0U4GrhM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=XO02EO3ZIyNk2n+j94csTnSD72YDrZtTmKwAN3Kjo8JS7bEIeneV4MehIV7ObDD7J
	 1PpZdTVrI80RsISeBTo/QUSFy2oDxY63Y7/ivDgnv+aXstdFnkfyjuQW5XXQM0WhZH
	 ML+av7TcBA+YT/DcWbIIAYYYeqygpbfY7j5QZadk=
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
Subject: [PATCH 5/9] arm64: dts: rockchip: Add ir receiver and leds to Khadas Edge 2
Date: Tue, 20 Feb 2024 01:34:21 +0300
Message-ID: <335629f57e593e20418a4a55a1e662505640cbde.1708381247.git.efectn@protonmail.com>
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

Khadas Edge 2 exposes IR receiver pins as same as TF card via EXTIO. The
IR receiver is connected to MCU and SoC.

The board also has 2 PWM RGB leds. One is controlled by MCU and the
other is controlled by SoC. This commit adds support for the led
controlled by SoC using pwm-leds.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index ea7f1bb7c908..5a3b52e62dce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/leds/common.h>
 #include "rk3588s.dtsi"
 
 / {
@@ -19,6 +20,47 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_receiver_pin>;
+	};
+
+	leds {
+		compatible = "pwm-leds";
+
+		red_led: led-0 {
+			label = "red_led";
+			linux,default-trigger = "none";
+			default-state = "off";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_RED>;
+			max-brightness = <255>;
+			pwms = <&pwm11 0 25000 0>;
+		};
+
+		green_led: led-1 {
+			label = "green_led";
+			linux,default-trigger = "default-on";
+			default-state = "on";
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_GREEN>;
+			max-brightness = <255>;
+			pwms = <&pwm14 0 25000 0>;
+		};
+
+		blue_led: led-2 {
+			label = "blue_led";
+			linux,default-trigger = "none";
+			default-state = "off";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_BLUE>;
+			max-brightness = <255>;
+			pwms = <&pwm15 0 25000 0>;
+		};
+	};
+
 	vcc5v0_sys: vcc5v0-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
@@ -181,6 +223,12 @@ vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	ir-receiver {
+		ir_receiver_pin: ir-receiver-pin {
+			rockchip,pins = <1  RK_PA7  RK_FUNC_GPIO  &pcfg_pull_none>;
+		};
+	};
 };
 
 &pcie2x1l2 {
@@ -191,6 +239,24 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pwm11 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm11m1_pins>;
+	status = "okay";
+};
+
+&pwm14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm14m1_pins>;
+	status = "okay";
+};
+
+&pwm15 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm15m1_pins>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	no-sdio;
-- 
2.43.1


