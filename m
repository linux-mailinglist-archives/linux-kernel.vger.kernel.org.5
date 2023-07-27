Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2576479B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjG0HET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjG0HD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:03:28 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9F830C7;
        Thu, 27 Jul 2023 00:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuC1FO0Ret9lOmqVwQXOko5Y6k3KxhOYrKE6SYFi6A9SKu6FVCZuv5sWHHbN2WgFetgpBBZR5PxzwulzC8DsEFsaVGemhgE7RnbAm/RoTjgp04FcepQ4xqPmr4bB7iOQNfHmHQV/N6dgyuezvHbth0SBKe99dJrdx3FvdW1Qs1qEeX2jhZ8nKlRyhFy0tBJ2pumE9b97GrgX+z+qj+iqcDwZCmMuZIQSBAM2kspo4HhlxLeLYlp8I9VszaIe6kchaiOz35+dMoPXJvHVFARYTI591ueON8kjrpK76IPW4DK11/hAIiOMVVwrWc7WTFIi0n28Ksc/G+pY5vqWTxjuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2uAnlw9We4maa9XEpusc3P6C5nlTy+13sm4GqQjPDA=;
 b=k1W6bnWpXQdXaviw8799zfMxI0KaNfXZTLJpcTUzOw9AbthCQT2n7nvI3aq0gGSjhkQczq0PJLCwF0QdYwrgqxiScB147VD8C8PPr+6G7XtZo0BXX/e4an8EahoekJ9hEn/b8XoGlRDlBxA+h+rPmuopJGFEkEpPz2q+UDMNMTnJb5Xzj4HAIwljMrBF9w6I+D3IF070t5zpip4Rc3J8UHIhqoZFo8hDd6JPzEzx3JqYbV5cBz9xVbRKPJtP5MnlG8Hq8ZYw3GJWe/pe+XdQxoKAqzztVdu1iJ3lwOif3GJWpTqjQyehDvZhHgyUW1OxMQ60p/gdRbOErAvJpAdiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2uAnlw9We4maa9XEpusc3P6C5nlTy+13sm4GqQjPDA=;
 b=pAjFH8+P3/oel6NZ8kTQSD9NE2XeXcaUZLTAIT91doTyo/1ExFnsWUZXCnEBwFDpc1kM9Xz3btcMJKHJAvgBvl7Ukg29eC6U9lZ4Cpl1zPVWHRRksFizAYA+pbUfsrzKOEyfwkRcFpajGyHTAotQw/yRvJohgX0zEDGPp/587f0l9bdzBvquqErf9gaBJhp7ZN685HhS3e4ISTi5BlQm7W5+FN3SWP/J8rhheVxEdnb81TQmD9mZ9GQdnTKEginuPSeSNXUlCBgLmJnKD7DwivPJeKFWoG9YqqDQB5wsZcWSPwD/3gyHyyiVWs2a4vJfSEwu6U8cIFOjQI0JkMBldQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 30/62] mmc: moxart: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:19 +0800
