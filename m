Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535EA751B54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjGMIPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjGMINg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC36D272C;
        Thu, 13 Jul 2023 01:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqAMPMlPlBQCWF7NTB5SSxSqLcjQKNJicwcXR3/2BE3mesAgG2bi3aroYSAxxnCOxv+DnVCknriacpblSreYbM9ABxw7soxinN49EE4AA58vpNv58PiNsEFIIkP3cjtS2AQUgsYls4/t63NUX1SJCyase4dgecI6QAy28jlubPEduKPS6Ti1ZoRxHkwsBYEvyLpg6Zg3vZdoVimT9giXd38FjDgDs5sye2zhYGRQi9aR71VVV4PUaQbm3dDFCmaXIeJHCOt0u0ptaEaKfRlVJqvAnmrnHoWTPzp9KSILnOGvBrX8IzBnDcdYEFsskqYnkbdjNkM+0hCv9LBtCEUBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gufcrtSc7ru1/F0WuXeyzF62082GBJEpWsdrwZ/EIrE=;
 b=F3yDA9wUxKdLUdC0Tv8TxQzg7H5kscuwn5OSr0ainEE3AG6lBWGlcr3TUShp5aCclbp4CGjVToRRjDQFwv5Blz9zeC1DgFbsJHHjOvIjYKJYlb7+torN/piZOhrG8b4NqoHkVXqrtp/1W/C4YFpDvRyot68iY9WN4mu34VRCB9kQPIA08/S5PXwRmXqku5kQU1ObTt2/E5jBtXUM4QZ12+xEU1BjXl3+AjVt7xE+WxGmAQAa3JSJhtejYIExk9VqEA2p3DkFKU+u/B18SbUmjR8g4RDLbZKUf/SDC9lwwDp9zQNGf+IgRxR/Oivj4Kdw8B4ghtmKWy9hLKsImUOA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gufcrtSc7ru1/F0WuXeyzF62082GBJEpWsdrwZ/EIrE=;
 b=nU9NtELbuMTVU4/gqQ5Rhl2l8FxPMJfu/QB5QZSlF8uMDhlPsOKGsBGqZ3IVqvxEwnDqxDk6gbevid3RkepzweQqeEYOGhM8KXPN+IaJ8PPX/73zgQquZEUCYgWncWOzNPPdepaAmwQCh/HsWGwMqynGeNvtKnDe66J9lvJD5Kh0khxX8fdpkGE8LJ2n/bUXnriBlEMxJuqZQYzM3557l7YoIVc5Q5PPOAZ+exqXW/nTz6VDXGEECcloaV8iXtPl+G5uFk0udaY6LbUuVzHp0Qz2keHzSO5a32ewNTmZx/JahhOXn43bY5P5JoxvbtbB1y934HTsymS7nUF1MCtkgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 52/58] mmc: mxcmmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:08:01 +0800
