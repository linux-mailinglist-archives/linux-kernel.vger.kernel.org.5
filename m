Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF137534BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjGNIJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjGNIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:09:05 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036F83C3C;
        Fri, 14 Jul 2023 01:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecQZH+5oOoSCkvBqb0h5OR04mIcXixXgNGsdiXSaChQ1YoJ5Xe7NMLSy1oWUFQtRVaHWboB+zzTZT/NXgu/IkcbBWzFYvHtC2H+4T/f5YMzEzMEpn93Qz29nnC1PUeTNDfHWeN9PLNMV+lbts8F9DdPWFYuT1njjHA9S2nnhHO6Va6zx1L7eV2I9wMbtto7mYoxKsVfGiSuiI25ZLE+sbmx0QFKfGtQot+qxTjneQnLVD74yhBQHEDsOoIc+papmvzjOfZU6GJRTtKGjlsEZPqUwOrfpt2NF+ksVLRKhz+pa52TPPm835+n7wzy5woc5KuxiBPwYU51IBUTtVU0TEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYvLDm/pKKUutNnQiuINiUO7YGK/iWMOkQoVBqqH2OI=;
 b=D431eI1VRkLfGWfSLHjAqvyh2CXGzUZGPt+6hK7CbBgyDAgIV6KtseJ8FzjFoNid+puoYh4Jvk4eFdtcjmubtj5oqjf3RPNGyekY/iFUK8YIHiex5z+l+oSIB7ET7RqiRaJae+LhI9inYhcuVHaJJVqoIMcMtjMV310zakaCmYG4XxCjVvfs6OLo8CE8L9t1SIbvBa2/unTRgAXXK7oEjOoTp9GIXvzvgpK9RWDwmW9dIJFAo98AWVmpBXiKLtIZ21cQ+f1/2JZ7N59qlmon91RwUCQw30EswREjild8yKTRHJxMoU0tDYeQYgSvcN8UbB3Ue5AyxuH65mQCnAhchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYvLDm/pKKUutNnQiuINiUO7YGK/iWMOkQoVBqqH2OI=;
 b=KJH9+z0x2BnDbYxyxrI+kWOzqvjcwcgiDBk/4f72mHHLEuuTc5ShV4DdjLZp9qZBScYrPnlEW+HNarOWHkfVWYIsQnOVtwyOx+PIW+WpoHRoBgwdY0RilDbhPt4TVYRub5vjSpYnYS9yiJ8zNkHb/1AzuL1aEwNZIK9V0CUrlPyYcSUWfPOwDtZ5iJWxWdjBqGPScyhZJZ5/eU/q+qIepTHmwPkvJYb1ZKiSyROfHxnhU2ynIg4mGQ3oxhxRz2B8B4igJy0wqxEwZngktjc7FFh+zMC0U2oUs7nCy1iB8STwNEGqufcn8qS/KrM7wqIbuZdowdpdAeKyLrraBhMmvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4059.apcprd06.prod.outlook.com (2603:1096:4:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:06:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 08:06:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] Input: lm8323 - convert to use devm_* api
