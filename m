Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1B7534BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjGNIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjGNIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:09:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B4649E5;
        Fri, 14 Jul 2023 01:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK7Nv8weDiBUGXbS5xLF+K5IZ20h4RynohrScbDsbnpc5Rlai0Nm1k3PG2A6dGM0aDs9beBRE34LJAw2uF0HH0Cp24hHo+72AnNlKLo0Y76xJcssntNeHd4JcVGvUKhELyeZ/T2+TLsgjBnYB/anb6VezUzGuZQ+rEbFpajj8DZH6iNlPQXifqiP/M4IycALKx5I8pizRGTn5MtA7rt46LJu115SVfw70moLOebu3anQgDgYRbEC4CS/HNZMMEw2t568corlFtlaSX/Mxqbk1OkHBi7BAsemANmKjCR0z22/PjnDFB+F6rpDj9AFh1IshyS/F6PLZBZIID+yJYx2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGftaSQHOqN63JNTpkM3aKIihrg8EH1pmJWu/L4qoYs=;
 b=VuNHlLbWmOAf7bKtpz44pI7QqLPf+0aFzR4Lo9C38HtQT5pnAZck5RChckvUiaX45d1rToPeiV2pwNiOgC1VKlMVrOPe1F1k6MwyU9BbprF5NK7tUfyYd+tJXA2uH2XlEyaXm64jDoCrKbylyoK07CJ1SNnthzro/jJw1389MlryIQh0WRWd+Ye3s3O+EWu65SBM6rS52mOoplZSEE1OTygkvaEyFBNsbM5UqHf+6iN8la1BZv9hkeC1KADqoQvzoydyAbA4ceFt9LBtbPsrAEGRRJtpbGVB/cBIZPdoZ1bG/gLfCex6ejkzSN3YNAMJug4SJWD5rmKGZOPDUzu2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGftaSQHOqN63JNTpkM3aKIihrg8EH1pmJWu/L4qoYs=;
 b=FeYjs4vtRXVwybKLT8/Bbs+NYnTshwwRZ/Oan4OTtPB4MkqOH/Lj20q8AVH7wsYwOkDob3vQM8pLLYJ2XIa6XkGViMh5EJULNmsCIqL82kJ81wqREgEjndFGhj4WLCq9hbgTkyqcW9mqKfLD4vv/QH4UFcIpFwQLqT0/HozC5TVrszkAYj9bUTtmANMxRYHzoZa4Ec66j47JVZAhE4NIGg0nSPMxwQQZS4qsVW+etOoXHlb4Kflq76qFY3VObFmzJ0FDFYAfivOpcEg7/KbKAbyYQ/c/NFt36W7zEhi1yk+BJyue4LFN4HhEc3LEPL4AJUf0qhNFOAqjPdSNPvD73Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:06:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 08:06:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] Input: qt1070 - convert to use devm_* api
