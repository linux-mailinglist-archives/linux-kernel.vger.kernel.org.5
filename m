Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28A4780F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378032AbjHRPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378193AbjHRPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:31:03 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0DB420F;
        Fri, 18 Aug 2023 08:30:48 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40fd2de0ddcso6722581cf.2;
        Fri, 18 Aug 2023 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692372647; x=1692977447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EovJ1fXMMd2dM0JF3L0MbrSsBqCZpLKmOn2nea/Ku5k=;
        b=M9ZS9vZdYQMh6oasfvZS99zeQYafduR+3Myt1uDdzI9OoIvqNklpegDyEvTi/rQnYQ
         eHVMoNmuMuS8mV8pmO71GC5cr8C/vluVc1eEcIkx4nlzIjdrdAoHBaS8iVRp88R9CrBD
         C5p2lZtFl2Y+24u15ZWoCYlG43afJkltyHgKrnnJ5+ErHza/UYl9g/FgC7nFdvCF9ynq
         XCHUY4aonQebAIW7ZOm5HAsAzXAXRgJNlIdMwXG/oVEDtU2bKxswOFJyYKEgf0UZwxK7
         PswDBTN3k/J6cIGQkn31nsXCwQxr/iabnPdPr0DNELgbyFi/d52E6raToY6M0z4DGi5I
         FbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372647; x=1692977447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EovJ1fXMMd2dM0JF3L0MbrSsBqCZpLKmOn2nea/Ku5k=;
        b=Lp2uhAZu6HZnEWc4d9mzHjylKmewxqOLhzSXKOJTopwm6HA1+8SjehU0WPF2SbPwiP
         gnboEMzoDXZ9JNCT2hTYHl+sxjv8aJaEfS9VMoAnOfs/bZufz1pbbQgHV7eRa5iMOtUw
         tWBKRNTF1aD7BWxwfPYlLwjd6aZFflXFyzyuJ8K/hRLf7T93sHKZhHWQQ3xQaHhO8pS7
         Ge+yvnoyvXQSZCdi/IDZK6IuKn5mf+seHl1R6t3eWwL7l0DW90/VflVwzjefA90nGVW8
         N7+IvMBY0u1etCyUwy3ittVLFVYb/wmoS0q6mRpkM+xILLbKZOsyT0T/M0BnaDGFRHxA
         Hv5w==
X-Gm-Message-State: AOJu0Yx4dDCwC9jVYAY+F5oYb4gNX17m2T4DhFMhybf4OcEmzios1l3t
        A5+mwNZbELuv/eRVY8n4nwsCn+Y441CH2g==
X-Google-Smtp-Source: AGHT+IFJYRo7zcZ81XXrqon9epCCaN6aQ8Kq4ALBK6MLgbNJ3w/AD6oiWyZazy/6HokG71CgoYD7bA==
X-Received: by 2002:ac8:5bc9:0:b0:405:5ae6:9f3e with SMTP id b9-20020ac85bc9000000b004055ae69f3emr3871100qtb.33.1692372647350;
        Fri, 18 Aug 2023 08:30:47 -0700 (PDT)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id b16-20020ac87550000000b003f9c6a311e1sm582850qtr.47.2023.08.18.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:30:46 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH] dt-bindings: usb: Add ti,tps25750
Date:   Fri, 18 Aug 2023 11:30:15 -0400
Message-Id: <20230818153015.513053-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 provides power negotiation and capabilities management
for USB Type-C applications.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
v2: 
 - Remove redundant word 'binding' from Subject
 - Add new line before reg property
 - Remove unused description in interrupts property
 - Drop interrupt-names property
 - Add maxItems to firmware-name property
 - Use generic node name 'typec' instead of 'tps25750'
---
 .../devicetree/bindings/usb/ti,tps25750.yaml  | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tps25750.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,tps25750.yaml b/Documentation/devicetree/bindings/usb/ti,tps25750.yaml
new file mode 100644
index 000000000000..d98c34df340d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,tps25750.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,tps25750.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments 25750 Type-C Port Switch and Power Delivery controller
+
+maintainers:
+  - Abdel Alkuor <abdelalkuor@geotab.com>
+
+description: |
+  Texas Instruments 25750 Type-C Port Switch and Power Delivery controller
+
+properties:
+  compatible:
+    enum:
+      - ti,tps25750
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  firmware-name:
+    description: |
+      Should contain the name of the default patch binary
+      file located on the firmware search path which is
+      used to switch the controller into APP mode
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+    required:
+      - data-role
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - connector
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec: tps25750@21 {
+            compatible = "ti,tps25750";
+            reg = <0x21>;
+
+            interrupt-parent = <&msmgpio>;
+            interrupts = <107 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names = "irq";
+
+            firmware-name = "tps25750.bin";
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&typec_pins>;
+
+            typec_con: connector {
+                compatible = "usb-c-connector";
+                label = "USB-C";
+                data-role = "dual";
+                port {
+                    typec_ep: endpoint {
+                        remote-endpoint = <&otg_ep>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.34.1

