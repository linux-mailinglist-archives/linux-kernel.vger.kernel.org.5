Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC1762A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjGZELZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjGZEKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:10:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B955AF;
        Tue, 25 Jul 2023 21:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyNmThcm1kSscq25OqpvnycHq26a4Y3cv7U1pytxIQEQTlBYBUGpFTFVgBjvUOxhPZ6zxKRg6gOoxipB3ZaaehmhIS+VlZLUIT+UWXY5MuuUqKFYBoTWirN3UICCdgEhw6GeOHgQJXLRgeXBHCPWkQGnQoJk9nuK5t8QYb0X6BW5ybzZL+UA+QXAcLCMxOmemA0idqHiWnmyNLAr0Nolrjj8q/oQd6JQLcdccz5vGo77YPW/BjyYVF1/kue+nNPrCgLKWhu6jJ2s7XgywIhYdIXzsEF480z9cS3WRUgwd8NmOHmYGZ/XvaerDTuc7UjyRNFwU/h4wcF8Ubmipvw2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiMupy/2gpTgAg4IecGGpHWMYbsCUu9rI2DrKBUHpxE=;
 b=HUMc24r8VX30CIhGXXDYczYM7rBNjzX8EnvSxkreGUP28PpDxXs2lzTfRbg7Hm88qKmQcAmA2yERb8R3KM/QRR/N0hSJQo6Aw8tiqwYDbAvrLbcWKZ1sLOoahi2tX34kHFxDv4NnmU/EQPQ1gdFnmv+JGU/KQC8ptA5yT3z4/OHpwxRn/C+KVX4wlWQaJ7q8+NSSNAirWu/p8GH4fCr3/sFeBBNnnQimkhIm1pPo6yFW6ehxtWLWZYzD93scHL6KbT+VCJRQVj150dNIzsOzSB14cOOC2uWX/uHFl1L+Ipcd5886ur2otIWeNABhar5GETaRGbMWufy+FTOK9MPzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiMupy/2gpTgAg4IecGGpHWMYbsCUu9rI2DrKBUHpxE=;
 b=ftkvdvKQHITpamX/abaxDN8AeZeZRd/b/LjYBdiCNgSoFMKUeNgjvRz+VSy/nWkQ7kic5O7yuptqnLIf9a3f4hcS2yQwprIbADPGREnofAkFZreEcgYkOzWndtzhf/JzvPRZ/w5GzXh4YxcZeLa9WqrIG/vlRjLEOSRhxNnGcpWKz9xYrPWJ2SXYpzbwGrH8hc0XgpHKJHwqq0Zsn/bc1N3l2kG75aitHOtQ2O+Bpc2n2zo3QiNCWzMHb8oXRbc7f0bp2tNXxVruvtUdyxx8FTd6s549OKu3EpQKV9pRkFDt+nFfjtt/cB7rCe+0mHtxML65S0o69eRUtyFbsKYeUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 57/61] mmc: renesas_sdhi: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:37 +0800
