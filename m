Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA43C7F2D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjKUMtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjKUMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:49:01 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E30BD54
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdoLItPMf2nL9cb/dEqf143tNhk9Td5KZuuk+VMQxKSfbqKFiKsvmxKtQUZElvYa65gaiBx1J5OiAUr8gJJ/br7092xtNB9EuBCTrrciiix7fbsttmBGU4YviXhnE0v7/owPR8OddnnoJ8SiTjQMEHLiscLQsgA7aoUHrpLg0VJoanJN4EDY8AgOT4+wRGoaqm7xuoeLhdtxiYkRtSKTg1Tj/N0jDPqywq8iYatKRXZlfofPjloRS506eX942tcZJq8TnparGGf20yjetsDzfxSQWQl4PMb80JFIp2lmvpe7yyX2Z1H2Wc2W18K8/VbtSYx7L08ZS2GWX8TCqK4PvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU6tMHb+rRbjwho15vJYmBhlBR5auMXmKacfH5sGqrw=;
 b=FXSYnfjPP4M11a4NvXJ//w/I+maMR1fw+rWPsv7a0r2dpA9r6ULWuW7KZ1F8ORUKbQGAVkY5PDzy/toXMNNtu+y0kwwryktuvxMumr3yXFvqgH9vXJODh9/pSIYleui15qaV31pyw29FjZy//kW0dNrA1/s4AoQFo3pzRm+O0beeEfhoErzA7rVRumKc5vge8Vh/vwVw+EA+Y/3qL7b59cANWEpxZdqcI5/WYAJp90SPhH0z1kfhb4789BEwmp876pYswh7FvHPaLjwWCHLC6ftZzZF6OMHg1Gpx5TVs5rZVOjCQ1OiTTeTu7Vfk4j1WXGBCHeKsHF3WhKZix8I+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU6tMHb+rRbjwho15vJYmBhlBR5auMXmKacfH5sGqrw=;
 b=HD5tV2uBb4oOi6b8Uf0JjwaE3ItTgjZ5Y7XcK4dnWZqwMYjL/s8zXdqkbESRMjWgE1VYIuHdKdEqzbJ7yXCgQtpeZa2FpemTtpnxca5hv8xooDBj/P/90U0tl4saBbWAlTVr1HBV5cOVxItjHF0AbIOLstY7yS3PDgpXU03Ed6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB6440.eurprd08.prod.outlook.com (2603:10a6:20b:33f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 12:48:52 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 12:48:52 +0000
From:   Lukas Funke <lukas.funke-oss@weidmueller.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Lukas Funke <Lukas.Funke@weidmueller.com>,
        Lukas Funke <lukas.funke@weidmueller.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: usbc-tusb320: Set interrupt polarity based on device-tree
Date:   Tue, 21 Nov 2023 13:48:44 +0100
Message-Id: <20231121124844.872238-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a52c4ed-49fe-46b5-0158-08dbea90372c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPlmqW9AQKO0HUrjulugfMJpzGHfomQVWGjw85yFCRT0ULvv/38HIvNCHF9jE5qnnNI3sRoo4oVjHNROcEyl+w5joDv/1r91jMmNjfkUOVV87HdfuoVxAokxXrH4FBKbpy9S0J+w1d+m0NxnhLcFuw+nr+R45lwkCcBb+A/X3B45afUEMiwiqO9Q5mp7jV4g6frL2/jHUBQL0l6FeiNdu2h0P9iQmYbTZoaV/BAsd8vptqs9RQEJzMIacC4lAj0gVDU009bweCcvWlb41/4afACyC1OV/ZAzpJPDap6KYpOo7GEcslRm9AZ8kqSHc3ul05ssjGRgsmIvXJ4zm+laNmvKnxeXdTux1YYyFibZFGJTorXLPwsCZdd89p2lzP4p7IR2Tze2pB9QZ/SGl5V4tI2CRr8iuJ6JR18mPgbqYt0gcEthuszZ5R19ZczyJADEFW5Qg6n62N8AxLRFxHncerOPH81AsJomOF9H/tO+erlWVaKKZE92ZcPrpHuZM8Q/akG6O/Qi2SRW+YyBKYeSs9ZOkDz0KzwJl9oxLpMd3yb37wdF8LjDqaFkYOgmSE9OfSaghYJXj+kF6j5iW/L3fh0pMvsH9wuE7r6xg4iEO8PbU5xCGwSJ2vSQN6p1rrOWROTxxw7ETf7yYJfdtwY0mln1k06qx8Z6AYZzL1uC6mE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8431.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6666004)(83380400001)(6512007)(478600001)(6506007)(66946007)(54906003)(66476007)(66556008)(316002)(38100700002)(8936002)(4326008)(8676002)(110136005)(6486002)(52116002)(26005)(2616005)(86362001)(5660300002)(41300700001)(1076003)(36756003)(38350700005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0kPvhCAjUNPcVRgD5s4W4EfzLBnbvs3PILxwXEY3roi4ucvKigUl7v8LRtTT?=
 =?us-ascii?Q?k8H3t9l16cql1AOd5yoW7JfB18d9WecRU9/sSQqvIVxwFz2tsBKYwQKIGIZ6?=
 =?us-ascii?Q?C/t8XbeurMfr1xYkBRBtqvQzYQe9sPDvcLiwrfair4S6F91GQwP7Uhc7lA9W?=
 =?us-ascii?Q?sIMPD3uvukcTB6wPXtWyReWKv+0I6U1bXsEVbkks9FxN0l/UnjBc5L12Bp+5?=
 =?us-ascii?Q?Y9pnDAKIxVW8hLUb4CCgCHsrDDZr0dTOueRfdrM4+P5WoQXhjxkfp05/897K?=
 =?us-ascii?Q?8YwfJG/+khA6RWe8JMk0Es2TbbF2UmXdoMlxnXNBixtQLJPMBq11AvV0emIe?=
 =?us-ascii?Q?tsrLPhUtnuYwPJmEJXjGxjV81YQG7RGEOYh0w5EDSQtHBdolJOdj3+i6BGaq?=
 =?us-ascii?Q?CQCsLB4G8aKweyP2Pf7QpxJI+QJ82xEF6BRLU6D5nY/ZWrEdutaFOzoNWM4O?=
 =?us-ascii?Q?kupusoq9rpyGiykwXLLHTU4w9RG5QBAIeBvMbYr2PKjcPgom4++NARE7ZGhZ?=
 =?us-ascii?Q?UQgqIa1ssdunM/I2pzvNlGPi8c2i0yLveTCSBEtZ7EpAWPLsewFos2yvoyBD?=
 =?us-ascii?Q?ubnP9PEwbwTpW5LPnX+924sETYkNsYWNEI1uf4zB/ADUL2M8+kDBAzH0j2tH?=
 =?us-ascii?Q?d8fFmJL2XJasGVjQKMkBjir9Er4seVpBzApja+H6ZYpeyl9Im3/xzifHTZ6f?=
 =?us-ascii?Q?1FJwx/jJbRm29TvTAhrWOheZ7c/FvgGMQpjJpLaXOFPKm1kCFMXIOKA3m0LC?=
 =?us-ascii?Q?YP2GR0JhJGibVKEgfnREa6IlE+W+8cdBDFC0ZwVoo9QUMBtQ+Y6ztH95TZvD?=
 =?us-ascii?Q?rlI9ENo86gSb8Z0+sVdwohsNudm0QnYEsnqi2Zx0DLSpSpOheoo7MwzSYgGK?=
 =?us-ascii?Q?814QvFCcoRUGZuxairhRAvBo8TRMfezSMOcG+CNMSQSJPXY0rJCSBV/r2J1x?=
 =?us-ascii?Q?pGWvbF1/ufvOKlJBmXR2LitkQY+XXXjujiB+FpFVKGQwTh57+7M/zjvyTlKv?=
 =?us-ascii?Q?bpZuxJmqKAXfyhLXTWUH1LYgKKGlP8QVsD/+F72cHG7QwfTGM4PUw8w+u0+V?=
 =?us-ascii?Q?MQpoorzbfj0UPbZ1HN4+vWBiIVmBNlAG/DiklfxGyKjg63NDUcGT0zwpRvk6?=
 =?us-ascii?Q?rcKD7LnRzqDo+DBFIDwem36VAxUhRPqqWagI4F33zeZUH3jn/rLxs3wILXGC?=
 =?us-ascii?Q?NY3x8AMWUreud65K+m597DMG8liagbwOBuIoEkUsUvskjEP0op91iusfj+54?=
 =?us-ascii?Q?wJt8GbDOh70aQT80FtHTxkI5EpX3PhDevJaIuCLmAD/tK2/k49gqCM93E/QV?=
 =?us-ascii?Q?/LDYeyWeavtgteIh8HFKI30aHUtKxf/Gw9InsXbqpqrZbwffDL8CT6nxfF3+?=
 =?us-ascii?Q?q4N4EFrzBiO/ECRXeWqUofI9RwXWe+erf2ckga4r3M/jKehrxnpg2W0rfoTS?=
 =?us-ascii?Q?pns9W7DeQS0w/PVmnDeoYQ/h/Hsh7Egn4e4XGVilXMKBA6ZfsfGWcjb1amPD?=
 =?us-ascii?Q?yNkP0STfgnwZ2vEiX3Dd0R55E9KoDnBtTGH5ixgXBJSA45TInv7+VulTmFZu?=
 =?us-ascii?Q?p4XXqB7VjFObvQdGktlOuJbv4viGsPK/aNQcfBwfOqGLJIG6xf2mO7nkcd6r?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a52c4ed-49fe-46b5-0158-08dbea90372c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 12:48:52.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfGkvXwYBBQdSJtZ2t9i7Py9e5tqTnbLHAsS92hm8C3q5K5ac4jgPkw12Js/exUuMifmn5w1wgbj7HLD4444/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6440
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Funke <Lukas.Funke@weidmueller.com>

Remove 'IRQF_TRIGGER_FALLING' request which is not allowed on
every interrupt controller (i.e. arm64 GIC). Replace flag by a 
request that depends on the actual device-tree setting.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 4d08c2123e59..f7d699a90f72 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -515,6 +515,8 @@ static int tusb320_probe(struct i2c_client *client)
 	const void *match_data;
 	unsigned int revision;
 	int ret;
+	int irq_pol;
+	struct irq_data *irq_d;
 
 	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -568,9 +570,17 @@ static int tusb320_probe(struct i2c_client *client)
 		 */
 		tusb320_state_update_handler(priv, true);
 
+	irq_d = irq_get_irq_data(client->irq);
+	if (!irq_d) {
+		dev_err(&client->dev, "Invalid IRQ: %d\n", client->irq);
+		return -ENODEV;
+	}
+
+	irq_pol = irqd_get_trigger_type(irq_d);
+
 	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
 					tusb320_irq_handler,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					IRQF_ONESHOT | irq_pol,
 					client->name, priv);
 	if (ret)
 		tusb320_typec_remove(priv);
-- 
2.30.2

