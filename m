Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3A77B4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjHNIyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjHNIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:53:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E4F10B;
        Mon, 14 Aug 2023 01:53:54 -0700 (PDT)
Received: from eugen-station.. (unknown [82.77.136.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B84966071A3;
        Mon, 14 Aug 2023 09:53:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692003233;
        bh=HYN+QldNtbHN80o42A4atrNQS81buNzuGV/Nz/ZAMgw=;
        h=From:To:Cc:Subject:Date:From;
        b=acVvqXX0EmW2ixUQBvOPwgpcDM8Z97WjdPpvvYmoqhFDCQQkKPwzzPBy1z/5cAg7h
         lRch0hk9U4IM2SAqfxgAVpolmFt6GaboaPTu0n2JpQD2Ul4BW0SXa4pPofOeePAuvR
         7dQYiBkPgt9fCr8Iw5VMRV52VFAg1kVwDa7jDIyCo3zUM8NeuEsgFBaQhQnNmGbAGX
         LM4EpSAKvtdb17kc6LF0bcrQvc9nuhqDbW4xDQLhai6cMZCJPOndo/XzhI9ufJ+HG/
         pD36x6KF6uryrKA05wXlfWNjrYQwGU1Nz6j2FmpxeAfQGG5twMYPOr9mUtSyT/JKCl
         UdEH6SI4gpZXg==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v2] dt-bindings: arm: mediatek: convert audsys to yaml
Date:   Mon, 14 Aug 2023 11:53:42 +0300
Message-Id: <20230814085342.8474-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mediatek,audsys binding to YAML.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v2:
- remove comment reference to inexistent binding

 .../bindings/arm/mediatek/mediatek,audsys.txt | 39 -----------
 .../arm/mediatek/mediatek,audsys.yaml         | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
deleted file mode 100644
index 699776be1dd3..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-MediaTek AUDSYS controller
-============================
-
-The MediaTek AUDSYS controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2701-audsys", "syscon"
-	- "mediatek,mt6765-audsys", "syscon"
-	- "mediatek,mt6779-audio", "syscon"
-	- "mediatek,mt7622-audsys", "syscon"
-	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
-	- "mediatek,mt8167-audiosys", "syscon"
-	- "mediatek,mt8183-audiosys", "syscon"
-	- "mediatek,mt8192-audsys", "syscon"
-	- "mediatek,mt8516-audsys", "syscon"
-- #clock-cells: Must be 1
-
-The AUDSYS controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Required sub-nodes:
--------
-For common binding part and usage, refer to
-../sonud/mt2701-afe-pcm.txt.
-
-Example:
-
-	audsys: clock-controller@11220000 {
-		compatible = "mediatek,mt7622-audsys", "syscon";
-		reg = <0 0x11220000 0 0x2000>;
-		#clock-cells = <1>;
-
-		afe: audio-controller {
-			...
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml
new file mode 100644
index 000000000000..7db99730a349
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,audsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek AUDSYS controller
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@collabora.com>
+
+description:
+  The MediaTek AUDSYS controller provides various clocks to the system.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-audsys
+              - mediatek,mt6765-audsys
+              - mediatek,mt6779-audsys
+              - mediatek,mt7622-audsys
+              - mediatek,mt8167-audsys
+              - mediatek,mt8173-audsys
+              - mediatek,mt8183-audsys
+              - mediatek,mt8186-audsys
+              - mediatek,mt8192-audsys
+              - mediatek,mt8516-audsys
+          - const: syscon
+      - items:
+          # Special case for mt7623 for backward compatibility
+          - const: mediatek,mt7623-audsys
+          - const: mediatek,mt2701-audsys
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  audio-controller:
+    type: object
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        audsys: clock-controller@11220000 {
+            compatible = "mediatek,mt7622-audsys", "syscon";
+            reg = <0 0x11220000 0 0x2000>;
+            #clock-cells = <1>;
+
+            audio-controller {
+            };
+        };
+    };
-- 
2.34.1

