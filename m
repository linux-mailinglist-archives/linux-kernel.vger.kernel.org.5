Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840EA7A1826
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjIOIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjIOIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D32113;
        Fri, 15 Sep 2023 01:12:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B8B5C433BF;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765528;
        bh=mBGim63dwvkGq1RMDM5Ao090NhWpVH65a2ZkwL5Yo+c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=u1M5Sr1rKE4VUdkj5gad3rIT2Mdb2CeODYn1HDPO4k0ATClau4oCyrK1d67BLOfHx
         Cns8iqShkUh/abvdesfhS5k1ytbS68z/os8XiW2mwyMhqiSkprve+GIx05/oali1IE
         NFcn4fraxNPWIuY1TuVjA1yUlIce2jjG5bbipIdt4ZqFNFRJYsaxRNkKZRcjh9aakE
         sbvmNcf7GbjpoRA+P7KvAwbm+bEhhDQbzs0/NJczyVULdDLrh2BkhjU49y3YMYR8E8
         CHnEBcS1kh8hxD5IQ2wHijp0Kq0qthph/gLwkh9tWU3/S/9FD4ZBhAadEEEGjHDw/K
         l38a5GvfivWkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 67CDDEE643C;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:10:49 +0300
Subject: [PATCH v4 07/42] dt-bindings: power: reset: Add ep93xx reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-7-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=1426;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=I52sOmITYDAEad5VX3+fpK9zHNrJkryMKM/Emu0XkSM=; =?utf-8?q?b=3DZtroFVL5l1BX?=
 =?utf-8?q?jZW9O7+Rvy4kPDH1r3mWCx53MerJIRqRsyqoeay/OjfOjFrXU/QtPDu3EVDszrKH?=
 F5WJpICTCOIlM1RKp8v7GkkVjVPteUPoBV3E1dJmO5b4s/h3kDWz
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

Add YAML bindings for ep93xx reset.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/power/reset/cirrus,ep9301-reboot.yaml | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/cirrus,ep9301-reboot.yaml b/Documentation/devicetree/bindings/power/reset/cirrus,ep9301-reboot.yaml
new file mode 100644
index 000000000000..a5a718dec4b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/cirrus,ep9301-reboot.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/cirrus,ep9301-reboot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus EP93xx SoC family reset controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-reboot
+      - items:
+          - enum:
+              - cirrus,ep9302-reboot
+              - cirrus,ep9307-reboot
+              - cirrus,ep9312-reboot
+              - cirrus,ep9315-reboot
+          - const: cirrus,ep9301-reboot
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    reboot {
+        compatible = "cirrus,ep9301-reboot";
+    };

-- 
2.39.2

