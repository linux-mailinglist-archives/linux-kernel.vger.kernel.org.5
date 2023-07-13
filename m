Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C42751B59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjGMIPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjGMINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE2030FD;
        Thu, 13 Jul 2023 01:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmqHDE4KgX4HWN8N2mtjFJ84ngQY3HGiVNWIgmQwt4qGIvD0hkmdCO3ZyqZ51N5xHQEBZAJ4CaN+gA+VRcowN3e6UAK1pE5gDseUkBuh9UK/7GIC150L5JkAx6vZ+97EbYKpT4a2VAtCtMRDtcZCkdfBN+qAmw1yktK66+IVEyfjVzI5prO862apF9kOI84W/eyvIvET6nLN4YGf20RHoosFlKToFoz/4/c0zRN5eGVEOensPd26yhEhYx+EAyTjdo+ZtkupPIUBt+7ZPsbeoU1eChpaKC3LkHxR/bVUPCYBD0Qzu77fLvQoby6z0v5DiR6+ZJHJxGsAPE8zdRuCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSVSY0tmOM4h4fHb2UFkj/zeTOsEVDjfwp+nRZtPSG8=;
 b=K9HAXPoJwFt90Gqw8u7P1tj8KQFWGHmCCj+os1w78q5KwBxxCLD8Z8EBJx3rms2UN7PrBBdBCNIpyxRxJNLxOtBSc/RSoGwY6zV/XtCNcAQBuazo8f6DX+37MQayLGL7xQFo5x10+/LaFjjajCxBsYZ24vcT1/hbCpjHQ8S95EstpHr3CNdmo/4nhozAjRy85aSie5wtfM3QcfRiJJoi6YlZM15UDDuJlbotZ9DLStV4MlAy7gpuGFQGeK0FQ/VRVNKarGuDG1r3aZc3PW3HWtF9G369mvlmE482ORPGgfpeN4JtyQljijxbuqPj0yM5jeZe653pZ11iQiI0y/Dl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSVSY0tmOM4h4fHb2UFkj/zeTOsEVDjfwp+nRZtPSG8=;
 b=jGEVR4JhSArKKp7YpaSBJZz3egQBLceO00GZOvrjAkpHibCCy5+7FFtmAc7KvOU+Z5G/VX+WcX7h992KOsDtyJMXkfypDgjM3phYnzycnuzhKHVx8m5wPkQUcygxLppfUQ/oOYaM8za13kYqMIKHjJ6kVa7fUDNuxrxLI+LMaY9vqWDIYlfJbK6w4XMZIKHuayt88jheQA23gZMXgZIWZ41aXEQ3BGS+1HqvAS4xd14uiUmwIWSIFn5SOqlDOUPSdLcT6Brzas+3jCKkEddzSy3Qh3BK7V+QdlLBqtwCOgQ8lQmEy8Dbw/ZtVmypO6wNpfJ283Isw6f5pTXMYw7QZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 55/58] mmc: pwrseq: sd8787: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:08:04 +0800
