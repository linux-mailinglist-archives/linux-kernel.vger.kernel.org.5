Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E024751B08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjGMIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjGMILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:06 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7E0211C;
        Thu, 13 Jul 2023 01:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4GvZhGlLlY0sk6xcr7aJ3+PMTXXqswuXI8MK+1oh3kh+YcC+ENfL7S97vzkGkettt5AFWLehr3GpwXn0oUUIemiwGeg7u1+uTcWFp4ox/EomcRNlOFOBOatmTSVOir/ar76adZ9GdbvofUu/34IFKqI5AwaECujig3r41qBxZ4VLER+NhElRpnzCzzPpfSL68+qWlf+T6ppuq30IGTLQlq+k9rCjk179tgydphgwHTmakbY8X38fqorKIcL9QM9Kl/HJUtlt3aqblbGhDWtevuxRkzd4WhMHxNCrEsF/GuFg8x8PAaDcAJUtpePcUVU0o1FldVHVAbEG0anFtjSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QwyjiAPoUwvuuL+fTQzivWNofmwHauOj0YWTiKbAgA=;
 b=P/BX/mQzPNGCMgXyrxnJVUTAvqYz6mNT9PTnU7eb/3OzBROtwBH/AbrZT1UP8m+nZUQK5zcc+hYFBIR3cqB9YRCruAjew11fNtIrxfHkh7VG0NWC+wjKUxcnazMfOi4wC8qTNkWsh+NOAIrDS6K5tLyQJ5L/sfn4sQG41Nhed190TRbG99ade9A+AsKBv2R+FZIDa0aoAltSw751tPkQLelRmXDypmTPGO6vpTV1LwJWPyUwWd2LDFxx86VT54lpB7jgqVN6B73z2SozKW3aafcgsR1BUKZO7OXsvuojyy3+hq+LsoJZIzHZ9PJE8FqWQNHT6TkNDLEPMw97p1BD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QwyjiAPoUwvuuL+fTQzivWNofmwHauOj0YWTiKbAgA=;
 b=NIxWFnEdsi7ImEMNgnyRS/6b4iowD/3n0lAksEMajf702/m1dya4RQvUl741Cn6WUdokikcmOVzorAcex6U6gYwAj3FI++2yc+20quaON9AjhFTPr6TzWeweMgdqRo3F9/Aw+nqurV6Z06AW4avJ/vPotbN7WTTRkzrxlFks1t8E61KvyvLA3sJVXeinMS9onKlv3mOr2zVggBzbma0sBmPp6xJt9S02QBWB0oEJ1fHgyW1GH4Jw4nsoROLEm4ufweDPPy1fbSB4PpTWHuLVNcR1sSQPlsSMuEBRDYwBx0YiEgkdu7wsOBixWs+mkJ3p1aiN9Sw2UjYkChrvmd3qCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:08:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/58] mmc: rtsx_usb_sdmmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:31 +0800