Date:   Fri, 14 Jul 2023 16:06:11 +0800
Message-Id: <20230714080611.81302-8-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a00ad3a-11b6-451a-f6e7-08db84413aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cdqYTyD/DaekipDicjJSwTo1T1+08mjFU6DdYzJWK1UQ5slinLwxnDcpN8wP8VEI+PVOog6yCKz2IEeKN2zzdJm5hK619cVEhcKu/P+UPrvB4JUvPXIzXbE5N5XN8FCEX1w1MAyW7JB1qht95eEl/tknZ9LyMcCIXE8yugSrW2AIPNYSK1lsXcMaY4L/6oQSOYy7l5j+bfNXX4Oy9+6DxnJxfy8oDL/LaE0zeCuE2gbC8ztczMrV/NB5g6GltT8scntEVHN9gDa523adEwTkaDQ8YsGFwJZSz8Nnqk+blG9j2eAXBxtGfDW6Vk67NySb48rJ1FYPLRgnLa++0GiH2pcgI72qH1DQ1LMIPNFsFPWYwEg++njpA/qRXTUKq1uSCcNgFQl6rCM3OR1xDeKp1X3fAsLFGerwWzhx16GyOsBSgwWfPJRri4lXq56tUYkXoJ+A2b4JySjzElH325JIfI/15/tgcDkxnxVL72Jgq2RYMl3yXTD9sinVc7QzgVAts0jx3xGsaQOMFP/USALBF9qs4N2UPSYqAfrOaNqa6N0fVvfvQrBGo9Y8enxjE7JoDK2wAd0VpdVIe8eNTJsEokF47DwfRVBS/q28tO80Ec4iWrCme+vUDtSlfBchsXd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(52116002)(6486002)(6666004)(478600001)(2616005)(83380400001)(36756003)(86362001)(2906002)(26005)(186003)(1076003)(6506007)(6512007)(316002)(38100700002)(38350700002)(66556008)(66476007)(6916009)(4326008)(66946007)(41300700001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0gmXTj38e/u9IFdO55QhtleawSuFqOC0/2QK8KKwv9wlhtJZol76n+foiDic?=
 =?us-ascii?Q?QIdLxxgQH+hAndCeo7l/JEMIrLBJIaodiwrLW52O2e7D70daOp27nu88e1QW?=
 =?us-ascii?Q?UpM25CfZ7SrqSUOQWHKm3PUjViZCJtPUiUMhMZbXD1gJnlerGJO3m1m1TAWg?=
 =?us-ascii?Q?mi+zmMqhNzre4QwaBHOxBWPRg+YI/614ZKVcrTVELYu3kRJ0DFazFSHa9mSi?=
 =?us-ascii?Q?P8SChfX1AMpapYRF+C7C7oN+NC/bhbKFd92wUI5zJ67AEII6V4W7G+TNL/bQ?=
 =?us-ascii?Q?Tgw47H1zjqCMAL7pDUQX6YR032t4gcdbq6ZvdYHQ6OZ81uP2BMobALovkFDs?=
 =?us-ascii?Q?NnYC2xeJrsusiydnCbKLy2RwLIsWn27SG09hdeSlYWdMHJoKAGzsQNDKdnW/?=
 =?us-ascii?Q?a362gdC8jotA6NaNY5OhiL6uuBnWp+zXhy7tmNmO6ZSfqtzkGOQ9qPg0qqay?=
 =?us-ascii?Q?KQwU4r35pACsZRSri4n0fyVvuaeGKsS+//xBPhjRXyiDKkAbLtLMTTvTESDf?=
 =?us-ascii?Q?pQU0Ura0TJex5x7rRQ4xpgRaTGDmV5w7MA3iZ+YZ0wTTo2Tnxm/6sViQAxnx?=
 =?us-ascii?Q?1zRcycUHsQFU+KY7tkbm0H7UP1ZjiaeJ1Pt6nGPSQUU3DFFf8GFISG8vVWeA?=
 =?us-ascii?Q?pGmeVenIMINJmCr/qxqsSMNL4+ywN9vq/bLruTzJlXnDKCr6dEFQJQI1sh8U?=
 =?us-ascii?Q?IAMgHCIrOikWT3Af9ybf3j9aXd7EX5118xr/teZ5w8DB84B+v3ZRxbH/LjMo?=
 =?us-ascii?Q?yji8NOB+olX3LfgVHlRt/jzv+axoIO0mttCHhF+ZNbTsDqVg4th6dldGvs2R?=
 =?us-ascii?Q?+t/bEngfrcIZ6KZB2pi1CWl1CaO5Rp/NfGDHRxFZY3Nz9qQ/RgMQlGJJ6WC/?=
 =?us-ascii?Q?0rp3gonUjLe+Qs45MQnJ7ARLjBpBOaYjlF1l7I9URCFd6j9gxyk15TgngVqa?=
 =?us-ascii?Q?FFh6XfETzTC+UvL1YhuN9leJLLc26gCbwW+rWiZ/vC3pEP2OAj5Yzi9iJgiy?=
 =?us-ascii?Q?dX88apxoPVplVPfATLaG0uZOEIoU5d2atyKYHACiAoGAPIEZSmORpOjQrxgw?=
 =?us-ascii?Q?geLSaVCMRufeaqbcwkuFLSiuH0+A37kPPIOXmrtWY/Q4BrHUP6gtRe5VBkqY?=
 =?us-ascii?Q?8uSMQutwkxnelUF1XU0vef9J+A61BfdHyBdgUG5X1xG4D9/fksMX73VX3Q4E?=
 =?us-ascii?Q?B9uwqYqYl9Oo4ALAXSFcXmDeQ0fU4VtWNYMio7fjIBg+Zbs1ncJ3LSZ6Pf9r?=
 =?us-ascii?Q?VNmkOzrYLvs7vDTLS5oXXkF0+g3BfsEiMhYAvy7kSTuRR+aGQ7eC0rNvDoTy?=
 =?us-ascii?Q?1BcE049h1OilAovbVmq8t8GOa4Zzu+LL26acHUdvqnjkwZCI4VSmkhQY2r/C?=
 =?us-ascii?Q?3hRTdXI/zdvSjdz7wX/zm089PIhYqAEC8oS0SC5x0WK2n1CRbFo0vlHVU8bJ?=
 =?us-ascii?Q?GpLWh2NK3FYFaFjphKHjZgUU1kDgTceHuHMBiGuig8EYEtqC5vWGvadvhlxd?=
 =?us-ascii?Q?lhTLM7MwB55Z5YT8G6nlQPUiIDc3h7k4s3RE4Wbj9qrTXg4l7a19ItAQy+pq?=
 =?us-ascii?Q?9JVaKr5I97GoSc+ACWaaXerB8pA9XXbMUduRN1TI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a00ad3a-11b6-451a-f6e7-08db84413aed
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:06:30.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zvp//BzT1wK1sKkQtafs35lsyVZRMbKujMZDq+B8jxzlXbsnG0xqOP25VkBv11EVfPv3rkSos3cWeBqZvG8uxA==
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
 drivers/input/keyboard/lm8323.c | 41 +++++++++++----------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 3964f6e0f6af..d6aa4daad3ef 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -618,6 +618,7 @@ static DEVICE_ATTR(disable_kp, 0644, lm8323_show_disable, lm8323_set_disable);
 static int lm8323_probe(struct i2c_client *client)
 {
 	struct lm8323_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct device *dev = &client->dev;
 	struct input_dev *idev;
 	struct lm8323_chip *lm;
 	int pwm;
@@ -642,12 +643,10 @@ static int lm8323_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	lm = kzalloc(sizeof *lm, GFP_KERNEL);
-	idev = input_allocate_device();
-	if (!lm || !idev) {
-		err = -ENOMEM;
-		goto fail1;
-	}
+	lm = devm_kzalloc(dev, sizeof(*lm), GFP_KERNEL);
+	idev = devm_input_allocate_device(dev);
+	if (!lm || !idev)
+		return -ENOMEM;
 
 	lm->client = client;
 	lm->idev = idev;
@@ -684,21 +683,20 @@ static int lm8323_probe(struct i2c_client *client)
 	/* If a true probe check the device */
 	if (lm8323_read_id(lm, data) != 0) {
 		dev_err(&client->dev, "device not found\n");
-		err = -ENODEV;
-		goto fail1;
+		return -ENODEV;
 	}
 
 	for (pwm = 0; pwm < LM8323_NUM_PWMS; pwm++) {
 		err = init_pwm(lm, pwm + 1, &client->dev,
 			       pdata->pwm_names[pwm]);
 		if (err < 0)
-			goto fail2;
+			goto fail1;
 	}
 
 	lm->kp_enabled = true;
 	err = device_create_file(&client->dev, &dev_attr_disable_kp);
 	if (err < 0)
-		goto fail2;
+		goto fail1;
 
 	idev->name = pdata->name ? : "LM8323 keypad";
 	snprintf(lm->phys, sizeof(lm->phys),
@@ -719,14 +717,14 @@ static int lm8323_probe(struct i2c_client *client)
 	err = input_register_device(idev);
 	if (err) {
 		dev_dbg(&client->dev, "error registering input device\n");
-		goto fail3;
+		goto fail2;
 	}
 
-	err = request_threaded_irq(client->irq, NULL, lm8323_irq,
-			  IRQF_TRIGGER_LOW|IRQF_ONESHOT, "lm8323", lm);
+	err = devm_request_threaded_irq(dev, client->irq, NULL, lm8323_irq,
+					IRQF_TRIGGER_LOW|IRQF_ONESHOT, "lm8323", lm);
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
-		goto fail4;
+		goto fail2;
 	}
 
 	i2c_set_clientdata(client, lm);
@@ -736,18 +734,12 @@ static int lm8323_probe(struct i2c_client *client)
 
 	return 0;
 
-fail4:
-	input_unregister_device(idev);
-	idev = NULL;
-fail3:
-	device_remove_file(&client->dev, &dev_attr_disable_kp);
 fail2:
+	device_remove_file(&client->dev, &dev_attr_disable_kp);
+fail1:
 	while (--pwm >= 0)
 		if (lm->pwm[pwm].enabled)
 			led_classdev_unregister(&lm->pwm[pwm].cdev);
-fail1:
-	input_free_device(idev);
-	kfree(lm);
 	return err;
 }
 
@@ -757,17 +749,12 @@ static void lm8323_remove(struct i2c_client *client)
 	int i;
 
 	disable_irq_wake(client->irq);
-	free_irq(client->irq, lm);
-
-	input_unregister_device(lm->idev);
 
 	device_remove_file(&lm->client->dev, &dev_attr_disable_kp);
 
 	for (i = 0; i < 3; i++)
 		if (lm->pwm[i].enabled)
 			led_classdev_unregister(&lm->pwm[i].cdev);
-
-	kfree(lm);
 }
 
 /*
-- 
2.39.0

