Return-Path: <linux-kernel+bounces-759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F658145A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7BE2853C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3041C2BD;
	Fri, 15 Dec 2023 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n2SUDFzs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74325208BD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33642ab735dso361819f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702636331; x=1703241131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0vxSZ9RvxjYOzxMLTC82yIpjyAij/ySbPoNuVAOnVc=;
        b=n2SUDFzs4UsriIJm0d/7roV2+AaFTVoW98MhnZiSZg9+ssNWei5VX8kgAlvri5zwF+
         li4QQR4RgojWhik9zpvi0/Hk/TXcbG1xSm0xU1v7f9pkYXlKqQ1MJDh+1yn6SAgdkrFG
         ML8k7esu33UZvQv7ZaXb0GHT7CQmm/viiquVZH5ISdaI2KI1nGGds6ZmZfEGVMK/83Pk
         P9hamtZNSPwH7HKNmbochwwcHYjbRMAY3+e6yDDRU7OvRXIdh0l6HRCVs+HxneKC4R9L
         hZLMpFIvH7LWhzWFw9UDSYv7icNwGnAlgealQL1KsYsuZ9H4BCgibynOqSL7v1QiPPD2
         pUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702636331; x=1703241131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0vxSZ9RvxjYOzxMLTC82yIpjyAij/ySbPoNuVAOnVc=;
        b=nwIPuHcoSKgKr/jC5E0r0X4nvJvzY2UCB/LtwtFf0kUoBOJIfw0/ZbDFQRGA0wLkZf
         dFcdLxqB4f98AvT9vDP1ve4FlHiqac9g4AKnCHSg0IaspYzEMSoVvizY5sUQjSVQgAvo
         lzdJ6qF5D27kNllJHs9jVm7lKURWvBUktu5nyUhMgOpQ6/lprcdAyPcJ5gZZx4qWDL8Z
         ZzXmB+6t0THLANSgWa/r0beSsKb9blMkOx7NvTCwL936HvdZJ1PaSvPrOC+DZom0Hr38
         2dbM3JkYTZdss82w8xRhRr0rr75QQVQpVQJXkloEZqyu6uKy0pAmtcLOVPxEdJtu6f7C
         9o0w==
X-Gm-Message-State: AOJu0YznXF/JWj02zKsRF+Ec7Vq7ohZhBdkF2iYF+X5qmUNI/0gtyaML
	/L3fuKBTHEVsiNegkr+OMhb78w==
X-Google-Smtp-Source: AGHT+IEOOzxRXGV1KZ0ZURPlNdzksXFIi0QgWxDIMIyw6Tr1CG06Vcl6zRkqiJlkf7gxnqX8FFeMAA==
X-Received: by 2002:a5d:430d:0:b0:333:130d:4311 with SMTP id h13-20020a5d430d000000b00333130d4311mr2749859wrq.52.1702636331594;
        Fri, 15 Dec 2023 02:32:11 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id q11-20020adffecb000000b003332db7d91dsm18421015wrs.39.2023.12.15.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 02:32:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/3] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Date: Fri, 15 Dec 2023 04:32:03 -0600
Message-Id: <20231215-ad7380-mainline-v3-2-7a11ebf642b9@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a binding specification for the Analog Devices Inc. AD7380
family of ADCs.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 107 +++++++++++++++++++++
 MAINTAINERS                                        |   9 ++
 2 files changed, 116 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
new file mode 100644
index 000000000000..43d58c52f7dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7380.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices Simultaneous Sampling Analog to Digital Converters
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  * https://www.analog.com/en/products/ad7380.html
+  * https://www.analog.com/en/products/ad7381.html
+  * https://www.analog.com/en/products/ad7383.html
+  * https://www.analog.com/en/products/ad7384.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7380
+      - adi,ad7381
+      - adi,ad7383
+      - adi,ad7384
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 80000000
+  spi-cpol: true
+  spi-cpha: true
+
+  spi-rx-bus-channels:
+    description:
+      In 1-wire mode, the SDOA pin acts as the sole data line and the SDOB/ALERT
+      pin acts as the ALERT interrupt signal. In 2-wire mode, data for input A
+      is read from SDOA and data for input B is read from SDOB/ALERT (and the
+      ALERT interrupt signal is not available).
+    enum: [1, 2]
+
+  vcc-supply:
+    description: A 3V to 3.6V supply that powers the chip.
+
+  vlogic-supply:
+    description:
+      A 1.65V to 3.6V supply for the logic pins.
+
+  refio-supply:
+    description:
+      A 2.5V to 3.3V supply for the external reference voltage. When omitted,
+      the internal 2.5V reference is used.
+
+  interrupts:
+    description:
+      When the device is using 1-wire mode, this property is used to optionally
+      specify the ALERT interrupt.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+  - vlogic-supply
+
+allOf:
+  - if:
+      required:
+        - spi-rx-bus-channels
+    then:
+      if:
+        properties:
+          spi-rx-bus-channels:
+            const: 2
+      then:
+        properties:
+          interrupts: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7380";
+            reg = <0>;
+
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <80000000>;
+
+            interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio0>;
+
+            vcc-supply = <&supply_3_3V>;
+            vlogic-supply = <&supply_3_3V>;
+            refio-supply = <&supply_2_5V>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fe1f6f97f96a..e2a998be5879 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -430,6 +430,15 @@ W:	http://wiki.analog.com/AD7142
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/misc/ad714x.c
 
+AD738X ADC DRIVER (AD7380/1/2/4)
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	David Lechner <dlechner@baylibre.com>
+S:	Supported
+W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+
 AD7877 TOUCHSCREEN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported

-- 
2.34.1


