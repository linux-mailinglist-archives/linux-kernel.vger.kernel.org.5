Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C507CF1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjJSIEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:04:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037F2121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:04:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9e072472bso51017765ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697702690; x=1698307490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amvbJJr0EcJgPf0fIdoc/bnu/yWtT48GlSjc/kIMZRs=;
        b=Au/vv363RpvXXgjrtpEcrVjvHwoj427iFtyqpAn6hKxsSLgb/juW+obeRrhc5hwSsI
         Idmwtum0xSNisMJM9qRgE4Be+hPVAswTLXVishu2pJjF31SUBjGrLMm0Qonsf9RI/OZx
         POSgWCatAVh/1Mz1WonzNNViMJM9cxHA3b/9M/3hQlF1HPrsyfrAUgITtkulvqglYfRW
         QcohId+SMn1SBF9C6sx7faZOJvvOZZWc3RDna/oOWXGm9zAzc+lprnVOURUCWsPYSg5q
         WbS4g2c9J7D8MS9sGnUVQgA/NMn0Sd3Oc0Ia3i2D0EEhApZ8NWqPX0hDKhWFnx1JD8bK
         LDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697702690; x=1698307490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amvbJJr0EcJgPf0fIdoc/bnu/yWtT48GlSjc/kIMZRs=;
        b=COI1R0lRv5nzt0oGo76KlPjsmXHuNgw1n/3l2xreUzMNoiCy6GfGK9TVaPnrhHG0an
         EwsE8U4ZAw+0kt1WtjpG8VDmGGc6NnHMa0Ff54wzc0tAEobJsBbdKZreR+JpE2C8xS5h
         eQ6Oe4yCBV14E0teDBwdqUiVvW966UhI/rTj6GrE+X9Hnbub9Ju2KFzsBlUfE2AT8/WT
         md3NtCPorACtpYC5beTy56hHjAbprYxgMFhzvo4OWB3JD49MzEi6p6lwO2QGK4sIJ7vW
         WhETOv2LGGf3D3OnVCPx2dxSZSYpNjO7M4Tin6/Vp/E6GqPt8a73Ny1Y5Uqh/57DtLDk
         uK6A==
X-Gm-Message-State: AOJu0YzsIfrT3+Mn1rUDm5NLBb9CQmi8of+AQYV17XyJZmmczY4MU0JX
        eL0MpNpYQVN4CyjSSjhZhljppw==
X-Google-Smtp-Source: AGHT+IGslNK906q5HyMCKssxFpUMoV4W8ICoihMkpQ50b0Oiis3kzSOiNyReQorYn28uD1dHZOVr6Q==
X-Received: by 2002:a17:902:d042:b0:1c7:49dd:2df with SMTP id l2-20020a170902d04200b001c749dd02dfmr1225061pll.32.1697702690357;
        Thu, 19 Oct 2023 01:04:50 -0700 (PDT)
Received: from localhost.localdomain (2403-580d-82f4-0-43ac-2324-cc6e-9fa5.ip6.aussiebb.net. [2403:580d:82f4:0:43ac:2324:cc6e:9fa5])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902ee9400b001c739768214sm1245450pld.92.2023.10.19.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:04:49 -0700 (PDT)
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960 schemas
Date:   Thu, 19 Oct 2023 18:34:37 +1030
Message-Id: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one
file and removing the other.
Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 .../bindings/iio/light/avago,apds9300.yaml    | 35 ++++++++++++---
 .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
 2 files changed, 29 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index 206af44f2c43..7826a1749fcd 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -4,17 +4,26 @@
 $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Avago APDS9300 ambient light sensor
+title: Avago Gesture, RGB, ALS and Proximity sensors
 
 maintainers:
   - Jonathan Cameron <jic23@kernel.org>
+  - Matt Ranostay <matt.ranostay@konsulko.com>
 
 description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
+  Avago (Broadcom) optical and proximity sensors with I2C interfaces.
+  Datasheet at https://docs.broadcom.com/doc/AV02-1077EN
+  Datasheet at https://docs.broadcom.com/doc/AV02-4191EN
 
 properties:
   compatible:
-    const: avago,apds9300
+    oneOf:
+      - items:
+          - const: avago,apds9300
+          - const: avago,apds9960
+      - enum:
+          - avago,apds9300
+          - avago,apds9960
 
   reg:
     maxItems: 1
@@ -22,14 +31,28 @@ properties:
   interrupts:
     maxItems: 1
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: ../common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - avago,apds9960
+    then:
+      required:
+        - interrupts
+
+additionalProperties: false
+
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -38,7 +61,7 @@ examples:
             compatible = "avago,apds9300";
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
-            interrupts = <29 8>;
+            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
deleted file mode 100644
index f06e0fda5629..000000000000
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
-
-maintainers:
-  - Matt Ranostay <matt.ranostay@konsulko.com>
-
-description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
-
-properties:
-  compatible:
-    const: avago,apds9960
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-additionalProperties: false
-
-required:
-  - compatible
-  - reg
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        light-sensor@39 {
-            compatible = "avago,apds9960";
-            reg = <0x39>;
-            interrupt-parent = <&gpio1>;
-            interrupts = <16 1>;
-        };
-    };
-...
-- 
2.34.1

