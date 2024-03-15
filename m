Return-Path: <linux-kernel+bounces-104805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71587D3EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2472853A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96AA3B79E;
	Fri, 15 Mar 2024 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWR2a9a9"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1E4EB5F;
	Fri, 15 Mar 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528581; cv=none; b=TGAu2jmgdxAA3/JD1K73WYma6pHFm9ojU7V7Pvzi7PYO14pW1y37D0NKJgolGoHRdKXDCOZKxwRT3GVbYgb/JcrI6YNsvRP9p/8rWkEcRD4NeSaREw4RSWBGisjrIJ44zLojWv5Lk+j4WO9VD1hANTS85GqMu4Nt6zOwFaOv4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528581; c=relaxed/simple;
	bh=waEtilpQQJVRhO5jxW08zWdWbqvE0of0BgBfWiZthWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9UacBhdGZ7IPiimVYSmMJ9h27csSk99ao4Xq4uvzRAKYyebekGLnelXImdgHAqkV2SDwnWnzXlfYtuvaIKm8ST9N2qv8hTIT2XonQZKQGDLkdncTJlDnnQ5yWqV2KtU3gAgafniSFCzGvaHiGKfnTPVLBn2cdNpPR39wXQF8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWR2a9a9; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso1919461a12.0;
        Fri, 15 Mar 2024 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528577; x=1711133377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekuD/GR/ETK+oPLgoe3fsxeUCpWofF5b/ECIf7CXi9k=;
        b=GWR2a9a9GnE+stR3i8bHBUZ5C7QCeRmKsRSy12Ejr9OOiK+5RxkL1eJOFLwBGpGv6q
         GOcKUlCkyzeT5MwD3U5caDIYtbmbQRRVBJQLVwWYrBQIzOQ/8110rRW5yaFiiZf47lw0
         at3PFXxGrwlPIU+mi8IzIOxojrWbfd6e2DJG3/xPHH3zBFnGVqKBlzUebqyCRNxHsIYG
         sPakC/w+57wMYIztdfKWUhmkqqv+b5O4ux6inos9ViY6xmfO1NhwzKPu78i+lvfUac1t
         XOz++NLcmhz2a3QBZUaToJp3WaFttskyqUC32wCJKuqhHd2cEWabXjSjuahe4/GImpRj
         dkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528577; x=1711133377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekuD/GR/ETK+oPLgoe3fsxeUCpWofF5b/ECIf7CXi9k=;
        b=VvkJ+7On6QC1+DpJJjDqj80sdHVdo8M2zqG3aMPOtCV/0yLAya6jaDdu6wfsUmqK0v
         ak1EmNcX/t7kQA1WsjZO6M3TMigm1w8Qel3b10H4VYk4lixfgF51wnTy0O9pemBxUhO3
         SCTo1uif20XYEAWTCuDL0Ku4XTw+I6MhvagqbK9IbeVOuQFpWu8ikjdEMJOub86KL0sV
         di+Yy1AiayjxCyVPqnrJzMOpEgxAScIjja41F3F+bhZcET7cevTeXEnxWhVkBI/a3DZL
         DahQLquMDyzXwNtm7uN4ntsVPjrFQ+yyXMSM1Srk3Z4oyJ7ntyyApdR/g0m7f8gU4w9D
         pkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlaVzt3vgx4F0KYqNK6hyX8hN/qxvfvGOsPMQ3BHh5bpIoij8BRD2BbLBganXXrfk6f1AXKhVxnSy+d65li3pDIKxDpv2gFq8PU+JWN93zOMxYuJYcYENrpw/pBRDwTB0qOyPCJa/6DuD7u2GSkpQG3eiTSriWC0ThVGbq/u2fEC9Axw==
X-Gm-Message-State: AOJu0YxsFCRXn4EEMW7NuH/bInPy0f/c2lHFGK7E+BjW4LuiafNnaaSA
	/blVGp4w/GYfQHJ4ZjRMmmCkI5ZwsiCSwXIVj2IPoZagvyWVkCHHVvGGUZXfi0vMmQ==
X-Google-Smtp-Source: AGHT+IHqxtAsUgvo4NnLO1aRy+KdmDGkLoMtm8Lp1OEsLkEDiyduFba/9liT290O5AFXVR+nRAdYxw==
X-Received: by 2002:a05:6a21:3990:b0:1a1:7711:cb4d with SMTP id ad16-20020a056a21399000b001a17711cb4dmr4993623pzc.36.1710528576938;
        Fri, 15 Mar 2024 11:49:36 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a0022d100b006e6cc998be8sm3580784pfj.207.2024.03.15.11.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:49:36 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH v3 1/8] dt-bindings: misc: Add mikrobus-connector
