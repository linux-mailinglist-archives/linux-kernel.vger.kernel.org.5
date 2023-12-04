Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA6802B75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjLDF5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDF5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:57:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D617BD7;
        Sun,  3 Dec 2023 21:57:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2866951b6e0so1921020a91.2;
        Sun, 03 Dec 2023 21:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701669469; x=1702274269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAIrBJ++PnmJ5yex7aR18QSXrWBXVdHB6cliHdL5dig=;
        b=edd8WCcbr7gTKoFSTvIgKVSKDdHimMf2192fyhW+IBhqJ3suDpR4Oab/wcqPGc4si+
         Vaap7BjwjaiXDWbUMdnymDB6Rrz51c7j1CrlYdLvZTE6zIAe7OMSF7qG5ldsOEl79z7o
         M9vzNOJnFT67P2Cc3ZYwvJSroztWVG0D8zMJHUF0bL18hlWmyqMzMaWzPGmZSaf/TfHN
         4j4cF3FRUk1pQz90MHJPocVfcICSjEsepBmgkyAOX43j/7YPmanuU8sEvuC3bURPqkYf
         1iBIasoY9bfmTwHT+1z5QLxxqKjbJ8kRjAcSqNwN6GosVl5iVgQ8e8OOTsLY5ujZCZkY
         cAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701669469; x=1702274269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAIrBJ++PnmJ5yex7aR18QSXrWBXVdHB6cliHdL5dig=;
        b=cEPXGcXw/DtECzePIb6WkrjwZsrKrQCBMP5C5Qfc97e3byc2m+3E8sw5KqkDHSx1An
         507aUoCHV6T/WWV5Knj9a3m9MJ3yipmmxdr2uT/ZGplXKtZQ0M+BPRGRRZbMQDSDDaON
         bjeufQgZY4Lixp7r52CiOqbf/v1y5ltJT/QPKEeDt1AHOJALW8Esxv47pRRiMDxCvSKo
         zV11wAR+PNdM6wPBiUoHPIPVnzpIZFy1n1A2kebh+bT8umsXmDl/8Ui1g7hWMMi+HAsM
         5LUA/2EHYhDxdEJ5Wqi0VxPUOXQEUavBnzXV5CKVnKcAx1K3vlF/wYzBqBEElucLetVX
         Zbvw==
X-Gm-Message-State: AOJu0YxExGBprXkY3TGWhSi03WcK7K9BYbng1B27t3NRhPPLNxrZL2QT
        OuswhQkVJ/hcjuBcPB6M9lYyFt2i/7vGvA==
X-Google-Smtp-Source: AGHT+IFp9v7JoAX4YayOy8Qz9lCpzheIHGit7ZfE/zZVOQLstK8rAlojUIc63MbLTWKtNm3Ks6Lo7w==
X-Received: by 2002:a17:90b:1b01:b0:286:5965:1f68 with SMTP id nu1-20020a17090b1b0100b0028659651f68mr2395855pjb.4.1701669469231;
        Sun, 03 Dec 2023 21:57:49 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 95-20020a17090a09e800b0028651ea5e7csm6113523pjo.33.2023.12.03.21.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:57:49 -0800 (PST)
From:   baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com,
        DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com
Subject: [PATCH v1 1/2] dt-bindings: hwmon: Add nct736x bindings
Date:   Mon,  4 Dec 2023 13:56:49 +0800
Message-Id: <20231204055650.788388-2-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204055650.788388-1-kcfeng0@nuvoton.com>
References: <20231204055650.788388-1-kcfeng0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ban Feng <kcfeng0@nuvoton.com>

This change documents the device tree bindings for the Nuvoton
NCT7362Y, NCT7363Y driver.

Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 .../bindings/hwmon/nuvoton,nct736x.yaml       | 80 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
new file mode 100644
index 000000000000..f98fd260a20f
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/nuvoton,nct736x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NCT736X Hardware Monitoring IC
+
+maintainers:
+  - Ban Feng <kcfeng0@nuvoton.com>
+
+description: |
+  The NCT736X is a Fan controller which provides up to 16 independent
+  FAN input monitors, and up to 16 independent PWM output with SMBus interface.
+  Besides, NCT7363Y has a built-in watchdog timer which is used for
+  conditionally generating a system reset output (INT#).
+
+additionalProperties: false
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7362
+      - nuvoton,nct7363
+
+  reg:
+    maxItems: 1
+
+  nuvoton,pwm-mask:
+    description: |
+      each bit means PWMx enable/disable setting, where x = 0~15.
+      0: disabled, 1: enabled
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0xFFFF
+    default: 0x0
+
+  nuvoton,fanin-mask:
+    description: |
+      each bit means FANINx monitoring enable/disable setting,
+      where x = 0~15.
+      0: disabled, 1: enabled
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0xFFFF
+    default: 0x0
+
+  nuvoton,wdt-timeout:
+    description: |
+      Watchdog Timer time configuration for NCT7363Y, as below
+      0: 15 sec (default)
+      1: 7.5 sec
+      2: 3.75 sec
+      3: 30 sec
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - nuvoton,pwm-mask
+  - nuvoton,fanin-mask
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nct7363@22 {
+            compatible = "nuvoton,nct7363";
+            reg = <0x22>;
+
+            nuvoton,pwm-mask = <0x003F>;
+            nuvoton,fanin-mask = <0x003F>;
+            nuvoton,wdt-timeout = <0x3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 012df8ccf34e..eef44c13278c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14900,6 +14900,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 F:	drivers/hwmon/nct6775-i2c.c
 
+NCT736X HARDWARE MONITOR DRIVER
+M:	Ban Feng <kcfeng0@nuvoton.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
+
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
 S:	Maintained
-- 
2.34.1

