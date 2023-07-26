Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32605763554
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjGZLkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjGZLkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:40:15 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B13E35AA;
        Wed, 26 Jul 2023 04:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb5zkHObZGkBTiJTvBbyRpSXkxdAc9uvqArU39wlqlexZstqFfDuC+g1DSNmfg1EguPB0g+5+7N2GqzV1JZ9PKfuG7KqQ4A26RmmzQ5CKR9qY5Pr2CF0R1ChjhLaTyhKRsbHpQ63TG2FQdN6JsOtpcO63ffLotqUbiMK5PsHCuuDUGmyXDqp1jceXITVrnqu1FRZP5iDc00MpdO5a/PxmItKYvGKUZCUXIkCP1EbHaCc6zFkTCL/5kYk6ZnTN+8vaXHnTjk++y5RmqnYk47Uj4Hq+GNuCcl8R8aHLoHTzgCZfJbT6Thxp425QiyjKblExVJnajXphnHR6Dh/K7c/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNYGem56MsmLlcj7RD4L5IAaIlnclQKbK0H9s5F9+sc=;
 b=JCVcrVbmvBazb4Y8Z1cuZDlc6qPQGOLEOhzFIMgGexRURdNfdMsH0A+bMH49wcqtBh6opfKRqA2DqE/ps2MlZxicTGCxffVIuwU+K5VnuslunpMUd/O6aFKO8TcfgzWP7XPnBUtQRglymWAWb0EtgIxL7Y8o3UYB7nxd6ANhkKLcThvxEvQ5YVAjkcjitl0HNQnPtD2A3HAwBx+oZyevLcJ5ZIuI4V2KwlqMwSQwPDJQUyu77tKaOrjYci2AUTl8i5vaXhI5HJn4OjZQLhybDgWb7NKw/3ngf1XhnwUk6cSuqXtAfd9DxDtcUM4bmZSarEjJ9KGWNkLEoJeS0FM4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNYGem56MsmLlcj7RD4L5IAaIlnclQKbK0H9s5F9+sc=;
 b=bfp/j6tvbP0ddBXP3pst25L1ulDAfG2KxwpLHXw/+IQE6R4nnfgy1GN9MIijsNNwRNkBTklAMbW3HT9CJoy8pw1uE2L/OGPiASQJ5kXzyqFHxSjyhxbQqGeApBXj0D78SHSm/9bKmxs0ZeVkQ48lPcD/fpWqzmrSrpFjCp30+VQqFoPzqKnu5AfTniH95a5t7hXR793TFa8Cwy+nbefEn7vUWipQ9Bb7frW7b+T0f6FCzYyuU2I9utWkEae9sULgRrC/wdItt5ihgsNTInUxYnMFI23EbsVpaIyJJpTBKK5XaKVVUsIRX6EkxhywcnFaLhxq7hS8r3ooGp7GmVZDxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6280.apcprd06.prod.outlook.com (2603:1096:101:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 11:39:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:39:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/30] usb: ohci-st: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:16 +0800
