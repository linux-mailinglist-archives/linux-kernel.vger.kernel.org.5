Return-Path: <linux-kernel+bounces-1119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01D814ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15259285D32
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723773DB83;
	Fri, 15 Dec 2023 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rgEU2+8b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E8358A8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0FBF33F746
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702651160;
	bh=sqnkwNJyx4Y3XZP1ctBo+dwvCXDcRgLVJAObMWMc4no=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=rgEU2+8bHiexwoF/wJDklvHF2ff54gxNGsk3RG68+R/ZrFXJMG1wTv/e2IWFTbTmc
	 pSuEHLWnRgZdLK162TWxS1zGk0As1mgqQtin7FhPnqtILZ3Hhbep5ddZe2zqxs0qDH
	 J0oxZ26l1ZClvVt74ZXKdo6tu/LrWdpJJRTvuGoGuXLhEQwgBH+wQDDoWsmEiQUu/k
	 GUOVaiNa8R2gPsUFIXxkoLlgxZ48/XXbaXZzpkm+tmFIU3Ekxm9sUFt4AVTwNBylNX
	 N0cncReRWnOu/9366sm/oQ5ZRwdULliSOlwMWky/pPQfB0+v5OQFsXSpc6ZcnQEyQ5
	 LQuaKuOTjVkXA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a19c5cbbe86so46677266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651159; x=1703255959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqnkwNJyx4Y3XZP1ctBo+dwvCXDcRgLVJAObMWMc4no=;
        b=FmKLZcCanD1XiPOjTZXsHm5fJejeOsNAiNXpohj6d/0+sgo8tEa3MwhjFAEfA0/M1a
         8OsEUYYOlVVbSM7oi00uP/W9/87qEcEBjR3pW6QcgQM3Fqv4CwmgRgIjPBlNO609Wx+9
         O/MXguzcmVENbsPpITDiuKgd1kOR9IqspbNvKpzFaAaBOhGS+C8ohNmPV2VUBetQymAg
         XmddiCAAxZzn7mLCPlgO36lDW+CoG1UaqniXvVF37ohu+3oJrvwcWg35QlrDYYwQqEsX
         nTAHJskAIsEb1su5NffT/9ntcE8qxb3MmLi9ZncgBKKMJYmedVr+w+YN9Bbj38Up07RF
         2myg==
X-Gm-Message-State: AOJu0YwtJu6ASoPtiI/N62/B2KhpFHplHnk26La1UE7bQSyxkdBu0zN2
	n6wktxftVvCkhKhJPWJf2dwScFM+KoxAvfrMVr+J4TOK/e02gFq8jcn18d4npQMUZX1g3KRVZhq
	07Kf+V7WrCGRptLREo3Obkdc4OxIlkmVwxQiobEdUNQ==
X-Received: by 2002:a17:906:2082:b0:a23:105c:4c58 with SMTP id 2-20020a170906208200b00a23105c4c58mr840388ejq.101.1702651159546;
        Fri, 15 Dec 2023 06:39:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdZavjGi1n85oMXyfE7FfrDma/NmyRnykjf5VznoZdUOncAJuIX1TOejqRPUe7VuV7Judxgw==
X-Received: by 2002:a17:906:2082:b0:a23:105c:4c58 with SMTP id 2-20020a170906208200b00a23105c4c58mr840384ejq.101.1702651159359;
        Fri, 15 Dec 2023 06:39:19 -0800 (PST)
Received: from stitch.. ([152.115.213.158])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm10789122ejc.73.2023.12.15.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:39:18 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v1 8/8] riscv: dtb: thead: Add BeagleV Ahead LEDs
Date: Fri, 15 Dec 2023 15:39:06 +0100
Message-Id: <20231215143906.3651122-9-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nodes for the 5 user controllable LEDs on the BeagleV Ahead board.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../boot/dts/thead/th1520-beaglev-ahead.dts   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 54d86aab6656..35585eff6ab3 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -7,6 +7,8 @@
 /dts-v1/;
 
 #include "th1520.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "BeagleV Ahead";
@@ -34,7 +36,42 @@ chosen {
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0  0x00000000  0x1 0x00000000>;
+	};
 
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+		compatible = "gpio-leds";
+
+		led-1 {
+			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led1";
+		};
+
+		led-2 {
+			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led2";
+		};
+
+		led-3 {
+			gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led3";
+		};
+
+		led-4 {
+			gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led4";
+		};
+
+		led-5 {
+			gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led5";
+		};
 	};
 };
 
@@ -58,6 +95,24 @@ &dmac0 {
 	status = "okay";
 };
 
+&padctrl_aosys {
+	led_pins: led-0 {
+		led-pins {
+			pins = "AUDIO_PA8",  /* GPIO4_8 */
+			       "AUDIO_PA9",  /* GPIO4_9 */
+			       "AUDIO_PA10", /* GPIO4_10 */
+			       "AUDIO_PA11", /* GPIO4_11 */
+			       "AUDIO_PA12"; /* GPIO4_12 */
+			function = "3";
+			bias-disable;
+			drive-strength = <3>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+};
+
 &padctrl0_apsys {
 	uart0_pins: uart0-0 {
 		tx-pins {
-- 
2.40.1


