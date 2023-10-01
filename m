Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205987B45F8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjJAIP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjJAIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001D4C2;
        Sun,  1 Oct 2023 01:15:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2cee40de8so464555766b.1;
        Sun, 01 Oct 2023 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148118; x=1696752918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGpDxcT5aeITQfH2zI83I7bXWv8lEzILwF0J/4qGo+Y=;
        b=KkOyL5ES7i9q8GzliIAxFb+3VPZ8uBJloVMnbZ0baox7njgRc+AGRULZSxqpr0zxDf
         fq6NgCyTH+eMoemcSzF30STP1EQc4sZYLSYfXQ14CxvNd8l0bjer8pjUMOLIsiOrSNCd
         bdM55YDq4KHY3I4msyk2StjgOP7O151EQo3Zw7uwJ64Z24SuepvxXCVy+rpe60wCEVGv
         IsJmJoi3oSbTU6X6PntX4UL/AEOtbEiDJViD3y3i/+9zzGy3glixT7OCZyWQsJ6DHSc1
         GUghF21vuSDQ2taKKgWLzJzU53KquoZkz54chZ/YCxod06hqUIY85OWM71/JzNQocHTW
         dQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148118; x=1696752918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGpDxcT5aeITQfH2zI83I7bXWv8lEzILwF0J/4qGo+Y=;
        b=gAUAcUyis8gx3+0Y790WtTTz3svF4VmRE49Q0bowVaBLDms4D9BZEsn/iBJBvNOuzV
         fKIL4haDuKqxTqMs6lGjc8tIeziTUzbxShYSriqwTMvUtXcN4KJ8l0sjvmsRJ7alx0Gf
         smOfLInfzJ2j45d1Y6WGJs59e6NfQcvQ3cvoEa48XzN1ktiuY4Y/3mMBBJebgLmGVszc
         +UijejVNqiEMPOO0wv7s38q1ITgYqwgNSnqabXfKLoU4/QWmcgBSrxo1m//qxj70OLUa
         yE6fvwGZgqp+gFqmrRIiAss6KjtI81vnotS/MPPMjx8ENLDYwiStYxdU+KbNPH/1YMJR
         szRw==
X-Gm-Message-State: AOJu0Yxzpeq6SPyw/isI2fBvoglg3QxwFwHZGUimUi+1xcSsrYf9B15t
        BMg6ICN4g1U+zeAZ4W8dsbk=
X-Google-Smtp-Source: AGHT+IHIKuKziaTPs/SvMhhF5Zkuf6L4ps6cFZ7uLtEsBgaVjFj11OU6BXG0g3PD77GfV9LSmBb3Ew==
X-Received: by 2002:a17:906:225c:b0:9a1:f1b2:9f2e with SMTP id 28-20020a170906225c00b009a1f1b29f2emr7570192ejr.2.1696148118076;
        Sun, 01 Oct 2023 01:15:18 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:17 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 01/14] dt-bindings: usb: tps6598x: Add tps25750
Date:   Sun,  1 Oct 2023 04:11:21 -0400
Message-Id: <20231001081134.37101-2-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001081134.37101-1-alkuor@gmail.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
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

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 is USB TypeC PD controller which is a subset of TPS6598x.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v9:
  - Add Reviewed-by
Changes in v8:
  - Define reg-names at top-level
Changes in v7:
  - Define reg at top-level
  - Remove description from reg-names
Changes in v6:
  - Use reg property for patch address
Changes in v5:
  - Add tps25750 bindings
 .../devicetree/bindings/usb/ti,tps6598x.yaml  | 81 ++++++++++++++++++-
 .../devicetree/bindings/usb/ti,tps6598x.yaml  | 81 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index 5497a60cddbc..72ac534e6ed2 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -20,8 +20,23 @@ properties:
     enum:
       - ti,tps6598x
       - apple,cd321x
+      - ti,tps25750
+
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: main PD controller address
+      - description: |
+          I2C slave address field in PBMs input data
+          which is used as the device address when writing the
+          patch for TPS25750.
+          The patch address can be any value except 0x00, 0x20,
+          0x21, 0x22, and 0x23
+
+  reg-names:
+    items:
+      - const: main
+      - const: patch-address
 
   wakeup-source: true
 
@@ -32,10 +47,42 @@ properties:
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
 additionalProperties: true
 
 examples:
@@ -68,4 +115,36 @@ examples:
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

