Return-Path: <linux-kernel+bounces-13109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C5581FFD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D4D1C218DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90012B72;
	Fri, 29 Dec 2023 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cleI8mmO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D9125A7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso3980057e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 05:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703857944; x=1704462744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gga6jIGQV6Uokv7TaAQoZWe7KKBaoCfGdy4Mk3xFQ7I=;
        b=cleI8mmO9wfr40KowC+LY6/gFV5ua71ij4/gh9NQTtRO+2cPap6wbqTNqZMBo7ayDx
         qNPd0maGyJ4fg7D7Gcdbk1QTk+WkhJXHBexCXzvJvO8k4EZViMJlf0jkLl++JVpm0d+O
         Cl/Fp8Dhb9mAttNWUsU1vM9LvvOp/Rkp0/3mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703857944; x=1704462744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gga6jIGQV6Uokv7TaAQoZWe7KKBaoCfGdy4Mk3xFQ7I=;
        b=utcSbNRhpAuGmzdS3KsQAxy0/WOjirYjYx1vzmo8wYQxmdfC7+aAoU/vKzzD/+Rn1u
         te+YYD1kEpJx2gN2Q3wyXKGotmopbdprzeeN1B9HrbBeNKUVTGG/OqvEnpp4RpAkLyGW
         QKBoZ0Hsb+Et8xVpliFSIczb8WxQR/PT/BgKp5AGvNDZl16jxv+jd3gkS6OPVnK4x/rp
         tDiDVdS8hryqJEtwHPvXRsm3CvBJzrTmYdIFZ1s/TGORhuP0fwOpSK5oAwcpmxYpZA5f
         piZ/763Ki9bVqwg2O/qoD9Vy+T0a/ZjE8FuK1HEjx1JfQRQ3nq52OlcZErqabCbPk5Dq
         4Kvw==
X-Gm-Message-State: AOJu0YzeZFeQ9hUlH4Ko+7QYiCd6rU28pJwz5WwE6rB4Yw9PTUvLDNq1
	yB7+2XjyemCEHJbkyuyMCazZ5DOT+T2zE9q2xxmrWgqIfoE=
X-Google-Smtp-Source: AGHT+IHNAEoW0q0mjbjPSGB46KYuu5mIa90Db/GV3FTHiOapSVcv/6o3ENSX54ym79nKR8N+QMFyiA==
X-Received: by 2002:ac2:5e6a:0:b0:50e:935a:b682 with SMTP id a10-20020ac25e6a000000b0050e935ab682mr221610lfr.45.1703857943769;
        Fri, 29 Dec 2023 05:52:23 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-49-57-70.retail.telecomitalia.it. [79.49.57.70])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c710000000b00553b243b1a8sm11019160edq.92.2023.12.29.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 05:52:23 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 4/8] ARM: dts: stm32: add display support on stm32f769-disco
Date: Fri, 29 Dec 2023 14:51:19 +0100
Message-ID: <20231229135154.675946-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch adds display support on the stm32f769-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/st/stm32f769-disco.dts | 72 +++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 8632bd866272..d1eb5f9c78bf 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -41,7 +41,7 @@
  */
 
 /dts-v1/;
-#include "stm32f746.dtsi"
+#include "stm32f769.dtsi"
 #include "stm32f769-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -60,6 +60,19 @@ memory@c0000000 {
 		reg = <0xC0000000 0x1000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,dma {
+			compatible = "shared-dma-pool";
+			linux,dma-default;
+			no-map;
+			size = <0x100000>;
+		};
+	};
+
 	aliases {
 		serial0 = &usart1;
 	};
@@ -85,6 +98,13 @@ button-0 {
 		};
 	};
 
+	panel_backlight: panel-backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpioi 14 GPIO_ACTIVE_HIGH>;
+		default-on;
+		status = "okay";
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
@@ -114,6 +134,46 @@ &clk_hse {
 	clock-frequency = <25000000>;
 };
 
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dsi_in: endpoint {
+				remote-endpoint = <&ltdc_out_dsi>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dsi_out: endpoint {
+				remote-endpoint = <&dsi_panel_in>;
+			};
+		};
+	};
+
+	panel0: panel-dsi@0 {
+		compatible = "orisetech,otm8009a";
+		reg = <0>; /* dsi virtual channel (0..3) */
+		reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
+		power-supply = <&vcc_3v3>;
+		backlight = <&panel_backlight>;
+		status = "okay";
+
+		port {
+			dsi_panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-0 = <&i2c1_pins_b>;
 	pinctrl-names = "default";
@@ -122,6 +182,16 @@ &i2c1 {
 	status = "okay";
 };
 
+&ltdc {
+	status = "okay";
+
+	port {
+		ltdc_out_dsi: endpoint@0 {
+			remote-endpoint = <&dsi_in>;
+		};
+	};
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.43.0


