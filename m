Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD1763545
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjGZLjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjGZLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:39:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612C5269E;
        Wed, 26 Jul 2023 04:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKqlzdM8fkS59O/3jVq67MeX3KCYvcyOt1V19Fkezs7kNzEfOjhnDjPz0GzJoh7NUfa73HnDID4QF2iPzHhiCS0QtjleCs+TEjNJPw47tobMIc/yQ8UNI7DREAHBGYUTbrGm/KzmkmERJR4JwUF++bDVDb7z77yASLBx2YrpS/0CKbNZ+qWK8ccbAxXMVPL/2Heg00S+6E91oG/oSFWqHvErYnQ4x2dkd8tvwW0eTTgf0KzjrIbkuQzVjnWM9jbl8SQMt0SVUpO4Hz2tJGChcXkA5wIA30RKpcUsIZsuCAh/caV2P2Zo2UbEym45X27AzkPDZIzi/Pt1F5jdOz5BiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQJQpFOuA8L+KdEv9kCIqmTSLdk0FN+XfwNwUClUetk=;
 b=EX88LUhrprewW7PvprsvkEZkG4t3+l/Q7RYrnZ26X1vOH6+pALDgadMmyfentQP9v99TFJyI/tgyAvCplR4QwJVb+SxxKHKYGSbPim2RskZXPlKYj4v63PAP+02JJEpLWtTHmtp/hVl+gYPfoelKmLthjIm7oHlorEMt6lWr4BE4rnsgCV0CiqW+0XXuWnjyqtwvXxDpam+FLNbocu3VK7J90PH48BKfCo0tfu3yBLii4fIhypG76THVi0FZCvwWcu/hkn0aBY+CevC/qukDEQK9g6AQOfGDRiBCsPsejmuyvy0G2Rp8WNFOLLz+IzbD+km5kiS9nMoqilvGvEAabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQJQpFOuA8L+KdEv9kCIqmTSLdk0FN+XfwNwUClUetk=;
 b=lNTao1VJSHP/mEkJI7HyVAIWanqoereLaWA3IgYMGd7PyFwBvkoGLwUy+hQh5m6VURp0gfN+RtXDd6eVsVZrV8bPS5NN9cjoqsMLA21rgR5HB48kJ1snbapo8ivbc/ulXELyPaMDeqhLm46IMTitGcA7Xk5ol7bJPQpEM1mI0sGvxRga9nN727tbiHZ3b/2RPSL23f7Z7+3nEnbEgSgaPAeXWOR/GCdUtUh5rmWJuVlqvGXKFDuNAQOn+9tnOlSjaKkjNFDkvlNUJpDOb+4Gy3l2E6d8OfM/p3or5mwvLyliS7+xotIBvRJcterFASGU0ormgQPEImcIyfzvbq/6hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/30] usb: ehci-atmel: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:56 +0800