Date:   Fri, 14 Jul 2023 16:06:08 +0800
Message-Id: <20230714080611.81302-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b04a9266-84ac-4086-222f-08db844138fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPO6ugd8oOnpmX98pO3QIz3XxAyai2iJtYV/ooj9wBk9B9836SwrOLk/0KRgOWOtW8n6sPqdRbgnq+YlSPWz6952rQtgfL2Biei1gP5IQcyjazstjVfRU521cCO3ifyjCl0RxP8NCnAzCra02f8PwZemUsAPk7mXFUqsIQe6PBwOOzpacZ+ar3ULosJ96Ol7X90GOwRKl664VoxzFL9C1N5QK7ov7T1FNUyNAoeaDQZPnDLkwhcBlDsDqSSxUhe0BvjczV1HUcVIfSRr3qQJnoZqbhl3Rxrf1B/nPzpA1KEMgU5pJ39XELN8qts4D0sJkGC5CoIAVy5tgwRI8a9UMSSOwhKomjDYuoRbYrrZfut1w7+KC32prp+paaO/jCwkRZJl5tWk044WGSSug918E213U7ceohQNghqYrK/392QgG4DP1DSWQZreeBCWjX4ggC+L8t+JDpZGnTk1tCejRaPBmr5W1nA5ScVr4NmnzenfxpuCfShVaRCqoE7ugavFh8bnvnag7a0pRbYxVkLh6HjoJw/kN5BtdYDuGBdKorR3zr40rXnzzf/zegV/hu/sWuQwZLi/Nkyp0yjS6NvB9Zo3TJQLmnzbR+M4Ea5Kkf1b8o8tj8F9dnI2cVCFSW0F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(66946007)(4326008)(66556008)(66476007)(6916009)(41300700001)(2906002)(316002)(478600001)(5660300002)(8936002)(8676002)(6666004)(6486002)(52116002)(6512007)(26005)(186003)(36756003)(6506007)(83380400001)(38100700002)(1076003)(2616005)(86362001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3e2y3vQyB4fjdUodCOUOo7YiuAtmGjT3/dQLXG/HrcaV6BoilG1Yf7+fhRhY?=
 =?us-ascii?Q?osEj/NJNJ/F+9Qc9ITq2oH1zSDlSbcbL9rloScKI8BKVO7n2F8AjgP7xAWc3?=
 =?us-ascii?Q?8cEMgP+P4HDtbEa64D09lclOj26Xfqw76GKwIhFxwu8QKzTRMKomCdilt2Ou?=
 =?us-ascii?Q?ZhaQcjxfJs063SuCwyuEriO6AWxFVzaTFkwrT7agl/IqgorGb7I7iui+QB4B?=
 =?us-ascii?Q?E44SXqJkgmX7h2TXY4N0YKbggpDHzdnlhgYOa298LiSEqmOSy+5W3bTJJ40/?=
 =?us-ascii?Q?RHB3U0j8xMCyFfxoIQPeRJZWBmnY7I1Y3GOCkfeDxoIvSunJbG5oGx7QW61e?=
 =?us-ascii?Q?cGl+iLzsNUJiZU6oZGcyzdiR82wl0WQkYNfR6nbMoGKNp/V+auacoYLBftk8?=
 =?us-ascii?Q?M5+Y+/9Eqzb/QtyoR+xEV3E/wNcbTtxn9aCunNV7oIIPy542H8ZEjreKaQhy?=
 =?us-ascii?Q?DKInAexONVZXKw8s+qZ60I2n3lKP5wcuPSWuVapmC6ad6h9ristZfeP5Sb50?=
 =?us-ascii?Q?jWDm91cNfUO3HJsU14S3MOggP6gvslzbMozqdzAtAN7LZMJ8qcZpX6fjBz5F?=
 =?us-ascii?Q?FMkkPLhiss5fuB4DumgLhCYrYRpqljsihHyVtmvK3Byxv0vnM2QMaPtSaSCj?=
 =?us-ascii?Q?eoVgreC5ntx4v7l794ZPnXTQySkNe5+Dd+guSLuAPNxYQOJxV3LiU5AlWpba?=
 =?us-ascii?Q?MH0Y8WsuNXbFwEW9wWidRB7D60HX/GcIpVin0jFVUzGqs5gnpyaGhIxyJxqs?=
 =?us-ascii?Q?4RRcVevUycNsYUGDFwNO6pYMQrwLPXlThb9osr1jwl7GTyINu8NxAqeqo61e?=
 =?us-ascii?Q?rhofWcBtk2zj21iaWlKsCUkJt+UBZIoJcEAmi4V8Lmy+/rCm1BH5AXtZcYa6?=
 =?us-ascii?Q?5MZuxrsT1w/OhuWd9TzV7phFbVd2GwnkC1ogwBHOXlbq9AJ5xcS02PLbz24Q?=
 =?us-ascii?Q?6Ct3VDK4h7RJhBiK6sj8TmM1Zjwz6YN96+RwBPCJE2ntrdAwIQzZ595NWryf?=
 =?us-ascii?Q?+efyNi4IfzCy68Jm2fKnQFYEheo6e4goNNHD0ieDsmhmCfUAo4i5S2VRI4+j?=
 =?us-ascii?Q?Mk7UcIwLk8xDJVoRFQbwuzb4aUvwFlL0NiMQ5kxaISPxEdmxMHedeRncDtqC?=
 =?us-ascii?Q?/EoVxxPu7qf4GwdCswhdOz9tXf0RoDEpTQ595tMkzwc3zhjbX4ANfURhupRj?=
 =?us-ascii?Q?R00QsEL27artcH7ubPHzjbfJzfRppdse99t3W4ePX0jTiZ9XDdTDzmvGHBsN?=
 =?us-ascii?Q?RVcwlzQ4Z02rqg8rO2R5VJKqW7teaVnPSFuoyEy1pXijdR5U6I/kvx0y05iv?=
 =?us-ascii?Q?mrfthdbC+flL/IbnP0/L4oujc3OnGM/5s8TH2rkku3r7QhLa/sRGnpPyBQ/D?=
 =?us-ascii?Q?Pp6PLlwWgsJKu6QpzBAClTk7+IDADfAqNFJaJXdSgckAEnj6w6p/L3n9dDYy?=
 =?us-ascii?Q?qoQNmVFpENhjmOWjWTVoT7WtcIuLcoS27+QBtXEn1+sLPhbvF1q+US9VECEm?=
 =?us-ascii?Q?IadcZXTwX1WuARBOc8VFURYgEi+giDXPbr0uhPE7qh2v7SZKw7nl6lNL3Z9h?=
 =?us-ascii?Q?bWp1n8TEkilqpeMSrm1d/iRtHRxUBGcrqtAKUw4Q?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04a9266-84ac-4086-222f-08db844138fe
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:06:26.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwlksOTN5UblKZV4jcLi+4CVL1Ci6BoT60zi9lpqybuGLeZve2fI5qRvlzCIZJziHXWrbxKm7hnPZsuBi+ZS/A==
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
 drivers/input/keyboard/qt1070.c | 37 ++++++++-------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index 91aaa9fc43a4..b240779b6a93 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -128,6 +128,7 @@ static irqreturn_t qt1070_interrupt(int irq, void *dev_id)
 
 static int qt1070_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct qt1070_data *data;
 	struct input_dev *input;
 	int i;
@@ -149,12 +150,11 @@ static int qt1070_probe(struct i2c_client *client)
 	if (!qt1070_identify(client))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(struct qt1070_data), GFP_KERNEL);
