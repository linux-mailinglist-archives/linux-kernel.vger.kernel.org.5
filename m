Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712CC763567
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjGZLln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjGZLl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:41:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F862719;
        Wed, 26 Jul 2023 04:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+LF6miDWIJQN2wPMBtEzY5JKfH/oK+fzo8tQWjGGUmtRiZChqrx+NlfDRKbMWjLaOEw9UjixtpXKH742R17pYj/SwV5DH3MHnrWTTQl9bYIvn910K9j96W67TV0g63Yv2uzsOkH4YgBNWKczUvDFvehrMzzcjpi4RTVSlQ5GLdUjJwmAfL/x59SCDEaRMWZkZXWuLG8gf98FIUbNnt+oC1RMczN56T9iBK90G7tEUGZGWr56ieA3qM1Uh1t2wlab/14rHXmsyknFoEGFWI60x8jZjk8Io23o5Wb8zCGa3ZsqXQASHnatNDLjKcg0xVgY31b5aVzW02zNyTcV7jSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRSWOokjgdG1mYkVtXRFm95UFecnalzqO//wLI2+y8M=;
 b=KghYAqXtoN0oOCWhJ/1t6x1y2hJ6MJpYA+8Fwwm9I/p5b/8cbYpMTXFxHMFuhlAN/KGqCYnODTE25qRCLAU343Gz6EEcj9vxqaiQR3spe8AglQBGg2H9rS+rM2JAy2Jz5gk7x0+d+hf5d+W76ijxZYbfGGBTH/prxQVPjj+V9Zj0ckJLfI/Bt76rQsaCfcm+32er8Ok2B/OnOK5EQPhKaWr70Qvv+kly1GaHzUMn1GcFf6sb1umXlC6fyjYkbyI8r8I24ydDVxDKs1zs8ZPtCkX6I20JyIda2wAy6kAKy9fOvtPAXRAdJAU6UvKZZWyZWNLdTMVVrUyj3tMg4rkFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRSWOokjgdG1mYkVtXRFm95UFecnalzqO//wLI2+y8M=;
 b=nHqANgEesWXS4HpNtHg1Sn4zea77jhWD0emQRUbbE5uAH14bbQkvaPpLp4g5zWul9lQJXIrho+LFgSNYaQPfweYYJcK0Sf3uuQbEG0JB+PhJuNJ8AzYEU37iI5LpXO+1HLv9zkL+QqhLhzb4U7yHWCkEG6/QE/Zo0H/+FUSLL8p385Wtko7SqCWMl7OX2qk2QY2TAdfh/nQS9snz9U716vuldtd2fw1YmToNbci6cXiV3bPDzqDGd44xdmgPfoqY4U7UAky5BVtUwqwthiZD22xQWjddYXKojuUmF+cQOTP14vXqkcJyR9mkP+CZ8Wst0OCFgaCo0Qb3L6CRoEU9Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:39:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:39:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/30] usb: ohci-spear: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:11 +0800
