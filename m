Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125E7F3762
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjKUU3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjKUU3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:29:01 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5917FD49;
        Tue, 21 Nov 2023 12:28:57 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id DFC94100071;
        Tue, 21 Nov 2023 23:28:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DFC94100071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700598535;
        bh=YEPAVovAT7fOQhJBeFq/4sGvowJqoh7IRxQv9siAkaY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=egfdggIoxtLmc2adnt4Mj3XJh8mp39esubzJDPpJ0i9gKVrMXVLBhtTReKVqJxiGJ
         pFzNz770d+ksoMuMoBu2BeesmSQuwSU1kcNgxGTRtM/6+BLvni9peP0kdcoN2LX3jR
         atNt3AaMirmNX8IcEc4e8esX27/6jtVCuUFxQHa6YDebI6sihKhPKkjOE05wMCodTQ
         phQBdwout94O0NvOomzOMpJSDKBVXZVmvON6otjF66ukhwhvzx2tF5Z8u26zv2UAnO
         6nKsnsou4FE4qFjNA5vh59Aj78VGExxCTQu3ph8sNEkLWiPRfzkslhUy0xotXL9OYY
         52S//8BKrd7KA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 23:28:55 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 23:28:55 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 11/11] dt-bindings: leds: aw200xx: fix led pattern and add reg constraints
Date:   Tue, 21 Nov 2023 23:28:35 +0300
Message-ID: <20231121202835.28152-12-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231121202835.28152-1-ddrokosov@salutedevices.com>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181514 [Nov 21 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/21 17:47:00 #22495004
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AW200XX controllers have the capability to declare more than 0xf LEDs,
therefore, it is necessary to accept LED names using an appropriate
regex pattern.

The register offsets can be adjusted within the specified range, with
the maximum value corresponding to the highest number of LEDs that can
be connected to the controller.

Fixes: e338a05e76ca ("dt-bindings: leds: Add binding for AW200xx")
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/leds/awinic,aw200xx.yaml         | 59 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
index 67c1d960db1d..54d6d1f08e24 100644
--- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
+++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
@@ -45,7 +45,7 @@ properties:
     maxItems: 1
 
 patternProperties:
-  "^led@[0-9a-f]$":
+  "^led@[0-9a-f]+$":
     type: object
     $ref: common.yaml#
     unevaluatedProperties: false
@@ -69,6 +69,63 @@ patternProperties:
           where max-current-switch-number is determinated by led configuration
           and depends on how leds are physically connected to the led driver.
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: awinic,aw20036
+    then:
+      patternProperties:
+        "^led@[0-9a-f]+$":
+          properties:
+            reg:
+              items:
+                minimum: 0
+                maximum: 36
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: awinic,aw20054
+    then:
+      patternProperties:
+        "^led@[0-9a-f]+$":
+          properties:
+            reg:
+              items:
+                minimum: 0
+                maximum: 54
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: awinic,aw20072
+    then:
+      patternProperties:
+        "^led@[0-9a-f]+$":
+          properties:
+            reg:
+              items:
+                minimum: 0
+                maximum: 72
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: awinic,aw20108
+    then:
+      patternProperties:
+        "^led@[0-9a-f]+$":
+          properties:
+            reg:
+              items:
+                minimum: 0
+                maximum: 108
+
 required:
   - compatible
   - reg
-- 
2.36.0

