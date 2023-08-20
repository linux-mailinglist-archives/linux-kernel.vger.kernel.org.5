Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FABC781F92
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjHTTi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjHTTiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:38:52 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C43D2134;
        Sun, 20 Aug 2023 12:33:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-64723bb9e25so16764596d6.0;
        Sun, 20 Aug 2023 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692559982; x=1693164782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKqxHlL6S33Pr4y3qopawUk7KhylcyuWgODSlq/ouzk=;
        b=F+UIn237LlM8gMVi90hBLPT+JWXuLEiPxAQpYpaKrwTpi6nfeFEYBL0aANf5cE1elj
         o/IESFAV3+vS36UWEt6+mCLuQORj4yzZASACplR9nBic+2m9fDA0TzloovT3BL6bJhdK
         j8f4svujX44nQaaexDE9ZV7DIUT+q9z1BALyJNveN4VQuAcH2r35HvnRtisLOMZVnGte
         IdSyB+FCdXq55ccDv8GdBQcIYrlBI6gsMXl4kyA4oFtHaM0zkVwKMbkXVxIkV9TQ8ZT2
         nm3Pb3i8S0dmXaUS/SjjpxY26PYELwXtHycbMYmmlIxVpaCXkCD82k/HxKpQb1Wbukmn
         7s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692559982; x=1693164782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKqxHlL6S33Pr4y3qopawUk7KhylcyuWgODSlq/ouzk=;
        b=fnHMmHgRcjL4KatlblbStyNyMeEkG6iFEtcCWlQD7QPqx00cno0yGXFzOMPHAWtVmo
         SfKmUuAY0uZmEdb6BNhAqHg+9kJ59wDDNjqRdjksILroHHVnI4GkFkqsUgl1+DzOWDUP
         R0AOpzM4GQtp5iRjfKZbT2Kwt8bIE2BshXxyEXP5hZKL82bRcYkens+DWbDO6H2yZJft
         DRdHE8RuyO+xfWhWvPy5N0iUYkrlsUok/j3wwrvtly4MGDIo5lG+jST1Xr6LxijkH+3r
         Q4gftujbdBIxPVjuJwDUn0K3YKAn0D6oNqJsqvb1xwotFDsZMTqpjzPfvuV7ESJgf4Wv
         r20g==
X-Gm-Message-State: AOJu0YxpLExJRS16mocy33aoBeom/kfXi2wZyXOUSluUXwZgSa50/twc
        aRz8GH2I6mMpEWGc1CeeEPo=
X-Google-Smtp-Source: AGHT+IG/+fnUpOzIwZAKDotebz9hyOYUSrO4IPB8Dj+2/y/GQ/vy0CWMnFRHev9zK9RegHmaMeWCNQ==
X-Received: by 2002:a05:6214:5b07:b0:649:791:c0ac with SMTP id ma7-20020a0562145b0700b006490791c0acmr5475829qvb.22.1692559982536;
        Sun, 20 Aug 2023 12:33:02 -0700 (PDT)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a0cf2d0000000b0063d0159e1f6sm2308042qvm.109.2023.08.20.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 12:33:02 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abdelalkuor@geotab.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: usb: Add ti,tps25750
Date:   Sun, 20 Aug 2023 15:32:26 -0400
Message-Id: <80a05bae7210e9b4aa842dee971639969405d689.1692559293.git.alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692559293.git.alkuor@gmail.com>
References: <cover.1692559293.git.alkuor@gmail.com>
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

TPS25750 provides power negotiation and capabilities management
for USB Type-C applications.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v4:
 - No change
v3:
 - Drop typec label
 - Use typec@21 as node name
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
index 000000000000..c658cb7ddec9
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
+        typec@21 {
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

