Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF06763552
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjGZLkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjGZLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:40:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69635B7;
        Wed, 26 Jul 2023 04:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km/ttNp9BYwb/64zg20YVX0Sk5/7u4CEePllxtvppwfJIc6YMjb9AERCOMAFmuqL3bhQIa4wdBCxTuk8q0fY4SZ4n9scwxBCJ0WcJj02gdQ2Q6XaSyTqtmHyq1mjobDy0+/kCbIps/d0k09UOV15ItCE+JQhnOlHNQ7J8mnLhAHm/ZIjmbGrnozCbzm3r2Cg/rxjIQcg9nXWZi6HXD/JRhM972XXEmZgFoTbmEENn6t6e7tRoEGT3lh4qgBXtDLaEMTc+/hc5STwkij2fLDw/kKBCde1dm9EaQKHGZGKIRo2e58cDccPI/VyWoH67Mq3JFLvEssYWCPz/kq6u3X9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScXWB9W7vzleb/f5NZnxqisbCcaCtCHQ8TducOkU4NA=;
 b=YUYDGNSEi6lgu19JB0naYXPzB9RhUY9EGE4ivMZinYgBb0FXfQ2hf0cTrrEwBkcLnQ/LF5GBowVBmWYJXBOmowvptXl7qBzPlfWlyn5OKuf2jSQ7+59qIxiTUv6y+a8n9hmSaP9l17CdbAnI4bw6ngybJIHo0G1aSFWbXkr27mpLcP6VmXfeEODHOUsnTjCp6MEDPLLBLXT1mx3I7c5THFGyeqtoGIXUGByoLdR3bh14jecgpDvq8wKGqIrlwrO00R6Hd1rdX9ap00tvul+M1IJh1e4IoFYhWnyBf4r97J4c79yHUvTakCh5C4ilvN2cn6nDWIzWqWQMz5H7f+jQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScXWB9W7vzleb/f5NZnxqisbCcaCtCHQ8TducOkU4NA=;
 b=WhnIKCuC1IiSg3LZPQTazcVpSzlooE2Gk40hSRecIft0y+axHSDZ5RRUS0DwJF4rDX44+0p48dr6M1BPDKw3NFxDEYy6IdVAwws97WrV9XOt50MKkjYSOS3HkaM+65Xh0gOTcZlp5BeDgSVrzOK6gZyhneFsSd21yIHo8zt+YGRDx62gvgwP8OcL4Op47Y0TxAMwNcjKF3E5lGfm7klPczlUMVjv++Fn1jFEbrlrcsf1WB0bcJan4OKsF6SMYSZITa+381OmNuG5rfKL53AikEYi4FNcoJA0NTvIvBxPO3gQpHTZADq5DcdWSf5GYZpoERoXI9ezegcJ/LZU+su8QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/30] usb: ehci-sh: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:02 +0800
