Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAD47DBA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjJ3Mwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjJ3Mwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:52:43 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACE4C2;
        Mon, 30 Oct 2023 05:52:40 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e9e14a558f8ab-357ccaf982eso16402075ab.0;
        Mon, 30 Oct 2023 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698670360; x=1699275160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fNVXyebOFrCRGrQioR3BloKGoH/IiLpcgVCUDZeWWU=;
        b=lL2e3mJ/+TbnG/EF2bGMUoKTtkLV7akdJgMAzBrHSPa57p1ovqAHJ0suwi5XhR5ZW7
         9+Vr7al9fkYFVXUDZi8ldcCRgfwSnDWGTrHqEsKsUu4ZysNd5Uqs8TsxKzgGXZSOYORd
         kg4A/5cMwK1DJ7cWYPowE0fBayR4UHrNBbzvkqSO4BxOflJ3Ko6SlWLtdX1sYckwlGgD
         Wv6HctUzz3Vs7SNaeeAW7j+4FAyOtAPTIsbfLl91FFWqX/KlWBfVOfTpPFeqfsIpk9rT
         j+ndjFnfDRDzYkhUlkqI8bIQhrJXPia/lz+fZucXf6Cgw5z1gb8Y0UUHqf7CshaH+JDI
         Fnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698670360; x=1699275160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fNVXyebOFrCRGrQioR3BloKGoH/IiLpcgVCUDZeWWU=;
        b=OSCL/bVwvNHMyaFhTyrXwN3dLT1FshmQ7ucv+oe0C+Fo0dzO0frY08vVm0pfJFXDMr
         Z3Et75UXS8bMaWnf7KNWdj6uTXhHFmAcNIhJSWlMif3PdnM5AyYv6IxSHENKl/uJfLe+
         uiFvZj5krmR+qYFngjkRNqcmbCMHnIlzQnqgZfAtgdMCz+6aNKAlV4eUAVyX/Of1OHPf
         TGmMloZMJguBpUdJeH2EwVmQtb13HwVZB1dehXKyzbv7QJqRw+CPIm0gzoZNuMJKF+uw
         YGcJvAsKr+LsHl/vzOGpjByR9fzPRaI/3PMbli/kkAEy+8Q9r1fVa/PGjUc8nzKnB9jP
         TJsw==
X-Gm-Message-State: AOJu0YxdzvoOD+uaDzCizoLK4lM+5rbYMLr1t7vf8RI2RHBAH0s78xpI
        tF1E9pxWNkhdlooY2QFSwNM=
X-Google-Smtp-Source: AGHT+IEtXsP/s0iZi5r5s9dTABLqQBAgRBQRsEKb4P/xC5URn+eU5R+kIz2EXcMxGeLPvw2uB1xMAQ==
X-Received: by 2002:a05:6e02:198b:b0:357:6e14:835f with SMTP id g11-20020a056e02198b00b003576e14835fmr15264769ilf.15.1698670360107;
        Mon, 30 Oct 2023 05:52:40 -0700 (PDT)
Received: from dawn-Aspire-A715-74G.. ([183.198.110.223])
        by smtp.gmail.com with ESMTPSA id o9-20020a056a0015c900b006900cb919b8sm5910642pfu.53.2023.10.30.05.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:52:39 -0700 (PDT)
From:   Li peiyu <579lpy@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li peiyu <579lpy@gmail.com>
Subject: [PATCH v5] dt-bindings: hwmon: lm87: convert to YAML
Date:   Mon, 30 Oct 2023 20:52:21 +0800
Message-Id: <20231030125221.12974-1-579lpy@gmail.com>
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
Change for v5:
- Change the file name to "ti,lm87.yaml"
- Add maintainers get by get_maintainers.pl
Changes for v4:
- remove excess spaces
Changes for v3:
- add type definition of has-temp3, has-in6, has-in7
- Change the description of has-temp3
Changes for v2:
- replace node name lm87 with sensor
- replace character '\t' with spaces

 .../devicetree/bindings/hwmon/lm87.txt        | 30 ---------
 .../devicetree/bindings/hwmon/ti,lm87.yaml    | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm87.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,lm87.yaml

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
diff --git a/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
new file mode 100644
index 000000000000..6dadf181c9a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,lm87.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LM87 hwmon sensor
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
+  - Rob Herring <robh+dt@kernel.org>
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

