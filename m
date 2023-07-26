Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD687762A03
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjGZEJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjGZEIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:08:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6D5448B;
        Tue, 25 Jul 2023 21:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdB/XdIWVSEd9JjSHBpH0gLVC+RB2BlmqviEtAuWAlmtPycm5Wwwu29PJpt0/pdxqrcVuK41hmrk96+fJUQYM8svvpkblHIMr5TukGbOWTgBZE9i5f6BG45SnJ9vMCs6xRjYx373SeWwpnMxfI4Rfr2vE/unr1JaxW556JsANHEMUycwmZV9BirXort12imlBB5R3WzlIRtWFMuAheMIvHT7a9AB92LhbZVOXmIrlFQL5zTjMoyY2uCryvFSp3MEtfTMzRCbZrWwiBo2w6f1rRBDIXfds7k5xM4Ra1AaysmBu468LRrfgRjpznTlXQGPU6tXzH9vyLpPY/77wUKYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLrIU4EUdrLqb7T0bkwRGkvgLMm9bmDLScwtsrZ+fTw=;
 b=GYT+UU9h4q29QXBkznNbqqKc8dPCdB7A5/J8LobsHTrOJSkjkkqhCnvuMiZ09xsUHIA2fJvSHsHToQ0bOKm0ALvrshSFMmDGq4UPZIXXTa7x1wbF4Lj43/DphV+a0bJaj/VX9O0czqoW4jmaAmPQ2xtlvWXzBtfx5glK4eRzsMCSUa5P3drOIQa/KxmTe+bJeDEWW9jduMi9N4+KwXccfIxGOy/lRa7U7tLgkwiUH6XuofFqFmIUV/rj6tok+NdV8Lteg4BbusiHq6loaZDxb+HikBc6BiSClHrSSnloco5oukQ22/1IOLHUN/14t6qepYSGGEaEnGt8llp5bk4ksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLrIU4EUdrLqb7T0bkwRGkvgLMm9bmDLScwtsrZ+fTw=;
 b=KkeUS5e5t5KO0lbgTwqPUg3E5/iUUqA1rYVvMWQAmvVLFdvd4XxeX4EuigWhvZJDF8ql5LuhxG81oPMhwjpAlrqfaRj3GjJFoMeqWEXkm1OsJy7mxLc+iFCL91DGLfgNnAvHIwWzcsJvsG2PoINA/3Ux7b/CCh28Il5msJXHCU5kkS0u2FynWDapcQ3CdRNXKXle2itf4Nbu1Y7jE4H8uhv+TuTWnfoFwC8pro62jVjMNFEbUMlxd8R8MvIuuSId2k3rFhZH0KK0ZVdCfURfVQq1K90LPS85ifEZb5jItMAVZpHc7qcT0YwNqgY3E9WjBH4911Y77ojgVDAyS8IorQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 46/61] mmc: atmel-mci: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:26 +0800
