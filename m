Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36747534B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjGNIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjGNIIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:08:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3175046B0;
        Fri, 14 Jul 2023 01:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcLozNJRARfQR5s+De9nRIKIfPlCI1en4EYIXL6OsYYOcx2S9C2YSyuviSScGr7KuJlkeswNHuVuvpz5kD/OO/60mZGvWedExFUijEVtULOQK9ySlhDd2MZ5Fr4xAYIwTz60EUC8ecLTUpo6B6lrSGtumY9bVjMb3E+KvP40KcyyMF8nzKGWRyx076T6+I/59Sv43NWTJtgqWnWFti8fiPu4vRryRVfK245eLQrijt4phODj6JCJAnJdSVWUSjoCjXKCkygDYiyD7g7iAwnJG90YaaiomYyq1YEBT1xD1AyOUIjpmJgtnr0pI1mc7JlIuPASuJaFmAk6D2nsjfbFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeJurPe7ItKE7RXvcYGKs7Z4OLyB1jbsfYIGHzoI8J4=;
 b=eGm2W8sDtaR3Jbs51vJDt2aAApzv2Hjq2kIXAECa+9sfAMn1OyHEdIufoWMrVqMQ2u3KC5Jqs1FXvhTlm4yiUPH1wASDmZK/jEsJhK8b/EVrIC9QCpkooqPZN9PoufuPEIH3zogbrk8GMKTdLDFzWFr+hWsJBRwgm04GqjrmdiSJt6bUbXJw7/CKHCC9d/bRyXb7UwpHPqIFTFv6w20AKYYQw3f7mLcr8t57G/gTP+pTMGlE68JtMGpKRTjf/aeg4NyEuXdG6vD8XdP82qUPKoRYfvEewlo38Y9iniYioY7rOoarXJC5EvWCFTyb5ChBaf/kLxFjyj/Fgt6E+SFItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeJurPe7ItKE7RXvcYGKs7Z4OLyB1jbsfYIGHzoI8J4=;
 b=P+aVzCsMjXydpFPQAwH/ig5ad/WzFTLAg+dPHtWjTZVBWHTudLunvC4HjKkhZnEY6ES4V/Go4ERvYrBbV4aGY2vmrzEDZxoCY/C2X2VbYy6DY7t1VEci4+/du7loOT1643qdxUbTnJ0YeWRAVcpzGJ4ph2qw1IiSoxSMl3NFhD0y1JFSzwsLuDp4avqobVBZ/uu14lRIorj9pwxomhQceLEqDoO6ZyyfLpl59PtD6yv2SBZ4EY8Lr+uVFRh1qZ7IuBWzdL1OB2Au6R5kvt5/pUgV+6LoqY0dsLMspbMvYZOWXDUSNC5SujK7bfOcVSNTTKPo9REiPR5J/TIxK+fDUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6058.apcprd06.prod.outlook.com (2603:1096:101:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:06:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 08:06:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] Input: amikbd - convert to use devm_* api
