Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0B76353C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjGZLjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjGZLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6DD2D49;
        Wed, 26 Jul 2023 04:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeZQuQfQJIVv2qwSI2afxFvnBEzpygFT+lxCYQICDxSkc0TTQRjz2iI2kYqYYXoYVF3bTdVDOZmRQqwuicwtOFzSy7uc+CzFP1A9Nknh0Ch45QdfHXqoimEyBZp2S6Ud4UjNMwCOjRlx/QgbveHIixU2jybJw3l7wjR2c6A5MnhoHddFExg6LUPNXls+u3D8jQtYwvxILNrPhbOFss0AXQJ4W+OiyAtMfmErfVfgPmURnDJXporo7tiIS3fxqlHIVbsczj29OlAfvro3cazrH+NyV3UYPNVDCUeWJ2MSo1DplBy9DZudgt3gO+Y2JPNLrstcE5V7YEFPZB6KT38O/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pZFvAKjk57UWtiQII4yoYGYu4LJFOIBN62vt1d121E=;
 b=Vx4PGPnjxSzNLFO2bv+JEqJL+EhHVHq8zy+6DzcOx9z+6VAchfVyma3OXvYE2rmqsO4UfV0C1NJ44AHS0+IcARTobNlpzPs69vGT+rpEpjn6fyoiDXphDNjPjeNyqJ/7XRvTKCVaWJl1U2eNNxaCwN7d/f0P9oGzcWHngaAq/h2v+SM0eXCq1T2Yc767poqCsWRsGVdsp5mrFgKbG84IeuVANL9gUxVEl1/5jfJCkqpksk0CeuLW/SmPnSOT5Q8bPHyeehn3bcRSKqFSZDYJmggin3T+b6sf5XjLMIUWHQonOihXJ6xzqzcjh/+SQdqn2eQhjpSIaV8eqO7u5NVAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pZFvAKjk57UWtiQII4yoYGYu4LJFOIBN62vt1d121E=;
 b=pAejyB5LoG/bSuAhCsBUoQBhEPBZ7dalGJEG4CoLhnnBuDSE2IumoO9IA467lGWvBB1oFQLO7HuAQdz/CP5+3J5h2JGrNWAIx3ta9eNgNRUBg7SiXS0B93KsXEznYL4U5AH4k+mEqDP2TNurBZiXwPZkvDHvbBTpYrBbTlRhASE5/OqG8JcYIjo9W59u5L4LwF9vDbb/tlo8/EVx/JZuJSHwlSXtU9hQHwSyyNiAxC9lLeN04TN7V/+FdYo9LLSUmtynCUfyeWen/wahKhFFLlsbSbm20hn4HCrk1lUqtkpQtyAo9W9pcVHMfop6UV2WFy35qz2RrAm5G1X0AbW37A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/30] usb: gadget/snps_udc_plat: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:53 +0800
