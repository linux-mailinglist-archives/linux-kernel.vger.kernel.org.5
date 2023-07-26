Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7C7629C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGZEC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjGZEBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:24 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909B91BF2;
        Tue, 25 Jul 2023 21:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emaD7xU43pIwn2+JlF6P9d4QPBlkwx68rAJXSJVnrZzBaVjWo+XLr7UJe+7z6JzgS/v6xwuqrF94j70be5YR/eT/g5DW0BD4qUscbhwxKTPoAxNYxQ33ihG3HXOmXoEDlK92bFQsZY0yxLgucRPcFqoF/0EH253bygkiBJ2nSef3Vrb3y9J4CWWZhEGzuAbOHyQyZ+3oWnCId0p60V/N3oke96tzRFpihiM9m6ge+CjcCWr3//3/j8xdbmXM+Y4n9XLEZPKjln5DgMJh6PU0a/tLDeyTehiSd/zL0rqPt3VP1WNvS8CAVMT/x/K9WUyEtHALOAxaolfnDTy5q+knTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjvydvAOnf9fdqZRVZUVRLRXIIaoxUyvKCR2No+4ygk=;
 b=Jmzzn4oAvglzBUVChj2gvNcdPRy1JmYiqzQUAVmi9PtJGCD1Lz3x7EAnLCZDRJ5gLNk1UR0dc1t6NcfX3dPsCdOcWHcU6yczbNNAeSohdLGwQGPNB+s+lxFsiKxBJRNmkPxHGZR5qgtG8dImhKhfLl6xNbk3d/m9q/qCxayJwnRmo7cWJLAxKl3jLq2h3c3rF0Tzl5ir4feoYuPrWknHyyrrdyRyqa/OsAFnk2Mt7n7e+dJnnbQ5YB6jttCzm8YmQv/nrE49X87RapS6TlYqK9ABmBFjvLX8jZod0DzXIwsDLW9CLqvkI1lt4SZGbdi+s4tfMTVxaVNdtXDPySleRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjvydvAOnf9fdqZRVZUVRLRXIIaoxUyvKCR2No+4ygk=;
 b=Re1h/w6VxQcwZ5ZGuwNZWeiYxlX9BmOkWMgMyl2NPvPHMtEaYEg8KO+6TaGm1A8wSNhNwlSxwoKOCzDeOvMHKI7WZG/4EHVI/WHjk5fdtFI6Ih3uabio7qOVtCkQIXPX7LfXuTbtPmmBb9Smtklr59EzidtGFt3RxT5aEoyF8ptk0kEd9ekU26WolaUje7rwNfbwy2robYdmqlklAlmPd/I/mRP8I6bHaW/YSU4ewd5qKZepQi1jiyghutDayZixyVf/X9fIGTBMme4sx0fcXZUfFFZTdrKJywlbg9UgbWFAJl5Pm7qYuNqoYtIA7uEn3kzDU9OVQdierbEifwq8tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/61] mmc: omap_hsmmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:51 +0800
