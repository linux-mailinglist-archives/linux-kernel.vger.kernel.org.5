Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E863C751AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjGMILk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjGMIKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:10:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9F73A97;
        Thu, 13 Jul 2023 01:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6iPd2aJ8WUMhOKpHwXwrYePic78EHYTVbEATrGsjOyc9OTCSPF6R/RNWA8jO+b6luHuAX7VPRsW6l/P1xwhB6WlDpmEtbgoKY3ckWvaAZMJZyGpHoMFod6BqdLVGn8SH5ReWk/Y1rWSk9BxoCh8A9ZNTy1GOSi0XXSiE0KzZu4VUBAWP/bBX5QAR36eHwMZT92c2zWNBm6dZEIFiqvO3sqIM6RXabs8WFEwDklV1bf6jJe12ZF3Eyy0fOpv5ey8ojdCuhkMOiDbE1f4Af6XXNgx/EZvC+6RdHHxuWejCm5z/44fZUhTnPboSeMSzZejT18Khkn6RdUwmQNGICmkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBCrlQifOoquSJLsuYWbDUS75795nZPusK2Le0rM6UY=;
 b=Efo0nHwvrmDFTHOm3bZzjXSHmFZKEfMgtpM3yH4g3aJVc4Z5B6xvy+Cb49iJlOPxOuIjd4g9/IwIwnQEC0EzSBWsHtmij21hCfvJbBDqMB/VSul6ZmOvYikJoK6pUGUZ5HEDAFqkHSH1GTKvhSI32wZxuYVjIjfxoGsgmOU0u3PucApwVxRd4W1Y7qJRAqocZgt6ZBsIn/mPOU5LUyIZzwglg44gq+AXVn6A8o7bGqcAZatUt53jUmJTTNwFogXD+uMoTwEvo4IiavWD3bpm0NqIZS0JpBkSJ5kitx5txLMIUYuUKTbPrEvZEkh25i09HZAmAur1LObgC/XfP130hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBCrlQifOoquSJLsuYWbDUS75795nZPusK2Le0rM6UY=;
 b=TuxEa/NZJ1l4T3XaxXFLvd8N3EjKjm983TQ+c+d6YEbok4HvGJvF/oZyz0Kp0vDtQQzPHVxuVUlOIVis9A4rbDkDCyYucoVMzF3vTdVD5X8On+ogaUsePjAu1oOyqwYtWGVw/XBbentvpTVlEZhsQqvSCtAGXdrufvVdeynu6FBsfuxVtGJAS4bsbwLgXKYNmSADQgSsvQHVFUD8YdeGzEUbR5P1SnA49Y+8sSqcLw2oldQXSYESoKyKSTwN7TGAdnfFReOD8SsCk3CvjfzcbJUXrinjnYbY9BrFn8mrEErQEx4WOCE7+Liy4p2DcfvHqNXJWeAbI5RK2QlHWx2Jyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/58] mmc: rtsx_pci: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:25 +0800