Message-Id: <20230726113816.888-25-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e24eb22-53e5-4d1a-a9a6-08db8dccea20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD8sXWq65AAlQ4fZntGz/jrMohfFlyeOdKO0keFRHXGg+BWYlADTdS52j+y67y8VY08VXx31c3sbEqvPrZPz2Ase1dEEQOHlsUlPc39yfW3CXVw1E17KkDcUXwi577qUeWsQMsgwzGyV520zeIDn3t9bjdrPqO0qeMBJEudcoDjDlpCr6mLeCGCmNN/pGw0wV0pX1MUywqANHdLG3JpezcjYyFrYIrWGQJPdxEGLEPlW/mzWPTK6/pZwQyuve8hewEGU3wMjNjkd88dWIT831Np0ikgdrtnfjrtQ6/UFawCVCcmubiooI8gp/1xiZmX9eJmGnC4DRyvpl0412l2wdig+uOPbgnv7VEOqrzSVFnmY57qSbhWJVJ8pdRsrO61NLkLzV2YUTl6hhroEYtaAkiP5MdBM/tSJRYaYtozBLVWkT2C6uNGIdFXShSUY4VtzKDbJFq6j9LILd5zqq1rHUSXpesM/wvwzscPiLwsNtd3Ois5Ovr1LpVxLKUfFa3L4usdpKh8KHAlf93BiCzpmU+J2qYefXO5hiQ+aL2CA8XW3cH5TGAby9mR+Sd64mu4nKrKgsm+Uv0SYxJoB9/KUUHxjyqeh3JX5io6sLI0zVnEks2ZcP/TdK5A15YQGsoP9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9vUY60dcZi9/P+sRx6KuMLjBJVUQsf1ZyG9u7V4SghbtCwmuiH9Igsc++S40?=
 =?us-ascii?Q?f+DUWccVrRxvTTIq4XeeXBQmOU0Ycyc+OL4XeWjvq5K/cvaZRWZuIoq1ClUE?=
 =?us-ascii?Q?pr3cjDi6T+2jS6N73L/XZLV0hjR/4aWuuVHOOu6V4lmD7jW9hwx7twE2Xn2n?=
 =?us-ascii?Q?ubMlIYKWOPwgs05r9C1sQxL8Stz8PCxLL5D3diSiqhoRGP3rw1KP+8poiagV?=
 =?us-ascii?Q?bcmxTebJUrjR3rzG045sFxN/L+65QMuS4UEWqGLQuma/IcC8/DdnOh8+z9Gs?=
 =?us-ascii?Q?9tl2RCnPIV8mmv5V7z8x3i/TP6Dqshun7FrXVcDOIwHy5jkOVS4Z7mA3gDrP?=
 =?us-ascii?Q?NiB5nXfbJmt0iHyXS8KvxWKr338vTPArvtIkRvHd6wc5SSEXUeIned3mGE1n?=
 =?us-ascii?Q?hLewHdL5KYM+KaHG9UlRctJt5kc5nE56m/0xPNvgE81ECzPAVeNWu+v+YNtV?=
 =?us-ascii?Q?Rkt9MbJZj5SskbgBtTZM4ABCISLC9wNihpHXwEnUi6ymkX6qaBtNf0V7+M+N?=
 =?us-ascii?Q?X6wS8Muk8dqoWvM2N4ycrOYrPVhem+wVQdr8lVChxx3eaxc44GYX9FyswP5I?=
 =?us-ascii?Q?DKxq4JYkNeCzR7HapLhUvYMRg5wBOI4g2b19KKwAEtb9pCSgF+RY3MbUxnHN?=
 =?us-ascii?Q?l8/HciRNdeajVhpwyRKGj1bqzrs91oNj7hJ/1Qzxz4d3qA+7Xinx+nBwqERd?=
 =?us-ascii?Q?yyVd6WYQLEYDFISPga+vFPHKBVoRFZApwhuJY4R2KqVb7YAAjM+zp5xTi3X2?=
 =?us-ascii?Q?gwwOK9H92ep09ZFX+xrn5uv2TCWzeS7BtHgFyXEoVUxIliSuOf9o1iCYVR9h?=
 =?us-ascii?Q?siDGBKDdMtzM9R0AxuSQudUbTVAh4kpncgIuMYN3PK4+PaqFDnXse+eaXE25?=
 =?us-ascii?Q?WIigqpNlvZgOXKCD0PZuuQo7zzykAeolWX3oKx74WOlyLF6A2JSG+71lJqi1?=
 =?us-ascii?Q?+jXAV4QspQbw8TSOZfk/G7x8w4+cKcDRRJklOy8UrFTBYm49Q2M80i32qwRn?=
 =?us-ascii?Q?HhttgxuhcJLgORsY2VoiB4cJbIzuWwAJPDEmNDBaOGlSulOZQEMpsgPkBY87?=
 =?us-ascii?Q?AwN4+589kgo3mst7o/QKCyRY3YzUovPcARrd4PyTI2mnNOfuAlgbG1D6dZwp?=
 =?us-ascii?Q?PNZo5I1xXRi5cJvdukclwiZ0df7l+YOtLy96RLAW6I1vjUsnmRi2mpI8o1bS?=
 =?us-ascii?Q?MKly5vw+M3FLKdJgpA20/T4uyzJtTqcCRCAo9W55IDpQ0xQgw3zEk4nr3CON?=
 =?us-ascii?Q?hrgM0dqLDft4Z0VN6Q+vYwojRwxjktJ+d3QtvntWxy2ZaxgCIW09UtxSKnk+?=
 =?us-ascii?Q?PgVX9Lbai57KEFRVwAWl+DGnusSNc2gBqMTS63KAmReAZkCayaI8sZZJMERD?=
 =?us-ascii?Q?WNy02jQr4vXaGzU9OsxM46XnjGNXXkMtRKdI8akpz2jI5IfOa3d2KF4/6DvS?=
 =?us-ascii?Q?L6cHpztOBkb4v5w3H3/eXdyicuL8AnwsWV/H1aBqouixGyt8WDmxdF++9OyF?=
 =?us-ascii?Q?KhnloB0NX0/ZsAf47yGWKC0qZClWwhm5TiYacE585Cp2RHtMco74FqukeHf0?=
 =?us-ascii?Q?dFoC19OLduF46q3cQQRFatKSqO0MbkiQQbdeBDhK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e24eb22-53e5-4d1a-a9a6-08db8dccea20
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:39:04.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKX9OeNnGAfScBjOcPdiGd/8/mwsuA4VUqpcwg6VpikLTEMJMdO2TJ1ruougu4QJbjrVeqW+7xux3yH1YenSHg==
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
 drivers/usb/host/ohci-spear.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index f4b2656407dd..993f347c5c28 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -68,8 +68,7 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
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

