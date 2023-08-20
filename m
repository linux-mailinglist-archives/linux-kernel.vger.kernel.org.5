Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB0781CA5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjHTG0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjHTGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:25:48 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E9F2A3A7;
        Sat, 19 Aug 2023 22:25:15 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76da22c090dso33536085a.2;
        Sat, 19 Aug 2023 22:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692509115; x=1693113915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZpgsiXVcupEckyvtiilqx+TaORBceXJquyTxWWGa7Y=;
        b=i+Y9xCZRsGp0xjK0wcQfERrj5CJruPSBcdnxrISp17zdZgGo3LF4Gd2snPbO48NeJC
         nsE4t22KtQX8WyND7qFpxK2Ap4LyBqDFSUSSJxL3/Iz4tHSzLB28y10Yt1LwqkDn0ZVo
         H/nCjhYv3XCxuwCsCKUiblA8WEL6pPiNUQNi6rofZtDgmHrYcXQ4QwSggsYYiMmY60Ej
         tT3UvW4G53XqQ+aZwwHbV9IUaVCrRD8gFu39v50iyfPSygH0UzoAxIShKe/K0cmF3iEa
         2oFeqKMZ1FHdRapShIhYgplQtcCcUvUFNC/FlWKARlhwTzGeS4MuskX9P8n7IlEQyOEi
         oZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692509115; x=1693113915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZpgsiXVcupEckyvtiilqx+TaORBceXJquyTxWWGa7Y=;
        b=MZQaHMEGUgY5ENLTXoIjJLTSdfuIvjDIOYwaSnMEY9IGf+tvNHP3hR0S8TGqWzdJ3+
         sPoiPkDznZVAemp/hs9PkWkNORNBUCnXvgziMNwFgIdep0+pAh0oaBd/QPJkDdmcOSH/
         1XgyXuNVYQv6cni6BsoCo2FbLvZBDTmd6BDu4wIJkFNbPdoRSoXZyIOj9KVYhsB7RDob
         NZdPcRkgX3LGIywWafokAD7648vilqiQoasKuuK83OK3QMHeJWxc5UQEnFj5NTUujky0
         pTONHWs6AxbYySMfI0QjIyiAB/ebwroGIQgfdsACha6aS80FShRIx0O45D3W/KGb/hfK
         zPDQ==
X-Gm-Message-State: AOJu0YyDdVQv3SWS/QYAyjV8XeYZKxM6N/LhMv9yPJVcyV96GH44G6VX
        FPRXdEELqkFX5T/Hjsh1yns=
X-Google-Smtp-Source: AGHT+IF0onSYHl1niRTUuR7vetqnuw5wA+F7lpHyFTpPugCdKVst2ts10STkgRIa07uLM29xjDgFIw==
X-Received: by 2002:a05:620a:1a0f:b0:76c:a957:b2d6 with SMTP id bk15-20020a05620a1a0f00b0076ca957b2d6mr4393042qkb.24.1692509114893;
        Sat, 19 Aug 2023 22:25:14 -0700 (PDT)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a165000b0076da29c4497sm307750qko.112.2023.08.19.22.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 22:25:14 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abdelalkuor@geotab.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: usb: Add ti,tps25750
Date:   Sun, 20 Aug 2023 01:23:15 -0400
Message-Id: <fc8a793aad8a84ee4658e630b7be2b04925a66c5.1692507038.git.abdelalkuor@geotab.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692507038.git.abdelalkuor@geotab.com>
References: <cover.1692507038.git.abdelalkuor@geotab.com>
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
---
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

