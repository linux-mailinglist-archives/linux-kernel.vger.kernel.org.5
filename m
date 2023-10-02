Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019A47B5D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJBWkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjJBWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:40:40 -0400
X-Greylist: delayed 470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 15:40:24 PDT
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3205E99;
        Mon,  2 Oct 2023 15:40:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id D98898285418;
        Mon,  2 Oct 2023 17:32:35 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id y9b-NGjVqnzX; Mon,  2 Oct 2023 17:32:35 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id DA0B182859EC;
        Mon,  2 Oct 2023 17:32:34 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com DA0B182859EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1696285954; bh=S+mCMOZ2NAwJ7Ik3LFaWrPjlnuBduz6GXjcS8/kAvNM=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=gE/3HFkpo8+TGJ0K9Y6OUyeh2h6A1K/c8/af65KLCJ3j6I6MuM1uYYQ8D1YgDKRLT
         D0ScLHsYB5yaclOLuGtuYs8BMsg0L3siPDf803pxQgwXi04Xht2BKzJ2T3Gahxgrzr
         s8zQpjbQZ2YiAv5pIFrvCxgj8ovf3JCefB+ifbQ4=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S_EcUAiR6GDY; Mon,  2 Oct 2023 17:32:34 -0500 (CDT)
Received: from raptor-ewks-026.lan (5.edge.rptsys.com [23.155.224.38])
        by mail.rptsys.com (Postfix) with ESMTPSA id EDC68828597D;
        Mon,  2 Oct 2023 17:32:33 -0500 (CDT)
From:   Shawn Anastasio <sanastasio@raptorengineering.com>
To:     devicetree@vger.kernel.org, lee@kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Anastasio <sanastasio@raptorengineering.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: mfd: sie,cronos-cpld: Add initial DT binding
Date:   Mon,  2 Oct 2023 17:32:21 -0500
Message-Id: <8b014f8b302f8b41c45c4f6fb114cf18e84a76fa.1696285339.git.sanastasio@raptorengineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1696285339.git.sanastasio@raptorengineering.com>
References: <cover.1696285339.git.sanastasio@raptorengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SIE Cronos Platform Controller CPLD is a multi-purpose platform
controller that provides both a watchdog timer and an LED controller. As
both functions are provided by the same CPLD, a multi-function device is
exposed as the parent of both functions.

Add a DT binding for this device.

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
---
 .../bindings/mfd/sie,cronos-cpld.yaml         | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sie,cronos-cpld.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sie,cronos-cpld.yaml b/Documentation/devicetree/bindings/mfd/sie,cronos-cpld.yaml
new file mode 100644
index 000000000000..3b59cdd46243
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sie,cronos-cpld.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Raptor Engineering, LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sie,cronos-cpld.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SIE Cronos Platform Controller CPLD multi-function device
+
+maintainers:
+  - Timothy Pearson <tpearson@raptorengineering.com>
+
+description: |
+  The SIE Cronos Platform Controller CPLD is a multi-purpose platform controller
+  that provides both a watchdog timer and an LED controller. As both functions
+  are provided by the same CPLD, a multi-function device is exposed as the
+  parent of both functions.
+
+properties:
+  compatible:
+    const: sie,cronos-cpld
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  leds:
+    type: object
+    description: Cronos Platform Status LEDs
+
+    properties:
+      compatible:
+        const: sie,cronos-leds
+
+  watchdog:
+    type: object
+    description: Cronos Platform Watchdog Timer
+
+    properties:
+      compatible:
+        const: sie,cronos-watchdog
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    cpld: cpld@3f {
+      compatible = "sie,cronos-cpld";
+      reg = <0x3f>;
+
+      watchdog {
+        compatible = "sie,cronos-watchdog";
+      };
+
+      leds {
+        compatible = "sie,cronos-leds";
+      };
+    };
-- 
2.30.2

