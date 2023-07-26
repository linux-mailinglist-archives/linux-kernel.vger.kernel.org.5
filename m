Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52250762A05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGZEJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjGZEIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:08:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20716.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::716])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0884EE1;
        Tue, 25 Jul 2023 21:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIZYZ9KxGp4ohgfglbtD1H2Kw6zo86YPuqYoUKzR5jkScoBQQr4V8sfNRTkKpb/FBIQhjvoxUcBL6SkZi+eNht0yR7XzCEKj5IhEHhIpQF6Gjo1CMQxUjBBKf/CzSJZCYa4AHRygU4LsN9ByZ1V6upIsLdgKrk1MqCGqikJ1DyIC8ZOD8H0cx4kDErX0ThAN9zmO/6AvZU86Ij4EZXG8WAOWytRGPY9OqRTDJJGCerrf9ZKPIPkQS7znnQsik+4Yk0JV0Z+6OD/XyYtzXj/ULPRuduMHq8oJAxk2JpYOMaKrpmfnaJvwODgBlz2lFgGm3GUi1cVtiNxJilCa3aWR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVnebS5xmKX74dwA/QiihEaSwS42iXdHIK6TKi1CgBE=;
 b=K1/0y8OjSw+sdXj2OChixqVMdp/oDv0StqschXcvjzzGKIMgUQODouYVhAkJgkXjl0miHcqrN/zK4Ra5tWcxJ51VM03lsPhRtyNOa0aH3qnClakaU1auaBPE9Ow06TMuxYB09FKvk0GzTsZn4pNmkjTfRu0h197op6dZPXFXjrb3z5IwUnAcs3PAmXTd0J0BJhq29xTWQ2HFuJuEBTO/L89h1Eq3uO/cEPhN391Tn6cDJE/AX72g7SHLkijYXhaQo75o3wELayBz8LkKzoeFUMkVDgTU8+9PXVTPL3WEIzY3cdKo89pJK2KvBzUgFZc8RorUxPV+aT+xMLifhy9pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVnebS5xmKX74dwA/QiihEaSwS42iXdHIK6TKi1CgBE=;
 b=nszivcoJJV1sDS+ltn3AVb8fPhrrFBiVObnn0zopmnEOVdIV6GiwIIuqFZUT57UWgJBO38p+/OHaOAVX9bYvseUm498bOqnnK+8Y8SshGyNoBWeDedikfO1qkxbvr26Er1y6Ad97tm6tplrfEU1gkat9Uf4bZy/pY36LjS4TrHkl+DfKGxMawnboDzkBHLK4PB1dz8uNtXghtKtCZqnAFkDFV0wzbG3zxe4Gi1NBCE4zpORv/vzgT9x4t79OW0E6GDH5BXjWCZKPnGGU0yx1A0v3IbthQRNypGLfBbyBgEGObTwWbYBYfI2BrYKOksGZZcilXAnDzAPUu5wDpbYp5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 41/61] mmc: alcor: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:21 +0800
