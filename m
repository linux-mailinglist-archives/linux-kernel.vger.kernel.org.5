Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4297751B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjGMIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjGMINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F9E2713;
        Thu, 13 Jul 2023 01:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiJzUt/r1HqE+HIGcnxkbGtA0ftUcGcWrRsYMgsnGl8Pfc9Pa/+IqXAK3/xJzJtFu6HIs+ILUibxHyuc50ESeZyY8XsK8xUvY9jiKx7OYslJyoaWWjR0vzoKsM2cj9xoq05WnfKSWFavZrzzlKIwKr26us57T3VKjI229RiKl2MgApO3Rl6bv3aBU9vhARmZOciFSpe20IyHLgqO689DCAZJe8YGQH00w36LjK+kJwOIHlvZ8dU8PCh+6+5bUbz+vm7FruFIySIknwSjsJ+OcVpFHjON2xU7YFo2wPlruwLuriAKE2w89NCLW92CP2x0TPbnoeiAQfu8SFGqyltpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1UBCsQ7z6bjOfCJhKMKvjOrHl91zL75OXa3zGFD5pw=;
 b=cgNRixQ3hqrr142mWck/6YcqfFjCxOJDHJZOczV3uOdnFd43jQXnfLlD1JVeOW49oLj3DUgIYIQT2YAk4ohSelnkDMF8bDVVDh9ILIfzHAUpMiXAdaUpVzwL6g2MXHAjbwBeDmKyhCVgi4BXg9yIxMUQLXH0wXVcL+EOg+hZCV06WDot5oo+DVoo48j5yjg6oqknn9WFx11THxdXuNxVcC0Z/DDlLqe4FeXgOUZkXUHeVS7yHHljcRS2n8Np+YI6qKU74E52ydua0/6KHjiJUcqCcvjqaV8kho4b0Cy0kRsi2xtNtmB2stbMKhVXVSD1+WTuuc5Kc6pQwwZw/UQbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1UBCsQ7z6bjOfCJhKMKvjOrHl91zL75OXa3zGFD5pw=;
 b=WKdIcpNfGhjdxj3Tnqw5dwYVLqlMq/SQJ0YJ21F0TmejP1OOPD2g+tJC+KmRLVqM6V/j5HdDOjdFy/1d0g+IvWr3/k1BhKL0g/5YUyvaWRO80+qY0rz/TD37QqN+XPftJeEI/rEwc/R7lQXuHI8kETD8Zgupr5Cea/H0LNGnfUhsYeUG59hY0GNxwTrsO9WmSYyFmsLFTaZCyS84z8TOLQ9/k1q2Ye3XZMRuuNbcRbVoZXgnTI2tZGfX/8AV47rdch86H0iIy7Ov3i03+KV9GWZJj4XCk74ro7hhpPtRPmouFh8qHOjvRkgYOE7S64X3RBkKOCSFEUFLeCYCT9bCGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 48/58] mmc: wmt-sdmmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:57 +0800
