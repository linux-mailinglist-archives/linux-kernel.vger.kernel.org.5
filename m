Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668BC751B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjGMIOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjGMINN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC8A2702;
        Thu, 13 Jul 2023 01:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5PS2ZmIeLBXOJBQOTXXng1+4gF4jZk5I+1NDXvLSa/mgVZUwrYj4leGy454IaV+prwnbh6vk/PtDRstX8HrCVLlmkGYk/k2TchI9y06aVszshX+o/GE/WBP5zgZ4Gr34yaFZUhDdcs5mxvUxn5GD/d58g0HT1xNxtqKUDRcUzkRaaPOsJ/Wq2WNB8YrrSRUFfWlYNCl9DiY0aEekd77R9vA2oXDv74qFD4E0IxXCspW/dZfx+zkCkJjKS3DBDNdZK2rp86M6JkiCFpOtcyhm9u53Jhzz3Frn6i8Sp6Se0xkLBgfbyK7C8h2ZxWmUN2sQJtyDrDbOQzX2GJBMuN+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc43eVj8D+jXjv+UOKZmNNsyrS57jCHl9PeQXr9Ahyc=;
 b=MLLRSdBed894kxnL3NR7ALsUd7N9uaBogtJpMiwyq+htWv0rrx2oNHi1QDfV7exL0WCUX7CLK0+EDsCMb00OEhsYA+Wjf6flUahG0RuOCLsPkuJ5Duc8UypT9GZ2dxtLUM0Htyvhb5AJD6/GRabMWmkT/4INJxEmUmsUm2/2jTUo2uW9DeSUV90d3l2n0foQyOrkJLuVSZk55lVXBm/My581LL0S9LZZRnHO3urakjzxgwM5cqc9SCrcVyKhUY4zejavR8C9LCJIzcU0s1QQcXNNZzXD19h8R7d7Aw6co3xz4ClYR5M/Y8VuCJDMG2zorDGnh+o8ZM0TF7AfbhadKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc43eVj8D+jXjv+UOKZmNNsyrS57jCHl9PeQXr9Ahyc=;
 b=XJoJsLiXXXBI/SsaoJnEKyBUFjpEqQjmjRxo5Hge2OfRcjn/9NE52AJlPHczokWJELbCySeBtWB6VkH5MMJ+SrrYJQaZum/KixVciSYneC1e0+9vN+b1RnJzq0XlFUp7OtF/nfxfMFjZQA4kxmrLFvyduCGB55aEvxc+rKp9z6NgHYSaey8MtUccEOdEfyG4ezMA/SGjOop+ObtUK+bBHFcwl90c55m1No7VGcq29tdw23qJ+k07Z+77DSk0q5uNEnfRof9I2NZrbcu60fc00R92BZdnZrq9B6FTEEdDeMn6GQ5jpTG1MQPtcRdBvYxitLyY6hyrwBBbYg6J9fcbXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:09:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Pierre Ossman <pierre@ossman.eu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 44/58] mmc: wbsd: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:53 +0800
