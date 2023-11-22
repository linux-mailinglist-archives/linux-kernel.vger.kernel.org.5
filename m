Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB78F7F40FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbjKVJCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjKVJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2217019E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F117FC116A7;
        Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643675;
        bh=ya3abGN6Ov58Dzali2bnHHbSY5Xv93VBv0s7x2OzZJc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=pn+E+X4F/gWl0BKCGIVBZhLAA6pvHI95uUT2jVDPvF2fVb4xTP+o2hZ7VcsuvSdr/
         PdP8k5RKiokPmd2881IzmmJ9pUfrizMSI9arOAZo1QKpLa+CsVMHtG6gZ+06WEhNWw
         EGP86xNlL88SmTa7TXTw9j+9H1zgaV3Igge5+aXEs0fTMGaGbRYaSjvQ/fnvjAT3g6
         ETS/9u+5Ib4+DyL97KHpRq9M8hwjpF5AMSO+4cMlJzyDx1A2/Sx0+ItoZUG9WQGwzT
         PEKQ6ILBj/y47Lzn60Volm2GmYHSqqOKV+5Cy7BfdExCXEGTE796BU1KJN1nqduaCo
         DSsIyzRL57w1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id DFB28C61D9C;
        Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 11:59:50 +0300
Subject: [PATCH v5 12/39] dt-bindings: pwm: Add Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231122-ep93xx-v5-12-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=1779;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=n/iurOkAjEQ/+YzqsiVn/lv9Zre1QQmi+ZiRYFjBUJE=; =?utf-8?q?b=3DawO7VKq6HcNF?=
 =?utf-8?q?tziSa1/b9x2BY0UHBqV86l9Lq/SP0lbIEFjn17pz1M/A5wloaIKoEIHxHsJs/Lqy?=
 Fwa0JXPXDPcuj2//gJp5rtPYFBXFiqjFCZ/y49FDp/u3KMt5MJiY
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC PWM.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml b/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml
new file mode 100644
index 000000000000..67b0ce01d1a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/cirrus,ep9301-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic ep93xx PWM controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-pwm
+      - items:
+          - enum:
+              - cirrus,ep9302-pwm
+              - cirrus,ep9307-pwm
+              - cirrus,ep9312-pwm
+              - cirrus,ep9315-pwm
+          - const: cirrus,ep9301-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC PWM clock
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/cirrus,ep9301-syscon.h>
+    pwm@80910000 {
+        compatible = "cirrus,ep9301-pwm";
+        reg = <0x80910000 0x10>;
+        clocks = <&syscon EP93XX_CLK_PWM>;
+        #pwm-cells = <3>;
+    };

-- 
2.41.0

