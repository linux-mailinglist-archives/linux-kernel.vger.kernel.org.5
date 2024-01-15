Return-Path: <linux-kernel+bounces-26455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925F82E12B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D66F1F22D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991211A592;
	Mon, 15 Jan 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l59JS8lA"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864B19BD0;
	Mon, 15 Jan 2024 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e7fb927a3so7179905e9.3;
        Mon, 15 Jan 2024 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705348950; x=1705953750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLDQhSu6kRqZGxiyHOr+RblF6k83oiX6rLk/meipQMA=;
        b=l59JS8lApJCODbBoqEOcoRV5jGa+PDeEsfrIb16WrVFYr+jiukgWb7rOZOut6mEhrz
         PKGvrcGwwOR9rGI5rVwZuqM72Tkkh+ubNZmphZc63ZqlxoT3RNgzHTTihzHppcZtmz/8
         WyTggJTHrbIGX5H2dzTVeomUd/tz1rowMpvw43xQBEdhg+QdtxFU/zafZNaWE9jIHX6B
         rofYtE4IRQmxZL5jsf3UHFTvq9M7ZGZ+20WE2o/TGkOcfvzqNvxaYu7RhXRn1i/Mhwed
         hvf7kfA3eoApvUEBqOMLwLuuUnL7w1KuBsSMCezlpdtPVpo7asNC7yBxrZfqC+n49tY2
         IA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348950; x=1705953750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLDQhSu6kRqZGxiyHOr+RblF6k83oiX6rLk/meipQMA=;
        b=vM9HNpJOvvxZdK8qAe9prMuV/mvo/7okeTN6Zl7M+JPC2s1XGmGKG/yr1g4QLwST4+
         8DaHi3Zfxb4wf+WRDUg4x35NYM4/n5Fabc14K3vwqJQUem/VdC5lSBnMOUznW21jgsxp
         tOSrekhEC3BAoIOkaVylb8VHSnMQlkjbkxeZ/+THHlhs7WK/yEryMbVarDErn1swEpXN
         8XNlTIfMtW3YD2GZXBrFDExBdJ689Oe4HwER9BY0IoFNqtuxO43jIJ4ScBpgXccrPwRj
         1I3iy7zDABtQGNqNSEHTcs+1uMe5cfhHoeTFjdSUhzWCxrR4fFpHzvrKc6GMq6oRIL86
         UjWA==
X-Gm-Message-State: AOJu0YwQuygBcztcumN9EsVIBffTchV2Vrj5V6R9V6UDXbFkPfOIYpqh
	ULNXIC2BUyNND65o+AYn3DE=
X-Google-Smtp-Source: AGHT+IEg9dB8L9AYCo/z7kn5emLXT7SlnL7CIsoc5wE/5qgGhti8R5kfVc/XaW7XvHhkX+fmtDK/Yw==
X-Received: by 2002:a05:600c:4d04:b0:40e:62aa:88dc with SMTP id u4-20020a05600c4d0400b0040e62aa88dcmr3774577wmp.127.1705348950476;
        Mon, 15 Jan 2024 12:02:30 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bf32-c470-1874-c1ad.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bf32:c470:1874:c1ad])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bca5a000000b0040e54381a85sm16377924wml.26.2024.01.15.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:02:30 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 15 Jan 2024 21:02:24 +0100
Subject: [PATCH v5 4/5] dt-bindings: hwmon: Add Amphenol ChipCap 2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-topic-chipcap2-v5-4-0cc7a15aeece@gmail.com>
References: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
In-Reply-To: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705348943; l=2700;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=fNJt6Q/D/Alnf1fohB1Z7SdgiB8iUvgMdRCGPeqchec=;
 b=XdDpcmpsJ50SV7kmMdYGdHgD6IJrKn8r9j8aVtHF5NGWl6Y702Xak+EULeeggkgY9BxcBIMzd
 WwmzBjiFAa7Ddmqgj9RkoiaHsC1A3AH27izvMvAw8oqdszvg2CX8n0S
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Add device tree bindings and an example for the ChipCap 2 humidity
and temperature sensor.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/hwmon/amphenol,chipcap2.yaml          | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
new file mode 100644
index 000000000000..17351fdbefce
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/amphenol,chipcap2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChipCap 2 humidity and temperature iio sensor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+description: |
+  Relative humidity and temperature sensor on I2C bus.
+
+  Datasheets:
+    https://www.amphenol-sensors.com/en/telaire/humidity/527-humidity-sensors/3095-chipcap-2
+
+properties:
+  compatible:
+    oneOf:
+      - const: amphenol,cc2d23
+      - items:
+          - enum:
+              - amphenol,cc2d23s
+              - amphenol,cc2d25
+              - amphenol,cc2d25s
+              - amphenol,cc2d33
+              - amphenol,cc2d33s
+              - amphenol,cc2d35
+              - amphenol,cc2d35s
+          - const: amphenol,cc2d23
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: measurement ready indicator
+      - description: low humidity alarm
+      - description: high humidity alarm
+
+  interrupt-names:
+    items:
+      - const: ready
+      - const: low
+      - const: high
+
+  vdd-supply:
+    description:
+      Dedicated, controllable supply-regulator to reset the device and
+      enter in command mode.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        humidity@28 {
+            compatible = "amphenol,cc2d23s", "amphenol,cc2d23";
+            reg = <0x28>;
+            interrupt-parent = <&gpio>;
+            interrupts = <4 IRQ_TYPE_EDGE_RISING>,
+                         <5 IRQ_TYPE_EDGE_RISING>,
+                         <6 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "ready", "low", "high";
+            vdd-supply = <&reg_vdd>;
+        };
+    };

-- 
2.39.2


