Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6C7FC86B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376342AbjK1VGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376314AbjK1VGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:22 -0500
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 13:06:27 PST
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1FC198D;
        Tue, 28 Nov 2023 13:06:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 0BBAE8286981;
        Tue, 28 Nov 2023 15:00:20 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iMM-HDrFvrzT; Tue, 28 Nov 2023 15:00:19 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id E307E82869A8;
        Tue, 28 Nov 2023 15:00:18 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com E307E82869A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1701205218; bh=kio7mzrZGCqYPsxWEva5tS5lBAjlTpNzIFhY60REzQg=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=jS/C2UIMkmZ4VWfCFvJCFI2HezJmraC01Pfagv//BTiHGALV5SDMCEZre+oS2wyHr
         HRSvMlZUtkFDMJHovJubGEmPW/HXl0APBKms4gKhoWL6Uy+m6IQrzNeiJZ3sZa1WAP
         jQn62EI9pAvdscJ9hBgKWI2oPagETmWQ3ofgAF20=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZA0KB-bgwYRL; Tue, 28 Nov 2023 15:00:18 -0600 (CST)
Received: from raptor-ewks-026.2lan (5.edge.rptsys.com [23.155.224.38])
        by mail.rptsys.com (Postfix) with ESMTPSA id 6E22682869A6;
        Tue, 28 Nov 2023 15:00:18 -0600 (CST)
From:   Shawn Anastasio <sanastasio@raptorengineering.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Cc:     Timothy Pearson <tpearson@raptorengineering.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [PATCH v2 1/2] dt-bindings: mfd: Add sony,cronos-cpld
Date:   Tue, 28 Nov 2023 15:00:08 -0600
Message-Id: <27ac3bf6e5fecd62918eb096a88503a13a1f0b9c.1701203916.git.sanastasio@raptorengineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1701203916.git.sanastasio@raptorengineering.com>
References: <cover.1701203916.git.sanastasio@raptorengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sony Cronos Platform Controller CPLD is a multi-purpose platform
controller that provides both a watchdog timer and an LED controller for
the Sony Interactive Entertainment Cronos x86 server platform. As both
functions are provided by the same CPLD, a multi-function device is
exposed as the parent of both functions.

Add a DT binding for this device.

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
---
Changes in v2:
  - Change SIE to Sony to use the already-established prefix.
  - Clarify that Cronos is an x86 server platform in description
  - Drop #address-cells/#size-cells
  - Add missing additionalProperties to leds/watchdog objects
  - Add sony,led-mask property to leds object
  - Add sony,default-timeout property to watchdog object
  - Update example

 .../bindings/mfd/sony,cronos-cpld.yaml        | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
new file mode 100644
index 000000000000..df2c2e83ccb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Raptor Engineering, LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sony,cronos-cpld.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony Cronos Platform Controller CPLD multi-function device
+
+maintainers:
+  - Timothy Pearson <tpearson@raptorengineering.com>
+
+description: |
+  The Sony Cronos Platform Controller CPLD is a multi-purpose platform
+  controller that provides both a watchdog timer and an LED controller for the
+  Sony Interactive Entertainment Cronos x86 server platform. As both functions
+  are provided by the same CPLD, a multi-function device is exposed as the
+  parent of both functions.
+
+properties:
+  compatible:
+    const: sony,cronos-cpld
+
+  reg:
+    maxItems: 1
+
+  leds:
+    type: object
+    description: Cronos Platform Status LEDs
+
+    properties:
+      compatible:
+        const: sony,cronos-leds
+
+      sony,led-mask:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0x0
+        maximum: 0x7fff
+        description: |
+          A bitmask that specifies which LEDs are present and can be controlled
+          by the Cronos CPLD. Bits 0-5 correspond to platform Status LEDs, bits
+          6-10 correspond to Link LEDs, and bits 11-14 correspond to the Power
+          State LEDs. All other bits are unused. The default value is 0x7fff
+          (all possible LEDs enabled).
+
+    additionalProperties: false
+
+  watchdog:
+    type: object
+    description: Cronos Platform Watchdog Timer
+
+    properties:
+      compatible:
+        const: sony,cronos-watchdog
+
+      sony,default-timeout:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          The default timeout with which the watchdog timer is initialized, in
+          seconds. Supported values are: 10, 20, 30, 40, 50, 60, 70, 80. All
+          other values will be rounded down to the nearest supported value.  The
+          default value is 80.
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cpld@3f {
+        compatible = "sony,cronos-cpld";
+        reg = <0x3f>;
+
+        watchdog {
+          compatible = "sony,cronos-watchdog";
+          sony,default-timeout = <20>;
+        };
+
+        leds {
+          compatible = "sony,cronos-leds";
+          sony,led-mask = <0x7fff>;
+        };
+      };
+    };
--
2.30.2

