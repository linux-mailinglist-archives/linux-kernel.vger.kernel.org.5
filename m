Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684827BBC69
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjJFQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjJFQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:05:06 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAB5C5;
        Fri,  6 Oct 2023 09:05:04 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7611312000C;
        Fri,  6 Oct 2023 19:05:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7611312000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696608301;
        bh=tN35mD0+nTDTwkVuf3TrI4jko6f8nzNCzdD5oWRnoxE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=RzjLRVazClEjfF/YL9thBc8/7V29oKt+1JaInCqx04ogYcB/j8wrC6E+edYPBP63B
         UtCKhO3Ow25ZIkClnDk4bArnO1iVbu1Eu/wuxvWDgYz/zv2If2R68yUeHh3jdvKzqe
         05lwmDlQs/nXKTqWGJGijAWaIM2uWUY1qkCLjUnBs2Ahd2T9OACJ0tjIWYyn/c354v
         oh8Y2aeFbNMpNoM2sno05pjGrHE5AMDYSLwdZR9a7oCbfd5fB0oDJ3m7KtvRXvwCXf
         M5rIxHKTfp+4QtBUnJkdE0ovkPmdxusduT8P94WFUYDUukxXTmIeEJXtFdxZAIvRVp
         YqmeQe7IB9idg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 19:05:01 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 19:05:01 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 06/11] dt-bindings: leds: aw200xx: remove property "awinic,display-rows"
Date:   Fri, 6 Oct 2023 19:04:32 +0300
Message-ID: <20231006160437.15627-7-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231006160437.15627-1-ddrokosov@salutedevices.com>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180439 [Oct 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/06 13:25:00 #22070343
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Stark <gnstark@salutedevices.com>

Get rid of the property "awinic,display-rows" and calculate it
in the driver using led definition nodes.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../bindings/leds/awinic,aw200xx.yaml         | 28 +++----------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
index e3ad11fc7a84..5cd167ab0f04 100644
--- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
+++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
@@ -36,11 +36,6 @@ properties:
   "#size-cells":
     const: 0
 
-  awinic,display-rows:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      Leds matrix size
-
   awinic,hwen-gpio:
     maxItems: 1
 
@@ -63,31 +58,17 @@ patternProperties:
           since the chip has a single global setting.
           The maximum output current of each LED is calculated by the
           following formula:
-            IMAXled = 160000 * (592 / 600.5) * (1 / display-rows)
+            IMAXled = 160000 * (592 / 600.5) * (1 / max-current-switch-number)
           And the minimum output current formula:
-            IMINled = 3300 * (592 / 600.5) * (1 / display-rows)
+            IMINled = 3300 * (592 / 600.5) * (1 / max-current-switch-number)
+          where max-current-switch-number is determinated by led configuration
+          and depends on how leds are physically connected to the led driver.
 
 required:
   - compatible
   - reg
   - "#address-cells"
   - "#size-cells"
-  - awinic,display-rows
-
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: awinic,aw20036
-    then:
-      properties:
-        awinic,display-rows:
-          enum: [1, 2, 3]
-    else:
-      properties:
-        awinic,display-rows:
-          enum: [1, 2, 3, 4, 5, 6, 7]
 
 additionalProperties: false
 
@@ -107,7 +88,6 @@ examples:
             reg = <0x3a>;
             #address-cells = <1>;
             #size-cells = <0>;
-            awinic,display-rows = <3>;
 
             led@0 {
                 reg = <0x0>;
-- 
2.36.0

