Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4C7534AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjGNIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjGNIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:08:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FCE46B4;
        Fri, 14 Jul 2023 01:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnoPn7XB5ZzM4b9vk+C/NAd5NnFbKiLEVPmpT1h+P2GXQHhrIabqQQ4N88JiVYPkdiaJFHvvnVxRVeMA8SgrhluOkNPDy8h5tXT/RbeCwns1rtjDR1le9xEmH8qNB4hdYOvnLd42NYMK79lhWKVpivVx7gwNYMj6CkMQw1G8i7YdFTzqOpEXFFDESmu0wMXXUyIzRR3NSjeZhBzKFtiR7mBpvJVuJB8VJ4pK+jLYsv2tBMwn8xFxUKb8A75EZaRcc7oQnNM6knET8P0IZQH7pyMFNQt55ixzFtbED3mSnh4M5MqopP4CFfC3nJJjwQfzb1jCYKPOteVzavVaw0+7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhXtyfFNn2c13mX+gMTcuJZa02qAz3DW/hl8K+j7UXw=;
 b=eQWlBvfXGtsz0gNd9gyFCP5nXW0nQiciLvaO0KhHW+1dxhUzYfRv0X+k0thS7H3emOOhp5vNXMsRAsfyhlYyB/3fXbuD1NZH77Gl++ungsEfzgRQHNnVhN9+/nG3+n4V4fJpgAVkaJd7XtzQ9UwqqbXH6s8o/kLa/RgTH2IzUxC8AjhY11ETiGz1Dm1L4eSehV6UjpFfMIzKGC4bbox+KLvXdJyAZ0qeAaL2Oajjf+bX3epCxawo44E/IhElvvUFUysobo5vrZunZ7WWLH5xVasq/ze7AA+uxENodueTD0LFHeqI9llD86JX1zGLQU8xxDq77JSYhy19UZbb+y7vTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhXtyfFNn2c13mX+gMTcuJZa02qAz3DW/hl8K+j7UXw=;
 b=RiSsbu6xmW8exSp1N+NJj1SjU/7asAoq+5FRcmUqnpJaNfixZj8SWIzs5xik8PNUCql2fpqKkATTjby3/YzZxDT0uL4LDELeF46eS1YM11D8iOiYqZZDZjtnOSjRu3LOAB9iClU006QF/g15kwjIzFSxXlVPhnHRBAweX0sUUlpBso3heqvw3dk4uaj46IOZIofZtmR4YNLC9HET222S2klr1lngU6mZdeUV+bZa4+c/g0q3g2E5fowqo6Odt+Us5XNYi2GDWO0obC1PUgGmS9AHfjonF3Smlu7WoDB5RNXrfX59LrPQmED6xy1otp6D982ig1ri3R4gHp6e1QVMJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:06:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 08:06:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] Input: tca6416-keypad - convert to use devm_* api