Message-Id: <20230713080807.69999-52-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb25ffa8-e46c-4ebc-8cd2-08db83788928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tC2P5CFRChKkNBAg8h2KSIxmHO+uENeFUjd67eL/9CUV8TzyG5h1E0uAV3vIxkQKHqFGwjDS38CJq5r7hsD7jpLJs1YA9GdpqtTgeJYVdh8F35kQUiMcwYW2HWU4on8ApMfvHfVDAJtW3JuCIVpUhEsvZ4Gk4IntafvEPPSsL2aol7XPZsLOFms9wiH1Vso/OzFfRPpfDdlB+J0P89m+yMRoOC5ucZKLilMgj9V39DwKpZM+hYSn2JcPf4uxdbTCmvYH4ce6tAWqFGhbBkDOCjHXj/3kN8dRNPDFhcjX6o3jTyh+r3ZYtfKJjSIvsI0YNU90QtKtm5B1zawAcrbALIBWRh7+A49RtGNZnGoKCKtANIdpELK8K0DCCdyIbzo/D+nguIbx4BTJzt5LjgMQ7Ut/CYyEBSoML7U6nTZeLBARnP8IHpDMVySS0woRWYUuFKsXbNBa9PnJ+YF7j3Yqwd4RkwUTnasUhRPayM41SS6jeg8FFO/srThDzWnxuDHSyLKBhJULFLthlQOpyck8FWHesUxc9Xtx9A9OCOcrHaN98x6Ik+YiM91fNZbZfEFT7TbPfhP8/iPpxght4+0gxq8dCN/3IHaE9zyEfWs7rNxE2asnRpTqPw3w+cqlxky4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(6916009)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hyaEVGb1JaYkpZUm1ySDFsYzhidGd2TUNUR0N6WDM0am9ETnZ5eXlra0R3?=
 =?utf-8?B?QUFpNHNJMVhNNmg0TGUwbHZJODNkU1RqbkZjZGo4djNuSzVlbXJGR09RSWxm?=
 =?utf-8?B?dnZpa1JZOFk4aVF1WHdnbEFGQkx0c0JBU1VIZXZ5VElqMjZXVzFtb0dDRlpQ?=
 =?utf-8?B?QTFMMXZMSkZmWERqL2VlVjVkR1lOVHNobUlGWXhZZU1tUXRYd3F0eWFLTm9G?=
 =?utf-8?B?THhQdjFsV2lvM0ZlV1lUU3JHcXArNXllczNJbFY3aWhaREZUWW0yZ3lxRFBs?=
 =?utf-8?B?cEdnTVlmSnlZMGNIVHA0eWxmRERIV1ZzK2hSVGFoRUtWSnhmOUFFRWZ2THNE?=
 =?utf-8?B?QXEzcUpocGluYW5uRVlPYTFUY2xPMzR6bDFEMzlmNDdiZTZ5SzMwTWdVQk9C?=
 =?utf-8?B?T1RlTHJvbExnakNQRG1paVdCdUF4djlLRXc0RytqTDJPOEt3dGY4RVc5OHRL?=
 =?utf-8?B?UGFveVdmRndFU3ZWRU14cWFqQTdYQU9TN1JIZExwek9xZU9TK2FjTVk5UzlZ?=
 =?utf-8?B?RkJBZHJuMmJNNEN5TG8wN0JpcjhvaDZZNGFtazBVdlhKT0swY1Mwc0c1ckF4?=
 =?utf-8?B?RUNGVC9EODQ0NGFxbGhOK2d5NXlXTkF1dUprcWNEZG45UnI2VzJCd3Z3Ri9M?=
 =?utf-8?B?MUR1WnBYclJzRXEvN1lNQWt2ZW1XQWxhVDJjbzY2VjhxS1hZeTNVcUFaN0s4?=
 =?utf-8?B?bjdGV0V0ckpMc0JMNGRZZDhSbnhpTm9EYjQ5cUtvZ1hiV2dYQ3BCeEk1UWZL?=
 =?utf-8?B?MUVyK3UxOTNOQ0s1TmxSMC9weDREbDJpT2krMTlJUzQ5MXV4ZDIySWdsbW9B?=
 =?utf-8?B?ZElyY1lGYzBrOS84eTZ6TXlpcG41c2xjNXk4WExRWkdRVlFkMW81dVF6Nitl?=
 =?utf-8?B?UGhkTzJIUDdQdkZIeWxrWXRzZGxacmdBamV2OTAwTWJYSytEaGQ3Z083UWFz?=
 =?utf-8?B?OTNtYUt3S0dtNlBna0RsZTdEWUhTNlAvbEdCMmpQeXorWWVkeGJxZWVqcWlt?=
 =?utf-8?B?dXFLeE8vY3AwVXE3bE43czg2M2dzQ0d0S3NrUG1zV2tVRHE2Mm9QM0l2SGdP?=
 =?utf-8?B?UGpRUWVCaWZTbUxTVVZDMTAzemJwb0wzaWgxb2ZqUE9keXR4dzA2dUtrZ1Nk?=
 =?utf-8?B?YzNFL2FsWUhxNUVZMkloaERqZmt1Q3Z0UTdSSXdCeWFIZGdHMjM3VTAydDZk?=
 =?utf-8?B?UmQ5dFdpQmZ5bjd5M3pYd0lhV1RhU2FqSkxZWkxpYnNFZDRraUcrbVllZEYv?=
 =?utf-8?B?Snh3RGRrUDI4ckk3QTFhK0oyMnR1T0lXZkpUNWQvMTNPNGtobVJJb1lEelJY?=
 =?utf-8?B?alhTWXRJSEZRS3hFQm1md0lCaWI3ZGhicm1YdlRST0oyYjl1aThGc0o4RnB5?=
 =?utf-8?B?UGJUUkJFYXJQTDN0VytLNDl0R0pSbmpDNDl4MFpLZTdKWUF2UnRQQzVGT3hm?=
 =?utf-8?B?YURBc2FTZmJxN2YxaUJRbGFjSUU3SXptWDJQS2gwb0xjbDBiaEFsSUVRWFZF?=
 =?utf-8?B?QjJHeUFZMjRmUXVHWlpTVldidVVvdGlKT3NpODY3djRKcmNJNEJLUXpPOUh5?=
 =?utf-8?B?ekN1Ull0RjdleGxUTnRSaXZIamtpQ3pMMFRVRkZrZ0lIbGNzWHlneXZDYytm?=
 =?utf-8?B?ZUlsTTlkc1ZOeVdhNERSSXhVcUhJRzdHdVRiOGhaMDFqRnVFY0k4enN2U3RU?=
 =?utf-8?B?MWFWR0ZtNUgwQnNZYjZqRnRyYUltdTRuL1Q0Q3VsOHF4Vy9zYTJDSFdvMVli?=
 =?utf-8?B?NFQzNGJwdEVDbFlMOVRLbWVCUDkwRCtWcnRVZHkrUGcrblJpSHQySG1RWkZp?=
 =?utf-8?B?bTQvZHhQZFRUbnZIazRHSUw4dXp2Z09YWW5XWURoeXpFUXYyMzJWTUthcUNG?=
 =?utf-8?B?SFFjS1NVZ0dFR2U5cjIxVERNdVBTSENiaVNKSjRvRVA1T3JRWGhZVWF5NXlG?=
 =?utf-8?B?NkVDUEhhd2toV21rNmxxS1EyMUt4Z1VrcGJUbWV2WThPbHZOMmxGRzlwK0ZC?=
 =?utf-8?B?aXc5SzIxUzhVTndiWDNpNXY4ZlZxSnBMTlN3SDBkMy9FMlM5RWtnODBMSGZr?=
 =?utf-8?B?VVpBZTNLMHZxdjFONVdVbEdvL2xUT2hva2xqTUZRUzlsUmdmTGE3cVhQSW1u?=
 =?utf-8?Q?l444IFpf7ABB5DDpNMTskokBk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb25ffa8-e46c-4ebc-8cd2-08db83788928
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:52.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QTu+e9zs53vgbmOGX2Rvio35189z2plDzGcZoT8pzz7WxhmD/qfpRvGkMgiLInefETl/SP8CLhfk+su3HN6Bg==
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
 drivers/mmc/host/mxcmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 668f865f3efb..c46276bc21cd 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1164,7 +1164,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mxcmci_remove(struct platform_device *pdev)
+static void mxcmci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct mxcmci_host *host = mmc_priv(mmc);
@@ -1181,8 +1181,6 @@ static int mxcmci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->clk_ipg);
 
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static int mxcmci_suspend(struct device *dev)
@@ -1216,7 +1214,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
 
 static struct platform_driver mxcmci_driver = {
 	.probe		= mxcmci_probe,
-	.remove		= mxcmci_remove,
+	.remove_new	= mxcmci_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