Date: Sat, 16 Mar 2024 00:18:59 +0530
Message-ID: <20240315184908.500352-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315184908.500352-1-ayushdevel1325@gmail.com>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings for mikroBUS interface. MikroBUS is an open standard
developed by MikroElektronika for connecting add-on boards to
microcontrollers or microprocessors.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 .../bindings/misc/mikrobus-connector.yaml     | 110 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mikrobus-connector.yaml

diff --git a/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml b/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
new file mode 100644
index 000000000000..6eace2c0dddc
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/mikrobus-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: mikroBUS add-on board socket
+
+maintainers:
+  - Ayush Singh <ayushdevel1325@gmail.com>
+
+properties:
+  compatible:
+    const: mikrobus-connector
+
+  pinctrl-0: true
+  pinctrl-1: true
+  pinctrl-2: true
+  pinctrl-3: true
+  pinctrl-4: true
+  pinctrl-5: true
+  pinctrl-6: true
+  pinctrl-7: true
+  pinctrl-8: true
+
+  pinctrl-names:
+    items:
+      - const: default
+      - const: pwm_default
+      - const: pwm_gpio
+      - const: uart_default
+      - const: uart_gpio
+      - const: i2c_default
+      - const: i2c_gpio
+      - const: spi_default
+      - const: spi_gpio
+
+  mikrobus-gpios:
+    minItems: 11
+    maxItems: 12
+
+  i2c-adapter:
+    description: i2c adapter attached to the mikrobus socket.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  spi-controller:
+    description: spi bus number of the spi-master attached to the mikrobus socket.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  uart:
+    description: uart port attached to the mikrobus socket
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  pwms:
+    description: the pwm-controller corresponding to the mikroBUS PWM pin.
+    maxItems: 1
+
+  spi-cs:
+    description: spi chip-select numbers corresponding to the chip-selects on the mikrobus socket.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: chip select corresponding to CS pin
+      - description: chip select corresponding to RST pin
+
+required:
+  - compatible
+  - pinctrl-0
+  - pinctrl-1
+  - pinctrl-2
+  - pinctrl-3
+  - pinctrl-4
+  - pinctrl-5
+  - pinctrl-6
+  - pinctrl-7
+  - pinctrl-8
+  - i2c-adapter
+  - spi-controller
+  - spi-cs
+  - uart
+  - pwms
+  - mikrobus-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+      mikrobus-0 {
+        compatible = "mikrobus-connector";
+        status = "okay";
+        pinctrl-names = "default", "pwm_default", "pwm_gpio","uart_default", "uart_gpio", "i2c_default",
+                        "i2c_gpio", "spi_default", "spi_gpio";
+        pinctrl-0 = <&P2_03_gpio_input_pin &P1_04_gpio_pin &P1_02_gpio_pin>;
+        pinctrl-1 = <&P2_01_pwm_pin>;
+        pinctrl-2 = <&P2_01_gpio_pin>;
+        pinctrl-3 = <&P2_05_uart_pin &P2_07_uart_pin>;
+        pinctrl-4 = <&P2_05_gpio_pin &P2_07_gpio_pin>;
+        pinctrl-5 = <&P2_09_i2c_pin &P2_11_i2c_pin>;
+        pinctrl-6 = <&P2_09_gpio_pin &P2_11_gpio_pin>;
+        pinctrl-7 = <&P1_12_spi_pin &P1_10_spi_pin &P1_08_spi_sclk_pin &P1_06_spi_cs_pin>;
+        pinctrl-8 = <&P1_12_gpio_pin &P1_10_gpio_pin &P1_08_gpio_pin &P1_06_gpio_pin>;
+        i2c-adapter = <&i2c1>;
+        spi-controller = <&spi1>;
+        spi-cs = <0 1>;
+        uart = <&uart1>;
+        pwms = <&ehrpwm1 0 500000 0>;
+        mikrobus-gpios = <&gpio1 18 0> , <&gpio0 23 0>, <&gpio0 30 0> , <&gpio0 31 0>, <&gpio0 15 0>,
+                         <&gpio0 14 0>, <&gpio0 4 0> , <&gpio0 3 0>, <&gpio0 2 0>, <&gpio0 5 0>,
+                         <&gpio2 25 0>, <&gpio2 3 0>;
+      };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 375d34363777..69418a058c6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14767,6 +14767,12 @@ M:	Oliver Neukum <oliver@neukum.org>
 S:	Maintained
 F:	drivers/usb/image/microtek.*
 
+MIKROBUS
+M:	Ayush Singh <ayushdevel1325@gmail.com>
+M:	Vaishnav M A <vaishnav@beagleboard.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
+
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>
-- 
2.44.0