-	input = input_allocate_device();
+	data = devm_kzalloc(dev, sizeof(struct qt1070_data), GFP_KERNEL);
+	input = devm_input_allocate_device(dev);
 	if (!data || !input) {
 		dev_err(&client->dev, "insufficient memory\n");
-		err = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	data->client = client;
@@ -185,19 +185,19 @@ static int qt1070_probe(struct i2c_client *client)
 	qt1070_write(client, RESET, 1);
 	msleep(QT1070_RESET_TIME);
 
-	err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
-				   IRQF_TRIGGER_NONE | IRQF_ONESHOT,
-				   client->dev.driver->name, data);
+	err = devm_request_threaded_irq(dev, client->irq, NULL, qt1070_interrupt,
+					IRQF_TRIGGER_NONE | IRQF_ONESHOT,
+					client->dev.driver->name, data);
 	if (err) {
 		dev_err(&client->dev, "fail to request irq\n");
-		goto err_free_mem;
+		return err;
 	}
 
 	/* Register the input device */
 	err = input_register_device(data->input);
 	if (err) {
 		dev_err(&client->dev, "Failed to register input device\n");
-		goto err_free_irq;
+		return err;
 	}
 
 	i2c_set_clientdata(client, data);
@@ -206,24 +206,6 @@ static int qt1070_probe(struct i2c_client *client)
 	qt1070_read(client, DET_STATUS);
 
 	return 0;
-
-err_free_irq:
-	free_irq(client->irq, data);
-err_free_mem:
-	input_free_device(input);
-	kfree(data);
-	return err;
-}
-
-static void qt1070_remove(struct i2c_client *client)
-{
-	struct qt1070_data *data = i2c_get_clientdata(client);
-
-	/* Release IRQ */
-	free_irq(client->irq, data);
-
-	input_unregister_device(data->input);
-	kfree(data);
 }
 
 static int qt1070_suspend(struct device *dev)
@@ -272,7 +254,6 @@ static struct i2c_driver qt1070_driver = {
 	},
 	.id_table	= qt1070_id,
 	.probe		= qt1070_probe,
-	.remove		= qt1070_remove,
 };
 
 module_i2c_driver(qt1070_driver);
-- 
2.39.0

