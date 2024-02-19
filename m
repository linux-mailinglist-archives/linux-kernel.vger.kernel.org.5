Return-Path: <linux-kernel+bounces-72073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4DF85AE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86882833C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E1156B8B;
	Mon, 19 Feb 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="Badhxm+I"
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0353E30;
	Mon, 19 Feb 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382131; cv=none; b=LinLhY+9v1Sh5Y4VAnG1rGNoPgOCGd4+AokLy7QgQIKjJe9scTj+85GTFzFWMbyypcr6oyEyvfdvxIkaScK4p9P8JjQoSEQyhC/1ZpzGKF5czI4LQvOL1H74LKxK4bEYRPHhkv6GGOS6s4Qp262NkCqkcz0+WFwB+SFHWxGazyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382131; c=relaxed/simple;
	bh=eMg/ntcnSGsveyRs2+mVAGmH9JL2cC6ThpMt223qU+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkFK6ElkTYxhj8sQdNbOw9vsv+lkUhctlXy9NE6dKG4+H04mh1gcniuMqmfo4wKKAAA4NkdktOQjyl6KWogyu6ceGATD/i0MDI4soD+CXP+JGbafirVPeYiHi82C9xJnozOZuaJZOKv20ycRWFZt+X+n1BfOZ014z+f8BC9ozLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=Badhxm+I; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3285:0:640:fd1e:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id 5B18F60EFA;
	Tue, 20 Feb 2024 01:35:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bYZIDNh7RSw0-9HqUFJ1q;
	Tue, 20 Feb 2024 01:35:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1708382121; bh=ueyLOZc7B83IQ6uzxnld32qnUQjpyIZJagirXKNDJ58=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Badhxm+Iu1+MfBrvQtqg5tRId7aDKWdDmWMqIlj6HmK6nt+bLoeN7af88cxe7X0RQ
	 tEU9FBhUpqDsLFjqx93Hi9bCiC5FT3FiAe7STBzCr0Vw9/3pfYfEgC8sdQLVjYNyS8
	 X+OV8jYps0ouEz/mwSV/9zby15Eq9Fmv5mccmeCE=
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
Subject: [PATCH 6/9] arm64: dts: rockchip: Add saradc and adc buttons to Khadas Edge 2 and enable tsadc
Date: Tue, 20 Feb 2024 01:34:22 +0300
Message-ID: <03feaafefd0c13268ba1630251558749654a567d.1708381247.git.efectn@protonmail.com>
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

This commit enables tsadc, saradc and the
function button on saradc line for Khadas Edge 2.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 5a3b52e62dce..dfcdbec3534d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -3,6 +3,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/leds/common.h>
 #include "rk3588s.dtsi"
@@ -20,6 +21,20 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-function {
+			label = "Function";
+			linux,code = <KEY_FN>;
+			press-threshold-microvolt = <17000>;
+		};
+	};
+
 	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_LOW>;
@@ -257,6 +272,11 @@ &pwm15 {
 	status = "okay";
 };
 
+&saradc {
+	vref-supply = <&avcc_1v8_s0>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	no-sdio;
@@ -604,6 +624,10 @@ regulator-state-mem {
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
-- 
2.43.1


