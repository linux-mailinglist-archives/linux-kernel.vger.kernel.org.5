Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51027801F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356300AbjHQXxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356305AbjHQXwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:52:55 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB5735BF;
        Thu, 17 Aug 2023 16:52:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4103fdba0fbso2623021cf.3;
        Thu, 17 Aug 2023 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692316373; x=1692921173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ0G1EvgU1HC0gxjA7w5dxfWvDoQ5EWsfP+3vCAXEN8=;
        b=YBg7iTjAjAK8mG3OkUrv1uRt6brhKKSOQqiMWvmOm1WEUHtRm5rcAMPnAUxlrgIgp0
         AER5Ue5x/i4CtoqkJ/MYLkDnD73p/6R99PsmKOWNJMdm0TlM1+V2creyZaPvJAycvBQf
         7K2B7WTKEzMH1y7epPZhqebIxKIbBin4nubPiL36i9kf1s+knCNYOuzYj/kiLG3BKI3k
         SyR7lWVEJA8+uYHLYzPSdCnk2tBL0DQdN8wCIlI17oSRj6D9WHJAMYGO1ND30LClFpw3
         KzVQ0zUwMh7rGTgjZw4tD1v4yYJrLuY4S/WPWXfBzXL6KL9zcmQT5amSR1jQFvQeAETj
         CSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316373; x=1692921173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ0G1EvgU1HC0gxjA7w5dxfWvDoQ5EWsfP+3vCAXEN8=;
        b=bP6RhL8O81aCR5sKR7RrFFQjZUjxEajzYDy21A1+/2UatO9AtUqDHpJpBIKvRZr+a9
         L1gd2c5B8/0IipJdY5zGcLqOhsNyAwI7VHGkvN1Ir2+lX4biCfj33Jiolbsv1HF05jy1
         08OXGp6Yc5yD4HJs9c/2MTjrVeQ7jC/40STV6I4sjSLpVncioTWRDM+6FcdBY+iS8Dwj
         ifrB6uSPyXgbwRPuWmZVj7xrLxjOnMvwMubEemR3Hp+Vl43b+cnpfwaHCFy9j4tPZzBA
         vHMSiL9415kPA8FDGkIw7kU9p8raaQaEQXPkoSdzigSd1vjIQ+r96erSFyvoou5JwJRj
         VtPQ==
X-Gm-Message-State: AOJu0YyHzxLxK5KS5i4vPfhnCW5P1mtUBgdFsYFkbt0basL00eIkDAEY
        kh5V+TfAR/ItCa2BJxpz9JlJPjKVAdXLLA==
X-Google-Smtp-Source: AGHT+IFo2aePLz6YbpD+aEmNktkj8NrQwK/eej9BAsFzXrRmP1DuZaT1nzX4cBiP+iGYnSU5GFQ2bw==
X-Received: by 2002:ac8:5981:0:b0:40e:a3cb:a1ec with SMTP id e1-20020ac85981000000b0040ea3cba1ecmr1243179qte.10.1692316372781;
        Thu, 17 Aug 2023 16:52:52 -0700 (PDT)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id e16-20020a05620a12d000b00767ceac979asm159798qkl.42.2023.08.17.16.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:52:52 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH] dt-bindings: usb: Add binding for ti,tps25750
Date:   Thu, 17 Aug 2023 19:52:12 -0400
Message-Id: <20230817235212.441254-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
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

TPS25750 provides power negotiation and capabilities management
for USB Type-C applications.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 .../devicetree/bindings/usb/ti,tps25750.yaml  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tps25750.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,tps25750.yaml b/Documentation/devicetree/bindings/usb/ti,tps25750.yaml
new file mode 100644
index 000000000000..326c9c2f766b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,tps25750.yaml
@@ -0,0 +1,84 @@
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
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: irq
+
+  firmware-name:
+    description: |
+      Should contain the name of the default patch binary
+      file located on the firmware search path which is
+      used to switch the controller into APP mode
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
+        tps25750: tps25750@21 {
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
2.24.4

