Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506F77B6DCE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbjJCQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjJCQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:00:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF557BB;
        Tue,  3 Oct 2023 09:00:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso995610266b.0;
        Tue, 03 Oct 2023 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348849; x=1696953649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmf4MgI08O7TLQHH46C4kwnnpl2Ocx3hEFAIi/9wvzY=;
        b=bPmM/cAByeyK+nuwvVznnMT4KCizBG0MP3tRtKAxmzgJYj6xk9qbhkSPUHpajkvtJw
         B+0ohlOK4qZMqIL37Xmbn1Nm4m/D/wOAoAnSEd6xmD6KgRYmYZssEWJc7CJRXy+0NBXb
         k8Igrd9K9pbopFCe3r4zNajb+PRqwe9+yE/THuurrrUrX7FVY9nOIL0k8igRUbGHh+K2
         Ml+45QHmAi3RgjzmlxrhSFwAf0ktSsmk9LSQSBBYzqgDz0RVIeRwgt/+o3DpefoBM0FY
         tuF2AgpB/NkMcvgfXUBfe8xpe+I7MqDUDZaO50b0HnHi6TPhqZSlNDY08bmqSyMxR5sz
         h75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348849; x=1696953649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmf4MgI08O7TLQHH46C4kwnnpl2Ocx3hEFAIi/9wvzY=;
        b=UUGu5PhV7po68JUE2l9nW63Lgzb0WiabIWKWASL9UKtGvg3eSPEvxXeP43NnnCzPcc
         AxdEIYd1w4djrsy9r/9ko1ujIuGtT53pzen0PbzZiPkoC7xK5ln6O8NDP3LuC9t86Jn0
         XkOfPP4vz1mSq0iU1LlySzeeqp+/KcbR5uuF942UjlDJAZM8pz4KmjBNLP/ssRYuSkaa
         TXboh6hKflDnzNZFxMpr6+IeloR2hdDnFYfuLO+cSM7+ccs2Sj922E+VWXkRutr3NguO
         g+QX0XZavGO8zXmBM0niKgdXcqOWAsyiw2JCmdA/fITCkiaGbl6WX6hM14m4I3FcyTGm
         RFsA==
X-Gm-Message-State: AOJu0YxTGzdhrBBsxIlLbP80eVub5+5VfcG+Ae7Z9DoNMYpzRP3kluZa
        cNmGne+IYBy0f5JU/YOKAAk=
X-Google-Smtp-Source: AGHT+IFJBn2pJIjc5XFzkvoYv9YgYcIrHv0sFdQN9cH8VTa3P2yYXAV+Nm9tLOLs8LSmF7LiDVKeqg==
X-Received: by 2002:a17:907:60d3:b0:9ae:3768:f0ce with SMTP id hv19-20020a17090760d300b009ae3768f0cemr2840604ejc.0.1696348848813;
        Tue, 03 Oct 2023 09:00:48 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0099df2ddfc37sm1270526ejb.165.2023.10.03.09.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:00:48 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 1/9] dt-bindings: usb: tps6598x: Add tps25750
Date:   Tue,  3 Oct 2023 11:58:34 -0400
Message-Id: <20231003155842.57313-2-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003155842.57313-1-alkuor@gmail.com>
References: <20231003155842.57313-1-alkuor@gmail.com>
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
Changes in v10:
  - No changes
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

