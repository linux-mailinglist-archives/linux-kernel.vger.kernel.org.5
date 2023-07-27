Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C207A7647CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjG0HHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjG0HG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:26 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AFE44BF;
        Thu, 27 Jul 2023 00:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CASQwrGoY9Uvcb9CyqlGcLdazCIyLTrBvOM6TyMxuFrgPnY+x1PPK9x+mEe1fq+kdGWVmLYcISSumbTjBsKRrTWSpsdxPPP30z/KfF/W0bEDCmT11+TYUM+7v6kpFhfAXXF8z1/VmtzF6TjuhWFBT2+sFvsky+tAMefQFYL8vkoikHDYfoMtZyej/X21bSoyw7dq3TyWd2Kgm3CGjLcsgpYlnLAky9osQ5MilGouh4O12ABEvz6xB32JaGtttjZ5aXzjkVcFkzNNTQnTpG5pNt4rjFNH596isIqlXFx6gov1lwnmhX4OTWfn+9/4QAHARCNoOTycZyXdXyyBoh7Weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVnebS5xmKX74dwA/QiihEaSwS42iXdHIK6TKi1CgBE=;
 b=BfJ6tPEVKXYp9MQIcVE/j+9Eehcf5lkK/B9IyGnHdVmb8FPk1WWLShfIcXj3YjbTpNkoVIIvIxgKRoJ8qkv5hChrEakq/dveoRemDMdyjNB6oGvnQIVSo7OIiTijy5sTBwIxbPjWbycNE0QSxNH2BluCnw0LBS2k67RBe5j+5SVe0IXmnuokIULB/fsdPPr7IBRCdNjG+5vt2d4n9/6QDy7aGhS1NHGjlnjLVcI+BA2ZgLWtzcrvqUMgFcjE9rUwTjpMn/lAQpJ5O4vYLD7ZBH6fx1JG6gXZMheGakfNcUGcAy7R/Af6zFghZBaCJ9TA44ZhHITianx3D9rC7ATQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVnebS5xmKX74dwA/QiihEaSwS42iXdHIK6TKi1CgBE=;
 b=YC3CwH6xulM/fLRG1ffnb6n2dbavKoIe6n2BiAxnc1m3Z44/TJaxU0gRcedvBZWy5abVcd8L//7mXA4I5tv/YKsEh3elSfLunIn8ZxS3zgzm6s6Vhjzx3uvn0DDcXI3WHb7Km3dks94OZCRRwJ0O6d9KXzkdPZejKuUwd1y/dx4H7Q38cdO/6R7CV28roWB3dspMbsuI+cxVhlvDV4A1sO9W4a610DDNPT5RFFGsBM9kKqzglbLHJhYS+6HjAlo5WYK4L/byhELzf2iGGdtFwN+YwkcGpK1WFXZw4c3+VApN1qeuvb/gSm82S2rvA8bKyy//f04++CDfs6vaxlkrQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 40/62] mmc: alcor: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:29 +0800
