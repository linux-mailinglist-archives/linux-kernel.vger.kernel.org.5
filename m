Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C97F3768
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjKUU3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjKUU3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:29:01 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B03D4B;
        Tue, 21 Nov 2023 12:28:57 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 53579120064;
        Tue, 21 Nov 2023 23:28:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 53579120064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700598535;
        bh=/HrW0X+9rW0pBeZMX5Q2JYjOL2DcSt6189XJga8hqTE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=D4mL8ApxT9G0OVS0Ao3pKhHWk3yP0L9H1s5Jl/BXka/iRAlnO7iCbUgpIG0XmrN7Z
         rjIYKW3w1rsFHjx7S6EnohfaZh9FucVxptHZEU438xSfmkGG5iD+gvkUBWxK21OmlR
         JG3lxWlADPtaRenJQYQj4OyAp/TW7fE36qlHDAF9maFKrYpj6wdbMwj76A1DcwR2Al
         MUYpAvJJ9ZmTH73hG7JmNGfraXjgOmhBnIQMRkjXEUgNDuD61PswTLgjuRoSvhMWhE
         YxBG4Gv5n76quA5aM18csb9dfmwNIRbGHWYe5AZrRzxj62tbWyePa+jQrxzSVuAbt7
         LwCH16py3vk/g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 23:28:55 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 23:28:54 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 10/11] dt-bindings: leds: awinic,aw200xx: add AW20108 device
Date:   Tue, 21 Nov 2023 23:28:34 +0300
Message-ID: <20231121202835.28152-11-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;www.awinic.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/21 19:45:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/21 19:46:00
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

From: George Stark <gnstark@salutedevices.com>

Add aw20108 compatible for Awinic AW20108 led controller.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/leds/awinic,aw200xx.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
index a6dced59599d..67c1d960db1d 100644
--- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
+++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
@@ -10,15 +10,19 @@ maintainers:
   - Martin Kurbanov <mmkurbanov@sberdevices.ru>
 
 description: |
-  This controller is present on AW20036/AW20054/AW20072.
-  It is a 3x12/6x9/6x12 matrix LED programmed via
-  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
-  3 pattern controllers for auto breathing or group dimming control.
+  It is a matrix LED driver programmed via an I2C interface. Devices have
+  a set of individually controlled leds and support 3 pattern controllers
+  for auto breathing or group dimming control. Supported devices:
+    - AW20036 (3x12) 36 LEDs
+    - AW20054 (6x9)  54 LEDs
+    - AW20072 (6x12) 72 LEDs
+    - AW20108 (9x12) 108 LEDs
 
   For more product information please see the link below:
   aw20036 - https://www.awinic.com/en/productDetail/AW20036QNR#tech-docs
   aw20054 - https://www.awinic.com/en/productDetail/AW20054QNR#tech-docs
   aw20072 - https://www.awinic.com/en/productDetail/AW20072QNR#tech-docs
+  aw20108 - https://www.awinic.com/en/productDetail/AW20108QNR#tech-docs
 
 properties:
   compatible:
@@ -26,6 +30,7 @@ properties:
       - awinic,aw20036
       - awinic,aw20054
       - awinic,aw20072
+      - awinic,aw20108
 
   reg:
     maxItems: 1
-- 
2.36.0

