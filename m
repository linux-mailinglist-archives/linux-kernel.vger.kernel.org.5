Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6067D229C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjJVK3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjJVK3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:29:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17269A7;
        Sun, 22 Oct 2023 03:29:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c51388ccebso34389551fa.3;
        Sun, 22 Oct 2023 03:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697970543; x=1698575343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiTcAHupBgTw7Vl1VZjjsvOC2KRXwCZBUoGeBsfXfLo=;
        b=PjRmXcVz+3Th2mA7QSgfQcwdWLoCrYCh3MbxEnYdozJFHRoGHGlIHJQXOfw4daQpDW
         LJEVqbBMe6gPThBxkkfcYk7bToHD1tZyRmvKvRkazkF6GoxoYnV9aKQM+Uo5b4ItkOEG
         f+QaJ4Ayu5Kgfq2SHuRm4Di6ZduhRI0qptNgDwBj7iHIY6xmy0bpAO877ywS24gBrGtG
         S33sl+2R4cyiznT9AIixVyRp0Hdf/zcmzJtJSRMfJPAm73rIgeVkRswOmQGxpBIGZOMK
         hg3QlRVEMPGLPozPwpbTtpcOQ7cSW02kcxiSlm++RBHZSMwBCAEQmMBNaR16Pj1hLeuG
         r2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697970543; x=1698575343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiTcAHupBgTw7Vl1VZjjsvOC2KRXwCZBUoGeBsfXfLo=;
        b=DEIuqeDbg66Pmk5a7A0WqdIBghID83imcXvwD3U+8mIWVqeQamSmnJMwWSJA7o2Ac7
         6gA1GPFfRXt+5n+BTKa0XnBchNEFyVPEtHGr13FWKg2UIj4vl6zuwfVLe0PApPPstORF
         AYl0FuuCbt2CW+i+sQ6smVf4o+sGaAW1R6zRsx8E6cUlXMtgYJ6ge3VPqd9bO1INTXmP
         ss7umaFFvoC/U+IkFYYSZAjozmUpr0qLvRYyKmLet5QZNt71TGEghB/JaTS7bnJG7Gzs
         MdootNXiQEnIr1lXybZVsdBIFMlZAtCDAVFW3KvX9R1ag6Iyda7BGyLIFhOd2A0burQa
         aajA==
X-Gm-Message-State: AOJu0YzI3rVHrjEjtDqATup5QIdCZ+o6sNVFIAYOMRA7eaauO4GI/hNK
        zypDxj9ezFt6san58eun0wd7Tr24nU4=
X-Google-Smtp-Source: AGHT+IG8AwKgQREdrTd3BzyymAYq98n5Fx6GodhxOoWKX4nGppqIcvjY8xJrbmDGlAjC3UzC0qC49w==
X-Received: by 2002:a2e:700d:0:b0:2c5:23f8:1111 with SMTP id l13-20020a2e700d000000b002c523f81111mr4092078ljc.41.1697970542665;
        Sun, 22 Oct 2023 03:29:02 -0700 (PDT)
Received: from localhost.localdomain (141.red-88-10-53.dynamicip.rima-tde.net. [88.10.53.141])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c21ca00b003feea62440bsm6497645wmj.43.2023.10.22.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 03:29:02 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH] dt-bindings: phy: ralink-usb-phy: convert to dtschema
Date:   Sun, 22 Oct 2023 12:29:01 +0200
Message-Id: <20231022102901.797030-1-sergio.paracuellos@gmail.com>
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
 .../bindings/phy/ralink-usb-phy.txt           | 23 -------
 .../bindings/phy/ralink-usb-phy.yaml          | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/ralink-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ralink-usb-phy.yaml

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
diff --git a/Documentation/devicetree/bindings/phy/ralink-usb-phy.yaml b/Documentation/devicetree/bindings/phy/ralink-usb-phy.yaml
new file mode 100644
index 000000000000..62dcf11d112c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ralink-usb-phy.yaml
@@ -0,0 +1,69 @@
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/ralink-usb-phy.yaml#
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
+      - ralink,rt3352-usbphy
+      - mediatek,mt7620-usbphy
+      - mediatek,mt7628-usbphy
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt7628-usbphy
+    then:
+      required:
+        - reg
+
+required:
+  - compatible
+  - "#phy-cells"
+  - ralink,sysctl
+  - resets
+  - reset-names
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
-- 
2.25.1

