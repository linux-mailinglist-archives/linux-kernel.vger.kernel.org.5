Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137567647CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjG0HHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjG0HGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1792D4F;
        Thu, 27 Jul 2023 00:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNkbUR3uw/2zGpNwd51ncm6P9uPRLCwOHPDWGN26V/CiEYjp01VV5qg4bt2uh91Jz2F5GXQ1Idx2X2o/ID0jKqcQQAvmDkslkBuMGTcpKT6jn5/XoNKPW2zhAmn8eblZMy6d8OFe8UoY+u7jMtGYMLwNJFI3hi5JgcipfOJHmIPbD0QC3Rkz6440agXiVa5r6hp9TvexsvERyR9fcoVCvQ8utK8caIM22Lr5hhhhmOUEOXjEClj9xKtsiGvyCZ26rv6pt5/QVT8CKkiXNuAdVQOxgZXcX86lotGX9qJVpLZ9bG7CCFj1YObUMgewLT9SU68qpaFhn7r8FmjA7doFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHKArmtjsh7/y1Aplpgib/ppYsMir3MLAx1CuQ9EKjQ=;
 b=mwJC9EWYS9DoS3f7h6J8kRSoplv9gjBtU/yVdgF0D/KpEnRpM0sWum0ENdStELoPlnLc3qsXEduOvN16Balz1ucLw+Z7fLTPctPDJdthxmbc3ypB/P8HQ4JgIefFJ2rIbSZXY9VYYJ10o1+4uiMeymvkALY4GRAPlbV/lOKVRYDRr6ViCU7fbBB8r+GIHyHhIYHSY/u8dOx+QtKm/kjddle+i23YLQeVOU+OnPRDv5Y59vf363/z056bQ5tcTzBPLb2TbFqAxbsugAqN4Ux7NarhsbJIU76j8cfBlPLtjYhnvV97MDbwUZ8PU5wjBLwK+MK7k6ErxBDpZtZ/GuoOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHKArmtjsh7/y1Aplpgib/ppYsMir3MLAx1CuQ9EKjQ=;
 b=I7+NvsVgIIfF0xhp3teWQOmx2AqrwEgMHt6jK5sXHMLqRh2O4nAARXqGy/yOi/ScmaFkjVJlk6AZaO4dHTySz4VWIikbdDaCue0qSSguWbpIvV22ePqbcOLCjjmUYu7p+oNSlFmxpUHuelUkDu66blBTsMcFxwUEP66DQSC+7V8L3upvhqu1YbMlcdAwfSRcCwRVELmhmtoBs0xlclC8E8DJsVHXOQSmfOZdqjQ62DKPwXpvjQ3f0y8W2csZMY4lD17ncTu+4l2bge2BUvSe54NLF6FD5CTjdG4sCc2V0JwJpgtVBGU/phWaWStQ8XRKp9Pc3xXt2YiQipr+FtD2yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:39 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 41/62] mmc: dw_mmc: rockchip: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:30 +0800
