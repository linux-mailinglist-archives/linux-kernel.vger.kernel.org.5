Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F277B0B61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjI0R5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjI0R5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:57:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C836A1;
        Wed, 27 Sep 2023 10:57:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so9810578a12.3;
        Wed, 27 Sep 2023 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837450; x=1696442250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TTTzseuuP8hjwAd/NiPB8IAcvjSSkCe6oGYFrHNmxU=;
        b=mN74+OMDMvxtjmHGZICS4GEBUV4eInqBngTcV070k5wK3M8+BgCIsD/FnEyv41qDy7
         49zjCsEFsf4WnV/cbztZFXRlhCIMRx5yYT0IPz9euIFXLCfKYEjmnPhvyC2aSN+Xi8ss
         Vy2QB4s84nGGyi3apFUfKH3+nz+RVpzW2bCmu2ChVx4rBdxYVARxNcZpacRYYSqYQPBI
         mlIyKL534KcUE/K2LQnEBe0KJw3X+eOdbjI0cnZ0NGRChyPFQ7QJwhzTr9fczRLFtNoQ
         Dm/S3neRZ0dq3HZiXugjP5wth5X+7JGe1Zl0J13yrvwdgyP90dvom0xG5NQmL/GymACq
         OnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837450; x=1696442250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TTTzseuuP8hjwAd/NiPB8IAcvjSSkCe6oGYFrHNmxU=;
        b=olXhE2WNecjGHFDjsXwBuOPLRNSkSiiW1R1ivL+3MTiCYIJRkHjMTLKa2Oed+ZXeD0
         F+NgrW1PKj92zX3Ng+7CaCqFWsVKWAUUm2nwiUNVsaxgOmy09BDA3NwbSQjBStIor+oO
         BZyJuVzFJYCzA0XgnVHoZT0NFMRSwcOubvnDz5Y03yLoxjpi4bAgRpiqFxjMBKI1VbfS
         9jN/UryARWcjZmtnLKI4f8vy7QTOpNTUEeXM5oKUKnH2MXURXZQO6z2TjZtVy7PiSHOa
         6bqwGvFThn18YvROMD7UCv0G0T65r5KZ0qzYru46hG6/8vE8w22WQry2lPRdc1QhKbGa
         fGNA==
X-Gm-Message-State: AOJu0Yynxr4W1qv/P3vbmRyK0zv6TVYZy5GnLxM3lpFtEVPUca+HoNWA
        5d37rm28XmmTwMWdehbRbbnGqKby7wVia7iTBo8=
X-Google-Smtp-Source: AGHT+IFsBDydS1HVbzexalbvWNzbeH6PI6ko1Xyxu7X+wcbnVvoG/wV/q8NKkiI0SxAFDuzDmHP/Cg==
X-Received: by 2002:a17:906:11d:b0:9ae:738b:86d0 with SMTP id 29-20020a170906011d00b009ae738b86d0mr2514961eje.66.1695837449995;
        Wed, 27 Sep 2023 10:57:29 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:29 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 01/14] dt-bindings: usb: tps6598x: Add tps25750
Date:   Wed, 27 Sep 2023 13:53:35 -0400
Message-Id: <20230927175348.18041-2-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175348.18041-1-alkuor@gmail.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
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
index 5497a60cddbc..9303d00b89de 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -20,8 +20,18 @@ properties:
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
 
   wakeup-source: true
 
@@ -32,10 +42,47 @@ properties:
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

