Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962A778591B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjHWNXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHWNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:23:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAD8E75;
        Wed, 23 Aug 2023 06:23:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317c3ac7339so4836248f8f.0;
        Wed, 23 Aug 2023 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692796968; x=1693401768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzn+5bTpnSMNwUuNyyowNMIJDQZpkAi+7c7mgKTYoME=;
        b=r6cn6rzIz0BUUjfTlEntcGmnQ1emT1LcuHfH0giUjqFalgnkFVgfmPmYn4JnZIGvGd
         8vq36GiD1N7HPhbhCHGX/Vxtvs65nKwerH03TLGgA3Jh5i1/nmPkBqtxZiXkbYi8oD6w
         K1UDpRQ5E5lLyAgjOBLJlKxACcWjaQUsQW2UVrjreVK0Idl3G7ovSzSNA8ZESvKUFo0M
         ecZOdNlHkEQ4Ydi6elupAad5t7dKX48Z6n1ZhtAKWKVyVA57ib5L1rjRAO57N1NXxj7E
         p7WSuw7k1/I+LKkLYV9HyAAmeIPbanf8mZR+mwtRVA4R9Ttdiuz3m5nwzUIsTQZjLgj4
         FRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796968; x=1693401768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pzn+5bTpnSMNwUuNyyowNMIJDQZpkAi+7c7mgKTYoME=;
        b=TtCByPA6kzGkHy6R4HEjqHuLQAzA+YyJiTpd5DvuvXWzixhOctoIpGKFRtUgBmSXGL
         JAqWTVdGPdXlNsmH0ms+sVmZV7DQqJvS2zngIwMQY9RKSP/IgTfmnPPuqKATBKyi+VFZ
         opaHJTAbd0SCZEG/0JmRSXQV1I87wx91qZ9SphJvcF4Da/ec+a9+b1XyDSsY3Quqc/ug
         ES39q88ik1oGfYe5kEj1Fi934heXIgIP8uZhQqXtvpOIbRDcR/jBQ1TVETALQykLmq04
         VMO6RxtqnpzVYxbglZrvmDLAIHBj0AnOMX32fS2LNeStwSSw4xwub/8JpLVMRhCEikbB
         +x1Q==
X-Gm-Message-State: AOJu0YwIRFFj8MeN+m8Hm1DP/ZWbZu7eUu1KoHMGhPzZiKXb+VL/nvFs
        LpOji0I6nGkYHAXqJgG1wRM=
X-Google-Smtp-Source: AGHT+IE1gUkkpuMyRPjYkQSA46YH3/bOWjgb5ixYadB1u37Wfo9A/dssTd2q0MBm9JbD7/LteuPZ8g==
X-Received: by 2002:a5d:4573:0:b0:315:ad1a:5abc with SMTP id a19-20020a5d4573000000b00315ad1a5abcmr9228900wrc.5.1692796967751;
        Wed, 23 Aug 2023 06:22:47 -0700 (PDT)
Received: from localhost ([37.174.115.23])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d68c6000000b00317f70240afsm19353163wrw.27.2023.08.23.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:22:47 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: phy: st: convert phy-stih407-usb to DT schema
Date:   Wed, 23 Aug 2023 15:22:24 +0200
Message-ID: <20230823132224.111326-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Convert the st,stih407-usb2-phy binding to DT schema format.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v2:
  * Removed quotes surrounding $ref
  * Removed quotes surrounding const properties
  * Changed 'st,syscfg' $ref value to phandle-array
  * Changed authorship to my oss email address

Changes in v3:
  * Remove driver references
  * Dropped obvious description
  * Dropped label and set simpler node name
---
 .../bindings/phy/phy-stih407-usb.txt          | 24 -------
 .../bindings/phy/st,stih407-usb2-phy.yaml     | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
deleted file mode 100644
index 35f03df00130..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-ST STiH407 USB PHY controller
-
-This file documents the dt bindings for the usb picoPHY driver which is the PHY for both USB2 and USB3
-host controllers (when controlling usb2/1.1 devices) available on STiH407 SoC family from STMicroelectronics.
-
-Required properties:
-- compatible		: should be "st,stih407-usb2-phy"
-- st,syscfg		: phandle of sysconfig bank plus integer array containing phyparam and phyctrl register offsets
-- resets		: list of phandle and reset specifier pairs. There should be two entries, one
-			  for the whole phy and one for the port
-- reset-names		: list of reset signal names. Should be "global" and "port"
-See: Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
-See: Documentation/devicetree/bindings/reset/reset.txt
-
-Example:
-
-usb2_picophy0: usbpicophy@f8 {
-	compatible	= "st,stih407-usb2-phy";
-	#phy-cells	= <0>;
-	st,syscfg	= <&syscfg_core 0x100 0xf4>;
-	resets		= <&softreset STIH407_PICOPHY_SOFTRESET>,
-			  <&picophyreset STIH407_PICOPHY0_RESET>;
-	reset-names	= "global", "port";
-};
diff --git a/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml
new file mode 100644
index 000000000000..e45cdd98aab2
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/st,stih407-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STiH407 USB PHY controller
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+description:
+  The USB picoPHY device is the PHY for both USB2 and USB3 host controllers
+  (when controlling usb2/1.1 devices) available on STiH407 SoC family from
+  STMicroelectronics.
+
+properties:
+  compatible:
+    const: st,stih407-usb2-phy
+
+  st,syscfg:
+    description: Phandle to the syscfg bank
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to syscfg
+          - description: phyparam register offset
+          - description: phyctrl register offset
+
+  resets:
+    items:
+      - description: Phandle and reset specifier pair for the whole phy.
+      - description: Phandle and reset specifier pair for the port.
+
+  reset-names:
+    items:
+      - const: global
+      - const: port
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - st,syscfg
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/stih407-resets.h>
+    usb-phy {
+        compatible = "st,stih407-usb2-phy";
+        #phy-cells = <0>;
+        st,syscfg = <&syscfg_core 0x100 0xf4>;
+        resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+                 <&picophyreset STIH407_PICOPHY0_RESET>;
+        reset-names = "global", "port";
+    };
+...
-- 
2.41.0

