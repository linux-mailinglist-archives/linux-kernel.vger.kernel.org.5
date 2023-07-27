Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66957647E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjG0HIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjG0HHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:07:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91D421F;
        Thu, 27 Jul 2023 00:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdMpu7/1Vo3J2bet4cJKHrcaLz00BozX2r+vUTbDZ2WTjZh1nPYAqZsn4SJLfYvv+iXnkyBcr/dr7M5B1UYDfUkfPkItmKt7WeQdaoWv3k+OhaxggND8KIJ1aEdxLfWzBuusw5W+xFNEbW3Oe6bM7mqmWeuw0XDuzIvGLW5bgYrWapl+LIsiz+3MSXVVapSssrBi0c1flxKn7VZLooDs6PQ+3prDO+2RVsaNGged0fQb4yizDQAaaYgzPHJJBq1vyGAQTpQAwhYmdPizPth8UBoCgq+mguBnb20q7dkaPNP3Xl3NsmMHZVEh31cxQuz2OnK0SmS/S3dyMjFKoc+UBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSWnsNd35kiXhc7HW4zXFBezZKYWnpvDY+cv2Mi5G1U=;
 b=RBPpy8YPSKIOy+lZsxBvGHoztLCSaKqst38YYodkE7wgPbMC+E3x16SYqQmA4p7itmQWHqLeeGzGpPc+T4Jzt/m0Bbd01doYQCGejgxVvDXxnVe6EYzLwFTDwmXebMfNsER5CwgzZ7TgJ+in9eLUInvw2zu5PsGWJ3rvlvOXOi7gVtueEiXMzfDJC5ENEuqsbUGkxp84+4qkn2bxI2IwpLCyQFOZB2ouhhDu07xooNUtJJ+SLbgZF7pMmWbXtkrFGcuHCZ+gqQlhqhAdpebr3POecDlvb64jzJJbY2OhOGH7Jikcp/4AoJFqldcqgjDxHWNxTVMHoIiD8/3gelghYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSWnsNd35kiXhc7HW4zXFBezZKYWnpvDY+cv2Mi5G1U=;
 b=PcNHUFsdriGLO2L9WjhTQrSrdnLUKa9JhqOZqB9+srnTrL26io50Dqlrh7+7oUrzC0mdfA+5LewTyzKY2W1SuRVcoa4vzxWRNJWrtOfDOK5QJ+A5yl6xPNwGQJ8htDXJDuFidO1BlXUSPYFNp/ag6M514Nqfn1PAlFmuCizUPIuZEX/VcS8CPXGLhHLjpSeyNiYzazJDAxMK8BnumcNof0jtsiN81NlJwZYtgBQUw6yaUqQcR8U9oYPGOjkpPQngL5skXnS/ytccEkkJaCR1STlFh48wjjdQdzi83HVfKIbU1hIfWqIdUx0fN3ExHIWr6ixn20rIJVX1GBbFpt6J/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:41 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 45/62] mmc: atmel-mci: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:34 +0800
