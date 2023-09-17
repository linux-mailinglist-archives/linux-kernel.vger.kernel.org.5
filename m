Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D8A7A3671
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjIQP17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjIQP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC3C120;
        Sun, 17 Sep 2023 08:27:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-404773f2501so31256255e9.0;
        Sun, 17 Sep 2023 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964438; x=1695569238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sklpvAcj30UO+GX0DztQzCwJiBeqDyCx8hTAU0gXl9E=;
        b=CnZV3pJ+vnioTkacAboil4MdQW05qIZ2uyW41ygEsS7FUYKPfSwpHj7SjOcTLVbiNN
         cEbO0aamocdIeb8iqGi3Z+Q87NYrKxlARJG4Hv5OtH1zjtkKb2C3ycNdeLwUDRGgNE4l
         8amL7CcK94vW4hs6S1XjgTkiBWtYx9ZrldnT/LYvqmceB5EMTzhCdohcOu/+NOym4dCA
         H8utNvJHD9Jzj24BQRX8sK9L4u4jmtqLJ75Sd4QvvSyKcKdIeys8eIv3FVjejPwH8fzR
         V2g2w9MauNyllCAi32k4/RVdiR6d1sG5iXR026fdKuvgDL37JkbHEtEYox0gMybT5Gk9
         Zv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964438; x=1695569238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sklpvAcj30UO+GX0DztQzCwJiBeqDyCx8hTAU0gXl9E=;
        b=v9UiwikzR+qwsi7F6SYviGCCyI9+0Tt+sOZpEsUYHv22yUll3OfPmGTezSThfuMrlO
         otcEW1X3lElvk5fSi+3JDetq9nR6/XjlfOlckCV/N/Pi3RC+oStkROeH/0r4t+HfEPrj
         u2+XXE2LEm9suJ3rB9lyjwavNhL3oqEINjTHvhaSaHUUkFXXNJjtMmp52IoXbAg85XSx
         a3ZYMBXP6xJ3gk4byTZaEcG/PJ2LuaZEfEmdQnERuDJsbdAM2xjFp55SR9Jnju63DVg4
         zPHvh1WL89DjWr7+VdOWdDYm/2yzxRvlZEt9v+dE9CKP+IiaTX5XMr48z9ga3cMMEOST
         YARg==
X-Gm-Message-State: AOJu0Yz5r4GZAsUSkMv3mWZT0KuETaCQo4ePGOnwPCvafLlfKZm736Bx
        jI+9XCsHlzV7iTkm9LekyUt7suV3f/OL37cDKWk=
X-Google-Smtp-Source: AGHT+IFAlU2KLbwPivzOvNhDV1UMVme5WR2wh+T5rKnTHdLovV+gEmPLm0qVb+TxWDSQpUuCpFvRcw==
X-Received: by 2002:a1c:f717:0:b0:403:b86:f624 with SMTP id v23-20020a1cf717000000b004030b86f624mr5664827wmh.23.1694964438121;
        Sun, 17 Sep 2023 08:27:18 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:17 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 01/15] dt-bindings: usb: tps6598x: Add tps25750
Date:   Sun, 17 Sep 2023 11:26:25 -0400
Message-Id: <20230917152639.21443-2-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230917152639.21443-1-alkuor@gmail.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
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
---
 .../devicetree/bindings/usb/ti,tps6598x.yaml  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index 5497a60cddbc..e49bd92b5276 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -20,6 +20,8 @@ properties:
     enum:
       - ti,tps6598x
       - apple,cd321x
+      - ti,tps25750
+
   reg:
     maxItems: 1
 
@@ -32,10 +34,45 @@ properties:
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
+  ti,patch-address:
+    description: |
+      One of PBMs command data field is I2C slave address
+      which is used when writing the patch for TPS25750.
+      The slave address can be any value except 0x00, 0x20,
+      0x21, 0x22, and 0x23
+    $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 0x7e
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
+      required:
+        - ti,patch-address
+        - connector
+
+      properties:
+        connector:
+          required:
+            - data-role
+
 additionalProperties: true
 
 examples:
@@ -68,4 +105,37 @@ examples:
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
+            reg = <0x21>;
+
+            interrupt-parent = <&msmgpio>;
+            interrupts = <100 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names = "irq";
+            firmware-name = "tps25750.bin";
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&typec_pins>;
+
+            ti,patch-address = /bits/ 8 <0x0f>;
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

