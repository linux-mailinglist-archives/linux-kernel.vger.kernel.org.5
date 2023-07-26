Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDB7629CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjGZEDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGZEC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:02:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B755F358D;
        Tue, 25 Jul 2023 21:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZtutulDGuLLf69uId51baRhx4/cFhIvtzCp1kyCf9NaCbnirBhqFZS5Vh+mIrpGN2gD6S1BVwRTR6OqLnF2U4eD4oA4j0NnHvftWYEl914mxiu8M2tcnmT4Y4smge+MWHGUUI+mvQk6uw0lcE8n7ek60iXmok28KNYoHDEpzCTizpzOuaxU3omz3XfRLERvFkHOo05CZi2PK1v5M2pB8qb3J73MTiEffeuw8VPNpHMK6vNqSFjMXL5hjUAvC4p6dzLMXedw5pP+i6cIKHw5iKpyLdjYzE8kFkdQJiICmH1o+YxF8LfN8HnvyNdTOAMF/paHNiQ6C1xptZrRC1H+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsBYm0syPr7thxBEbMPEsbcgZPueQUhwrbcvN2FuDVM=;
 b=kaaaq+/oP20zEviEOkA1SAxN/Tmb3xSBSh+Q/G9Fh+SNHeqMq48PZOWsXwF6JbSuEScshe2vhp081O3QCR+v6PLGCfgpKFE6Cw0OFuBlMTs+hp+WQXOSos6J81EGbDok3bzFwkGIBdLgyQkxm40VBrJ/QUqALEkPARVkfejY53tQqAbcIquk1KydLR9hOI9Z1Jz2qv/BmFn14x4poAcRmJpD5dG86mU8k3YbQDjuhh5nSs51/iNU0hm/Xs4PwnAnWg0jab9nPfjT6f4bRTgHoVlNfAV7Tq09vvxtkwizzyY+yNGKx0awR0RN9SoSxIar0qKiuzBuULvNeaZNdtUWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsBYm0syPr7thxBEbMPEsbcgZPueQUhwrbcvN2FuDVM=;
 b=l8dvFSZZnZ9ZdlJ2PiAVafeuUix1I/btUOTkgBzPAWv5aUJZTq5lHTgqGGWlZUA0yOE04n1Eu7a/6v8qlJCgKytIqWqeWeHbYf+FBTcVvAmEXOTpQ2cmIUrnp++irQeuWGIRulinRQ6t/zXFwCR/gwOARAt3b21le3J+mNVPc2ZNKlc9tX/a61KOmQRvUjavA5R8ku4AM0PkG6kHRw800uY201f34yTuxiPEc9XiUbwbp/c2GyglTudvdSTMb3FqiTLH3r9P908ubGtslLeve7g9A43uAInIvZ5jzkNUTN9OnNG2ahAzcPfaDFGUbU8gDPI5lf9X+uxUKaELSg2Tpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/61] mmc: rtsx_pci: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:57 +0800
