Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E07776477A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjG0HBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjG0HBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:18 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A58268B;
        Thu, 27 Jul 2023 00:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQP/RTkGo7KbEUeRfuPlqsM0ugp4OCR6FKxgjzET3gP+/7JksPK97skLGKa2Ih3znlKPCeCAaytaYtzEQmcNVfah7QTZXhm8Hf1Y9e1QD5+PbQHIGQ3dSNTe2KkwRdWcX52vjJlnZNM3d1wX++rn/EphNHv3XuaZgJE/QgjPEbOJNx8xTRbZgpxl9F8xtCDfVWrVQ2b2q1poqLq01mTcNhr5BxLtohM1PHOqEL451HMUqjBsLV/knA8IkFIAqD78CNqVibWdluI2aiQ6U8Y1qCrhQmm0lnyypSMOWQUU34B37NMI6OsoEGUlKTXgGUuDNcAaVY8KvlFoA85DGO34aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO/T/iqSahPS1fYBVSCrfdexxtG7yArNkbxS9PglIXI=;
 b=bA8AjvynDULvDsz6KZaJ2XhLENaJ1uyFl91T2vjUxDZoNd8XefsW0cGmo8ncsUtQ3LQ2YL8t9nDbHAIys23oE/aJ+QcbPGnOYBHwYWBNRclNhE9VqDk+i56i21QvMXGUtoPkPXQhzW7fe0c/plqT3LcjvI5l8jnjIXdxo9kjKtoWkud8+56IZMcu1vY7yvAXTIJIOEqmhFWOgp6YqCZh212D+lcJtjPD0a70IbCRCoYHztIoMyy1NdQsn/vzGnCQOkzBIPo75tRxykbUfibk+H9/kljj6s30RVZ7GymNtL4rSvQLhDK/JtV2LjDAlfGejqS8cdcizYAFwZK0G+Ff7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO/T/iqSahPS1fYBVSCrfdexxtG7yArNkbxS9PglIXI=;
 b=NQkBog9NL8GmejYk8svz5s65swDEuDuo+qbOlV2vHZaRs43uwcPoktfH31ioaWuwb7FeGURAC9m7LF3ftJ7CfzIMPAYgpH9zWvxWa21vWgUyoZ/Xd6LONUoGuK77vde4vRV/ezU6Lak954jZedAlr0kWggU7F0pcGH06KLDL2uDW7sendWbEE4H+F3bQo1Z8JNyVIWS0Vjx5EC6pXcOMVc8vWIyLmHCMAobYVNS72WJokclWfczPkiNUvIIVgXhqn8v7hPSDHd4yKlEVzX+FVT5CMuAlsJxV/s674DE6AooRC0etgAu706SZrHh9rErLudwywkgLGzEbIm07BMws7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/62] mmc: cb710: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:55 +0800
