Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27C77BBC67
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjJFQFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjJFQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:05:02 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE14B9;
        Fri,  6 Oct 2023 09:05:01 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 0124812000A;
        Fri,  6 Oct 2023 19:05:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0124812000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696608300;
        bh=4J/JIZb8TJ/YBiUfw0G+dDdYJJZD1Z0B5w2YjJsc3UQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=IUlAfyh6YBeRpIT7W3Wc+cTi3YCzz6gkUHMEIpTrsP7OeKxq2brkh5AMOddwjukmY
         csQ0Z79o+WmQ4URYPRjKCMmEgF/sRiV0Rm0nTzRovNYR5gm9sU6tH4I9lePXACKjE3
         TOweyYG+tO74EZ7jwr/KAtd8ONsK4XhlwQwDz4Fri/icGfnsabGqogquYKlf4ZCzxD
         qsR7M0sPcyhHikisSAjzfubfhlr07V0r7rfaFdEqWaczfA3z+xOAcqx7kgfO5bb+yF
         TVFVgTLgFCsmMBOutGd3TqipGfrQ7hB8gDgNYKjmZ6+WU8JTEWNUQP+Zw5Z6FkggE9
         tTMuA/sA6acXA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 19:04:59 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 19:04:59 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 04/11] dt-bindings: leds: aw200xx: introduce optional hwen-gpio property
Date:   Fri, 6 Oct 2023 19:04:30 +0300
Message-ID: <20231006160437.15627-5-ddrokosov@salutedevices.com>
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

Property 'awinic,hwen-gpio' is optional, it can be used by the board
developer to connect AW200XX LED controller with appropriate poweron
GPIO pad.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
index 73b81f7a7258..e3ad11fc7a84 100644
--- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
+++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
@@ -41,6 +41,9 @@ properties:
     description:
       Leds matrix size
 
+  awinic,hwen-gpio:
+    maxItems: 1
+
 patternProperties:
   "^led@[0-9a-f]+$":
     type: object
@@ -90,12 +93,15 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/leds/common.h>
 
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
+        awinic,hwen-gpio = <&gpio 3 GPIO_ACTIVE_HIGH>;
+
         led-controller@3a {
             compatible = "awinic,aw20036";
             reg = <0x3a>;
-- 
2.36.0

