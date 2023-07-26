Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC3C763540
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjGZLjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjGZLi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E130170D;
        Wed, 26 Jul 2023 04:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9Df0rHf+6cNgvn2vuvhFuABv71Ffwqwwt1BZsqFS+0zw3cJiQDQhsj2ia9gNOmhoDbaoxdwVgkB5I14t0Qltw+EIE2wBA+cGrg7xnWfsFbEVthwUHN7RAphHrSoZqGjd9R+TGKDyZtVL7ZjfKmL2GJip72sWLzwmBto1PtLinz+8gpbs1nxPVW7ZtAFzIjueH7NYrVysbEpSqiNYn2zXaqjyEoJ42WH+Uz1J6uRJy1SmGuQk9G3jHa3790T7/Y4u5rr2KOPak2GSWGSRZlpyC3e8oCRO1csYZVkQK59eA1pdZ8+fn7kvOrNEJQ7WIB04p/q71J/CUd1Kj/oXGIt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVa7zYxpE38QeURQRntCjBcZuekxkPucqcYfA3rgk5s=;
 b=k+qmei/4QT+m1VHWc3o4ap0rRo010fOYXLv2S4NisdTP5aB94rnNlDcqJgmzxUgL2Q1IAdWRsS8FiofcYg+MpWBntKQhgTsBtEN6yrHQMxBIWST7B/dnJjB9zCBfQNm+lOmMXQdQgVr2va7lUzP1hiuhlP14C2I5RAOhIs4mOtIMnWgLTbqbVDHfe/EMbzRTxXNC8yAUjphv/CWRfMknE9m68Fag1/vHISFZzkQqUvPiyEXWrvEzj2XBN6QCMK09pNbPucFRqHpnjW8eKswXSYE8FSh6/okjSDBDASfeWPruOP8Kg25TNJxVZ6qaE9w2eC/GhifklPMe0D9l0qGwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVa7zYxpE38QeURQRntCjBcZuekxkPucqcYfA3rgk5s=;
 b=O1afH+1+X1Jgnv6MBjrncTi/O2ccjYkNqbrDQ/rQ/dhwrcLNKiLJuL6KCTPaeDcM553eUab+3ooJZBceELEbPUg2YwPRwEotdu47c6UkrVnZQQNgt5S7damcBRDJJ+wk+efXNMK3H8LIQexOhnSWTcTMWLXoSRW8U/yAkEI5Iw2GoIgw5pAf1ZHFznkvRBK+VxFw/c+GhYWPJhwV6OFIiisAJTaUcnI/eG69Ss33S3KZud6kJP94UjOICtn0UEuMQYxKLV6hW6pMmZiU6xPygd6ES6UeyCseUtzzbJRDdBTMMsgQ9ZPtpMX0cy+qY/E013nfTjOMisMyfsfC9mJCZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/30] usb: ehci-spear: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:58 +0800
