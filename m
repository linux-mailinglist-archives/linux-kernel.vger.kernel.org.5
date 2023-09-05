Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF56792FF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjIEU2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbjIEU2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:28:45 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127E1FA;
        Tue,  5 Sep 2023 13:28:38 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a9e89fa553so167643b6e.1;
        Tue, 05 Sep 2023 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693945717; x=1694550517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTAlf1Pn0y/kznlJiOVRc19uOH2iY5h9kLD6cMbrGec=;
        b=liOj2IIS8xlM/noLQncRlxHTaJFuzby7A0Z8wm6fRgFFzqB/hVh/EEm4QjLAPjXyNw
         w8NSsz9RhIBS75XVPsr0lbFHJQ4EG3W4SiX79jF6krxB5vuUugkCASpKcMV62f59Qi2Q
         iYWYnkKp66PJFtBiJzACESIoR6lYGV+0+9cyGFTfNqKzqgzWyI3aRpYLU+yqb8FUDdPB
         /q7VRf8A1X9pDaGqGLnwD96zrl36q2JEafifdOKnhoEVmYDB5TJSwD2+wJCiKnr0v65F
         hqVED9B6P8kIvUPu/woJoqkwpwsl3yLCRCbZF6SnnSTKLn8wlOqgsbWSFfkzPst8ZY1V
         ar8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945717; x=1694550517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTAlf1Pn0y/kznlJiOVRc19uOH2iY5h9kLD6cMbrGec=;
        b=ep7F46B2oFW5qaJpOpDw2xWPOJC2MbBKZ777/TJnXIZKhdzJzev0+LeQxlI3XjGVGj
         YCtIUaXCfR8inutA+Ap1tKoLvTrgFJSNmw+Wy59PYOJGxVYRTCSSDXfypkXyvZJdSgE7
         gzu6r6k6mHEchD8YAzT5MrUgrMlZRTCjSHaR+h0TRI6Oi9fii/Co7a967NFiyhWZTKmX
         vJk/X50QEFmzEtobN6x13kuJ9ZJV8xe7NzLwIFlRwAOBp0mt1BaMMFWoSXGQH9m3mesv
         sGm8602/ftInEVMdLrU8UR7wmxIkSiXUoQX0DlIXSo/JfdLPiaLKHvZudIezYKwMrXjt
         ywMw==
X-Gm-Message-State: AOJu0YwnT8ZZQ892Z3jiqYmtnw8Uz/+WPxDEgDoooqpPq+RoSVz2s44m
        uV+zLe42iIecXZjLNJqVJk5VmxlEc84=
X-Google-Smtp-Source: AGHT+IE7x7EBKIFZ+qVuqswnyxIG2uwHjRUE1iT/ARHkwcvh5TxlyI8/qqrxmVug6W2kMtdDnkV0Vg==
X-Received: by 2002:a05:6808:4443:b0:3a9:e40c:683c with SMTP id ep3-20020a056808444300b003a9e40c683cmr16061835oib.1.1693945717206;
        Tue, 05 Sep 2023 13:28:37 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2abb:b8c2:b1a6:d1ec])
        by smtp.gmail.com with ESMTPSA id bf36-20020a056808192400b003a89019d5fesm6279419oib.51.2023.09.05.13.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:28:36 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     alexandre.belloni@bootlin.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sam@ravnborg.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] dt-bindings: rtc: pcf8523: Convert to YAML
Date:   Tue,  5 Sep 2023 17:28:27 -0300
Message-Id: <20230905202827.67212-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Convert the PCF8523 bindings from text format to YAML.

The YAML format is preferred as it allows validation.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Add the default value for quartz-load-femtofarads. (Krzysztof)
- Pass unevaluatedProperties: false. (Krzysztof)
- Fixed a typo on Sam's email address.

 .../devicetree/bindings/rtc/nxp,pcf8523.txt   | 18 --------
 .../devicetree/bindings/rtc/nxp,pcf8523.yaml  | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
deleted file mode 100644
index 0b1080c60f63..000000000000
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* NXP PCF8523 Real Time Clock
-
-Required properties:
-- compatible: Should contain "nxp,pcf8523".
-- reg: I2C address for chip.
-
-Optional property:
-- quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
-  expressed in femto Farad (fF). Valid values are 7000 and 12500.
-  Default value (if no value is specified) is 12500fF.
-
-Example:
-
-pcf8523: rtc@68 {
-	compatible = "nxp,pcf8523";
-	reg = <0x68>;
-	quartz-load-femtofarads = <7000>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml
new file mode 100644
index 000000000000..8d17b89fef5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,pcf8523.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCF8523 Real Time Clock
+
+maintainers:
+  - Sam Ravnborg <sam@ravnborg.org>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: nxp,pcf8523
+
+  reg:
+    maxItems: 1
+
+  quartz-load-femtofarads:
+    description:
+      The capacitive load of the crystal, expressed in femto Farad (fF).
+    enum: [ 7000, 12500 ]
+    default: 7000
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@68 {
+            compatible = "nxp,pcf8523";
+            reg = <0x68>;
+            quartz-load-femtofarads = <7000>;
+        };
+    };
-- 
2.34.1

