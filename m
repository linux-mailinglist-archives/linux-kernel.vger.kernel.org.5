Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3485A7DA047
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjJ0SZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjJ0SYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:24:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8861E1FC9;
        Fri, 27 Oct 2023 11:23:12 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698430990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jy+W/PBfHKSgw53hRltZmF6wq1CF7Ah3IuKAA1cvr0A=;
        b=HZN5EOxnD7jNhwHcemO6C9znJrEbvwjU+M59cy9bRjezEwyztIyhq6pFgfPGmUCr44uN35
        Be1c0Wa3yj/OTtRzIeKojhGBaPAc5qDvFNr264zS93vEt7MzkrN65Q1bCz1ehGAU+dO5Tg
        D/yzDOMNjDhmjdCWzrVwV2C+EBmq5+irVS77MPROE7ORbuUv5PXSHk3kdssZSk01aS4aSn
        +vCdwyAOw3ChZF4gUsaD0CHfv7rI61AXOJ2NX9TumRDvIqHgVNGRQSb8NUjvAX6be+x4Gu
        HnNEvNbr+YP/OAJyHITtxcTNwLbG6X6McBEHjTFXyv4YsYvSHETSEnoUauzmyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698430990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jy+W/PBfHKSgw53hRltZmF6wq1CF7Ah3IuKAA1cvr0A=;
        b=SuQfGy3T0t1nVcFFkwtpkfR6x0WgDqOLGCErEKEpHOOzOVhNhBS58/0e0K1fkSLsLvgV2J
        OSWjBxKt0RRsYbDQ==
From:   "tip-bot2 for Nikita Shubin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timers: Add Cirrus EP93xx
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230915-ep93xx-v4-11-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-11-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Message-ID: <169843099021.3135.10392037699813416655.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     81824f7c8fb0485a5007bf0e60718afdecdef60c
Gitweb:        https://git.kernel.org/tip/81824f7c8fb0485a5007bf0e60718afdecdef60c
Author:        Nikita Shubin <nikita.shubin@maquefel.me>
AuthorDate:    Fri, 15 Sep 2023 11:10:53 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 15 Oct 2023 23:36:36 +02:00

dt-bindings: timers: Add Cirrus EP93xx

Add device tree bindings for the Cirrus Logic EP93xx timer block
used in these SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230915-ep93xx-v4-11-a1d779dcec10@maquefel.me
---
 Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml b/Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml
new file mode 100644
index 0000000..e463e11
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
