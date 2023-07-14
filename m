Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBC7534AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjGNIJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjGNIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:08:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B4C46AF;
        Fri, 14 Jul 2023 01:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efVKJi+Nu5fJldOztSAGHnWUAp8xvYcTy/Juni062gArjc87UUbm3sisQDbkqPmMwglCnZZ4G3hdMM7ERqFNx8aTkYbL6nAqESvVR5ROx8dFogi+4rN/m3PCh9jAlE7tstTwtVoKCOOYnGaamymL8uzcpZh6tB6zRKQt2saj/SHAqNZEIgRxt9m18oetYIZMF+KvQkFw6j+rqnOTvoCteLaw8O388jdgZWAH/GzAjP3zbyNSKf/EADciYN1Ck1hHauXvuk2yHdsCtj/L/qRGEJmxh2GqxtI/QmdUMaMcyZWyIfutNP6rkj8bRUb6q5Lj/HcNKqYhz9bFUO+22B/npg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saEl64TDhrT6KRUSNF9mduU8aXv4PHc+GMBrNqfWFeI=;
 b=dg1UDD8T7UYb/FYjfdI5jJeBdSgA7UGka3I/7nbTXQT1H1p1sT+7/RykABlaOrwDNIpmg6HSerxjk7pW/bb/7seGEWxZShtgNc7HcEdRbLwJL8ph4kFwpg5gyBKhD55xKQhNNHG6xZxNHss8WpAJh6QVy6EGR3sYTsoQR4QNW7ubgp+DVChdYdhq04C8P6/8apysGHNApI9a/DD+GM+iC1hsnJZSxC6Dwn1UW+9b90MHGp5DOHWpDdgnxXDmIwbnMAkqGsoJTmBVQmyQCTRfB35iExJyXNqsZD+d7yWKZLjcXoFvC/heJmG4A5QTNP7HP7LQ7gGnVad4zqVBUjzvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saEl64TDhrT6KRUSNF9mduU8aXv4PHc+GMBrNqfWFeI=;
 b=dwidkKm62eWr9sEsp4PQ5/ZczBtjAp0lYv+zBkqzAoAK19bIbolIyP2hTcgH8eogsdWmnq7rWMdveZeYBDB2CatS2ToDl5Ghz4FPKcQMOsyqJd5YkAnXT4HfMQ8lEOujgBx6nRE8Ks0/FMOr8Fy/clz4+L5CHKbuVFSR6X98HJk9K5JBY/Fl4Evxo3gesstQepxJFx0HbMu2zecvJaU1T/T4x8KuVLXZ52m23SE/NopBAMvXTghp/3JICL3DiXvrGb07HqriJBcyQDavl0zo5AiOsea2M2BEpC97awpZE9myPcP4gZ2geVSt+kNe6bmCWuGXvdxqEq4cXuME19XSMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4059.apcprd06.prod.outlook.com (2603:1096:4:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:06:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 08:06:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] Input: lm8333 - convert to use devm_* api
