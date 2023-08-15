Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1FC77D2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbjHOS6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbjHOS5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:57:55 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D211BEB;
        Tue, 15 Aug 2023 11:57:32 -0700 (PDT)
Received: from p200300ccff31d1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff31:d100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qVynp-002fC5-0r; Tue, 15 Aug 2023 20:30:01 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qVyno-000tJ7-25;
        Tue, 15 Aug 2023 20:30:00 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rydberg@bitmath.org,
        u.kleine-koenig@pengutronix.de, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/4] dt-bindings: touchscreen: neonode,zforce: Use standard properties
Date:   Tue, 15 Aug 2023 20:29:46 +0200
Message-Id: <20230815182948.212575-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815182948.212575-1-andreas@kemnade.info>
References: <20230815182948.212575-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable touchscreen orientation to be specified by using standard
properties.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/input/touchscreen/neonode,zforce.yaml  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
index 1c45adb2407a..03513f38c9cc 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
@@ -9,6 +9,9 @@ title: Neonode infrared touchscreen controller
 maintainers:
   - Heiko Stuebner <heiko.stuebner@bqreaders.com>
 
+allOf:
+  - $ref: touchscreen.yaml#
+
 properties:
   compatible:
     const: neonode,zforce
@@ -26,9 +29,11 @@ properties:
     maxItems: 1
 
   x-size:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
 
   y-size:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
 
   vdd-supply: true
@@ -38,8 +43,6 @@ required:
   - reg
   - interrupts
   - reset-gpios
-  - x-size
-  - y-size
 
 unevaluatedProperties: false
 
@@ -60,8 +63,10 @@ examples:
             reset-gpios = <&gpio5 9 0>; /* RST */
             irq-gpios = <&gpio5 6 0>; /* IRQ, optional */
 
-            x-size = <800>;
-            y-size = <600>;
+            touchscreen-min-x = <0>;
+            touchscreen-size-x = <800>;
+            touchscreen-min-y = <0>;
+            touchscreen-size-y = <600>;
         };
     };
 ...
-- 
2.39.2

