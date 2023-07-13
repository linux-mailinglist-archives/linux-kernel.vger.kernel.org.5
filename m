Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E5751B38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjGMIOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjGMINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:12 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951352697;
        Thu, 13 Jul 2023 01:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTUbUiVDjfZdOcXaVRu/p0N6vHQA5JA2/ECziUbeEHEqErDPiPVbp+/OdwgGHorWBTjc7eNELMHUfKpoKvVEZcn6GcEoPoLI15BAbeyq0zV1+B0YvsCamUHjXFp58t3knXpBvLrC6uSvFBAif52H0BqRKyJz7d9sfwiiK9LixI2TvZygHzojX9DYLOPrVfpzTFQ9UVui4Dj9MqYVyTTj9x0WjRF3BTES3dIqI+5X9YlnWMYQNhVwa/F7U79msGqekljBzh4Swa5TjI0hlXLkiKCiiAnBw7Gj2rRWaKAxrMP3mzjAGxi8c1EKi5m+8IsbGZ2VDpy0QRw8IooyGPaUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHKArmtjsh7/y1Aplpgib/ppYsMir3MLAx1CuQ9EKjQ=;
 b=PO7qjlb2ETwxoA6GsYJt8UH1sBFIoZNuQyQDwitOxvDnoFgrV+dttWgGs2TFUP7A6KKhwjV/LjFf44nffgTEO/PHPJouz0JBtn6NgrR5SQiI6jh8p4qpOgIznUq8PsNAnGGnjO0DqxrDPL7IzyaV9Tho/AbugJd1Ftupy/S+ULN2qqRvYrnjvzePFm1LEwyrLdw/rcc0EylqDpSItoezrVZkfLxp9BzsF78R3VVwLAnLZaH6kWvi78oQCpwxRSuEpgJj/ELScoOBfYCQNr9QXj33kMnvNHtN9VtXEYCzV3ZaipeUUF+k+gfFqFBRHTDldfeKOhF8cOBemKWDFlNmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHKArmtjsh7/y1Aplpgib/ppYsMir3MLAx1CuQ9EKjQ=;
 b=hoCB/9b83bukOsm8nihD6dKhcasQrUnfxS6UZgutGtntF3HYC79UKPXBqNSJz3IHMJ1x8C9PQeiodhJneed2A7gefRwK0/kmTcZnbs9s2UAxpqLva9JsIModSr9O87wKt6eqD1k2FCPwftYlOgDQAhKPIKAS6WRJG0cw+YmEL7V9vwiPeN6uCWzXNdCesSHqN9wBMjknT8UB7pkix/PqFcyR8i5IB9+G+bH21ZvDPqXwL90oqPIfJ0ZB4xT8m2bz5+6iOMxC5rxY3mpwgzzSkAdHTOOP/WkOwUA1NECjIHT0GrNTtdumeX4BJo1c4mIg3g/9cV23MRiH71zyUZF5bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:09:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 42/58] mmc: dw_mmc: rockchip: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:51 +0800
