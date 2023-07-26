Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ADE7629AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGZEBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGZEBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0826A2;
        Tue, 25 Jul 2023 21:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaNajTNzecTM8WTYp8Q7ggNgloBcHTyG93CzJYbVKfHZyHV0iWy1UXGufVKBuHskBofYmunKAVSM3W8F/W3saEBt+k6EGtx6XMgces26wq/gNc8Q8o1kqvn6tftETpvqij9BDaNxZ2q5k9I3ChwdQw61/7be+diJy8wMjJG7UH9CCC2pgNp01N5K5aFGukFPK9ybps+BQ26PgijhyMaipVwBeYE+GomeTH1FmVbLNHNLW8BmgHfWcs99cFw/SfFrqlyEU3ti5wt2nvfnLPlRvgx59AO3c4CvBjWt7+zMx0y1Vf8BkA9xJy3CqUpyD0cDMb7pN5/Q6jRjXw3caWwc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqxSuEFdgd7k42jXTQq9t2x1NA379+lBETFrgOHf+Eg=;
 b=i6EFv+qwU+uuo7cmIoGIhTEjpgpCPQr+tmVfsoNlWgGSBpuOpAahKYP9ctr1btuhsdIj7rrE8fz1MstCmXf/DHdn+cigDdruYX3uHq3v7wOEDIG5dgz3Xcd5TgM+nNcxY244C3+AdsBpHMiZYbKF4hrvkDQSIYsa9RsmnRWpS9LMyjsmaSHSlE8gpr1a3qy5UOJZsPhJ56xUDRHETRC7ijaKJDdHE6EPakZFN9BIPBvRyJuz7rqNiGwR5I5Ltu/wEAnaceDC2CL7nBj8y52MRBXTURabETyx42Zsq00/wE/PzurFYESEbmoH1cwOsPLiEC6p3LTR0eiMGQnf+X/CkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqxSuEFdgd7k42jXTQq9t2x1NA379+lBETFrgOHf+Eg=;
 b=mNkz7HsB50waEWLYCCDZ4lHK8KC7EAdImAclZdANxM8hB0X5BzCAoyVc5xo4GxQjhVLrKoudulEjhNHGXjXJqnDHOrw2Then9ylWvvKXemaMuwIZpxdRJcu6Z4FqnQPQACMAKy/ZbPaCJzurG1cvoNX5Kwi7SQJb+HMmc8YBXdX4NyBOSJcch6N+iU0O67Zljn+XJkfy4BlLUTjeBSmIfOTu8GtaMw3f0YZ3w7m515ABmSa8qiGBB0PsJm6rEwpXY2zLmIl3E4FFJAH1/zdDSP2crt13j+HDhhNenr7ccLv/pvpGOoGNvzFrPLglMJsIAVRw8fREos96kIVADqj3cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/61] mmc: jz4740: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:43 +0800