Date:   Fri, 14 Jul 2023 16:06:05 +0800
Message-Id: <20230714080611.81302-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230714080611.81302-1-frank.li@vivo.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:4::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c8d827-20cd-43fc-0baa-08db844136c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9ZB3SpGg1un/I/BIBWka77MFL5PeSxOj84DtlEnxA6zJwxX9o6lwTA39R9mNYTrA822Y0kklm0tOrz7rJMnu/1bT99AkxeABqslu5P61WYvRjlXzihjToGUQ95mCxbYnhFEdPd6CZ+hZRlfL3zMllmyaiMdHqzQgv5C/q402S9YHIyeksUiWxmoEKXTjwjem2J+uQTuj+IYVC2MMdKmlPHADDNfkK6CZ2GnyoJfxrCzlGPQFj6dSS8kkLFJA/yU99PBuCbqgmf+j5acXKu8zbW/k0RnV9OaL7rnrgEpNPC+hcPUtkDh5rTBe2qnla3n9MGYqxeo3/ebo7Htrk/sojQ+ut0RT3+xf5y1EpBTWZovE9J/7/bjesmZOON8jq9QdW8UUdHw0YAIJADLHH90Ff/6Tb50CFEDjIVGxhDFNeqdR08ZPkn3TYHnY9U0AHAXxYT5Y32zayIW3/PYx0p3cYp6zA2+Tplib0IYVWdNTAU8wCN4pbKp4zpwHfdSiW4rU1HNuQmvF9WNdsabAbpkeVL2hOm8fUyZp1Stet0VAnIyOfW4O6uCxvq0a3iXr5L7fTP7dYa46JBMJdFrjyai03ep7N06AywpHw86mjf+rGrYnhd4X01qA1vCXZYS8aSt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(4326008)(6916009)(66556008)(66946007)(66476007)(41300700001)(316002)(2906002)(478600001)(5660300002)(8676002)(8936002)(6666004)(6486002)(52116002)(6512007)(26005)(2616005)(186003)(36756003)(83380400001)(6506007)(38100700002)(1076003)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LG0lOUObEqqCCbaiDyV2wUzV46gO2O7YsbsZ6repDziWQt9s+sMMQNin0P1e?=
 =?us-ascii?Q?6YsDxMKrFIWT21WzJBVf9JU/o+qWDWA7qpxkB32PfTmD5yMbyonwI6JTK9jo?=
 =?us-ascii?Q?y/k10dwtGniWB9+XYGL6S171UdJ++pz+IH9o05fMtYfhVGm4HmHbKw1eT3eb?=
 =?us-ascii?Q?4lGUQweHhXJR1JPY9tPxzz1TrCrwk4IZHXe5Qs8xrb6sSlwnKj8FbIsxb0yi?=
 =?us-ascii?Q?kcQQa+HtPSNnmbx7ztXukDCqvuE+HkxUa8oKoA1TuZ0k962dk/NhmcpWhXqp?=
 =?us-ascii?Q?6/TrRY2ZcppFfXLZfB+Ig2DQCbWuOkSSrCJa3cRRrhhiDs6jvZ+9loLaJI0Y?=
 =?us-ascii?Q?ldjRx4JarZUqODmL7s9YW5Pe7oeB/+k1JYpGr0dQOdlKDVSXGDY3QNGR4JCW?=
 =?us-ascii?Q?f9ImgDbNxfye3Xlb+DCmb3P6GgDE7/FsdUTbVh/6l0qLLzFe8otLuB459v7k?=
 =?us-ascii?Q?jJhb1uSdn1DaoGh+ob3flhocL0tJdYGQiRjzentf5kOAgaoCsvsnSjwndeNK?=
 =?us-ascii?Q?EdfXT8MCv7VyYd5BkSgxYEf2xGB67AO95qOu2VPELXWlp9W3/65gxQreVuh6?=
 =?us-ascii?Q?AO7B5Du3RJ/u8AuiQxbH8SZKUbiFCwVLiwOGXUbXQ1WAQpIKSBKedRN1C+aC?=
 =?us-ascii?Q?1wyb6UH9FGJB+PsKfM0vSM8u9kDkUP1Iz2RCB07l/PafzjbgNDPJTLNS+dJr?=
 =?us-ascii?Q?E/lHf3L4ESeqs8iE0ssaD6uQk1owiJ7VWihAxftVkVZOwthOwNb16ClL2aCO?=
 =?us-ascii?Q?PcJ7rgc7EBtgwED3c8DQ+E1UEnDGPwTJwNLGyiIeataq3RxaD0/79eolvul/?=
 =?us-ascii?Q?q3fw5W9zber8XCflUtr/wj7cUKfHRZRIlk3/sJ7tcQ6qhNKdnTcEkQArZVdI?=
 =?us-ascii?Q?odXS2W7buw7W/onb0N7CDs/09pJHlZVJOXr2/BGkb9Z+IFTDXEcGISm4h6TO?=
 =?us-ascii?Q?+ZU9lxp9PkWZLNDOhszeMds3YWGGjuXTbAh0vZzTyzhDZwJkeIgEa6RUiqM4?=
 =?us-ascii?Q?b+Kja7W9Xp8J8ySbh8d5/HYqCyPz9PAsSHLXZdD/0J6orgCRc7OhQVNZ3e0m?=
 =?us-ascii?Q?z4RRHr/QYvz74shtMK1YEEVweK4L18Zwg4HO6lqNb84JF2nePVvEw0Mb4BTy?=
 =?us-ascii?Q?VxS5nKyS5E6Pem1cy/oq/1D9dLJTIbAI4BtpXdBcm9xao2i2nHc9xk5lU0Fe?=
 =?us-ascii?Q?KKOwdJBbzgK0iVc3NauopqB8K4WpbHHmffarD8UFXxKeCQrFUe7gSOj8U1K2?=
 =?us-ascii?Q?2rYpP7hJne13GuT2AGd10HRx+uK7Gp/415MqQu1Cg4zvtczAgJNhibdoJFfl?=
 =?us-ascii?Q?c8VNAukEwrteSERtb2IpiylSuHyYOXOTxFjgPmSHP0/Xle9V7DkPsC0/S/kg?=
 =?us-ascii?Q?5s+MqVQ2fyEVykItNvJIuKSQCAoxe3I7nZvPp3B77UTG0YtWhSYsDYJtSCDL?=
 =?us-ascii?Q?4aSCa5EYvp2agvJcS23g8L9L3qhw7Xh/l4uwpF4mVyA9o3ebBBIOj1RJosfn?=
 =?us-ascii?Q?FZXeUCUaPeQa0BKYbaPQAMS/sFgZc8c+2ReJLoyKeR5+fmGX8OiOLImrpJjs?=
 =?us-ascii?Q?QZA0a25nyJTJs5OyaC3AoB93UC+CLlvyJeW3KcTg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c8d827-20cd-43fc-0baa-08db844136c2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:06:23.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhCSSl42C1vjAJwMYssLwLBWAlUveXqoKvApjp52M1d06zalQMyFmSZghHCb6vOpVuK7mxzWSRx7USGGu0Vl6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_* api to simplify code, this makes it unnecessary to explicitly