Message-Id: <20230727070051.17778-41-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8723842-9120-46da-fb2b-08db8e6f66b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLinV5srOpqqZU33Ugr6J3sfa0fs1o06ehwMPHlAs5KMFkFQH4OenGd2Eno2hj44vcQq72vg8xYGHPdiAAGxeub2nXkeILYNr/ARg0k7LkBs9zEBN2mIIzCJlsdH5lm+l8uhosnkZwoRQRw9P51DW1CQMvSK5hi0W7jeFp2pQNRuUJQ5Jp9VOeXaORUn/jG6nernblykjHPZdK7YD4E3pYV25wK0rNl/7d8HtZVBNQycaL532Q56uWj2L0nEl2RaWTZ/Ob5/lshd8A4md9Jk7WMg38Dk69yqyb9IX3Hv5OPsYy0CZ06f5JrWbVq098c8YTIGC0+Vz0Kff6hEkwXCOysZjo3v6KDTv5II4q4a8D9vxHPt83ar7gBZs0/5B545p4mVe96ti7T1AEXSmsXKPea8j2nrAMYH4uUj4eSFp9dZSS0xFFQK8YX5ik9vjxHJmo6ErrIAqyH2hnVMFQlsGyfi+/zaTlHYaSLlE5o3D3Wf1z09PO6HLNDS82z/a/1xPoD91H7T/XTnD0HQ+/2VpMNixNeGpAAYWgUu+AI2eXeVwef+HdCVMon5bbQz6HC2PFaHNelDSRrgFYgsb5mjF1dFGD5fkmtFkHPbMjL8crR9fJVGOtzZUIwhMFPKMq7x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3k0UGZKRHN1QXk1SVB4V1YzNENNbTE2MWZmZDg1U3ByN0RnMjloN1czWTgr?=
 =?utf-8?B?ejl5cUV0ZzlJK0piZmczVVZBdC9XWW5SWkd3amNJaUE0SEdIWWd6NFkxR21x?=
 =?utf-8?B?V0pCV3AwUGpTSXpDd0lLb3JTMVlJcFpIYTdCMUJDalg1bCtiL3c3NlpYMStw?=
 =?utf-8?B?WFk0VVdReWdVb1BJY2QxUGVzV0xXbEpRMXFFR2pEU25BTGtzOGwwbTF5S2Z6?=
 =?utf-8?B?Y25Qa3ZhVVNJaUhqOFB5bFlhMi95ZGxtaHRpSVlrRnlBelFQM1g1eUI1S1Ro?=
 =?utf-8?B?MUE0NEFDOXBtVGc1OUlscWdhMVM0eDArZWlyQytuaFRlOGRWUXZXRTk1WXg5?=
 =?utf-8?B?WXFmUzFVbXB3NUZHajFtS2Y2Mm16Q2twcFhGeXFkRXhwcjN6eElIcGRab3VI?=
 =?utf-8?B?U3JTVURXcm5DbERGcVltZENjcC9zSHNYTm45aE5QaGJBcEZqcHZLYXBYV21u?=
 =?utf-8?B?M0w4Y1V0a05ObXlIbmZNYy9kcGJSSzladHEzMmkyYXkxOVVoODdRR1ZXNW5L?=
 =?utf-8?B?QVZacjNUK0ZxeTJMaDB2cXpwdEFUeUJ2bUQvd21aQUVNVlM5ZkFvREo4Rno0?=
 =?utf-8?B?NDM3T2thaHk4TUpEY1dManlOSGx5ckdvNlJ4YWFOUWU0MnBPV2Q0Qi9oMUln?=
 =?utf-8?B?Z0VRT0ZvOVRxeGpxakl4cmxEeW9MbTVhd1NiVE1qaDg3LzMxSUxYMkdzQzJT?=
 =?utf-8?B?S1NlWFIzUkhwaDlKRzZDcEl4U2hhVHY1WEJNRVJUM0JxVGY1U3Z5SzkxVklB?=
 =?utf-8?B?TGNrcWxhVWtMcnZMQU9RTEhjUW9pN3pZRU8yMzhUSFlnRGRTVW1UV3JrOVN6?=
 =?utf-8?B?R01WVVpmR05FSWNwdzhDVFJRWm44WDB2UGV3M1R3K0szTjJDNXNxOGVqUXpT?=
 =?utf-8?B?TkVVNTlFTVpiWlVyZU1ST0IxckdKVUMzYnFCNG1Xc216WEhsV2JnQmUzRXZk?=
 =?utf-8?B?Z0cvdWNLcG9lVDdWVVd0RVhtUU1hNFl2dVlJaTFnOGpMUjlEM1RrcnB4UTVI?=
 =?utf-8?B?VWlHeldlbCt1b2ZjUnZpR1FBdXJOOWlQWHZBcVByK0trblV3Q0NYUTlYS0Fq?=
 =?utf-8?B?ZHRsOTF0Y25YT1Yyb0xpbE1pOUVPYjg1TEVJd0tmY1Z3OGFwaEVlYko2dkpP?=
 =?utf-8?B?NEw0R1doclZ4RVVZVm0xdTVVREZrQjEzVCtQZWNWcDhZa3lsVUZaM21POWcw?=
 =?utf-8?B?cGdtd3JyMXRJOWZsTXVYRG9ublhxMGtsNUFzcWlwQ1J4QTZpLzRaWnNHU3VX?=
 =?utf-8?B?cFl3TnB0S1VrRW5lM3hzMENIV292MU1YeGF0YytSMjNSL29vdUs4MEVaQkpa?=
 =?utf-8?B?anEzT216cDZRRkxsUytoTGNlL3Z2YWhTNVFyR09NZFdiZ1k5WWd1dURIL2Y0?=
 =?utf-8?B?WGUzelRoN1A5aVBHbzJyakhWdjlpb3BxemZpYm9WaHF1c1FEVzd2RExkNDlT?=
 =?utf-8?B?d2dUV1lEZU5zQmd1ZFBrQWpVY3E2UmZFYjF6b29YYkJkUzZJSWU2WTVKUURr?=
 =?utf-8?B?TWkwSTZmeXloWXE2aG8wOHhNM0lqZEozQUlaMitMYVJjU2cvbXhmUW50UjZa?=
 =?utf-8?B?VVlRa2lrN3YrcFA1ckRTc0lKRklrd1U5czloQWJzQndQaVRFY1JXM3ZiNHho?=
 =?utf-8?B?elE2QW9uQ0tvQUlOYWYwZkEzVjRhckRCRnB2MytSSHZvNlIzZnprY1RhWHNw?=
 =?utf-8?B?bmRHd0ZsNlBmY3FnVitSdS9VaFpDdjZHeUoxUkY2M0hIOTNGc0JjSFNsaVZ5?=
 =?utf-8?B?c3FFSnZESjRhVXJWRXE5aXFZdkRXTUZxTHNSRHF2MCs3QU5EbExxdCtHcm1Z?=
 =?utf-8?B?bklJcDFCTU9tK3RMMWlRaHBqeEMwelgwQk9mYS9PdmVUK3llVkNrb0Q4M0Fq?=
 =?utf-8?B?WmlwTU9zVC8xVFhLOTNHVnNmbkJJTnRnWVlZYzNKTmRIU0xKSldGeHVMUm9L?=
 =?utf-8?B?dW1LbmhjVWIyU1FTUU91dWhXZ1ptR25tWjl0OUErYVE4SGNZREQvV2s1ZW1V?=
 =?utf-8?B?QXNCaG93eDJsdXFJb0NjbW1EU0l1b2phd2dDMWJZcjhwazJUSStHTHRmcDJu?=
 =?utf-8?B?Z3JrZjBQUDBSbkU1RkZnd05vVXFQSE1MalJZYTU0UzN1ZFJITTV5VFp1aHdn?=
 =?utf-8?Q?J37OBfLnOrhDfFlDK4FIcunQ1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8723842-9120-46da-fb2b-08db8e6f66b6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:12.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26g4anAd+SAAekuvTVHAtv4vm6BwI9JrDj2W2abY28EzKuQARV81fVAcfI01Kr+rVSk5NeqWGRsZ0Pj7vSarQw==
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
---
 drivers/mmc/host/dw_mmc-rockchip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 2a99f15f527f..b07190ba4b7a 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -371,15 +371,13 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int dw_mci_rockchip_remove(struct platform_device *pdev)
+static void dw_mci_rockchip_remove(struct platform_device *pdev)
 {
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
 	dw_mci_pltfm_remove(pdev);
-
-	return 0;
 }
 
 static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
@@ -392,7 +390,7 @@ static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
 
 static struct platform_driver dw_mci_rockchip_pltfm_driver = {
 	.probe		= dw_mci_rockchip_probe,
-	.remove		= dw_mci_rockchip_remove,
+	.remove_new	= dw_mci_rockchip_remove,
 	.driver		= {
 		.name		= "dwmmc_rockchip",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

