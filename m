Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FAA7A1828
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjIOIMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjIOIMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB70271C;
        Fri, 15 Sep 2023 01:12:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59125C433BA;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765528;
        bh=IxhYy8HDsfSFxr7o4eBZ+tPwoow6t9TJ9PFphIBRJ7E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=OT+7yfXshuduxTigrxMbCzeh9Qd0XNRxTStac2hcVr21sOXawWx+DMBHr2c6je94H
         R5p32sgO/f++veZtBBhnWiqqCRle25lcT7iQpZ5ZHtDhTES3xxjQmfZzP1t9jc2Bsu
         QVErV46NIzeTr0V+4sjVWx+wkpLmPdaHNBjQNvggo/IlPN7+Gw0skAg0vRrwRFb+9z
         hzxkl4IgibX5cNOrVU2HZUX7HoIJUwDqad9zJn62duUcWiyCC+5L2rSBuhxkYoeXMB
         jAKmGenBt+AoMY9nh+nzHTxbtwOcZ9kAXyYHaOSKGGEshkcQjWVipSsY3gFnrrbHKK
         Z92Ymb5BNW4pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 46108EE6436;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:10:47 +0300
Subject: [PATCH v4 05/42] dt-bindings: pinctrl: Add Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-5-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=2116;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=bK/ofpUsuxYmv6fuKZVUudz6ww/jwSK1B72cojrFW8s=; =?utf-8?q?b=3D7OJUtaO82nOu?=
 =?utf-8?q?4x7xPTuOK6Typ/ue8WcYNbIdDDYu+jw77DmKDfacr16Q9zQpmCDXjBWMNh1Kr81Y?=
 DKJhsmNqDFEG9p+ap5iKNA4Co975BwINjRWVn9BzsV4pw8/Itwsx
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

Add YAML bindings for ep93xx SoC pinctrl.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/pinctrl/cirrus,ep9301-pinctrl.yaml    | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
new file mode 100644
index 000000000000..1dbdc5ccc232
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/cirrus,ep9301-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus ep93xx pins mux controller
+
+maintainers:
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-pinctrl
+      - items:
+          - enum:
+              - cirrus,ep9302-pinctrl
+              - cirrus,ep9307-pinctrl
+              - cirrus,ep9312-pinctrl
+              - cirrus,ep9315-pinctrl
+          - const: cirrus,ep9301-pinctrl
+
+patternProperties:
+  '^pins-':
+    type: object
+    description: pin node
+    $ref: pinmux-node.yaml#
+
+    properties:
+      function:
+        enum: [ spi, ac97, i2s, pwm, keypad, pata, lcd, gpio ]
+
+      groups:
+        enum: [ ssp, ac97, i2s_on_ssp, i2s_on_ac97, pwm1, gpio1agrp,
+                gpio2agrp, gpio3agrp, gpio4agrp, gpio6agrp, gpio7agrp,
+                rasteronsdram0grp, rasteronsdram3grp, keypadgrp, idegrp ]
+
+    required:
+      - function
+      - groups
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pinctrl {
+      compatible = "cirrus,ep9312-pinctrl", "cirrus,ep9301-pinctrl";
+      spi_default_pins: pins-spi {
+        function = "spi";
+        groups = "ssp";
+      };
+    };

-- 
2.39.2

