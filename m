Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6A57647B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjG0HGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjG0HFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:05:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883B3C0A;
        Thu, 27 Jul 2023 00:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJJ9/NGixKu1zeaBE7TbTZqzJ5HzjdMxhgtinVeKo9NkXIBqUTCSjbwUglvbrE9GWjvdI804yMdenz/luOLoGJw/gR/6lDeloqYdafPWutEGrdk6qbktA2lGxbtLTrsAM6FgRSjaxtr3hUjxWJNxNbJauzs/KA6M2bxtyH4ZpHETUq4deH9V1mm1WfneX5+yE446Qxi0Z71sEE6DO1irCTOziLM74e7MnnXgGYxrX0s4x8sc5T8vxq2zHz1kEbgFpKbPYrF9+nF5lyXd+QOg/Hh3G98rmIZdIIaTVM2sUUZoUdAGHt0VfQE7O++WaPRLy8aATP0upR84qdol+JKL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMRuHPjs0o6JxnjzMmw3FowzCDPmxFhkE7AH+JRAepU=;
 b=fFsmTXS7HbqAEyF72Wgvba4e/xbwG5ZHqps5KkvtjxmjaBTzXJqNQMI6GgcPRnPN+bMZsizc8jPYn6Gf8YL9mNweoV9ZXFI2T5S5i6euAvy68BqhcbeUkyMdKPRbd5sXx3gPehY4K6T3fSuHag0HJGD0CNqCjqwFXYk7IXIQcLUpLX4WihQS2D3Z6efARVbSMhmNPDtjdeXMcAIUOP3qpQSkj9kuD7MjIzrbrimshwbLXc/o8lrd9BWcJEjkGFHBtQzGlj0MiST0k696vVButJWjKBZL5foPuzVyVm7RKxn1/QGJJQKA++qN5sWORwYceLnwPhe5ZUXX4cQ0e2AzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMRuHPjs0o6JxnjzMmw3FowzCDPmxFhkE7AH+JRAepU=;
 b=Ss0llbHEWZnFJzJ93ECoZPVCyBb3yqoHlu2ZMQehKPmABM1lnVE+vdmHubXw4mVnmSzFT6RhmG0Rx/kUIn8/bvXkMLn2Ya0iheh7hJqf4BzZUM/c1v7CjLZLIHmKW0hZ8TZXsE437Z2aNKiR9iflQnCRO2wjz2QX2yMcOzmS7ouzoEmYYw7mRlLyNlIdEKqKM6o4r08Dbh6zGYTwmDmhpM4RuYW20CZT2uUhBU0Ydfb3YhZXBnV2wMVloH+6OwKk53/pgJ5aFVvE7VXdLNIFHsi+VFnPnGGfLOYor3Ny7rrukqNka5blRgP5nLD2vJUyBy8QOIN/hYPkxXoBGBU2Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 25/62] mmc: sdhci-of-arasan: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:14 +0800
