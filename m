Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B5751AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjGMIKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjGMIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99D12D41;
        Thu, 13 Jul 2023 01:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYI7UOqfntP3lAzRhHBWEC8NvP0y7VqIEmP38m5h0qzVTGp8fgFtjAu+UP/tf/pSx+WyVJKPA9QsAG3CKijMjmZ2QLZEUQOuzZXMTYC+eWthcaxu/HZS/MxVcbRTD1xsVSixU+ZBHvIQdzhzjZNegHWR5u4d1SM+hj8WlnNjN5+gaYaX2DtncZmXqcj0eTF8MRdoYTNo3kfsYtruplDMa2LkXKBMYmM5yvMa43S2qY2kJKNsAnPFfyU0mdHQs0dbvsRiAehHccnfMBeF/z+HnfxjFINFnlHmfGMyJfkO4ZQPgyHh27kWKwS4G1DDN3ExKfFbMjToJJSt5NcYsfYL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7okkAtAy4Ay200gbDx0jngJNeo2uhW4SadPJUa5pIw=;
 b=LvktVay3YTVhdTqxYwhVJBuKkSCu50aNT9UMYHPlVRrZ7P8hShM0Mtca4TcMFRJqVRMx+HuaoUXqGJ6fP46+htwNc4ID2SwqmWKPVgEoEoVwPFw+Qtucs+NgdlZsbyAcTKsHKTAzsQaeDgcl+N+Ggtq7P+mSNYmjaBB/dLbzrxwJUbaFyQypkgzae6TkGPDQhJG/yOMxlaSMR8KXmhYrE3/6NWbWvqNUmJxN2GA8BLEJGwtVZ9U+cj6TbuyaNG0YspR03+ITw6NQlYYgAaxf6IMNdI0BcbZAARuyo+rwffVDRqPqd8FRdPsrm+UyCiPDkdY2FUEVz9JIQG0RNlcWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7okkAtAy4Ay200gbDx0jngJNeo2uhW4SadPJUa5pIw=;
 b=pl+acn1cSrbxjBqOq3SwzoPXf0G2eXIdB0v5lO1bMtNWpNDUXKutIN87T3S40kfQWSF+FXPw5gmwgi7lLUGT6MYXgUL5py/n9KH17nUKdFOuYyXDTSSBaufx1X+x4cGzq8b2GIyObyDgSyoc9IyD8ruJQyX0QqT6uC/8417fJ7qyi2N8TkQZQnfwTFzGjtv88aCUQPHK2kIJI8xHz/Qem/2suHqfC/rHpp6UYT36gEPUs14IgymQuupQ/wui1k4phL1H9m8ynSA3LMRhIcdhMWuEY9NHVvoikGAUZTsGkT7o97yxqvwLMYXCJmaCjdkHIGnPgwx2YAZt1J0IX7D/LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/58] mmc: dw_mmc: hi3798cv200: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:17 +0800
