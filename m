Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C319376354A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjGZLj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjGZLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:39:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A592707;
        Wed, 26 Jul 2023 04:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw9jlIIEgq7ApxYT3+ZvyN4yi1V7ypOBVlr8oNpgHDJN4I2whATUwac0X39VXsxEvTRiSKTfr5l9kEpLnYfnIrLxXWpCujlLNiX5zcJW4UluA7h8GHH2MFc4sGHKB9mcJTHJpob3KrAMLeXrlzoocjtGJ5IgrgjxqG+HFuluY6CSYhT01VN7u1YKL77p5RYmVGhkjfJK4eGlZGd3gNFNz2iYNFlPzd/GEnR6b20YxlZPDEXACdk+JJBS7+FJx3ikB5V1TYbF/fhZVEgxXVUMff8ylDs5+vSoEI+O4mLTwVEdgsI9ClEakDG8hvipjgKxIuTg3G8x5Odu0lVfVRfF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brOfnpXWG+BlQNr/drLFUTt6IkQrATlZ9MTL6rDmuOc=;
 b=G9B1GOp3LtQbi3vLW5Qd3f2093rezKmG5F+1UVUAqoV1WFrnIHikCoPbdAhlZ4Igri5IEAloGib0uI6gqtecUeNjFq147pPKnNTU7stfBp/BbZjVahnOZbFWtZFT7rRuJSewqP6ktC42eg2V4pNXlG4mNJd2ctP64/TDutWStzflXNBxkkeB7clq6/BF5e3vod4czMnE+1uuveVOJ3inHskrseM5MKtlDZHORAGbcOj0vunVABooOOvGrLOUV4cx3PjVjFQb6eUf1NIiqa2nzzwRqoVMKSOcRhRIT5VrtUDszNwg1lS5XDJmVsK0WlobbKaH0mQyobtjIJDZFVJazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brOfnpXWG+BlQNr/drLFUTt6IkQrATlZ9MTL6rDmuOc=;
 b=n6+bbK0jl60F8et8cj6JI8wHQeyYrpjdOlgmHD1yN2VVe3Wqe3C1ZykS71/peeslyZS1JDiujmP8Bw9/gK4SI9kRyml5Hfxi91nEfOPEemQqCK9weh6iNVSMF2Ll+wzartMMrNgtb7WvpIa3R2tfmeSusdJ706zjWC2QMiqQfrbAly7OJL0Ro73wqWPYRSPO5Ht8+kouEI7+3iG0d+J+4JRVKN2FDPdCwFl3i1yf6ItBM7QCeMCENAkEoEaIsx11O+CaruffzrYqGvvtKdKgapVmMucb+xsmqu6j4YkodiS5VbBnENNzwX3eAjoLRtdmB4I7exBT2sYObLolJzypLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/30] usb: isp1362-hcd: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:59 +0800
