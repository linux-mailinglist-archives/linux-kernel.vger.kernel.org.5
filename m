Return-Path: <linux-kernel+bounces-20078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D882790B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3101C23050
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9CD54FB7;
	Mon,  8 Jan 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DjY6wFQW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798355E50
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so3969854a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704744987; x=1705349787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6lTYGwOZkH/q3mVT10Wfxgf2APvMbHICMTqCuHaYlQ=;
        b=DjY6wFQW3LhX9PezQ2OplLYWgcy2hI/cSii4x61bmpleZrLLcQEbXwbppxMo2XTqSS
         XjsU1x3h2g1j+tLyuN9NumQMUJUsBMQkyb5ODrE2/6SoC8bvyttc3xdwJ2aallPUuJoq
         c0vTMHPiVzLwPh7FSp5qHqUQKBWDtTB39wqb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704744987; x=1705349787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6lTYGwOZkH/q3mVT10Wfxgf2APvMbHICMTqCuHaYlQ=;
        b=BVIAJzO0UjxGMd31QJxY6RDg9Rl8qOQS4fIuirzmyAdC2lls1Yxrno/PjSakeVtZg7
         M0jwsVC6k988hLPtLdMmpT83iaEoVmYjowWIbNU/qDDXK4srGOb0RHuuJqIdAu0HZK9y
         w7Zte+XB63B+yQCamMYULdZOhqQ8wDvG30D1RxoV7+qT6xvfH0IDw9Uq3oMnzNjsjRfu
         ytmtD/2rUcxnXRnqWLOUWZvqNVfjFbyKaxvP/Lar57Cs/co15fgqFqdYMAOvXnhw1Fd6
         nR3hn+Ll7UkkAaFjwbIeEsjuTIsPYBAeE4I0jYS1/TNsJ2U78Pko+Zsjz33OG+My/PZO
         6drQ==
X-Gm-Message-State: AOJu0YylRe+pieEa6h2D/DSvNBFX11aXxT438otKBSvKWkLp5rqEO4cv
	F23tZoLFqnEtnYFhhL/I/XPHZD2SrqBZgZMaPBcOWLZPo4Q=
X-Google-Smtp-Source: AGHT+IH571bHgLenmr1+KWUBb4GbCe9fNk/ox6ov48UEPndOfewqWXbJLWttw2GX2aE8VnQZLowacw==
X-Received: by 2002:a05:6402:7c2:b0:557:7501:4242 with SMTP id u2-20020a05640207c200b0055775014242mr288476edy.12.1704744986947;
        Mon, 08 Jan 2024 12:16:26 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-2-38-81.retail.telecomitalia.it. [87.2.38.81])
        by smtp.gmail.com with ESMTPSA id by26-20020a0564021b1a00b00555fd008741sm173699edb.95.2024.01.08.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:16:26 -0800 (PST)
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
Subject: [PATCH v5 4/8] ARM: dts: stm32: add display support on stm32f769-disco
Date: Mon,  8 Jan 2024 21:15:49 +0100
Message-ID: <20240108201618.2798649-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108201618.2798649-1-dario.binacchi@amarulasolutions.com>
References: <20240108201618.2798649-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

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