Message-Id: <20230727070051.17778-30-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 001d4c8f-e187-491a-5979-08db8e6f5a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gz/mbKN+zvSuz1zJS0Fb+W1NYsciMQQuEWuF3HkxnY6PYuOJlS8IRW8YVjSS/vX+zHjC5BzK2E6WtqcGng5NYPG+RcKV14mJ5NsgrGYYXJOwmqXV7yh3md3sL/3EIfNs5i4Gk4efmgGbXYjnu6DFysh2rbLB0Glr8Dy5XnbiKqZLae5pF/vd7WO/HHnmaVdMKhNCBb1YFsSLIXJCc1tdWKLWWRU4mIQdDzyS4z9RsHYUr4ymEPzRPOF8xMwX+VgFagFmsT+99nAy5qZNWVYzAQVvC59ioGsBombN/obKGH5sXcgWYtb+DjQ/4CED+avhQuyTRXbSZF1PLZ6J3X8ifhbSPlX5towFH27A4OosVVbgeeWBZH2QHSoVVXxjxtsCxz1cM1+mKPJiVbD+ldF1BH97TO8A1M4b4zxRdJei4mqOLDhjVJEyWq2y6qq7tgzz9IAOxuIZRaZYgvGKEbOA4ypBchSqCdMzUDqs6HzwVDXc5NZiQQFdHyN+lYvf74JCQeOASszqosJ3D4NtoNn2XEBJdEI6PLpYf72LsyLCq7GkTPiJ/cT5q6JuiYJS0kMoANHyfgAzWOjJi5etDePma2NwLHJSiuujTz7l5gqe1xRYBCfHloFtiqKC5lsbTWlG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(6916009)(8936002)(52116002)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THBtS3VSMEovVmhyMnlHNjlYcTh4NWdSS05IQUZ1eVRqd2JFenhlMHlqYmJQ?=
 =?utf-8?B?MGdIUyt1eUczRFgzY1YzRzVMNzU3M2g4Y0JhUkN2Rk56aE5JdmpsRGRzcTdD?=
 =?utf-8?B?d010aU9KTXJ4QUM5VC9ZQ3d1YmNYbmJyOWMrR1NHN3E3RkwvMzEvaTFNTGJT?=
 =?utf-8?B?ZWhpRE1ReWtrT2gvcldoZFc1d2V1bEVPNEJML0RFMndBSXNHclp3Zm5oV2hj?=
 =?utf-8?B?YTZOcGZBZmxOMWI0YTI3eXV1NGhsMUdQcHRyOXNhQnhnNFZrN0RQbmdVT25S?=
 =?utf-8?B?L1gvK2w3eHc3VjliTlZGcE9DbWEyajR1NFlBZzRXckhvTEFsc0w2UWsrTFJm?=
 =?utf-8?B?bldVRlQ2MU9DY0lVQTdWNmJxMlo2eU5hUldleVlUd3JmYUtmdDVJQkZYcUNk?=
 =?utf-8?B?ZHAycldMOVBJd2V0V2tya2tmR2NuTHNhbWRMYlhjeUlON01QNlJOVzB3Wmhj?=
 =?utf-8?B?YzRYcGs0WjVYVHRpM21scERZV2JKRXV0anh5UC9EM0VHSzBXdXJRT0I5TWxF?=
 =?utf-8?B?cXZZbGFobWhXTFNtcTFrTGtRenZ5RGtmOHNHSjhZVFlEbmlrSmEzc05IbDlF?=
 =?utf-8?B?V2dYemluSEM3TFVpY0xUaEt1STNQd1Y2cGxwOC9BTTh6bVVlMTBTSUlqUnVk?=
 =?utf-8?B?eGNRYkFjNWVMeWY1YVBWUzBzaEI2WFpjWnMrWDE4ZHhMTVkzR2FvNXAyQWlm?=
 =?utf-8?B?WDF0Skl3YmtkM2t6VS9iWHNGSllMeWhScHhSZ05KZXhBdGFhWXpzNjlvaFdn?=
 =?utf-8?B?eHlrSDI3Sk1sdTRUVUFVdzY2K2FiZEJJRC9FNXBqdzE0UCtTU2pXbW0xQ083?=
 =?utf-8?B?SU9EZW5jTTJlVFM3SnM5WndjZUFqVlpiVjBBK1ZiUm0vTHdDZG5UYnpnT0tm?=
 =?utf-8?B?YzVyNDBodjF3OURKTFNYOUcwNjhLRnk5a2V3em9UNmMzK1k4RmxJK0tjRHRN?=
 =?utf-8?B?U09ZVGdpc2MvMCtlQ0hkdU1VMSs5L2I1eDRYaTZMSHJOdVdta0JvVzJweE50?=
 =?utf-8?B?SDNwY2RsTkIyc1ZobUFJNVNya21nOEROdzRHQ2NCbXVuNFlYbWZZNDBqYXpG?=
 =?utf-8?B?R2hWWWUyb3hHKzRaS1ZhRGJ6bURWZlZqNHFYMENFMEx0OUdvWlE4ZWVSUS9U?=
 =?utf-8?B?T2I5YUtkSUY3UzhYbVJuVzNoNXpxTXFRMG9YRFZ2djY1OERXT3dsT2U5MDBM?=
 =?utf-8?B?VGN2K00vc1B4RUlDcXk2dW9lQUY0d2U1ZHd4RGZEbVUvRjZPR2JGOVBPODRU?=
 =?utf-8?B?YUEwTnlGSGNKTHgvaWRLeEozQVJYZVFBTzNwbUlTajNKbXQ3RWhuYlFEVlB5?=
 =?utf-8?B?K0czR2lrMXhYSXRKWkpUdFZPOFZRWmErdG1sbXU2TzRyRG9MczFqRXZvUHlw?=
 =?utf-8?B?ei9sSHlRamlEQTFTa0NBb3BuTlVKUklRbTRGby9nVGJRdW5zZXlneGovM3NT?=
 =?utf-8?B?cUJaZUpLVlJYYzhvMVhqNGVyNkpaQzdaMkJqVTB6eUVBMW15bC81TzVGMlRB?=
 =?utf-8?B?ZnpqQTNtdnFCcXBaQy82ckgzMGxxRVRYRXpFeWt0c0NpVlhGdWc4MXpFK2VZ?=
 =?utf-8?B?OHBPdkdQajlZQmdIbVB4dnBuOEJIc1FuQ3QvbTg4TWdXUUNaSWtPRjZKRlFK?=
 =?utf-8?B?R0xBTEN3THFaQkN1aE5yTEdlbW92aFpWMzFKeDhCUVBxK2hEdG1odTM1Rklv?=
 =?utf-8?B?RXcwZ2hONXFaUG1JYnl4ZWxzczIyekZDeVNzM1pjQURKeFBWTyt2eEFESzBq?=
 =?utf-8?B?QXRlaHczOFRDdnFjcHVKdzFuSXpRbS9FQjlvRFo1WVNQYzVKcFhOdWJKNStU?=
 =?utf-8?B?TGxYamUyWFMvbEZTT3JMRUR4UXRqRSt4WTArNmhsMEJWU211QUJIYkFGNnk2?=
 =?utf-8?B?d3Bnb1hZclBnOTlYSThvT3V0M21yQ0lRSHppTG9YQWs3N3R0ZTJkZUgza2NW?=
 =?utf-8?B?WmxGc1Nzd2JpVjhSM1lTVXpMQ3h4am1XQ1R5Y2xPbS9NSjdoYUZTaGdMQmFH?=
 =?utf-8?B?TTZrY1pNS2hJNTY0VC9RZ2Vua3MrQnVOTk5zWkRzanZkcjVQS1d3K2ZiRDNR?=
 =?utf-8?B?UlZ4ZTgrdGlqSGxiN1AzeU9JTWpLeXBqeW5jS3kxU0Y1REcvWGp6cjJNMVJ1?=
 =?utf-8?Q?UOjQicfYAX7E3TnWrbeW4esw6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001d4c8f-e187-491a-5979-08db8e6f5a97
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:51.6428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt6FO/RlOuij37/JjV9biHkM/1iYUqm/MJMpzPOm5by+55pn7rfg6IupYkJ7bIb9u0fPCpak7e/cpUgc+ZtxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
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
 drivers/mmc/host/moxart-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index d0d6ffcf78d4..6673b95747cd 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -687,7 +687,7 @@ static int moxart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int moxart_remove(struct platform_device *pdev)
+static void moxart_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
 	struct moxart_host *host = mmc_priv(mmc);
@@ -705,8 +705,6 @@ static int moxart_remove(struct platform_device *pdev)
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id moxart_mmc_match[] = {
@@ -718,7 +716,7 @@ MODULE_DEVICE_TABLE(of, moxart_mmc_match);
 
 static struct platform_driver moxart_mmc_driver = {
 	.probe      = moxart_probe,
-	.remove     = moxart_remove,
+	.remove_new = moxart_remove,
 	.driver     = {
 		.name		= "mmc-moxart",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

