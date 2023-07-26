Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4DA763543
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjGZLjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjGZLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:39:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4A0AA;
        Wed, 26 Jul 2023 04:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BR+Ghz765HFIeAGSQvfm73c1NLaJUE3P/aqhDpy4T4eVCq2C9nqRpOmhCLJfrEVDYuU3eLvXLDHyQeQpeukVGJLaa/bR1YRZxZFgqEs3Jjj0nEwshm9hHjkpw3/egkUQaWSDLUsT3EZrXR6e5yVlttOTTp3eqYRx1k1V0Lew4FQlIMNElmy/8bSxkWJmv1OIZi3pos4TB5eb02V3BIQStmpPO05QDubG6mIBUNqnNleBEtYV2eEDsYC4n51sgrDrg16rOe1nko3ZNL3R4OCviaG+f9WMTjz5zNRnGNt0ZcsWPHYH+/KdpnjCgcGQEbrhhYoL52/1+5Dcp4cfptx2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrdEbn+GJN1lr+qf46f60e6mU9uZS3/v+ivs5C8jFnk=;
 b=A3aKFY6vrwMzLMKh2Xq7glV5NleCgevqQt3JAXLZuKi2rwZDHLsIMelnhlB7CuFVEMurpdp51yEh/zhBUZZTJ4EkpzKHDk8rZxmlYGQVzpz4CIoB4/MP50O5i1vKYnbLRFlnbYNHCBETw9fQuYADVdu9dVYcs3cavguq8UagnIwjLh4HIz6u7IC4yhrvo1eFy4bUu3JxIXZWg8hZqMnPy9ydNyX8tRpmH5D7SKeFZ1Z0sTkiABEO38iCf9x4gb3mTViooApodWTtrvPBIg45npkcxm92ssa+fcrrJ6XdilirgeW8uVjRdmkU9N8Ehx/FcLJpbnaCgPnJ97mjiJAFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrdEbn+GJN1lr+qf46f60e6mU9uZS3/v+ivs5C8jFnk=;
 b=Z5F1eLUeLi5DBmjw8AF0OZ6AtxnxSNH7pxK/7fZIeTxptklP/VDSruCRscrf/rHGTupIDa8s1O9BQ4n3QZtxzyE3ZEmlvLpfBbJs/UcgQpTnLQkSDCJ5GD85m921cE0QV7qlRacTib2xzFeXNgFh3OQB31wV+88A/ub68d9J3hSnpe3ddehhwqyxylshvNyrt+e64RaSEolyYtan/dOVDPaH/bWMiaFwruXk4cp9X4wA2DejlNNRw8M9yMgahmikTlFntzuwK3tity+EU9p29eDB5OR3EdDVSWVn7njcJ1/hhXV/pKjoxv8gRTyiBephEQ4BHUqZyr3uFLWUTyhQfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-aspeed@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/30] usb: gadget: aspeed_udc: Convert to devm_platform_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:55 +0800