Message-Id: <20230727070051.17778-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
References: <20230727070051.17778-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b16ede6-6950-489f-c588-08db8e6f4335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iae5BqMxTaO6TRR4Wlvl7uSeHnXg7Tg37b7XCyOV4Qh/AArj59jFzW7iKauinnOQO8d4hOBTLr2R5qqcPZFxuterIGO7/Z2MM2wmebV1I/A3ZP0La+tTNCPDMomFhp0hsCIXCZQZ3zkcfPqUJavVH8fGF8wQeVcC3c+nlClwlbj7aFNz5x6MeI7WM0iAa0rYd1CRj6+6/mgV2H9rTaU1r5iolAmSBq5nWjFy8l/OfPdECfOuxhl4pj4HOHYgZnNav5T9x6H7Wct+Kd9O/U24rEKzZMz1oP5fyjU42xdoOGoEsPgjaWovw5PSaLpUAoJdoo8AbEd4GbR7nYdMmk/O31aV9ttWu/uiLMFPOkpVfQQe9/2E8UcjJwQ1QK16anxQDE7SOL1ADRuqv7qkBx4P2I1y4GVTcG8CpZa58ZyigKDG00VVopGl0CsHlENtKOoaFf4ma69XS//38wwapcbvFCt14by2ggOMUqnAsz3g7k3M6k23QN2INjENP/bb56Vw8gf7DvQGMahzcfQHBFzNSF/yRf+ii00sr4Y+32YKvlNJoyQk4Zm5b/rk8YZPxcQlBAYMokZcepcZ/XmYs4PfUgBteh2Z9HREQAr+wakYwnKWYBZfPUtUmpD6bARnJx4a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(66574015)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymk4aWdwQktyQ3ovalcwU2pieFVIOUNERnRTMmpLKzEyd0VXYXZZTzBucWlW?=
 =?utf-8?B?UDIwa1RYUWQyeXZaYlBhMHpZMTMxeDBjT2hXd2FMemlQdTZvb2xONEpkbVJh?=
 =?utf-8?B?dENWRk9kdDFmT0hiQ0FYOHNibU5UQnZHdTRrRE5mcnc2eHlnT1RjVEpBN2xk?=
 =?utf-8?B?ZllHWXgxb0V6UnFJSFlpdTBJb2JpK1NabW1sY3ZVVkRRZGNXVkpXSjFLTUJV?=
 =?utf-8?B?RDVCWE1HeEY2Y0xITisrYWFGdWt0azZFT2plMjFFWVRFVHFJQUFMMWZGckY1?=
 =?utf-8?B?dFNDSTRxdXozZXJlZFNNSFVoTkJ5N1dDQjNBQXVwa01YNjR2SC93dEJxSjBM?=
 =?utf-8?B?WUwrQ1lWZDZ6cnhnY2hwM3M4SlhPTFRhS1g0SU03M2dYMXlmWHFCQnlkRUln?=
 =?utf-8?B?QVNWRytMUFd3NHM0dngwN1ZNQW0wWnFVc1RoczZuQ1BUNjVBRE5yOURZb0Mv?=
 =?utf-8?B?TnJ0S1RDTUFNL3REcVp0M3hVU0c4MmNIa3JzY2dXaDRSVHdqOThCcC9FMlVK?=
 =?utf-8?B?dXV3cmtMck5PbkhRY3pQOEZVMTE1cUhWdmVBY0l1dGQ2dEFVV2gwc2VQSEhO?=
 =?utf-8?B?UDJtQjdSbGFhVk56K3JIOUdmU2Q3TzRSSFNOTGdoYlVqVmw0NEJlYk5oOGRO?=
 =?utf-8?B?NXRqc0lmbUR3a0grdVZuOGNsejNZT09oOGhJKytUOGhFRlMwTVh4YW8vUVlW?=
 =?utf-8?B?SXhDUG4yV2JFZ1JHZUhQancvVTVpM05JOTE5YkRkWjNtL3UvaHRTaFF0UWN5?=
 =?utf-8?B?NWRCYzZMR0J4ZkRjdjdWRG1MQVlzWS9Pa0w2UDFuZ2JUcW1BMXJkQlZnK2FU?=
 =?utf-8?B?dnE5cDJua0s5bGxEazNibW5rTXVtZ3E4cEZlV2FsMVBhZDU5R2tIRC9zaGZ3?=
 =?utf-8?B?UjhWYmgzRFkzeDBCaWhRZUsxQitDL2lvRmY3REUrcjUvaEN3b3RjUXNUNWRp?=
 =?utf-8?B?NzR0TW42TDJEWGZuWm9xWjZqSVZWRTdDNzlUVmEvOWVIYlhXZUl1WXdIMHB2?=
 =?utf-8?B?OW9Gc3NNNU1qZWs1VU1NNVM0djR3cTZHM0pkMzJ3dDBPcmt6T2d0QUVXOWlJ?=
 =?utf-8?B?dGxzSnhORitITzFEK0s5SzludEVoOVRDaFRNOHp4NE9NcVJOekVTb01kTkda?=
 =?utf-8?B?cG1lbTVXTmMyMzRZNHh4N0dHNmZ1K1FiMlJaMlczTTZpd0dTRGRUOGYzblc2?=
 =?utf-8?B?bCt2QnRQdFRWK2pZeGVTSHRac3hQN2tuSktqNTZ4VjNMcGV3RExKSUd3Szll?=
 =?utf-8?B?NCs1YjY2MlQxUHMzWnF2bTlVeEhBc0NMZGptc3ZLZExEbm5uNC8wVitHSVdP?=
 =?utf-8?B?UXdUZ1ZHaWdObW5hQmtUZnVVSUx4ejNHTkNTZVNRL3EzWGNLQVBGTVhOQjNT?=
 =?utf-8?B?QUZWcWNLUCs2S3NUN3BxcGU2NnFoRmZDMHc2bUh6TjJXSEQzMTBoYjZVNTJT?=
 =?utf-8?B?bzhtVzZ2b0E0OHlOcllmVUNkS3N1alhuYlBibk5GUHgwRXBJN0xlcHhxcEtN?=
 =?utf-8?B?MGI0Z08rVHB0bUdkbEFZcHZjaUNKaW9uNjVnWDIvVnppam54RU0rSmk5Z1lV?=
 =?utf-8?B?WHFrWmNlekxYTlFycDQxWjFmeHQ4S2hDMzY5N053MmxQTXZrN1htcVY1OFEx?=
 =?utf-8?B?aTN4WUFmS2w5eWdIQXRXZmpRYlB2TFVTZ3lqbUU5SjRGV29zRmZTNHhkU2Fo?=
 =?utf-8?B?ZFZRS05xWGFQb3EzYWZIYXo3WjVkNzhiYjh1ZjZuUEFIUTNhRXpPVExGRVd1?=
 =?utf-8?B?L0tnb1dRTXdtd291Z0xxK2pEY1R0bFdtbHpHQWlDd3Rwc2hhMW95dTZpUHJv?=
 =?utf-8?B?VHMxa2UvN1k4cjkxT3FpRzV4d2ZuUjZLQkxORmxsNUhGaVdMVmViMEJpRE0w?=
 =?utf-8?B?M3FjRHdhQVFiVGc4bG9iS2xUTk1mNDNCTEJjWWl2ZiszNkVRSC9ERVJ3eEV5?=
 =?utf-8?B?Wk1pVzdEMldQVmZkMlp4R3JJNytSckZlUTBRejVUN0hHZGNpSDhWdjVtNGNQ?=
 =?utf-8?B?anNSWmN4Qm9MUm1Jak9IalpnVFdrY3UrclJEK2tqZ1hNL2N5MFllUUlsbnlq?=
 =?utf-8?B?REpBQ0ZNajFSYjcyd2t5R21Xc2NKTnAzUjRGLzJkZGluM3BQUU9lMUdJRHFh?=
 =?utf-8?Q?pau6IRdY6auAFn3gM0Gnq8itD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b16ede6-6950-489f-c588-08db8e6f4335
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:12.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFH4Ij4vjc8vtMqnGXfx4OOcG7ddD/3kEyBe25rN4m4ZWlw6jIouVWsV8IMYpi0t4s1hjXPv+lVYwLkZCKO9XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/cb710-mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 6d623b2681c3..0aec33b88bef 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -745,7 +745,7 @@ static int cb710_mmc_init(struct platform_device *pdev)
 	return err;
 }
 
-static int cb710_mmc_exit(struct platform_device *pdev)
+static void cb710_mmc_exit(struct platform_device *pdev)
 {
 	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
 	struct mmc_host *mmc = cb710_slot_to_mmc(slot);
@@ -766,13 +766,12 @@ static int cb710_mmc_exit(struct platform_device *pdev)
 	tasklet_kill(&reader->finish_req_tasklet);
 
 	mmc_free_host(mmc);
-	return 0;
 }
 
 static struct platform_driver cb710_mmc_driver = {
 	.driver.name = "cb710-mmc",
 	.probe = cb710_mmc_init,
-	.remove = cb710_mmc_exit,
+	.remove_new = cb710_mmc_exit,
 #ifdef CONFIG_PM
 	.suspend = cb710_mmc_suspend,
 	.resume = cb710_mmc_resume,
-- 
2.39.0