release resources.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/keyboard/amikbd.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
index a20a4e186639..4cbac79f5a4b 100644
--- a/drivers/input/keyboard/amikbd.c
+++ b/drivers/input/keyboard/amikbd.c
@@ -193,10 +193,11 @@ static irqreturn_t amikbd_interrupt(int irq, void *data)
 
 static int __init amikbd_probe(struct platform_device *pdev)
 {
+	struct device *device = &pdev->dev;
 	struct input_dev *dev;
 	int i, err;
 
-	dev = input_allocate_device();
+	dev = devm_input_allocate_device(device);
 	if (!dev) {
 		dev_err(&pdev->dev, "Not enough memory for input device\n");
 		return -ENOMEM;
@@ -218,35 +219,21 @@ static int __init amikbd_probe(struct platform_device *pdev)
 	amikbd_init_console_keymaps();
 
 	ciaa.cra &= ~0x41;	 /* serial data in, turn off TA */
-	err = request_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt, 0, "amikbd",
-			  dev);
+	err = devm_request_irq(device, IRQ_AMIGA_CIAA_SP, amikbd_interrupt, 0, "amikbd",
+			       dev);
 	if (err)
-		goto fail2;
+		return err;
 
 	err = input_register_device(dev);
 	if (err)
-		goto fail3;
+		return err;
 
 	platform_set_drvdata(pdev, dev);
 
 	return 0;
-
- fail3:	free_irq(IRQ_AMIGA_CIAA_SP, dev);
- fail2:	input_free_device(dev);
-	return err;
-}
-
-static int __exit amikbd_remove(struct platform_device *pdev)
-{
-	struct input_dev *dev = platform_get_drvdata(pdev);
-
-	free_irq(IRQ_AMIGA_CIAA_SP, dev);
-	input_unregister_device(dev);
-	return 0;
 }
 
 static struct platform_driver amikbd_driver = {
-	.remove = __exit_p(amikbd_remove),
 	.driver   = {
 		.name	= "amiga-keyboard",
 	},
-- 
2.39.0