Message-Id: <20230726040041.26267-17-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: 661b1735-919d-41ea-7d6c-08db8d8cfca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pFqj13hlJ9dfLWIB3CJL3jSD4EbPnHZ4mjGNYg7NFEIUgNN+YwwBzXz1DOr5R3gpraHqmSTZ4HqsQ7XAqagGUnJt43seQmF8olYJKPLMU2W2BAyX2kpwqSgoeGSqbiqyuR5M8V8ZYjIw9tvLpLqbNFrlXOzohlUSYuQjr/ueOIOs4bQNq+txXUOxfYFYVkFPdI9GKNW+H/BHm8717X804FHgsVyN79QA//A5RTXKcmNWum6muliudwo9+Pw8uCjMK/35v5mfkSLjnWFmNmQAKBlvPx3RfPoULkzrSFJ6C7R0OZfvcooPRNyJ9JUfWPnA+LeSuH5G4HID3mXHL6zwym2iebGQwwgotFN/RKXrnXxUhnby/0gR3HI4CNtwzxbp+fb7wHCbaCLmRTLpIzRG0OD2e9KW1TQ6O8JiMBpR9aaArBAjngtG3Mof/SrgHCKbWcEeeUG1G7mcR2MT5H+JlS9jQBxY1dOjksb/V5hTXV/NWktMP+v9/sPgh3o7mhw9oOAD/VGsfdl7PGMfTpBlwczighX/mhvAnwJZ0ldxqIYK5nWjJG3xuBU3pvqKS2BDJCZK2rVbRw3g5FbIbsP3Wjd6K2rpsDUG2IzBXOD4k3ex7m9GgvnAtCWojQAwzNo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(6486002)(52116002)(54906003)(66476007)(316002)(6916009)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRCMDZzRjA3azJYNnpLN3JkZ095OEdacGhWQ2ZjdXJFOGZrNXBlZ3QwTGk2?=
 =?utf-8?B?QWZTeU9hOVdyVnY3dkdtWWhNVXpjUFdQMUVmK1JrMjFPa1lrWE5QVFJqZTZI?=
 =?utf-8?B?RVMyYmtTTmdUMWtlcFVwZDMybmoxV1NqYlpWN3FjNnBQbUQrM0QrRDBQRldV?=
 =?utf-8?B?bXdqZjl0NzgzcHd3QTgrR0MzbUJCWFJyYWVSYnRjMzFuVDJDQnVIcDViYmpo?=
 =?utf-8?B?VnRQd1ZCZ3VMbitJb1BOYTg4UjVkVC80cC9lbVp2dC9GbEl1ZmJuL1RjNFc1?=
 =?utf-8?B?UlluUHh6MkdmTDZPVjY4blJNM01pM1dObXgrMXVET0kvb2xlVzJQNGhTaHUx?=
 =?utf-8?B?ZUpIdmJGS0p1bkNteEl6VTFoQ0hRbkROYitVNHJqdmR4RkR3OG8wd1pPNDl6?=
 =?utf-8?B?WlIxWXNzNGVnUmQ4R3pnTFRyQkhIQ01saGZhNWVLYVdDaWJjMjhNeEloaXNC?=
 =?utf-8?B?UmlCcnpWeGJQak9kNHIrN09BT1V0THZ4T0MrNThrU2U0L2ZBZFpkRFhGb0dC?=
 =?utf-8?B?ck9iQnhhS1ZYTE1NOUhnQWM3QnAwL1ErbjQ2SlNVcjk1R1c2Y1Y5Z0RqVFlp?=
 =?utf-8?B?WWpwSGVyT0UvUkhFS0xudzRaWDY4cjZLQ3doVGx3MThjNlJWMmJ2d1MvZFJw?=
 =?utf-8?B?Y3dxbjB6Tm81bnJ4eFptbDdYUlZDKzJZbUlvTjhDNis5MnRXbDhZTlAybGdp?=
 =?utf-8?B?dzdyZlNBUEZoYmxpM3NDL0hFWU83MHNySkxoeDEvSkhpMk1QbWdnV0hLOXRx?=
 =?utf-8?B?c2xzY013ck9RSFpkZERRcHp3OUJOZG12K1JtTjh2Zm5kVEFaNlBrU3ozSjhi?=
 =?utf-8?B?RGVlRm5xYVNlb3lBcGl0UGw0dnorUml1OWp0N2JQTmlOeEhVQ2tyejd0ekNs?=
 =?utf-8?B?Ni9wZVZGblQ0b2ZpZzFQeEk1VytlZVlHNDdTdElrMUxQQVlRMnRDVlN5S3Zi?=
 =?utf-8?B?TlhYUzh6dDRBbFpuRWdOODRjdC9wSE54OFFxS2I4NlF6Nmp0Vk5DREVMQm5M?=
 =?utf-8?B?aFVuWkVVZmZnTmVRNkpGNW1XdVdGOFo0WWNhVldXU0IzS3RqQVVBMWtLTElw?=
 =?utf-8?B?V3VpNjNpT2IzSElxLzRkaDVveW9wZXpDRVQyZGdISGQyL3h2elYzU0NBallr?=
 =?utf-8?B?ZmNkU1NSSXJjcjM1Skk2UlMrY0phK3JmZkFOTG1NUUZyeEVEalpENEdwOUV4?=
 =?utf-8?B?Y2d6Z2JJTSt6WDA5MGwxSWwxTXlIakwxbDhDVDdsazJzZUhqUmZ5MXB2eXJD?=
 =?utf-8?B?NGRmRjQ3Vzc0eVpYL0ZRRjJCQTRQTXBLbkxiRkdDcm1DY2d6emFBM3BweVQz?=
 =?utf-8?B?MjdXdXY1bkxSaFNkeDVFbWlkTWF3c2JCdTJzZXlvckxoMi9PZjVxUXNmNWFx?=
 =?utf-8?B?ekk2WXVOY2dDcGJ3U1c0S25kVnZkNm1qN2JNeGRDS1QvTS9QOXhucTJGdEtk?=
 =?utf-8?B?T1VRaTVPQVB2TGJHd2VKTEFranZWTW12K1ZtR3pWTDV6SmFobWoyUm81RWhQ?=
 =?utf-8?B?YlJVM3ppL1N1anVYQU9tL2VtVm51dlF3OVF5ZnpXaGYxM0lza3dWTmNCbHZs?=
 =?utf-8?B?OTM3c1gvNUU2R3JhZG9pVXdSaXBUQzI4ejVTeDlkZFBOTk1XcithbEdPUzFB?=
 =?utf-8?B?Y1FNdXNYVGtYekZEVFBpMGFaVkVGRjZ4b0NnVjF6MTgxcTNLV1F0Sjl4dkRY?=
 =?utf-8?B?RmxTa0tpbjVCdTZ2TW9maytIeThDVzl5ZnVTeEpWY0FvRHVjbk94VERnSnVs?=
 =?utf-8?B?dlZ2MHBhNnlaMFZ0dU1najRrcDdwY2hsOEEvRzFOcngrV2NscG01MnppZjdP?=
 =?utf-8?B?MXlvSDlqUzI4TG5tNDFib3U0eVNwaGRJNk1XNTVreFo3UDk2dWVYMmx4a1JU?=
 =?utf-8?B?a1JSYUtLQmEwTU5TYkpnS0g2cHpyTmliQ3EvZTNYQUVwQ2VYL3RGR1V0bHho?=
 =?utf-8?B?c1dTN2UyK1hYdk5Ec2kvVTRJYkRkdVJ6ak02V2hNM3k1cEtyb1k1ZUNSYVNR?=
 =?utf-8?B?R25hcVJLSFRJYkF6SjRPUDZCK2ZxemlZcEN3Y3ZXRkdyV1RVbnUzRVNrc0xP?=
 =?utf-8?B?K3dOSGNjd0VnZENuT1I4aUhSMHpDaEdDbW9YUi9MRnp6d0h1aEpYNFJVQjdj?=
 =?utf-8?Q?hbjeYywur/QK+lLXi0B9KQAaq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661b1735-919d-41ea-7d6c-08db8d8cfca2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:27.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YW3Aq8sJjoIyuuWPP0k97BYEGpq5QHulhCEHgo9YJLP7TrF58Zt+OlAYNH81hy22TbQM1jFEI1u2yimPL/99Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/rtsx_pci_sdmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 062d07c2ae5e..87d78432a1e0 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1523,7 +1523,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 {
 	struct realtek_pci_sdmmc *host = platform_get_drvdata(pdev);
 	struct rtsx_pcr *pcr;
@@ -1563,8 +1563,6 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 
 	dev_dbg(&(pdev->dev),
 		": Realtek PCI-E SDMMC controller has been removed\n");
-
-	return 0;
 }
 
 static const struct platform_device_id rtsx_pci_sdmmc_ids[] = {
@@ -1578,7 +1576,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_pci_sdmmc_ids);
 
 static struct platform_driver rtsx_pci_sdmmc_driver = {
 	.probe		= rtsx_pci_sdmmc_drv_probe,
-	.remove		= rtsx_pci_sdmmc_drv_remove,
+	.remove_new	= rtsx_pci_sdmmc_drv_remove,
 	.id_table       = rtsx_pci_sdmmc_ids,
 	.driver		= {
 		.name	= DRV_NAME_RTSX_PCI_SDMMC,
-- 
2.39.0