Message-Id: <20230713080807.69999-8-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 1195ab68-5db0-4687-d3f8-08db83785a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK6oeS92wjovEoWqY5W3bDstCdV/+St2nk68mW00A+oOsvabjR/UnKcpBWsTLvGCeGS5aTSkDUeopleuKiO/3dBO7M9SKWqnaEXbJSrBvY0qMz8oBF+Zc91gSRLn2V0cN5XYXcRv8q6TqgF6QYRhiCxjk0paj6LdsOHelFzVmy7DmerumZ/kGef2HZU9AU0i+C71AQzCTPt7rB2V6LtSkmGOuLLrWQ0cY0lh0wIlO+hlsXz3TTkJDTH1J6lM4lwqej/HMH4WgBRQS5eWXJvVhP+TgdchtUX6J96Ln/WM9dlptS1Co9aIbOAI/sHac8cjpGYiG21PTgzTk1R8oUjEQskt1SWANyWH8K6yD6kJt/CacSgS4GdWvbpF/+45PDaseC5j4PoEmN1tD81htf4nUfuskxqXb5/doGVI88wLNwsP/CAkNnn7ekIG+nj75KF6JiVlYjxP0DgvCmFm6M3NazgsOEz3utpq5YHVGyfEimDyLCfdQb9n8mb75zjTVbU6+HHb8i+TcMxuj2YEeZO3wRKprqGiN46J8uctW4OjKLo78IKi+9C718zz5hyusVgbMXaCyMev3aO5NDP4tOU5wboB2btJeFqeVbB/42a0R1NKAj7QFtiW9xGJqSWwQDlyQq4BRo8UvrJCEoSslOvL9+vD/ZJHNvNoWMnJ8QwMuFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NNMi9OKzVqNVVlamxSUnM3azFuQzh3RGg0MFI3MlhyUFYzMDdNY3lVS1FX?=
 =?utf-8?B?VUVvSkFjWGk2dGZwNTBJbnZoL3c1SEE2N3lXUXludm83a0E4SjIwUUlJYmJz?=
 =?utf-8?B?WlpsWDNFZ0ZqNW9mcVdWUTdud2lzWHdEb2MzZjhaMGtNRjMxRSswQzRrWE1n?=
 =?utf-8?B?YmtzZ1k3bldXUENndy9zdkY5R1hFQ2ZwVnRzdUFQeHBWNUxBWWNCWDZzamN5?=
 =?utf-8?B?T0pKZGdGd3d5Z0xNQkFRZXZCTWp5K0xaSnpqbUljTmxIMjdpeFlmdUkvV1Bk?=
 =?utf-8?B?SDd1RGhDK0JCdkROVmthT0lxRWQweDBaR29rNDdtVDlaTlhFK3l3SHF2TnNI?=
 =?utf-8?B?bzZXZzAwdzdENGhiZUhEaEJIUGZGTU5iUlpub1ZyZWpLOWJtNjljbkd6NG5U?=
 =?utf-8?B?aDdta1o2emViOUJCNjNaWjU5dlRDMWdNN0VkbjhBcktQdUlBUmVsYTViL0RF?=
 =?utf-8?B?R3lnSm9vQkc2S2c1K0dIWHBoMEdLT24xZTF5YkxURjV6Z01JOU1LdW92MktK?=
 =?utf-8?B?ekdOcHdhcWc3WnI5NWVJejlQTFB4WTlIak1pTElianZCWVlZaUtrNUkrWFVO?=
 =?utf-8?B?Z0pLaUg0SjUwWHFmQmd4NEU4R0FUeEIxbHFURXZqR0wzV05OelhXVm1LOGRk?=
 =?utf-8?B?S1lmbDgvbzBIcWdYcCtvWkJoT0RPY1UwK0dsRTNXMVlGSTBGMnZiYTZqQnhK?=
 =?utf-8?B?Nnd3TEVXT3lBeVZvOGl5OTZmYUF1Q3czeUZVVFBSNmM5RzJoR1ZBUVNidmI0?=
 =?utf-8?B?U0gyS1JVc2tXMGd2YVhKOFNKMFE4OGE1d2xLRVNSN3VVYUlPZnNXZ01tWC8r?=
 =?utf-8?B?eks2WTAxbWtUSyt5WXZ6MFBjUUdmL05NZEozcllyeDVMTFVza0h4d3R5QXVQ?=
 =?utf-8?B?b3hpQ1hBcTF4azFmSlZ6aURsalNUclFmWGpaNi8zY3NhTkd3dFNpSFB1WDFE?=
 =?utf-8?B?aWZsNkY0WnY5TnBLamV4aVdNQlZWWjZ1N0JEZ1AwS1NxcTB5RGJmUEZDeHhl?=
 =?utf-8?B?bnVjM0NCYU0yNkN2Nll2SDZjZWNFaUJXckZUTFJIVFp1emtVU2U5aUFOWnVW?=
 =?utf-8?B?ekhTM2ZiVnozQjE1WXBGZGVteVdHSVBEQm9JcE4rY21rSVc0UjduaEZRdkVh?=
 =?utf-8?B?R01hOGFrMi9lRjJralUxaTJONnNFU1VJR2ZMQ3daV0loWDZFZ1JzMlEva3p4?=
 =?utf-8?B?NVBzWWZqVmROc01WY0FpZ3Mra1llaFltWE1mZFczakg1SWV0L09ualRPd3Nn?=
 =?utf-8?B?aGFGN1lxQkVYMXNhYWFoc0tQSHlGVWg5ZHJ2ZWZuQnFGdEk3R0dLUTZ5ZGNW?=
 =?utf-8?B?eDRPUDRoMmVXK29jVzJFMkFwNm1SQXYyMmlKOUhMampwU0d3NW1XRzNIWlJq?=
 =?utf-8?B?YWZjakVLci9McklZNVBiR1lidi8vdVlnUXlKdFVvLytIandRMEs1bERpRjNY?=
 =?utf-8?B?WUZ5TzJHVGEvRTV0akxsQmZpRHZuVkZpOTkrOG5VbC9ZaHFlS09IeEpWSU9X?=
 =?utf-8?B?ZWhwMUl2VFVlYytWb0EzeW5VNWJzV3d3dUFPZnVjcDZhSmdITDNaQm5SOUhr?=
 =?utf-8?B?TlRGUGRXK1BjUENka2d4ZnZJdndZUjBDcGlscU1ORCtwK3krK0xNdU5QSUFN?=
 =?utf-8?B?YmVOQ0pvcG4xaCtJNVMxM3B3REZRYjg1MGNpaHMraktIYzFsSnVBd0J2QVhl?=
 =?utf-8?B?QkFrRG5ES1RRRWNoWnJTREoyK0xETjV6eWltK2ZRQVo4SGZpdTNIZXFVenZ4?=
 =?utf-8?B?NlN6WVc4YkU1NnpLbnE4NHNnemFBSWJiUmRBSmI1SHdrRW9ZejUySDdrODVQ?=
 =?utf-8?B?c0ZWWUtRM2hUK2lKL0RwbVB4b0hQNFNBaVV2eFJKSG1ncVhmOWo5bWxWWEZu?=
 =?utf-8?B?b1hZQ3NyL0ZDWndCZjlLcm91ZnZJZzU1ZUxNSTNvaUJGZFpRZFRBc1dhSHBY?=
 =?utf-8?B?TkZDL3FXbldyb1oyWUdMai9haFV6eE55eU1yaGZ0R2h6OG00eE5VRXpXS29S?=
 =?utf-8?B?VlArTE9jUHZXYXRxZTI1REhITjVmc3NPeEtjVTl5cjBmMFNYY3dnMGpubEFh?=
 =?utf-8?B?RlJ0OUNhSWR3TEZWMjNzM25qM2dyazBzV3lpTzVaNnNjV09LYzhnSnl0OEUw?=
 =?utf-8?Q?SKqfo4TMYWapzQQoNpDuh1zbW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1195ab68-5db0-4687-d3f8-08db83785a0a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:33.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsi6rngAUDWYJnYUC87jBv0E41knxjSeE6sVhxu7X3QF4hPv8mWy9I8Qj8YNzX9GUq3xYC+3+OA+yBCscKyLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 6f22fe054087..e9470c50a348 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -171,7 +171,7 @@ static int dw_mci_hi3798cv200_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, &hi3798cv200_data);
 }
 
-static int dw_mci_hi3798cv200_remove(struct platform_device *pdev)
+static void dw_mci_hi3798cv200_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host = platform_get_drvdata(pdev);
 	struct hi3798cv200_priv *priv = host->priv;
@@ -180,8 +180,6 @@ static int dw_mci_hi3798cv200_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->sample_clk);
 
 	dw_mci_pltfm_remove(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id dw_mci_hi3798cv200_match[] = {
@@ -192,7 +190,7 @@ static const struct of_device_id dw_mci_hi3798cv200_match[] = {
 MODULE_DEVICE_TABLE(of, dw_mci_hi3798cv200_match);
 static struct platform_driver dw_mci_hi3798cv200_driver = {
 	.probe = dw_mci_hi3798cv200_probe,
-	.remove = dw_mci_hi3798cv200_remove,
+	.remove_new = dw_mci_hi3798cv200_remove,
 	.driver = {
 		.name = "dwmmc_hi3798cv200",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

