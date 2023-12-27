Return-Path: <linux-kernel+bounces-12031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36FB81EF18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44132283093
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7139044C7B;
	Wed, 27 Dec 2023 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hiV6n+4q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75FD45961
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336c9acec03so1593440f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 05:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1703682510; x=1704287310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ocsSiEqBdtanIffaaT52Hpat/4WnkDj2kMGWbB3pX8E=;
        b=hiV6n+4q8Z0ZFX2ngX+LspAOsc5eVlPs0eU7Crk1XUHoFi5u4/paBB3Zspkf/NPIpj
         uVC3JxdQoSJJXSzYr/1ZtEoEKSzy/0MzBeTrLDmjp6vROdjmyPbp1u6qLf3Fng/tcewk
         yBgDIsP30+CBRDqjFdIgJVi4LpCUHEKzYkD1JhuLjDiq+AmVSnf4Ibb0tN01DEXqW3Tx
         RvcL7KUNN00NYV17+LJIdytKap7f+qCdUSngiz3FD1Ueu93W4aepWrTqR4l2PGxZYdDm
         /iP1XAeXi+nLPmn4SQdlN74VsLH3MasRlkiCFqDAfpyShUG+k3TMbsSf/WLyCXChho5f
         58ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703682510; x=1704287310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocsSiEqBdtanIffaaT52Hpat/4WnkDj2kMGWbB3pX8E=;
        b=nnN5zcposafRTyc18uVFKTN7mff+5C2+iIohiAOu4Ww/Gey8LgTYLMHqvYcyTAmCgF
         tnp7etEXseGwzDh1Rk7uc13V4+aG0qUhpGslaFF0XW03v8UxcbU6BCsSrBF03z/E0Zqc
         7Y72jvpfnHbIenNIo44edGcDpbTcD8BcImB0id257L2ac7qvYqFM7cPjFvEdys+RuH0p
         6nLG9hdBZLabiKNgthQV3h1i+pNjDcTO+JH5GUH4T8UA/BCdaqTlM/eI5K17WUFzvSvh
         LXiVpozwCsiLA+w3SrSxUCvRkuQ7vrHHcen8VRzvMzr39zltEGw/PLejiG5vynW2COiT
         7hig==
X-Gm-Message-State: AOJu0YzxP70NzIJHzKLXg4rPoGu0mjfhgXP7qaN/2w9XvQyC74DNgyOl
	SRPPNSWqdPf/CACrNS6iTy8FdsMtd/oVNg==
X-Google-Smtp-Source: AGHT+IFqg6rBequ445Nl+pCxjvGGT3EEDoFOIFQGo8u/WAIGCWjYYgshK4g+8oDoULLXedhnF5ap4Q==
X-Received: by 2002:a5d:6d06:0:b0:336:c159:d3df with SMTP id e6-20020a5d6d06000000b00336c159d3dfmr3250890wrq.87.1703682509846;
        Wed, 27 Dec 2023 05:08:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id c6-20020adfe706000000b0033342338a24sm14906263wrm.6.2023.12.27.05.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 05:08:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: rzg3s-smarc: Add gpio keys
Date: Wed, 27 Dec 2023 15:08:10 +0200
Message-Id: <20231227130810.2744550-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ SMARC Carrier II board has 3 user buttons called USER_SW1, USER_SW2,
USER_SW3. Add a DT node in device tree to propertly instantiate the
gpio-keys driver for these buttons.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 214520137230..deb2ad37bb2e 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 / {
@@ -14,6 +15,37 @@ aliases {
 		mmc1 = &sdhi1;
 	};
 
+	keys {
+		compatible = "gpio-keys";
+
+		key-1 {
+			interrupts = <RZG2L_GPIO(18, 0) IRQ_TYPE_EDGE_FALLING>;
+			interrupt-parent = <&pinctrl>;
+			linux,code = <KEY_1>;
+			label = "USER_SW1";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-2 {
+			interrupts = <RZG2L_GPIO(0, 1) IRQ_TYPE_EDGE_FALLING>;
+			interrupt-parent = <&pinctrl>;
+			linux,code = <KEY_2>;
+			label = "USER_SW2";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-3 {
+			interrupts = <RZG2L_GPIO(0, 3) IRQ_TYPE_EDGE_FALLING>;
+			interrupt-parent = <&pinctrl>;
+			linux,code = <KEY_3>;
+			label = "USER_SW3";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+	};
+
 	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHI1 Vcc";
@@ -35,6 +67,27 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 };
 
 &pinctrl {
+	key-1-gpio-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(18, 0) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "key-1-gpio-irq";
+	};
+
+	key-2-gpio-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(0, 1) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "key-2-gpio-irq";
+	};
+
+	key-3-gpio-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(0, 3) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "key-3-gpio-irq";
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
-- 
2.39.2


