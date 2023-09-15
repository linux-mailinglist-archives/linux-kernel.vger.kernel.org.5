Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414597A1851
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjIOIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjIOIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558A02735;
        Fri, 15 Sep 2023 01:12:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF610C4AF75;
        Fri, 15 Sep 2023 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765530;
        bh=2lu5EzJp8GgAHbOGtBIqxlFSHhFU/8mjEZ8eKO8JATw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Gzzxhr8WDTKuZYSQod5y5uik77q7GcdUUE8f3x+XnPBDiVpAOmV/XjEapa+AqQGn/
         +NuIlmtY14ODJ6wt46ofR28kksQRlsUlY6eVQVjnsEVZkqbIiU3FTWplngfvtoQvS1
         x7Ez5/EoJBGyPl1HKIwvxODqgV1P7advgqPXQf4GLzIbTTfYjZ4lMYgwO/OTmgH1Lj
         MFdYJwO+ukCK0OxoMiqh1utylXDOg8QBJkW1Pj48JNQ86Ye7Syy5DaHx4hILOjLV4n
         CQiBhlMS7gaqYI7yKxdkGLlbFzW4225OPOE6ed0i8VsrufMGJVDddwjMlqduM4cSiR
         JY6jUoBx/RgBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BBEE6441;
        Fri, 15 Sep 2023 08:12:09 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:11:13 +0300
Subject: [PATCH v4 31/42] dt-bindings: wdt: Add ts72xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-31-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=1618;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=RU7BGPJdygzLxD9nFWrzFwn5EiUB5p7KsaAjUEvthxc=; =?utf-8?q?b=3D9/inJrUTu3vA?=
 =?utf-8?q?qYIQHoNTHYl4Zrw/sih1PaakLy8UueZLlnKgAdqfNOiElOg9HMW5oKNXJFxpUAVu?=
 7Ln1mKxqCFy0c92qVlcOItuOwPNakPEUA8fErTSMDN2uiyPTHcK3
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

Add DT binding for Technologic Systems TS-72xx watchdog.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/watchdog/technologic,ts7200-wdt.yaml  | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/technologic,ts7200-wdt.yaml b/Documentation/devicetree/bindings/watchdog/technologic,ts7200-wdt.yaml
new file mode 100644
index 000000000000..7e4bfef152f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/technologic,ts7200-wdt.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/technologic,ts7200-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Technologic Systems TS-72xx based SBCs watchdog
+
+maintainers:
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: technologic,ts7200-wdt
+      - items:
+          - enum:
+              - technologic,ts7300-wdt
+              - technologic,ts7260-wdt
+              - technologic,ts7250-wdt
+          - const: technologic,ts7200-wdt
+
+  reg:
+    items:
+      - description: control register
+      - description: feed register
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@23800000 {
+      compatible = "technologic,ts7200-wdt";
+      reg = <0x23800000 0x01>, <0x23c00000 0x01>;
+      timeout-sec = <30>;
+    };
+
+...

-- 
2.39.2