Message-Id: <20230727070051.17778-25-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 504479c5-62bd-4fad-ee8f-08db8e6f5604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Gr+shy+NKnUVYIGb4eitby7zNb7MyoAFTLpQ+IjztEQZXYMlDBRbsp40XGFR8lY/sNHoNnnuD3w84bsuRIZdnGEZ/CwtCJEl5MZWEnvp0BK2K5TQx4leRGfkVlApcm7qMtIdYYnEM4jqrxW/GME4591j7KuHGmiVJRk4VNl+tVe6WYtZOHM+Hzp3J/RBRnpurrDPItuY2wsT8XcwIQ8tzVHubQECB+NiyRp1MY29KoOq7WWIqiS7d0ihQ6JqY4HKTjnYvQLeyp1qabS2uNGU7jAKb7UuEjGPxVd8Knb41MkQkWx5wNo8kP8IMdKy3lEyyfBcst9gQmJ4xmbsCAQ1kaWNgOyU7dnLhOmYKmLW1l+O82+3j3Ur1MtAtQrDfR/FJsvbqoeLu25WbcrtWbH2X8XUGmFRkJHLbS2qb245OJuHRyqgLQHn5wPzdfITRIdFLplwxGSB003XvipJsPGPEvs1Utj3XHtrnvLEx57/vmSmvqzkapOTVK7Q0LLHTfCKhVr4AxfM0/9M1wRox1WDGoCxXOlcFUcPr7hKp9AlCAiL9FE+JgYBXKlnBk1U5Ihf+kxp2/EwhatRp3B2i9QPo2gT/fOLadb3EOckWQxD0rhpdC4R9yptdok5LYTpWIj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N25PMGVzQ0hGZFRmRUp6cjRnZ3JuWmFuUCtVRG5Ia2tPckVaLzRlblhSenJq?=
 =?utf-8?B?aDNhWVF1M2pNb1JOTWovQktIblpGV2lRVWk0d2tHWkdZUzYxenVNR0JoWE9L?=
 =?utf-8?B?ZFRZLzI2MW9ybitXZ1VLRW1mK2VCVzlDMmt0LzVCRzMxejQ3dUtMV3E2MkxI?=
 =?utf-8?B?ZEROZ2J1c2xXNGp6U0krY05qcUthNCtOeXJtNC9IemUxcGU4ckV2QmJuS1FM?=
 =?utf-8?B?NGVELzduV2g1c1I1enZUMmVXU0dOUVd2MGY2RnBSNE4ySmh1MFNiT2grNU1E?=
 =?utf-8?B?SU5HbEZFeUpzVWI4U2VpZUF2UXBXdnpFbjl4bWpRUzFxL2FwZXJIK3RSZ0pl?=
 =?utf-8?B?Lys2cUg4aUtiaG1MUjc2ZUZhOFNvRHFOOEtZWnhhUm5HQ0tDRW5HYXVuek1Q?=
 =?utf-8?B?ODd1SUI2MUljaWZ3NVhGenkzWjJ2dm11RStCenlpSzNYNHd5anNUdHFHVkZQ?=
 =?utf-8?B?R1VHampjbXFJMGpEcm1rV0lyMkEvNUEvUThyUjB3Q2VBNzhFVWdqZEpFTHZj?=
 =?utf-8?B?WFNXNHRodzFXM1l4bFc4UTFjSEtOa0huYXM5Nkh2ZmFNUlFSYnFSOUtqQldB?=
 =?utf-8?B?UzFTUHp5bkN1czhQazEwdTBzMWJON2hZbmNWNlZodE5pZnRrTGdrVlFsbDBu?=
 =?utf-8?B?VUxjcEtHbU8zU2lYeDdUcGdKSHI0WDR5eU5SaitIeXlFQTVhaTg3SjBjRlhK?=
 =?utf-8?B?cUtoYyttS2pxdk16Uit3dTAyWCtsOW11aGtQWmMvMzNkNWowOTFxS2dSYUhp?=
 =?utf-8?B?WE00NGdhQXBOcTFhVnR4UXdMK28wbzlCdFhZU2k5MkRCTVptNkQ5VUs3Unhm?=
 =?utf-8?B?WWpRYmE1UXNreElZVlBhTHZ3ZFhZUHZIM0taVHAzaFhMVklXM25xbWlSZmtG?=
 =?utf-8?B?VCtZbDZDd29MMW02YnhjYmtIYy9QT1JocTBjbG5Xd0tHby8zQWlTdW5sQUcx?=
 =?utf-8?B?aEM0cU5XNExjSnJxZDh1RHQrTlo2UTRXRVEyVU1FcExsdHljaEVGK21ZVW94?=
 =?utf-8?B?MVNJd2RnMDFJQW9mMWpSK2hGZ3ZVZFBOZk5xYzBDbTVVSmFBTStTa3lGK0dC?=
 =?utf-8?B?M1dYZklVSlduY1NnRzJGUXhCbjdseWl1NFlHVFB1RFFROXVaaWRyY2Y2Q1hH?=
 =?utf-8?B?cFBmNnkrRG5JbG5URVc4WjZ0TWZKclMrNkpWOEp3RlFDSVE3OCtGMk5DSk5X?=
 =?utf-8?B?UktQaDZxelRhSFdxQnMwLzdORnhMWkJqK2hmVy9yZ0tsaXltcDF4ak91enkw?=
 =?utf-8?B?VjNvc1QyRXBtN0xQRnZLVUZxd0IyeFk5QXpnWlZDZmE3UWhYQ1k3eVkxSTgx?=
 =?utf-8?B?YkplQlZEY25VOXVsRXdGd1FwRSs5aGN6TzljbUV3MmkwNDNXN2xCV3RmKzlq?=
 =?utf-8?B?Y21rVzBRMWN6dFBrZUZKNFFabnVMbWRFaENORmJUbWhReEdxbUkyR3BhWUNQ?=
 =?utf-8?B?c08weHpuZ2VSZExhVW9IQ1hOQytidlJTVUVabHVkUWVLeUVVdlQrNGpjaGlh?=
 =?utf-8?B?VGkrYXB1SlQ3clBkTTl4ZnppTFJ5VnlvdEpScFU0V0xGMnROdU1nOFFjdlBs?=
 =?utf-8?B?MEp5cDZ4YnprMlF4NjNzNWtIQVhTWU1uRjFiYkxIaUpLcHZSbjRQc3ovdnVi?=
 =?utf-8?B?OWNrRU5sUXU3NmROd3ZuRW5zZDVYWU1zeWpMZU03aW5pbDVNVzU5M2dZZzZn?=
 =?utf-8?B?RkJ4bHVpb0prLy9CR1JEd3VaTEkzK3dVOUlqUVQ4Y1lxQnI4dlBxV1Q5c1hV?=
 =?utf-8?B?Sk9kcHZlZHlkVklWTnNUVEl6ZnpQQmlqL3Q1cWh0L0U4YVJVeDFKQ2dYZi9Z?=
 =?utf-8?B?eDhuZjJ4QWM2c294UGxVQVkzOGY1aUFUMXhJd08rMlI0T3VERUM3ZmVQcHht?=
 =?utf-8?B?aHA4VG1QcUUzMGxhWDEyaHpLNXpYeU9iMEFMZjhZQVBVd2o2Y2FXOGxISzRY?=
 =?utf-8?B?d21jbDhzR2kvd0xaaS94c3V2Qm1GMTdlWEJJSjdGTEtKZFZVSDdmTXBEdnRV?=
 =?utf-8?B?OWNHZ01PWENBZUJZR3dxb1RiaHJpR3JjWGN1UFJ2bjhuekwrS3M4aGF5UlhU?=
 =?utf-8?B?cjFKSWRlaFkwQTBHTFgyTVBETzlraG94MWM0L0hEbjdVaTZyUVZsZkhWeXhT?=
 =?utf-8?Q?r4cmLs3bVJKXSX7J748GWIVfl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504479c5-62bd-4fad-ee8f-08db8e6f5604
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:43.9712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sP0v8KgV8pKs9FuGCjSp2uXlfa/oStMREQ0JsWegP2Gi1g4nVHf0mnWE6HNpsjU9SsnzqmHjAclSe7RfaUD63Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 294dd605fd2b..160bab0c437c 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -2016,7 +2016,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_arasan_remove(struct platform_device *pdev)
+static void sdhci_arasan_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2034,8 +2034,6 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	sdhci_pltfm_unregister(pdev);
 
 	clk_disable_unprepare(clk_ahb);
-
-	return 0;
 }
 
 static struct platform_driver sdhci_arasan_driver = {
@@ -2046,7 +2044,7 @@ static struct platform_driver sdhci_arasan_driver = {
 		.pm = &sdhci_arasan_dev_pm_ops,
 	},
 	.probe = sdhci_arasan_probe,
-	.remove = sdhci_arasan_remove,
+	.remove_new = sdhci_arasan_remove,
 };
 
 module_platform_driver(sdhci_arasan_driver);
-- 
2.39.0