Date:   Fri, 14 Jul 2023 16:06:04 +0800
Message-Id: <20230714080611.81302-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:4::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: e11625d6-92fb-4c6d-c20d-08db844135a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KhSX391UVjyX0sUCYAdsjbGyh9AaS+DPAxrd2M9PfRPbL8fcOx/f9ZK9H8/tdJvmuV0moWpkuYylO73qAMnsW4AQuEporfYMVpRok8N9jxlwjlRiJpIJzFZJWp7Edip81J6dW6PrW9oljLlT5O+QZLX8mBvJrnmAsY1VOqrncG4jGgZx6Kz9AxhcOkJY/ocewQX0WJ2PRucvbHDh71l3Thbhq815Mv2hMo75PLJxCRyZR7E8eD/qc9s344+jv9xhs1KUkCMCEAc0zrNR/Qux2EXE2tJBPJc9phKOKMRiuD1sVQnKK9yL42+nI71NUuwl5kyC5bQrePGZSOqVOE+87yg9mKhRz6vAsBov4exBPvSb0EuwrtPx/Zo49s9uNXcxXL7YoKMhlGHcM3lf5+iCFKmNjCDQFn4Rm7rsIZ3VbtC/5ma+WbBrM34jsm6RbJMpYoaqI0NHRmvGvQMbi+ce5PGBW3pvDQ+q5/4zyewRx3KyO33hEPJ1v8dIcmwx/gfovsqfnWv83EHhq0lGnpFj+Yx4qD4mlBj7x04rqg0e36Ldi+Kw+yy/9dgCI9KMX4VO/fuRnUXVFNswcM+vIVGORVRbT/EfiY8o+2LlgE2UDpJAWYkIT0y5qW/EvYtktia
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(52116002)(6486002)(6666004)(478600001)(2616005)(83380400001)(36756003)(86362001)(2906002)(26005)(186003)(1076003)(6506007)(6512007)(316002)(38100700002)(38350700002)(66556008)(66476007)(6916009)(4326008)(66946007)(41300700001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NGWwlLni5BG6tXaM8EApStxUkOKxHvBN/E6iP38rv3FietmYuGqA+K0+jb98?=
 =?us-ascii?Q?u145aHm2V/Ej2hZ41F8X/r2N3yGMkOVspP1D96UyjFvo51hSWojt2sDciwqe?=
 =?us-ascii?Q?JFxU1foL+D1NJJwW3tV2vHt6zmF3H0iJTqychFSVm4C3JfIMqFFmfUp6pqwR?=
 =?us-ascii?Q?J2OjRKQ4BOaHczs6h5gsb8KHaWYJrztOdwjWxcD6e245UUplOw/r+GD3Dnml?=
 =?us-ascii?Q?gYYtgguMYQFph5tJHGFuvPaeAC//kC1V1KYa91OVchh42wzUZ9JpcSzRLECc?=
 =?us-ascii?Q?ikgnkstRBRbaVSuINd8tGqKpLjOwpM0KZui3xN1WXDvMMdafPRYvFCNg9T5V?=
 =?us-ascii?Q?+68HjCK3a5XT+GHxKJ5TwIgak4Q4fZvk+2J6WxYcdXuUI/dQaSglHX/VUWjJ?=
 =?us-ascii?Q?QyQI+GRRu81apJQS0q4H74EiWAT0qwpCgZDqjMy1/p1JYqlZNdZXOvlLNVDo?=
 =?us-ascii?Q?1T5FaPvNnIo/E4WUKwde3pgBNSTWtXMZYn1PL+jOoL5wUlKbpxTNVjIC/9OK?=
 =?us-ascii?Q?Y2GCGCNPyAIwTq9lVOmX5NYvXpUHPzOCH6XcWeYisc2P3179hzDhkkz6BTqj?=
 =?us-ascii?Q?u5ApMI7UigXWyRrOf4DWFxuiwIslvcy0FD2FI8Q72W9BB9DkqxtGkYCKFDm3?=
 =?us-ascii?Q?rk9E24ZxaCIP1eQ4fCCTnQofBuJATTgSs/aTKkqWMzMtzyeZTcnwzqFnMLlF?=
 =?us-ascii?Q?Y2g+hrBfs10UhM6w/CUpTEVx+gJNJq3Bk9DGcgrnSBoHbVY16+H8jKJlfABC?=
 =?us-ascii?Q?Yu4TJLBLu0UatA30+uuTrQ5q/QCySlai/5iEsd7dQTSt001KDqhacU7oQUWT?=
 =?us-ascii?Q?gBL1Tx9/rEudfetZT4JOIwVPyFggbKQtw6iuBNwiAhqFg0mRQULLO4pL1pMf?=
 =?us-ascii?Q?FHXgR78yRwjmv2eEPY8NvE6GIddMoHT3GmVIBlwITa6GI5gXNPrRaBGCUslX?=
 =?us-ascii?Q?I8CGPUIRtPGOuzN4sLaSD0D53gsSprPIEVQ/Bh68UgIefCBt4A1Fu48gPICV?=
 =?us-ascii?Q?E2BkH0qQThu//+eWMLr68oYc0G3RApMKQtb7f4eVFeL14MUTnRMky2U5mp7p?=
 =?us-ascii?Q?oUdNFV4GlG9pDyYTuj2KTeMqwiCU5Ri9tsi60xuvRNpLf2YAg8pS3wfdr7qg?=
 =?us-ascii?Q?VAxoYB3LeHGjgRI5Tj9qzPwed72f3GD3KQ8QV0WyFtpRWvBwqfWwxgHCtghP?=
 =?us-ascii?Q?g/JXhYOtOVkXPPVe8vOyZV8NOrUOh11F9EFsER/MacNYp4DGCglLQleCKKa/?=
 =?us-ascii?Q?tK7hk1DN82qaQLVr7ZpupLTRYhL3g0TSbUf0IopKJoCfRZGYjL0n39F4Bzy2?=
 =?us-ascii?Q?BwpgppWX+8Pa/TsOBHHtB0ntEQp2/6O+v//RxX+gBEHpSo5FHt2TYiOfukOO?=
 =?us-ascii?Q?GMgE2LHUEX6roMdnS9oEtowY4+jyB2xxnL++Tjamio4LJCVE8sWYFQAqMSow?=
 =?us-ascii?Q?uPOs36vRwALcurwcEuU5DVfTw/vS4YLBJ70MTecI7sZ/A4A+nuSxpwDox0eZ?=
 =?us-ascii?Q?budVPs90iB3Y/W+BP7NMdEvkgzA3d9yh4U/eUysEk5YH8q0sQUH8/ox445/S?=
 =?us-ascii?Q?t2QdT+Dhr3wbbIfzVd4Ru5JnVcGvm5xH0QvEmpY9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11625d6-92fb-4c6d-c20d-08db844135a8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:06:21.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVPwA9KjzH57b2YGxzPre9UwZX8sT9IRjyejjTD01qxVSlkDkgok8dkOGvpV952qYFy8xGKM6InOhqirQrrtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4059
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
 drivers/input/keyboard/lm8333.c | 40 +++++++++------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index c9f05764e36d..41d088933e01 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -129,6 +129,7 @@ static int lm8333_probe(struct i2c_client *client)
 {
 	const struct lm8333_platform_data *pdata =
 			dev_get_platdata(&client->dev);
+	struct device *dev = &client->dev;
 	struct lm8333 *lm8333;
 	struct input_dev *input;
 	int err, active_time;
@@ -142,12 +143,10 @@ static int lm8333_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	lm8333 = kzalloc(sizeof(*lm8333), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!lm8333 || !input) {
-		err = -ENOMEM;
-		goto free_mem;
-	}
+	lm8333 = devm_kzalloc(dev, sizeof(*lm8333), GFP_KERNEL);
+	input = devm_input_allocate_device(dev);
+	if (!lm8333 || !input)
+		return -ENOMEM;
 
 	lm8333->client = client;
 	lm8333->input = input;
@@ -162,7 +161,7 @@ static int lm8333_probe(struct i2c_client *client)
 					 LM8333_NUM_ROWS, LM8333_NUM_COLS,
 					 lm8333->keycodes, input);
 	if (err)
-		goto free_mem;
+		return err;
 
 	if (pdata->debounce_time) {
 		err = lm8333_write8(lm8333, LM8333_DEBOUNCE,
@@ -178,34 +177,18 @@ static int lm8333_probe(struct i2c_client *client)
 			dev_warn(&client->dev, "Unable to set active time\n");
 	}
 
-	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   "lm8333", lm8333);
+	err = devm_request_threaded_irq(dev, client->irq, NULL, lm8333_irq_thread,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"lm8333", lm8333);
 	if (err)
-		goto free_mem;
+		return err;
 
 	err = input_register_device(input);
 	if (err)
-		goto free_irq;
+		return err;
 
 	i2c_set_clientdata(client, lm8333);
 	return 0;
-
- free_irq:
-	free_irq(client->irq, lm8333);
- free_mem:
-	input_free_device(input);
-	kfree(lm8333);
-	return err;
-}
-
-static void lm8333_remove(struct i2c_client *client)
-{
-	struct lm8333 *lm8333 = i2c_get_clientdata(client);
-
-	free_irq(client->irq, lm8333);
-	input_unregister_device(lm8333->input);
-	kfree(lm8333);
 }
 
 static const struct i2c_device_id lm8333_id[] = {
@@ -219,7 +202,6 @@ static struct i2c_driver lm8333_driver = {
 		.name		= "lm8333",
 	},
 	.probe		= lm8333_probe,
-	.remove		= lm8333_remove,
 	.id_table	= lm8333_id,
 };
 module_i2c_driver(lm8333_driver);
-- 
2.39.0

