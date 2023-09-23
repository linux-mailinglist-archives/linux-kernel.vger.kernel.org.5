Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA4C7ABE69
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjIWHkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjIWHkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:40:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272C198;
        Sat, 23 Sep 2023 00:40:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31fe2c8db0dso2914513f8f.3;
        Sat, 23 Sep 2023 00:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454835; x=1696059635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKrPJWkjEs+cK0uLXs72u7EPbOGJFSfMi3rQJfH1tGU=;
        b=XpXotixH/ksLEUKAvx6sE9Ol2rUjmpxU2HR4eyOakFDtWu9vljhafL8BZwt7KceT59
         idMdabsIse9xos+jA/3cokT7Hmp/nYgw2+Gx8THBwfZXogtueZHgebwswFEJ2f89KMCv
         qwo+54aOUpEjSPwqsIDu1fGbuw3TmuKHiySjVoVNpoFhMiuoq1kIzwGeZLqqmkYQ0RGH
         m6pIzG+jVqt/eRn6oSqsRryktX4X77hwLSMHvIXLU5nxGA7T2H6N8hxpHhrzZryMZ4Jv
         8QDlpG2zmp6qIDgqSJr0xXgnIT4WqmZSwCpYRBh0XX1LkX+zOahwqk0PJx2dElI8KU5x
         YZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454835; x=1696059635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKrPJWkjEs+cK0uLXs72u7EPbOGJFSfMi3rQJfH1tGU=;
        b=HkrnCJdK0CpdKqidPK/txgrxGEucwNIg5gIGzQNJkdAOF/XYTlGn4NS3JzLwetT2ZV
         5oZx2o/5eX7hFIK5sMiM+9cxL0XRxfWPXmzxtY8tHRwqGrnz/4Tgx2m7Pp0wDuAa5xcq
         ygwN1QFvNxy8BLefESpc+KAb7pKw8Dq7CnhaPvmYdXPtmTzke4QVcF9+qLGBPwKI/28y
         y3+TCxC1EOeAsgIKwlgV7OqPxXR58KsGhl7ZWrC8fDMtX/KsRRrvDsbSN+zb09WCUbL/
         eT9nADR/h9T4I41xsfuAlBEHjX97klxGfbINB0S3XxSoN0OOMbITslxFHNfcnNVPewjF
         BpJA==
X-Gm-Message-State: AOJu0YyqwJ2o7LnYL9wFH+b0p5+vAOdn7ChaV3lGWv70dbEGfsxjbATp
        MQzyNc1TCRSWeRxRVp2xC58=
X-Google-Smtp-Source: AGHT+IE7+mky1P7RVLFZVXctvXF3UzbQte7wMu1FYl99R3/3im9zbOy7n8jAucRP7u+t2P/CyDALNQ==
X-Received: by 2002:a05:6000:819:b0:323:1689:6607 with SMTP id bt25-20020a056000081900b0032316896607mr1557349wrb.5.1695454835447;
        Sat, 23 Sep 2023 00:40:35 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:35 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 01/14] dt-bindings: usb: tps6598x: Add tps25750
Date:   Sat, 23 Sep 2023 03:39:46 -0400
Message-Id: <20230923073959.86660-2-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 is USB TypeC PD controller which is a subset of TPS6598x.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v6:
  - Use reg property for patch address
Changes in v5:
  - Add tps25750 bindings

 .../devicetree/bindings/usb/ti,tps6598x.yaml  | 80 ++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index 5497a60cddbc..da299a2bb19e 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -20,8 +20,7 @@ properties:
     enum:
       - ti,tps6598x
       - apple,cd321x
-  reg:
-    maxItems: 1
+      - ti,tps25750
 
   wakeup-source: true
 
@@ -32,10 +31,55 @@ properties:
     items:
       - const: irq
 
+  firmware-name:
+    description: |
+      Should contain the name of the default patch binary
+      file located on the firmware search path which is
+      used to switch the controller into APP mode.
+      This is used when tps25750 doesn't have an EEPROM
+      connected to it.
+    maxItems: 1
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,tps25750
+    then:
+      properties:
+        reg:
+          maxItems: 2
+
+        reg-names:
+          description: |
+            The first reg is PD device address and the second
+            reg is I2C slave address field in PBMs input data
+            which is used as the device address when writing the
+            patch for TPS25750.
+            The patch address can be any value except 0x00, 0x20,
+            0x21, 0x22, and 0x23
+          items:
+            - const: main
+            - const: patch-address
+
+        connector:
+          required:
+            - data-role
+
+      required:
+        - connector
+        - reg-names
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
+
 additionalProperties: true
 
 examples:
@@ -68,4 +112,36 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec@21 {
+            compatible = "ti,tps25750";
+            reg = <0x21>, <0x0f>;
+            reg-names = "main", "patch-address";
+
+            interrupt-parent = <&msmgpio>;
+            interrupts = <100 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names = "irq";
+            firmware-name = "tps25750.bin";
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&typec_pins>;
+
+            typec_con0: connector {
+                compatible = "usb-c-connector";
+                label = "USB-C";
+                data-role = "dual";
+                port {
+                    typec_ep0: endpoint {
+                        remote-endpoint = <&otg_ep>;
+                    };
+                };
+            };
+        };
+    };
 ...
-- 
2.34.1