Date:   Fri, 14 Jul 2023 16:06:07 +0800
Message-Id: <20230714080611.81302-4-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb56a8b-27a4-43e0-1f13-08db84413850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQuGBCIzbh0xWl7KxSxebmaOEsVeSg7AbCFR7k8SzyXlNrBIiBnXVYks5TLI/i64XISiSHU8zeUA+js0VNH+zEi0GGs1N8W1mf+qzGSVeAXoUpAPdmjpmny/fVRTW+fTcaK3lLC21JXhwHkuoNTZyCMXBnnHo+kolHywmE55XtiPyMZfsf/9gYElZQBkpl7GdUavEulgOYsBUbqp5l2q+Q4UDc16GE0AmC8qP9ffZLMhaYlZGhGT1XgpB5iamEu7ezo4vbQHrxc2aJzKYrnIv9oUzL8fH/m1ars5r2ePKuxePs88TBCV0sk+71QlIeAcYcxGqLEix49KIvkSMkLrMkJrhCXWFCXiCZNuMzdjjKFQwjkGJRuQsCaxUu8RiAMzSterY41LRr0V8eEvneol1/NXyBxZdwIcjwDSXAU15P34pdFirm3KwkGc7fdqkeas6z4w99bm0kmXk569CFkptEzo+jkQUQDIk8pBSqTXcH6WvtL77/m/hPJujpfulGeJduCsEjmVJ+zxuqBA3wXL/AY/W7FQRHht/CfaxKU9mi93GVP10vw9wKK+GZ/kHtzP2zubMpwD1MJkufKRrIvo4ajljtk1kSstF/3hvu2bK6oKcgiww/Gmx1Zxvt7tZ9CF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(66946007)(4326008)(66556008)(66476007)(6916009)(41300700001)(2906002)(316002)(478600001)(5660300002)(8936002)(8676002)(6666004)(6486002)(52116002)(6512007)(26005)(186003)(36756003)(6506007)(83380400001)(38100700002)(1076003)(2616005)(86362001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?erTubDaqHu+OorCIoVzC2QwD7/pSKpDrG74+YWeMu2k/Mg/jkhMj+NsjPZPr?=
 =?us-ascii?Q?Bb0hg4FyivOmxrLRC32PWD9m3RH0xo7ZSWhRYajWnQJVuvR5mF9/F5GtrOAg?=
 =?us-ascii?Q?t5g3WgEgonKRTIuQP/UiV8i0SJ04bSi//AiXK9MZdjM4BG6xvDvbDImFuJz8?=
 =?us-ascii?Q?hpwmHibqV0cJW2p5tH+N7XPgPe/K3QHu4kUhBtgoFQY5h0rxZQjlp33y6RnE?=
 =?us-ascii?Q?W3+ecJHqyWlwyvPbSZKoxvSEC8jdecmYDoyR6KQ9wACHznnhJD6CpyRL45c8?=
 =?us-ascii?Q?lbwF/qm3XarLydn4oEcnjB3VUUpEqKNpuyHyOHF9q5YS+FcfJutzR1cLkKtr?=
 =?us-ascii?Q?yfDSQQ7qciatgoLCetU3cOo3u4mIp51SqW6VEAG0gEy1ELMbdidg+hwXfoXm?=
 =?us-ascii?Q?kxqqTShJw1UNoud2TSPI7A9WBhkPgDR55nYZo5gSJYWOq4f3LX7aH8up2isC?=
 =?us-ascii?Q?EP3B5828zps3W+1qepaqeHCrviqVU9l5yLwz+MSuNz4g4PGYYJj1t1eDk954?=
 =?us-ascii?Q?RXpNY1pWNUXifTBlg9sIj9uh25etLOnZALOyzNbQEroYhn5UQ3aHSxw0SzUF?=
 =?us-ascii?Q?vnJ/hCP67+q/fG8mNNJMGMq8XYW3mt3eD9vuqryK88n5ObYylaCV6SAKJ7C3?=
 =?us-ascii?Q?eLfzWiPkRYdFYFyUQ2FVG1Dqn9N5YRl+LJ1BJQaLsnANgapJukQZcdFqRzLD?=
 =?us-ascii?Q?xJmrLRVlWYdOscW6rokVIfdzaCHKh31Z16xIRWTdBkFzpEv1DcUpDs/4SCNQ?=
 =?us-ascii?Q?3Dn16Bn7SuyQ/3gL6Mu65DbjwGYTC1BIkXWPIeggZq7Kvsl6WP2Y08ATOpKR?=
 =?us-ascii?Q?6osQhdJHOneF2nXKEEbIwUUl9Oyu/BjeEPUA9yUhB6Wx+HO9oR+0NkfKcxDB?=
 =?us-ascii?Q?t53kQPFG8qVD1MRdiXUnEKA+aDpd+4LiDctMhte//V4Tjzp9PXJ54pgokOIH?=
 =?us-ascii?Q?OPOWxDwv7mHPUL733YdSXAv3G0bwyk+AftqQRakVemMKsLFWoqDggvH2T8Y8?=
 =?us-ascii?Q?SSmUGhmSxjp3qE32RvVnti13gA2sQFIEEVH0O6mLZb9DBOkuUUxLYp7mskRK?=
 =?us-ascii?Q?ppvXwKV2JpcW0rLESG60tUge+8AQF4N9ywCOOezXGk9H6EotNJuMrj4xQI5P?=
 =?us-ascii?Q?HNGI+gM6JDkH8RCtVyPZg+17mg2o0C0qnP2QyIopdOEC4gE1sYvcdxsY59HC?=
 =?us-ascii?Q?vKoxIisqnBoQs2RsvPJ5X69cArEKRcylq8M3edfuzegy+uvFJfHHdmWaTjS1?=
 =?us-ascii?Q?+aqJrpKSmJ6UDSyZSN7zvRHopFE87n0Z9o0vR2xoR3Vfxt94bCn97GYdogXC?=
 =?us-ascii?Q?CAYqDKTnF5i75RTQtSL3h79VC9De6fGMdlpeDPUniDnTUTy94psECZmS3TXW?=
 =?us-ascii?Q?e4LwF5J8s0rIf5c86trm9A9gzEkw+W1xWVQ91cA0TsJavjI2S5hMYijS+WPx?=
 =?us-ascii?Q?RE4SJAqJhbjx3AC8ZP46p74r5msOJOTY661uNlwwXN1AQCmkAi9WsS5kNEai?=
 =?us-ascii?Q?PgPBC15QFVOOK9WE/dLyd0EeE5QMC0emS5XErXzZlyZzYK64S959W54PVD37?=
 =?us-ascii?Q?KRUrLUB3IeYcF37Y8NeYaRB1BKoW1u9E4zhAY+j/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb56a8b-27a4-43e0-1f13-08db84413850
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:06:25.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+GqWfqo/xXGzaQYSsRh43R70FMUZ7z4gxXcSxVSibi7phw6yX65mGuR6O3oZ/BwwWEnv8LfuCY7QYzmA8Qx/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4510
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
 drivers/input/keyboard/tca6416-keypad.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 2f745cabf4f2..8db204696191 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -198,6 +198,7 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct tca6416_keys_platform_data *pdata;
+	struct device *dev = &client->dev;
 	struct tca6416_keypad_chip *chip;
 	struct input_dev *input;
 	int error;
@@ -216,12 +217,10 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	chip = kzalloc(struct_size(chip, buttons, pdata->nbuttons), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!chip || !input) {
-		error = -ENOMEM;
-		goto fail1;
-	}
+	chip = devm_kzalloc(dev, struct_size(chip, buttons, pdata->nbuttons), GFP_KERNEL);
+	input = devm_input_allocate_device(dev);
+	if (!chip || !input)
+		return -ENOMEM;
 
 	chip->client = client;
 	chip->input = input;
@@ -263,7 +262,7 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 	 */
 	error = tca6416_setup_registers(chip);
 	if (error)
-		goto fail1;
+		return error;
 
 	if (!chip->use_polling) {
 		if (pdata->irq_is_gpio)
@@ -280,7 +279,7 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 			dev_dbg(&client->dev,
 				"Unable to claim irq %d; error %d\n",
 				chip->irqnum, error);
-			goto fail1;
+			return error;
 		}
 	}
 
@@ -288,7 +287,7 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 	if (error) {
 		dev_dbg(&client->dev,
 			"Unable to register input device, error: %d\n", error);
-		goto fail2;
+		goto fail;
 	}
 
 	i2c_set_clientdata(client, chip);
@@ -296,14 +295,11 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 
 	return 0;
 
-fail2:
+fail:
 	if (!chip->use_polling) {
 		free_irq(chip->irqnum, chip);
 		enable_irq(chip->irqnum);
 	}
-fail1:
-	input_free_device(input);
-	kfree(chip);
 	return error;
 }
 
@@ -315,9 +311,6 @@ static void tca6416_keypad_remove(struct i2c_client *client)
 		free_irq(chip->irqnum, chip);
 		enable_irq(chip->irqnum);
 	}
-
-	input_unregister_device(chip->input);
-	kfree(chip);
 }
 
 static int tca6416_keypad_suspend(struct device *dev)
-- 
2.39.0

