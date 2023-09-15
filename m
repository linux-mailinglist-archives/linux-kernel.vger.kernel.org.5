Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC187A1825
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjIOIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjIOIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0B82723;
        Fri, 15 Sep 2023 01:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBD8CC433CD;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765528;
        bh=v5iaPlwXd/OKY/Q0WHziCUY1RlsKsYRSD0RKIEbGFGg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=WMKteJrg4A5p3BceRlRbO4zdB9oYR8O8w2izAvAbU1v2qEHoquSyMZolEPMOVSHge
         nilyBpC2ZdBMOsv0ssWVxXJsoa3awV8m1wYnMlqx1qwzdBkYE+30ihO5yOsX58G59Y
         tJ1iRU7yLeOZ2eVWhUaw7e9TRaMV+/6DD0cmqVOJZom65pPaEs6TFYLPEI5ekqBb35
         N6H1v7DbuTULua0DiouHHIOpD4SINcvDTGxgjfjhgRZwIooN3yGW6jQJMEc4CnWkpc
         4Yw/xSCKsxAj9G6qReWCKPcSPZj0+y/MYx5x7q++BO0nnncKjDghx0jBZMqDdjV2A4
         limLHiG7G/EyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id CABA1EE643A;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:10:55 +0300
Subject: [PATCH v4 13/42] dt-bindings: rtc: Add Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-13-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=1532;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=llBn19+N5OMsRAdced6fEa337zLi62mxyrYZPxL4bew=; =?utf-8?q?b=3DZEueZSJSmLtX?=
 =?utf-8?q?mleqTaxRhGsWXM8QLlULSAgo2aJpe4urGGdUI7wdA/bYKuWMRfxgJAgzDo/H2onI?=
 1Z96r9a5DRYiQ4slaT+nGmY+UlR0BkVjLT7Ts0ff+0gL26fWq1LZ
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add device tree bindings for the Cirrus Logic EP93xx RTC block
used in these SoCs.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml b/Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
new file mode 100644
index 000000000000..a95f6af2b1c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/cirrus,ep9301-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus EP93xx Real Time Clock controller
+
+maintainers:
+  - Hartley Sweeten <hsweeten@visionengravers.com>
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-rtc
+      - items:
+          - enum:
+              - cirrus,ep9302-rtc
+              - cirrus,ep9307-rtc
+              - cirrus,ep9312-rtc
+              - cirrus,ep9315-rtc
+          - const: cirrus,ep9301-rtc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@80920000 {
+        compatible = "cirrus,ep9301-rtc";
+        reg = <0x80920000 0x100>;
+    };

-- 
2.39.2

