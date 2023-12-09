Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9EE80B4E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjLIO2D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Dec 2023 09:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLIO16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 09:27:58 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1B210E0;
        Sat,  9 Dec 2023 06:28:01 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 13BC824DFCE;
        Sat,  9 Dec 2023 22:27:59 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 9 Dec
 2023 22:27:58 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 9 Dec
 2023 22:27:53 +0800
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
Subject: [PATCH v1 1/2] watchdog: starfive-wdt: Add JH8100 watchdog compatible string
Date:   Sat, 9 Dec 2023 22:27:22 +0800
Message-ID: <20231209142723.2060196-2-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231209142723.2060196-1-jisheng.teoh@starfivetech.com>
References: <20231209142723.2060196-1-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "starfive,jh8100-wdt" compatible for StarFive's JH8100 watchdog.
JH8100 watchdog reuses JH7110 register mapping.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 drivers/watchdog/starfive-wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 5f501b41faf9..31785bb373d5 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -581,6 +581,7 @@ static const struct dev_pm_ops starfive_wdt_pm_ops = {
 static const struct of_device_id starfive_wdt_match[] = {
 	{ .compatible = "starfive,jh7100-wdt", .data = &starfive_wdt_jh7100_variant },
 	{ .compatible = "starfive,jh7110-wdt", .data = &starfive_wdt_jh7110_variant },
+	{ .compatible = "starfive,jh8100-wdt", .data = &starfive_wdt_jh7110_variant },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, starfive_wdt_match);
-- 
2.25.1

