Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BEF7D7DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjJZIDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:03:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81102B8;
        Thu, 26 Oct 2023 01:02:59 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6ce291b5df9so308866a34.2;
        Thu, 26 Oct 2023 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698307379; x=1698912179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiNUWaVbyuQ9E3+Z8Xcu/M3576aIKpUu0D5Q0llCz/Y=;
        b=HdtPWIqR+o4kxo1Y5iDHbGcrPB1w5Fstm7Nx0OOZ3P75OOtel40+ajHTWlwWu/5gSx
         7nT98Za/HEwDhsjCjbX8qzso2By5Bzh56b0tgRX17pj3/cK12B2CA/EmzUaGajDiPOOj
         V4uw2IMe1J8LThuEhUqAsmWj/7kqHqYNLtH5TZ1BflSj6DVk32A2m7JCJLF99HMycoMB
         aD2OiFHaCUIFOsM1luvvstSX8QdW38jpYK9AlLi5k6trM3qWlWi2oJN7Zdmi59cDJg8v
         pUiNDu3kd5BLMCapi0TXrujTerxjJh9jTDi1SId/CXTK45RCM4tbveIL0cg8VS9VcoPi
         KcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698307379; x=1698912179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiNUWaVbyuQ9E3+Z8Xcu/M3576aIKpUu0D5Q0llCz/Y=;
        b=utr6171PHDJyskINhRSjRbn11Cgk5YRnd6vL1t+jkR3SaEG7y6FtLNFT6iFIHhbl/k
         ou8lPzg3gF9OhfKJHsHXFebrsknPbeUskpZnHNeYr93ImD9pl6VFYrRVOC+QfDkX9Mjv
         9awrozJF4Z3eeSmAdp1arvHlBL7hLYmBUCxxYNhVGcgUqrMS01wnoCTsd+HtSUCa0/+Z
         gAFAtGTfgCF3p5TEnU8a4W4zGrt6iSKa8HtiYZYUUqhYJUBPHdAsV7Iva3UPYNlIGJ9y
         aOPZGWfdyajeaS8zT37B7uQKZWgwOWSbiiche6XA89S4JORXIL+l8bAhilCIGoA2oWNV
         dCmw==
X-Gm-Message-State: AOJu0Yxfzjavp7nmqQUVqRgYjYQ1cw86BcANYathIDYVGgxqhDtyMLaO
        QL/NzNYaqqnaCLSIUAzdfK8=
X-Google-Smtp-Source: AGHT+IHgKWPQhOLXFQRr+4qqmAwqD5d5K+uinng7SBFGOYZi7HWhXPOFi6EUb9I2souPViSEkRgsWw==
X-Received: by 2002:a05:6870:6713:b0:1e9:9bad:8989 with SMTP id gb19-20020a056870671300b001e99bad8989mr24160862oab.25.1698307378484;
        Thu, 26 Oct 2023 01:02:58 -0700 (PDT)
Received: from dawn-Aspire-A715-74G.. ([183.198.110.181])
        by smtp.gmail.com with ESMTPSA id b11-20020a655ccb000000b0058a9621f583sm8625579pgt.44.2023.10.26.01.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 01:02:58 -0700 (PDT)
From:   Li peiyu <579lpy@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li peiyu <579lpy@gmail.com>
Subject: [PATCH v2] dt-bindings: hwmon: lm87: convert to YAML
Date:   Thu, 26 Oct 2023 16:02:26 +0800
Message-Id: <20231026080226.52170-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <caa50763-74be-4c40-9d8d-7f1f64ce5144@kernel.org>
References: <caa50763-74be-4c40-9d8d-7f1f64ce5144@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the lm87 hwmon sensor bindings to DT schema

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
Changes for v2:
- replace node name lm87 with sensor
- replace character '\t' with spaces

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
index 000000000000..8f4f07845d95
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
+      sensor@2e {
+        compatible = "ti,lm87";
+        reg = <0x2e>;
+        has-temp3;
+        vcc-supply = <&reg_5v0>;
+      };
+    };
-- 
2.34.1

