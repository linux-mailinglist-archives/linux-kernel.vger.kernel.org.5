Return-Path: <linux-kernel+bounces-165397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108828B8C40
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F45B21F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9937E12F59F;
	Wed,  1 May 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HZWK5idm"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28912F36F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575353; cv=none; b=aw/DsvYAXqzM9w4Lp05K40sjKAGxbAbuMwxc537Xc89EywXcurGPaQ2xqAyVoMgx6ElTcSTNXDRjulz4FLDpS694J8Hl0k2tCa7GuK1Kw2ia13GSk/h6JSMvWpxF/ET9Y8aK1wChL3AoZKrcny1CxLZgpMIFZgDlaBPt3BoD424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575353; c=relaxed/simple;
	bh=IDhrjIJtC1G3o2fCZqsHvxz7NEDrI0F5jKU0EEQs398=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZACBklns6WIKrHnG1O1+wPinNAhjuDUoyOIm7ly/EqLdIbNjOqn+zVoMgmiiehNuLj+E4ulNSqboQ9SrGoCu3GzRZcXfpcD7Okyjb0owXs2f/aQkupLpxh3v5B45Wpq1kuZ8dqzCLmZEh/qmYIpc+zQauGlmml2re1NErMW+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HZWK5idm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dfb4ea2bbfso53046981fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714575349; x=1715180149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fhz/hQk8RD1tt0hu/cR4amFoB9mWCchFbN+TxPow/AQ=;
        b=HZWK5idmP6QILE3q3N3KEcFMgKf6S+NSTqRhw5tSLPSieMEYngUugUXemk6LlhS8Wg
         hQSkXexZpa8QZiDpL8c0M0QFL7rncNPbbQCmtZQQUq0ou1Lm+e0NrVwVHmgawXzBCWyI
         hgFNVHVva4xsacW+JUqAtmDKxzAR0EtdTXx83v5ct9TxbEJ5piXUTfNYLlYbeCAV5qn1
         OlfD/GT79UAZ9AUBZnNfxahAzN+YaDIFDDUF4e1Zzf6bzzLz3TrNijo+PO1qqxkoHpXD
         pnSCKiL9/JJ1IAGekKlcwv25fqE19dDWd6GACM6jRN+IYoFydQgUcfZt2GspX20kuS/6
         7pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575349; x=1715180149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fhz/hQk8RD1tt0hu/cR4amFoB9mWCchFbN+TxPow/AQ=;
        b=W/iTxLEvZ5f8gJSGgqeg14Gl0MdrNNyQx5sA3qsfhCnJ8iigf8iyccc5GTBiY/9I4/
         Gb2Stu4Dwnz4So/BU2OLYddwrt4LqUKMqAtKd4g9lydAR+iu2CmSKRAkyECXsMko2asc
         AMVXPTBPVhADFmU7q5GvXEsBYvIUnzKLOv83qD78UwRp9hF+2p24D3SpLl8chhWCNsDi
         va/cmNv9+7gvO7ckp5dLD3jq0qH4HX/pc4BJ3B/OsjvyYLzr2jKqkKYulFVL4h7oeJzL
         jb7h5MV9c3yxgsnHf3g5thDKtuSGoWd7SoRmC2XsyLGq8gG34yANBYyvap48yOQFsMXe
         kgRw==
X-Forwarded-Encrypted: i=1; AJvYcCV1QbyEco5HRufNCkpmgnb6SLNVr+nyk2NjQV+k4L8g9x/xuWlJrr8r2fjrK2bbCrnBX8OzhILPrSOPy2DfRRS4OIccvYj75O/mqrJJ
X-Gm-Message-State: AOJu0Yzb/onx5p5nvKCCgs8WzIYZgxpLnHlypuGeDawwzflCvFBURbh7
	WgYOWUnM6jeaPNLJrXoqf2zhzzKefwwDn1RFzL0F5W63eAK3qfAYUGaGI43VHRA=
X-Google-Smtp-Source: AGHT+IExWbzFu/y+P/BHymNniS1NWoawv6PjReU8jo15sbOyMVB1Zznn6zp0RVZFa5o0QkTLX+GZDA==
X-Received: by 2002:a05:651c:222:b0:2d8:930c:bbfa with SMTP id z2-20020a05651c022200b002d8930cbbfamr1798566ljn.5.1714575348754;
        Wed, 01 May 2024 07:55:48 -0700 (PDT)
Received: from [192.168.1.61] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b00418a386c17bsm2422999wms.12.2024.05.01.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:55:48 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 01 May 2024 16:55:34 +0200
Subject: [PATCH RFC v6 01/10] dt-bindings: iio: adc: Add binding for AD7380
 ADCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240501-adding-new-ad738x-driver-v6-1-3c0741154728@baylibre.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0

From: David Lechner <dlechner@baylibre.com>

This adds a binding specification for the Analog Devices Inc. AD7380
family of ADCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 82 ++++++++++++++++++++++
 MAINTAINERS                                        |  9 +++
 2 files changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
new file mode 100644
index 000000000000..5e1ee0ebe0a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -0,0 +1,82 @@
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
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7380
+      - adi,ad7381
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
index 8ad79cf70552..5bb168937853 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -427,6 +427,15 @@ W:	http://wiki.analog.com/AD7142
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
2.44.0