Message-Id: <20230726040041.26267-11-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: d90d4c21-c888-4d6b-0b94-08db8d8cf5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OPzs28baHS6UGL5nLs0YguIXlTvr8xjlW0RwvZn3I3WFvOw7Qyn5JuTXrYgnAelA4ayzm001/PwbAEZqhy433Y2yDOt7RQKFpnTiCKmNkfGWpGbPIhY7n3YeolT2TnCcK+ARSZXXNhHPTisElxE2q78PVmaN1p1Z/HWZueb5v0ZhXHgUUM7sbWWeEBjNx8Xn3cHHn7EzhRE1awUMkjxAjkl1ynij0bWqzJZB6YpmhQ1qvYdyRIa/Ua2zyF1OOKPeH2UChb/Mv/GmvOY/qkJYXxKnK96qvybo04/do8rA3xpFh8F4zW5St5Dk+Yrrfwo7GbDeLe3fjdtBOZ/JdQ3hVSqoCZT+rRBk9+GDLaVXpvuvANWsrwiqQO2LtotcaLdLQRL79caYWzx/RTVP/pXdr5a7C1AYKzxtlaqopj+lSx3aUmnTkjgCEZo46REg4XoATXGtuCEL3zp0hY/Y4IRQIaLwdSqwhFUCjlaLk4KM0JHABXl+UVL+3I2jvD0nynRFoEEi/+W1zTINx54w1zvq7imXfMFl1B1riD8cpbpzAmMEiJvO4eujHNjmezKcipkUpaplvwV7C+JXKccs0TWcONesHHnga7Q8HOMTMnuEjOMbccDNhZr/9LF3XplIct5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(6486002)(52116002)(54906003)(66476007)(316002)(6916009)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2h4ZGJFTksrNUZCYndSYXVzK09odlEzY1lHekNZUHJZSTl4U0wwMXdUTmFO?=
 =?utf-8?B?OGg3VXdBeUNZV2kvcU5ZRUZYUTZXRUkyWWJvcmFLT21UTkl4ajVWQlFyQWM5?=
 =?utf-8?B?N084YnFxVm5DWXhhTDN6OW1aQ29oa1JiNytpVWpJZ1JQL1pZaEl3ZzJ4a3VU?=
 =?utf-8?B?Zmt4RWNYeFFCRDZlcXl4Vjlnd05YNzZsdko4Tkd5RnlPTUtsMGl3YmlPd1Nr?=
 =?utf-8?B?bkxEUjEyclpxMURIVHpUSGJ1WG9ud0VINU9lMG1tMC9IRnhIaXJhdE55aGhp?=
 =?utf-8?B?US9TK0thWURMTG5ZeTBvN3JxUVByMHBaZ2sycWNUTWVVZ0RQQW5wTjl3MjFX?=
 =?utf-8?B?aWdzMVdWQTRDVmpnMWhGZjl3QnN4Y0NlK2NnV1lIejUzTXUwVDdaSG5RMXRQ?=
 =?utf-8?B?YU03U2dIUHRULzJnRG10cEVpbldEY1ZPTnE1SjVIdnRyaTFPU2JRVWJ4akdV?=
 =?utf-8?B?cGFUK2FNUVh5TGJhL2t4K0lKMDhPeWJrMi9hRWpNeVo4V1BZUDVvMlNva3lm?=
 =?utf-8?B?Qml2cCtJWXgxTWM2RnZLRDU0WEpzOGRPcHF6WENSWUczc3Zrbzc1QWUrL081?=
 =?utf-8?B?a0Rtd0NWd2VnVGhSTktwMFZ2SUJwUGhzOFBETlh2TlZCTkJJUXVVSmhMWEJK?=
 =?utf-8?B?M0VPVzgvZnhwbG4yUU83dDJabHYyT1dJUEpDMkhkUDg1R1NXK2hvVWhEcUU0?=
 =?utf-8?B?UUFKMlBCa2t4ZzVaRDBycHBTMm0xdW5oWmJnZ1VUamxwMEcvTWxESE8vMGJ0?=
 =?utf-8?B?dmZpVmd0d2lSQ2ZvQldRa0ZweVd4T0IraTUvNm0xdmZoSHVNblZNYUM0MzFH?=
 =?utf-8?B?MjIxY0JMZ1Iwczg0Rmd0RTlneUhMUldvREdRNnF5RTB3OEVWTjJrdnhnT1BQ?=
 =?utf-8?B?elY0aEQzVjNtYTlpakFyVy84T0E4NUN2MXpEa1o5cjh3eGFCWW1EbU51WDlx?=
 =?utf-8?B?OUs0a3JLVVlaM3VQYzJmZkhnUHUrRWI3TDJWQWJnTkpUdS82RjlyTFhmekhl?=
 =?utf-8?B?aEJEZ3dMdnhyUUd6eDdHZjNicTFsb3VUTWpkMmZzUWVia3FicWdpa1ByUXly?=
 =?utf-8?B?Y3NuN0p0NU9sdUdCZE1TT2JWRG9Nd01LdStqcnhpUUVNYVRmcFNaUmM2anl2?=
 =?utf-8?B?Y1k5KzBROG5TWDVWbWVpYmluRVJDMXN5SWI3S28wUk52blNwMXkwa0RsUVVn?=
 =?utf-8?B?VUtGVHU1bUU0Z2w3VmRvbW8xSCtjREkxb1Yra3hlQVZKR2pNSTFXM3ZFQ3Nz?=
 =?utf-8?B?bWs5eGI5bjlKV3dsY1p6eEhZYVhOWlNtbEx1QVFGd0twL2JBUW1VOEo0aFc2?=
 =?utf-8?B?bFpjbWRTSFcvWFBnQ1VGa3l2bm9tRG8wYUgxOS81QlNIMmw5YUxYSzVDNytx?=
 =?utf-8?B?VzVEbEZOUGdXQldHbWRwcWQxVWhPejNQRU0xSXQwNE9hV3R5UVIvcEVUV3Mw?=
 =?utf-8?B?SjNvOXJBY2k2eEs0aENCT0JRMkRqTVZ4dHM0TVR0QzNqcTgwS1psamQ0S1Q1?=
 =?utf-8?B?cDRLdlVHQ3p6WXhnSmp2b3FkNFZuWHFrcXlkZTZHa0VjcnQ0WmgwMnp2dHBm?=
 =?utf-8?B?Umgvb1RQQ2FFNDVDR0RVM2RudlBDUG1DWnBudVRWREdiWllpbnZGbmpiNzl4?=
 =?utf-8?B?TFpwc3NqeXJ4Vmd3ci9lN2dqdElMc3pidElVQjVJQkFqbW9lUjhqdmRWbHhG?=
 =?utf-8?B?empZV0hQTlVLM1pYelplUXMrUytuWS9PZFU2dm01Q3poNGxnNXVYS242NDdo?=
 =?utf-8?B?N1lNMEgwWkIvSjBtY2UvbEZEV3NaL216UnJObmZVUFZUNUR3a092U2VtMVFa?=
 =?utf-8?B?V0hLYVF3ZnBQWklWbXVBcS9nMG1RWHg1V0tYazJ5bzFSc1h1ZGpwTC9oVjBT?=
 =?utf-8?B?QnlvU0swME9zOUo1cGMyUnFIem1DQVVVZktGd0pPL3RHSW5jUTBYbUY1dWo5?=
 =?utf-8?B?alV6SWNXOURveCs2bXBBZmN6NE9Ka2JiSkY4bG1zc05Za0lCbnZVYzB6MmVJ?=
 =?utf-8?B?VWVqMDdJYzY5VDVWK083d3k2blFEZm1YcXNhTFZwSEVtdVY5aEpQaWM2Mklo?=
 =?utf-8?B?Sm53MUprWFIrK01WOUk0aWtOc3EyRnVkWUJhZVhuTlRqTmJGUnB0UTZGWWFo?=
 =?utf-8?Q?DbFNcCO1psVNJ5o2l83dMI2Fr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90d4c21-c888-4d6b-0b94-08db8d8cf5c8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:16.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLXouBuCBTwR4mZrrJ5Of5m2rO2mU8Lmkwx5XB62PkQ201pEjqoVQU4sD+fdxbD6Pfkbe2/xme5tWIUUW7tMPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
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
---
 drivers/mmc/host/omap_hsmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 93de00a06aba..e120aeb869b8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1979,7 +1979,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap_hsmmc_remove(struct platform_device *pdev)
+static void omap_hsmmc_remove(struct platform_device *pdev)
 {
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
 
@@ -1997,8 +1997,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->dbclk);
 
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -2123,7 +2121,7 @@ static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 
 static struct platform_driver omap_hsmmc_driver = {
 	.probe		= omap_hsmmc_probe,
-	.remove		= omap_hsmmc_remove,
+	.remove_new	= omap_hsmmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