Message-Id: <20230727070051.17778-40-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb3bd1b4-99e6-482b-9e42-08db8e6f65a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gaykgs1wB4z3hjEFhgQk+TUUbRfMU2QBEO5TUTvPe7BE4uha9n1ajIM8nThmT5cS2Y4cMA/BUz36gcI93ZG9raOXbp8A9HvQ3RkKNEPCu8B41PW2iZWKNjJpcrWpwtQe90klv8uOyDQ+tieH4e5wG8npZ4KHczmCNlJp7x7KUM2qXGUA7XHclp6loJRNUwCeakNdxUsyyMK9wI9rvhSilN1WvDofsLkXJmiLZOJFtlcFMcYKQDMl4kRj6nQVbnPYRcwdnKnS6tgpNoupXrk2pBdhP6SRBg98SVxNETdmfFk/msAcoQdBe6K2GQpJOJ76nZ1Rks1l0YF4ogD+XMz/+2ADrwwnNVHVKWu9EhAn+Q8kTH+IvXyrr8orQ0hCw3NS1TyT6NlMn1pU3q2NRqSDcqi99wRKIxp6mAH0W4BjeOZkrg/9VIrJaRJLDABmG7RHTcQedbOUWZ426jqAuAf/iPhEbH/6xvNcNE2xyWOrSkFyQqIjKWP6APZEQCB+77jDac8BtpRJbxDroxPs1eYsy5Gu7F784MRml2hn2z8dXOZ8orQGo5UnYytX4oimRvF7ON7pkhoCJQMLqf2jF6Uw5sSa5EYC3Zj6fg/FqqjpiVzet1HI9R6ZQ387qY71DDRs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(6916009)(4326008)(316002)(54906003)(66476007)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmQ4dXgyZHhQQzBBT2tZK1FUT2pkNXMzNStIc0tQK1EwMksvb3NtdWR5a0x3?=
 =?utf-8?B?OVNzWEdvZTROUXR0OTVTK3IyR2taQkFVcVhqWkFDWFp0TTRCcUVzU240MzJl?=
 =?utf-8?B?cWJ3NVJnZitYMnlCUDF2QTZqMkNwM1FDUENWUkVPREswV3JIWDg0d1hBZHB2?=
 =?utf-8?B?NWdPQWtPMDg5NE8zWkhGM2JOMG0zazg4MzY2YmFBcVZjbFlIeUZETmRmb2NG?=
 =?utf-8?B?azA0RzJZdHZiWWo4RzgycjZ6VzN2LzFUR2RUa1ZCeDNidERrM0trbU1aZC9H?=
 =?utf-8?B?QUdQUTgvOUtkUTJPdnB3LzR2aU5hOFRldE5jS0NSc1BINGxxQ0VNbDRIdDFO?=
 =?utf-8?B?MVRESk5UT0VOWUNnMDdTWVZxcldwa0ViU25jYmhsM0pWUUZPeVBaMmxUdzBa?=
 =?utf-8?B?NUQza2V3S1gvYjhwNW1ndUUwSXM5SGkwZnhMMVBlOVB0VkVlSU5Nd1pYb0VZ?=
 =?utf-8?B?enZhamwzMUZuSWRFcUVWdXBjV2VtNXZOeWhQNmRGWEg5UVBUQWc3UkRFZ2Zl?=
 =?utf-8?B?NWNVKzVQZzg1R3N4UlE4S2dXZFE2elJFaC96YjAzL0RtSEo5QVJJR041R3gr?=
 =?utf-8?B?ZnlXSWtSdTFTZDhkdXJ4MnJMZERickVRdWc5d1RQMUxCU2RLVWV3RzA2WStu?=
 =?utf-8?B?YnpTQkNQOE5UQW1TOGt2QVpURTd2V3lJS0FhdlVwZExMWUlrTTE0cTJONFAz?=
 =?utf-8?B?QWEyNEVadU1UYmJMRm9PWEJNWEJNQlRtcEs1WmZ1eTJ1MzFRNHlrVFFiSnhX?=
 =?utf-8?B?NktMcGJXZDZzbklJOTZtNGZUU1BzL0hIQUU5aEdveURDdUpDRHZrNjRJbUhR?=
 =?utf-8?B?WkIxandUMVlQOEpteStYd2gzM3J0TVN0Q1l0SWJoWGRCbzFyM1RTdWt6UWJ6?=
 =?utf-8?B?WnJMYUJXR2UwNitEQUZhTjVHTk9FL3lUT1NvZklma3I5NXJqLys0Q1gyZ0lt?=
 =?utf-8?B?NUhHQU0zbTdBeFltKzFtYkZ3UUdkNXNLSGZCQUdlMXRrYUdtT1dqaHJ1M2F5?=
 =?utf-8?B?QnpnVzBsaXFKRm1rUTdDeG16bE13QmFMVENRd29WWHpseG1xYTBYaTkzb0Rp?=
 =?utf-8?B?MGVjZlFGdHp3dlhCN0l4ZlplYkdoSzVJRzEzV2dKTVVMYitIWm5RRnJuZXc1?=
 =?utf-8?B?VXFMRlZRd1FYQXFlU0dYSnNGWk5XcnNWb1ZYMG1DczBMT0x6NE43TDZnWTA5?=
 =?utf-8?B?N2xkaTZqSlJPS3c2UnA5aC8ramVEcVZzMy8vaWdhWlBrU0NJbzUxc09Wdmd6?=
 =?utf-8?B?cTYvejAxeU1yUlVnaDlRMEtqRDRneFhLVW9mWGNENFNYdTB6VXFWQWIzUFNL?=
 =?utf-8?B?U2xFUUZQa2FkOVFrUXFRVk45QzUxZmU3L1Z2bDZ6Myt2ZTlpcmhMM1J1NnRY?=
 =?utf-8?B?SEEzSVF5OXdOQkxMRlVnNzUxRGJMdE9OdlREYVRjVGNoRUQzK1RaOHpYcm9Z?=
 =?utf-8?B?N3ZsamdLWnpoUWxsTXZ2aXAxbFVlbUpmRXoyNWZWTXIrOUZmZkRoN2UxZXRo?=
 =?utf-8?B?bEFnU3VKYjNiS2pSS2poR2R4VVJxNklkOWJDY050dWtUTHY5cU43bXBlcGxn?=
 =?utf-8?B?YnRBbEFZcWw3cGp6MlFrZGI5OW5rMURqRFZabWtib01YUkduQzNnMEo0VHIz?=
 =?utf-8?B?MXpNUGZyaTVBcHV0bjRjWU9wMVB0UFZsSkJ6ZVhLdm1jUFFqK2lLQlVRMEdz?=
 =?utf-8?B?Z2lCanYzVjNObG1mMjdseTZGcUJ3cTlrU2pNRDhieWZIWlFRbGhkbXpMenVX?=
 =?utf-8?B?OVRYVy9kTi9nMjhDNExNc2svd2NwclVzWmp6ZmExWjFwVlpBblNBNEtqVVJh?=
 =?utf-8?B?S1pkd0hnZDUrSmZQSDdvY1lFYmFTRm1DcUxaMjlYUStJeXZ6Qk9UYXRGZ1Z3?=
 =?utf-8?B?QnZ2QnhUZmVyaVpRNXdabGZqZU5DR1BDbjhhSHlNSkFqVEtiRHZNZWRlQjhM?=
 =?utf-8?B?eWpTWlpsMVY2U0d0SkZ1Q1k3NHk4cFY1OGN6YkY0dGl3UEl1eDYzbGdGOE5w?=
 =?utf-8?B?R2VjV28zL3cxUVpDblA0NjhkZ0xzemVVZXBvM09BMGFZc0NzOHF3aVpYT3Uz?=
 =?utf-8?B?aHpLYmM3aUN3VG5PWkNRSndFdndhblRnSExBVFpYZUtxaHNUSzltTnFzY2NO?=
 =?utf-8?Q?Cqvl4eDoF9F9VKiytIbb/ERH7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3bd1b4-99e6-482b-9e42-08db8e6f65a9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:10.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RnKQO+q05Eky2lBYtR+QyVPSWdLtIRNtwQ8yXUP+y5zuOFqgWslZmKEBzwRNHSku3+mmF3zTk/VEK7x6Y5q3g==
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

