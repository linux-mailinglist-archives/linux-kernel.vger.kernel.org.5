Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91747534B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjGNIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjGNIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:09:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC58F49DB;
        Fri, 14 Jul 2023 01:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfS8WlMgyQXp/GgBps6LYFDjojM5xPm49+bdeB0zA3Ag7V7bbMwEQgpfY8A6WuSV5Py8DBbVO5MRv+3UMmpCtVHFKTKfQRCmZltp2RfMShSU3mi3ywy4aIMUhfee/zyb0M1Z5Py82/sDi3mTrrd6ERSew9/Gjjns+luLluLLx3qVKKy74AAmvmNt9EUjRy3BTrTu1NWDhvqt5zX9rJqbTsmjjhoWHXpBVOpxUE48BDnevOw76paFgdxdLKPLngNuaCg2+0ySBiCiNKPTOrcgEtfLlrzQTiGXrKfDjGz4PNdNEZYhh8tHnwqQM+mnwFrW/6hEDXguBO9mUSpx3NAZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGZS1aX1YoU5sn+WGWBNX293+dnAu8SuwDDxkW/KL9w=;
 b=c9qYMmF53+229hkoiztlb4sWVW4tt+bOegtwNsmBuZCqVURe2Cx/TAO+BuTwyf7ibMMlnyj6KAAH7Omnr9GdwAhetJPn5yA2tvroGKLiONjOS10i3YMYxfUadrlghRFMHRo7jr9EkMt7KqkS7+ai6t/TOH33kMB9BCNdTSLOhFVeioz/GG8K88ZZvjWNIAVlG8Pzzm8/Ix3ReBskfm6Yfw91PxCvkokbIBRh9wLmBu7U7BYE8YqlCh9YuXtJtKcImde1JdHCu0F2bwql/8jJqu5LK5nKxkOyPCruuYRWm+MKV7PuHkvw0zQ21zYmsX/c9hUDOzkCqxks3d38JE/Vmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGZS1aX1YoU5sn+WGWBNX293+dnAu8SuwDDxkW/KL9w=;
 b=ayJubJnPx08xGwsindauVxPUfbPpnQT+9FvN4pjfdhwl73lg3KU7bjzrqcFStFLPFuqM0XZtproJZZXZyE0VS/s5GP+j53XJsE4qOlVTFUHb392lPFOmUEH0+n10UVVr6Hnk98aejCraNLSUeuDhs2qqc9YI2YlezX8nqHN6sq5ZRDAJ/Abq3Iv+g1WJwQnZvk1k205QF/qr1ShQ0mvNAoV94BrswKNIw2N1BIQftAl0RnvYmnXBUjvX4x8kKcV/rcIvDmq7dIz/BQaVzc3PSJ6YyVte+++F7zcI/2SarUyy0QSkdRSuVKUjgiPHYybzCD79Geai1DAlWtDtHTNF8g==
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
 08:06:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] Input: mcs-touchkey - convert to use devm_* api
