Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB698751B16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjGMIMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjGMILV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E84810FA;
        Thu, 13 Jul 2023 01:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSOdt9aBnXNAzr2FUDhnOdeE1V6HpIVYXMUAcWqa8BKuiyJVixM7PAZEzTkxmOC7ifw4OdfB/YHXAVJQOkAsjk52vLXAAtcl7J/PmuqF360pyGMyTgiAaVOrZYUZ6FSEejCh/YQ6/8FLx+wE7+hqmbxKeEOvAFt+idupbvzbEzMfV5BneJRtriCwkD2+z4mHlB28nGLaOvuSby2bxQKdQGVpYofWeEA/HSzEFhf09Uvby77X10YVzc6/z4g6m4T5Wt1zbJQk0qvq+fe543xHqt+4U4Zkq2Yur8hSY1p1mo/Vu80fcurSeohmelXm1YlFerIV6rdg6fSgnkjWhU2QUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnEm4eeaXUww5eDuPQKSh3EIaMee7cr4msQcxUd2bqk=;
 b=QewAxLKPCk8J7jfOhYFRRgEHSXZBFGaGcXoCGlDrqv1Kaw2NCFWoe6+MlLJb0MdxcWCpke1E6pjZJlNoE596TGvkUa2Fw0+QnEb/az/A4EXvKZQBd43ZxwAqRczCeoqxW80MYaCvdjzOoABVBCPgOFw4WfhQQ+I0H8FD+dSshdrbxUWA02tTzIg2niZ5/rx/ozTti04VxEkFXQLBhmVjMw/30gQnOgw1VGhfgSPzmkgH2AlaVDneV6JiC+X4t/3U2F3WwflTOeZTtkLGKOlCDW6Gldw8oePyUzlgEWxdhkNSsmPEGMk+j+1CJ96N43RQ3jntXtqyDD3XyFr1kBFVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnEm4eeaXUww5eDuPQKSh3EIaMee7cr4msQcxUd2bqk=;
 b=UgQ0igklY8IShgThuvB30420emNdWELIvva+hVxq7lD2e8xAQDJ8GceP6iFAGOyi/UwFahCUsSnKDMPS2ue/nv9Y5jvc5ntUJ5WAdDHB/wCYjPXGTH8F0C64t4eXoYd89ou368TXYw7uwI6eQabpxKP4+Q04ELNdlCsoW9FlzsSpQczylKF0bDz+rZ310wPw2YxitQjdDVZ/OE+ntaEQTZHd25373kIwXp35/XGWfc9IkDdu0bFwp5sPvysxgmPzfaAP2q/jO0FwTpM7/grlJPOZlaoMgllJnnmZgLAms9XSstd8rVdri988Q2MnS9szQ9TRQANaqGvZDChD+qmgIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/58] mmc: au1xmmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:38 +0800