Message-Id: <20230713080807.69999-22-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3dda80-e9e8-47a2-d90a-08db83786960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8ZpqNgGZWsAvpj5zv0DZW4g0RIy88w7iUfttGpusz70lRXAKiIjcqbaR3d45yMg85WWMgMy5rg7Ub9FVrLKnXLwLLbcPBfoMe2xA4wP0X8tC1uVg9P1A6eYczB3S+jiHRqzZw6O7aQKLxWvpFqkyxI1Q/nvMwno+bo21vd44aolWjlOhA0pJD9y/LbJ91s0T4Q0SfMFfMLv1JEEDlwMDY3h7//V1BXY66lGKyU17Phm+MOso34twYA2QSXB1QtHK7vxVhHqhmSMvXTZfeIgNucuNAp71E4d88idX1K1uqynEyrFuqyynvHh9Qc0wa3p9UkV0r4LhUzQqQacqwv3BGEoeVcBOYUWOGheFMu8VTQ+7a5CYXZVeU4sAcVEy8Xqf8kWHgT0sX34FxCM0ti7T8zk2TItZgLFjU7If1ReC9cQJU0GIb/UbpCaGa1jLmAWI82V/URakqRSZY1B6xqr01/77QERcbCxa8ETOxVQdVcjp2PXvZmYfiW67nxv8vxANysr6nk+qJBMGv6uwCVefzvXcZuiu1bR6HaVYqgmxSNwz1KRxq1YlinzTBTu5D8Q6nZVTlX6PDfC8CPgHaaNvExa7PVPcqZgXRUuAlFHKHv4BskOlRypGaZjwRaYLLlg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(6916009)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHhQOU9XRkxlQ1JFb1RqWi9qQVBoa21FcEo0VHYwSHB0Tm1PdktRZUlLYnhE?=
 =?utf-8?B?VjBBRDlPSlRPQUtZa2JTUDZQelVPMEcrRG1GcHQ2SUdOanNobVNhWjFOSXBZ?=
 =?utf-8?B?U3BWOHROU3FTeVZudDk4aExTamV1YkNSQ09mc09kMFdTZEQ1Mk1sUGJTWXk4?=
 =?utf-8?B?NkY5dHl6bGhUMXdtYi9VUzZ1ZDFBUlVyNm5XbmRXbkhBa1FkUFh0T0tWZ3Fo?=
 =?utf-8?B?VmE4OU02VUNRSytpSTlIOHVwNzgzU1M4NXdyQjFPUFBRYitHV3VSMDkzMDdC?=
 =?utf-8?B?bk1ncmJsY01oOEVPTHNTK3NNZ1U1K1NGTXNLRWRMc1VLSUFPZnArcXZSSGVx?=
 =?utf-8?B?d2hFQU91dm1YdUpHY1NMTDlkaUlLdmJxMXhERUxYeDAxSEJYYUN0ZXJldW5K?=
 =?utf-8?B?RGxZMExscndXbG9IekJIU3ptMkN5ZFpJc1J2ZndqUkNzVG5mSG9ONGNnd1NM?=
 =?utf-8?B?OWJqOVBIZDlxUCt0aFRwbUNiK3pmQ3VDRXNBMmJiZDBMU3laWmQ3NjdRMEhU?=
 =?utf-8?B?d2JyWUhJdHA2NkNXb2tPb1IydFlHTjY2Q3JYdWNoV25WM2hrQnFGTjgybkVR?=
 =?utf-8?B?ODBVVnJaQjV4cXdac1hkQWVrVi82b3JFcFJsVEZmK3phcnkvZ2xkTFRwYVM2?=
 =?utf-8?B?NmgxbDdRV3FsYzl3VFU5bitkdzRlWDU0bDFyTWhGUWdIOGg0TGxLeDBsV3Bk?=
 =?utf-8?B?ZkNWcUlUNEdTeEV0cU1oRFB1Q1RkN2tLeWlnVHZBMlFTNlY0V2hFM1d6VEx2?=
 =?utf-8?B?cXI4akRIM1ptZTU4enM5NVpQeWRXNS9ra2UvcEJIV0hpUVdERWhQcFpHY1Er?=
 =?utf-8?B?OCtaKys0NDZucndQL1JzbDk4SERzaFZhTzhFSnBHai9CQ0huNW51OGVSb2RE?=
 =?utf-8?B?MW00NTM2YnFmMkRyblZMTnFXUmkrWHdQZUw4Z0U0d1VUTkorYkxoam5Yb0xh?=
 =?utf-8?B?U0JCMnRJYnVYRE9nUjhvSTMyMFZobCtIempEREl4VmxiWXRxOUFLQ0RzRFhZ?=
 =?utf-8?B?Tk0rdEMwa3M4UWVOcEJ0RVZRTi9ZK0lGZEpSNzlLT0FkS1ZxZHJKTlVUVnJT?=
 =?utf-8?B?UW51MHFxVWNHMk1UbmQxYXMvRm0yT0tRd2U2QklacWZDcElZdXVDaUwybUxC?=
 =?utf-8?B?QmhyeEt2WTVFaklvUHJNVzF1R20vcmJpR3FHZ1lEaVdaZ3pSVGxTOUQ2MUVN?=
 =?utf-8?B?R1FKbUllOFhlR2I0YzY1RGxkZE5EQ0l1aWdrTzE5NWZVTFJQSlpQVUJVK3dS?=
 =?utf-8?B?WGFpR2EvN2Q5OWNTZGpJWmlpWjVkTFRQU2FyMXhqSVBraHVYY2hsQlBjL1RY?=
 =?utf-8?B?NkhtZW9hN0MyUUd6N25BY1A3OGxWZWQ5WjRjMDFLdjRONTVFUmxIU2ZFZ1FS?=
 =?utf-8?B?dE03eU9DSWRCRFNOUWR2MmdtTno4V3ZZd0R5cXFYNDBLSU1qejZ0Ni9xMnpk?=
 =?utf-8?B?YVdBMmR0dnR3Z1RMRVNZSkNrQ05kRU9VTitKUW5VeDFCbUhqQmdDVXREQVVS?=
 =?utf-8?B?TEpXZURaWjIyMVM1ak4zRTExUjZMQzcvZVk1Q2NNNGJtYVpnNDBmT2V6NndK?=
 =?utf-8?B?dDJOMHJ2NUVDQUZFL3RGeTZRVW5zVlJ6elVNWDA4OE5MRGFZeWE2dWhOYSt4?=
 =?utf-8?B?eE9pRFhkRnEyYVBSMlQ0TmM5ckl3NFlBS0R2Q3FFbmZOZENkVjR0dmxrTHJt?=
 =?utf-8?B?UGZxckoxQ1piNHFERm0zU2xFYnhZL0VUYnBxZnZmY3hDVSsyczVSOStTQUZK?=
 =?utf-8?B?MXFDWFNTMzFoZjBEMDRiWW9hNXpBZHo3UjNWWmxXbDkxUWlOQllXbkhYTjZO?=
 =?utf-8?B?dlY3emJtdmxyRUVCcFVybVFYZENTOEdaR015L0NVaHRsaUJGclZKTGxCbU81?=
 =?utf-8?B?YlQ4dm9uallxWkR3NGdHU1dpR3BBalhQRUVmSUxTSEZBVkVqdVo4VFE0Skg1?=
 =?utf-8?B?V0NFd1Y5ZkVPWkFaVFhiZ0JiNm56WVg2NFF3N2pvbUtZTnUyeGhGeFBWMGsz?=
 =?utf-8?B?THFRYzQ0M1hVb1p4TWUveWJNZk9yUXNFRXYyQWd6MGRtVTB5YjJRQkRzZDRm?=
 =?utf-8?B?YzdSb3Zrc09PZVdNQjYrb1JPb0dnQ0FxY3hZQUlSdnhERTBTOS8yYnoycTBG?=
 =?utf-8?Q?Mg1UQpxZw5HAG1A46HFL9ODnV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3dda80-e9e8-47a2-d90a-08db83786960
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:59.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3MrQNg8nT8KLaMwCkoCV9cWpAkHGjlEWJsbjQPXSn7/zhW0vo7snEDDISjT6jrlY4OvXbhtnZ9huyskbORvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4409
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
 drivers/mmc/host/rtsx_usb_sdmmc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 2c650cd58693..ded9b6849e35 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 {
 	struct rtsx_usb_sdmmc *host = platform_get_drvdata(pdev);
 	struct mmc_host *mmc;
 
 	if (!host)
-		return 0;
+		return;
 
 	mmc = host->mmc;
 	host->host_removal = true;
@@ -1415,8 +1415,6 @@ static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 
 	dev_dbg(&(pdev->dev),
 		": Realtek USB SD/MMC module has been removed\n");
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1455,7 +1453,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_usb_sdmmc_ids);
 
 static struct platform_driver rtsx_usb_sdmmc_driver = {
 	.probe		= rtsx_usb_sdmmc_drv_probe,
-	.remove		= rtsx_usb_sdmmc_drv_remove,
+	.remove_new	= rtsx_usb_sdmmc_drv_remove,
 	.id_table       = rtsx_usb_sdmmc_ids,
 	.driver		= {
 		.name	= "rtsx_usb_sdmmc",
-- 
2.39.0