Date:   Fri, 14 Jul 2023 16:06:06 +0800
Message-Id: <20230714080611.81302-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e30b41d-f05f-4d91-4654-08db844137a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khgX/6OlhrFSzMsDOfK+Wo9tRcbQgIDHAT3zhxZVh4dAbkOwPw+VOcNDcES0CLp8IMjD/f+O/jpHk+sB/jpiQRXoaKXFqj8ON7XwENYtK+4vMrsCJoU3GlliEsTYrGepOFmCdpVUCXSRBD+3VebylNlkz27WX/ctqX9w9bGGKXVqiJojQa/8GUCUrcge0dr722hiTDRmmiqWSy+MiNWsWrJFqNhYNYZyDZUryMK5+cIRMpkUih6nSqYStJ/woR3EXI1/SWh0jbyPespZiX04TWRjKsw4iedjaXmW+xcAeMi/VuvufiB3iOJ4lu0fZfneSBF5xtvhfwvuDQOLa5ktbeIwWyfI9vQ0q3RL7Hzzp92e2/nKBMnqZBqJ8f9/uHTMYVBlYVXHSmgo2kz9e8LtELdu12VeSkGaJZEQas8/cOyvbtjPOeyoj4+AKYBkFv/4LF+tx8gYFyzV5kKb1lbEpZ+zeJeSTSpoVSVV2sDT20lcgqGZKZPlHvNfkDh13zgXhW35ZHVWEJM3iIlSYgBerwL/ij03FwuR8lFCSqPf8e1jUQ7YKWNusIy+2MQyb/hIWyHz7rWsO351HE8pwttYbm69fXkjXnjHmFqePqHcF9dJGuHvlmYk5KqtCf1XfJ+t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(66946007)(4326008)(66556008)(66476007)(6916009)(41300700001)(2906002)(316002)(478600001)(5660300002)(8936002)(8676002)(6666004)(6486002)(52116002)(6512007)(26005)(186003)(36756003)(6506007)(83380400001)(38100700002)(1076003)(2616005)(86362001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GChrSvug9KsKiEoSSwam8qaN2Hb8pQqiH4N7NWs6lJIKaGaQdyuwuHvjHo6a?=
 =?us-ascii?Q?i0TMebdO8+YeA5bfDaAf0yNtWVtiS7gkNXhuWXJg2zB4zIkQS3RhpAE7XTQ2?=
 =?us-ascii?Q?fcIMu9CF4lkqYEm6oRJK+GtexF9XPI4UdMhDuuk2lAs/HE9Y1g2kGhfFZgtY?=
 =?us-ascii?Q?gJTbGdDrRMBEQ6+lhjvpu4WOreNLTE1z5RdfazWqEour7Xd741WCXlw/BxLV?=
 =?us-ascii?Q?p9Ueo5e1YHTypmGtLwCvLYuzS3QSLy04ni5S03cAUbk4NS2S1nwMoAFlPhjU?=
 =?us-ascii?Q?yH9RB+W8v2oa73BhbCUqAukO6ciTuXJQ7hItwPrq5xUvVcT8+9Pk1k6/F3iX?=
 =?us-ascii?Q?Cdz+JIt6mSWkHAZuLVWMBMBYn6nlNCHPfFHhN1bFcTZKREv0TauNerP/nFhi?=
 =?us-ascii?Q?9CbiKM0kafBP8S/tXnWrRWFUuEZGzdnCqDF+Koqe4+Ww4zkl/YNKAnZrjIEK?=
 =?us-ascii?Q?14OhvyvitxpuJXUt2XLgnrdbkKC9vtghZAHptC2qTJaKos/kYTK8ch+851qb?=
 =?us-ascii?Q?JQPHVWa0uah+EkegHCSVbuD+dcpyrJ4jS62aU0FvPOqpcXANGLP+rbDiu72/?=
 =?us-ascii?Q?+pWycdmFwjp9IbRS2XSvVWHISSvDhx3sfNS18+Csc5MOi6uidC3HRDittryr?=
 =?us-ascii?Q?NJFrDk/QNpbdk34HBxZRdzge6UAOxEdW3XyDCAXIR5fXdyb8Hyv3gIkRyCPQ?=
 =?us-ascii?Q?XBGvBTUW0Twmwraqf1m1vMfC/7gkTyjs0agKZC5PE+yUmdA7P6s4smOWsTRq?=
 =?us-ascii?Q?jrkmdJroJICMQIAtMloaNAEXqX7FkCq6J+y6w2cSEZkzz0JH1/spAcbVxfHq?=
 =?us-ascii?Q?S9DSswGCZMewkIkR9aoo6rZs26A0154Hm7Ls1xBI9H3UXjddU1VqInLakM4R?=
 =?us-ascii?Q?9z5RgTDsMn8Z5tY19NeSSaVUGJlSNm64c2c0w4AIIdan/gR2kgaRFDHwDZr5?=
 =?us-ascii?Q?55bQ1EV3hwsmN6y1CRjt0clkilDQ1MKtx2CNAO/VIXChwK8/bGFpwGHtZP85?=
 =?us-ascii?Q?qjB8Lx+Wr2+D/55B4ZUhb5FxZ/uRbKtGIG1GAYd4IWFJqSQ3dlfquim0+DYd?=
 =?us-ascii?Q?osoCoUjyCukBW9wElMUV27wt7kOH0ZAuJqF62nPsiXjGFLELayPuJSZwhhcD?=
 =?us-ascii?Q?dk/0NGmaVOvRwR+sZZMCeCtidMk0ZkaAmEl0LdmKNb8TJBMeu6jDIfH3aLGf?=
 =?us-ascii?Q?nqFEzt0ttAFMV2sB/TTrva+cesYblsU60JMqRlfrc5dnGJztDsTlG2idd/Bl?=
 =?us-ascii?Q?zJ9ahdqbM0HNLk2mt8q3XACgRAOrJZdFJl+mQlo+asItjhuFZ0hvDtA48zXM?=
 =?us-ascii?Q?SMVvoKpUg4BeaISJ3wxOeebp2xBsKlAdT/v817BgJ6g+TQOV+kH5TxfxxR54?=
 =?us-ascii?Q?/9hStsmYkoRq0XUnpyhre6We3pEzKPjqUGKU1bZgiYnR33qhMWDImGzxXhcq?=
 =?us-ascii?Q?FkiT/TH2XmqbEd0OBLPnrSkYEqcgOUvpN+gT9O1LrQxNfyoe92EbsUTDluzg?=
 =?us-ascii?Q?nT4y3x9UB29p8YGLcpKfEK7pZskzhq4j8WuqJvNqsjOiGrbqRd5fobo5MvT9?=
 =?us-ascii?Q?Pa+AIvYVfcsn8//QTWEMlplrL+9q2loSAz1+sxlG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e30b41d-f05f-4d91-4654-08db844137a9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:06:24.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0FrwISd+NVVJeZ/Us8DaOa+8qr4KRVkL8xQSrgWZafOPsbqHB6BhqK7hbxYNf9k5O+1MIgj0jCZLw3w6FtS8A==
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
 drivers/input/keyboard/mcs_touchkey.c | 51 +++++++++++----------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index de312d8eb974..a0d2e3b1bdc9 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -92,10 +92,18 @@ static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void mcs_touchkey_poweroff(void *data)
+{
+	struct mcs_touchkey_data *touchkey = data;
+
+	touchkey->poweron(false);
+}
+
 static int mcs_touchkey_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	const struct mcs_platform_data *pdata;
+	struct device *dev = &client->dev;
 	struct mcs_touchkey_data *data;
 	struct input_dev *input_dev;
 	unsigned int fw_reg;
@@ -109,13 +117,12 @@ static int mcs_touchkey_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	data = kzalloc(struct_size(data, keycodes, pdata->key_maxval + 1),
+	data = devm_kzalloc(dev, struct_size(data, keycodes, pdata->key_maxval + 1),
 		       GFP_KERNEL);
-	input_dev = input_allocate_device();
+	input_dev = devm_input_allocate_device(dev);
 	if (!data || !input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	data->client = client;
@@ -136,9 +143,8 @@ static int mcs_touchkey_probe(struct i2c_client *client)
 
 	fw_ver = i2c_smbus_read_byte_data(client, fw_reg);
 	if (fw_ver < 0) {
-		error = fw_ver;
 		dev_err(&client->dev, "i2c read error[%d]\n", error);
-		goto err_free_mem;
+		return fw_ver;
 	}
 	dev_info(&client->dev, "Firmware version: %d\n", fw_ver);
 
@@ -169,40 +175,26 @@ static int mcs_touchkey_probe(struct i2c_client *client)
 	if (pdata->poweron) {
 		data->poweron = pdata->poweron;
 		data->poweron(true);
+
+		error = devm_add_action_or_reset(dev, mcs_touchkey_poweroff, data);
+		if (error)
+			return error;
 	}
 
-	error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
-				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				     client->dev.driver->name, data);
+	error = devm_request_threaded_irq(dev, client->irq, NULL, mcs_touchkey_interrupt,
+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  client->dev.driver->name, data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_free_mem;
+		return error;
 	}
 
 	error = input_register_device(input_dev);
 	if (error)
-		goto err_free_irq;
+		return error;
 
 	i2c_set_clientdata(client, data);
 	return 0;
-
-err_free_irq:
-	free_irq(client->irq, data);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(data);
-	return error;
-}
-
-static void mcs_touchkey_remove(struct i2c_client *client)
-{
-	struct mcs_touchkey_data *data = i2c_get_clientdata(client);
-
-	free_irq(client->irq, data);
-	if (data->poweron)
-		data->poweron(false);
-	input_unregister_device(data->input_dev);
-	kfree(data);
 }
 
 static void mcs_touchkey_shutdown(struct i2c_client *client)
@@ -259,7 +251,6 @@ static struct i2c_driver mcs_touchkey_driver = {
 		.pm	= pm_sleep_ptr(&mcs_touchkey_pm_ops),
 	},
 	.probe		= mcs_touchkey_probe,
-	.remove		= mcs_touchkey_remove,
 	.shutdown       = mcs_touchkey_shutdown,
 	.id_table	= mcs_touchkey_id,
 };
-- 
2.39.0

