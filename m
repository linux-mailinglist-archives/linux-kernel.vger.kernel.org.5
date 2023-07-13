Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B84751B34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjGMIOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjGMINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747983AA9;
        Thu, 13 Jul 2023 01:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt+Kve6inq04tzgQA/XGkQkzdsQ1dH+q+goQdWTytxV1FuVPQFPSsmAPT68TAZ3R+lJv8N5JJf0TLj3tvSOagR89vf1VDUTyGgyREUZN94blvhqtZqK7fpqOdytJZgfIZj/RZ3aqKI7cSnfDTF074s1YmzJyuQkQkHlW+9LrsBCSYoirsT3iIqHc0tVHLuF+HU5r71+XkTE8AeKIYayazV/7wiU+QxYuIZRCI6ndTZiGTSDOREIBw54G7/XkzISMPWIzR7yHziGLnJQy+AGW93oqEAZYSEHUiG0rGD0uHtoJ5zx22OIE2REwE3WgGzMgvlNbd4uRImUwl3jwxVQrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVnebS5xmKX74dwA/QiihEaSwS42iXdHIK6TKi1CgBE=;
 b=Y4JH42PvASEQ0qpCGMo5E2TjMwuqG25HZjyEW5fi53QoFYYShzlA5L2WfYCuLAuN1ONUqYAVxgQ0bZp42PmsjD8wTH3j58Wo6/+lbA9tfodw6qNKfv+IQOnRypk9KXBxmrWkBRnP7SYRlZE1N3HB0dKLDv64Ecb9NUSfxoIcdGyO+UN6Nld7KUL3zMPbWICNVsRtfSCsrjMu/fl2tHJ26bfq4WMH9IlKUQG+burOfZp8y3N4StizESr9QGUAyXbMr81Wn8t34Ut0kuEHOJEWfhTPKgLq/bAm1KAFf3SCSouVamYNy050GlSxTZLkz4keOcIT3D7RNTqSCHfzPTzjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVnebS5xmKX74dwA/QiihEaSwS42iXdHIK6TKi1CgBE=;
 b=IV+VwuYx3SzW3CBiKqqvZPUbHLEAa+NBCvPGCSwtGAqHkVTSWEkOa5SPWd/wadMU5LVasJK33IVKPxbkXiPiHznQqp4qNohSuut1EoZvs+euvDpBtPWWFCIZghnz92K4iIvpUQdCgYFFyrCVN6Xn7snErJ1rGWi7DkbTkMSmqzYLY/r385C+wv/dHXEZUqNDDBo2R44fONys5uiJwDhCX0+mCZYGp8sQU492IiZ4RR7lQA1+rKY14IDCE73dzw221OPspnUIhZkxBrNf0pzT228b0u+E+HFV//r76UcoeosPswQXy99GrFarV7w/fud2BywN3U+Xc9uSRd4EcRDyNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:09:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:58 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 41/58] mmc: alcor: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:50 +0800
