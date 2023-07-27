Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927017647D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjG0HHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjG0HGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20709.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C32D6A;
        Thu, 27 Jul 2023 00:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+W4wOaOFY4QV8ha/H5a2OUlTE7kyIh7BvPo8NyR53FBuAJh7Y3L8oSrfmOTIs7XdmUjjEXgIvaoG6jbi3t7xRvnjN57Pm15AbA2F/IRIpW0w3MuAOJxN9IndEVntbtK0Cr93Dl0YO2iVt3XwKAjLTHRCfpZlreQ+BAH4Y58lljNfYjRkDm4yOTgtW34DhCR8mx4xoyiXNrp1qHSKESazJIO8EpG6D6I5lA8/PvQYexpdKBxLhdp6s3XZLwm7xFYKGUnLhtVVtt+BU+GGgC6kHGlLlEr8g9p3kRzshW8Zn6DrYI1Za8Udj16A+hNZRyBfzXSkosQmVMmCfJThMbYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsecs0FraqEkVI69yYtZuIhcDu7CE/3dvX42vrGL9bQ=;
 b=KAREA+U05B+5tyqhT/DKSe++TGW841uVniTQML3FeMLVRlSM887Oqi6SNp8I43qu9yPmUM8o0Ajhq6cI+vE8ltrxOHe/b/OsbvCcgahYASF+xOoc3Pv0IV+baXqIY4XZObsWMyEARxbQqWz4hAAU06dw8G5wE0jrTow1fSlm/bcQRLAQSVDDAErqIh29F8ScVNFxzxn5sP5wQjrH3G12s05uOB22Tg2bPemndlvDRw4d3BZKigw6NKO+VmluGw1UOd+V+XZGeSJxx0o+APrkXP1vEt+i3JxzUPTfVFyw8aZ/DtKHa1jWR3SCjehUK1otAW/pz9E5h0WwNVgoMWSn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsecs0FraqEkVI69yYtZuIhcDu7CE/3dvX42vrGL9bQ=;
 b=SJpDNSscgGn6PWwzjTwpLGqUeko3tEesz9Tf2LoaUv8mg8Giz2D/E3EYvEFFu+u/aaMWSTPrdUa1E0e8SnjNuTUV0MUQNmrM4jIckug6BsxQxW/37WJGwauQyxTK7h0jJgpHqhL6Qzun2AIfRllvqeeltTrJ9iRqaAwBpAFBkAu49QLHE5mpX6jZuTYHG588u6RcNzgvyceHt7Dq3oWDDyVF7YTqfqIF6bocV/2+uN9YcrfZy3pG2MzJ3Fwgh41eO7gP+bQN7Wr1glAsG9hZdmABHFUGTSWuhJOaAnEIsNrlqScqMbk51WmVp5D2CBhogfDRB2Hg9BZAdw8cqkYKZA==
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
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 42/62] mmc: owl: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:31 +0800
Message-Id: <20230727070051.17778-42-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 28c76e50-e26f-4ca5-580a-08db8e6f67c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfB1AJc0MPP5MHwuycoyEHR+iDQEkWI+v5vUws3LjMQJeFc1FJmVCem2IprfvB4ApFl1O4vOtq1aDJ1HNjZL0sAbyimpNgWMB67MxfEKq/B9yewMzAoDm+Wu5xg5oNjYgpYOWAN2w4daJkjjxVNqOegknDn6BNidLrJoQTl49QEFQLwE9VJyAM5fcnJ5j+FTIGeLsAlIYjnKtx+md432flEySwVd2UZuRmTookQTMdxleLjjONohAHmYDvkOdKWGWe2W/XY9aE8nXLStGYTC2KTnmml0AeOt0afz2pVwW4DQzkTg6M5J6/6pJG9/Jh+CDfaq+erZKMhvMCneDmpyz7rX3BUse4lQEqZTMLqaREGVhWuS2fzci8f/gfjNJdVt+aL4GaNk/vczEChfbUQgHgs86SjNrDGmAWfH56RpHE/AUUl1Sf00L2vrNn2pD0uQOVv5iaBDPtu3CY7Q0Jq/m+YsDTRdJ4duYNGIwTDo5K6KjF8sFxsqELlrwiizm+/gg7l8jkZykuYq+qimBVgUWuHdJxg5JmiRXWvdwCHPpiSt//6jHWFJMbVO6PQCR1QylO5Zg/o1x+FIdJq2iCqKHihl11au4pHgERJFBxHAEzOerMEu+fG+UZGnvJAVVyOG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmJFRFRreXFYNmVxQXdtQ2hldnhYUnd4Nk93SC94RHRmbHRBallNaGFsOFlZ?=
 =?utf-8?B?RnFCSDBydFFiTjdhMWJEY3I5S0J5aW5EZXA0WitnaVV5WTFQYUJxaHI4c1Rz?=
 =?utf-8?B?WTlJVmdja0RWUUFLeTllUTVqRHBPTEVLbmVRbWMxK0cvMnhvM01KdlA1MFZM?=
 =?utf-8?B?akFNTURGN1FQa2Z1ZlVoNkw5dFM5YXRIdW5DaXg4eW1YdCtrWFVVRFhxTmM1?=
 =?utf-8?B?eTlpY2piRmx4R3ppMXBZWDlsNjVRYjc4Z3dZZng4TGkvbFRGN0N6VTNVNm0v?=
 =?utf-8?B?UE5iMy9hcEZTOFkvVDQxS2RibXlGak80SWNVNTNOUGhlWGhDeXJ1Zm5wY1la?=
 =?utf-8?B?SHZEcFd4d3poUGhNcjN3Y2NubHp1UERCcklEcytTUDQyQ0NXczlvYi96UGFU?=
 =?utf-8?B?RDEyUWpnTFZ5UkZFQzg0c2JGVzR3cXEzTzJzZCtGWXNBREVNT2JlTUVacHFJ?=
 =?utf-8?B?REl5aURxNUx3ZU9SOVdiY0xidFgyZHZRMkd0OWZaZ1NCZUZRc3Y2dmZCWElp?=
 =?utf-8?B?U25rd2EweXZRT05Gayt3Y1BoRDh3TVZaejJRdmZIZFljaGxKeXRkdjJOTkdp?=
 =?utf-8?B?YTNiTkx2TWxLaXpQajNUeExISFdxYUhpTUtzMjFnK0tHVkdSQW03QVZZWFJ4?=
 =?utf-8?B?Nmc0QWR1b2dpVnYyS21MM3M0MTZiczBwRXptekxxM2dqc0I3YUNMSHJVQzBw?=
 =?utf-8?B?UEZIcjNETjd4ZDMyNlRGT2YrNlFzQlVEa2pPVjlIV2JuRVZySE42cDVKWVMv?=
 =?utf-8?B?R3BsZlQ5WlA5VDFNU1JsNElMRDM0aXBkK1hkWndpdkNqYUtLcy96bnV4c3JT?=
 =?utf-8?B?SFJsMndNYmh0bjNFTUNzWmdsV2JaWW4zQkdGYktHeStsY2lzUHJuelRycXhm?=
 =?utf-8?B?eWw1VHk4OHJaL291WUlYQWZWWWlza1NPbEFsbEFqTzZFRVZUb045V0FZZmV3?=
 =?utf-8?B?SFhwemFxMThkVkVmbTZxUFNlS3pVWkRKZEZDbHo2aVhFdHZZZnRDWFdTRGkz?=
 =?utf-8?B?eWEyRExCREprRjRzNVpZS1hPaEdSbmtVTUxBdnlDV1gwUG5mczc3cW5EMEow?=
 =?utf-8?B?VmlmOUtvK09HNmQvYXRla2o5c05TdWhNbEtnZDZSL0hqYW9BNlFkcW9YTWVj?=
 =?utf-8?B?QjlzbU5LMkkxenZBTFp0am42cm1TczhVOFpuY2V6aWRJajdwU1FRdWRoQURF?=
 =?utf-8?B?V0d1QllMKzlVUkV5dWFNK0ptRmVoSU1GNlhXZytaR2dUL3pSYUtrSE9PVDNi?=
 =?utf-8?B?cVFlZittYkVBdGs2WXJOMC90MWQxWEowcVZVVWpieEwrMS9GdnZKN1I1QmFF?=
 =?utf-8?B?eU52YXZhYUhpQUZxQWtJR3lGd0R5QkZLYTFWa0hpK091ZTk5VnhQY1MvYkpM?=
 =?utf-8?B?bm5KTmVBMXRFUUxCbGRXT0NHYmhmbnRGaVVwc3JJZjdkQ0dQVmduV1RBbVJ1?=
 =?utf-8?B?Vk1ON256TnlqSjZTaVRFUWw4SjRTQ0NPdk9kTm1kcTh6ODRIRVMxdmJOZDg5?=
 =?utf-8?B?U3JHTWlQazZsandDRzJGTDdtS0FSVHFBWFIra3NHem5PK1IvTXZUSER2U2I1?=
 =?utf-8?B?emR0ZlZFSENrU0FmTFpUTkFkMVFubnNFNzQwYnlnZkpXTFloVU12NVY4dHk3?=
 =?utf-8?B?bFhMUkJHWGwrT0tGRWEyWGZnb1czTDZTbTVzOUhvOWwvcnB0eXVYclpiend1?=
 =?utf-8?B?akdGY2EreVY5dkpSSjN1R1NhdnNjdlM2U3UyZHpST1IwVVlscFB0VElyTytk?=
 =?utf-8?B?b3FJOXMxam5aUVlBMkVBVWJqTW9NREZTTWdrSmU3SHBqZ2Q0S2s0Z2RSOFcy?=
 =?utf-8?B?SnBzb0ZpR1loUUM0eDJHNHRWeDEzc2VNVnRBdFh0SEV6YWJJZGNLcUV6TGN0?=
 =?utf-8?B?NkhxQzJFcERlYTNMbDJ4WCtwVzR1Wld1dU45N0JOOEN3ajNNZ0VzdFV4eU0z?=
 =?utf-8?B?amdCWGQzaWJCMk9ZNU1LbW9WUFNOaW4yY3JQR2c3dHJsNXBuNlJQZnZIYlNM?=
 =?utf-8?B?Z013VGQxaUdJa2FLYVZIU01qRXhPbmQyNDJnRTlHU085OEsyNTBkZEE1ZUtX?=
 =?utf-8?B?Y0VFeXBra2d4OWtsTHVXZVNEZGI0TmJDQzBVZ0RFS2JOc25CMU5TNWNwVk0x?=
 =?utf-8?Q?sKRVEnFokoH8aLXROrgwUnczp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c76e50-e26f-4ca5-580a-08db8e6f67c4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:13.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0Ppk7iH/bTRIwn6RdZ8PFRkpk6rwICObsKp/QHpB/wqXB1KNt3fxTFGN/iJlaMfQmMgYOGruTtDr592va7Zgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/owl-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 1bf22b08b373..a13bec42554a 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -667,7 +667,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int owl_mmc_remove(struct platform_device *pdev)
+static void owl_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_host	*mmc = platform_get_drvdata(pdev);
 	struct owl_mmc_host *owl_host = mmc_priv(mmc);
@@ -676,8 +676,6 @@ static int owl_mmc_remove(struct platform_device *pdev)
 	disable_irq(owl_host->irq);
 	dma_release_channel(owl_host->dma);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id owl_mmc_of_match[] = {
@@ -693,7 +691,7 @@ static struct platform_driver owl_mmc_driver = {
 		.of_match_table = owl_mmc_of_match,
 	},
 	.probe		= owl_mmc_probe,
-	.remove		= owl_mmc_remove,
+	.remove_new	= owl_mmc_remove,
 };
 module_platform_driver(owl_mmc_driver);
 
-- 
2.39.0