Message-Id: <20230726040041.26267-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d78ad3c-d4ea-4000-6519-08db8d8cecfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZVTXxhx6zdIjFiFtEu92/9J36py0b4YQqFP15JBJkV47lsW7L8ga+LnEMzZleMFwcflg87XO5CM/sgR33pqTneasAkKq+qfA7cxZVqGWBG0qqY5z6YK8xHlT2Usf/5tI3o81Mn5S5t3OnI9gLN63fu1ycHuiV2I9SD9qiRwklkZmBwLHxsEPIZD+Z+huuE0xVnPnxS5VZgigEzH7lW7sj25C/RlOQvsUlmpaCMdi2E9+WQJUZ7moEiUq5Q64iejpW435MqgpIgpAnHz1qu02E8hIzIwHRqxCbh4Sz51YIX87Phf6ZyT2s4kXjPVAghEPJUyHftePbQ/N3VRXa4sH60nONpbDKlx+U4rQw/FtCJG96O/AliMfjy/UXcvAOVw6EfvIwB9T5lRDoSz6t5iHeB2GS1sGxBfse3aipOd8QkBr8Itqyn6iVCoV52koSePjJMDs4jm02zPL1Ti7V/uVKds9fq2AHURxHmhlMQiX6n0XS1fPSTOXm4xpmVdY1M0C6Mhiafa+qnDC6MoLcDN+bMSrNcmr2wGKey9Q0ScfcY1vPYPniVXaqMsMMRcUnhe6KDpFt9TG+frqaK7QgwUzqkk6H6RNQMYn0o25/ZN3PmcPUEJ7WY+4b1YOR/IBJsp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(66574015)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWRBd3NTQ1BjV3JIL2pVLzhzWE1ZckxDb2lkaGRtYnNoTlhIMS91K2s5N252?=
 =?utf-8?B?YjVvN002ME83SEJia0dYVktvOHVhdnpyS2J4NXNyMkdmWHptRU1iVituQkVQ?=
 =?utf-8?B?dzNlVm15ZTdnb3FFbmJoeFVSeTU2UzBDVXFhK29mL2JOL294My92T0wwV3lQ?=
 =?utf-8?B?a2JqVStvZEFKMGx0YU5CWlA0NEJjRVZhUFkrakdxK3ZGNDR3TzNtZUdMb2M5?=
 =?utf-8?B?L2lMMDhFRWRVRWhacC9NM2FTMEpsekZuOUZobkZ3dzY0WkkwWTlrcndZNmQw?=
 =?utf-8?B?SlBZYVpIZ3l2K1ZHeHpLMUpHM0Q4WjFUM3hDYmp6Z2cxQTdHWXB0SDAzYzJT?=
 =?utf-8?B?T1BmamF6d2doNDdVM0dleUsySm0wYzBtUDhhS2p6SHMwbE8xM2g4WUZON0NK?=
 =?utf-8?B?ajFoVHIyTzA1YmhYdlhRemtRWG5CN0FGeEZUb01SYUNwWHZGc01sbW9ra0E5?=
 =?utf-8?B?Ly9jU1p6ZVRSWmpzQ3ZjZlJ1N0pKUktUcnpVZUVDZGQvclF5WnVIVzNxdnBC?=
 =?utf-8?B?TXpZRTVnVmUyaW1HUDc1Sk5VR0gzQ1UyamJrRmI5SG53NE9MeTEzc2JDOEpW?=
 =?utf-8?B?cFR6TWYxbFJ4bUFqS2c1ZUN5bm1IT0g1RTY1RFpVZVlGb3BSK0dIOGpXMW9l?=
 =?utf-8?B?aTVQTncxajhvNDlaalJlclh0RXhiNC9EWHFJbldCR0xDRXpKOVVTem4rcFJ2?=
 =?utf-8?B?K3dsQUFjYUVac3RPZ2thNU1LVVhDQjFoTDF1ZWRsdEdFd3ltajJpdmxQRDRZ?=
 =?utf-8?B?cTYyN2hFWU1uZ0drZlNXSWU4RVFrQzFiQVl5dUxYVXcxcEJjVWV1Qkc5aUhm?=
 =?utf-8?B?M3NTVlp1Zm83V3p5KzJnUXpzcmRqTVlscjJrSEJwSXYwYkRONlB3R2tZcUFZ?=
 =?utf-8?B?ZXpxQ2lnNXZXOTllYlQ3dG42SHdHVUZ5TGZoMG5jTUpTalBHeHNFUHJtZXkz?=
 =?utf-8?B?dkk4czNUQk9CVHJValNOWkd4aUNNbER1S0c4T2RWL3dlcDFvZkU1YnYrMmFn?=
 =?utf-8?B?cGJac0tTNzlNa3FjTmRHNzlza2kxRjUyZVJUWlk0K25zSGdQZC92MFdTZ1p6?=
 =?utf-8?B?MitzZm1mZWpqditFRzBmM3EvY09MeVA2dHduYjZOa3djL2dmcnY5ZytOYlVK?=
 =?utf-8?B?NVBRN1d1dVZ2cGpQRWJRdTRqVWd1RTkvMTV2Q3R2VXM2UUI3WjE3aXhad1J5?=
 =?utf-8?B?M1NkbmhKeTRiSW1aMDJQajJZZW1BREpKeUk1Q0J5SDNaYnZTVjUxdWlMQnhw?=
 =?utf-8?B?ZGFsaUdXMkhwc3hEVGF1UGJXV0xuZ25QWVNFM1dKUlVidjZvVFI3N2JsWnNM?=
 =?utf-8?B?L0Y0OGRkditzRSsrdlpMQUdXQ1F3ZkpoczBnMnVhS1NQRmErV3FKRHpXNXN2?=
 =?utf-8?B?TVpCSWVRamZKN1RtRDU0QmdCTmRxQTJsVkEyNnRDY0hveTY2SGoyOEY4NDhs?=
 =?utf-8?B?aWZBaStoR2JLNXd3WW14VHd0a1dOWVo1WkhXQk9xaVN4OXBVR21KZVM5emJx?=
 =?utf-8?B?dTNtTHZvbnhWMmVaNVdKeHFJU1dZNlh3RlVRd2djT21VeGZKOTRqdnZiT3JT?=
 =?utf-8?B?dk94WE9KSVpmRHdDaHFQdlUxbmZqTkc4UnAxTUhlZUx2VS9mYmppbks3Q3RU?=
 =?utf-8?B?N2lJSE9xNTI1UVdlNU15N0oxMDkxUjExWWZ3anVKdE9mZitKQThCOUhiWTln?=
 =?utf-8?B?Vlk5NGpXU3YrRXFDV1Z3eHBEL3hVNHpxVXNwbXV6amJUb0FWTW94cWpqbGRT?=
 =?utf-8?B?bjF5OFczSi91SExCYjk2MmlkbVJkRTJLZUVmL3hWc1JmVG5aR21lekl3RXhV?=
 =?utf-8?B?Tk1oN0txM3RDMytXMmVtU0FDU2xMNHp6SlloSGwxMmNsZTdubmQ3a1NwRk5O?=
 =?utf-8?B?Rkg5bWRpd1VmcWxLQ0FiMHVia2JXamxxQUVCZGs2WjRGTW9lS0VKZGV0L0NF?=
 =?utf-8?B?eCtGQjgvbnZUUVBEdWJDRWVNSXFhUE1MakgycjJmaW1ESVl4eXFGbHdmRXRn?=
 =?utf-8?B?R0YvUjRXeUM4NHN1TzF3VjhLV0ZmQXhOR0ZBMnphbXZvOGNFZFRDK05pWG1r?=
 =?utf-8?B?S1pSSHNGaFBtQkZaa2xSb1hFa01TU3kveTZKWDhXczRrcG1BT1Q4RkpXS2No?=
 =?utf-8?Q?vnEZSjRqZyuikSqZdc+K7hBmv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d78ad3c-d4ea-4000-6519-08db8d8cecfb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:01.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV1hMIxwM2JrRqMZX7jHCoUPI1mAed3nTcgQqQPk8zKre7scsyFmTKCY4Z+e+uzugRjVzHcL2smdTUkxmVIAQA==
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
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 1846a05210e3..f379ce5b582d 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1163,7 +1163,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	return ret;
 }
 
-static int jz4740_mmc_remove(struct platform_device *pdev)
+static void jz4740_mmc_remove(struct platform_device *pdev)
 {
 	struct jz4740_mmc_host *host = platform_get_drvdata(pdev);
 
@@ -1179,8 +1179,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 		jz4740_mmc_release_dma_channels(host);
 
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 static int jz4740_mmc_suspend(struct device *dev)
@@ -1198,7 +1196,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
-	.remove = jz4740_mmc_remove,
+	.remove_new = jz4740_mmc_remove,
 	.driver = {
 		.name = "jz4740-mmc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