Message-Id: <20230713080807.69999-41-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ddd0622f-b9dd-41b1-e04f-08db83787d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nE468ABzbW4tNDCd9XRswf9e0pZhG8DQiLPKtCDF/64PgTAG9pgEOpaK/SnCKEvWkd51ugSgdRiyj6JhiAYW1CKm3ABqHR6e4wAHUnWouMCaOtWTCaisPXz1v2iFih0Gk7pLgy0rEro9pVmr4FmJ48IHdVS3ecEef8l59DadHYumWUOIp43U4DADQZm8fQuovNMnE8SUKpDe4UUrcMkon2qWo+wkbBhYf7Mln8LWzXXMTUtWRlujrsgnPUMn65JMQ8o3Ow2wMl3Mv2UpA5kAUAc28X+4mJQyrUK3c9a2NLXNe/j2KNWsk66pel6J7PWNYKvuDrDJS+ryZwAHM3rTRGgy0CBDOd6xU4l+azBEk7U2FE8JDodwwhD/Q03rqj/W/xYGfxh7G6Yq1MxVAL6w6GdrS6hjv1IJli3ebqdGKZh3FzDhuxWA85rBmYngOQS/3kIFZoV1y7vZWBqsfJP2L0/fDzeEWlp8cXWeOC+OLWELPnqA+OD+DGO9ziIKcFu7VPpCUy2T8xtMq6QspsI5jc/nuPe2MCl7s8lgZbIdnBOgBrDsiLD4bpnH9mmJiq4QCcSCFvnkbtHR4bK2g5G4CgEmQk+xIWjLQRq1h+UcMB7bAvHVNZcP1eW10Q5wL4dC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(6916009)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEhtMUFTakE4WkhoOUhjWXBaUzlweWk0UlJnZW1XV3V4bS9HR3IrV1E3TXll?=
 =?utf-8?B?M1gwMHh2TmFxY0hITlYzbDFTYTdmek41cG0vZFdDTlR1VklIMlVzeEJkUlpq?=
 =?utf-8?B?ZlRyU3QycjFkY01IMi9CWTNDUER6TWJpdTRqTVRrM3hrY0pSam5pZEpnQURh?=
 =?utf-8?B?cTZFQjB4WE1UVlFRcXRZT0ZFV05NVGkrM2xTOEtDcCtOSGNMdGJUTE9OenlH?=
 =?utf-8?B?YXZPcFlSQlcxd0tEMFNiK1Nkc21lMHVkOEFhbnZMcTdTeGVJYVpXQ2VYd3dz?=
 =?utf-8?B?QU5LdXRGc3RrOWFjVkJ0MFlOQVphb0NONFAzUjRDZWpuNDJ1cy9jSlhJZ2x2?=
 =?utf-8?B?bTVpT3RzT241dklydmhGRitZSlRyZXRSTjRwMjUybjI4UzhxQlBiUEZkczhp?=
 =?utf-8?B?OVhqTWlQcHRNTVV6Nk5zeTNYcUs4YjhWS3hqaHFmQVFtN3lWUGQrd3hKYS90?=
 =?utf-8?B?bktLQ0tUMmpuekh3Q3dtbG16MU9JQUtlL0NFTDR5M1VGVEpxcE41TmROMXRj?=
 =?utf-8?B?eTA1eWxPcSsvQVhvalJ1VGlaWklkTXJISDJaamxsSTVHM3g3QjI1czVkQyty?=
 =?utf-8?B?YjQ0U2I3MmRRc1Y0QXRDcW1JYzk5eWt4VkkrVnp6NzZrTG5pZUZTcWY3MGd0?=
 =?utf-8?B?cVVwbDduSWZveXNsVURjd0pWTUhRamFZS0hsTWxmYWYwTkN0dkp5ZnFkcVZo?=
 =?utf-8?B?K2NKcENXWWJScEttOExRQmY3bVoxalhrZUVMN3ZjU2lVMkJBQW1nbm81ZVlU?=
 =?utf-8?B?NjdTOWF3OU81OTh3aEt1SVc0eDEyM3dJQ1JtMFoxTFhPVjdlcm8vZHBoeXNV?=
 =?utf-8?B?RjZ6QkRhVjF1aEp3VWdVYzN2ZmdEYVo0cEZLRUMrL3NpcDVyV1VkWGRtMlBV?=
 =?utf-8?B?S2ZKWUtGK0pKeGVtdEVpazVucis4RjAyMEhNRGg3Z2xWbVVUcXZJeXpNMEJI?=
 =?utf-8?B?d1pMckdGMUNPMHFTME5FUkdsMDVORmh0OFdpZWpxckZyMTExQ09wQUMwMnRx?=
 =?utf-8?B?UUVoMzIzZWJJVldMaFJrME9oU1k4eFBqdllUWjZGZ3JYRW5KZU5neldOemNK?=
 =?utf-8?B?MDdQOHkycHRrR0lQNUI1WUtKT1NLWW1LWDJyZ3k4ZXZrUzZETDNsT2EvYm1U?=
 =?utf-8?B?cTFYNG51SS9FZ3d2Y3IzWElweEJvN1E3ZjFVNXYyS3puUVFacVh5N2JVUUNN?=
 =?utf-8?B?VFNUd0hYa2hvR3JzN3JVZFF4czZvUkJYWUdNOFZGOU1XN20yT1hnMGhPODEz?=
 =?utf-8?B?RS9rSjRHS0pXVm9kSjI0WXNrNzRJUU5UQW8vZW1mSzhFdDdoUjhmcklxV3hr?=
 =?utf-8?B?VG5ZdE5QdGtNNk0vNWIwWG56ZVR6eVhYa3VIVWdhWVdWWXRqbTh4MTdZNjl1?=
 =?utf-8?B?Wlo2aGFnRHd2VG9hV1BhTlh1ZlhHRW5reXo1MWpiU3E5RDJnK3FwbUdMbjN5?=
 =?utf-8?B?aW9mOHJMVmtyNkFWbWtvY3pUeHp6ZERHWjQya0o0Ui9tRmlZcWxIQjAxR3pK?=
 =?utf-8?B?NFRUMWNHSWxZMXZSdXc4SlFxSERERDlHei9lMWNDU1FncUZiSEUyQXlIUHVn?=
 =?utf-8?B?ZjQ5ckRnWVZKRkJBZmppdjd0K3UzYm5mQ3huYTZraFNYN1pTUlp5N0JVMldX?=
 =?utf-8?B?Nm9NNFdYN0JtcllQKzlTWURsVksxejRULzJtYlROVE5tcnpSYkVPaWJsazB3?=
 =?utf-8?B?d1IvYmsybDBRS2ExMEJ4NmZDd0JaNjU0UFNmakFvU3hJeE5wZGIzNnRDM2gz?=
 =?utf-8?B?QStwV1p2UTRoZDExQUZWQ0dtcjhTSEE2K3kyUWNvM21LLzFDVkpOQ3p5bXBa?=
 =?utf-8?B?NllONmY0ZmNTVUVqdU44cVlkT3BmNFJ2S3p2YklrRU44bmRLeG9KVlU1a21G?=
 =?utf-8?B?NVJaOVNLM1k3QjdWU2ltWnlwNFdES1dSTXlqTnNQemJJeGNLQ2tTdUMxM3cz?=
 =?utf-8?B?VmdmSzVQblI2eVZvM1IrUnVPTXZaOXBxTW1sS09hZU9FQ0YwdUI3Sm9sNUt1?=
 =?utf-8?B?dmhKL05ONVpFdCtPMDNHQXVyT051RWUxbk90NURDN1gzUVpoc1V6aVJhLzZm?=
 =?utf-8?B?TllxaXVXbkpZWUNqS2ZWeUFaVGd5bTFybTdVTDUxR2lkZGdxZnh5RkhlMnZK?=
 =?utf-8?Q?1xbXyDQr1EvpxV3gkcvetRGKc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd0622f-b9dd-41b1-e04f-08db83787d84
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:32.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxqc3+qrH0FV63doMXmoR+7qgDzuw5gS5N7viBEr6v4hiXVPhYvkh3sQXCLegP0n3lFsuTsnedzjV1sXe51Zxw==
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