Message-Id: <20230713080807.69999-42-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e30de44-7a3b-4cba-ab6e-08db83787ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmGr9M3IOCAVX8UgHFFMApI5ddUQePQs27B8Yk2fsvj+kleKSuG+pXFRPKHOlm43AhFlQ0lgna8BYPoto33LmeRToP6rkjEFY2SgpFLWMPxCEo9p4oFstf29UD9j8aurYBHzwmZFgKRvpGaSEHor62YAJHUtxOGcb6iB8fo3r1g+yaG5IKC9NntpuIwgXl0CMLreL6z0pbKADdq/KqI71jVYcq5z77ILiYT8RdOTn8JiEV48nrobVqer0YQ4zlzFq/Wt0YYnYozhvobYfJqEvloKi0tQ/QYs3mhX3bD6aRVEG9WwwBUXlGVxnE/oZ4K5Z3lPP8cfZrC1sevVExISSZBGTZSxasUOqwQXjeK84uuaS5tXBfdfhWIQzuo1wFraicLnd5lkkc5w7B+tN2vblzSUHMIEWP/w1mEtrw/dAl3R9e6JdfhUvwb5i4W4cOHtlyvXSgWMvOX16YLoYWlczN6wxL1+7qOeMfGqo7X5JF0RY4HxlPQxTpE/8rnkmmqy+ljPPrs373uz9VOJ1QcMgp51p1chXvqrJwHSq+k8uF1lHKBx1NmhiOtn9PlzxGKFNCqcFeiCg2+oJpEoO5t0tEJKnEgeYu4UOXunLrmP+nJJfLy73np5iMgPYCwhmdMv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlreFZjR0JqSmdUYndzcTljbWE4OFRiMVAycmtjcDlGcjFYMU5SSC9KS0s2?=
 =?utf-8?B?MVRkeXpPTllRMy9hUUE3QkQxM3pLTUZzK3BUTTFac25lZmF0Q0dweXAzV0hL?=
 =?utf-8?B?TVlMSk9EcklHTHRkLzAxY1ZtRXdHaSs2bFJZTjU1UVUwYkYxaTlrcW9HZTU4?=
 =?utf-8?B?L0lnZFFZbkVVMmwxcElVRHNIZTk0ejNTVGQ1Q1c1TUtubjNaQzM2bU5EVDJo?=
 =?utf-8?B?RmVwVVRrZE5KK3J3dVUrNWlNUHlPZlZkTVplMUZOMHh5bDhrQmJSYUNvZFBu?=
 =?utf-8?B?cGxXZ0hncDZxMnJhNkd1ZWpJRFhpbW9lTHZzbHU3WW92c1oxeGRQSGIzcFJu?=
 =?utf-8?B?N2M4MEViT01NelpHUXNNNjB0RkFCOFZ6Q2U1bkpkNzNBSzVOMElQOGEzLy8y?=
 =?utf-8?B?WjlXZkJIODdSOXRzWVlUcmo0Q0x0QXAwZHJURFJDYTV5Q2YvenR4dnJVTHY5?=
 =?utf-8?B?TGFpd25ja0N6eFczTy9Ib3FqeVltU2dqRmdvM1Rta09JRjQvalM1MmlOT3Rn?=
 =?utf-8?B?VVJ3a3UrYnBnZEQwSDhwTTRNMzkrOHJBUUpQUytnc0c5T25WdHVjOWJlcVky?=
 =?utf-8?B?K1hFVkxoV1VqVFlOeU5DV0tvRU9mMFVFbEZ3U1N4eUc3OER4RHBzQU1PMHFV?=
 =?utf-8?B?aVV6UTN0TjdSdFM0amVUaHBtbTd4Rnk4Nng3V1hpNFJSeWVxTE1zYlQ0Z2tV?=
 =?utf-8?B?RjRQdVpQOGdjaFhHM21JbjFRTGFEKzdTem9WY0tkTmpteWZzM0hNL0pvUjhm?=
 =?utf-8?B?bjk5WDh5Vm8yRThJVC9ucS9kSERoazlsTTA2M0QxaDMzRVVaOWxLcWFIQy85?=
 =?utf-8?B?VlpTVzFVcUE5WVRzKzZnT1A5Zys3TEZMNnc4WTJTRXVjb3p5dFBtZ1UzV2lV?=
 =?utf-8?B?bHhPRWxjVy84VTg2bysrbDZKUW5FdElRaFJkU0NVUWNUeFAyelFxcjlvMFFq?=
 =?utf-8?B?MEpkSVY4UUdqYXFVVGczM3g0am5CaGUySEdaaDFoSXU0emVmb250WFVHYk5i?=
 =?utf-8?B?cDNWcUs2Q1pmM3lLWHNhb0UwRWZGMHFmSGErQ3A2bmN4azNNUndJU1Z3bDQ2?=
 =?utf-8?B?WDdJaCs0eWtpRXB2MFB2SHd0djFKbVRJU09CUkhHdUJPREFWZjAzZ2tQS05L?=
 =?utf-8?B?UGYzM1kweHZkQVU0WmVybGRrM2F3cDlhQldiNXV3S1BIbDJTR0JRK2Z5eU9l?=
 =?utf-8?B?TjIzdzJKeHd1anBnaUx5QU04c29WQ1MzbStEWmgyUHZOdjhRYmNNY2Q1ODJt?=
 =?utf-8?B?RmNubWlzZzVIOGdMZGVpajRZWVVRTDk4T1FVU2VMU1h0OU8zQ0lGbVdVS2pW?=
 =?utf-8?B?ckpIUlM1cjhsdXhWMGRvM1UwY0xBd0VDOTNRRUFSV1J4UlVsWjFybHByYXlk?=
 =?utf-8?B?OXBoWWRWTmRTZEpzbHVCWnZFbElKeFUvbTVNK1BGSDB2S2IvL3JjVkZXTnN4?=
 =?utf-8?B?cGlieXdVczM0RXgwZE84bHlXR0ZRVE1qRm4zQ1dRQkxYQTJKRzVia1VTUGdm?=
 =?utf-8?B?VmFFa1VzODBkU3pjaEhmZzRoU1RObVZremM2QmpkODNna2FOam1oTllaeGlp?=
 =?utf-8?B?MHcyUGt6WWdZb1UrUlNSemowZlJScVZubWdVc3BMZjZycHVRUEFQaEhqbExJ?=
 =?utf-8?B?c285VU1ldVZtdi9LRWFTS3hpV2duTXF6QmJoRFh0dUtzOFNGUHRHaGpqbkpL?=
 =?utf-8?B?MU41cDVQT2lyWVhIOGo3Qy9mRmpXWnFidDJMYXJNODNadmM1cHhtTmxpNXZ3?=
 =?utf-8?B?L3ZuenZ0YXZLcUFNRXM3OTlQSjRIMWM5Y20zSlpJKzUyLy84cmlIODJyUnFX?=
 =?utf-8?B?bXZqVXRmZWl4RXBYbU0xQXhDckNNOEt6VG5Qb1Q5bTRCMWRWYStLOG1KbHRh?=
 =?utf-8?B?UmgxOFVVOVc5OUZmYnVLWTFJQXpqN25Pby9tSDU1KyttQ2dPVXN4Q3FqdUFv?=
 =?utf-8?B?WjlCcU9wWDVvWjdpNmZudzhTOWFjSFNuSVdiRml0WGFjNURrT2lORDlkaHQ4?=
 =?utf-8?B?cElDVHlQeUtPZ2JnVnVuYXdYWktyUkw3eDNMTWpRUHJyTDZwbGRrUy9Ta1Q0?=
 =?utf-8?B?ZHJBT1o4eDY0V09vUGR1QkpzOFMzQTZDK2NGd0RReXpkT2kxVWpnaW1WK0M3?=
 =?utf-8?Q?UNvhC4Op+krFrkEJqbUfRiqAE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e30de44-7a3b-4cba-ab6e-08db83787ee5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:35.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHsObpeO0K3sjY/clh6lllkMVflWjT1m/CsRKPqg1LK/tEdnRsbB65ABlgufvV4QO+26zs3fK9OWTOzXUPBBQA==
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