Message-Id: <20230726113816.888-13-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58207283-984b-4fa9-9fbe-08db8dccdf47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZcxJRQ924ajLgYa57exx6NkwMXZEdWcqhGgkEVpyaA5zcTWwR5Q8NdVkepkUp7bykWUuj8w7wMHT4Y3dYwfTpQ3nq/UDSfeQMtLPvCXFlPJzvUy2/c9dC/hFiz/Y1FsWazXV09YH9HABCPOmzSnlFzxUvCrMJ+KAFMMQ+sr07hfIm9aJh/YRS2k2K2w4JLvBrI0SriJExteEQKx0nrom/ZIBQhfLE7SzYgNZx1lsR4rKucVFCtFrk0wFb6/dRD0nKEqFmX0CM3ePIVrZ6KOkdhaZaVhmBZLRrY2cky7D+di4uJwSco8z83k4VJBNIRD4gJCATdWMSCLCVZKN3kdKpADg8GgqMt33OofaRH/cwWkwGULQ3FSrE4PDHJy17J3lGVlRDf/8McIVFUAbQ3MNcE3bAyCinTIXa46MtulhP/xbpxkxGpqSu97zbsIFIeJsdeR0rRdV2OwjdtMGYZDQByp2sLFCgem2HStUUJxH3lMQphlfBNbngVKFjTDWNC28pvwEsV4PGrWBs9mcjEVqArcOwP4FxgyjtKU419sVvkHPqNdlAo2bWfhga3E6NT/IqnMG+eqwveGmF642SnPte27bGCdDkZsKP7kqdMINwUgefcto1Y7gi3D5DR3REr8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(6916009)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0DpIIcZXxA4XkBKieronDrhGlcC3/0pAcqb2rmicJyeRyt0QVXYhYbx8m6f4?=
 =?us-ascii?Q?uRd8V5TI0O4n3+KS4vg0g5Y5YM8Mo1flcaoIcU3kKN7Xv68XM5wDnu5HjHqF?=
 =?us-ascii?Q?uXNKRLHOvGAZbxPe/ZisHmzBC9GCzomT2pjsZIm/9gLtgObixw2LnEu6jkZy?=
 =?us-ascii?Q?N338qkuc5bWyfTdH7KjlcmRGyfvDKCXckm5gOsC03aVDvir2goKddrbvORUC?=
 =?us-ascii?Q?E/n7hRTml4jBXV7GEjfLKpP1Y659M5ziis+G6fX9N203q8Eblyp1xjTYqzJo?=
 =?us-ascii?Q?yo9r/EnlpxYUqwIvKkG4mQfa9/sDWcLC5wNn3SyQ2fo3xd6c9lr1j4NGr7Sj?=
 =?us-ascii?Q?VjZIR/5HtNx69GP3Dx2umAnpFRyrnSYQjtdtoJ2Fqp8STKtIdNe1mhWWBH4Y?=
 =?us-ascii?Q?A3hoZ1AsMXTUJqZMGMXttbcVwr8Jar18l2LOVuusyAr8exKjSSe6aShVw1hk?=
 =?us-ascii?Q?+VWVSQpcKIekfSaYYAQUUgkBraNf1UVgE6TommVkbatlqtGaCN5wDbhJclQ6?=
 =?us-ascii?Q?eoxagTSUBY1KQ7BSiRrIyjVbWvkNZk9wNH8/QYGSVrJgtelKiPZvIa7iuMk9?=
 =?us-ascii?Q?/aPdTtb2WhhPDQeOVt1ywMs/HWPz73MLLrUgvQcC2XMZPI3u+Hk3xh5PZeyt?=
 =?us-ascii?Q?GaFdD28J3i4PjgVi0j3GafRywhb/VOOkiwl37OeTvAdcrxEU7InLEOuOeXDS?=
 =?us-ascii?Q?6WLrJVC72wbE2we7RY3B9epB/kfSaCpvaX+ki+VgYOFgPsI2eKhwisu+25/Z?=
 =?us-ascii?Q?OIX2wLAMCH0Iz4Z5s5eIFvGf2J/psWdCm4X+2paBYc/XMNbcoc/VTY0KtgW+?=
 =?us-ascii?Q?Pdvvir1UjK2ke1dhSRyUcwpbly8lAMwdzkwkmbWHjX5DrnKDp50MLEA22FkX?=
 =?us-ascii?Q?PgyO2o2Vgrcu75ljQn1gXB2/rbN80NYD6kGSKjRPwjGvrLq6gzsF6QozbdQU?=
 =?us-ascii?Q?HCw/l4g19iDOFiK0LqyJUJxaMSf2cAWoTml7EC8ANAq8abtfuH226I41jTTJ?=
 =?us-ascii?Q?uj5fz0cnCIb5Zoa5xPkT1+TPZ90fL6zAr4PAap6ZF4uSr15SDUB7GtTdgDQb?=
 =?us-ascii?Q?BiUfQBmrYzhKKjv3UDAT65sF3CxPcXwBzfx7luRCxuS7ytlsTHlDbVGA0VKp?=
 =?us-ascii?Q?0PLwdBWViKNOqXcAtRbc3oVw5TkTywyiR61/3yJyxmp/I6z0dPdJewjriDR+?=
 =?us-ascii?Q?ONL6lEvtD+PaNy/60LCK9Llz8FrYLZ/1i80xXT2Zp3lmCneeS7QJKEhfqa+Q?=
 =?us-ascii?Q?cFM1n6t5O01itp9zhZ16gpQM6Q+mJZLGmL8Bl49i8aeyq/zY0bW8V+HdTned?=
 =?us-ascii?Q?xZCxsgIKRBAPXP/kA+PhWjzLdHPBT2vxrmNXiGuyy8B/ST4UfVK4nVjkL1Qv?=
 =?us-ascii?Q?2yFeEqUyF921xJHrcSdzM/kDmnc3afehgl7fwxZIxAOGjTwxMzOKeUIA3UYX?=
 =?us-ascii?Q?hAYiFZX2lP9EeXZh94yYy04wjosLYQL9SlXbXnB/vagLZ7kt4lD7Wgj6W3VS?=
 =?us-ascii?Q?KrTPAodUKNtQwXMPYdNy9+KA3I9iEnv1s/ruvhSrsf/j/ydUjCWTaVXTUGO/?=
 =?us-ascii?Q?VM3guooOxEo5JCiH63XPLIZyLlgmBXljgvPnKUcY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58207283-984b-4fa9-9fbe-08db8dccdf47
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:46.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bafn5DWQqduLAkDW+dgmj+FyPkoN9Nk9BUnvzWqIDFV1WZ1Kge6c9OPyC9BbjhRHThnzClOAJKJyxJwFcVMr6A==
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
 drivers/usb/host/isp1362-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
index 606f0a64f3b7..a52c3d858f3e 100644
--- a/drivers/usb/host/isp1362-hcd.c
+++ b/drivers/usb/host/isp1362-hcd.c
@@ -2651,8 +2651,7 @@ static int isp1362_probe(struct platform_device *pdev)
 	if (IS_ERR(addr_reg))
 		return PTR_ERR(addr_reg);
 
-	data = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data_reg = devm_ioremap_resource(&pdev->dev, data);
+	data_reg = devm_platform_get_and_ioremap_resource(pdev, 0, &data);
 	if (IS_ERR(data_reg))
 		return PTR_ERR(data_reg);
 
-- 
2.39.0

