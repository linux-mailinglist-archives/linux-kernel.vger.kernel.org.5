Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73477BBC71
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjJFQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjJFQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:05:45 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D8CCA;
        Fri,  6 Oct 2023 09:05:09 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 36E86100009;
        Fri,  6 Oct 2023 19:05:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 36E86100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696608305;
        bh=SHiNeiY8XhPsXkjZdEmqf6B0M+1wIjbeERMyWHXZeG8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=gibKC2LlnbnKqGXixjllbMQWQ3Kcdd2zmLjLXWjb418wC7dtuupQhIs6A695ZwUCA
         0j26WLCOb+eH4vDONHjakvGRpaJt0jnihqy0cZrPuhXo2TB0qMyvr4q3BG6OI3s7fm
         Io88duEDf+oNIFES/iB2bLDMkEkhTOQrSTgDN/LCc1PufI/igrrWY12Xc1+GigxoVK
         5TeCWnSxgX+HGsvXjS5ISJ+yT+r34Vq25VpU6zX75/itOtQx5wNdbdose96Y6dWu4W
         cnCAvVwxxIXVxW84qZwLRx+eQj2EXH3caOVJLmopQ2V60nY+akI2rIAIxG4/uAPWkl
         Fx6xTNXpXJ6ow==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 19:05:04 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 19:05:04 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 11/11] dt-bindings: leds: Add binding for AW20108 led driver
Date:   Fri, 6 Oct 2023 19:04:37 +0300
Message-ID: <20231006160437.15627-12-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 180438 [Oct 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;www.awinic.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/06 12:39:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/06 14:01:00
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

Add aw20108 compatible in devicetree binding for aw200xx led driver.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../devicetree/bindings/leds/awinic,aw200xx.yaml          | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
index 5cd167ab0f04..c3abb0f7ded3 100644
--- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
+++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
@@ -10,15 +10,16 @@ maintainers:
   - Martin Kurbanov <mmkurbanov@sberdevices.ru>
 
 description: |
-  This controller is present on AW20036/AW20054/AW20072.
-  It is a 3x12/6x9/6x12 matrix LED programmed via
-  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
+  This controller is present on AW20036/AW20054/AW20072/AW20108.
+  It is a 3x12/6x9/6x12/9x12 matrix LED programmed via
+  an I2C interface, up to 36/54/72/108 LEDs or 12/18/24/36 RGBs,
   3 pattern controllers for auto breathing or group dimming control.
 
   For more product information please see the link below:
   aw20036 - https://www.awinic.com/en/productDetail/AW20036QNR#tech-docs
   aw20054 - https://www.awinic.com/en/productDetail/AW20054QNR#tech-docs
   aw20072 - https://www.awinic.com/en/productDetail/AW20072QNR#tech-docs
+  aw20108 - https://www.awinic.com/en/productDetail/AW20108QNR#tech-docs
 
 properties:
   compatible:
@@ -26,6 +27,7 @@ properties:
       - awinic,aw20036
       - awinic,aw20054
       - awinic,aw20072
+      - awinic,aw20108
 
   reg:
     maxItems: 1
-- 
2.36.0

