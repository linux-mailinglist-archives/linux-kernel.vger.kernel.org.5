Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000DC784B90
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjHVUna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjHVUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:43:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713FC10D;
        Tue, 22 Aug 2023 13:43:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3feff2362fbso4067205e9.3;
        Tue, 22 Aug 2023 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692737006; x=1693341806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD3sULWbpFRWziOX0LtxIjs7iHTJSZAnksomDUCWlP8=;
        b=sjFFs0W1etlRT3SzqjIjbgAprfJllIK9/UqSMigLiPAptwSewNR71/EC51NXJLDM8C
         x7uGzatIeqlvxVzwfcfCcccykqXh/3mikjr4lNSPJUnNYRbbFnyVcmMotFAQzlWNdASY
         l8O5zlFdZy0ckNBMvkQ0ssVL8Q+zO4rmUgRXfmgNsDE7vZtlU/45CCfyOVj89Shh5WsP
         Wp2k0dgzY4zPxicX2ylzr6Ns8jg0/FdG9ki7G9rIbMVidnzYvBeacKKaC0iAG6pvT2Z5
         9wnZA5oXx62/D8MHvaHuHm9HEWJ3zTAt8R8n83r8Fgt8NzuWbjxiOZgozRUCSam0C9US
         9GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692737006; x=1693341806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZD3sULWbpFRWziOX0LtxIjs7iHTJSZAnksomDUCWlP8=;
        b=JgACK8UL3qP5kMwCQ9MPqKp/fZrazLDPY5xmmcOaZvpRqjKxgbw7Uyq6JOzYmDzdTy
         5aPA645hlkr2Jb555CGWnAdOCLkvzHThDELcOIb2b8DldRRGJBjFEHjx7MBQpTj3QSja
         A1q3crOKre217M5zHepByuPrY9IBsvBNJQ9XjzshGOesiduxVZiL4zhFoMkxR37ukAVR
         DycqtqaRmFFsIbrGdIsixNscbdRkDs9NILNR0nXUdnmnB2z702lqZDUpOBQX3h6DJlZM
         +lOZX116JgK5PuPWHbTPIUTNDG9Zj3fHHh+tNerysMfxMv/pIP+o8/KHzrYUtXNbdHP1
         pRlw==
X-Gm-Message-State: AOJu0YyM87a6KUFBtzMzMyjJ8CNbJUnfDOx2hSyHk7pFKF9hU6XZ+4fF
        A9MhMpp6coBcOTVUoSFWNRk=
X-Google-Smtp-Source: AGHT+IGLqETrin1+3JZvy484W9YMIdwIOYSeS/8ZWaw/ylVGxoFuVP+2Z32MEeUjRRhS4W2w2HaqSA==
X-Received: by 2002:a05:600c:b42:b0:3fe:d780:4f7a with SMTP id k2-20020a05600c0b4200b003fed7804f7amr8287028wmr.3.1692737005675;
        Tue, 22 Aug 2023 13:43:25 -0700 (PDT)
Received: from localhost ([78.242.174.90])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c249400b003fc04d13242sm20298322wms.0.2023.08.22.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:43:25 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: phy: st: convert phy-stih407-usb to DT schema
Date:   Tue, 22 Aug 2023 22:43:21 +0200
Message-ID: <20230822204321.54716-1-rgallaispou@gmail.com>
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
---
 .../bindings/phy/phy-stih407-usb.txt          | 24 -------
 .../bindings/phy/st,stih407-usb2-phy.yaml     | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 24 deletions(-)
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
index 000000000000..abd6fa0260f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml
@@ -0,0 +1,64 @@
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
+  The USB picoPHY driver is the PHY for both USB2 and USB3 host controllers
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
+    description: List of reset signal names.
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
+    usb2_picophy0: usbpicophy {
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

