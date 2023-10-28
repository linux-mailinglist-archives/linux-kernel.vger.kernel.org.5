Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E87DA5CB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjJ1IXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 04:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1IXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 04:23:02 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F71ED;
        Sat, 28 Oct 2023 01:23:00 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id 006d021491bc7-581e92f615fso1640754eaf.2;
        Sat, 28 Oct 2023 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698481379; x=1699086179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP6wiRrtwTK6swQjIEVgXni0A5O1wIdXi7I8tLKQ7oM=;
        b=l2kNP7Ndgg0VPdFTYqFgzW9f09qkcY7nKnxIz12kA+XJrKrBmGJGLVK41uw04v5KWP
         Z8z+aComppfxteo2PwQ6dN989axVb0WEqK6z4rhr2qSo5GiEbKfCSEOoU10fCepaUl/q
         hl7tLMeJELxX+CTWeIsHln8zZhSoTb0NN3BhppZfomOUHpMKQc20jMqS8KAclEPsPehs
         /p2/Aeq7ngc9eh/jp3S8eBX9kkDLoVQL+OaIKw0eHfTKg1siod9pe+poccoR/ZXJKFiO
         m2XYVDs9P+sbnACH0b1hI447Qsfu3jyWR2RqIpqgtHfb/8/c3N3ZWV3/Rs+/7gDB8lmu
         +xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698481379; x=1699086179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP6wiRrtwTK6swQjIEVgXni0A5O1wIdXi7I8tLKQ7oM=;
        b=hEKQRUcPr+WXCoPUmBj6x5/W4y3Bo7OzG4gwYTdThnDAyLzxzEMnJKl9NFZkGXZXp+
         4CADzGjZd8sWTL3yUTj8VIR1gK6d3HExpZ5qTFMwqi482NVXRWW5zjYAnZIFUbGYG9DF
         rvCFfmlsh7KD8oEFUznG3isz+8fJ9xk6pBgb4wK7VNLvFEfgJmTA5DQrjhRitDYZDRnf
         WwBAi1cRL2PikXaAg1pp7pqDN8YTrSkUwdIULyrBWc3mhAaCI8Sp41KFzkiSG5/AN3Bu
         o3Vw0HH6Rxqi/rIxKo7qVHfR/tS51CuJJ6c1OnV2SQ41p7XQod8Ls5iV12N/BnlzlLJf
         t9hA==
X-Gm-Message-State: AOJu0YwwdBul+g/I+Vcama3HStnknkSfbjymAvHg0fUEp5AgbzCl1v+o
        yF43i0dlkZjexRN/ecIHq2s=
X-Google-Smtp-Source: AGHT+IGyNeKH4HniKy+pLheYEL/j0CxFUgrN0ICWz4Gq7rRkbWuKPpxy2gW27njI6Bz7VKt9d3SBPg==
X-Received: by 2002:a05:6358:cc25:b0:168:d382:1446 with SMTP id gx37-20020a056358cc2500b00168d3821446mr5060125rwb.11.1698481378894;
        Sat, 28 Oct 2023 01:22:58 -0700 (PDT)
Received: from dawn-Aspire-A715-74G.. ([183.198.111.239])
        by smtp.gmail.com with ESMTPSA id gb9-20020a17090b060900b00267b38f5e13sm2318789pjb.2.2023.10.28.01.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 01:22:58 -0700 (PDT)
From:   Li peiyu <579lpy@gmail.com>
To:     jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li peiyu <579lpy@gmail.com>
Subject: [PATCH v3] dt-bindings: hwmon: lm87: convert to YAML
Date:   Sat, 28 Oct 2023 16:20:56 +0800
Message-Id: <20231028082056.43276-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <025c3d36-587e-480c-b913-2a3916674c54@kernel.org>
References: <025c3d36-587e-480c-b913-2a3916674c54@kernel.org>
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
Changes for v3:
- add type definition of has-temp3, has-in6, has-in7
- Change the description of has-temp3
Changes for v2:
- replace node name lm87 with sensor
- replace character '\t' with spaces

 .../devicetree/bindings/hwmon/lm87.txt        | 30 ---------
 .../devicetree/bindings/hwmon/lm87.yaml       | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 30 deletions(-)
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
index 000000000000..587191c663d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lm87.yaml
@@ -0,0 +1,62 @@
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
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      When set, pins 18 and 19 are configured to be used as a second 
+      remote temperature sensing channel. Otherwise the pins are
+      configured as voltage input pins in0 and in5.
+
+  has-in6:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      When set, pin 5 is configured to be used as voltage input in6.
+      Otherwise the pin is set as FAN1 input.
+
+  has-in7:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      When set, pin 6 is configured to be used as voltage input in7.
+      Otherwise the pin is set as FAN2 input.
+
+  vcc-supply:
+    description: |
+      A Phandle for the regulator supplying power, can be configured to
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

