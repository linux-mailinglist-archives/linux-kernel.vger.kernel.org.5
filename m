Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ADD8091C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443825AbjLGTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjLGTo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:44:59 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A5C170C;
        Thu,  7 Dec 2023 11:45:04 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a00cbb83c80so151848966b.0;
        Thu, 07 Dec 2023 11:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701978302; x=1702583102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQIFVhJJWVMErSy2LBehuPtfd+ssOO9PI0vGzyJlWu4=;
        b=F56+RECoKagw/r+XWvLKY0gaKf7BdWL9C4dtKbVePboZaiUGYsMRFVfjAz8gsSCXPy
         uz/ymucwMOIGLYJuF3AoE0p/Z7vO1opR8hOgTFnzPQumZCi7fKbHQ1pP2CP69V1XOJcj
         y0iAFHEBxb5vsMhgdgbOkhHer1fY1NciGxlj6l1c+kyUCwR8iMWaRsBF2GdakJHOlEMS
         d2WYwfspLKGBjwhuIsoDnyzDJyGvLHNRePhEn7JNOPjfmel4YJTVagNqFvPXrm7fmLNJ
         UVWgi/w3rw8WHSLDUaK+QxsC+1l+uZ91Exf4ocA1SqWPbQMBXODXHD5i9Uro4N0YSry+
         uoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978302; x=1702583102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQIFVhJJWVMErSy2LBehuPtfd+ssOO9PI0vGzyJlWu4=;
        b=ak56pwpShsgobR4RD5OxMZa5cWT6djjyasNzyFQD7+B02SgI9m+PPoUngeAtiCZtB9
         LvYZnoRQb08zD4FC0/zDG1JhXBrUMoWaKe0vHvOQtPdrJU1t4YP6nsFq5g2N9D/pZlnS
         FH3SzNIF9pK66QLjzMQjoT7ZXBsOoG516Wh9Yt3NhfD0n3No9gVO4XcQxQrRu4Z7byM9
         saozDEZGhIiFTP6LKVBfxoIuCw75E5Gn9vL55mHMgObJ/X98QDyTESRrqni513MuCceX
         S2kH9zgvKtvjnWE2SrXZXzaFUf4aZTHU4ADrVdCKPOz+byzcMSArR/qXEpth5pwqXsK0
         1hBQ==
X-Gm-Message-State: AOJu0YyCLFjkjaaRwxwMRiGcdkDoIRszsoe5CEZazCZfRpPfD4PmQYJ+
        o41lS4UAHHYyJVbu448sbI83t+z4R6ZSBA==
X-Google-Smtp-Source: AGHT+IFbkE9v9gKKM3CEmpySv54v5+3W+2J8h90C0bMqbBxR6BDm9S8HT5gAj2+nIcnH5NjTdkm+2g==
X-Received: by 2002:a17:906:9e06:b0:a19:85ae:e0c3 with SMTP id fp6-20020a1709069e0600b00a1985aee0c3mr1579412ejc.35.1701978302066;
        Thu, 07 Dec 2023 11:45:02 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1de9-f6cf-eef8-174f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1de9:f6cf:eef8:174f])
        by smtp.gmail.com with ESMTPSA id rr17-20020a170907899100b00a1d457954d6sm127364ejc.75.2023.12.07.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:45:01 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Thu, 07 Dec 2023 20:44:54 +0100
Subject: [PATCH v3 4/5] dt-bindings: hwmon: Add Amphenol ChipCap 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v3-4-5b3bb50a5f0b@gmail.com>
References: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701978294; l=2523;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=C++NOYO1W92ZUhE0C/w4m3kdvpKV1mYW6ndjBCwmz50=;
 b=dQ7l6Yyz3XJiqpb2y/gNyCRYElUSUMIC8aA+B3mLEa3xk2fem9Je6PzFq4IW7eI1qePr4ywWW
 vq8ex8bzDseCe5CQ7CE8ftWbpPD9LyJ0Pl1nErJgteODoBPcA+9Khgo
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings and an example for the ChipCap 2 humidity
and temperature sensor.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/hwmon/amphenol,chipcap2.yaml          | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
new file mode 100644
index 000000000000..b83bbc2719ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
@@ -0,0 +1,74 @@
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
+      - amphenol,cc2d23
+      - amphenol,cc2d23s
+      - amphenol,cc2d25
+      - amphenol,cc2d25s
+      - amphenol,cc2d33
+      - amphenol,cc2d33s
+      - amphenol,cc2d35
+      - amphenol,cc2d35s
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
+            compatible = "amphenol,cc2d23s";
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

