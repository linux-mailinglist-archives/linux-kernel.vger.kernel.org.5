Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9507B3533
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjI2OcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjI2OcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC6410D7;
        Fri, 29 Sep 2023 07:31:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad810be221so1928424366b.2;
        Fri, 29 Sep 2023 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997917; x=1696602717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gorcjYjN49NAZEdNmuGyOjw/6rU6U5kxJc+ErxPrr8=;
        b=aUUKttNEaTM6BKnYPWhs9R+S1ao+hVAJoWCkfOFSA2e4fssaBscRKR4r/sMGLSg0eZ
         9LobkIyOpLFdupc3jeDv/URy8PfPshgRR+yijBMa1UrG4WP26vZtnIdR9w6jbCBaYITr
         Kwri954BX/2PiAQ4QCGbeoLzeaMFpgs35pwNDkEOo4uwtCNpWBBLrh665uieyrR4YGF8
         6vC3A0e0jkTCKH/HDHA1SPv/Sc1S0sJNGnerYeqs8q1uknD8S7uBHhymQJauUoKSo+e0
         0B0C3pQB+XJLMsjKzkmMU3VIvst6TX5L1Vpd9tV4JnreRLRXevewyVkaCmlmcd4GzQ/x
         fnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997917; x=1696602717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gorcjYjN49NAZEdNmuGyOjw/6rU6U5kxJc+ErxPrr8=;
        b=hp9aNYD5rDBu35xskEc5a+cUwRA1AyUcKUjMy/kgCiDCptECa+bKUrD/xZqFwROKcc
         6CofK2FgLl7mpSLXeMc+GmK4zqCmJflkKIJ8TwCEX+w2pGtshlPzUX1WH5MoXBzzxj1a
         qFaaTACgvL/3RjtE9A7dPqArXhnokhJbu2ZlyF7NqaAB3u6GbQQDWkanKFDkmaFyfy5m
         i1ZRrQWyUeXCRKisma/vy257fvHNgBY6T1mn/Dj7anC1lnJXx2ag2vZYFv4CXxrkSWXt
         6rq+SW3YTDem7GKisRkAHyf7mpjliAIiyZtQdHZYsj39Np8eBxeS6EfodWH459hX9fbV
         iTbw==
X-Gm-Message-State: AOJu0Yx3c+1UlbibdDxrXdzSx17qauzHnvWNgO1RqMrGb3hfiQGIkwI9
        GyWtCZUnjO/FkX5fS3Fm7L0=
X-Google-Smtp-Source: AGHT+IFmuALX3FXtk4mGwNdr4fEQwVnLdS3KJkvDr9qnxI8h7hi27ZV680wNfIrM3B6QxD3gNkG+pQ==
X-Received: by 2002:a17:906:51d8:b0:99b:627b:e96d with SMTP id v24-20020a17090651d800b0099b627be96dmr4061338ejk.44.1695997916718;
        Fri, 29 Sep 2023 07:31:56 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:31:56 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 01/14] dt-bindings: usb: tps6598x: Add tps25750
Date:   Fri, 29 Sep 2023 10:30:42 -0400
Message-Id: <20230929143055.31360-2-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929143055.31360-1-alkuor@gmail.com>
References: <20230929143055.31360-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 is USB TypeC PD controller which is a subset of TPS6598x.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
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