Message-Id: <20230713080807.69999-48-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6190350-d205-4c88-c375-08db83788541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9Nu7LrpaNN1Wxq5GYKW2hAYSIjgTxmSeJQCXMVu1KYrjE8/1BldY2Mrw2vwKV7ne6xQx8OyqaYg/EgSDf6JWk86okYhHnPsddO/RxYVTYaVrh1E3orJy4i7c4YgABPgPVL7An+AvRJaiXbKbSkcnpMB4g5umK43VDoPF/EdPXlvwW9x68uNPcWwvgV+Uejy/7N+jSXbeIVx2feSQ4PuxNBWr2+uVdiyVB0jiATxvZBWYu2rL5MdkGGbKQvW5oCR5XhEdTTO9WyE8d+Kb133NiNHL4Zyj74JZ3ziEX7vYVqfsMNnMpSb15rIHHFNnEQ6HJfbgkuhjld/KQs0EAJpf+RWng1YTxjSMER42qsO5EAaemYQM1IGlDHOk2EfpfnzFgk7tj2A59FZB/S5tT8Z7pRYrrTBeng+pIOo5slQA7EOrhib92YUP+dhOX+ExPeQtOnF+RUxqrh/92+V2nHkFQzteFdqvTfsz94zKW6MuwqCILx4UzoT3t74bFL/vEp6h4pHemetu+6eFy+tSz/8nmMk0Twj2SUfkx+psnvjok22tyfGb6h6oJgsevGKDGXWk0oa07cdpnGMFs5RC+q9tx2XQuRebZQRKQoPb/87jaMVtIqMNOiCTFyRSdBFMLGr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(6916009)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktmOEh4NjdQS0hEUlp3MXpvUS9IWWFRRHFIdXpiWk1KMXQwb2NpWTVBZGtU?=
 =?utf-8?B?VnM0a0hET0Z4dmtERHlueVprMTVyVW5GQUJpblNlbEtEaytGTk9hUUt1cmxF?=
 =?utf-8?B?d2hTTTdCYVY1WStYaUpPWVVUMXlQUmtHMnRnZlphVHVUZDBxVU1XL3ZiNlJu?=
 =?utf-8?B?VUh1a0I5NlNkbHpUT3l4UnZLMHM3czRGRDhWc1dMYWdCWXNXbGtnVmRtRXA5?=
 =?utf-8?B?MUZmUmxzTXBqVXc2NUtTekFmUDZCTzVqcy9PL2V5TUxTU2RoWmJwVlYzY0lZ?=
 =?utf-8?B?WGVJaWVrOVNrbW5PQ1pDNWNoRnNVWWpRSzljYUZjU1lzUFA3NE9EQVc0U3Rw?=
 =?utf-8?B?ODNtTitDMVhWQ3lQOGJDYkwycDMxMkFCU0xCWUdQZzNac2xPS1FtMjRHeEJs?=
 =?utf-8?B?RGdlcysrMXpMNTBEdWlsVW03eXRrU0NJa05vaWZpdW1adGRKd0pzdWk2UEU5?=
 =?utf-8?B?UXhwYndEY2VySDNzblRkU1FlUzcxTE5qY0k3OXFQdzdIbzhBaXNySTB6Q0Mv?=
 =?utf-8?B?R0tkRFkzeTI5ZVRhZFFyd2FMQ0h0S1VXVzM5REViRXR5dndaQnBORUJIVnFT?=
 =?utf-8?B?WGplUDVqeFNaK1FQclBnem1FMWE5QXVkVUY1ZnZ6YmhyaCt6U2hiZjVPWmha?=
 =?utf-8?B?MUpCa09oa3U2NE14YyttbUFudFdVVmduRTJpbldFczF2STBTMFJ1RHhBV3dS?=
 =?utf-8?B?RnpvTnBXOEdDc3drREVYdGZUYlFxeTg2S1FqZURhM0hBV2JqNmxzZG01SjJW?=
 =?utf-8?B?NmFmdHlqZDZwbldacXR0c1h3UlNCM0J3VGYxUVFEMnd1alFlVmtJZTIxckIx?=
 =?utf-8?B?OHZaemtIREx6SmJ6d0FSdEJkRmJLSmR4SDUvNlkwcDMvUUxIQVlCSlBVRW9w?=
 =?utf-8?B?WFBKQWh1UnpXd2Z5UXlyNnZ5VnlzS2p4TUNXUjdwRFZ0QVpvMGJNbFpQZzFw?=
 =?utf-8?B?QTFYM3RRVFlSR0ZNN3ZwVGswenJpWmJGYTU5REtvSmZJa3RHWlUrZHhHa2tL?=
 =?utf-8?B?blFJcDAyaUI0TWc5L0tPU1lNbVIyaHpWbjFUWjJlKzY0NG9qb1YrWjAvWFRz?=
 =?utf-8?B?MW1ReFRCbVI5ZGx5THI5Smt1ZW11TkVRTGQvUEJOMEh6NDg3WS9HSlhsTUll?=
 =?utf-8?B?NjBlTXNXVnhwM2FsVU1tcnBBdi96WUR4Tko1cDBQamdxbFFITmxYYlZJN0s1?=
 =?utf-8?B?OTI1NTd1ODZQQ2I4Z3EvYWVYcXZSVUd3OU9YVVpkZ2VvdU1rQ1B1MzdhMmNi?=
 =?utf-8?B?ejlTbUZUbjJDaHM5bXRWYTlhT1FYYkdMT0dlNmY4eVdmaWlWOGdFMDdVY0FL?=
 =?utf-8?B?VkdCaTNOeUNZWU44VFRDZmRWNWtzdWhFczM4a3VNZERDMWk3UC9palVaVm9X?=
 =?utf-8?B?SkJPbjRTWTkxY3g0UVBFbkNZZHN0MmF2b1FQNzVuUWhCaXdkMHFXcjdwdk4r?=
 =?utf-8?B?NkZSNHdFb0VEY2ROMEJabUlBYnBXTE12ZjRQTlFtb1orU2cva3B2aWs4YzJz?=
 =?utf-8?B?dlN4OElIeDE2UU5nci9OMWVSVkJyNUI0REJEazZkbUJSdTllbzU4SXowY1g4?=
 =?utf-8?B?bmFabW9PcDdPL3ZIcEVlMThPQm13YzJDdzNHZk1NNGl6Q3lXODBDQTVQVDl3?=
 =?utf-8?B?NG9DbzJ2UVBkc29RcVBPMVVOdVNuTTVyb1lUTnB5WitoZ1lrNkxUeEQ3NWsr?=
 =?utf-8?B?d2MvUkJRdjJNVGJXaWs5eXFWOUJLUkRzWHlKMlFHelR0SkVvMG9vZkd3RU9u?=
 =?utf-8?B?TmdDV0Mzd0ZjQVI3OVF0TzhaRXUzS3h2V1pCYW82SnlHcWVOWVVuSWIrL25N?=
 =?utf-8?B?UXN0ZExmb3h2UklmMlJDeFVUNGt6ZjgrZHJVMHU4R1RIQmVsODBUci9PTjFR?=
 =?utf-8?B?S3RCM3g1eTJPVHJyTHNDaVlyMFoyU1NUYWQySTlFSXJPdUc2ZGJ2L0ptajVN?=
 =?utf-8?B?SDAwZ0Y3a0J4SU9jbm54a1NjZzRJL2FQWnBwcW1FckFUdHBieFNVV21yR214?=
 =?utf-8?B?RTVheFo2QWNVUUJpVVZNQXNQQ050NmxlTlF0bUQ1aVp6OEUxMUpUaGJpMU9N?=
 =?utf-8?B?ZXNMcmVBbUVrdTkyb0VDQlFaY3dRcGdqc3dhSGl5SkJlTEpCWW13V3RlTktR?=
 =?utf-8?Q?7ZLlOzioa34e4X2khu8p15Lf2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6190350-d205-4c88-c375-08db83788541
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:45.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8c2JydYd8+5owYGLYvLtWJG7yYyjfN3UVenSEXpgzLDHKENNHJL8kBxFydd8w3x/WDRI4igOU+srwaqGFMW7w==
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
 drivers/mmc/host/wmt-sdmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 68525d900046..74c475d071b7 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -880,7 +880,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int wmt_mci_remove(struct platform_device *pdev)
+static void wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
@@ -918,8 +918,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -989,7 +987,7 @@ static const struct dev_pm_ops wmt_mci_pm = {
 
 static struct platform_driver wmt_mci_driver = {
 	.probe = wmt_mci_probe,
-	.remove = wmt_mci_remove,
+	.remove_new = wmt_mci_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