Message-Id: <20230726113816.888-10-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b89ba0a2-1f90-4bac-64d1-08db8dccdcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkLK3oeANAcXx4K/OhGTM51AgTfRGiivWRKjMFaBFwf/ff9g1/J3Up54TZaQyHPLKJ4T5R8DgK/oM5VNo3ypRAuWo27ZFQZv0WV1XwILtDy5UV+NVAU0JBRJSpU9NGkgP1oM8nDAVHqsiWLVkJlM2BbX5EBYX2qDstmt6+Sj0jw1wz/m7GovUdFoGzfIUYknOYIOaM4SysSJ5YPc3QIwLN9zeY5a5QCG3cwYdkifPpGeYUt6Q9mVJ6ovhO9BtCwT2aVYOu6wxzloEK76TerBJzitBtrCfQKa9tkSJ4dqig/4eUDIYaQrLru6s1JB/BQpOd+ELmXhBPRhbSEjHiuotJZgn/gYs4AQ3SdvYtXuWAMf8yK5sQ1vtd7wG4P/YaWBnCjBqKogp4/CP4XHMCYPDAf8VRMhP16avmy2jYw3JbxyK4pO70zkW91UBEZTyRRflNLAip2kH3G+cXkneV1jM3Q70Pf9ePtkvaTT3GHGQorgcXdOo3kMeGnCPjLM9R8r6Ft+PnB4PI5FqBC7Brrh9LD/D5mOxR9FiaGXOerOkJGmYorHhXDzTjQ+9ziYtrImUYS5h1+bCt4yG+m9XMTPfdQBageS9I/c7bFTLqW+NrLu0arkd5tMKuQIrx65yR+2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(8676002)(5660300002)(8936002)(41300700001)(316002)(4744005)(478600001)(52116002)(110136005)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0nLW6u2gzWFjyla5kxW+8w7xOufoFaRho0h2raA7ToecnzWFAOVWgg+PGO3?=
 =?us-ascii?Q?WAxyxIZUJphCme+7Ig3isGA2yt9SkOUJAlYxTeYq6lbMH5oUrUEmNYV23uLK?=
 =?us-ascii?Q?CbJClN8CTcSsKk+vrq9lS/+fosCbiFap9xTjh/O21X/9Am06uRofDSqA8jYd?=
 =?us-ascii?Q?cU4ePMfyK6umf4tZmBw3NbWf7VQ6d3WOjx9rh57eo5ai5hDu/rGZYwVVOdoG?=
 =?us-ascii?Q?KSULkWNET6moRPXDnGBPKvXcA5iJ72wNXWjAY2y7JJRnw1mrYdjcpkq4Lvf8?=
 =?us-ascii?Q?k5Yxo0xO5WNMfrgWZe4HRVA1RtErnDCJqbyFH+E0Ue5WO/hiPQfMWyK8fLzz?=
 =?us-ascii?Q?esyfgNRIfc21HlyeQGWA89Ji9Y+R7lnkyUHgYOKvG6elVtdOTldhMliMkU3m?=
 =?us-ascii?Q?mdHPsRgi3HaMNh5qJqPsvxBIIzw1MBUGeAuxTrnCryNQGjKKdU82tkRzczQg?=
 =?us-ascii?Q?+DEZfygi457D0Q2DZJyvNZSKO9fZjTucY7kkQJJb6HldF9vOCBB6nG79KTIo?=
 =?us-ascii?Q?VFdEYc2e3pqVjpu2bAngo9g4oIDjcULmqz2SdhOqvJN3q1Kcj1XrIikQ8zsW?=
 =?us-ascii?Q?Thwvalm+vV4XDEHXCTVOuf5Y1snNjpZqvoHAJCqqyVXL9BWAYDwHdCU+b5vm?=
 =?us-ascii?Q?0RKyV/X704Q8aNWxx4MikK6CvAJoXDtfrq4dHp+2M8X7g0Hyb4FD9xVqOYln?=
 =?us-ascii?Q?lv2MwHQjGMT/4VL2471+US3NJ9hbXl9msJST4naJSxhx7UCA45Fe/gdrgIV4?=
 =?us-ascii?Q?8vSGJS1P64IDjGDly4dpV1GTK8o3KMNNy85VHLogd9NxBausIUlHwwjzRgu0?=
 =?us-ascii?Q?3rtd8bYpoHvDEh8PoCdITPt+cFYjyRoWhLlEprgP6f9xIFeA/5LmobsvIEE2?=
 =?us-ascii?Q?gpPsomhONb6m0q0LeSpO8L4e9l2rPjF4B0sEw3pxb2B/QX9sg1ALaLNHDmVw?=
 =?us-ascii?Q?nzTE7QBdbjvnCk9HHne7C3YCLSzgXY47Zs56CyRxD2RPSyw/nulBhl3Qh4w1?=
 =?us-ascii?Q?Xu47RTWgSvxnfRyxPdJevfdD8Ryjl/A3gz2W79Ewbiksd+Jqlkf+hbXVdPmT?=
 =?us-ascii?Q?zZKvHi3aqcVGP6yFzBcdIztmQezLUoQXubmCKj+gaLjdafCOdR5vNyUaDsr4?=
 =?us-ascii?Q?WeCzAYnZ2T8tAEm3hFNgAeJ0W/VXADxc/zSpFw3Gv6IbpxVKzJKsa/PKLlCV?=
 =?us-ascii?Q?H25L7YPg2GD32A22KCilabvXq2SPy3G/0HdNI1bRfw+NJjsPc/sTkc2H7c1Y?=
 =?us-ascii?Q?6PoNkZ+AMh5hRLLt/6fmR3yTJcayFhsc6P/aTGXqz2AorTXha266Hew44J5J?=
 =?us-ascii?Q?j0C3qcZBO9voAIywqCKokDl9SL1VAO+57lvAHOGVdr+dGRiNPy7hSdZLnUj4?=
 =?us-ascii?Q?wszJVlibF2Xhw/bO7VWBDKnhYjauVu0sQM6aoNpeJGt8c/rkpOaz6I5Xze4U?=
 =?us-ascii?Q?PNPvlOZHvDEz8+OjPvT6iCvL84HBaWc0OcWSqFNT1JQCMpEfsmJO0TQPkAnK?=
 =?us-ascii?Q?xuwolYMir3xqU/Nux2Y7wpcyBL2Ulgj37XSrQ7lhuD6V86oITZWfw2B55+LK?=
 =?us-ascii?Q?8rmrd0hRQ9iUW91qgZGGIyfF3XqhJIejzmKx55Rp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89ba0a2-1f90-4bac-64d1-08db8dccdcc6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:42.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTjwGfIeulckL8BPDZQ5miClPYvacAYAFcUtDh33BpXEioipTOulRfYo4u9pGj90wNE2DVNc++LZwrc49D98gQ==
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
 drivers/usb/host/ehci-atmel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 61808c51e702..e14b66d848ee 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -122,8 +122,7 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 	}
 	atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		retval = PTR_ERR(hcd->regs);
 		goto fail_request_resource;
-- 
2.39.0

