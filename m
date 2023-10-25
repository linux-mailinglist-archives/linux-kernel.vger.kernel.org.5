Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75E7D69AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjJYLBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYLBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:01:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E244B9D;
        Wed, 25 Oct 2023 04:01:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso4555059b3a.3;
        Wed, 25 Oct 2023 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698231687; x=1698836487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piuEhlKzYYwzHRc+GXT0yNRApgseVG2f389HXHULRS8=;
        b=N+Zq/6DkSuaGZ1gFcJfJ2+mjoJVVFxr7kXryJ/i/SOHnlHmkGeiA15ZsIKVVGbhwv6
         UAWo1a79TRF8wenzI8+ZrrqKxh5OK2Eafl8zgPagtzq3iXRN5wpu+4VHjxOPfGP0lu54
         V9u0R0WkQz1M03E3HSBnlEffDmG6qTlXPEqIxZW4+mFgZzW2VxSh/72L+tY3Bg43jcYq
         oxbfWmKc7qZh/NpDZbwMYiZSASoZ/z6ccQ7Ps0pV7pC63cLu/xKpTqCn/PxOIj82U7W6
         qSEZKHzMOELdzRRENb6uekOOkKJ5vSKUdfiJW7/BJ9th/p7Yeieti4exizGexSEVy1yz
         WzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231687; x=1698836487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piuEhlKzYYwzHRc+GXT0yNRApgseVG2f389HXHULRS8=;
        b=lkDUTrQXQ4R53/hB/1Mk6Dwn/ncYTStBMn9W7DQXisl1vDfkxcCrMLkbl4hY+48xHs
         xwaeKz3wNM0tfQ34YfTrVXNlq9mYA5gtmtMme72dOO8TFMlnNyc1gVinrdUlG0NVmdtD
         Eyq0G/OSDswelZVMb4foTe8wpHcbWFlTcgzMqpAR22MplKPY1NWd1jbxfEqZt/JLNaGK
         x3m7tZ3P7YS1wxrp6qj7WTqhwQ6Zmm8YIIJpKir/qVjfLt0/ZDs6DGVNB6JgHedq2E8k
         rjCENWz+JYAJ0X472MaeBT2jcoMZN+qOvOCb+qHnUuiIkELYo8Q3bKOIwvfzXoq0r7xx
         tOVg==
X-Gm-Message-State: AOJu0YxqwYM/pwCpixAqUTd3cjMnSW6uk+MiMjx8kuUsRMAF8cDANFVs
        yXBDRnN8XrVnT/hz6mGwlxk=
X-Google-Smtp-Source: AGHT+IEFeaSOeoi2yUNTRWdDS9nkIWcP8+NXq94HUP9lvXACogZgvVbynbMTtkQkCxXtKGnAYSN7jw==
X-Received: by 2002:a05:6a00:27a0:b0:690:c306:151a with SMTP id bd32-20020a056a0027a000b00690c306151amr13059034pfb.0.1698231685948;
        Wed, 25 Oct 2023 04:01:25 -0700 (PDT)
Received: from dawn-Aspire-A715-74G.. ([183.198.109.198])
        by smtp.gmail.com with ESMTPSA id r1-20020aa79881000000b006babcf86b84sm9139783pfl.34.2023.10.25.04.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:01:25 -0700 (PDT)
From:   Li peiyu <579lpy@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li peiyu <579lpy@gmail.com>
Subject: [PATCH] dt-bindings: hwmon: lm87: convert to YAML
Date:   Wed, 25 Oct 2023 19:00:03 +0800
Message-Id: <20231025110003.10769-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the lm87 hwmon sensor bindings to DT schema

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
 .../devicetree/bindings/hwmon/lm87.txt        | 30 ----------
 .../devicetree/bindings/hwmon/lm87.yaml       | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm87.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm87.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/lm87.txt b/Documentation/devicetree/bindings/hwmon/lm87.txt
deleted file mode 100644
index 758ff398b67b..000000000000
--- a/Documentation/devicetree/bindings/hwmon/lm87.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-*LM87 hwmon sensor.
-
-Required properties:
-- compatible: Should be
-	"ti,lm87"
-
-- reg: I2C address
-
-optional properties:
-- has-temp3: This configures pins 18 and 19 to be used as a second
-             remote temperature sensing channel. By default the pins
-             are configured as voltage input pins in0 and in5.
-
-- has-in6: When set, pin 5 is configured to be used as voltage input
-           in6. Otherwise the pin is set as FAN1 input.
-
-- has-in7: When set, pin 6 is configured to be used as voltage input
-           in7. Otherwise the pin is set as FAN2 input.
-
-- vcc-supply: a Phandle for the regulator supplying power, can be
-              configured to measure 5.0V power supply. Default is 3.3V.
-
-Example:
-
-lm87@2e {
-	compatible = "ti,lm87";
-	reg = <0x2e>;
-	has-temp3;
-	vcc-supply = <&reg_5v0>;
-};
diff --git a/Documentation/devicetree/bindings/hwmon/lm87.yaml b/Documentation/devicetree/bindings/hwmon/lm87.yaml
new file mode 100644
index 000000000000..54d6ef6700ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lm87.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/lm87.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LM87 hwmon sensor
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+  - Guenter Roeck <linux@roeck-us.net>
+
+properties:
+  compatible:
+    const: ti,lm87
+
+  reg:
+    maxItems: 1
+
+  has-temp3:
+    description: |
+      This configures pins 18 and 19 to be used as a second remote
+      temperature sensing channel. By default the pins are configured
+      as voltage input pins in0 and in5.
+
+  has-in6:
+    description: |
+      When set, pin 5 is configured to be used as voltage input in6.
+      Otherwise the pin is set as FAN1 input.
+
+  has-in7:
+    description: |
+      When set, pin 6 is configured to be used as voltage input in7.
+      Otherwise the pin is set as FAN2 input.
+
+  vcc-supply:
+    description: |
+      a Phandle for the regulator supplying power, can be configured to
+      measure 5.0V power supply. Default is 3.3V.
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      lm87@2e {
+        compatible = "ti,lm87";
+        reg = <0x2e>;
+        has-temp3;
+	vcc-supply = <&reg_5v0>;
+      };
+    };
-- 
2.34.1