Message-Id: <20230726040041.26267-46-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726040041.26267-1-frank.li@vivo.com>
References: <20230726040041.26267-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d037bc-e351-41cb-f384-08db8d8d1b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfrcrJ8WAKh5/WhuybRFhX7if7YMlxEHhPny2vXchuBTqEB11hbDDXOGAO8UlbSf0ZRviKkoOdOQZVEGvQjDYl5HkWvqKoOpD7Ah7u7ruu6ECIHzDvBi/sYNF3JbjGYFoM9SizFXX80+gLPE1JoTfjT8zJYafIKOusGvYTNircgEyZLiTWdlSwx0R7aItwOfvPrAGjSefWz4v3CQNFcPYYBI15EeaMhow+LHMFrpQRQfwD0F/lhkx0etLFsdh+jOGvCPuIZNy+sjTh29ss6kmR5jnEt6+Zx5BVN5gkumhK7FbZl9h1znsTCycW+uW4yfChlhAGVlTTBH5AC2V0hp/+0khpBrlsTMFiyA8byI+oiuG3FtG3V+OwQKsdNkBwRe5XcY7tpVmhJbZ6l5dxWvYFDxoReUDkHtdytcReZXUUfxiUFgrBuOHsc1IW/Hf1F+gK+Gf1RFCLiUELL0/HrnnLNd1bXPP/hFgAVni+EY6BWjUsfuy/FbhEXMpgTqwaP/e7VVfYwbfUNUN3uRQuXjh9sUm0fnJzlLMqIrytc9VMYuGlb7CsN21h7NIbsjzc1qibC68yVE4baAce1JVK82wdtu94n6h7qC7uYngbuVMs9JaRk1bXnR4jd91FgChAxK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFaS3NibVdsRzM3V0ZjSk1rWVpyZ2d5SldQL0ROWnkzVGMyTEt6aXB1VEt6?=
 =?utf-8?B?elVkVSsvR21iNmZnbGdqR3R5OUpjK2FLRnFySHlrYkxSdDVkVWU2WlIya1Ju?=
 =?utf-8?B?ZE1VMmt6ZU1BdjVIZXBheHhzNFhSUWhwOVFEZXVoSEMrWVh6ZW4zUk5JaE5S?=
 =?utf-8?B?enZUeUFiYmpkMGpocGhSZFU0N1FXMlZvK0t3WGxlM2d3c0Izb2lxenVDc3ds?=
 =?utf-8?B?NGhCd2h3cklTWDBhTzRBVjFMQUtrMXZ0aWMySG14WkRWcEJwRkQzN1Bkd1VQ?=
 =?utf-8?B?WTNwNGhUcmFGTDVlWU1kbFQ3ODI4VS9kWnpRN1FEUGlDbVdaTDVFT2NzNWo2?=
 =?utf-8?B?R1F0VTV0Y2pxQ3JpVGl0d28vQUdUVmhBNkdHaTRERVRlSUR0dnVqVzRoM3d2?=
 =?utf-8?B?ZGQ3cVhLUktaZkFaSVBCK0RaOWxITERtU3cyaTh0SVJzZmovN01FeEFQS2tu?=
 =?utf-8?B?NHVXTS9rT2VjVExTOWg4OVB5akVzeHdTN2hLNkNCdFNCclF6cHAxUEo2cllw?=
 =?utf-8?B?N0FLdTZuZ2J2Z2RYU0JzNmYxRGR4WHBqU1h4S3I0WEs0RHlObEVoRnZ4NFlw?=
 =?utf-8?B?YUtXdzRDYXlQM0pKNDRaZEw3bWNLczdzbnlpa2poMlkxWFZ0MG1VenNpb2R1?=
 =?utf-8?B?SFFVbkVXeXJzUkpUV1ZUVWpEUjFpdU03bG5UY3JRRDVvK20rWngxWXl0NldX?=
 =?utf-8?B?TTA4aVVlQXJvVmsyb0hxVXpDWXJsY1MxWThPSkNQMm1PcnBZZWxRZ3IxMUFG?=
 =?utf-8?B?UkNPbzVQYVRUWmRkOFJ1WHVYRGU1WkxZc1RtKytOZEg1cVlYRXdlaHVmLzJT?=
 =?utf-8?B?c2ZKRld2T2J5ZmZLN1lRdDNQNGZCOWFUa294aVhVTkZBc2Y3bE1sbFY3VjJV?=
 =?utf-8?B?QkhVdVlyanhzMjZYYWl2aGg4OFpGTXczeGR6QnRmaFBvZkhlYjVIKzlaUzlZ?=
 =?utf-8?B?UjZ6UHZ0ZTh0RXdaN2FBanpXS0tMRC8zS21CMDdyUHYxNzBhbW5zS2JBTU5m?=
 =?utf-8?B?UnFvbi9YdWRuS09wSkV5OFJUenFkQnhGdEpEREtGZmg2YlZQUDRmZ2xPK0Zr?=
 =?utf-8?B?cFlrbXA4b2pmUmtMSUViSHFNWDZQd2wveGZqQXpBc1RTazg4aVhrZzlER2NL?=
 =?utf-8?B?b255azltb0JwR0FpRG9TT2c3WVpmOFF6ODFsc2FZd1h4aGJsc0w5ZzNzKzky?=
 =?utf-8?B?Nk1zY1ViVUtrTE9ocW1mZVNMMFgxaW5uaU5ScC9KLzZROEF4aEdKRjUyT0dT?=
 =?utf-8?B?S0lWMTZhWjAxSzA5dVV4T2V5UmRHZ0dTdDV2VXV3UUNYYkJFSlRLdVBOdXc1?=
 =?utf-8?B?K0xzMy9JZHJ6TUsxMCtkSlpRODBPNEZkMFBxMlg4NGIzOTRhR0pBTXhNdHJE?=
 =?utf-8?B?bk1OM3N6emR2UlRBcGViTi9valVCVTNlam56WUxnMnVZTlBSY2crb050Z2RV?=
 =?utf-8?B?QVV2Nm9sRVVWdUZCcFpnakhMYnZGSHBSU2tRbVFpZHg5dE4vSmY3L0kxMnZX?=
 =?utf-8?B?c2twUERrclNuUGhrOEZZVVRzNElrY3JBVTZPaG05SlBlaTB2a0QwSWFsZGox?=
 =?utf-8?B?N3AxaWpQS2pEZ3hRZ2swTGZLZm9nQlY2RjY5Si9lTkR5TXdnYTdYNStPamgv?=
 =?utf-8?B?R1F1QXVnZ0NXeHVvREhLK1VhYjJjdm1LRnUrQ1dTWktkSTVnTmd4V0o1TTRy?=
 =?utf-8?B?RHY1eWNocXN2WHpsMnRJbndPVlMya205bGx3U055ZlJzdC9pVHArVmFSRjV3?=
 =?utf-8?B?eHhNWHA0N0ZUQU56dzFFTCtUK0V0Uk1IdUxVT1dCRGwyVWhDMmIrTFBxRVlp?=
 =?utf-8?B?L3VYbWZxS0VKS3F2YVg0a1NGNHRYV0w3RkR1aGZrUFJZTnZqdG1oUW9qOXJJ?=
 =?utf-8?B?VkRZVWl1ckN1TTg5Vkw3ZnhScEdmd0dJNndpbEt1ZmFJRnVYTk45cWhFeFJZ?=
 =?utf-8?B?czZYY1NsVkNZQkgvUUI5TEFRZ0taUkltazRoSWpJR1BqZWZUZ1JlbGx6d3ZR?=
 =?utf-8?B?eHhURnlkdkNNN1plbWxuWUp6QlJVNGVEek1xenR1UlJ4RllBYkZ0b0tPNkdQ?=
 =?utf-8?B?ZW80ZDlTdHlxYit1V2lxYjc0NTdsWG1DRXZaQ2E1cjdFOG1zSWhhZ2RwTnQ0?=
 =?utf-8?Q?5PtiYRznZ9GdT+v16TYJDnYoC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d037bc-e351-41cb-f384-08db8d8d1b50
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:19.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z29OMKT9BH6Z32B73HHq4n667wnITKP5sHFDOKyHAv7OVfWKvV1oSkAEGM1ayqnVDKICR3X1/6po63rvJV+FuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/atmel-mci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index dd18440a90c5..b4ae9aa939a5 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2600,7 +2600,7 @@ static int atmci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int atmci_remove(struct platform_device *pdev)
+static void atmci_remove(struct platform_device *pdev)
 {
 	struct atmel_mci	*host = platform_get_drvdata(pdev);
 	unsigned int		i;
@@ -2630,8 +2630,6 @@ static int atmci_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -2664,7 +2662,7 @@ static const struct dev_pm_ops atmci_dev_pm_ops = {
 
 static struct platform_driver atmci_driver = {
 	.probe		= atmci_probe,
-	.remove		= atmci_remove,
+	.remove_new	= atmci_remove,
 	.driver		= {
 		.name		= "atmel_mci",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