Message-Id: <20230713080807.69999-16-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20bfc1ac-4b7f-4cdf-5e3b-08db83786235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYYuoWKLDHXftphrOyft+0HkyiS8M9ms5WycNBIslTG0lN3mNdeU7uRdoL3+i2kR4cUFOc7TCQdo+sRB5e89bklhHo+/xn31G8H2yufTAt/bKIFe9QbRGRG1iHIPtDuIPXjUJPMoxU6gixUT/V3zV/C5Yo0DCtI7ezrSHVPlB4vtlOANV2zz9RpyigMg+uT1zavPlGeuEo0H9tp6lvnvnBi0f3hRVWbaJSZGOqLiDDr0BpuUUGvMZ16hdo6WIRxmECgzQCnW3ZTvlz6wmeKJpdR2Qn5v1rZokgF4zGY6DfJoJWta5HPFYFUE0N4A6pVBXAktUDO04hg2/jVutmqYWcUssJHoB0FGRTaCaAsN8ccU7FWwQzStbDDjG60PRbD1STuygBh3q4Yx1+QJcz2QoFcsVTedR6cG6cdIwAXFIZUUmcIEYu9cYc1taEXMDlhJh+R19zM+d0s1kvBrnskvIuECZ0Olya1NgzV5vUdeEJg2fVtHlx2XpbdvXRKc1FNH/1vbuNecnG+MQInOZZOqXvOkwnWgGGZju1XD56u+OV4EE0Dq/Yp4qiptrbnza9KwGR47879+o9v29Rv3UWoloXk1DRNmghv/7ItA4LMwPZy+JQ9y5C73lleXniegMrQxAEls8a/KilnE7zg6qZPbErtTUzpSpSVBaegraiOcMRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(6916009)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2lyVi8wZ3BrcjNkRXBvSFpMQUo4V0szQXhlZVYycVFzZU5HcjJkQlFaVjhN?=
 =?utf-8?B?ZkxvejFKWnVadzQyVmdPT2E5QXByVjQ5ekRUSDd5cEFOTUY5UUpjdWRlak01?=
 =?utf-8?B?SXhYWTczTzdnYWkrelBDK2F0OTlOSU1Ha2JWRjFibVJuNDZxZXM1OVd3SFYy?=
 =?utf-8?B?UGpLTFpsMjk4S2Vwai9ualVaa2NFaEhJVVVkckROQ3F6QnVuNjU2LzBYNWk3?=
 =?utf-8?B?SDFQV0ZaYzRWWWxMTXpsVVJrMUd6aHdxeXRPaFc2U00veVNXRklPYXVqTWxH?=
 =?utf-8?B?NXBzbTdJcTA4UldpT25tNGVJYm9hbjVJUnBJVW1YeUhYY3czNXRVY1Q1bWxF?=
 =?utf-8?B?RzF2K29wKzkwdUd2RjhHM3JYMXB5emR5Y3JDSGVBNFB1VmlrSXJiMVpSN1Rn?=
 =?utf-8?B?aHdtU3ZadXBXNFoyR1lHT2tqRnVrcyt1R1Q2bHhDam1Vb01RNFFlUmVBWmx1?=
 =?utf-8?B?TVhrYzZ2eEo3WktuZ3ZhZzliWmlqNUVZalBvem5sbVlwL0duR3BhK2JOTlhK?=
 =?utf-8?B?Z0dqTHhJOG9oMTNxQ3pnQ3pyMFU5YVJ2bDYxc0RHb2hQU2QvdUF4L21RcjBu?=
 =?utf-8?B?ZHBuZXU2L2lTMGE1d1NQSzhPZE9qTFlkQ1ZZNDlMQU9zYVZJbnFUZE4xUUo2?=
 =?utf-8?B?SWxEM1RmTFRMckwrY3lYczZLa0U0aDYvTmxqemNLbm1Nd0VwVmRuRmJMbHlO?=
 =?utf-8?B?cXk3a1ZSMTMxbGVzLzNlZ2llYmZQbllzQmdRTkVlejdRYWkwaXlpWWxnYWhr?=
 =?utf-8?B?VWd4aVhaV1AreUk0K2ZJZVJjZDhTTklmRmg0RWI1YXVHR3F2TENOUyt2QlBI?=
 =?utf-8?B?YjBSVlJ0NnNnblovejdsM3pMZEYvZG52UHJDM3Y1ay9WL2dOWmhFQVhFSytE?=
 =?utf-8?B?U3JRRUl3Z0hDRHk5TytmMjR3dUhnb2taN3grTnpXdWE4YzRTMm5NMm5pdm9D?=
 =?utf-8?B?UmIxTkxPUGY3WDA2N0p0NmxQcnhBeWVIZGlwK20zenRzc3FDUyt5K0RtT2x3?=
 =?utf-8?B?R3NIM2JoNUwvcmh5KzhTQWJZbUNkSnhQekp2cFhjYm1JUGkrMEx2eE53NEhG?=
 =?utf-8?B?WEM4S3V6Q0w1bkxFakVibUh2ZExhY1hOb2FZMmJoTkd3a2xxakcvT05ENnhk?=
 =?utf-8?B?ZDhDRTlTSVV6TDRxUS9PeHExUDV5STlocDN3eCs0VG9qdUxmSHhxK2wyU2lY?=
 =?utf-8?B?WnVkTmdXZ1NkNFNQUTZtcjBTcEFUdUl5RHNJaHRWMXBHaWY3TnRLWTd5OVFU?=
 =?utf-8?B?a29iV2pFUllNWHR3Q0JGUDJDNm9QYU5SY0FPRGRROVdJb2xxOFFzS05kMnRY?=
 =?utf-8?B?cy9KclJHNzhoWk9GY1hVWDY5SlppY2JIWk5wUHRFTzc4WGRIcjFuYUFwOGxq?=
 =?utf-8?B?Q2puY2trcitHZGEzMGJGNWRONURZMnRxdzlVYUNmbXQwWWdCa2dlYkU2em9o?=
 =?utf-8?B?Zis2RzNJcVFlbWc2MFQwd3REVFZsWGhCak9NeE1tVmxLNEN4dmlERkhJK29j?=
 =?utf-8?B?VjFYMTJvNTJaV1R6K1NuZTQ4K0FLMlNQSGFlQzJDYWJ6bnlJUW1ZekxaTVQz?=
 =?utf-8?B?QXR0V2cxdkxHV0JIcTQ4cW9VYnV2bjE5eW0zamE2bnlhbk9WSCtmZTJ3My9W?=
 =?utf-8?B?TXBoMHJpRG42UitHWThpQ2Q1VWN4UUhqKzZGTEpaREFDUkZPN3lLOFJWcWVK?=
 =?utf-8?B?MFBiU1hiWG1pclp5OGdqWjgrSFBOamcya2ZqbEE5SW1qaFZiNzRDTFlXNVBm?=
 =?utf-8?B?RXRmN2k4YWpiU2h1c3o1RFF4a3NRc1hiazVnN0l4QVVPZ05UT3F6dXV5V25p?=
 =?utf-8?B?eXcxanRKeVVEY3Z3Z2p2QWJEV3R6NzQ4dlZadnFPNDZOZDZ5aVhVZElCUzEy?=
 =?utf-8?B?cGlUOEtZdjErOUNxUy9nU0JwMk5MUDRma0hDMUIxd1hwM282VDZSdHF6a1Bo?=
 =?utf-8?B?RjBSUmhnYmtEaVV3UUVqc1AyUVFsN2dRVWFkSG4rZDNJd0txRW1BNk9xSm4y?=
 =?utf-8?B?UlZ0eFpKSGdEWmtCdTFJZjlDOWhlSGJHdWJCbHl2Z1lkdE1jQnhENHUxeStj?=
 =?utf-8?B?c1hrd2RFNHdzSWtpNDN5alFDVFVuTENLNmFPUGNnUjdxTjdNbGFVUjJnM2NI?=
 =?utf-8?Q?AsKztIheQrG5mCte4L1FyI4GU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bfc1ac-4b7f-4cdf-5e3b-08db83786235
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:47.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4iTMVMt/atlsNE+wXCxkBV/4wZ9xSM52c48akmT85Vo0PaVzrMs3sTwx29igpcPZ4JXtQASChndHgDQrHGNkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
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
 drivers/mmc/host/rtsx_pci_sdmmc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 8098726dcc0b..5465a7225df4 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1523,14 +1523,14 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 {
 	struct realtek_pci_sdmmc *host = platform_get_drvdata(pdev);
 	struct rtsx_pcr *pcr;
 	struct mmc_host *mmc;
 
 	if (!host)
-		return 0;
+		return;
 
 	pcr = host->pcr;
 	pcr->slots[RTSX_SD_CARD].p_dev = NULL;
@@ -1566,8 +1566,6 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 
 	dev_dbg(&(pdev->dev),
 		": Realtek PCI-E SDMMC controller has been removed\n");
-
-	return 0;
 }
 
 static const struct platform_device_id rtsx_pci_sdmmc_ids[] = {
@@ -1581,7 +1579,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_pci_sdmmc_ids);
 
 static struct platform_driver rtsx_pci_sdmmc_driver = {
 	.probe		= rtsx_pci_sdmmc_drv_probe,
-	.remove		= rtsx_pci_sdmmc_drv_remove,
+	.remove_new	= rtsx_pci_sdmmc_drv_remove,
 	.id_table       = rtsx_pci_sdmmc_ids,
 	.driver		= {
 		.name	= DRV_NAME_RTSX_PCI_SDMMC,
-- 
2.39.0