Message-Id: <20230726113816.888-30-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 98556862-a92e-4036-7b74-08db8dccef44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WrXzCFfp6p3n+p+RADHz7ncl95JsMwcWEQmm6A8fSiLDDebVt1pKFny6wcVntg5UPNZxh17XegaKqgKD4xw1bNPCZXvD62xLiRSGPoizUIG4oRyLwDeMmj5X0A88G5Ekg97QjqFLcWZofbjcGcvaO+KR8MZOOG5MprXxWPOQ4c8SEuNGLArKDzuNR9qEh8dL7OimGQ8tAZopnfPLZpOAV3aIMjx3q3jsyaGSccjLQhrFiIvPmSzMnI0CdJjO+5rGa/XQ/vDcsbONYHaBBz+/6cS0vjtNDCs7wUwMCKmL/U4Mj1uAepWcZzkA2gm2ym2LEmirbqaRmff1Y6t/nMqECSAxQz35HkqGWh4QjttHrjDkSMOVJJ6DnBByPdpN5gDqRtFpqaOyifokxfxU6YsKbaK4NMsgPB4K/ycM9YsF+I8caU+IEgYhhjZ+/xLG/m+N2M+w0igzbLyi0MY0pyVHv3XO21WNBm4nMqtprsBR2KMzxgC9aEcB/mFXNvAYXLdiYr6G4HPueERbEMM51YqB0Gm/iIzErbEYd4jemOKnG450RchtbAeJov8DOWqZ90+uOoaKzaqaTfnCLmQG0PTm/4UaUsfuzTSfB0loq4KFlU0xBSLZiq4mfN/9krtmfSF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(110136005)(52116002)(6486002)(36756003)(2906002)(478600001)(316002)(8676002)(8936002)(5660300002)(41300700001)(38350700002)(38100700002)(66946007)(66476007)(4326008)(66556008)(26005)(86362001)(1076003)(6506007)(83380400001)(2616005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ah32Gl0I2YipW33MKvgVLQGqrQN9CtgWy9Q/ZKP55wa31GEpYDxQTUghZ1XF?=
 =?us-ascii?Q?tmchUjqZg5EPfy8vUru2A2wGnhBH+cGqwargmx9vsLwdF51J+RGvKGwuDx9S?=
 =?us-ascii?Q?fJ/KT7YbSRGjj77wVlVH3S4NP6xnV6TykM4th+FVODlRDih0weany6cZSfdg?=
 =?us-ascii?Q?Bz5MWyUb7dTaAmY6R36fKt0EXb8D/bXnRt15qYexAJwn2Bym8yQ0EKwXVW+a?=
 =?us-ascii?Q?apJu21nNG7BgmSIO6F9LXTM7u4DGZZdQnbZOlPU9icNjMf7bta7eotn89K0i?=
 =?us-ascii?Q?GkS/rOEZ7GLoF5Gm62vGK9TAAQtUUcGEqk7Px3lUgVaq3cl3A8hH2PNwX3bb?=
 =?us-ascii?Q?6YMDmQjoJes9QEa6N5yZWsLCfkS19xU1MZVRZyPmW9MzV4VKnBQTgiFZY9o/?=
 =?us-ascii?Q?826IbV6Tg9YXiQUQ+YrhULX/BIUioSN5aT5sxCJguvJ2WyXVYmijU9sJ+I22?=
 =?us-ascii?Q?T5HsgdADNvoUD8FbPfwhvfEs26Uw9sushRiB+xgjAYK79eocDqfR9G21ps5v?=
 =?us-ascii?Q?FMCCfzuNbVfX3f4jTHu3/BiaWpB/DVpXWyEEVsQx+Qu+VPBcKGFj83abRXGB?=
 =?us-ascii?Q?ldD7zcE0ekuJmRejKTSgvwoX+2igFjohS6mK8xx8RnLR634ufpq5p+8qQ2iR?=
 =?us-ascii?Q?V62YkPzcqsHO9qm2GM7hnFFJ7bcYe5pQgS9Gxi+TZVwxhCVp1CvnFSewokSO?=
 =?us-ascii?Q?7MfltTOTsqZgrZQuX3ldQTj+zpN3D8QTeDQFLMIFpN0PINu4sL3BZUXIToHw?=
 =?us-ascii?Q?KLnM4v84T2wyEIYhwycpDTnyhbbmktNH+SObSwCQGChhMaxiRE04MqqV179Y?=
 =?us-ascii?Q?iUjHD9qsQkXdUi4xXHuECsnTNTX+PlVrU8APkYjaU5wcnc1KSNg0EDmMkckV?=
 =?us-ascii?Q?0gTq4LvyTr2+cuEGwKeohnkUPXr8bp3zCCfGALbZ69gCD+ZMKYHiBPQ9Vx99?=
 =?us-ascii?Q?ACXE0BpRV+6nD+uK47OSi+APGC6UPULigrw7mc9o3GFIay8BXlrFMuDf8H4N?=
 =?us-ascii?Q?yOspvNyCPcq99ups4Ew74h2wuVkU2ThiYm/km1B0+mDMn7oZ4p5FvnC1Krx8?=
 =?us-ascii?Q?aTARY4wx10b1d73MXCQw4I/2jMEEunckYTFpWtI0U3gC4DJ22YeW6bEHquHT?=
 =?us-ascii?Q?9EtlaMouUROdjgE5+Jzyq3oagxTykroPjgQYEJGceFBnlmValheCOtaqsoeJ?=
 =?us-ascii?Q?+tkJl43C8xuQ3x4/O3BQnzXg+pHBxxotYOL/2TqLt7NLB5FMNRZESUzwaSEs?=
 =?us-ascii?Q?YoGryFcvL0k9uAyvVjeTSAfH0uIHyu1dIuBYr+wXq3xTH6G0WkZzwlHWAJTY?=
 =?us-ascii?Q?IiOxswP9FKmc4ujNXaUcYP8m6+y2Gmia7lwUdeBbqx++nh+OwVSOsU2kcWNh?=
 =?us-ascii?Q?NHdTvWKWiG+RjJgW9V1MVchrLyJiQFPM9iy34aj0edhUVV6Tfy++8oE61EEI?=
 =?us-ascii?Q?QhQdX1FBaxrI++xGkeqrMi4MkCAbM3MQ5J3TmVykFkFxk2jw4WnPc4X2amIG?=
 =?us-ascii?Q?QQ38wyg0yW1VhJPfIye7iP6WaEPr/ex4SRRMcV8SnNAMYjNNAjzwuVAwYhQ4?=
 =?us-ascii?Q?7GX5GpDIhLjTcfOBI3rbrpK0Q0iZwD0TZjUGEuWV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98556862-a92e-4036-7b74-08db8dccef44
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:39:13.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/f9gLI8Ij6g0HVBsLxNYNSunlb59bZqFdz0Vb7+IuxGUXmJ2PHzHpcidNvkqg1NyVCaegU6lw2NiOuG1tGLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6280
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
 drivers/usb/host/ohci-st.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index 884e447a8098..214342013f7e 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -139,12 +139,6 @@ static int st_ohci_platform_probe(struct platform_device *dev)
 	if (irq < 0)
 		return irq;
 
-	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!res_mem) {
-		dev_err(&dev->dev, "no memory resource provided");
-		return -ENXIO;
-	}
-
 	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
 			dev_name(&dev->dev));
 	if (!hcd)
@@ -199,14 +193,14 @@ static int st_ohci_platform_probe(struct platform_device *dev)
 			goto err_power;
 	}
 
-	hcd->rsrc_start = res_mem->start;
-	hcd->rsrc_len = resource_size(res_mem);
-
-	hcd->regs = devm_ioremap_resource(&dev->dev, res_mem);
+	hcd->regs = devm_platform_get_and_ioremap_resource(dev, 0, &res_mem);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
 		goto err_power;
 	}
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = resource_size(res_mem);
+
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err)
 		goto err_power;
-- 
2.39.0

