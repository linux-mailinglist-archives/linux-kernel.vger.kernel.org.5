Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57CE80E2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjLLDSM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 22:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjLLDSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:18:10 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD98DB;
        Mon, 11 Dec 2023 19:18:14 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9835824E2AC;
        Tue, 12 Dec 2023 11:18:13 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 11:18:13 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 11:18:09 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
Date:   Tue, 12 Dec 2023 11:17:31 +0800
Message-ID: <20231212031731.2498584-2-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212031731.2498584-1-jisheng.teoh@starfivetech.com>
References: <20231212031731.2498584-1-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
watchdog.
Since JH8100 watchdog only has 1 reset signal, update binding
document to support one reset for "starfive,jh8100-wdt" compatible.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 .../devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
index 68f3f6fd08a6..02572b16ac08 100644
--- a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
@@ -27,6 +27,7 @@ properties:
     enum:
       - starfive,jh7100-wdt
       - starfive,jh7110-wdt
+      - starfive,jh8100-wdt
 
   reg:
     maxItems: 1
@@ -45,6 +46,7 @@ properties:
       - const: core
 
   resets:
+    minItems: 1
     items:
       - description: APB reset
       - description: Core reset
-- 
2.25.1

