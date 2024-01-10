Return-Path: <linux-kernel+bounces-22729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2C982A23F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF151F23025
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21D4F1F8;
	Wed, 10 Jan 2024 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v5DAHdyb"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D644EB2F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-20503dc09adso3040444fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704918560; x=1705523360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JXksM7CDCG/lkWMAjBejDKWK/w9upChSXLmiJsLKPw=;
        b=v5DAHdyb0YSQaVyt0RNMCBVCPAbK3DkIG2TGl1FVocSV2CkMnLX72xmW8xQBt96Pcf
         2bDDeCPvROTE2BeC3JKmvGDrWzTzbRXqk2M0XSUc/oQUr+14XO6iZRVTL6OfTHrEr+RN
         Euf11gtsdMToWNKRfZkiZ6t+vwsYMvcOEZhM9ymYItDTTp1RJiPG/qxCHDTXXW3Xh1cU
         fJGG7LvxhKKvZIg/8cJR519wP3111LcP3nfmHkOfaJmNi+9cOthLPSYfSjZUhp+dUrUo
         1z5uw1as4CxeqHLhGbhxqmfDxB6d74rTu1afD61sQbdGEh+XcOR+qhnYJWwlTRE6I5bc
         z/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704918560; x=1705523360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JXksM7CDCG/lkWMAjBejDKWK/w9upChSXLmiJsLKPw=;
        b=dFl6Sk8iQMluP/jDVoY0LuhO+mw6jVpndJBgDQrJNQbsbirL8syTDU8LkpJ75hyqut
         ET4hsM+dlpYtxzTGhwdgl/a2q8yet6R48TqacdSNlqJJ7OzJgCJe9kvAPsxEpn0X2RgM
         rDlXFlz0LWo1qyOtOl3yyKJAx/p4j/QpfYLb+LNWeNP0VvT+uYMHC3jcS0pfoSPBuWiT
         ecyHBHBBxVBMRkZdaP3aiOQEfNcv44UfDx8tqwS044SrF0wS1Y9aFMniefDw8q/jnaTf
         R+kON3NtOe9OGGo6zqNHPtxgnSsBqayFt3+dnLOCQ0dGVkvx4bJKz+kl3yJgjyGXhcaC
         5GIg==
X-Gm-Message-State: AOJu0YzQiimF0l8x40xACKw84TL4DC2h/ceKIrB/TFfAFaHtnLtjJ5y1
	cInIIfcbqmOspozPxCHfPWgXmPOhoJDM4A==
X-Google-Smtp-Source: AGHT+IHAwa8gw3VjPDWZUWAcDHddSW68o81tl/JL4oDatVEPm9Nxk7ayDw+WyOkSBXY7laprrO2lOw==
X-Received: by 2002:a05:6870:ac26:b0:206:812f:97db with SMTP id kw38-20020a056870ac2600b00206812f97dbmr161811oab.90.1704918559893;
        Wed, 10 Jan 2024 12:29:19 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l33-20020a0568302b2100b006dbf5ca14b9sm852502otv.47.2024.01.10.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:29:19 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Date: Wed, 10 Jan 2024 14:28:40 -0600
Message-ID: <20240110-ad7380-mainline-v4-1-93a1d96b50fa@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com>
References: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com>
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

As discussed in [1], the proposed spi-rx-bus-channels property is a complex
new SPI core feature, so it was nacked for now on the grounds that it should
be accepted without the corresponding SPI core changes. I dropped the Reviewed-by
since no DT maintainers responded on that thread.

[1]: https://lore.kernel.org/linux-spi/0a774bc6-3bf9-4b5f-92e0-8bd673e71a33@sirena.org.uk/

Changes in v4:
- Dropped spi-rx-bus-channels property.

Changes in v3:
- Picked up Conor's Reviewed-By on the adi,ad7380 bindings

Changes in v2:
- Added new patch with generic spi-rx-bus-channels property
- Added maxItems to reg property
- Replaced adi,sdo-mode property with spi-rx-bus-channels
- Made spi-rx-bus-channels property optional with default value of 1
    (this made the if: check more complex)
- Changed example to use gpio for interrupt


 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 86 ++++++++++++++++++++++
 MAINTAINERS                                        |  9 +++
 2 files changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
new file mode 100644
index 000000000000..5a70d1ee768b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -0,0 +1,86 @@
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
2.43.0