Message-Id: <20230713080807.69999-29-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e97c850-f265-4f30-b8f2-08db8378706f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dX1pNE4yEphqHHb2u4T/vj31CTMX83+gcTn6A3bpo1obfXaX9c0X+CCFSAqWAJlybw9vCn2EXm6XXTjxaX+7r8zTZ3T/vbrRQ7O03qz295Owyl1SVCVipM1WB0uPvzHL+QDdbVTLx+EgpP+0XxQVdenpJ5qcEUPPO8eW9uErOm/76XnfNmf4wau9JvLFNL0PnqTvSR8ZdNDnznOd9g3zbdG5Ur/Y7r43WHhkozRoVlrCJIfIRetwy24rmGuWXkcggnB2t2XxSPi3QuP9sRnTzTbzhkX+7OhQayi/iB/M/wG5r2fZjM7bAhsYowX6lcJ3z82Uh8Gw9AOn13TYXMnfqjrmrfVJJaBEcQ4CW6Al17C7uYYfpIandlylVRmS0xEQKkfyW2Nxb2NmQtzpoB7D4mKMKfVTrrIVpkpcQ4+JKNRnfkB4fyqnPX7++dI79Q+iT/RbpKXAtjGOq1zQUiwNiXt7veJpFAGjjmry5dZgwHr/WfbYFl8zK8TCokvgwl1OYUyjHQz76iOc0nEOM9QMqJ/SNGd98PBTKo/nhOLkJ05dolrE8cF7qwVL4LjgA5fSGbrfI0J0UB/4CDIsC0ri+fTjFqJc3u3xUWoMEDb6EYuRaQt6ux0TwNbzR1Hkeca4o+5qMdSGyKUWgwrOwT82aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(66574015)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlhPOTlyWHdyZFd0VERjdDI1ZllUUm1XQ3Q0dXptM0dPUTJQUDlZN2Y4RytC?=
 =?utf-8?B?Kzl2Snl6Z1RhMmU1ZjU2RkVnQkI0TW5WWXR0dWdnZWRTa1ovSzJsTTBScENU?=
 =?utf-8?B?Si85RVp5M2hyRnNlbmp2VDF4K1BLeVZoaHJtdVFvb2UwdXhKbVRQaEhwK2p2?=
 =?utf-8?B?STV0VXFiYUhGTkx1QlhMMUJubWdkclR0TGRaZmp6OE9seUVkRXNPT3hTd0c3?=
 =?utf-8?B?UXNyUFJKdFk3NE42WUtGK2xDQ0F1UUtybzJiZ1dDZVQ1emVab1d6eCsybUpK?=
 =?utf-8?B?MFZQOEJoWnl6bitoaUF0RDIwbjlFaitwSDNMbGxmenNzUk1oazV1WnkrWWNE?=
 =?utf-8?B?T0M2UEZySkRNRDN6bGx1VkJ4L2lGS0Z3eGt5cFY5UzFvaThyb002MDRyeEwy?=
 =?utf-8?B?VXBkcnU3YW55ZUVMY1FlSlVMTHpJRzhZdjZyTHhqeXhhNlpkaEg5RjlJK1dz?=
 =?utf-8?B?R1Fyd1FhNW5rVzZMMU5nN1o3R0lYQmx0OGpXZGwwdU5NS0ZpV3FreFdqZjFz?=
 =?utf-8?B?K3hxUzBhOVFrNGNMZWlER0hFd3dacUlyaEpjSjZWT25IbUM4YWZWemhzVUpJ?=
 =?utf-8?B?eis0bWUzcjVOTUszR2JwZ0FvVndDTUZWN2VxK1MzTzJGbVh2Sk1XbXNtT3NU?=
 =?utf-8?B?aytCZGlKTGJYQjZCalJiMWpoTVlwS0Z2dVBPTHBUNlRFaEtmdkJuM21OR29v?=
 =?utf-8?B?TkhVMnhEVW9XN2pCcjRvQlVFMURqNzlSdnIrL2JWRWg5aXAzT0pNVXpyOHNV?=
 =?utf-8?B?cHQwNkIyTnI1Y2FqaFZsaG1EWnpmNy9DN2FjOENEakRSRk5reHNselA1Skdq?=
 =?utf-8?B?WU1OVE8xSitQNHpzdmlQT3ArZU1IZ09pbERsS1NITGVYYldXVXU4QVZSb2dZ?=
 =?utf-8?B?Ty96STg3UzRpQ0tHb3UxbUpoQ1hVNDJ0RnhBR3hlTHZWeklvSzFmYTU1MWxE?=
 =?utf-8?B?N1REblV6b082cTVJTEhwVVNSLzQxNEVSRldtTjlZbkJOK1hZcklWd2pCK3A4?=
 =?utf-8?B?bGtIWmxDWFVKU1kyOGo1Y2xVUTZrZE16WnJldEVCL0xlMlNKSk5ndUJoSlNZ?=
 =?utf-8?B?UUtXVDhzcmQ2dTcrYk9COURKUTV1OUdBSUl0cGIxWW5RQUcxQWtPS3N3QXZH?=
 =?utf-8?B?akM2Ri9ZQlN4ODBwL1AxN1ErK0MxeWlWK0dLR2ZmbHJ3ZzRsSjhTVVdzc3Vh?=
 =?utf-8?B?T212VjhzdTNiSnp0VVNuT1lZVmRWRFkvMXBvUnFqK3N1K2EvTmhkM01sOGQ1?=
 =?utf-8?B?L3U2MEtKWnRlQWZVTTQ4RGVQV1g2aFpvQVhMZUdvOGRKa0x6WlIvQjJLVElO?=
 =?utf-8?B?RjhrM3g5b1ZkTkZoTFNTN2IxOXp5cEVjT2ZHbkFFcGlpSmsxZ1BmRUxKc3JG?=
 =?utf-8?B?K01XVDdaeGd3bXpBQlByVVpPY1RxSWtTNnIxMnc0WUNMK0NmcWJiLzQ1SVBt?=
 =?utf-8?B?KytZU29iMUF2U2U2Mk9ZUnRFR2cvRzRXUXV6SVRqTTB3eEFZemkvbXkvZGhQ?=
 =?utf-8?B?SHRFcjNFV2JzUjFGMEJSMTF6L3N5WmdHSC9xTTJRWFo3NVU4dEEzTm1wUjkz?=
 =?utf-8?B?QjlCUXdncEpYYklXYUVTVmRuR2htY01yUFRDNkd4bTA4dWRndStEbExZQzR1?=
 =?utf-8?B?Q25wQ05raldGakVYbVE5ZlhSanJkbVZjUDlYWEZiQ0lFaG9LWmRSSEQ1NkxB?=
 =?utf-8?B?cldaQnlLdnQ4RndXZnZSdEhsLzc4dHZrVzBHSENKaFY4ZENuWHZKdnM1WFlI?=
 =?utf-8?B?L1ZZNW8zcHVBdWxyVXVqdDUrcjlvU2hTbURBNXN4VUlqVXp5SHpnL1dORTV4?=
 =?utf-8?B?U1pNSmFHR2ZGbFkvUVZvSHMyenpmeEFvYS9PY21XKzd3ellkUmc1YmNFREpz?=
 =?utf-8?B?bE9MZHQ0MWZETlhveEFyMmJVR0JIOHNZSDBrQmlkKzF4UU9ieTFQOHQzYVdN?=
 =?utf-8?B?UEQ3S2o2NmJVUzA4SDJyUXJkWjFzdUd6TVRCajhZYXQzWFJWcEoxOERNcjlW?=
 =?utf-8?B?SDRJT1Fpa0g1UE10TkkxL2tvUXVQcjlOUG0vVXNSTm9SRDFtbGVWV3FZdVhp?=
 =?utf-8?B?OHc5aEhMTldpaEFJcnhVek94Z0pqNDdPaVdpMkN5NkxaTGZJUHdxNzkrcWQr?=
 =?utf-8?Q?R1c8Sp5RtLzXFNeglHxF0PUAf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e97c850-f265-4f30-b8f2-08db8378706f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:11.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvx8GXP6jN2PXQH3ZwXFxSqEBgya0AUmXafIW1TTMBclF8RUgRZXtqe8gfDfOnfWULQk0hx+IOvLFgpANbuapQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4409
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
 drivers/mmc/host/au1xmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 82dd0ae40305..b5a5c6a2fe8b 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1114,7 +1114,7 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int au1xmmc_remove(struct platform_device *pdev)
+static void au1xmmc_remove(struct platform_device *pdev)
 {
 	struct au1xmmc_host *host = platform_get_drvdata(pdev);
 
@@ -1153,7 +1153,6 @@ static int au1xmmc_remove(struct platform_device *pdev)
 
 		mmc_free_host(host->mmc);
 	}
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1185,7 +1184,7 @@ static int au1xmmc_resume(struct platform_device *pdev)
 
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
-	.remove        = au1xmmc_remove,
+	.remove_new    = au1xmmc_remove,
 	.suspend       = au1xmmc_suspend,
 	.resume        = au1xmmc_resume,
 	.driver        = {
-- 
2.39.0

