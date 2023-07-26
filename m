Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350DB7629BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGZECA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZEBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A857268C;
        Tue, 25 Jul 2023 21:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh7YWxdKOALah58bnDCmiZ2sCI0qE/25krITgbQQb4JAyj3GqXK8aPyU4nyEmLtnMTeCavsk3rANyBrQcsK0ZWx1I9IVyBz48owFCUA9x8G29QZfyzID5LaHg2AnCiuVGpSKj5go3k4rEwjPcYokxeAhpao+NmYNUkO8eTf/gofE7BQgzT9Z05d3nIwbojHxygbcn+jXIDkqcFSbB5ilgaSnfO3CRHderFZb+Zb9PGZ4W4LVl2DkTo2ANVIdJcaVlYWrgLQuWjcDGrZM4wYUkn0JfpHSAzowEu1+Ae4wDuL4c3679V+VjhQthGG272zYEUqk0CrZ3IR2bLTP+c1P1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QdurEMlGIZsmiqW8S2xEYZCcDPaCpY8fWT4ehR5P58=;
 b=H4jErh3ybX48QhlrZGay7/tVz0PTb27F+7xled3A/i7z0trUt+foAGzgFRlAMtaK5dRWbRna+1KuisEphodWakE6edWCorXMrwaYWpXr2dBGa96jzmqpYo+ouLPreUF+Jj4xlpM+/DhZM+4m6I/pd2O6rZYID7LgJP+CLAtl0+uEUukdeOuFUF4CpK9Z/eRHBEcHz1q0s1VkZSLlPlMJqPo2o9/16QUaNqe5rHfgRKLCOA7vUohEnHVLNJ0ETi36HzhTPWRdkwrXAzKWo35RcpwAo9weufSTsHgRlgwOPg07OeyxQdevXxmyIeGMXHgHVgs7R9fdnA2o5xZXrjquWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QdurEMlGIZsmiqW8S2xEYZCcDPaCpY8fWT4ehR5P58=;
 b=NruAjOg31qMr1XZqENKd9LE5/XDm4XlRqoNJfmhdPRF1bnSwe5GJdzQM/Nc3Nf+L9LtrWG5B/xQIbEwjxr5eDNQ7CuXdz3X9At2qfUltF0zlhMxr2BfQily8YvminzhTDxyVPDBUYhJeI1qHIDEZzyo4P9NMwnx7If7IetvdFLWezCTXk1R2+Il4N3mFZ0RGAtmLmD+h5MBzGeIRVk7FJ0lyaVOS/ZgWm0diqX3AX7yHiIBkzT6jZmdvovrHylAbi/Sge+TznqDqalGuZv09ERqrqmzaL/MXWW3NGpsgE6TrjO8yP8TAi06p0OxqjTiMReFJY2fR0MvaGHjfsEeQSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/61] mmc: bcm2835: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:42 +0800