Message-Id: <20230726040041.26267-57-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: b90602b0-d6f3-4a13-875a-08db8d8d25a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHIaRm0sT/Rt7uqWItjN+37JinUhAOict0ZUhb04EfXXhzvgUNAWzEXReDWDsSI+jkbz/hEdfV+fhLBI+dsn4/5Fa3nIAPtgdzedzrQvPvgILqmiIMUr+qd5Ocal51jZGKqC7ElPNM6d6IeiejWMTpVw6netn6sAWbIIlnSyTRP5IvK8utwWx8TP6h6smA6Cr9LAWcUmPIRJDVLhxBGatQhvJ7fShFkHd+Kb1PXBqFAN2DOxdEM9o9cq6bAuh5o3xNy8DcxsApEe3G2vpE6fR0cQknfNugB2MlEbhDlHFA2Hv/0dw9Qc+ICgCdow3rbJIMn0hsRtTJD7b53kE2HFMQbAfYd2CpQ/JKCMFstWm5sZE3l89VeKQZQgCniuLJj8xjCiRU13PXTC3VRmALfkC53V/v4+BxVTtYXYch6vUZ24O+i1vcFkvfqwpOqW3YimkprhitH9B0h3ukklLowIJhglNYObvE4OTXK+QtZfynkfzxWaMm16ZJ2VcYsuPDSEq4db3z44gPOpLO39gX5gkunyMH0OyTj2H+kdsRGH8OgyTm0pVHSs5jPFY91oSqywp/oW3gHqaam7dbcvwRNadQevooajjE5ll3yOG9co0g1PYag3eRHtctaojywio1Bh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZZUzNFUXFCdUlFSGFzT1lObFg5TlpvTkZ5bURDRnBsbVFRWWFaRnYrZFlR?=
 =?utf-8?B?YlB5SVpMWUtRUEtodmZoSFFoSkRkSUdsZTN3c0ZmOGZCakx6MGJKT2ZoVktP?=
 =?utf-8?B?Y1dBd2cxNWVhMjBDQ1Qxb0wxV3V0bkoyL1cyUFFHdWxXbldmN3k4blJLYzhj?=
 =?utf-8?B?cDdGN3lmT1pHUnVEM284S1FuWWhKZ0tVM3BGQ2M1MTREeDBRRHpJZTd0cklk?=
 =?utf-8?B?QVlnVFNyUERwd0RBVWV3TDFCUjJvQ2k5czdYS2RyNGFyL0RqOHhNc1FqaUNy?=
 =?utf-8?B?RGZPL1RScURyRVp2Q1UycVUySkVoKzY3R3dxVnIwWmdXRUFtM0xhZ3l3QmNk?=
 =?utf-8?B?NXQ0RnFjK3FnRGhrZEt2MVVuYmFKSWFkUVhabFhMVlFCTCt0ZEQzb1AzeHE5?=
 =?utf-8?B?QjZjT0htWFBJdXExeEgvNU11a2xuOTdadDhzcE5nMzU0Z2t2MnZzQVVEU0F1?=
 =?utf-8?B?ZE0wb0RTN1RMeFdmdlVYbnhqMk9nVmVSS2doRVdlbDBobXBBZFJ1NU8wb2RH?=
 =?utf-8?B?MXgwKzBYVyt0UCtUYUVpOHlXVzBtYU9oM0VXL0pZR2RodHlQYU83bkNZWW1Z?=
 =?utf-8?B?eFRKVmoxbUhWcFA1R2JBdkhaR3FOeEIxMjh5NlNObGxlTG85VDBkeVlyNzZi?=
 =?utf-8?B?V0drU1oxdkJ5bkVmUVFIYzdmS0RvR0xmeHh0a0YvcDRJN1dGbVViWWJ6MUg0?=
 =?utf-8?B?ckdLT0hZVFg0VE5yT1F0eU9EL3JYTW1SQXhTYllOUUhvTUg3cmI2clJZMi9R?=
 =?utf-8?B?ZXhuNVExbDJOc2p2ZVZtejk5VzFqeGxWRTJkNkNHK0RPazQ4blNlOW42ZldH?=
 =?utf-8?B?S3NPTHdFRWpZVTN5aGJteDh0YXZLWWduem1vcjB3bkVPeXJaQ2JEWURraEIy?=
 =?utf-8?B?V0xRdjFRSUNraEJzaU05TlNYY280SjBwRlJGMlFyUy9WcUZUSXFFeURFM3hR?=
 =?utf-8?B?RHhKYW0rUFpDdWxHQ2xVayt0bCtpeTk0MHdDdkJYUUZzanFIWWxrSUdJSHVx?=
 =?utf-8?B?UWUxTlk2U29NWDJJRFdycVdUUEFOMUxwTWxtM3V2UW5mZlVTbnh3d0pVaUkz?=
 =?utf-8?B?R0ZLWEVlNE1oZ2dVS1VCN3ZyVXlPSHJlcXpRSU9wSkEwTVNSWGlYcFJ6NXVC?=
 =?utf-8?B?dDZvUFZwVzJzT1U3YmNuanAvZVdhRW9ac0FJRFBEenZ0b0JmaDFLZW5jYmpx?=
 =?utf-8?B?eHBXQ2RhcUxDVmdISGxsdzZ6NkNReldkUFZGSmRFV3FhOThUK3BxNEVncGJ6?=
 =?utf-8?B?c0ZaaXlxR29Ya3ZORVl3eVQyRCtoNGxiK2hqVko3a09rdU13ZDV1VjdMcHZj?=
 =?utf-8?B?MzUwNGpja2xnbDNMRWloazAwNjJmVlAySWVVZEV1ODBhaWpybi9rb2hDNUty?=
 =?utf-8?B?cEI1dysxQjFGYUxIcnFSK0dxalJlam5jSWhLTFl5MjV4TkdvUnVoSU14QVAw?=
 =?utf-8?B?NHh2bjVNb3Q1T3F0Y0hDL084a3ZkTzNzTFJzNDZFelM3eXhaUUxlMmdMRC9v?=
 =?utf-8?B?VWlscnNrUXgyQyt0RkZhckt0OC9sZC85MGlBd2llMkJON0ZRcXNsQWQrbXYr?=
 =?utf-8?B?eStZTWVzaHBLYUhEcW9ILzZSQjQzYmdpV25jZXVEdFBSeURVMERGNDJZMVVv?=
 =?utf-8?B?REJEbFhlQVR6ckVMZzRKUjk2dm14UWZpb3FLSXNZQk9LSlFnNjJjL3RBUFU2?=
 =?utf-8?B?YXNOaUJaaUw3RE11TE9CV2U4T1NxSG84L0dDbzdPVHFuNnpIbDdGYWxIT2Ru?=
 =?utf-8?B?RHZQKzUvc0lJTGdOdGpUMzQzY3A1aFpaaFJKWkpJTGlGYXNKY3hPMEpjWHlS?=
 =?utf-8?B?eCtRb1lyTWZRRXJRcFdXOTdlbVd5S2NCQk5LQ1RyK2hrYTEvS3lrZENlS1Fq?=
 =?utf-8?B?TW1DZytqWWw2M0Y4SEpwd0V0R2lkSHdhNG9HYTBiYVplc2FPaXR1SUE2c1FW?=
 =?utf-8?B?QnRWSVU1dkpKNFFpdzhJVHpiV0JyWk14V01hTUJxZy9uU3pnOFV4bWhZSXFw?=
 =?utf-8?B?NElQd0x3UlF2MWZIcTRXUWsrYjdHTHowdmVXWmdmcGVUd2oxMzcvUHNqa2Nr?=
 =?utf-8?B?d1VwclFmeGxhL2ExK2tNaHViaFAyazFvcDZGdElEUG5JK1VNWnJYRWY2c0Ir?=
 =?utf-8?Q?L/FdcVxhTxQldXFf4CP10QyAK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90602b0-d6f3-4a13-875a-08db8d8d25a4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:36.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCqGkKw497mu31AtMfQiwIG1rAYpUBc/i/GD+y7Uu346FNYLXToBlpyGCO0ELRRWl9j2NrW6Ii8b05lyh8PRiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/renesas_sdhi.h               | 2 +-
 drivers/mmc/host/renesas_sdhi_core.c          | 4 +---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 68da3da9e2e5..c1fb9740eab0 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -101,5 +101,5 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops,
 		       const struct renesas_sdhi_of_data *of_data,
 		       const struct renesas_sdhi_quirks *quirks);