Message-Id: <20230726113816.888-7-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e273e8f-18a7-4218-7a97-08db8dccd986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9KkLTG6iw+RMmq+n6a/HHF1aZaufEBgGcwpjEnk/y/WeUv98CgcLSrWuJQDODu3k8MscUv74M06Bfrec1XQVyLiZKR55hDEuHebNQ51BMijCTLOxMN6eDjUs6Oq7tJ3/vYwPqeqWgDrj76KQMs8Q39+z5q9h6qWSrgE75JbkGZIXucWHCYDDxJbDSClN1+U6joc6Ll3L0O+iFsjU44425pP9lGP8JOx6sdx1dTQ8xatYEgEBEkYTRacgqCKqCMYxTZsx5/y+1KUK/9GGMGf4cPdsBWzbrwlTw2Gn1CxddrDfzp5NFThm69JCbf01i190BAPi24J8GttsxG+09669/6uI6ZWWJD9Pkfr6IdTTXBHiWGprnadNvbeUv/k7LB98Nozj4C0IxF80UNeekVGER/Tb0w5m/QPIHLSKn1wADWtJnj5obFs8gkiRxGdVO2E9XjDqET2qNwTErjpuvjiCoRLNS80CWEqOwd5hr/BNzdOyb1g9HOi2CTfsIu1VLl/Pd36fALqORTfklc8ydjOd3PZcQcQwyt0yS56gkrdwGa9XWdXJHgn7bTiWuxykAymgxuXtWgbrp13Nf8ftiUO2Zv7MEYwkum1t9YJhDjTl/x7GoKtMa7aoXCVFirR6Rpd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(8676002)(5660300002)(8936002)(41300700001)(316002)(4744005)(478600001)(52116002)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(6916009)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DU2E8J0BiyZaTobmEEyUi3plq7XE6yZj0bKtApIPm54byeNv5QQxsdXHvwS9?=
 =?us-ascii?Q?gQXAVLUVzqCnvbhchMWW9sjUhOt0mm4hv4oPqpq+GCuIDTcRtScdVFu+Jn92?=
 =?us-ascii?Q?SbWsBwXG+vP/5qItHfkCQS7/hesR5xKFBi4eUzLFgKf/PXN9l/KuE3K207nn?=
 =?us-ascii?Q?k5Pt01RWiNshbpGT78oX6sl4gN087cApVRWgWjZEHn+2rUI0uhQfxi5CYDXa?=
 =?us-ascii?Q?o5mMF8QL5JjMIvPbNCtngj4G7bCuo26CzlJHjoIf+tMUP3ykptQDIXgVEmAY?=
 =?us-ascii?Q?c2N9ycIAmSfEFuqnP+BgqeJlbRrpUTq+PmnjcfcY/eCuiMgm4TC09N/4uc4c?=
 =?us-ascii?Q?LyUOSKO7GBRFTFkmHa/PHgMoaRr7zN9dk00P6Hlv5QuSymk9J2D8DiZ50KNb?=
 =?us-ascii?Q?YJRxIbBRgLgrhzBFVMWCUyWukJOSsb8AQIjoVaO+8NurL53t8lgYIIwrL5ob?=
 =?us-ascii?Q?FFBk8OmJ1K19t35Hh/U86q3Ht7d9/FRKcdPihTB2hVthaRnbPjLiNjuNw4rw?=
 =?us-ascii?Q?dImgh4DXH7ZE6ov5xxv3uxNQ3I8XyUNwdQyc0zNf/R1dNgDnkJxm9svZLcK3?=
 =?us-ascii?Q?WmiW6glt2wQDhFQNqFhD1Og5e3+KHw7cnqF5kjgP44P50zL6FIHe0MzuEmPT?=
 =?us-ascii?Q?voT1tYcbfto2N/G+45LOFIM6g1tjm+AT3kuOSbRT28NPlsYvNugFiTterLO3?=
 =?us-ascii?Q?5mFbQhEiuc+MwlygSEPcGbzCZcVH2GIb5MGJ6oC1wj+hyhziQldFpsiVcksp?=
 =?us-ascii?Q?zixiDmptvwd42IJ0/uuA+jQ5IuLZo0pgdbalosRxDMQRJBQCFfguFLiHsgA2?=
 =?us-ascii?Q?V8E91lLZFaat3QIG+SMB7T3PutWhaFCj9P3OIzlP2Yjv3C6rd8YCYFA10eF8?=
 =?us-ascii?Q?0eyL4uuudUp7X24I6xEB5nyTRKd7MrWb0cQQoFw44QTy2788BvzMLVWF8BQY?=
 =?us-ascii?Q?BRZG3V9FID8DulNcXE3oX2/RGugI9ZCUx9hGoH64fcUWSnCamsTLNnAEUCVu?=
 =?us-ascii?Q?JhW5FC9sO36XmM+7PAPqT5zlo+Szij01tkq2Xmp62bB64CkYGLDvJOFbo0Gn?=
 =?us-ascii?Q?LmHC1NJXYtJcLk0MVEXt+7Kkm+Bx7u55u/ZPW9CruaYvz32Cn0sTP+afnebA?=
 =?us-ascii?Q?2djIb9BMzsr/m2J3YYo6eW8+PmHNBDFlZ/WUoHl/vkhquZH1Mq+hBT87POZh?=
 =?us-ascii?Q?CPN6phfyV+BqTLjmW2jlfBNC0ZQEwr1lw9aVKOSvcj30f63ln/JiFtEQQBFf?=
 =?us-ascii?Q?DDRhTo6xX+dG11TIVFE69IWkX5dtyVSDidNOXO8vVb0Vy5LZwKo+7OUr2DsZ?=
 =?us-ascii?Q?cMjiEDC/GI5f9j9OScLr0n4TT2KAVtGbnUA1yVnOx1v+xlrr1VIR0+ScA6pW?=
 =?us-ascii?Q?xX7FqKv2jPla4SWYbPFpoaLvbHNFOmyp/fiVGGkSQLIKs23YufFuF22q5w9h?=
 =?us-ascii?Q?L+vJA14myAonuAfrJN9Rb8/8CBXsKKbXCnR8Dt5BQ5x1QnwaUWNHMK1e8Ar9?=
 =?us-ascii?Q?wpzYAkUOzYOeuWBcfOptPnVudW3rdlHRP+jeoylXIFXW9ueKhdsgdr62nn7X?=
 =?us-ascii?Q?+GDBSFkJnJiLHuVHsyz3jI7eUEzaW3qAJPEExMHR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e273e8f-18a7-4218-7a97-08db8dccd986
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:36.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SE1+o/PiJn07JGl8T5gx3KEO+3nwao7kZNXp2vgm+VmuhkfWsTizzZoE+lhze6GMoFdrjA9AtkA0cRBDUWnzdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/gadget/udc/snps_udc_plat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
index 0ed685db149d..35c7a149b977 100644
--- a/drivers/usb/gadget/udc/snps_udc_plat.c
+++ b/drivers/usb/gadget/udc/snps_udc_plat.c
@@ -112,8 +112,7 @@ static int udc_plat_probe(struct platform_device *pdev)
 	spin_lock_init(&udc->lock);
 	udc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	udc->virt_addr = devm_ioremap_resource(dev, res);
+	udc->virt_addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(udc->virt_addr))
 		return PTR_ERR(udc->virt_addr);
 
-- 
2.39.0