Message-Id: <20230726113816.888-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a3e9ce5f-a596-4fac-bd7d-08db8dccdbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gC1dN9gna+uZH0IuzmIBOrGeVteiVfI5IXVpTk2D+wxyyeI9oZ37sOpmP6aACWRPWG62TBcL1Pf0cXyY61TmDPwN/It2EkqWNsa0GKiTS6jyXQS/0uRhwyvElB6wFirfAfr0KJ73aPOD/ecdednLw0EFf2lhHIcO7clQAr0qh6O5zxzuiaZ3gc+H3s1QHhY4Lw+190ZVJr5SqTm1+mdXUV9I2Y8nWTAmcvMbWSxfhdyTvPTte1kin7Qp8XsMJJNlwVeJ3QSVwI6haCxKiDefhYu7DAj5Lu/OUogQT4dBzKVohKvDo3z259k9KyX/dHKeK9nmEca7S2B5oSgVjyZzywJoEDMa2Om+mnw9UxgNzAAx1m8gLfeaYANf8ARPBAhT3NfJtBCJfRcDPsqzoDmRSt8kvpfRWYVLVhAUKR1W0WzKPpDmBRYag4O9aojFS6dJpqI4FtGUx9stJRj2L0+GzCL+iBlX+oj6PIq7QO/6dYF2iBqNkxXOwfKj0QOa8NuU52WUcislKmpkD7HQZiEzbEil3kkzCm2oPQ9JJ5Z+572S/hvie+saMbbFnrstIrbt4Mm4Pfe4qqUPX8NZ/tF36LX8sOzyNnYUbfz2EiG+No+N6JLVjGV4Gn5pm+y2eF59
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(8676002)(5660300002)(8936002)(41300700001)(316002)(478600001)(52116002)(110136005)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MR93Dq2T9k07D/QKm0Xbilo5y+d9tZanNh9TGp8fTn+lbwH08vfuZla2Oy1A?=
 =?us-ascii?Q?ixr5EUOO9EabDR7gdJlCmEZ3h+IZGDtXsTC+ao105ZM9iUMbKCnPWi/Ii9wn?=
 =?us-ascii?Q?bVUJf8TYi130HtRNa1D0i8U24EibBOlS9f7E5zAubHzy9NuvIlN5wbpD1tCX?=
 =?us-ascii?Q?BF66UeSA5xTQ283Lqj/QMyN6I1Le5VUYfQc2Doof/oCsR4jiJSgEwW24cMj2?=
 =?us-ascii?Q?Jc5wJo4BBn+rBG8cu8e19sA3hrVMVlferozRxEFwEutMwB2fT73pu9CAJK7g?=
 =?us-ascii?Q?S/LVsximVL6+LHpU+enBtZjDaX+M17N9jnbAtEfM0uYDf8UMxSc/fwuahyfz?=
 =?us-ascii?Q?bunv3HnP5bqrAm+6QEv76AZk7/VBvdsvCpKOK9g1hCtLNOEQQyggNGsz7jLM?=
 =?us-ascii?Q?NxkDqT/nMZYe+wjPPjq+LrWjfESV/qSJgBdQX5PohgrH6x7n52KAfbsDdUDi?=
 =?us-ascii?Q?Qv7OCdFS5X2Zd/VqncQnTl2Yo51Kp/mtXgS64tnqLT4IEC14Gsvgj6xbMj9N?=
 =?us-ascii?Q?uN67ZUsUmFuEXUlovSAu4xR9A6Y4kvq8fYegTpLePTrNe7bOu+Qe41vpvSrI?=
 =?us-ascii?Q?gIYW4NfQoW8hMjvQzik4h6k6NV8uDuGLTe4tNf7hd0lu53Q9PfzhUiV1oFPv?=
 =?us-ascii?Q?cgjj6z6Y71LSqn22ZD5QY5BacQL520rrLv4dbIHm3v0r3JrXcJzIKZUG+fIY?=
 =?us-ascii?Q?U749xwpmkA5q+vgRziPi86nPNMLqkedn5Y+byrOTppTDV/5lcRm5zi/FP1aw?=
 =?us-ascii?Q?831xTAS+xtygp0x9hUVUppkMP4Fe5FbhU9YqJArXxRwMEVL/LQJkCvEwSw1t?=
 =?us-ascii?Q?34wy54UDPTDQNruZd17CJQ5PMqPUMWY7jAL3NvUmCEuotxtWgJlGZa2VYwvH?=
 =?us-ascii?Q?MRCVhscId+B1+DoiTOzRcE8S+HiqtDs1sTCyZWzVJ6+pmWWCknUyb6H6hGKj?=
 =?us-ascii?Q?nqBOe6I/aqbNsB4684e3XqMFyodUfxyBv4pMPSLUWvp3vooR94C8L3NEHv/G?=
 =?us-ascii?Q?YYOqZaN07l6qzU5ro7Oo2mFbKoFltRwwPCtbxxhNVPTfbqJ34emqGjKj36oB?=
 =?us-ascii?Q?5qNmP+ejn45zL+IQYRB3ObmJb9YL57SOzQPA+XdhgbHytOi/JdDIJBrL+IZ3?=
 =?us-ascii?Q?GGN+LSzJ+Wjwj7Q97hSwoufqFrKNd4t38ed95t74FulNLfbC2/1o0bNaS8RP?=
 =?us-ascii?Q?fhh34cwd4U4H+chtzgj4WzVrza4uIb6xeZ5Ha6AJ0sLz7VM0j+B3WBfnf8xO?=
 =?us-ascii?Q?hwXp8CCT/PsinRr+QK0SYxDOU4r9nJTUWqjaTVrcsiS2xb+JA1dZZpc38oFr?=
 =?us-ascii?Q?jdiIrPeF0vLGM9LvYoDeAjXmzgXNU5HGwaYX8giK9d4O2BQS0MGHmi4dVxGN?=
 =?us-ascii?Q?MSYDkDHFofC0KcfRGqRbVD2bioyVhXUXbfrBF8aX6pO475m6PvBfnV2/xvHT?=
 =?us-ascii?Q?usHDLTNjisjZAf/yOybcRZO09wUiD1siT4n/+DCISfz0h64hg4C4U39xhAJy?=
 =?us-ascii?Q?o0NhWlsss/YldSaUwX3Zcm2LV/JtwBdIOE/89A5EWxY4kTzvJ0i6VuBLjJis?=
 =?us-ascii?Q?2cE9vtwnx/se6ZPZrzM6coswpFcZHayZRfonPRu9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e9ce5f-a596-4fac-bd7d-08db8dccdbaa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:40.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Br1Tq0KWyqNcqnjDin8yKZmodh5nFLDzdk/PBupNJBkyn400meHjWbQLX+fexCrAGYZ6lop28G8DSjaj+8a3+w==
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

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 01968e2167f9..2ef89a442f50 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1468,7 +1468,6 @@ static int ast_udc_probe(struct platform_device *pdev)
 	enum usb_device_speed max_speed;
 	struct device *dev = &pdev->dev;
 	struct ast_udc_dev *udc;
-	struct resource *res;
 	int rc;
 
 	udc = devm_kzalloc(&pdev->dev, sizeof(struct ast_udc_dev), GFP_KERNEL);
@@ -1484,8 +1483,7 @@ static int ast_udc_probe(struct platform_device *pdev)
 	udc->gadget.name = "aspeed-udc";
 	udc->gadget.dev.init_name = "gadget";
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	udc->reg = devm_ioremap_resource(&pdev->dev, res);
+	udc->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(udc->reg)) {
 		dev_err(&pdev->dev, "Failed to map resources\n");
 		return PTR_ERR(udc->reg);
-- 
2.39.0