Message-Id: <20230713080807.69999-44-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713080807.69999-1-frank.li@vivo.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbded1d-7064-4d90-b854-08db837880d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GWbHP8OICCMWvBViByBOK3ixyMMdcIqDPsLdscp18R2ciEIpkCRkU2ajLSeqbtOEp6ludZGbPXkjSkD0Fcrde3C0WwtnlmvphXGbooPmSlMFzA5Q3qrMTeLlpTg/2dUWcJCHVrwWBXB6aFfVWMHxsFAa8f4x3Wx3dDSad34JYYr+IpEUGFiumwobDz0xpc+6/MuW2eelWIyqSd9bpbg5ylN3zMHc1Rtp7lQkz6+LTmYyYx8p8A6j57PlTlRrAG9w4xYbyqNPaYNqoHwOomVF0TRzbivRnh8v9u7d0ROZSUEeC5dgJCQ89qMXZ+EaUVSI82LjwtuWQpf6rkYOvx5tbdOV9X+MnHZza42XvDepyIZrOjuKWzvEjmDUOYgh4FGwQsGcCyyT3DlJdK73XFhz4BuqDCFc9waIxw7+IfXQwvp7lN7gYCmS7T3HoS76HftfL58ACS9jOOX+xCuxBfnwpP1KT+82Ys9G27RxIE0bvZkfbLoEWGr725i/8imkOmgOSXPUxDpEjQN5CGgVrzasB10Czm2HzL3DZFUpHqUdCK8P/yc0CSifLsLd4+TMJsTVb8bFWjwCw1/t0AAvftfnghHeadIVd7Xei7rw2wqr/aoukokSgWjUZ9uUysG2acn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0JPcStCeUNnMC9iYy9MUjJlbE42OHhKcnM0TXJQZ1pQbUhJWEUrY0c1SWJr?=
 =?utf-8?B?U2w2RUFFd2NTTklCWDA0b2lnVW0zc1M0U3FncDY5ZHVDa0NtQ3grQWtEeXdn?=
 =?utf-8?B?NUFqU0xtR0ZqdzRMNFRjZHlUUVFZam1ubFdwZkxYUEN1VS84b2ZybUFUMVJr?=
 =?utf-8?B?cE1oZXNEOXpoV2IxWkFmZDRwRytSMXhQWGRoRTBpQTArTHVLSDc4UlQyQlIr?=
 =?utf-8?B?YktRcGphRFd0T0FYdkpkWEc1eGhPbGhoYm9lM3VtdTREVU5tQ3c0ZDFxdGww?=
 =?utf-8?B?OE5FRkwydjNFdzVwMEsxT21vUEZCaUtOZk9ZRFFIOWNGVVkyVzV3NVc3SW9H?=
 =?utf-8?B?OFl1QUlweENPMmRNZmhKbmIrTjB2citlYVQrVVNHaTEzQzI2dTNyNkdJaXR4?=
 =?utf-8?B?eVNSaGsvUHFsT1FTQVlmVW5KeDNaSUJDVmFLSEc3TmNpUWlTOTZiVkRMQmtO?=
 =?utf-8?B?T1ZIZUFzQUxmRU9yYk5IcENOR1ZMNlorUGZBL21xTmVKcXlhKzJUMGRLTnVz?=
 =?utf-8?B?c3dDTDM5SjFrbkYreVAyWTZmbW1aNlVFbDFMVVlUUGJFa21tbkozeVpodFpT?=
 =?utf-8?B?N2trM0p6U24weXdQeENkV0MycDVBY2YxRjRuOVFkeFJzMGU5ZzhRWVBtTmhQ?=
 =?utf-8?B?d1JweFBFSWpIVkhSMDg5RjdXKzh0WU40M1hrTjEwNGIxeDI5ajcxR1RoK0FJ?=
 =?utf-8?B?d1c0S3BUNW1KYTJlak81czN1ZjhURXZPS1ZoY051akJ0VTBMc3hsTVU2bGsx?=
 =?utf-8?B?TWJPdWpOL1RLeml5ZmtoTTZJdEJSaVdvcjNwYlVVM0dSckVjTzA3dWFoNnlX?=
 =?utf-8?B?WW5xT2NRMVZvNit0MFZNbDJnNVQ2bjF3dWw2WUxob0dzK1ZWTEZTb3JkSDg5?=
 =?utf-8?B?d1QyYTJiVjIrczEycHpEb2puS21UaVUxZTRiMHduWVNlcUVwOFZmUkd1U0pi?=
 =?utf-8?B?dWc5V2dlL2hPVmNnVTZ4VnpUZUZhVG8rMUR1U01nMTJHMlhaTDRlNGRiVCtZ?=
 =?utf-8?B?QTU0eDVEVkw1OWlPUnE0NnlyRi9ieWw0TUVMeXNjZVhKZHQwMWUrUnBlcHFL?=
 =?utf-8?B?ek5tUm94NTVsVThWTmlLTERqcmE5UlV2cTBHeTJma1F2di9JNVc2RDFiZVpy?=
 =?utf-8?B?MEpxS1hmNmNzc2luTy9vdnE2bDIybGtidkNuTkFuNHZtSktzVTFxNnNkcUVE?=
 =?utf-8?B?RjBualR6U2w3a21QdmNYakRUdDBjOVVCWG94S1dPdEtBTkVqbUlTRWhvdTVI?=
 =?utf-8?B?Y0dJc2dDc2Rzc0NtcS9lV1ljQWI2cEpIUk9YejNXWFRxMXhLQW92dTl1dUxN?=
 =?utf-8?B?SHlUbG1hZlBWQ0RhT3BWYUZLOUN6SVMzd3padVVhVTgzbkFKNThsSDhmTG5r?=
 =?utf-8?B?OTE0SjhJU2pGeUUvQ3dhSkNyNzV6VXBKZUpEQU51SE5ha1I2bWRnV2pSVmVO?=
 =?utf-8?B?a1FwS2RFYUpLclo0SkZMUW5jdERkTDNUVExsajV4Yzc5WUNVd3dWWVUzY28y?=
 =?utf-8?B?bXVVSmdJcXFkbUIyS2tseENhdEFqbHpWOXBZZEY5dkd1TjBEZ0p4TXhHMEFU?=
 =?utf-8?B?Ukl5V3NjOE9YZ25GRFdjd3R0L0Fmd2VWSXNPbDBLRk9nbXIwZ2lSY2dqcG5y?=
 =?utf-8?B?MHlzanZLdncwNFNGcXVHZEV2c0svcGRmanNXVnJ6cm1XTHZOK0FKMFRJQWcv?=
 =?utf-8?B?WkRTdjFSNkk0NFpDL000Mkkva3BFM2lLV29BdXlwQzdjcnNpQlViV2RGWjNU?=
 =?utf-8?B?WElyQ3RRMlU5aGlweUNoaTlBMHZpS0hsdUtQUS9hVURZaFZoYmZKZHZXU2RH?=
 =?utf-8?B?UElqVllibzE5MDB3Uzk1ZE5nQ3NCK1FUV1p3d3JaNGxWdEIzYzBtc240THFo?=
 =?utf-8?B?UCt6bTQrVFk4aWhLMkF1OGNtem4rSEl2dFJBc1ZFS1BaMmxiYWp2ODZrRlc3?=
 =?utf-8?B?QVhESlY3V1pUS1luODczQnJyN2dZSW52MDhlSjIzbDBoZS9JTlNBK0dVN0p1?=
 =?utf-8?B?TEFxci90V3pUZyt5UWc0YldsRkV1MW80WUNEdE1BR2dJOGNCTG1UWFpjQVpS?=
 =?utf-8?B?cHM4bnJkeWxBNTRuemFQZVZ6Qjgrd1ptdFlpK1FYZk1ja2k2MWJWa0xKVW1X?=
 =?utf-8?Q?bY4vNhUcJRAtSujB0D4SW1mv7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbded1d-7064-4d90-b854-08db837880d0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:38.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfOi5MirEmZMeICPxfJA2CXwNyh98CiHD0kIFTBMSilyz6wn1C1lvSMYhjxxPUl4S9ziEj6Du6Dh1tstjkB2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/wbsd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 521af9251f33..f361cefcee01 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1758,11 +1758,9 @@ static int wbsd_probe(struct platform_device *dev)
 	return wbsd_init(&dev->dev, param_io, param_irq, param_dma, 0);
 }
 
-static int wbsd_remove(struct platform_device *dev)
+static void wbsd_remove(struct platform_device *dev)
 {
 	wbsd_shutdown(&dev->dev, 0);
-
-	return 0;
 }
 
 /*
@@ -1904,8 +1902,7 @@ static struct platform_device *wbsd_device;
 
 static struct platform_driver wbsd_driver = {
 	.probe		= wbsd_probe,
-	.remove		= wbsd_remove,
-
+	.remove_new	= wbsd_remove,
 	.suspend	= wbsd_platform_suspend,
 	.resume		= wbsd_platform_resume,
 	.driver		= {
-- 
2.39.0

