Return-Path: <linux-kernel+bounces-15576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE8E822E59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CBDB224C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B31B28D;
	Wed,  3 Jan 2024 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DnOEVUJD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A162C199DE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 44FA13F74C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704288553;
	bh=j8polI0w/bjJ8tZqB1jGYw0XXYsOmvLZx8MNesRoCUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=DnOEVUJD7eMXhCK/MQ544wTYkmj+RRJXE3d2iW2RbveB84/P/NCR1RPnPu3zu05Gy
	 6cqnOjY0Hs5CEeJVpmcOMjEGTrSAxuTHHeXyBeM8cchni5s/iD7QIPUx66kKWUBT9y
	 xXrOpGRW8OywWbFo4qKCJbitCm9yBs7hspfEgRI3NxhcYhEFYy/EGvZ0yRSitznMFr
	 Yf9XuJErz/ye29V0YdJAcIZrXLmljwYljny4G7QYN5kIa/kBaMElmWoyokmAmlqNsV
	 qXh+RH/p9Bfe/ECOkMLpU+NcbI9bndeBNyALZTer6pjmeg8J0EyJbmUGBmJZ0mRv5I
	 Bn08yOnXV8nDQ==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2cce9d6ec6bso35251231fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288542; x=1704893342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8polI0w/bjJ8tZqB1jGYw0XXYsOmvLZx8MNesRoCUY=;
        b=tENjBeIGxEvaNyY9zA+Fj7FV0XlCK2PWd/LQP4BBy1YoVEeZQ1uuImPZq+OCehnt9H
         5agmmqDkl6ZaDnFIz28hK4oNp95VAVDYScMoUVI5DUqXyCafhoTEPi8lf0hywT9M0T+N
         7kZYZjmrDycDimnTADJgKnb218isgdMjjBA+W/q7K3+lIAnxaUXROFWEkTeg6oZILDux
         Aj0K73ZnRCFNblsVggFcqw9z2sEIXzGHEncfdAnwrp8WWqD0HtxjlxCgTJ3IKjl3PFo5
         IRCN/4il6xvMjJxNQyxljtjDcJzFQeME77hj1CNrkafbvZ93AqOdlq3WeN/h78FZZ1eY
         tySg==
X-Gm-Message-State: AOJu0YxeoZGoG9NS20w78lg6ETGhNY+CJRmfxXkoDbRmGhLRljpHoWta
	2QiwvfSKCbxqQ1nioGx819XkfxUOMVCsZAQvIdTMVWXGi25h4OGus4UM4k6YYy7fylXuzKw6M8x
	jJNb/8tLb9CczmmQgXsqF9xqSz6XcdM+EYHEUWQMxhYrRNLHkAIamz/zp
X-Received: by 2002:a05:6512:1145:b0:50e:3767:d381 with SMTP id m5-20020a056512114500b0050e3767d381mr7432129lfg.139.1704288541963;
        Wed, 03 Jan 2024 05:29:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJt4/P/j0GlWbqbKebsvHvV6+jrN2+ONRLeoH23443/k+kOFBIdKz9RoGU2lF8BDUFzg5rrQ==
X-Received: by 2002:a05:6512:1145:b0:50e:3767:d381 with SMTP id m5-20020a056512114500b0050e3767d381mr7432116lfg.139.1704288541775;
        Wed, 03 Jan 2024 05:29:01 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:5af0:999b:bb78:7614])
        by smtp.gmail.com with ESMTPSA id eu18-20020a170907299200b00a26e53be089sm9549873ejc.44.2024.01.03.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:29:01 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 8/8] riscv: dtb: thead: Add BeagleV Ahead LEDs
Date: Wed,  3 Jan 2024 14:28:45 +0100
Message-ID: <20240103132852.298964-9-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
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
index c697a50ca9b1..0b309c770202 100644
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
 
@@ -62,6 +99,24 @@ &dmac0 {
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
+			function = "gpio";
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
2.43.0