Message-Id: <20230713080807.69999-55-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c93b580-a866-4199-cfcc-08db83788c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGuwkwYYMfYCsnCQw6g94pV14j18hdvN0sapPP0998AxNU+1jRgci5zlOp+n+WQckFaUBK2PPoxk/4jTsA3EujA4YlbvQSXaKbxM6f+9KDT9MCMQZ2yPt/m3c+Kc2tDmjYavj4cd4FiXaEUQEKeY7ev1nxNHdTH+Nqj/jZwcdELLcuK7TVkOE/85JMVxI0XBKwsUUC1845bYWwn7YHf7EcVAtvMVfDDxIWBRWq/qNy3oktUCoavrF6MpNaJjT8bFylpIrct64SzvfdAVPki0m2dgiV1Iw2h4A9j2uu6SZ7kRqO6FJrRV44CPXeBppt2P/YWTQzuc22RBLihreamWVSJtIyrdRxgjXISIa11k//0CmArQOpJH9CAOa00JcCk10hTXtz0X479nfPh/9IZnOxTy+fvQL4Z5myEfOaYbEw9oy+oLcND8cT68dcasKYq1419UJzQbTcS2ySjX7Kt2YDBnIz5UAdNVAPbgPP0Es3u+esiwVWOyokVbPBRNVyp/VCaafSURN2+H8OjyGBSlOSA2eKTjyufVtKAqk4dLjdwgR93c86U1XUOuv9njZvCM8AhPz3ppdk1qP+PV/8wBlkuCHkPGTBYLkk7SmdyjuJfmxeqTsIhsNZwCQUv50Ice
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(6916009)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWxhOGszN3IvQTJoZE5oVWxTbEIyenZGMGlTa1RmK2lRakFRc01CNDhYKzNU?=
 =?utf-8?B?WUpmdEJlTXR6UFZ3YWpjZ1dpbk4xZzBTR1NFay9oa2FuRWxSRWlYOFFEWlF2?=
 =?utf-8?B?QmNVcHFYSWVQNThVUG9CUGRBYklmSC9JQWhoVGxtQktuQzAxaWgxZi9MT01a?=
 =?utf-8?B?NFpXWlNTSjFZMk1aWithUDI3bU9rc2ZacVZ0NExXdG1LZUpMNG15bmFoVSsr?=
 =?utf-8?B?SGYvakVDQVVPOENCa1EzUEp3cVIzMXNOUFdCU1NjdUZvS2xLWHRhMHJFSzhw?=
 =?utf-8?B?Yk1mYzEvQTNkQmpvM0EyTmVaeFozeSt2aWQ4TXlXUExhZUd4enV6dExDYkxi?=
 =?utf-8?B?amh6QldtUVlHaUdEY1Z2ekY5TUtGRVlnSzR5K0gzSEd2Vm9rL2NyZUxhVnhL?=
 =?utf-8?B?UjBiY1M0bmxwS0RCbCt5OWJrNVVMRWtHODY2YU9CSStRbjFaNGk2dUhkb3NP?=
 =?utf-8?B?b29wZllYQkowbmd6azlyUVczZHVxaFlxRlpIYXZJRi81aDRyeHdyTHFpa1U5?=
 =?utf-8?B?M1ozdjZTUjZ2aTJJRFJzeWx3UVRrNlIyQ0lwSnd0bXB3RUdwUTB0bE0xWWJ1?=
 =?utf-8?B?dWhGN1k4c0xTaUJldUZDcEVyQUdmRGRobHhtQ3I5bnMrT0g0RVFlQ2M0MnUv?=
 =?utf-8?B?VUQ2NTR4VXFhdVZtVHhieEsvWUVENjFwNnVKMm9hU0IvOUo4aSs0OVhRaDk5?=
 =?utf-8?B?dFFZU09mLzBxMWhib1RDcVY4bnQyZXg4a2ZpVFlDWGdNZW91dHF6MUdXZ0RD?=
 =?utf-8?B?MldiTkRUV0NwNTlGM0JpNlo3Z1JNSGNRR3NBUWVyWVdQeDRnaGxHVlBWbEd4?=
 =?utf-8?B?ZjJRSTV0Z09yZVlPSitPLzR5dHBjSCsyMFlxa0xOL2thQ1hjUURGRmhmSlVU?=
 =?utf-8?B?RG5XZU9TWTVqQ2xiSEFma3lOL3hZeUE4WGdmeFMzWmhvQ2hTOE9QaEpiOFFw?=
 =?utf-8?B?R3plNmwrSEFHSFBrK1FUT3Nhb01kZTRCTEJDbmFZNHF5cDFiRjNHTDEycks3?=
 =?utf-8?B?QWVWLzRETlVDVDh4L2c0SFZaTkVjajNlQ2VFMS9UeS9vNkQyd1lwTlRTMVZH?=
 =?utf-8?B?VjJBaDNUYVZKanlzRkNIc2hVUDl5d1pOcGlISjQ3MXRhbGFxTCthQWQwS2s5?=
 =?utf-8?B?M0FvWGVNNTQ0cHZQVHJiQUdZczgwZ0Z1TDB2OG5nTGdwZ290R2E2R0V4VW1x?=
 =?utf-8?B?cmtoMklGbkhTMWt6N1gwNzVSN0UwbXBJUnRkaHZFQXlFQzJXTE5ZQ0xheFUv?=
 =?utf-8?B?Q09KRzczKzVkSkhoZ1dDeDN5K0M4ZlBDMk9ibTJ1QTNOT1FTNzEzenRGYmRx?=
 =?utf-8?B?b25WNjJSV05UVzZ6VU5HMURXdnAzT2cxNERnWHJNYW5wc294dHV2eGlXdXpK?=
 =?utf-8?B?US9jOXpkTGh3M2tOL0FjTGJWL3dIa3J6M25VQ21UbjQzT3lIVDJCa0tEaGky?=
 =?utf-8?B?RTlPNi9lTnJsWnl2c1Nud0lybkJUMGtGWjJWaFhoUzZkUWlRbFFnZlhQNVRy?=
 =?utf-8?B?MlFMdzRxc2ZxZ3dSTEZVY1dVUHdlb2l1Y2JVSGtwYzFuM2YxSW5aUVpzUVUr?=
 =?utf-8?B?bUE2aldWQ3ZJckZBeUdoc25KR0Z0WHE3MkZLaGtpSHRFdGVIODBWUlZRRHNv?=
 =?utf-8?B?R2UyU0tFazg2em5HUHpRYnVmMitReWZ4cGxFYU5nZGZvMWUwR0I0QS9NYkN5?=
 =?utf-8?B?d3FRbWtmUUxWN2draDhQQi9seGlmS0tyLzdpNmNuRmhyR0tvVzhRR2NCS1ZH?=
 =?utf-8?B?eW04TW1jWmRld1FOd3ZXb3pjdEVzQWhKVUNodURFNFhQTlpzZ3M1K2FOM3hE?=
 =?utf-8?B?cUVQUjA1KzVQTFlCR1FYNlQ2dHI0cVpXdGtwQ3JzbnVTTXZiZ2VxNzlndnNy?=
 =?utf-8?B?Y1pqVHFuaWZFZWh2dXhzTnIzYW4yQmJJejF6cERGV0ZVY3A2bDF0c3UvU1FT?=
 =?utf-8?B?TzZVWU8wbzFUT1BUa1NqTFhqczA4WE1yY1lTaUVocG5YN25kT0t6WlY4YUNy?=
 =?utf-8?B?UVBITjdvL3hrOTlpQ2pTbGI3cHcycmRwQTdLQTBXSFdBU0VYRHNua201L29a?=
 =?utf-8?B?TldyWExmK0VNWXFqd2RqbjJYei9BRmFJR3ZlNlRBQzZwQXl4L0hDTWgwdTFo?=
 =?utf-8?Q?fuGRNYvSnkLWlDE3s51eBuUH9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c93b580-a866-4199-cfcc-08db83788c19
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:57.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Czk01kq7GZ+A60rU/4OmNn22KHDXnzfKkEfjt90R5EEAUa+aZKSJsqG06pcSeZ7XQYfm7hmHloXJhl907FrlsQ==
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
 drivers/mmc/core/pwrseq_sd8787.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
index 0c5f5e371e1f..0c5808fc3206 100644
--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -113,18 +113,16 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
 
-static int mmc_pwrseq_sd8787_remove(struct platform_device *pdev)
+static void mmc_pwrseq_sd8787_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_sd8787 *pwrseq = platform_get_drvdata(pdev);
 
 	mmc_pwrseq_unregister(&pwrseq->pwrseq);
-
-	return 0;
 }
 
 static struct platform_driver mmc_pwrseq_sd8787_driver = {
 	.probe = mmc_pwrseq_sd8787_probe,
-	.remove = mmc_pwrseq_sd8787_remove,
+	.remove_new = mmc_pwrseq_sd8787_remove,
 	.driver = {
 		.name = "pwrseq_sd8787",
 		.of_match_table = mmc_pwrseq_sd8787_of_match,
-- 
2.39.0