Message-Id: <20230726040041.26267-41-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b725bc-49fb-4e46-b3b6-08db8d8d15ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCKDz5wMkAML9YbfOoCMFQ/GrC1sH8I2khedVHbGNBjElt0kYu4DL2PNbxM+jWA8ZK8Dsup9f/C2KQzxqMRQmOQFOZwYaodQPlfrkQbmUFJK0AVrwatXV5GuvLM0VPkfVz0GVntWDeWfmigodOcy3I1Cg0TVUN4SHzZHVaKvf+UaheoyVV9dS/PEMncAzmyj0kNzGSQ4GkpBEHh20nB3kdRKhODO5/zKEyulxWgAUyHhV6ImVbsD0uAMYzK58WEdhw4NKe5mWRtDtMGyXKJJeSMMF6aUFOVpAoPEIONl6XF217zUEua5bBl1J06EYHI9W+eygCOzflRAtpZxTB6Oat5WOmMcT6NMa3c9nc04kSG4qMQHmlBB4yVt45bWyQogav5Uj3kB+psvbRyotozgWGSr3sVf6VIcvbQo10qBUzfiWgRsF5/liRJwOKy/Cl0qeyPESBL2H3/ZaMC478zPnsyAjjdhb7yVu0zRYEOWA2jGAf+chm/kVW5kCt0Qo544yBy4EAyvXXLXroVy2cE1YxwTfku/RAbDsvm2XgRxKo8fVfIo3oJL5TACBR23SfnfXRm0lcx2bds3TopEV13VXw8hEcw6nq1FpSNfHMoWLHQYC1F5oBpuw21DApYKI+ft
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTl6dkZRdUprWnVlUXRWNkx2L3B1UE1ab0FtNUd0Z1Jpd0thU1hBUnFZR2FI?=
 =?utf-8?B?d0Jtd1NoVnh3bmkwU0pMbkc2MTRLTGtPZ2k3Y3dON3lMOGEzOCthNGdadVg3?=
 =?utf-8?B?WWRMbzN4WUY5c05LRkdQdmxjdjFZdTBlTnR2VGgxTUVFNUdCbXVvenVSLzVq?=
 =?utf-8?B?RVVyWUluL2RQNk1vdFA1bTNWd2pjYzFrc05hcFNjR1Joa01jem9GY3ZQL0xS?=
 =?utf-8?B?OFEvMTQ0Z2UvWjJPRTc0Vk1DVVZPT0RNTU5CMWhlOG5wRWU3M0pQblprU0NX?=
 =?utf-8?B?T3VMNXMvQ1BZL0lGbmhWK0hrVlh0bm43QkE4S2owYW4vei9haTNTQm9HNnZJ?=
 =?utf-8?B?OVRyZzZkQUxIVi9DbUZGYitrV3dpK1RNRC9MYUk3eURtQXhHODVPSDJVZW00?=
 =?utf-8?B?ZU1YTVo4TGJOdExsNkUwQWtqMEJNUHRHWEhFT3l5dU1DdFJHNUNENVFSSy9W?=
 =?utf-8?B?Nld5a1VjaEdFQnduZHZlTWpxZ25zMHBzWUduWHRWR3BHWURKRkRsTjIraXE4?=
 =?utf-8?B?aHJwRGk2Q2lIQ3JaQTBCMUlQNUpqQ05CZVJuRTRSZlBJRjk0SGxRMDdEVFFD?=
 =?utf-8?B?UTVmOWMwK2NkekE4SW5pTnh6c0VGcG9KMGgrRkFKbk9Ed2FwaHFMbEgrbkdz?=
 =?utf-8?B?ZUFjRHZTNitNRjZYK3AxSW8zTStLRkdrN3JuMERFQ0laeEpvYjlKU1oxZE1m?=
 =?utf-8?B?dzd4OU52VGhHYS9ML3Bsd3pSZ0NHUkduck5SNFVQenhQeWVlTWRhTWJ2alBp?=
 =?utf-8?B?c0Q3WTNNVWo0bE5qTHFJT3F1ZTBzWnB5UlV6bUhvaW1pTWw5ejQ2TERQclBq?=
 =?utf-8?B?SUxKRHZXb2U5dXVEdUxkbkt3NmNxRjFiM2cxWHBDNjVEbEp4VHBrUSs5UVpE?=
 =?utf-8?B?L0t4REFRZm1HYnVQUnl1TFc1bWJVUGdrTEFJVFk3YVJWWDhibHVpdVQ1aXF0?=
 =?utf-8?B?NmVZelR6dk9HcFZCemZKVTI0MWE4cTR2RWVobVArUmtSbVBLUXlGVXpuK1VY?=
 =?utf-8?B?NlBjRnJ3Z2hJRklZK2N6WlYvWXlaVzREV3dmbDZIVXpxUDNNMGxTZTNOKzdx?=
 =?utf-8?B?VGRwSWpYbS9SQWwyYk9xNWwydnlHdkIvY1Rqc3h0WkZaQzgxWHZSUTk4VC8w?=
 =?utf-8?B?dlhUSHpCc3NUZE5EdElGRjY3OGE2VzFCeW8rRWZidXVIcEM4dXp5cXY5Wk5u?=
 =?utf-8?B?REFWMVZKUEdoZmhyNU1QZjVGRTgzQi9tc2d1WUhhU01VQ0Yxd3QyMldQQW9o?=
 =?utf-8?B?N2xETnJFRUg3K3BkY3N6cVpwY3JDRGwxTDc5WUlNZXR2TytmUVloTkt3RFpU?=
 =?utf-8?B?V3JxVEhKano2ZWdBZmR4NEtrWjNiUUM3N2thK3dQTm8zbU1RdWlWT2JOUlhp?=
 =?utf-8?B?MXpBY054d0w4eWc4dnR5aTRBZWRGcXpwaERjazVZS05iQXd1RjZUM2VkZWRq?=
 =?utf-8?B?Y0FJRFF2dGE5R1hzYzZBeUF3WFlDSytCb2toSW9FQndTdHpFTGY4MHlLNW9K?=
 =?utf-8?B?c29JUWpzVnRNSFhncWs4b1FZZlBwang3SitTRTlON2JSbDdqQTNoaTV5R2Uz?=
 =?utf-8?B?NjJnVno2QVl3dktPRTlnb2RXbi9QWGdrc3pvTndqZmYwUjFxeEVMVHlualJO?=
 =?utf-8?B?SEpCVUkwUzNFaStsUnlub3daRGNvVWZOcnNzQmVPaEUyUGFFVGdweW9kVlVZ?=
 =?utf-8?B?MUxTeEhNTFphY0NLYmFJWEt3aXNBR1dSeThHUHhaYnZ2QnhoeDlnZ3BXVTBD?=
 =?utf-8?B?a3V5QVJZeDRFWkxuNTVXa1AzNDZXblVVeEIvN2ZXTkVlNFBaZDhHbDhLMGtl?=
 =?utf-8?B?T0FyNFB5OGFmQzZtK3hDUkZuRDYrd1hVWWR5U1hwYkJVcUwva0JsUkNsNXVF?=
 =?utf-8?B?VW1mcFR1NjVSQTVxTzQ4TC9oL3hGcDZUTk50NllLdkNVKzBlM0NXWW95S0RR?=
 =?utf-8?B?SHprbjN2NkprdWtvaTV0LzdrclplWjNVTjhweEozcFhOZGRUSG9GcktHY1JP?=
 =?utf-8?B?aEJSMzlzbnFva0cwdjFvYjkwNmRsZHpqMWdocDh0U3VqOG55cU5NWHQ0WnhJ?=
 =?utf-8?B?WVBMS1k0QlRyNXBvbDVuN1hqZ3NSejVzQTdlVnptNjh2YnJhTTJGUHZDR0lp?=
 =?utf-8?Q?7KdDT4ZfAOt2EcYskj9mKzbjv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b725bc-49fb-4e46-b3b6-08db8d8d15ba
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:09.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoHuRZY1A4Evx/685MJp3k8K1MqSw7MKk1vKcqgg5maEOaAzVmU0eNroCIw8PCcfiWWisQtHiyCiCJ7NfI/D3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/mmc/host/alcor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index d01df01d4b4d..42aa43740ba8 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1125,7 +1125,7 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
+static void alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
 {
 	struct alcor_sdmmc_host *host = dev_get_drvdata(&pdev->dev);
 	struct mmc_host *mmc = mmc_from_priv(host);
@@ -1136,8 +1136,6 @@ static int alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	alcor_hw_uninit(host);
 	mmc_remove_host(mmc);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1177,7 +1175,7 @@ MODULE_DEVICE_TABLE(platform, alcor_pci_sdmmc_ids);
 
 static struct platform_driver alcor_pci_sdmmc_driver = {
 	.probe		= alcor_pci_sdmmc_drv_probe,
-	.remove		= alcor_pci_sdmmc_drv_remove,
+	.remove_new	= alcor_pci_sdmmc_drv_remove,
 	.id_table	= alcor_pci_sdmmc_ids,
 	.driver		= {
 		.name	= DRV_NAME_ALCOR_PCI_SDMMC,
-- 
2.39.0

