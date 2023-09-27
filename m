Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1A7B04EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjI0NHn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 09:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjI0NHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:07:40 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103CF5;
        Wed, 27 Sep 2023 06:07:39 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 290758022;
        Wed, 27 Sep 2023 21:07:37 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 21:07:37 +0800
Received: from ubuntu.localdomain (113.72.144.128) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 21:07:36 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
CC:     Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [-next v1 2/2] pmdomain: starfive: Update prefixes for AON power domain
Date:   Wed, 27 Sep 2023 06:07:34 -0700
Message-ID: <20230927130734.9921-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927130734.9921-1-changhuang.liang@starfivetech.com>
References: <20230927130734.9921-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.128]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "JH7110_AON_PD_" prefix for AON power doamin for JH7110 SoC.

Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/pmdomain/starfive/jh71xx-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/starfive/jh71xx-pmu.c b/drivers/pmdomain/starfive/jh71xx-pmu.c
index 2724bee7e85f..74720c09a6e3 100644
--- a/drivers/pmdomain/starfive/jh71xx-pmu.c
+++ b/drivers/pmdomain/starfive/jh71xx-pmu.c
@@ -419,11 +419,11 @@ static const struct jh71xx_pmu_match_data jh7110_pmu = {
 };
 
 static const struct jh71xx_domain_info jh7110_aon_power_domains[] = {
-	[JH7110_PD_DPHY_TX] = {
+	[JH7110_AON_PD_DPHY_TX] = {
 		.name = "DPHY-TX",
 		.bit = 30,
 	},
-	[JH7110_PD_DPHY_RX] = {
+	[JH7110_AON_PD_DPHY_RX] = {
 		.name = "DPHY-RX",
 		.bit = 31,
 	},
-- 
2.25.1

