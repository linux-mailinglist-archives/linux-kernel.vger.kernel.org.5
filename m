Return-Path: <linux-kernel+bounces-107364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186F87FB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD5A282D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49F97E566;
	Tue, 19 Mar 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="axCZ8tzr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD537D3FB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843094; cv=none; b=qlkO3V6M9Zq0ADbsCuSG9sGs/DiGio/scUiU+7lr/MX2TJoMYGZR67GEKP4eiDwkgM2A9qNeM3zirIjH9hGNR3iYZwTNyPOevy0XAZEAny+1FGsKu+VppDh9vkOr+dLnoUAWWaoWKmnIXiOnSbVc6Jw/klGNU6D7NpmrXrZ2AQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843094; c=relaxed/simple;
	bh=qJG+h7PWXq3FlSvEpcaV3fvTYQ6QvP4I7lH9T+MdsvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1f+ArleMuMfUHxO6YJZgFE+izG9qJCGJO9ARy0WM6TGGCipMLWscE/loQu3Q+zBOXRWMR6A1mdKkaS9Sio/8g6Fk2Kwocpt62GVwLHlIYFyhTPoNLzd/Ptv78NJryinEftnoFkA1QFrUf5YfexlZm3Qw2daUrFTIEEprkd7k7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=axCZ8tzr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-414633f7a52so6322365e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710843091; x=1711447891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2Xt4gKZEQzxm+w1VTeGy38oB/1nG8epzhUyQ7RBcWo=;
        b=axCZ8tzrBYLINfoR2Y9H89WCC4/FTw07yxeSul8Fjya2ch5lqQNYTGVZBdxw7Nxebb
         5uUPa7hgyk6FDzeOLeOqA22yntZDQV4A0N9pOVWuVcDWRDp3KGBAL1k3Ek8Lv0eI82tB
         Ng5WfYIWNfokZgSFXhcpKNzp8kE5/d+lfsCKc/26RUKmkn2QTie4Lx8r85EDMGflucmR
         ZLTjERDRBIxVc2dO43qdB4BZ+ce3FhJUeA+lQEarC+YkeQa/jxGiEujx1Nly1HZE/CfF
         nuVNR40snc8lsu+4r3X40TbHg4jzldJOb54iCdovSoShWcKirNLwTDKn9JX8+v9/fOKA
         EehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843091; x=1711447891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2Xt4gKZEQzxm+w1VTeGy38oB/1nG8epzhUyQ7RBcWo=;
        b=X37UoRWJeO8+UzkaR4jyUUswt0nwofgPfk/UYNXwk/kq0mpYyJuIIAztR4ULsLEnVk
         6a+Mmx7lA2W5hHUz4g0ggTyQjAYyVi6XcWUtsg95148n3YIYII6HwO0EXhXXn5YueBfu
         AP4b/vkMTydY7R99QjYCsZFvbF7rbht2sD7naaCwERB90WjbewOvqk+/kqhcaj5dOOop
         B0WwbAQTXNnpCRfjTX04/ZO+0lgR/IOBAFE/Jj8IrBVVMRIMb3+SF9y8biHjw9eqYpjQ
         iisiBXNduurwU0fBgJN4rMohhJb+sO5QAeLUliY+q+svKOYeH9vfoxZV6hoHzje6nrZi
         F3WA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ymZb0oPIkGFsmyFyGP2/PDgeAbPpydPtAgRafzfLfWF/1iil/BYgpp7wm0gA9mgZay/+GI2TuUXf7W/b96+9AiHtSFr+7mdummz0
X-Gm-Message-State: AOJu0YzK4KD700cdAd5rKnYXuSRWM9yKNL2xTUIDSDMGxxOjXabA81Dx
	sdctwVUuWX6lOpVQKwjk8HBRXyA7Np9DLsJIu94Y8BGkAOITDQLe8yJFFis/kew=
X-Google-Smtp-Source: AGHT+IEGYwtfQJdXt8wjZGZJwk6LVY/ecAzX0QAWAk7gugnt5j4IMepeCVZaQIKRzGUiMfy1LE84Dg==
X-Received: by 2002:a05:600c:3b25:b0:413:286c:4fc0 with SMTP id m37-20020a05600c3b2500b00413286c4fc0mr8130459wms.34.1710843091150;
        Tue, 19 Mar 2024 03:11:31 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm21096384wmb.42.2024.03.19.03.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:11:30 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 19 Mar 2024 11:11:22 +0100
Subject: [PATCH v5 1/7] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240319-adding-new-ad738x-driver-v5-1-ce7df004ceb3@baylibre.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0

From: David Lechner <dlechner@baylibre.com>

This adds a binding specification for the Analog Devices Inc. AD7380
family of ADCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
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
index 7b1a6f2d0c9c..f7c512f3bbda 100644
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


