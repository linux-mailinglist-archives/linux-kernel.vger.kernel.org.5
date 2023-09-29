Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF69C7B3066
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjI2Kbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjI2KbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:31:01 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674131BCA;
        Fri, 29 Sep 2023 03:29:54 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id BDE3912000F;
        Fri, 29 Sep 2023 13:29:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BDE3912000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1695983392;
        bh=FgKxXDgE/uNx01ueWhXfT0y9HcY1omQL2iYWSfBMwSs=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=vQv732HclpwMEw6YQWa/0tPyfXhUeDwEEDOBKinaeQgtqupz6RYFPwoVMMrnJKYlN
         qbfpQFQKr6lS0ZTpNrE8QIiyCJEVe4H7hGpza22h7mzMvRSz0zcJsMhqVnmeOWjljS
         fUmB4hicra5Uaq3L3N9oNCcDgo5lqTcZzgjNsMb/l4O4Fx0A2KIrav9Df94Jzu399r
         lZfbYc3K8whx0VfZNgYcTqoWZQfRs5hfQ4QUgYg3dGxw2X+jwxfkcdZ3ah3njWPHeP
         m5F5w3bXr0asC6eBvY56xLZKfY4SJePta7aDEKz/VIt4spZMbG9OQrEKSXd4yc5rNB
         gOOFgdr1C4FxA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 29 Sep 2023 13:29:52 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 29 Sep 2023 13:29:52 +0300
From:   Alexey Romanov <avromanov@salutedevices.com>
To:     <narmstrong@baylibre.com>, <neil.armstrong@linaro.org>,
        <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <conor@kernel.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <f.fainelli@gmail.com>, <hkallweit1@gmail.com>, <lists@kaiser.cx>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <kernel@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/3] dt-bindings: rng: meson: add meson-rng-s4 compatible
Date:   Fri, 29 Sep 2023 13:29:37 +0300
Message-ID: <20230929102942.67985-3-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929102942.67985-1-avromanov@salutedevices.com>
References: <20230929102942.67985-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180231 [Sep 29 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/09/29 07:52:00 #22006267
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Romanov <avromanov@sberdevices.ru>

Add compatible for hardware number generator node for
Amlogic S4-series.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
index 457a6e43d810..afa52af442a7 100644
--- a/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     enum:
       - amlogic,meson-rng
+      - amlogic,meson-s4-rng
 
   reg:
     maxItems: 1
-- 
2.25.1