Message-Id: <20230726113816.888-16-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f1bc5d-ce84-4362-b073-08db8dcce1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJntfgr9eWHDkovjli8/ZStnNWA3wDK14I/Tg+tRjdkuKeyIlzF7QyeAOlMyGvWFmRsoiuBdLjWG7SxEafKRd4w8pcs6vVsyPZnpVjO9QJjYAVUDwwuZXJwzvKdWkXh7nEah4gTHor+L6XcmcX79xhvrOXZ1W0lg9x1o8KL0XM5k9AWCvixxwfvXoXD0deRsvIeK/3Fip9EVUuA+tlCvhUek4M71CZfhUdjvamNg0lVChrfVwvtd7cwrILCVetDd5tNiIOb7xefWXWLtzKfjPOlbslJfoHZILkKAw5x2XgRyh0+yE3rljYSopnyE9buYFtCgVoBSmLrW2o86qJhIWRnJyX3o7V9Iy+s/6NVAOms0oRX5N6sPCQA1PdxiQ9keCogOOCgvXz5XSCQoR8ukq9Ytti7FnECxLlzS4r8lsGP0Rwo/2qJkR5VBT7vGWrtq1OSz4/7xr6C0lw7KTTKxbUhDO5Df89Gx7Z5o6Wlg89AA625U+9YSjVa6Tzd/n+PadKxpYf1EE+Yky49nrJuu4d9SItE2fwLk0urx+Dnm8JdS3ytuWslA/lrEm7F5BgGjOy4fa4xuvF1DWRyTZiCPVYasgFdcnZxwEz9WoDjGuCbwdYQkM6gI690AzRgdoT8r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e0FK24B3RbXD7UMX6D+/6+RWswpwQL6QBL72oFC7yujWmopONO4Gu0+IuYg4?=
 =?us-ascii?Q?F+lOoVus/8KVVaiZ+NIOqKGiOdz2v0VE2MWgfT77ZOg6ljC4Yrk1BTwhllB6?=
 =?us-ascii?Q?HyYJs3te/YMD1fstpF1YLpxe5L78Bd+oA7c6kHx7f/WAXEW/0iQ6ZQ7o0T9e?=
 =?us-ascii?Q?m8Fn+KrD9EQlEw0F0IcL7En08jXGao4wrGzaGTOAg43J29cM33KVvVCetamh?=
 =?us-ascii?Q?wEhBMJqjWDMa09XaSA8GwetUVMYt8bHaRsWGCbWR6qMbEP1DkjrocIpqeq+0?=
 =?us-ascii?Q?SKIElmaiCoYQ3UyIkqr85tfZxIlDi/J5Vbm8p1VcfZ6ZNEgpRaiIeYRsR54u?=
 =?us-ascii?Q?HlTEP+XzGyF52qx49DtrvjCQzrK+B8yirYZ9g7Q/O4UP3iRY0c5iOWflHEBT?=
 =?us-ascii?Q?Ma6oFSgzJB76eV5FtqRkhFP3cu7F+sEDs+gcmtJD1AMC0oC3Yxt7CEVzTHYB?=
 =?us-ascii?Q?/FwIBJ9FcMxUT+w0wNaPKRCu3YP8xdvxQyxua2Ytxd4fpIx5sH7zJsJhWYns?=
 =?us-ascii?Q?Fxc7qV8thsdoVehKpSm3EpcnlZFLgXF00VfO7rex9hizOrlfLDQC52clmKqV?=
 =?us-ascii?Q?MXVlKSiUiYBaiuft3X5/rqnZSpQvZYD6nTM5mPCBDoAFNMZmKHAAyDDos1Ga?=
 =?us-ascii?Q?4J0chP8HvWoIg/r7xYIRl59n7+qy862U89sOnJKMZkjCc/F86AfgRfX7ZRYZ?=
 =?us-ascii?Q?DWZr9yxufGJ/qH6vctRpx2Qxv/WKMhRWTST8fIH15W5N/ITW5qYZ1dqkhSFh?=
 =?us-ascii?Q?dmfDCGjMUCvR9ItkjXRUMW8QfPvEX6aGlxm/8SUuqNIV1Pe8zqo+Vs4Vz1em?=
 =?us-ascii?Q?PxWqI8VcvxQJU59cqFhjQPMgiaCYcZqjpYUPbF+9YknE7mElagcVXsMopcLZ?=
 =?us-ascii?Q?DbLygEswALB4P0jh6NIBk6RwfxUS1dzyVc6QRFr5xqLlWVb/3lCzq0tsiNMt?=
 =?us-ascii?Q?9j5z56EbmOZSegIvbDuwp0zRxQvjyddMjBWeDqGpivcBYd0xtpzqfowPFc7v?=
 =?us-ascii?Q?lyi60AcXiRGwj8VZeGXf5vqkqhT5H5QF4nuhq5QfqcW8jOJYrGElA7BOjB3d?=
 =?us-ascii?Q?PL78spI0TwI/hszLsm8Jt65fyYzHnAy20yHl4aquXrbgR/tDD+W9Ee0xVhJ1?=
 =?us-ascii?Q?/zPBIj/3qy8ENNh05NsLoCu9u4nDvzug1SanEchZC6IXzzSrAuxjvRDBlJgT?=
 =?us-ascii?Q?Kol3zknvbTZ60hb51jDb/0NgW2x7mDfcuxjXPG8G6DitGECinhokWG1CqkZN?=
 =?us-ascii?Q?Yk+vI5mxMQvWxr72ied1eSMjplzS7mx2HiLOaxJdkwEYr9jLwgxBn1uQU29/?=
 =?us-ascii?Q?18x8WXbMXIC+9PxVp7DFD7dXngBFPYpOw0/g1t5iqEb2mXX/shEy3FV5FYB9?=
 =?us-ascii?Q?r2DtKZyorAj2RjvpEzLDpnxKOgi5R9CQRSLfm9Um16djKUTebhZDJdWYqxdT?=
 =?us-ascii?Q?zojuTcjB2uWlHYi7mfysrFXWpYPWSTGISmWSB/4KiiIGhcBrNYOnIxHLIMRL?=
 =?us-ascii?Q?v3t0INV8bDNWovvuy3h80IXSDjtLgBHoH2gPKRmroLx0McFJ6sXSoFojL3po?=
 =?us-ascii?Q?hbPBhUoupm/IOuSs4qT5WDR5tO9YtQszvl/gW8e5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f1bc5d-ce84-4362-b073-08db8dcce1c1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:50.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /l8xJw/u+doE73SxxouhQY1Z2LUgE1+dIfGoZg8ZHIKN6hNeOdpOHz0TOyQ883LnZ7UlAE7vGU4QMXbovJ1ldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/ehci-sh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
index 0520e762801d..575c513f7ea0 100644
--- a/drivers/usb/host/ehci-sh.c
+++ b/drivers/usb/host/ehci-sh.c
@@ -95,8 +95,7 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 		goto fail_create_hcd;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		ret = PTR_ERR(hcd->regs);
 		goto fail_request_resource;
-- 
2.39.0

