Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CCE7A1821
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjIOIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjIOIMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABDD2720
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:12:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0350C4AF1E;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765528;
        bh=X78QprckOYkkAyNg8Ml+IrF0WiJ2gWwRdmG2kEHquPA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Xr9s4yHyb+8iQw+jJkg5NgnYy+hoCUg1NpWpa8U2dB3VErZbj4Ioh/mdm/Sg/QaGH
         uCMz4RHNC27zHvFyC2Jb129H3RXCKc3rtDswZp1nEZN8deBbYLgQZTyVNh9qomxROE
         DfrNZSjQPmAHOKWzrnkl7TQpnPYhSXrmLiQRzRv4yUjUCV1IYN+HbFr0RiLGtfcQpj
         0xrzfv7LQ7qZRQJIzJ3Xy92pAtJfkoRcA9b2jW9PbWPkIw8Aeb42sqSlAcO+9hbN6b
         Rrof/yuUWO3kDVJKXGhLo7psOxtOuM2mmWXuWIwBOVoEkpLj0Iyl/VLM/5Y3Qu8VC2
         vDHXNASJymNyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id AE57EEE6439;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:10:53 +0300
Subject: [PATCH v4 11/42] dt-bindings: timers: Add Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-11-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=1730;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=1YCRVxosT/z3Q6cBGPOs3eYKE/8hqoIndRMA5myVMN0=; =?utf-8?q?b=3DjWYsJZclQlk1?=
 =?utf-8?q?Zj1nriFBP3sFX8+kQHl8xhcQXT9BiBBbKaioO2KN9pcx6GQJIFaGZ7RfHDjfpE6m?=
 whuQAoWKARsFzCF2a6vVRbfL5YffSEehaG5g0/KwQY92quA4i7BT
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

Add device tree bindings for the Cirrus Logic EP93xx timer block
used in these SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/timer/cirrus,ep9301-timer.yaml        | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml b/Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml
new file mode 100644
index 000000000000..e463e11e259d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/cirrus,ep9301-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP93xx timer
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-timer
+      - items:
+          - enum:
+              - cirrus,ep9302-timer
+              - cirrus,ep9307-timer
+              - cirrus,ep9312-timer
+              - cirrus,ep9315-timer
+          - const: cirrus,ep9301-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@80810000 {
+      compatible = "cirrus,ep9301-timer";
+      reg = <0x80810000 0x100>;
+      interrupt-parent = <&vic1>;
+      interrupts = <19>;
+    };
+...

-- 
2.39.2