Message-Id: <20230726113816.888-12-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c1dd259-b378-4488-26bb-08db8dccde84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUBQg7KG4hlPMjRP8wk6R7C083A761bXAVLipCP9Lh4EkU2EbdrUCS2PdDC8C5MnrSsiFmyAjU8uSAjYYXYlpHEbWsPsp0XXnqZduqlA8+EUZ2ji2NZN6ORbxNLkERsajC6x0hQY1TEjnXfRfKrmz/X3c+3hdaZG1ccpVCXYDWzLRgyd4kTHzPBwDie5N1ne1VWfO83bRgV2k7dFnq1yAKnUWm6GzrPVYrMwt3do5xl3/VDcIXkVRk/MXxwyekKYlOF00Pi6T8GX8ilMK2WCbLGkyWHCetIKFT/QatLGRYD+8q6PGnHVuaEQsHeaqGiJKb0Wo4LQSxArYeH7FSuHuWY5hrtEwoxX/Stdgyg14aUeEUVMx1HUV4ej7B5PPguswmTBdotgP9DMoixgZLmvifk20uSk4/AHFoZ1Tz1WtfCqulAaE5EXzhCWYFbJ0qf/4NAi2nmtGSeY/XSYRCnJGkiDdU7A4D2Ji71CIunWMF3GPZVVEJe8oxrrxryOGW8j+t0u317MQ6CtbBSRztk5D2JfkfDCvxXXeyh9jxGJ8DT9NeCqVDY2C2yPLV5/5ygmpKR2s7RvEaJu2n3mJslbcSmpPnv3PZMEQiAxKNxxtX059o9Gfb9Hrcl8SvknzS6Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whTpLL1Ws2p8B8DHlEjbqfWrp5uIybYerjPlVfDkn7IlbX4ccu1qqJss6XRp?=
 =?us-ascii?Q?GqEOLWw6QfwIatE5+7Ipjrfn9xOQiN2bnF1IX2vffcn07xqemI00vWsy8rjs?=
 =?us-ascii?Q?8uhHPapfmVKldaoEkSGVZAHvbsCfRSVz5MkfafM8k3RLpRkQQo4GmQDYj2O+?=
 =?us-ascii?Q?JOL/0nyNpV11B5eh4ATk/WCgyyNGe6e+nn2w93vQGHyGwEsD6LCfK6kAu+LM?=
 =?us-ascii?Q?XtD6ELINrOapCh8GkssGkx0nc28cZaUr4QPH8D0D5zsfuqfJHJrxhGefD2zi?=
 =?us-ascii?Q?MFpvMyCuc3MPhlB6G73qmiUzANsFzjdC+XH9Gw84fgZT2api2LQpVvt2D+ei?=
 =?us-ascii?Q?yH4Zpc6JIe38uhMT6o0BjhQ2Quy/GJgfT5jFuFr/0gaDYWSKvFGXaiLNcmo0?=
 =?us-ascii?Q?XfBjxU+584OrUl48mshgYwKngSnn1s2/+9RLPcycOdBaReIvk3xREasFqb/L?=
 =?us-ascii?Q?AOV/YvDdyQNhtEo3Xhuw/DY9jxPJWTtKyxDk35aBfn6XjdPJNtZhHXJCg1nj?=
 =?us-ascii?Q?xikakEuJLuqwD46ebBSZKRI1kdvTupuW84/C1rUI8TAF6UbqbtEAeNiHOMOg?=
 =?us-ascii?Q?OctqVK6vGCo9pztzqk3Q8djW07KacAnO1jySv5b2IvblfHJWc2i5q1zOs8+7?=
 =?us-ascii?Q?oi7nuicGuBWqP8tuA5hEELdeZ/9bJAOvy0g7BU2kbQ0Ioy+6udhumt6tqP0r?=
 =?us-ascii?Q?C45moxNbv2buq9KAoFSlGfZ2HTEUjcktoOm1jm+/ZZG+xLASFzRLLtDjNdX0?=
 =?us-ascii?Q?n9k/k55w7tIo6Iy6o5AqhUHaJNSdu6FKMDmViqx8hdS20bwXJ/hoKLOR2VSQ?=
 =?us-ascii?Q?TzeYLMPuldVBuRVYKUfRV3c3ZQfbIrAxf/bmFDAY4Dd8dT1hy4MpFwFoxtOm?=
 =?us-ascii?Q?LTIED6CIcgz66WWC0vHOiw+b1mqzDtgpKqKT74XU4SKBKJ1ie/bUTB5sAyTY?=
 =?us-ascii?Q?HzCEiprob9wLrLsdNjlj75/FsbDKanvVZKYqubboRZtOyX6EXH99v2l2dhXa?=
 =?us-ascii?Q?c0m9LuylJ/znBEu3zwpm07DLU9l/Ep7XZJ56Ly6+6yl5YhRRhiyrzRYXpuQJ?=
 =?us-ascii?Q?CDZJ83/URlic77wE/s1G6twxjZBMDmwOCYkw5cpX/ww20F+oSeT91SPucacZ?=
 =?us-ascii?Q?lPzMOUawJ5rgHKDt8ODoHVr4p+5z9hp2fTwKbrNR/m247EFaNCXDfXPkroPA?=
 =?us-ascii?Q?mefRF4nUKCQVbz/VxtMh8D+K3mhDP+K5Ai3ebTaG83cEDYUxJsGxBpltA/f2?=
 =?us-ascii?Q?O5r1dVLTORy4o+Dp+2zau5Ds8ersylZ8CxBhyfyMZKtsLp6I73+H/wZfWcEY?=
 =?us-ascii?Q?P16kinMkz5+RgMli05YdBV4ZZr73aCIvRV2e9RVEth2ARXYCODteg2VPhwh9?=
 =?us-ascii?Q?bcBYJ9jVIBRzo06JT3/WTxizKr/0f0EDPT13C5e/pz2h0wMjss0Lq751apGw?=
 =?us-ascii?Q?cSDWbrWXiPR2tl2dNtbKAt2wz5mc5UX/iiwN/IDWG24cnOeWJkD7sTffmLk1?=
 =?us-ascii?Q?kfyuWqkkjTv6Aom8j+NDRHEYV7VnuUmDMK7GCpmPIFmHc7PRBnbvdrDaOoCH?=
 =?us-ascii?Q?VaZ4KPhXk0OARbbxDYldr7I705ZTlwGZFv6qL2Gw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1dd259-b378-4488-26bb-08db8dccde84
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:45.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCik9HhbKx1nq+DZR37omuTPiarvoaTFLlNIt75DpvMAj3N9JBerTCWpV6J+mGkM+gsL7r7CdZso9Uo05XFkNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
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
 drivers/usb/host/ehci-spear.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index 1407703649be..d0e94e4c9fe2 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -91,8 +91,7 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		retval = PTR_ERR(hcd->regs);
 		goto err_put_hcd;
-- 
2.39.0

