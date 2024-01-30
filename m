Return-Path: <linux-kernel+bounces-45318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A3842E73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742D51C22F92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121817B3D1;
	Tue, 30 Jan 2024 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqfX1oFA"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A690762F4;
	Tue, 30 Jan 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648819; cv=none; b=fnWUKV7Yoep6FeLlHf2nmOekEIrx67RZzAujBn5m5SatbNqSrNgADj+9+8LoHflrvuIQ45D+cCTTwSnpDhxl3OtA2RMejYfnipLKruf2D8AsY5KupFHHtPRy4lqb0i4QwvIkZjJNbNWqHC5cb9G60fXUQcH6pvQBwNe8B12H0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648819; c=relaxed/simple;
	bh=fNJt6Q/D/Alnf1fohB1Z7SdgiB8iUvgMdRCGPeqchec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLycXFvjOAgRJXl4YSz2I9aqcmr535hWdcV33kkKNZDwXXfD3F977qjobSlSX+hRPg8ZdQTNKgtjZSfx+qIi6bzwjL47C5uTRXrofELSoE1DM7iH0GBMBy0OlDRz3eog54IsbexZUWHQoid/yjsbeOf7C1eFr+wdmhfCWq8LY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqfX1oFA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a35e9161b8cso309430666b.3;
        Tue, 30 Jan 2024 13:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706648815; x=1707253615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLDQhSu6kRqZGxiyHOr+RblF6k83oiX6rLk/meipQMA=;
        b=TqfX1oFA6owraA4egYBHaJsxAyo7ngxiou7GiBswvpkxHcn4sgAxQpLPoUiMRFHpkp
         Hicm+hTkzWLMNMkjNZCxrOYoz5adgJXJhGXfO2Mb5J2vCMq17O0ZqRJIiiktuXT4C42n
         tpo8/hxZCU3lhkxIz1XEbIeov8M0iO6q4G0FWaXTj0iJWVOPQfNKYXDh74VdxFXrlJy3
         k0tR6fnGKxnA95PL8d6BUfXFZeSjAdytaywA2hkjP0+SDTcPk1cerGIW48UUIYtnVfbC
         nQsMz8JGqN1SAIy5ig7Jozxa8FLMhloLrtNSBhslXijcOsj67seMB1IPOJEtRfYu4qnG
         aJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706648815; x=1707253615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLDQhSu6kRqZGxiyHOr+RblF6k83oiX6rLk/meipQMA=;
        b=YAqD+DPufPFuYlOcT0c1X7Gt/0q7mj3nyl0gNgUr5kHA2D0iytlStrTJ59/MRq0cCK
         J3fXtkMLEK5e2MwjfgzLBP8qV8YB5PMjNFXmW8UN/KuKDvQE/EM+yeY/6/2MJLHUuMEU
         5Ci0FpFebuIrdbo3EXAVY/Au0VP8JnVUWN2j3Iua8y1JnaWi87GMkGv/DnsPs+6UIh7x
         vfJzAbECFSMifqvYNm7tGr0A5XKNgfKI+5JeYrZizFiHnKREq3ioiFwZnpgSak832rx/
         gyUckIy2/4NCs284kI6vgBtjFFmahriyUx7ydPk5EF9le+TYfBE4bNGgbdrJqlRCeyvs
         gPQQ==
X-Gm-Message-State: AOJu0Yzju1DY8BVv+kQ88++E1ygqkM6mQghj6r8egW8MaLT74R33wCTA
	waYCC+hFXdQTcMdoYTFBNfxgVTnwG5yEvZBz+Jahy4mDces+ffRC
X-Google-Smtp-Source: AGHT+IGk6r9KlNzje7atnk4nKVE+RhaI2llH4SByjhzfH3V9RToNtOYhP4sic9HHF0riJEA1uADvBw==
X-Received: by 2002:a17:906:26d6:b0:a36:239:77a with SMTP id u22-20020a17090626d600b00a360239077amr2770503ejc.23.1706648815369;
        Tue, 30 Jan 2024 13:06:55 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7400-ff68-7ab4-4169.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7400:ff68:7ab4:4169])
        by smtp.gmail.com with ESMTPSA id vv9-20020a170907a68900b00a354a5d2c39sm4177658ejc.31.2024.01.30.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:06:55 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 30 Jan 2024 22:06:47 +0100
Subject: [PATCH v6 4/5] dt-bindings: hwmon: Add Amphenol ChipCap 2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-topic-chipcap2-v6-4-260bea05cf9b@gmail.com>
References: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
In-Reply-To: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706648808; l=2700;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=fNJt6Q/D/Alnf1fohB1Z7SdgiB8iUvgMdRCGPeqchec=;
 b=MAPNCwHqUhbiKclSBeuhCBTF8oR3TzEGbpJ7+X1TyFsGcwyuTBxjXe4VbItX8JQ0V0h6G9rQy
 xD+aGaGSlUsDi1NnuBkFF7V8fByqizgn52ePwweamWNiH29+NEvukzA
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


