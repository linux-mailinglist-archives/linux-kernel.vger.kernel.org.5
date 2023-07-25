Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C37616A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjGYLlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjGYLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:40:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530CB1FCE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:40:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98de21518fbso900289766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690285233; x=1690890033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCWWBBRJa0PORsLtnTWiKQp9jCoJ7Z5w0rr05I0MhAM=;
        b=A65PLuZvDWSYYYDsjc1F+ZXpzZI+oamgjXR5RgxTp9cRoQ9Dne5I+Jh8psRSH78myb
         A7gqN0mwwpj20DcWesnpkiRR1y/0oDoxMW2YQF6jriAms+leXGFKjnklt/4wJaInyHnD
         pANYTfJu/uKiRwA8tPws/g+LXN+6so5TwwTgN30x8YjP+2P4iX0Bf5VzI49W5Rey7lcA
         m+dK9+9YHD//oL23pNz9tydLv7vA2IQtnvHSTwKcSe98dC3zblljuMHuDEsOVINXb535
         AI/BqWNjgFBPXrudag3p1/C1VjTcqKp+5yXHOVTkDkb3pRnZ1VohwoBv+4VrR4mJoCB8
         HKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690285233; x=1690890033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCWWBBRJa0PORsLtnTWiKQp9jCoJ7Z5w0rr05I0MhAM=;
        b=gylwpvEV8SjfYj4pdTdRLFA5b0z16Z6bbnIOWqFQH884lmHtkioQ0b/2QtM7YAKEO0
         5SYX3C6BLguZu8Viov65Qrxj0FwEGVLwiiKRMLIFrDsUll2fz9mNttkwbpIXpLeMOsxP
         2DFZmMLG1MncLx5eYoCTiXjkjKbexamsz7M/uU7Voc3IryT59Nb1ZFbBhL653yMoSMum
         tiqq3t9fw7KjB3Kw0/GSdB4WRieu0n5/eZnXC/jdwXjJT0PNLShasUZ+O2pYaMP5Q9Jq
         xHxacssrwXnW3iVWEtjBXJio7uAD9vMc3D5+8YwY9z5T1rkdcrq+iir2pgzAT41yLY82
         BTdA==
X-Gm-Message-State: ABy/qLZLSnX9jEGuZUDJNk4CcyqO7LDOku+3aCutwLrQxmUs9VajfA8g
        GtWqzNbvBSK+T7diz6kBQMrT1g==
X-Google-Smtp-Source: APBJJlFS6kYrnmiucY9eWirPBclgdbF4vnVSeCw6/ChNL+5oAgMp6DRN0T580c2uPfxcC++hVTOUoQ==
X-Received: by 2002:a17:906:9bdd:b0:99b:4e75:52bb with SMTP id de29-20020a1709069bdd00b0099b4e7552bbmr12428460ejc.69.1690285233475;
        Tue, 25 Jul 2023 04:40:33 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id d6-20020a1709067f0600b009925cbafeaasm8088206ejr.100.2023.07.25.04.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 04:40:32 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Date:   Tue, 25 Jul 2023 13:40:26 +0200
Message-ID: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

The TDA38640 has a bug in SVID mode and to enable a workaround
remove the TDA38640 from trivial-devices and add a complete schema.

The schema adds the custom property 'infineon,en-pin-fixed-level' to
signal a fixed level on the ENABLE pin and to enable the workaround.
When the ENABLE pin is left floating it's internally pulled low.

If not specified the driver will continue to use the PMBUS_OPERATION
register to enable the regulator. When specified the driver will use
the PMBUS_ON_OFF_CONFIG register to enable the regulator.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
new file mode 100644
index 000000000000..520112e4e271
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,tda38640.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon TDA38640 Synchronous Buck Regulator with SVID and I2C
+
+description: |
+  The Infineon TDA38640 is a 40A Single-voltage Synchronous Buck
+  Regulator with SVID and I2C designed for Industrial use.
+
+  Datasheet: https://www.infineon.com/dgdl/Infineon-TDA38640-0000-DataSheet-v02_04-EN.pdf?fileId=8ac78c8c80027ecd018042f2337f00c9
+
+properties:
+  compatible:
+    enum:
+      - infineon,tda38640
+
+  reg:
+    maxItems: 1
+
+  infineon,en-pin-fixed-level:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Fixed level of the ENABLE pin. When specified the PMBUS_ON_OFF_CONFIG
+      register is used to enable the regulator instead of the PMBUS_OPERATION
+      register to workaround a bug of the tda38640 when operating in SVID-mode.
+      If the ENABLE pin is left floating the internal pull-down causes a low
+      level on the pin.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tda38640@40 {
+            compatible = "infineon,tda38640";
+            reg = <0x40>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6e24c4d25ec3..2b1fbb2a672b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -151,8 +151,6 @@ properties:
           - infineon,slb9645tt
             # Infineon SLB9673 I2C TPM 2.0
           - infineon,slb9673
-            # Infineon TDA38640 Voltage Regulator
-          - infineon,tda38640
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
             # Infineon Multi-phase Digital VR Controller xdpe11280

base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
-- 
2.41.0