Message-Id: <20230727070051.17778-45-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: b105bba4-5434-418c-9566-08db8e6f6af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Y/vM+abh0U6LcXQosZ+/PIZmt70CaZiVtG23gssbaDqsvFu9ZmSDtcnIJ6EQVlQiwinbLbZAxbiMLjSoLrzoZGKsI4nXkT40W+6pBzl6IaNFwfez0MjJ0gzGrH186vjWm9ybJ4LmGO9zohTAbkNun8vynfJDJd37jRAK8YhDJhdU44k9+DPF7hWwKIb638HO13Z6LAkw7E+bbf/Tel65pMNqHh6S11i33WfBmHr+pLh9DVHaZKhjjDvLrRJmONia9t9cpKqUFIz+qy0VKZDkdlAM2X9n4mCbg8fbSCg//hpanD6fYF3DrXaxOYLfZ3vans0VgisFj8rKCPt7u61k10710vgOtvbpKL/usII3PFipPoZ7aoPg891aREfx0L5+gLoP+IeaV0eriJOreHXVD9Y/g+ktNX0LZ4Ry7ZbVKCpoJJBbteGQ7HfhZlPIRw6OIxYRJ3ZdZoQXLkWC61CYh1S46USWKc5yOfuLNnCMC3eQ/IwPEjmchCBPJCWfir6ppYFSxOA/IEOdYszm9OHYi4uFHIC2wf+IjLEA1KW6YNHFu/WLYNSLkJR9ajQxsG315xZOAHQT1H5/KN8k3iTwMQZHX5f96iK04vjLT90lx6EVo49Kj8/OINduStv90s+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(7416002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklQdHEvZjA4QjlyZ1JKL1pPeTZJRHlwVnhQU1p3OVpyeTlXNUh5Z1hicnBY?=
 =?utf-8?B?ZGNPWm9WUDlDRjU0czA0aGhaQnV2eHJqSC9BM3lFQ1dTcmhhWXhnYW9mT1hJ?=
 =?utf-8?B?Rkl1ZUxpNUpjcGlBWk16di9INTgzZ00rTkE1Y3U5SlYwNFZYcElQekNxMjcr?=
 =?utf-8?B?ekhZUkp1SjVUdjgreHJrZ0ZMTjFKZUNaTjBRRmFUWStVVjdLUEdjT1NFa3B4?=
 =?utf-8?B?MkFBN2VSL1ltdFdxTTNnRmpVVU40MTFvNTVTZHhnZmt6d2Q0MzcwOGdGUGRs?=
 =?utf-8?B?NmNzaTErRmhSMCtISG82SW5HYXJhK2taRmdxanB3QkU3UkpKOHg4MFprc1By?=
 =?utf-8?B?NWJWTXl4Qk1YU0hhVHFDL2Z2Tko1aWRqY3BrL1JpcTBkZWhPak1QTndmMVNM?=
 =?utf-8?B?TUUvZ2VJUlhXbkVJRkcxVWlEWWlidko0dVhKbTdKSUtZcFZZWjhQeG9RS1dI?=
 =?utf-8?B?OHBRQUt0Zk9hNnNsNVE0TUsyYWROSXpjWTF4cVVqbE5Banp0bTFuNGlDU25i?=
 =?utf-8?B?WWlVK0MxdUpFY1NUMS9RSDdOYWJMa0prK2g1d1ROd01NUWgxcE93VGVlMitL?=
 =?utf-8?B?K3BLTjRjbjd0ZmY5L1hmSXh1NlZINkpscE94R0UrVlJFTDRqSlFFbWVSeFE5?=
 =?utf-8?B?ajRKYWFJWVhhVko4clc3d052a1pxTmFGUWpla0IxbkRpRUlDR0YxYlVKRUhu?=
 =?utf-8?B?eVZTc3djUHZJRGJ4c0w0Ni9DZWZPNzEwaHY0OUd4TlRWSHZzNFI5L3JIYmZG?=
 =?utf-8?B?Y2hTQnk2bkY4dU52SXBZcEZTTlJ2cmg5cENuQ3A1TTJOMXRNbUlDYWJ6dlgr?=
 =?utf-8?B?cjV1eUNxeW1EdXZVdUl6a1cvVE5CYm1zTmNoVUh2L0F5eDAwTk00VVl6cmN5?=
 =?utf-8?B?TldOdnpNSHdRRytXeGVmUUtCTW9RLy93aVFodjJ5WHVGUFoweHlBSzMwYVM4?=
 =?utf-8?B?eVBJSE9yU2FSTmhiTCtoZ2dkdk1zYi9tb242cEp3UTdDSldjMFM5a3hpSnhL?=
 =?utf-8?B?Wms1SEJuQ0lhSVlqaTJTSU1FNUpwVHJoeDNwQ001WU5HUGt6TS9LcnRzZU15?=
 =?utf-8?B?WENvczVZd2JwZ3ZXSnlhdlBLUmJjUG9ESzR3MnJhdHFPWFVXbFMvUDVLdldI?=
 =?utf-8?B?eTQxTURqbDMxS05nRU5oN0s4eTdYVTY4cHZlWDFTRlE0UXVwZVk1aVZUdTFV?=
 =?utf-8?B?UzZNYUVBY0FQZXp4YzJIeDBRQnVpNFV2YWcvZHhETFBZTEIxcDdtcG0yMXdD?=
 =?utf-8?B?RGRWR1RTWW5GbkhNOXJUbVcvcVFBd29aVGRLQ1NMRCt5MHRUYU94U0RQeXBZ?=
 =?utf-8?B?WHUyWnkrMGc0eDhNUC9tTEZGSlkrSU1MaDlZY1p1ajZ1WmZsM0xOU0tIbDhq?=
 =?utf-8?B?UWdoSVZaRkQ1WWlqT1BuVlZmOHB6ekFxdEVLS1lnWFIxZ3R0OEFxU0JHdEY3?=
 =?utf-8?B?OU5NVjAvcWVjb2ZxdXloNFA1OFJScjVuYkdraGMvdG9vMGRZTDhNcmFkVDBN?=
 =?utf-8?B?b0dWcStDbmduejU1YXVBcXYxNlloOVlqT1ZqQndqUTNSRFdLRFFSWW9ieENu?=
 =?utf-8?B?ZVE1ODNNQXVNNWlZL1hEaElYeHNkN1lhL2loRU1aNXAzUDZvMXhzOHUvYWJo?=
 =?utf-8?B?M2Vza3M5bTIrSTloNzRWTis0T1VCeDN6U1ZMUFdnZkhUVGE2SkQzd3ovQ3c5?=
 =?utf-8?B?WngwOUdrNmVXYW9kdkFWZ1hjaHJ5MWJwZloxYXpIVFRiYU5yQ3g2QVo3WUlB?=
 =?utf-8?B?SGp3Y3p1RUUxKzMyb0Vtck51a3JvdWdIbEYyd3lPTTlpVHcrc3Z2MEtVN3JB?=
 =?utf-8?B?QlhMZUlNWWM4aThHWkQzbmQydWI0Q0szYnVrV1l2RkhTU1RUK0lxRlVmQk00?=
 =?utf-8?B?NVdzNFUwRGJ6Nnp0Y3RSQ3QzMG9VdnFTQ0NJZkt1bHNnYW9qbkhZSUdYSE5H?=
 =?utf-8?B?VVNhdTlER1lRT3k2SjNpNllLTjdJN3ExMHkrZTlGY0txWVg3Um9IV241SnYw?=
 =?utf-8?B?bDZodGdoK3Vid1ZSZUZCc3RtWGhDdWxYYk5tc3NBdUV2UHVDYzJzVCtrSys2?=
 =?utf-8?B?T0FiTUt3V3VhR1Z5QmlBb0ljOWZqMG91dXFhcW9JRlM1TzVocU5WU09jTVlG?=
 =?utf-8?Q?lrh7bAbpxawUe37bXZs4er66K?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b105bba4-5434-418c-9566-08db8e6f6af3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:19.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxRkLBY7cG/FuHd1Uw5ri5T9PQXV6whYh43faoL7Xm8bPG7No7GvAn3eaETHzd8fWgRalAhFtmjywiCHASIKsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
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
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
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

