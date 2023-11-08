Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B987E5AA7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjKHP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjKHP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:57:13 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08171FE1;
        Wed,  8 Nov 2023 07:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA+c/9332IRcA9pgeJWeWW+P5SJC0TwT5Ek+T79syp6XuPnBRs11lEDkGy8TXda93Ou9Qw0xV7+NjDnO84T+lb1lbrYl0oJSmH+V0lYpbOTtVuOZ626dIiKyFFXpwgx6v+tcJkQigi7q5bKirhQiXXPM5a267ognzS+Cq2z7NuSmMlGr93ybRfpYoaeeVoNJAOqZv7Lap/0oQ2jtLOLHmX05IE+y+amTCYaD3tmh+fuFizLuvCtNqirPuvRaZJqxzPAIzcUNl50qQvBhB4IgXqM/BRBb9TI6fPnqZ8AkZWfhk/sBuVbeJDo9TBFGwx/d3vE2V/2Bbb4MqJYhKurqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/TXOXVEhWUf4cxEo/jB8TMyttY35vqVR0XLwmU4afE=;
 b=fRpjCLONCDIYeNHn7nr9qKAtHgKjFUDxY7qthfH8WYYV0W0AT1tV0FEXXALZmFoHKPs0b3ufpd9tZbfzBvsNqF5d43F126ajOJuTCqpjBjx7otoVKgypaTYd4N3QI0pWBs652tM3gLBJLCLvhZQtvrAf7vC3gUKduuIcjy89od3h6LY3y+OcfhtU2zEQ+gxVhPcT/megbZH7WMLlKl6DR5xLd1Fmk4qYsMydmGpFRf/dnrnBMvM7pyE0H3R//Ar8Pksk5z77fLRy80ZBMPf7rID9p3BGbgMJ7yODDNQe5AEwnoCpmuKScfhjIH/RzO5om9WYO6b3xf2eAUyCHPuhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=2n.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/TXOXVEhWUf4cxEo/jB8TMyttY35vqVR0XLwmU4afE=;
 b=sEVZOFn3MacTe86bdwRKg1+bJ0YxcatnBB6OBki9xPs+nS+r2JBC6A0MdBJE8c+BnMXy4DtF5O/d8JTBGlrkeyWYW6OzDoBnqJuRe+jyxXPYHRrQGOWcRSahDSzdcXpmNDxEbIR4xJecELAkgGePxCHrkL0UyBDeyztAKKzc7zA=
Received: from AS9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::28) by AM7PR02MB5781.eurprd02.prod.outlook.com
 (2603:10a6:20b:108::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 15:57:08 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:540:cafe::c2) by AS9PR01CA0015.outlook.office365.com
 (2603:10a6:20b:540::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 15:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of 2n.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.17 via Frontend Transport; Wed, 8 Nov 2023 15:57:08 +0000
Received: from lap5cg227217h.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Nov
 2023 16:57:07 +0100
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v5 3/3] Input: cap11xx - remove unnecessary IRQ parsing
Date:   Wed, 8 Nov 2023 16:56:47 +0100
Message-ID: <20231108155647.1812835-4-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108155647.1812835-1-jiriv@axis.com>
References: <20231108155647.1812835-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|AM7PR02MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: f96db592-e659-4fa6-c4e2-08dbe0735ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1kYN0do9e+I81AxKs5UxQ6t2Q2XlcPCXazSL0ILxJZAOhrwnRLzczzOSuhF9oU4fwvZUIVC4eomX9n+UDq1pN1LbEvKefwvRMb7h/AcHyOZC7mSyOde+ekE6cPj8cZd8DyPuNYQRXojnPta9xCM1lS6qg+K5xwRAm4yl4HJ0BiXiuOv9hkfOCrOgrXYExNPUfRgq8L6qyEZ/BsprMulqqGU6Uqe1naB5zM1KeicK/arrsSI90Yc5yIwpA2euaiX9I7ovqxQBatbcX0fECXlIwGpew4PwvwLH+I/TNdm7brl6Y5eAsU6sKoMXdr794EznWNx+x01RYE3cRSkO7vL96w2k6KpktpgaxyrykleZIP25FAByE2FJ8MGkJLlHY1VNepuNgYsdSL98AbFxVDOBbSzTYEvMGmhW24jAAhktxxEcGFuhvqu4kKoQvWQhGyKJCPz0lpD5Ltok8mVaBnZk5exgHmgx9917cuEO7+2l4Tl1zODOW7hEYlo7KGJm1QrKYIuiYlZQctneH/cmlmxBRiQQt6RJLL+So7YXvZZVrGfs8jcm1Dx6GHbadVUt9GAEYSb1G6z4u6XissBMHUGBOJ4LyoLiUyYZXDVyBv6AwmLc6mfEgHybiYU3kD3DdxMxz02fz1DSrm88HASM1UBc7k9GCWlj0Ib/xE7euRFSFluztq/2w2xyCDF2VGPG7vqu+hbo7Xo1gHoPVpMjHYfCdmx/q3RvJrN8ZxFtxC7qnWMY1rFlQgjf6SsqtrT53P0nIcK4zskzUfa3uPGuonsDw==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39850400004)(376002)(136003)(396003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(16526019)(7696005)(6666004)(2616005)(478600001)(82740400003)(83380400001)(426003)(1076003)(70206006)(336012)(26005)(42882007)(54906003)(47076005)(2906002)(110136005)(70586007)(4326008)(41300700001)(316002)(8936002)(8676002)(5660300002)(83170400001)(36756003)(36860700001)(356005)(81166007)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 15:57:08.5725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96db592-e659-4fa6-c4e2-08dbe0735ccf
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate IRQ parsing is not necessary, I2C core do the job.

Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
 drivers/input/keyboard/cap11xx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 4711ea985627..ccca9936ef25 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -518,7 +518,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	struct device *dev = &i2c_client->dev;
 	struct cap11xx_priv *priv;
 	const struct cap11xx_hw_model *cap;
-	int i, error, irq;
+	int i, error;
 	unsigned int val, rev;
 
 	if (id->driver_data >= ARRAY_SIZE(cap11xx_devices)) {
@@ -624,13 +624,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (error)
 		return error;
 
-	irq = irq_of_parse_and_map(dev->of_node, 0);
-	if (!irq) {
-		dev_err(dev, "Unable to parse or map IRQ\n");
-		return -ENXIO;
-	}
-
-	error = devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
+	error = devm_request_threaded_irq(dev, i2c_client->irq, NULL, cap11xx_thread_func,
 					  IRQF_ONESHOT, dev_name(dev), priv);
 	if (error)
 		return error;
-- 
2.25.1

