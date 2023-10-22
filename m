Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE367D248F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjJVQaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJVQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:30:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38491FB;
        Sun, 22 Oct 2023 09:30:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40837ebba42so18416875e9.0;
        Sun, 22 Oct 2023 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697992207; x=1698597007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMcf/hVcl9Y942sk0y4rp2whb2upDzTSkcZEnfp5ZfQ=;
        b=mzQkpi4d6GmeJFq7EH+6sYMevfp3XyecEmqprTDog5bhdZK6E8eCPXjzyw1c7sPYpQ
         ax7YWaTEbzAfL39n0Fy3/EvLi1TyZDSahVathpR21fw4PENskkN+CO4xT0VTV8c7kOZg
         vBOLLoy+HBxMhsJXov/IA79eilgXMyJs9tCi1KsNQh/njaYNT/10UmNJeEecsnHI6/gW
         n9ACh+qRd4K1RIL1bXJKiCca62J0K2mItBMFDoWweLusLPtY+gUadlYfyQ+RzZwJAljV
         9ikyDlQkGwZ+2mDy2yLgc6MCArQxTki2XsUr7zB79G3ZT2P861dEAYCI3II5FDy/9mFK
         eU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697992207; x=1698597007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMcf/hVcl9Y942sk0y4rp2whb2upDzTSkcZEnfp5ZfQ=;
        b=Y5TB1sBt7Y3hsBlXkiCYjVrIO6tuF8wNLxgNOAPOxFhT0jz5kEzkah+bgBUacDP36Z
         4Pc12ZXEn1FftmjV4DBgc3uNOAEE6EpeXKhESvrTowpC/fC6ROIOQRY/zgQ/zClLCuAc
         vVGgQHUnh2SyyZ+0TTJmPs+ojO9/WH6GU4jwPQlbzC+QKHCDWtIMU+DB4BVJcOqCsI+d
         tqvyC783ZnHzdz89AjWqnxCeEjug2YfiFCgeLHeqrRZBKmCjMg0o+NoVVI94V81PSTv5
         jcyOkaAkMGV0F3jWt8p9i+GPqy0iJS/fcN1rEh25vU5LtWBifRIvf3E0m9qUnj7O0E3j
         1E6g==
X-Gm-Message-State: AOJu0YyaUvxYbcd6uULAryiJR4ISOqkcFsYiL4LY6w9Hm8KipdGoexKa
        MB+IO8Qag5KhB7MUt6f6yYcn6cNDC3U=
X-Google-Smtp-Source: AGHT+IGM4XnJECS62Dw/iZAKXzBsk+hKeSbM7rXlIH9HhsUHo87ssmwYjMVz+jdwLcXVuRB2xJDpdQ==
X-Received: by 2002:a05:600c:3ba5:b0:406:44d2:8431 with SMTP id n37-20020a05600c3ba500b0040644d28431mr5260416wms.6.1697992207077;
        Sun, 22 Oct 2023 09:30:07 -0700 (PDT)
Received: from localhost.localdomain (141.red-88-10-53.dynamicip.rima-tde.net. [88.10.53.141])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b00406443c8b4fsm12150482wmo.19.2023.10.22.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:30:06 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v3] dt-bindings: phy: ralink-usb-phy: convert to dtschema
Date:   Sun, 22 Oct 2023 18:30:06 +0200
Message-Id: <20231022163006.803800-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Convert the ralink-usb-phy bindings to DT schema.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---

Changes in v3:
 - Address Krzysztof review comments:
   + Use compatible to match yaml file name.
   + Reorder compatible alphabetically.
   + Add missing blank line betwwen compatible and reg properties.
   + Move allOf block after required block and add missing else case there.

Changes in v2:
 - Add missing SPDX License Identifier

 .../bindings/phy/mediatek,mt7628-usbphy.yaml  | 74 +++++++++++++++++++
 .../bindings/phy/ralink-usb-phy.txt           | 23 ------
 2 files changed, 74 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7628-usbphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/ralink-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7628-usbphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt7628-usbphy.yaml
new file mode 100644
index 000000000000..ce2c228e3216
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt7628-usbphy.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,mt7628-usbphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek/Ralink USB PHY
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7620-usbphy
+      - mediatek,mt7628-usbphy
+      - ralink,rt3352-usbphy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  ralink,sysctl:
+    description:
+      phandle to a ralink syscon register region.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  resets:
+    items:
+      - description: USB Host reset controller
+      - description: USB Device reset controller
+
+  reset-names:
+    items:
+      - const: host
+      - const: device
+
+required:
+  - compatible
+  - "#phy-cells"
+  - ralink,sysctl
+  - resets
+  - reset-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt7628-usbphy
+    then:
+      required:
+        - reg
+    else:
+      properties:
+        reg: false
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@10120000 {
+      compatible = "mediatek,mt7628-usbphy";
+      reg = <0x10120000 0x1000>;
+      #phy-cells = <0>;
+      ralink,sysctl = <&sysc>;
+      resets = <&rstctrl 22>,
+               <&rstctrl 25>;
+      reset-names = "host", "device";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/phy/ralink-usb-phy.txt b/Documentation/devicetree/bindings/phy/ralink-usb-phy.txt
deleted file mode 100644
index 9d2868a437ab..000000000000
--- a/Documentation/devicetree/bindings/phy/ralink-usb-phy.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Mediatek/Ralink USB PHY
-
-Required properties:
- - compatible: "ralink,rt3352-usbphy"
-	       "mediatek,mt7620-usbphy"
-	       "mediatek,mt7628-usbphy"
- - reg: required for "mediatek,mt7628-usbphy", unused otherwise
- - #phy-cells: should be 0
- - ralink,sysctl: a phandle to a ralink syscon register region
- - resets: the two reset controllers for host and device
- - reset-names: the names of the 2 reset controllers
-
-Example:
-
-usbphy: phy {
-	compatible = "mediatek,mt7628-usbphy";
-	reg = <0x10120000 0x1000>;
-	#phy-cells = <0>;
-
-	ralink,sysctl = <&sysc>;
-	resets = <&rstctrl 22 &rstctrl 25>;
-	reset-names = "host", "device";
-};
-- 
2.25.1

