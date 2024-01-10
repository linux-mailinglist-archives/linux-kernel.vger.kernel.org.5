Return-Path: <linux-kernel+bounces-22675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D982A154
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8709FB23110
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280C14F603;
	Wed, 10 Jan 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nooHw6Bw"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980D4EB46
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5989add5511so500082eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916273; x=1705521073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxwuK84w923F+g+Vt8AcwM39UH7HsN98gaGyRuSrYT0=;
        b=nooHw6Bw+oo7gGwZ0e+OXaV63hLdzwuhAFVPwdLJ+J6Q7hO2B6OEDEt1WlHPKM1U0v
         STcz4y+lFqp0rfW8QkiW2ec+ijvVt2YP49GnGz9RyICdZ05pz9KS9Um+aCIbgaAwZGEp
         JwJx0qEJoAwnF2V8R7tQQ21+ta/+br44wDRgaW1m6k7vLtsYRZVps+g1Fp62GcyX5wl8
         wFi5bQWiYHk4CPJcoLaUJeny9f1LT5H7F1vqFEqjkG3xAgov6eOX0RVSy0zKtAWoR1R1
         ckqo8+920CM3FJsGMk6rfqzPhMxBhuhgUmH9mOWNJJI08RqAZ9OnPe+OKL4Ly48z4/XJ
         7odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916273; x=1705521073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxwuK84w923F+g+Vt8AcwM39UH7HsN98gaGyRuSrYT0=;
        b=JevBKxj8st8GmmYzHgHmrO0NtakqmjlNrkicD/JiCKzFvO70N3DIC6kJF7/xPx9MKf
         2xi1PT0JY7/Bw6LaqBG4S480/j1tgJcmpHg/XVxm4mZZNTE1gMbC413K8yE1HylCBGDJ
         Gj3Ef6j5nMYcqZfceL9vjHJ3RaMMxMNx4XERabPgCvmg2rT/ETTBwp9TkWgPHA0ntEST
         WTB3LJNEww7Tth6vSYEqrN4N+7SdTOqFYEprTzTNC7Hxrz9F5OsvDozGkMLtckBHdZVV
         00SD12rgDoF/+d8qBOOhU803gkZJD2fVV8MhcLVLv/yz39D9/szhGGudasFxh3+q7Li7
         NW5w==
X-Gm-Message-State: AOJu0Yx2Mw6gU58lSM8rIigzkLZXk1u2DKlyT3T918jUXqycZ5dg2CBo
	UjS+4bRTULJ50JIakvV8bH9oJ/WzXtxqVA==
X-Google-Smtp-Source: AGHT+IGJ+O/PYxjqHIL/1LHHTnKjU7G2qVmk8BAvyUKQ/5nDAwbS6rdUFjjZNIceJMm0d4HdbWXbjQ==
X-Received: by 2002:a4a:5888:0:b0:598:8f50:d37e with SMTP id f130-20020a4a5888000000b005988f50d37emr94684oob.16.1704916272986;
        Wed, 10 Jan 2024 11:51:12 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Frank Rowand <frowand.list@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] spi: dt-bindings: adi,axi-spi-engine: add offload bindings
Date: Wed, 10 Jan 2024 13:49:45 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-4-e42c6a986580@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The ADI AXI SPI Engine driver supports offloading SPI transfers to
hardware. This is essentially a feature that allows recording an
arbitrary sequence of SPI transfers and then playing them back with
no CPU intervention via a hardware trigger.

This adds the bindings for this feature. Each SPI Engine instance
can have from 0 to 32 offload instances. Each offload instance has a
trigger input and a data stream output. As an example, this could be
used with an ADC SPI peripheral. In this case the trigger is connected
to a PWM/clock to determine the sampling rate for the ADC and the output
stream is connected to a DMA channel to pipe the sample data to memory.

SPI peripherals act as consumers of the offload instances. Typically,
one SPI peripheral will be connected to one offload instance. But to
make the bindings future-proof, the property is an array.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../spi/adi,axi-spi-engine-peripheral-props.yaml   | 24 +++++++++++
 .../bindings/spi/adi,axi-spi-engine.yaml           | 49 +++++++++++++++++++++-
 .../bindings/spi/spi-peripheral-props.yaml         |  1 +
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine-peripheral-props.yaml
new file mode 100644
index 000000000000..19b685fc3b39
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine-peripheral-props.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/adi,axi-spi-engine-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral properties for Analog Devices AXI SPI Engine Controller
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+properties:
+  adi,offloads:
+    description:
+      List of AXI SPI Engine offload instances assigned to this peripheral.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 32
+    items:
+      items:
+        - minimum: 0
+          maximum: 31
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
index d48faa42d025..69f3261bab47 100644
--- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
@@ -21,6 +21,23 @@ maintainers:
 allOf:
   - $ref: /schemas/spi/spi-controller.yaml#
 
+$defs:
+  offload:
+    description:
+      Describes the connections of the trigger input and the data output stream
+      of one or more offload instances.
+
+    properties:
+      reg:
+        description:
+          Index of the offload instance.
+        items:
+          - minimum: 0
+            maximum: 31
+
+    required:
+      - reg
+
 properties:
   compatible:
     const: adi,axi-spi-engine-1.00.a
@@ -41,6 +58,22 @@ properties:
       - const: s_axi_aclk
       - const: spi_clk
 
+  offloads:
+    type: object
+    description: Zero or more offloads supported by the controller.
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^offload@[0-8a-f]+$":
+        type: object
+        $ref: '#/$defs/offload'
+
 required:
   - compatible
   - reg
@@ -62,5 +95,19 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        /* SPI devices */
+        offloads {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            offload@0 {
+                compatible = "adi,example-offload";
+                reg = <0>;
+            };
+        };
+
+        adc@0 {
+            compatible = "adi,example-adc";
+            reg = <0>;
+            adi,offloads = <0>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 1c8e71c18234..7beb5a3798a5 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -132,6 +132,7 @@ properties:
 
 # The controller specific properties go here.
 allOf:
+  - $ref: adi,axi-spi-engine-peripheral-props.yaml#
   - $ref: arm,pl022-peripheral-props.yaml#
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
   - $ref: samsung,spi-peripheral-props.yaml#

-- 
2.43.0