-int renesas_sdhi_remove(struct platform_device *pdev);
+void renesas_sdhi_remove(struct platform_device *pdev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 10dbdb4abc93..c675dec587ef 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1149,15 +1149,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
 
-int renesas_sdhi_remove(struct platform_device *pdev)
+void renesas_sdhi_remove(struct platform_device *pdev)
 {
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
 	tmio_mmc_host_remove(host);
 	renesas_sdhi_clk_disable(host);
 	tmio_mmc_host_free(host);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 9ab813903b2c..d8efb8035b1f 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -609,7 +609,7 @@ static struct platform_driver renesas_internal_dmac_sdhi_driver = {
 		.of_match_table = renesas_sdhi_internal_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_internal_dmac_probe,
-	.remove		= renesas_sdhi_remove,
+	.remove_new	= renesas_sdhi_remove,
 };
 
 module_platform_driver(renesas_internal_dmac_sdhi_driver);
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index b559ad38b667..248dfeef942a 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -470,7 +470,7 @@ static struct platform_driver renesas_sys_dmac_sdhi_driver = {
 		.of_match_table = renesas_sdhi_sys_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_sys_dmac_probe,
-	.remove		= renesas_sdhi_remove,
+	.remove_new	= renesas_sdhi_remove,
 };
 
 module_platform_driver(renesas_sys_dmac_sdhi_driver);
-- 
2.39.0

