Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836E27E5A40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjKHPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjKHPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:37:41 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054DB1FDA;
        Wed,  8 Nov 2023 07:37:39 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso11810675a12.2;
        Wed, 08 Nov 2023 07:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699457857; x=1700062657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bezVq5NfxD+KhZfkFbZwhXk3BKYmWSQOuA8lFp/Q5CE=;
        b=Gb3o2tRVoT1jK2jyT4CtxQpuSprDD5KzOM5tizpN9sEJ3fZ+cC7P3hoYKOezeh/LX9
         6WNTPlsj8TRVhxV2QlpfQ7GUv3AvomKMv0VhBkcifmg2jSXZZ3TT9IDl1t7g9LT+8g6Q
         DpOWdC1SuqGl+n6roua8k/53GyNOLzX4WHtX8g94CpyTFM6akSuqCZBYvFFEt5io6B3I
         nVihQX1uGh/NGtxwMoQGYxnwvc3ipaxr+eS07nm7b4TiY5ADHNT/CVCkRtP2f05nRZga
         dNeXyjgCYmj0gWD2zAgog7FVklRP3pW69HbxzUP+CqnZWJmzDciz6SaZs2Diej8CmaJf
         sAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457857; x=1700062657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bezVq5NfxD+KhZfkFbZwhXk3BKYmWSQOuA8lFp/Q5CE=;
        b=wkGM7aI0YjiQ2ggnFNADH93nTmqK8kRnn9HsPDpbGo5J11LYiikeS15u/7Z0BXxx3J
         +XBDK82meZeUvnPk5sEd0eNoq3uk1tRNewmVmHOEHmJnnWzgberjtGXiMaT2uU7fJj+L
         KaTk337jHtGnMcDeZ+8ClsIlkcBlFuyK1qTClzfLnlmEH8aQdOnGYFTvGWb2WBWo4Rt6
         3kWCY1gncbzmbqvSTFvf1LyCdNoeBsH9vd7RIfvmOH8iD8NxDsoCYD+5jKbbwDplpLbX
         GWV7xPwzkaqX66r2Ki2+Pm/MUjY56RQ9g9/RdEoR28rZaNHIULUAjKKLSGldx+OeuaAc
         SP9g==
X-Gm-Message-State: AOJu0Yx5xt3OSfuuk/TcTJMuRhT9fbtkOy5a6p5bFu7Z6dEY0NGfXJTV
        xvcxJuXkz4KsyByKgG2KX2w=
X-Google-Smtp-Source: AGHT+IFf5dosgoD1Z/beNxINcyL8uGuFojj7oTj/e5xSGmjEzmvCdA840NrOJrGiIFsuVMbiqbv4PA==
X-Received: by 2002:a50:8d0b:0:b0:53e:37d1:a31f with SMTP id s11-20020a508d0b000000b0053e37d1a31fmr1918407eds.28.1699457857488;
        Wed, 08 Nov 2023 07:37:37 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-840c-82c6-68fb-9a49.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:840c:82c6:68fb:9a49])
        by smtp.gmail.com with ESMTPSA id j28-20020a508a9c000000b0053e3839fc79sm7009966edj.96.2023.11.08.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:37:37 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 08 Nov 2023 16:37:30 +0100
Subject: [PATCH v2 4/4] dt-bindings: hwmon: Add Amphenol ChipCap 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v2-4-f5c325966fdb@gmail.com>
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699457849; l=2364;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=d+q16++TF3EsSideU+hM8FP/AieHkXH5vyhNQwTbFHQ=;
 b=vaBHUKRj7Ud6Yd2UG7HEi9UGVO2wB07a9nPq2uSl7p2TM4ijNt5tX9Kj4Pjen0NvzxNPd0AZZ
 g8NrFJtNv7NCbvCJ4fVjYQUEcKUv42HoMOv4KHvrKWvc4Rfol1EKHW0
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings and an example for the ChipCap 2 humidity
and temperature sensor.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/hwmon/amphenol,chipcap2.yaml          | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
new file mode 100644
index 000000000000..8bb6daa293d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
@@ -0,0 +1,68 @@
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
+    enum:
+      - amphenol,cc2dxx
+      - amphenol,cc2dxxs
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
+      If not defined, no alarms will be available.
+
+required:
+  - compatible
+  - reg
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
+            compatible = "amphenol,cc2dxxs";
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

