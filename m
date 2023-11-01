Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ED57DE356
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbjKAOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjKAOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:25:05 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C143310C;
        Wed,  1 Nov 2023 07:24:58 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 799BC120034;
        Wed,  1 Nov 2023 17:24:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 799BC120034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698848697;
        bh=Axls6j7FjYgwQZDHrBNQKTEaUgzPNHh03GeTST0E/8g=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=QJYUpEXlizSl96UBdFaG8GG579PTbGYk1P32URtd8TZCWppWtGQ+/kJcpL18+LF0L
         GY+g9Yfl+vneMxIvrSNQiKTeqzRpsSfUpsoqCTIvzecLp08ad51Yy3E4hH3EF0Zq2m
         ZxugzEejo1/zzQ8l4I66DWZek2jXj+aIERWzH+sqvcUl/v6bRgUX2pDk9ElN9m7yy9
         jmrisR2K2WS5ZZkefmlj5TNsSULNv4OFU38e8U5XaVunQcowC6aezYqOjcbEgYuMb2
         UnW+aj1cTRPBMmCF3g1T3hs0vlxoVcR887zq1WYTnhUp2eYp/IqFPBSrA0XF+EoEqp
         NmsdHzbabTeTw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  1 Nov 2023 17:24:57 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 1 Nov 2023 17:24:57 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v3 03/11] dt-bindings: leds: aw200xx: introduce optional enable-gpios property
Date:   Wed, 1 Nov 2023 17:24:37 +0300
Message-ID: <20231101142445.8753-4-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231101142445.8753-1-ddrokosov@salutedevices.com>
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181053 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 13:00:00 #22378131
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property 'enable-gpios' is optional, it can be used by the board
developer to connect AW200XX LED controller with appropriate 'enable'
GPIO pad.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
index feb5febaf361..3da3633a242c 100644
--- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
+++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
@@ -41,6 +41,9 @@ properties:
     description:
       Leds matrix size
 
+  enable-gpios:
+    maxItems: 1
+
 patternProperties:
   "^led@[0-9a-f]$":
     type: object
@@ -90,6 +93,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/leds/common.h>
 
     i2c {
@@ -102,6 +106,7 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
             awinic,display-rows = <3>;
+            enable-gpios = <&gpio 3 GPIO_ACTIVE_HIGH>;
 
             led@0 {
                 reg = <0x0>;
-- 
2.36.0