Message-Id: <20230726040041.26267-2-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d442b0-130c-4a34-4066-08db8d8cec08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2ZWFXdJVmAefUSR8IGC57U5g3OJ3sfLkfxhxN4uMM4Ycdi8iAxNNCeuAK//v/U/jRvrXFUI6K509ELVKTXkiFLRFRF5IlrMsUaoQkRb0EVk7YFTntX65az5AaMrFUUPDQPDRhT4xqthid40olHSrPwkFEp3+XQMCvrsiDpH4i6OGBTv+BuIHRendPQYAx1YK1oJMOPq96OimaA6qCuHLMhrpW/ZY5LBu96CbkS3x4Hkz7GbMtNoZ85iI/kKNJm5zx6xb3CYGJB1+kiq/d/7j/SQJHGmb62biXrPSMFh3nZEiVke2hQZkla04msGuXlE/bvPo50HuplaU0OtrhQsSiIjXcaztQMqjw+wlTywyCXYWicm23/GRcDvfjoWVIf4aml0s+nVNbmfDVGwRuaqGBicFJbRJIqwmrdO86k5l3lMd5xphE6Gyym4u1Hb8I5S97rnuuBq7KLd8W7ExTUpVqCA9UI9YXgSA+cvGj7jWnFl0JgwBwGSW1gPpF7r4ub7WrxeuoP2tm0nYkOxHCZEBtDzgkQZE0Q7u1zbN5H1qtCw3feMz6zDVQFqVlSxYVCviSir9uJA34FkQQzjwc/T7Fdi+KAxdRGeG4bGFxhKyolNySPnIUmiTi8fkKcHNSnn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(7416002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDUvNHNvY3BSakxJaWh4THprTGhWVXNyazRqU0R2VjFKelAvQmVqVkQ4YjBB?=
 =?utf-8?B?RUdyNXA5N21GQlJQS21IREM2QWUrUk1nVlF5THl5RlBUYXlLbjlKcjJWd0xp?=
 =?utf-8?B?emY2cjJGTTU1TW9id1J5Q1VFVmRGSmpEVk9LNnJJRmpkT2YwS0pYdHA3c1l3?=
 =?utf-8?B?VTc0ZnljS3NaY1IrYXR3VkFidlQwVk93Y2czT3VCNVB1MS91SG5mbWpPL3Q2?=
 =?utf-8?B?MFNPSjc3TnBMcnpoaDB2QU1HK29tV2I1Y2dTdWkydk05OHpQT3VlYm1HYm1p?=
 =?utf-8?B?Q0hJZlVPL1RYck8yWnFJbHFnQmRHSXo1YlRqd240Y0RzY3M5N1k2cmNKRVo0?=
 =?utf-8?B?TWlKejEwVzk1a0hacndSQXA4MngyRVNxbXVuRi9ZOXBZYnJFWVVhT0RadGhT?=
 =?utf-8?B?SlFFWnNoaHlxdnZISFZ0L3FKMFE5TzhFQU1HUlB0Vk5TelFOMm04MUtCa05l?=
 =?utf-8?B?dGFueVgzZk1xbENDNG4vdHZmc1BpZlRZR1FlMDVjN0cwZW9LSGhIL3UzWDNB?=
 =?utf-8?B?eC96STg0UGZId2pJMEprQ3lRdUlJa3dMaEVFTEVTbHBuckYwWHJJZEczNlpT?=
 =?utf-8?B?TU5ZUUs1dS8rbDNnVWwyODA1N3FnVG5aMG1ob09lV21aSXBpcHlFSnB4N0k0?=
 =?utf-8?B?bkdyWVZnOXhicHhxZFlObm1wZHo5Nit1Z0o1eWdBalZwWXhvNEd4dTZqV1Iw?=
 =?utf-8?B?NGsrVDQrc2NnYzZ1Zld2WGV2V1NKSTFuNUtMSnM4Sjc2ell5UG9pMVdoLy9L?=
 =?utf-8?B?cTlQanI4dkdlSkV1bk5nUnl1c2M3emZCd0FoenAvWTlWR1QvZ1FGdXFEcFI1?=
 =?utf-8?B?SW94eGE4aERIMHU0QUJsTWhINHBENk12ZHk3Z1c1cFlRT1UxNS9oU2hraWpl?=
 =?utf-8?B?a0FiUlVEbUN2cnI5a2l1bDZIblprQnNOUmJWbTIrWWNzUml4aDRsUlNOSm5H?=
 =?utf-8?B?TnNFRFJ3LzAzM3pZamVjSkFXdWJVRnZnaExyYWdhT0RLZkNMQjFBQWpnalpa?=
 =?utf-8?B?VVZMaUxFT1RHSHFiZytWU1kxMHpTZnpiUlkzelVueWxNZkRqbVgyQ3NyVUJC?=
 =?utf-8?B?NnkrOUhEMllPM1dKSjhJcDFDR2lPb1JSU05EMVNzdW1XTTlwNGRzUVdPNXlx?=
 =?utf-8?B?Y0NWRjlUWTJ5MWs4cTBLYklPZW0wRy82cjVTOWNCYUlBWEVERVR4eGJQTXdZ?=
 =?utf-8?B?Ulh5YzRNVmJibk5scTdkUU1ISnk0ZUwvYUhHRjdnNDgrMEdsb0dabXFqME4z?=
 =?utf-8?B?REVKMndGV2ErcTAyMlBZa3FlMTVXMFV4WHdjV25TR2pXenhzMUIrdXZOaDVi?=
 =?utf-8?B?cnM5bTRzOFkyeGFxaHoxR0M1ME9MUWxzVXhpMkZYL0FSSlFsdENGTVQzNGRR?=
 =?utf-8?B?dW5oclJvNEp2QUI2VjRzWkVvR092WUd6M2RCNFV4bmFteWhEQ0VwOFIybm5N?=
 =?utf-8?B?ZVRjcGpXS3Bsamc2eDI2cXV0RWd0ZHlRYmphT25vcVk1R3ZnRFVpa0lZVThF?=
 =?utf-8?B?bDd4OVNqUkJRbE90S2dOVVc4d2FoTENGbXZpeW5wQ0xSQzhWc2p1YzR6TzYy?=
 =?utf-8?B?ZGtkdHRXVXRkVnFNT05YRVVkQ28yZVViT0ZSdnZKWGtiQ092OHZVNitMSzVQ?=
 =?utf-8?B?cEhBOU9UbkVaRGZub3FsdmtRZDdUemJsV2VGWlBDYmFiTHBJMjNpdDI0U0xV?=
 =?utf-8?B?NU1KL1NIeU45bmQzUThkNHlmOUVMYnpIdk51RXBmRURNTDlZbXJ3Ryt1UjFZ?=
 =?utf-8?B?QTdlNTRWb1Zmb0ZidVRUTlFERVZGTXpYOXlMQlJsU1R2OWhLTWs4QTg5SFVM?=
 =?utf-8?B?R291ams3VDM4T0NvYWlzbkw4Z2hvL0FFM1REZ3htYW5VcE42WHpmVno2VFNU?=
 =?utf-8?B?RzJ5NzkrUWZQcG5JU0RGS2ZIZUFIWEorNGhGeEFGZUlCanordmd1R2d3TjBK?=
 =?utf-8?B?UjJ2MUxXcDM1Tm1Qd3BFZFFXbTQ2NCs3YUNKSW44aG1jTUxWRjFHYStEcXAw?=
 =?utf-8?B?ZXkzUjdWcmRibTBxNVNIckZHYVd4VFIyeHBGRWIzMUZnYWEwQlVOMk1iTkdD?=
 =?utf-8?B?L012M3A5czhWUGYvNjVicHczZnVhYnBodlF3clVZa0hhWTVRQUZLaFNyMTZZ?=
 =?utf-8?Q?Li/mYBxlBYjx+1pXPDYBlR4v2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d442b0-130c-4a34-4066-08db8d8cec08
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:00:59.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKrN8aINOvnirejrfeB/CP03i+jJQVk/0hkfLGw67uh4vWaqfE4ZAg7ksyG6kAsfR6NmlOXisYKBlAzz2iHSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/mmc/host/bcm2835.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index eea208856ce0..35d8fdea668b 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1431,7 +1431,7 @@ static int bcm2835_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm2835_remove(struct platform_device *pdev)
+static void bcm2835_remove(struct platform_device *pdev)
 {
 	struct bcm2835_host *host = platform_get_drvdata(pdev);
 	struct mmc_host *mmc = mmc_from_priv(host);
@@ -1449,8 +1449,6 @@ static int bcm2835_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma_chan_rxtx);
 
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id bcm2835_match[] = {
@@ -1461,7 +1459,7 @@ MODULE_DEVICE_TABLE(of, bcm2835_match);
 
 static struct platform_driver bcm2835_driver = {
 	.probe      = bcm2835_probe,
-	.remove     = bcm2835_remove,
+	.remove_new = bcm2835_remove,
 	.driver     = {
 		.name		= "sdhost-bcm2835",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

