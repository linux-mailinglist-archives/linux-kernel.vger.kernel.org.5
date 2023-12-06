Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095F08064DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376537AbjLFBmt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 20:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376485AbjLFBmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:42:44 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3B01B8;
        Tue,  5 Dec 2023 17:42:50 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 001AE24E23E;
        Wed,  6 Dec 2023 09:42:47 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 09:42:47 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 09:42:44 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] hwrng: starfive - Update compatible string
Date:   Wed, 6 Dec 2023 09:42:35 +0800
Message-ID: <20231206014236.1109832-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206014236.1109832-1-jiajie.ho@starfivetech.com>
References: <20231206014236.1109832-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
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

Add compatible string for StarFive JH8100 SoC.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/char/hw_random/jh7110-trng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/jh7110-trng.c b/drivers/char/hw_random/jh7110-trng.c
index 38474d48a25e..46272a9e5964 100644
--- a/drivers/char/hw_random/jh7110-trng.c
+++ b/drivers/char/hw_random/jh7110-trng.c
@@ -374,6 +374,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(starfive_trng_pm_ops, starfive_trng_suspend,
 
 static const struct of_device_id trng_dt_ids[] __maybe_unused = {
 	{ .compatible = "starfive,jh7110-trng" },
+	{ .compatible = "starfive,jh8100-trng" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, trng_dt_ids);
@@ -381,7 +382,7 @@ MODULE_DEVICE_TABLE(of, trng_dt_ids);
 static struct platform_driver starfive_trng_driver = {
 	.probe	= starfive_trng_probe,
 	.driver	= {
-		.name		= "jh7110-trng",
+		.name		= "starfive-trng",
 		.pm		= &starfive_trng_pm_ops,
 		.of_match_table	= of_match_ptr(trng_dt_ids),
 	},
-- 
2.34.1

